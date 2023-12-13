package com.joo.hello.board.vo;

import java.util.Date;

public class BoardVO {
	
	private int BOARD_NUM;			//게시글 순번
	private String BOARD_TITLE;		//제목
	private String BOARD_CONTENT;	//내용
	private String BOARD_WRITER;	//작성자
	private Date REG_DATE;			//작성일
	
	
	public int getBOARD_NUM() {
		return BOARD_NUM;
	}
	public void setBOARD_NUM(int bOARD_NUM) {
		BOARD_NUM = bOARD_NUM;
	}
	public String getBOARD_TITLE() {
		return BOARD_TITLE;
	}
	public void setBOARD_TITLE(String bOARD_TITLE) {
		BOARD_TITLE = bOARD_TITLE;
	}
	public String getBOARD_CONTENT() {
		return BOARD_CONTENT;
	}
	public void setBOARD_CONTENT(String bOARD_CONTENT) {
		BOARD_CONTENT = bOARD_CONTENT;
	}
	public String getBOARD_WRITER() {
		return BOARD_WRITER;
	}
	public void setBOARD_WRITER(String bOARD_WRITER) {
		BOARD_WRITER = bOARD_WRITER;
	}
	public Date getREG_DATE() {
		return REG_DATE;
	}
	public void setREG_DATE(Date rEG_DATE) {
		REG_DATE = rEG_DATE;
	}
	
	@Override
	public String toString() {
		return "BoardVO [BOARD_NUM=" + BOARD_NUM + ", BOARD_TITLE=" + BOARD_TITLE + ", BOARD_CONTENT=" + BOARD_CONTENT
				+ ", BOARD_WRITER=" + BOARD_WRITER + ", REG_DATE=" + REG_DATE + "]";
	}
	
}
