<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 등록</title>
</head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

  <script>
  		//달력
	  $( function() {
	    $( "#birth" ).datepicker({
	      changeMonth: true,
	      changeYear: true,
	      dateFormat:"yymmdd"
	    });
	    
	    
	    //우편번호찾기 팝업창 열기
	    $("#btn_zipcode").click(function(){
	    	
	    	var w = 500;
	    	var h = 200;
	    	var url = "post1.do";
	    	window.open(url, 'zipcode', 'width='+w+',height='+h);
	    	
	    });
	    
	    //아이디 체크
	    $("#btn_idcheck").click(function(){
	    	var userid = $.trim($("#userid").val());  //현재 창에 입력된 값 가져옴
	    	
	    	if(userid == ""){
	    		alert("아이디를 입력해주세요.");
	    		$("#userid").focus();
	    		return false;
	    	}
	    	
	    	//idcheck.do 로 데이터 전송 - 비동기 전송 방식
	    	$.ajax({
	
	    		type:"POST",
	  			data:"userid="+userid,   //어떤 값 하나를 전송하고 싶을땐 json 타입으로 작성  
	  			url:"idcheck.do",   
	  			dataType:"text",
	  			
	  			success: function(result){
	  				if(result == "ok"){
	  					alert("사용가능한 아이디 입니다.");
	  				}else{
	  					alert("중복된 아이디입니다.")
	  				}
	  			},
	  			error: function(){
	  				alert("오류발생!");
	  			}
	    	});
	    	
	    });
	    
	    //회원가입 체크
	  	$("#btn_submit").click(function(){
			var userid = $("#userid").val();
			var pass = $("#pass").val();
	  		var name = $("#name").val();
	  		
	  		//공백제거
	  		useid = $.trim(userid);
	  		pass = $.trim(pass);
	  		name = $.trim(name);
	  		
	  		//오류체크(공백여부)
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
	  		
	  		if(name == ""){
	  			alert("이름을 입력해주세요.");
	  			$("#name").focus();
	  			return false;
	  		}
	  		
	  		$("#userid").val(userid);
	  		$("#pass").val(pass);
	  		$("#name").val(name);
	  		
	  		
	  		//전송처리 ajax
	  		var formData = $("#frm").serialize();
	  		
	  		$.ajax({
	  			//전송 전 세팅
	  			type:"POST",
	  			data:formData,   //var 로 선언한 변수
	  			url:"memberWriteSave.do",   //저장될 곳 action
	  			dataType:"text",     //return type
	  			
	  			//전송 후 세팅
	  			success: function(result){
	  				if(result == "ok"){       //controller의 ok
	  					alert("저장완료!");
	  					location="loginWrite.do";
	  				}else{
	  					alert("저장실패.");
	  				}
	  			},
	  			error: function(){     //여기서 error는 시스템error, 장애발생, 전송실패
	  				alert("오류발생..");
	  			}
	  		});
	  		
	  	});
	    
	  });
	  
  </script>
  
  
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
		<th width="25%"><a href="">게시판</a></th>
		<th width="25%"><a href="/board0416/memberWrite.do">회원가입</a></th>
		<th width="25%"><a href="/board0416/loginWrite.do">로그인</a></th>
	</tr>
</table>

<form id="frm" name="frm">
	<table>
		<caption>회원가입 폼</caption>
		<tr>
			<th><label for="userid">아이디</label></th>
			<td>
				<input type="text" name="userid" id="userid" placeholder="아이디입력">
				<button type="button" id="btn_idcheck">중복체크</button>
			</td>
		</tr>
		<tr>
			<th><label for="pass">비밀번호</label></th>
			<td>
				<input type="password" name="pass" id="pass">
			</td>
		</tr>
		<tr>
			<th><label for="name">이름</label></th>
			<td>
				<input type="text" name="name" id="name">
			</td>
		</tr>
		<tr>
			<th><label for="gender">성별</label></th>
			<td>
				<input type="radio" name="gender" id="gender" value="M">남
				<input type="radio" name="gender" id="gender" value="F">여
			</td>
		</tr>
		<tr>
			<th><label for="birth">생년월일</label></th>
			<td>
				<input type="text" name="birth" id="birth">
			</td>
		</tr>
		<tr>
			<th><label for="phone">연락처</label></th>
			<td>
				<input type="text" name="phone" id="phone"> (예: 010-1234-1234)
			</td>
		</tr>
		<tr>
			<th><label for="address">주소</label></th>
			<td>
				<input type="text" name="zipcode" id="zipcode">
				<button type="button" id="btn_zipcode">우편번호찾기</button><br>
				<input type="text" name="address" id="address">
			</td>
		</tr>
	</table>
	<div class="div_button"> 
		<button type="submit" id="btn_submit">저장</button>
		<button type="reset">취소</button>
	</div>
</form>

</body>
</html>