<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<a href="${pageContext.request.contextPath}/member/insertform">회원추가</a>
		<h1>회원목록입니다.</h1>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>이름</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tmp" items="${list}">
					<tr>
						<th>${tmp.num}</th>
						<th>${tmp.name}</th>
						<th>${tmp.addr}</th>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>