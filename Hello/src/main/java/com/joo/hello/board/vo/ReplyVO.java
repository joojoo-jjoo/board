package com.joo.hello.board.vo;

public class ReplyVO {
	
	
	private int reply_id;				//댓글 순번 1씩 증가하게 함
	private int board_id;				//게시글 번호
	private int parent_id;				//댓글은 0, 대댓글은 1값을 줌
	private int depth;					//댓글은 0, 대댓글은 1값을 줌
	private String reply_content;		//댓글 내용
	private String reply_writer;		//댓글 작성자
	private String reply_password;		//댓글 비밀번호
	private String register_datetime;	//댓글 작성일
	
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getBoard_id() {
		return board_id;
	}
	public void setBoard_id(int board_id) {
		this.board_id = board_id;
	}
	public int getParent_id() {
		return parent_id;
	}
	public void setParent_id(int parent_id) {
		this.parent_id = parent_id;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getReply_content() {
		return reply_content;
	}
	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}
	public String getReply_writer() {
		return reply_writer;
	}
	public void setReply_writer(String reply_writer) {
		this.reply_writer = reply_writer;
	}
	public String getReply_password() {
		return reply_password;
	}
	public void setReply_password(String reply_password) {
		this.reply_password = reply_password;
	}
	public String getRegister_datetime() {
		return register_datetime;
	}
	public void setRegister_datetime(String register_datetime) {
		this.register_datetime = register_datetime;
	}
	
	@Override
	public String toString() {
		return "ReplyVO [reply_id=" + reply_id + ", board_id=" + board_id + ", parent_id=" + parent_id + ", depth="
				+ depth + ", reply_content=" + reply_content + ", reply_writer=" + reply_writer + ", reply_password="
				+ reply_password + ", register_datetime=" + register_datetime + "]";
	}

}
