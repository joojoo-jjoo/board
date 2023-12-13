package com.joo.hello.member.dao;

import java.util.List;

import com.joo.hello.board.vo.BoardVO;
import com.joo.hello.board.vo.ReplyVO;

public interface BoardDao {

	public void boardWrite(BoardVO boardVo);
	
	public List<BoardVO> getList();
	
	public BoardVO boardView(int bno);
	
	public void boardUpdate(BoardVO boardVo);
	
	public void boardDelete(int bno);
	
	public int boardReplyWrite(ReplyVO vo);
	
	public List<ReplyVO> getReplyList(int bno);
	
	public int boardReplyDelete(ReplyVO vo);
	
	public boolean updateReply(ReplyVO vo);
	
	public boolean checkReply(ReplyVO vo);
}
