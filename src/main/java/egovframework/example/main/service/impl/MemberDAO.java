package egovframework.example.main.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.example.main.service.MemberVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("memberDAO")
public class MemberDAO extends EgovAbstractDAO{

	public String insertMember(MemberVO vo) {	
		return (String) insert("memberDAO.insertMember",vo);
	}

	public int selectMembberIdCheck(String userid) {
		return (int) select("memberDAO.selectMemberIdCheck", userid);
	}

	public List<?> selectPostList(String dong) {
		return list("memberDAO.selectPostList", dong);
	}

	public int selectMemberCount(MemberVO vo) {
		return (int) select("memberDAO.selectMemberCount", vo);
	}


	public MemberVO selectMemberDetail(String userid) {
		return (MemberVO) select("memberDAO.selectMemberDetail",userid);
	}

	public int updateMemberDetail(MemberVO vo) {
		return update("memberDAO.updateMemberDetail",vo);
	}
	

}
