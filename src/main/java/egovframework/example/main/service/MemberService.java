package egovframework.example.main.service;

import java.util.List;

public interface MemberService {

	/*
	 * 회원 등록처리(save)
	 */
	public String insertMember(MemberVO vo) throws Exception;
	/*
	 * 중복아이디체크
	 */
	public int selectMemberIdCheck(String userid) throws Exception;
	/*
	 * 우편주소 검색
	 */
	public List<?> selectPostList(String dong) throws Exception;
	/*
	 * 로그인 데이터 확인
	 */
	public int selectMemberCount(MemberVO vo) throws Exception; 
	/*
	 * 상세보기 ( select ~~~ from member where userid='test1' ) 
	 */
	public MemberVO selectMemberDetail(String userid) throws Exception;
	
	/*
	 * 수정처리(변경저장) ( update member set ~~~ where userid='test1' )
	 */
	public int updateMemberDetail(MemberVO vo) throws Exception;
}
