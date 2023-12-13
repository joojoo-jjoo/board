package com.joo.hello.member.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.joo.hello.board.vo.BoardVO;
import com.joo.hello.board.vo.ReplyVO;

//component scan시 bean이 되기 위해
@Repository
public class BoardDaoImple implements BoardDao {

	//Mybatis를 사용하기 위한 핵심 의존 객체 주입받기(자동으로 주입받겠다)
	@Inject
	private SqlSession session;

	@Override
	public void boardWrite(BoardVO boardVo) {
		System.out.println("여기는 오나요???");
		session.insert("board.boardInsert", boardVo);
	}

	@Override
	public List<BoardVO> getList() {
		System.out.println("여기는 오나요1111???");
		return session.selectList("board.boardlist");
	}

	@Override
	public BoardVO boardView(int bno) {
		return session.selectOne("board.boardView", bno);
	}

	@Override
	public void boardUpdate(BoardVO boardVo) {
		session.update("board.boardUpdate", boardVo);
	}

	@Override
	public void boardDelete(int bno) {
		session.delete("board.boardDelete", bno);
	}

	@Override
	public int boardReplyWrite(ReplyVO vo) {
		return session.insert("board.insertReply", vo);
	}

	@Override
	public List<ReplyVO> getReplyList(int bno) {
		return session.selectList("board.replyList", bno);
	}

	@Override
	public int boardReplyDelete(ReplyVO vo) {
		if(vo.getDepth() == 0) {
			return session.delete("board.replyDeleteAll", vo);
		}
		return session.delete("board.replyDelete", vo);
	}

	@Override
	public boolean updateReply(ReplyVO vo) {
		int result = session.update("board.updateReply", vo);
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean checkReply(ReplyVO vo) {
		int result = session.selectOne("board.checkReply", vo);
		if(result > 0) {
			return true;
		}else {
			return false;
		}
	}
}
