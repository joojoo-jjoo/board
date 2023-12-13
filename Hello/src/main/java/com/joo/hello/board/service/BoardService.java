package com.joo.hello.board.service;

import java.util.List;

import com.joo.hello.board.vo.BoardVO;
import com.joo.hello.board.vo.ReplyVO;

public interface BoardService {

	//게시글 작성
	public void boardWrite(BoardVO boardVo);
	
	//게시글 목록
	public List<BoardVO> getList();
	
	//게시글 상세
	public BoardVO boardView(int bno);
	
	//게시글 수정
	public void boardUpdate(BoardVO boardVo);
	
	//게시글 삭제
	public void boradDelete(int bno);
	
	//댓글등록
	public int boardReplyWrite(ReplyVO vo);
	
	//댓글 목록
	public List<ReplyVO> getReplyList(int bno);
	
	//댓글 삭제
	public int replyDelete (ReplyVO vo);
	
	//댓글 수정
	public boolean updateReply(ReplyVO vo);
	
	//댓글 패스워드 확인
	public boolean checkReply(ReplyVO vo);
}
