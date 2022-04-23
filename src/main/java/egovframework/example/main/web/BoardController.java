package egovframework.example.main.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.main.service.BoardService;
import egovframework.example.main.service.BoardVO;
import egovframework.example.main.service.NoticeVO;



@Controller("boardcontroller")
public class BoardController {
	
	@Resource(name="boardService")
	private BoardService boardService;
	
	@RequestMapping("/boardWrite.do")
	public String boardWrite() {
		return "board/boardWrite";
	}

	
	@RequestMapping("/boardWriteSave.do")
	@ResponseBody                            //비동기 방식으로 데이터 전달할때 이 어노테이션이 필요함
	public String insertBoard(BoardVO vo) throws Exception{
		//result == null; 정상실행시 
		String result = boardService.insertBoard(vo);
		String msg = "";
		if(result==null) msg="ok";
		else msg ="fail";
		return msg;
	}
	
	
	
	@RequestMapping("/boardList.do")
	public String selectBoardList(BoardVO vo, NoticeVO nvo, ModelMap model) throws Exception{
		int unit = 10;
		//total 개수
		int total = boardService.selectBoardTotal(vo);
		//total 페이지    (double)12/10 -> 1.2->  반올림 ceil(1.2) -> Integer(2.0) -> 2
		int totalPage = (int) Math.ceil((double)total/unit);
		
		int viewPage = vo.getViewPage();
		
		/*
		 * if(viewPage > totalPage || viewPage < 1) { viewPage = 1; }
		 */
		// 1-> 0,10 // 2->11,20  //3->21,30
		//startIndex : (1-1)*10 +1 -> 0
		//startIndex : (2-1)*10 +1 -> 10
		int startIndex = (viewPage-1)*unit;
		int endIndex = startIndex + unit;
		
		//int p1 = total;
		//int p2 = total -10;
		//int p3 = total -20;
		
		int startRowNo = total -(viewPage-1)*unit;
		
		//sql까지 가기위해 vo에 값을 담아줌
		vo.setStartIndex(startIndex);
		vo.setEndIndex(endIndex);
		
		
		
		List<?> list = boardService.selectBoardList(vo);
		System.out.println("list: "+list);
		
		//공지사항 리스트
		List<?> noticeList = boardService.selectNoticeList(nvo);
		
		
		model.addAttribute("startRowNo", startRowNo);
		model.addAttribute("total", total);
		model.addAttribute("totalPage", totalPage);
		//list받기
		model.addAttribute("resultList", list);
		model.addAttribute("noticeList", noticeList);
		return "board/boardList";
	}
	
	
	@RequestMapping("/boardDetail.do")
	public String selectBoardDetail(BoardVO vo, ModelMap model) throws Exception{
		
		/*
		 * 조회수 증가
		 */
		boardService.updateBoardHits(vo.getUnq());
		/*
		 * 상세보기
		 */
		BoardVO boardVO = boardService.selectBoardDetail(vo.getUnq());
		model.addAttribute("boardVO", boardVO);
		
		return "board/boardDetail";
	}
	
	
	@RequestMapping("/boardModifyWrite.do")
	public String selectBoardModifyWrite(BoardVO vo, ModelMap model) throws Exception{
		BoardVO boardVO = boardService.selectBoardDetail(vo.getUnq());
		model.addAttribute("boardVO", boardVO);
		
		return "board/boardModifyWrite";
	}
	
	
	@RequestMapping("/boardModifySave.do")
	@ResponseBody
	public String updateBoard(BoardVO vo) throws Exception{
		
		int result = 0;
		
		int count = boardService.selectBoardPass(vo); // int count = 1;
		if(count == 1) {
			result = boardService.updateBoard(vo);  //int result = 1;
		}else {
			result = -1;
		}
		return result+"";
	}
	
	@RequestMapping("/passWrite.do")
	public String passWrite(int unq, ModelMap model) {
		model.addAttribute("unq", unq);
		return "board/passWrite";
	}
	
	
	@RequestMapping("/boardDelete.do")
	@ResponseBody
	public String deleteBoard(BoardVO vo) throws Exception{
		int result = 0;
		
		/*
		 * 암호일치 검사
		 */
		int count = boardService.selectBoardPass(vo);   //count =1; (암호입력 잘함)  //count=0;일치하지않음
		
		if(count == 1) {
			result = boardService.deleteBoard(vo);  //result =1; 삭제성공시  // result =0; 삭제 실패시			
		}else if(count == 0){
			result = -1;
		}
		return result+"";
	}
	
}
