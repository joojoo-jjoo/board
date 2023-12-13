<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<title>게시글 상세</title>
<script type="text/javascript">
	$(document).ready(function(){
		
		var status  = false; //수정과 대댓글을 동시에 적용 못하도록, 아래 대댓글 등록할때 사용함
		
		//수정버튼
		$("#updateBtn").on("click", function(){
			formObj.attr("action", "/hello/boardUpdateview.do");
			formObj.attr("method", "get");
			formObj.submit();
		});
		
		//삭제버튼
		$("#deleteBtn").on("click", function(){
			formObj.attr("action", "/hello/boardDelete.do");
			formObj.attr("method", "post");
			formObj.submit();
		});
		
		//댓글삭제버튼
		$(document).on("click", "button[name='reply_del']", function(){
			alert("삭제버튼");
			var check	  = false;
			var reply_id  = $(this).attr("reply_id");
			var r_type    = $(this).attr("r_type");
			var pass	  = $("#passWord").val();	//test용
			var reply_password = "reply_password_"+reply_id;
			var params = {
							 reply_password  : $("#"+reply_password).val()
							,reply_id   	 : reply_id
						  //,r_type			 : r_type
						};
			alert("댓글삭제 아작스 가자규용");
			//ajax 호출
			$.ajax({
				type		 : "post",
				url		     : "${contextPath}/replyDelete.do",
				data		 : JSON.stringify(params),
				dataType     : "text",
 				contentType  : "application/json; charset=UTF-8",
				async		 : false, //동기:false, 비동기:true
				success	 	 : function(result){		//추후 수정 필요!!!
					if(result.code != "OK"){
						alert(result.message);
					}else{
						check = true;
					}
				},
				error		: function(request, status, error){
					console.log("댓글삭제 에러라규ㅠㅠ");
				}
			});
			if(check){
				if(r_type == "main"){	//depth가 0이면 하위 댓글 다 지움
					var prevTr =  $(this).parent().parent().next(); //댓글의 다음
					while(prevTr.attr("reply_type") == "sub"){//댓글의 다음이 sub면 계속 넘어감
                        prevTr.remove();
                        prevTr = $(this).parent().parent().next();
                    }
					$(this).parent().parent().remove();
				}else{ //아니면 자기만 지움
					$(this).parent().parent().remove();
				}
			}
		});
		
		//댓글등록버튼
 		$("#reply_save").click(function(){
			alert("댓글 등록 버튼");
			var reply_content = $("#reply_content").val().replace("\n", "<br>"); //개행처리
			var paramMap = {
							 board_id 		: $("#board_id").val()
							,parent_id 		: 0
							,depth 			: 0
							,reply_content	: reply_content
							,reply_writer   : $("#reply_writer").val()
							,reply_password : $("#reply_password").val()
						  }; 
			console.log("댓글 등록 버튼2");
			var reply_id;
			
			//ajax호출
			console.log("댓글 등록 버튼3");
			$.ajax({
				type		 : "post",
				url		     : "${contextPath}/replyWrite.do",	
				data		 : JSON.stringify(paramMap),
				dataType     : "text",
 				contentType  : "application/json; charset=UTF-8",
				async		 : false, //동기:false, 비동기:true
				success	 	 : function(result){		//추후 수정 필요!!!
					if(result.code != "OK"){
						//alert(result.message);
						return false;
					}else{
						reply_id = result.reply_id;
					}
				},
				error 		: function(request, status, error){
					console.log("에러났!!!!")
				}
			});
			console.log("댓글 등록 버튼4");
			var reply_area = $("#reply_area");
			var reply = '<tr reply_type="main">'+
						    '<td width="820px">' +
						reply_content +
							'</td>'+
							'<td width="100px">'+
						$("#reply_writer").val()+
						 	'</td>'			   +
						 	'<td width="100px">'+
						 	   '<input type="password" id="reply_password_" style="width:"100px;" maxlength="10" placeholder="패스워드"/>'+
						 	'</td>'+
						 	'<td align="center">'+
						 	   	'<button name="reply_reply"  reply_id ="'+reply_id+'">댓글</button>'+
						 	   	'<button name="reply_modify" r_type="main" parent_id="0" reply_id="'+reply_id+'">수정</button>'+
						 	   	'<button name="reply_del"    r_type="main" reply_id="'+reply_id+'">삭제</button>'+
						 	'</td>'+
						 '</tr>';
		//	if($('#reply_area').content().size() == 0){ type error남
			if($('#reply_area').find('tr').length === 0){
				$('#reply_area').append(reply);
			}else{
				$('#reply_area tr:last').after(reply);
			}
			//댓글 초기화
			$("#reply_writer").val("");
			$("#reply_password").val("");
			$("#reply_content").val("");
		});

		//대댓글 입력창 - 창이 생겼다가 금방 사라진다면? <form>로 묶여있지는 않은지 확인할 것!!**
		$(document).on("click", "button[name='reply_reply']", function(){
			if(status){
				alert("수정과 대댓글은 동시에 불가해용!");
				return false;
			}
			status = true;
			//$("#reply_add").remove();

			var reply_id   = $(this).attr("reply_id");
			var last_check = false; //마지막 tr체크
			//입력받는 창 등록
			var replyEditor =	//앞에 +붙이고, 같은 태그끼리 묶어서 그리면 좀 나은듯...?
				 '<tr id="reply_add" class="reply_reply">'
				+'	<td width="820px">'
				+'		<textarea id="reply_reply_content" rows="3" cols="50"></textarea>'
				+'	</td>'
				+'	<td width="100px">'
				+'		<input type="text" id="reply_reply_writer" style="width:100%;" maxlength="10" placeholder="작성자"/>'
				+'	</td>'
				+'	<td width="100px">'
				+'		<input type="password" id="reply_reply_password" style="width:100%;" maxlength="10" placeholder="패스워드"/>'
				+'	</td>'
				+'	<td aling="center">'
				+'		<button name="reply_reply_save" parent_id="'+reply_id+'">등록</button>'
				+'		<button name="reply_reply_cancel">취소</button>'
				+'	</td>'				
				+'</tr>';

			var prevTr = $(this).parent().parent().next();
			//부모의 부모 다음이 sub이면 마지막 sub 뒤에 붙인다.
			//마지막 reply 처리
			if(prevTr.attr("reply_type") == undefined){
				prevTr = $(this).parent().parent();
			}else{
				while(prevTr.attr("reply_type") == "sub"){ //댓글의 다음이 sub면 계속 넘어감
					prevTr = prevTr.next();
				}
				if(prevTr.attr("reply_type") == undefined){//next뒤에 tr이 없다면 마지막이라는 표시를 해주자
					last_check = true;
				}else{
					prevTr = prevTr.prev();
				}
			}
			if(last_check){	//마지막이라면 제일 마지막 tr 뒤에 댓글 입력을 붙인다
				$("#reply_area tr:last").after(replyEditor);
			}else{
				prevTr.after(replyEditor);
			}
		});
		
		//대댓글 등록
		$(document).on("click", "button[name='reply_reply_save']", function(){
			
			var reply_reply_writer   = $("#reply_reply_writer").val();
			var reply_reply_password = $("#reply_reply_password").val();
			var reply_reply_content  = $("#reply_reply_content").val();
			
			//값 세팅
			var params = {
					 board_id    		  : $("#board_id").val()
					,parent_id	 	  	  : $(this).attr("parent_id")
					,depth				  : 1
					,reply_content    	  : reply_reply_content
					,reply_writer 		  : reply_reply_writer
					,reply_password    	  : reply_reply_password
			};
			
			var reply_id;
			var parent_id;
			
			//ajax호출
			$.ajax({
				type		 : "post",
				url		     : "${contextPath}/replyWrite.do",	
				data		 : JSON.stringify(params),
				dataType     : "text",
 				contentType  : "application/json; charset=UTF-8",
				async		 : false,		 	 //동기:false, 비동기:true
				success	 	 : function(result){ //추후 수정 필요!!!
					if(result.code != "OK"){
						alert(result.message);
					}else{
						reply_id  = result.reply_id;
						parent_id = result.parent_id;
					}
				},
				error 		: function(request, status, error){
					console.log("대댓글 등록 에러났!!!!")
				}
			});
			var reply =
				 '<tr reply_type="sub">'
				+'	<td width="820px"> → '
				+ reply_reply_content
				+'	</td>'
				+'	<td width="100px">'
				+ reply_reply_writer
				+'	</td>'
				+'	<td width="100px">'
				+'		<input type="password" id="reply_password_'+reply_id+'" style="width:100px;" maxlength="10" placeholder="패스워드"/>'
				+'	</td>'
				+'	<td align="center">'
				+'		<button name="reply_modify" r_type="sub" parent_id="'+parent_id+'" reply_id="'+reply_id+'">수정</button>'
				+'		<button name="reply_del" r_type="sub" reply_id="'+reply_id+'">삭제</button>'
				+'	</td>'
				+'</tr>';
				
			var prevTr = $(this).parent().parent().prev();
			prevTr.after(reply);
			$("#reply_add").remove();
			status = false;
		});
		
		//대댓글 입력 취소 버튼
		$(document).on("click", "button[name='reply_reply_cancel']", function(){
			$("#reply_add").remove();
			status = false;
		});
		
		//댓글 수정버튼
		$(document).on("click", "button[name='reply_modify']", function(){
			var check 		   = false;
			var reply_id  	   = $(this).attr("reply_id");
			var parent_id	   = $(this).attr("parent_id");
			var r_type    	   = $(this).attr("r_type");
			var reply_password = "reply_password_"+reply_id;
				
			if($("#"+reply_password).val().trim() ==""){
				alert("패스워드를 입력하세요");
				$("#"+reply_password).focus();
				return false;
			}
			//패스워드와 아이디를 넘겨 패스워드 확인
			var obj = {
					 reply_id		: reply_id
					,reply_password : $("#"+reply_password).val()
			};
			
			//ajax
			$.ajax({
				type		 : "post",
				url		     : "${contextPath}/replyCheck.do",	
				data		 : JSON.stringify(obj),
				dataType     : "text",
 				contentType  : "application/json; charset=UTF-8",
				async		 : false,	
				success		 : function(result){
					if(result.code == "OK"){
						check = false;	//패스워드가 맞으면 체크값을 true로 변경
						alert(result.message);
					}else{
						check = true;
					}
				},
				error 		: function(request, status, error){
					console.log("댓글 수정버튼 에러났!!!!");
				}
			});
			if(status){
				alert("수정과 대댓글은 동시에 불가합니다.");
				return false;
			}
			
			if(check){
				//자기 위에 댓글 수정창 입력하고 기존값을 채우고 자기 자신 삭제
				var txt_reply_content = $(this).parent().prev().prev().prev().html().trim();  //댓글내용 가져오기
				if(r_type == "sub"){
					txt_reply_content = txt_reply_content.replace("→ ",""); 				//대댓글의 뎁스표시(화살표) 없애기
				}
				var txt_reply_writer = $(this).parent().prev().prev().html().trim();		//댓글작성자 가져오기
				
				//입력받는 창 등록
				var replyEditor = 
					 '<tr id="reply_add" class="reply_modify">'
					+'	<td width="820px">'
					+'		<textarea name="reply_modify_content_'+reply_id+'" id="reply_modify_content_'+reply_id+'" rows="3" cols="50">'+txt_reply_content+'</textarea>'	//기존 내용 넣기
					+'	</td>'
					+'	<td width="100px">'
					+'		<input type="text" name="reply_modify_writer_'+reply_id+'" id="reply_modify_writer_'+reply_id+'" style="width:100%;" maxlength="10" placeholder="작성사" value="'+txt_reply_writer+'">' //기존 작성자 넣기
					+'	</td>'
					+'	<td>'
					+'		<input type="password" name="reply_modify_password_'+reply_id+'" id="reply_modify_password_'+reply_id+'" style="width=100%"; maxlength="10" placeholder="패스워드">'
					+'	</td>'
					+'	<td align="center">'
					+'		<button name="reply_modify_save" r_type="'+r_type+'" parent_id="'+parent_id+'"reply_id="'+reply_id+'">등록</button>'
					+'		<button name="reply_modify_cancle" r_type="'+r_type+'" r_content="'+txt_reply_content+'"r_writer="'+txt_reply_writer+'"parent_id="'+parent_id+'"reply_id="'+reply_id+'">취소</button>'
					+'	</td>'
					+'</tr>';
					
				var prevTr = $(this).parent().parent();
				//자기 위에 붙이기
				prevTr.after(replyEditor);
				
				//자기 자신 삭제
				$(this).parent().parent().remove();
			}
		});
		
		//댓글 수정내용 저장하기
		$(document).on("click", "button[name='reply_modify_save']", function(){
			var reply_id 	  = $(this).attr("reply_id");
			var reply_content = $("#reply_modify_content_"+reply_id).val().replace("\n", "<br>"); //개행처리
			var r_type 		  = $(this).attr("r_type");
			
			var parent_id;
			var depth;
			if(r_type == "main"){
				parent_id = 0;
				depth	  = 0;
			}else{
				parent_id = $(this).attr("parent_id");
				depth = 1;
			}
			
			//파람 세팅
			var obj = {
					
				 board_id 		: $("#board_id").val()
				,reply_id 		: reply_id
				,parent_id 		: parent_id
				,reply_writer   : $("#reply_modify_writer_"+reply_id).val()
				,reply_password : $("#reply_modify_password_"+reply_id).val()
				,reply_content  : reply_content  
			};
			
			$.ajax({
				type		 : "post",
				url		     : "${contextPath}/replyUpdate.do",	
				data		 : JSON.stringify(obj),
				dataType     : "text",
 				contentType  : "application/json; charset=UTF-8",
				async		 : false,
				success		 : function(result){
					if(result.code != "OK"){
						alert(result.message);
						return false;
					}else{
						reply_id  = result.reply_id;
						parent_id = result.parent_id;
					}
				},
				error		  : function(request, status, error){
					console.log("댓글 수정 에러났어유???");
				}
			});
			//수정된 댓글 내용
			if(r_type == "main"){
				reply =
					 '<tr reply_type="main">'
					+'	<td width="820px">'
					+ $("#reply_modify_content_"+reply_id).val()
					+'	</td>'
					+'	<td width="100px">'
					+ $("#reply_modify_writer_"+reply_id).val()
					+'	</td>'
					+'	<td align="center">'
					+'		<button name="reply_reply" reply_id="'+reply_id+'">댓글</button>'
					+'		<button name="reply_modify" r_type="main" parent_id="0" reply_id="'+reply_id+'">수정</button>'
					+'		<button name="reply_del"    r_type="main" reply_id="'+reply_id+'">삭제</button>'
					+'	</td>'
					+'</tr>';
			}else{
				reply =
					 '<tr reply_type="sub">'
					+'	<td width="820px">'
					+ $("#reply_modify_content_"+reply_id).val()
					+'	</td>'
					+'	<td width="100px">'
					+ $("#reply_modify_writer_"+reply_id).val()
					+'	</td>'
					+'	<td>'
					+'		<input type="password" id="reply_password_'+reply_id+'" style="width:100px"; maxlength="10" placeholder="패스워드"/>'
					+'	</td>'
					+'	<td align="center">'
					+'		<button name="reply_modify" r_type="sub" parent_id="0" reply_id="'+reply_id+'">수정</button>'
					+'		<button name="reply_del"    r_type="sub" reply_id="'+reply_id+'">삭제</button>'
					+'	</td>'
					+'</tr>';					
			}
			
			var prevTr = $(this).parent().parent();
			prevTr.after(reply);
			
			$(this).parent().parent().remove();
			status = false;
			
		});
	});
