<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<h1>게시글 수정해볼까요?</h1>
		
<form action="/hello/boardUpdate.do" method="post">
	<input type="hidden" name="BOARD_NUM" value="${update.BOARD_NUM}">
	<table border="1" width="600px">
			<tr>
				<td>번호</td>
				<td>${update.BOARD_NUM}</td>

			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" name="BOARD_TITLE" value="${update.BOARD_TITLE}"></td>
			</tr>

			<tr>
				<td>작성자</td>
				<td>${update.BOARD_WRITER}</td>								
			</tr>
			<tr>	
				<td>내용</td>
				<td><textarea type="text" name="BOARD_CONTENT" id="BOARD_CONTENT" placeholder="내용을 입력해주세요~!">${update.BOARD_CONTENT}</textarea></td>
			</tr>
			<tr>
				<td><fmt:formatDate value="${update.REG_DATE}" pattern="yyyy-MM-dd" /></td>
			</tr>
	</table>
		<input type="submit" value="수정">

		<button type="button" onclick="location.href='boardwrite.do'">글삭제</button>
		<button type="button" onclick="location.href='boardlist.do'">목록으로</button>
</form>
</body>
</html>

