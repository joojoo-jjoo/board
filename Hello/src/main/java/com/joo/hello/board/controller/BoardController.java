package com.joo.hello.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.joo.hello.board.service.BoardService;
import com.joo.hello.board.vo.BoardVO;
import com.joo.hello.board.vo.ReplyVO;


@Controller
public class BoardController {
	
	@Inject
	BoardService boardService;
	//게시글 목록 화면
	@RequestMapping("/boardlist")	//url값 .do는 생략!!(why? web.xml에 servlet-mapping으로 해줘서)
	public String boardList(HttpServletRequest request) {
		List<BoardVO> list = boardService.getList();
		request.setAttribute("list", list);
		return "/board_list";		//jsp파일명
	}
	//게시글 작성화면 진입
	@RequestMapping("/boardwrite")
	public String boardWrite() {
		return "/board_write";
	}
	
	//게시글 작성
	@RequestMapping("/regBoard")
	public String boardWrite(BoardVO boardVo) {
		System.out.println("글작성 여기 오나요???");
		boardService.boardWrite(boardVo);
		return "redirect:boardlist.do";
	}
	
	//게시글 상세화면
	@RequestMapping(value="/boardview", method= {RequestMethod.GET, RequestMethod.POST})
	public String boardView(BoardVO boardVO, Model model) {
		System.out.println("여기 오나요???상세");
		model.addAttribute("replyList", boardService.getReplyList(boardVO.getBOARD_NUM()));
		model.addAttribute("view",      boardService.boardView(boardVO.getBOARD_NUM()));
		return "board_view";
	}
	
	//게시글 수정화면
	@RequestMapping(value="/boardUpdateview", method=RequestMethod.GET)
	public String boardUpdate(BoardVO boardVO, Model model) {
		System.out.println("여기 오나요???수정화면");
		model.addAttribute("update", boardService.boardView(boardVO.getBOARD_NUM()));
		return "board_update";
	}
	
	//게시글 수정
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public String update(BoardVO boardVO) {
		boardService.boardUpdate(boardVO);
		return "redirect:boardlist.do";
	}
	
	//게시글 삭제
	@RequestMapping(value="/boardDelete")
	public String boardDelete(BoardVO boardVO) {
		System.out.println("여기 오나요???삭제");
		boardService.boradDelete(boardVO.getBOARD_NUM());
		return "redirect:boardlist.do";
	}

	//댓글 등록
	@RequestMapping(value="/replyWrite", method = RequestMethod.POST )
	@ResponseBody
	public Map<String, Object> replyWrite(@RequestBody ReplyVO vo){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("여기 오나요???댓글 등록버튼");
		//정보 입력
		int result = boardService.boardReplyWrite(vo);
		if(result > 0) {	//ajax통신할때 success function에 넘겨주려고
			map.put("code", "OK");
			map.put("reply_id", vo.getReply_id());
			map.put("parent_id",vo.getParent_id());
			map.put("message", "댓글 등록 성공!");
		}else {
			map.put("code", "FAIL");
			map.put("message", "댓글 등록 실패!");
		}
		return map;
	}
	
	//댓글 삭제
	@RequestMapping(value="/replyDelete", method = RequestMethod.POST )
	@ResponseBody
	public Map<String, Object> replyDelete(@RequestBody ReplyVO vo){
		System.out.println("여기 오나요???댓글 삭제버튼!!");
		Map<String, Object> map = new HashMap<String, Object>();
		int result = boardService.replyDelete(vo);
		if(result > 0) {
			map.put("code", "OK");
		}else {
			map.put("code", "FAIL");
			map.put("message", "댓글 삭제 실패! 패스워드를 확인해주세요!!");
		}
		return map;
	}
	
	//댓글 패스워드 확인
	@RequestMapping(value="replyCheck", method= RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCheck(@RequestBody ReplyVO vo){
		System.out.println("댓글 수정 버튼!!! 컨트롤러!!!");
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean check = boardService.checkReply(vo);
		
		if(check) {
			map.put("code",     "OK");
			map.put("reply_id", vo.getReply_id());
		}else {
			map.put("come",    "FAIL"); 
			map.put("message", "패스워드를 확인해주세요!!"); 
		}
		return map;
	}
	
	
	//댓글 수정
	@RequestMapping(value="replyUpdate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyUpdate(@RequestBody ReplyVO vo){
		System.out.println("댓글 수정 진행!!! 컨트롤러!!!");
		Map<String, Object> map = new HashMap<String, Object>();
		
		boolean check = boardService.updateReply(vo);
		
		if(check) {
			map.put("code",     "OK");
			map.put("reply_id", vo.getReply_id());
			map.put("message",  "댓글 수정 성공!!!");
		}else {
			map.put("come",    "FAIL"); 
			map.put("message", "댓글 수정 실패ㅠㅠ"); 
		}
		return map;
	}
}