</script>
</head>
    <style>
        textarea{
              width:100%;
            }
        .reply_reply {
                border: 2px solid #FF50CF;
            }
        .reply_modify {
                border: 2px solid #FFBB00;
            }
    </style>
<body>
	<h1>게시글 상세</h1>
		
	<input type="hidden" name="BOARD_NUM" value="${view.BOARD_NUM}"/>
	<input type="hidden" name="board_id" id="board_id"  value="${view.BOARD_NUM}"/>
	<div align="center">
	<table border="1" width="1200px">
		<tr>
			<td colspan="2" align="right">
			<button type="submit" id="updateBtn">글수정</button>
			<button type="submit" id="deleteBtn">글삭제</button>
			<button type="button" onclick="location.href='boardlist.do'">목록으로</button>
			</td>
		</tr>
		<tr>
			<td>글번호</td>
			<td>${view.BOARD_NUM}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td>${view.BOARD_TITLE}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${view.BOARD_WRITER}</td>								
		</tr>
		<tr>	
			<td>내용</td>
			<td height="100px">${view.BOARD_CONTENT}</td>
		</tr>
		<tr>
			<td>작성일</td>
			<td><fmt:formatDate value="${view.REG_DATE}" pattern="yyyy-MM-dd" /></td>
		</tr>
	</table>
		
    <table border="1" width="1200px" bordercolor="#46AA46">
        <tr>
            <td width="500px">
             이름:    <input type="text"     id="reply_writer"   name="reply_writer"   style="width:170px;" maxlength="10" placeholder="작성자"/>
             패스워드: <input type="password" id="reply_password" name="reply_password" style="width:170px;" maxlength="10" placeholder="패스워드"/>
             <button id="reply_save" name="reply_save">댓글 등록</button>
            </td>
        </tr>
        <tr>
            <td>
                <textarea id="reply_content" name="reply_content" rows="4" cols="50" placeholder="댓글을 입력하세요."></textarea>
            </td>
        </tr>
    </table>
    		
     <table border="1" width="1200px" id="reply_area">
         <tr reply_type="all"  style="display:none"> <!-- 뒤에 댓글 붙이기 쉽게 선언 -->
             <td colspan="4"></td>
         </tr>
         <!-- 댓글이 들어갈 공간 -->
         <c:forEach var="replyList" items="${replyList}" varStatus="status">
          <tr reply_type="<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>"><!-- 댓글의 depth 표시 -->
              <td width="100px">
                  ${replyList.reply_writer}
              </td> 
              <td width="820px">
                 <c:if test="${replyList.depth == '1'}"> → </c:if>${replyList.reply_content}
              </td>
              <td width="100px">
                <%--   <input type="password" id="testpass_${replyList.reply_id}" name="testpass" style="width:100px;" maxlength="10" placeholder="패스워드"/> --%>
                <input type="password" id="reply_password_${replyList.reply_id}" style="width:100px;" maxlength="10" placeholder="패스워드"/>
              </td>
              <td align="center">
                  <c:if test="${replyList.depth != '1'}">
                      <button name="reply_reply" parent_id = "${replyList.reply_id}" reply_id = "${replyList.reply_id}">댓글</button><!-- 첫 댓글에만 댓글이 추가 대댓글 불가 -->
                  </c:if>
                  <button name="reply_modify" parent_id = "${replyList.parent_id}" r_type = "<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>" reply_id = "${replyList.reply_id}">수정</button>
                  <button name="reply_del" r_type = "<c:if test="${replyList.depth == '0'}">main</c:if><c:if test="${replyList.depth == '1'}">sub</c:if>" reply_id = "${replyList.reply_id}">삭제</button>
              </td>
          </tr>
      </c:forEach>
     </table>

     </div>	
</body>
</html>

