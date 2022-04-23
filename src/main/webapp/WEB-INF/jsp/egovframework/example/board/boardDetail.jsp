<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- \n을 <br>로 변형시키기 위한 코드 공백도 보이기 위함 -->
<% pageContext.setAttribute("newline", "\n"); %>
<c:set var="content" value="${fn:replace(boardVO.content, newline, '<br>' ) }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 상세보기</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<style>
body{
	font-size:9pt;
	font-family:맑은 고딕;
}
button{
	font-size:9pt;
}
table{
	width:600px;
	border-collapse:collapse;
}
th,td{
	border:1px solid #cccccc;
	padding:3px;
}
.input1{
	width:98%;
}
.textarea{
	width:98%;
	height:70px;
}
</style>


<script>

function fn_submit(){
	
	//제이쿼리의 trim() -> 앞뒤 공백 제거, java,jsp에도 있음
	//trim을 사용전에는 공백도 문자로 인식해 문자가 없어도 공백이 아니라고 인식하지만 
	//trim을 사용하면 공백을 문자로 인식하지 않음
	//val()의 괄호 안에 글을 넣으면 그 요소에 글이 적힘
	
	if( $.trim($("#title").val()) == ""){
		alert("제목을 입력해주세요.");
		$("#title").focus();
		return false;
	}
	$("#title").val($.trim($("#title").val()));   // 앞뒤 공백을 넣고 글 입력시 다음으로 넘어가면 앞뒤공백은 제거된 글이 넘어감
	
	if( $.trim($("#pass").val()) == ""){
		alert("암호를 입력해주세요.");
		$("#pass").focus();
		return false;
	}	
	$("#pass").val($.trim($("#pass").val()));
	
	if( $.trim($("#name").val()) == ""){
		alert("이름을 입력해주세요.");
		$("#name").focus();
		return false;
	}
	$("#name").val($.trim($("#name").val()));
	
	if( $.trim($("#content").val()) == ""){
		alert("내용을 입력해주세요.");
		$("#content").focus();
		return false;
	}
	
/* 	if(document.frm.title.value==""){
		alert("제목을 입력해주세요!");
		document.frm.title.focus();
		return false;
	}
	if(document.frm.pass.value==""){
		alert("암호를 입력해주세요!");
		document.frm.pass.focus();
		return false;
	} */
	
	//document.frm.submit(); //동기전송방식 : 이대로 form의 값들이 action으로 넘어감
	
	
	
	//전송처리를 위한 ajax
	var formData = $("#frm").serialize();
	
	$.ajax({
		type:"POST",
		data:formData,   //var 로 선언한 변수
		url:"boardWriteSave.do",   //저장될 곳 action
		dataType:"text",     //return type
		success: function(data){
			if(data == "ok"){       //controller의 ok
				alert("저장완료!");
				location="boardList.do";
			}else{
				alert("저장실패.");
			}
		},
		error: function(){     //여기서 error는 시스템error, 장애발생, 전송실패
			alert("오류발생..");
		}
	});
	
}


</script>
<body>
<form id="frm">
	<table>
		<caption>게시판 상세</caption>
		<tr>
			<th width="20%">제목</th>
			<td width="80%">${boardVO.title }</td>
		</tr>
		<tr>
			<th>글쓴이</th>
			<td>${boardVO.name }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td height="50">  <!-- \n을 <br>로 바꾸기 fn함수적용  -->
			${content}
			</td>
		</tr>
		<tr>
			<th>등록일</th>
			<td>${boardVO.rdate }</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="button" onclick="location='boardList.do'">목록</button>
				<button type="button" onclick="location='boardModifyWrite.do?unq=${boardVO.unq}'">수정</button>
				<button type="button" onclick="location='passWrite.do?unq=${boardVO.unq}'">삭제</button>
			</th>
		</tr>
	</table>
	<div>
		<textarea rows="2" cols="60"></textarea>
		<button type="button">댓글등록</button>
	</div>
</form>
</body>
</html>