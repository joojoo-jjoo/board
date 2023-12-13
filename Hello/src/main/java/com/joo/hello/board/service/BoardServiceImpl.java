package com.joo.hello.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.joo.hello.board.vo.BoardVO;
import com.joo.hello.board.vo.ReplyVO;
import com.joo.hello.member.dao.BoardDao;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDao boardDao;

	@Override
	public void boardWrite(BoardVO boardVo) {	//파라미터 타입이랑 db에서 받는 컬럼명이랑 같으므로 vo로 던져도 ok
//		String BOARD_TITLE = boardVo.getBOARD_TITLE();
//		String BOARD_CONTENT = boardVo.getBOARD_CONTENT();
//		String BOARD_WRITER = boardVo.getBOARD_WRITER();
//		
//		boardVo.setBOARD_TITLE(BOARD_TITLE);
//		boardVo.setBOARD_CONTENT(BOARD_CONTENT);
//		boardVo.setBOARD_WRITER(BOARD_WRITER);
		boardDao.boardWrite(boardVo);
	}

	@Override
	public List<BoardVO> getList() {
		List result = boardDao.getList();
		System.out.printf("여기는 result???", result);
		return result;
	}

	@Override
	public BoardVO boardView(int bno) {
		return	boardDao.boardView(bno);
	}

	@Override
	public void boardUpdate(BoardVO boardVo) {
		boardDao.boardUpdate(boardVo);
	}

	@Override
	public void boradDelete(int bno) {
		boardDao.boardDelete(bno);
	}

	@Override
	public int boardReplyWrite(ReplyVO vo) {
		System.out.printf("여기 오나요???댓글 등록버튼 서비스", vo);
		return boardDao.boardReplyWrite(vo);
	}

	@Override
	public List<ReplyVO> getReplyList(int bno) {
		List result = boardDao.getReplyList(bno);
		return result;
	}

	@Override
	public int replyDelete(ReplyVO vo) {
		return boardDao.boardReplyDelete(vo);
	}

	@Override
	public boolean updateReply(ReplyVO vo) {
		return boardDao.updateReply(vo);
	}

	@Override
	public boolean checkReply(ReplyVO vo) {
		return boardDao.checkReply(vo);
	}
	
}
