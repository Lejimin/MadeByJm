<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 수정</title>
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
	
	//document.frm.title.value==""
	//$("#title").val() == ""
	
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
		url:"boardModifySave.do",   //저장될 곳 action
		dataType:"text",     //return type
		success: function(result){
			if(result == "1"){       //controller의 1
				alert("수정완료!");
				location="boardList.do";
			}else if(result == "-1"){
				alert("암호가 일치 하지 않습니다.");
			}else{ 
				alert("수정실패.");
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
<input type="hidden" name="unq" value="${boardVO.unq }">

<table>
	<caption>게시판 수정 화면</caption>
	<tr>
		<th width="20%"><label for="title">제목</label></th>
		<td width="80%"><input type="text" name="title" id="title" class="input1" value="${boardVO.title }"></td>
	</tr>
	<tr>
		<th><label for="pass">암호</label></th>
		<td><input type="password" name="pass" id="pass"></td>
	</tr>
	<tr>
		<th><label for="name">글쓴이</label></th>
		<td><input type="text" name="name" id="name" value="${boardVO.name }"></td>
	</tr>
	<tr>
		<th><label for="content">내용</label></th>
		<td><textarea name="content" id="content" class="textarea">${boardVO.content }</textarea></td>
	</tr>
	<tr>
		<th colspan="2">
			<button type="submit" onclick="fn_submit();return false;">저장</button>
			<button type="reset">취소</button>
			<button type="button" onclick="location='boardList.do'">목록</button>
		</th>
	</tr>	
</table>
</form>

</body>
</html>