<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
</head>
<body>
	<h1>게시글 목록</h1>
	<table border="1" width="600px">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>내용</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
			<c:forEach var="row" items="${list}">
				<tr>
					<td><a href="boardview.do?BOARD_NUM=${row.BOARD_NUM}"><c:out value="${row.BOARD_NUM}" /></a></td>
					<td><c:out value="${row.BOARD_TITLE}"/></td>
					<td><c:out value="${row.BOARD_CONTENT}"/></td>
					<td><c:out value="${row.BOARD_WRITER}"/></td>
					<td><fmt:formatDate value="${row.REG_DATE}" pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
	</table>
		<button type="button" onclick="location.href='boardwrite.do'">글쓰기</button>
</body>
</html>