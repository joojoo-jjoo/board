<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
		<h1>게시글 작성</h1>

<form action="/hello/regBoard.do" method="post">
	<table border="1" width="1200px">
	<tr>
		<td>제목</td> 
		<td><input type="text" name="BOARD_TITLE" id="BOARD_TITLE" style="width:600px;"><br></td>
	</tr>
	<tr>
		<td>내용</td> 
		<td><textarea type="text" name="BOARD_CONTENT" id="BOARD_CONTENT"  rows="10" cols="80" placeholder="내용을 입력해주세요~!"></textarea></td>
	</tr>
	<tr>
		<td>작성자</td> 
		<td><input type="text" name="BOARD_WRITER" id="BOARD_WRITER" style="width:170px;"></td>
	</table>

	<input type="submit" value="등록">
	<button type="button" onclick="location.href='boardlist.do'">목록으로</button>
</form>
</body>
</html>