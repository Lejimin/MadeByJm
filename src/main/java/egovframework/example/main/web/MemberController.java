package egovframework.example.main.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.example.main.service.MemberService;
import egovframework.example.main.service.MemberVO;

@Controller
public class MemberController {

	@Resource(name="memberService")
	public MemberService memberService;
	
	/*
	 * 회원등록 화면
	 */
	@RequestMapping("/memberWrite.do")
	public String memberWrite() {
		
		return "member/memberWrite";
	}
	
	/*
	 * 회원 저장
	 */
	@RequestMapping("/memberWriteSave.do")
	@ResponseBody
	public String insertMember(MemberVO vo) throws Exception{
		
		String message = "";
		
		String result = memberService.insertMember(vo);
		//String result = null(성공)
		if(result == null) {
			message ="ok";
		}
		return message;
	}
	
	/*
	 * 아이디 중복체크
	 */
	@RequestMapping("/idcheck.do")
	@ResponseBody  //비동기전송방식 일때 필요함
	public String selectMemberIdCheck(String userid) throws Exception{
		
		String message = "";
		
		int count = memberService.selectMemberIdCheck(userid);
		if(count == 0) {
			message = "ok";
		}
		
		return message;
	}
	
	/*
	 * 우편번호
	 */
	@RequestMapping("/post1.do")
	public String post1() {
		return "member/post1";
	}
	
	
	@RequestMapping("/post2.do")
	public String post2(String dong, ModelMap model) throws Exception{
		
		List<?> list = memberService.selectPostList(dong);
		model.addAttribute("resultList", list);
		
		return "member/post2";
	}
	
	
	/*
	 * 로그인 화면
	 */
	@RequestMapping("/loginWrite.do")
	public String loginWrite() {
		return "member/loginWrite";
	}
	
	/*
	 * 로그인 실행
	 */
	@RequestMapping("/loginWriteSub.do")
	@ResponseBody
	public String loginProcessing(MemberVO vo, HttpSession session) throws Exception{
		
		String message = "";
		int count = memberService.selectMemberCount(vo);
		if(count == 1) {
			//session 생성
			session.setAttribute("SessionUserID", vo.getUserid());
			//message 처리 
			message = "ok";
		}
		return message;
	}
	
	
	/*
	 * 로그아웃
	 */
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.removeAttribute("SessionUserID");
		return "member/loginWrite";
	}
	
	/*
	 * 회원정보 보기
	 */
	@RequestMapping("/memberModifyWrite.do")
	public String selectMemberModify( HttpSession session, ModelMap model ) throws Exception {
		
		String userid = (String) session.getAttribute("SessionUserID");
		MemberVO vo = memberService.selectMemberDetail(userid);
		model.addAttribute("memberVO", vo);
		
		return "member/memberModifyWrite";
		
	}
	/*
	 * 회원변경(수정)처리 (저장)
	 */
	@RequestMapping("/memberModifySave.do")
	@ResponseBody
	public String updateMemberDetail(MemberVO vo, HttpSession session) throws Exception {
		
		String message = "";
		String userid = (String) session.getAttribute("SessionUserID");
		vo.setUserid(userid);
		
		String birth = vo.getBirth();
		if(birth != null) {
			if( birth.length() == 10  && birth.indexOf("/") > -1  ) {
				String[] b_array = birth.split("/");
				String date = b_array[2]+"-"+b_array[0]+"-"+b_array[1];
				vo.setBirth(date);
			}
		}
		
		int result = memberService.updateMemberDetail(vo);
		
		// String result = null; (성공)
		if( result == 1 ) {
			message = "ok";
		}
			
		return message;
	}

	
}
