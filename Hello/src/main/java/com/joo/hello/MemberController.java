package com.joo.hello;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.joo.hello.member.dao.MemberDao;
import com.joo.hello.member.dto.MemberDto;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDao dao;
	
	//회원 추가 요청처리
	@RequestMapping("/member/insert")
	public String insert(MemberDto dto) {
		//MemberDao 객체를 이용해서 DB에 저장
//		dao.insert(dto);
		//view page로 forward 이동해서 응답
		return "member/insert";
	}
	
	//회원추가 폼 요청 처리
	@RequestMapping("/member/insertform")
	public String insertForm() {
		return "member/insertform";
	}
	
	@RequestMapping("/member/list")
	public String list(HttpServletRequest request) {
		//회원 목록을 얻어와서
		List<MemberDto> list = dao.getList();
		//request scope에 담고
		request.setAttribute("list", list);
		// /WEB-INF/views/member/list.jsp 페이지로 forward 이동해서 응답
		return "member/list";
	}
}
