package egovframework.example.main.service;

import java.util.List;

public interface BoardService {

	/*
	 * 일반 게시판 저장처리
	 */
	
	public String insertBoard(BoardVO vo) throws Exception;
	/*
	 * 일반게시판 화면목록
	 */
	public List<?> selectBoardList(BoardVO vo) throws Exception;

	/*
	 * Total 개수 얻기
	 */
	public int selectBoardTotal(BoardVO vo) throws Exception;
	/*
	 * 상세보기
	 */
	public BoardVO selectBoardDetail(int unq) throws Exception;
	/* 
	 * 조회수 증가
	 */
	public int updateBoardHits(int unq) throws Exception;
	/*
	 * 수정 처리
	 */
	public int updateBoard(BoardVO vo) throws Exception;
	/*
	 * 암호확인
	 */
	public int selectBoardPass(BoardVO vo) throws Exception;
	/*
	 * 삭제처리
	 */
	public int deleteBoard(BoardVO vo) throws Exception;
	/*
	 * 공지사항 리스트
	 */
	public List<?> selectNoticeList(NoticeVO nvo) throws Exception;
	
	public void insertHashTag(BoardVO vo) throws Exception;
	

	
	
}
