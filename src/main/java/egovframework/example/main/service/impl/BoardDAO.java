package egovframework.example.main.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.main.service.BoardVO;

import egovframework.example.main.service.MemberVO;
import egovframework.example.main.service.NoticeVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


@Repository("boardDAO")
public class BoardDAO extends EgovAbstractDAO{

	public String insertBoard(BoardVO vo) {
		return (String) insert("boardDAO.insertBoard", vo);
	}

	public List<?> selectBoardList(BoardVO vo) {
		return list("boardDAO.selectBoardList",vo);
	}

	public int selectBoardTotal(BoardVO vo) {
		return (int) select("boardDAO.selectBoardTotal", vo);
	}

	public BoardVO selectBoardDetail(int unq) {
		return (BoardVO) select("boardDAO.selectBoardDetail", unq);
	}

	public int updateBoardHits(int unq) {
		return update("boardDAO.updateBoardHits", unq);
	}
 
	public int updateBoard(BoardVO vo) {
		return update("boardDAO.updateBoard", vo);
	}

	public int selectBoardPass(BoardVO vo) {
		return (int) select("boardDAO.selecBoardPass", vo);
	}

	public int deleteBoard(BoardVO vo) {
		return delete("boardDAO.deleteBoard", vo);
	}

	public List<?> selectNoticeList(NoticeVO nvo) {
		return list("boardDAO.selectNotiveList", nvo);
	}

	
	

	



	


}
