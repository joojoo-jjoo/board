package com.joo.hello.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.joo.hello.member.dto.MemberDto;

//component scan시 bean이 되기 위해
@Repository
public class MemberDaoImple implements MemberDao {

	//Mybatis를 사용하기 위한 핵심 의존 객체 주입받기(자동으로 주입받겠다)
	@Autowired
	private SqlSession session;
	
	@Override
	public void insert(MemberDto dto) {
		// TODO Auto-generated method stub
		session.insert("member.insert", dto);
	}

	@Override
	public void update(MemberDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(MemberDto dto) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public MemberDto getData(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MemberDto> getList() {
		// TODO Auto-generated method stub
		//회원목록을 얻어와서
		List<MemberDto> list = session.selectList("member.getList");
		return list;
	}
	


}
