<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  
<script>
	$(function(){
		$("#btn_submit").click(function(){
			var userid = $.trim($("#userid").val());
			var pass = $.trim($("#pass").val());
			
			if(userid == ""){
				alert("아이디를 입력해주세요.");
				$("#userid").focus();
				return false;
			}
			if(pass == ""){
				alert("비밀번호를 입력해주세요.");
				$("#pass").focus();
				return false;
			}
			
			var formData = $("#frm").serialize();
			
			$.ajax({
	  			//전송 전 세팅
	  			type:"POST",
	  			data:formData,   //var 로 선언한 변수
	  			url:"loginWriteSub.do",   //저장될 곳 action
	  			dataType:"text",     //return type
	  			
	  			//전송 후 세팅
	  			success: function(result){
	  				if(result == "ok"){       //controller의 ok
	  					alert(userid+" 로그인완료!");
	  					location="boardList.do";
	  				}else{
	  					alert("로그인실패.");
	  				}
	  			},
	  			error: function(){     //여기서 error는 시스템error, 장애발생, 전송실패
	  				alert("오류발생..");
	  			}
			});
		});
		
	});



</script>
  
  
</head>


<style>
body{
	font-size:9pt;
	font-color:#333333;
	font-family:맑은 고딕;
}
a{
	text-decoration:none;
	color:#333333;
}
table{
	width:600px;
	border-collapse:collapse;
}
th,td{
	border:1px solid #333333;
	padding:5px;
	line-height:2.0;
}
.div_button{
	width:600px;
	text-align:center;
	margin-top:5px;
}
caption{
	font-size:15pt;
	font-weight:bold;
	margin-top:10px;
	padding-bottom:5px;
}
</style>



<body>
<table>
	<tr>
		<th width="25%"><a href="">홈</a></th>
		<th width="25%"><a href="/board0416/boardList.do">게시판</a></th>
		<th width="25%"><a href="/board0416/memberWrite.do">회원가입</a></th>
		<th width="25%"><a href="/board0416/loginWrite.do">로그인</a></th>
	</tr>
</table>

<form id="frm" name="frm">
	<table>
		<caption>로그인</caption>
		<tr>
			<th><label for="userid">아이디</label></th>
			<td>
				<input type="text" name="userid" id="userid" placeholder="아이디입력">
			</td>
		</tr>
		<tr>
			<th><label for="pass">비밀번호</label></th>
			<td>
				<input type="password" name="pass" id="pass">
			</td>
		</tr>
	</table>
	<div class="div_button"> 
		<button type="submit" id="btn_submit">로그인</button>
		<button type="reset">취소</button>
	</div>
</form>
</body>
</html>