<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 암호</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>

<script>
$(function(){
	$("#delBtn").click(function(){
		var pass = $("#pass").val();
		pass = $.trim(pass);
		if(pass == ""){
			alert("암호를 입력해 주세요");
			$("#pass").focus();
			return false;
		}
		
		var sendData = "unq=${unq}&pass="+pass;
		$.ajax({
			type:"POST",
			data:sendData,  
			url:"boardDelete.do",   //저장될 곳 action
			dataType:"text",     //return type
			success: function(result){
				if(result == "1"){       //controller의 1
					alert("삭제완료!");
					location="boardList.do";
				}else if(result == "-1"){
					alert("암호가 일치 하지 않습니다.");
				}else{ 
					alert("삭제실패.");
				}
			},
			error: function(){     //여기서 error는 시스템error, 장애발생, 전송실패
				alert("오류발생..");
			}
		});
	});
	
});

</script>

<body>
<table>
	<tr>
		<th>암호입력</th>
		<td><input type="password" id="pass"></td>
		<td><button type="button" id="delBtn">삭제</button></td>
	</tr>
</table>
</body>
</html>