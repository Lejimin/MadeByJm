<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
         
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정 화면</title>
</head>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>


<script>
$( function() {
    $("#birth").datepicker({
      changeMonth: true,
      changeYear: true,
      dateFormat:"yymmdd"
    });
    
    $("#btn_zipcode").click(function(){  
    	var w = 500;
    	var h = 100;
    	var url = "post1.do";
    	window.open(url,'zipcode','width='+w+",height="+h);
    });
    
    
    
    $("#btn_submit").click(function() {
    	
    	var name = $("#name").val();
    	name = $.trim(name);

    	if(name == "") {
    		alert("이름을 입력해주세요.");
    		$("#name").focus();
    		return false;
    	}
    	$("#name").val(name);

    	var formData = $("#frm").serialize();
		
    	$.ajax({  
    		/* 전송 전 세팅 */
    		type:"POST",
    		data:formData,
    		url:"memberModifySave.do",
    		dataType:"text",     // 리턴 타입
    		
    		/* 전송 후 세팅  */
    		success: function(result) {
    			if(result == "ok") {
    				alert("수정(저장)완료");
    			} else {
    				alert("저장실패");
    			}
    		},
    		error: function() {  // 장애발생
    			alert("오류발생");
    		}
    	});

    });
    
} );
</script>



<style>
body {
	font-size:9pt;
	font-color:#333333;
	font-family:맑은 고딕;
}
a {
	text-decoration:none;
}
table {
	width:600px;
	border-collapse:collapse;
}
th,td {
	border:1px solid #cccccc;
	padding:3px;
	line-height:2.0;
}
caption {
	font-size:15pt;
	font-weight:bold;
	margin-top:10px;
	padding-bottom:5px;
}
.div_button {
	width:600px;
	text-align:center;
	margin-top:5px;
}
#top_menu{
	width:600px;
	border-collapse:collapse;
}
a{
	text-decoration:none;
	color:#333333;
}
</style>

<body>

<table id="top_menu">
	<tr>
		<th width="25%"><a href="">홈</a></th>
		<th width="25%"><a href="/board0416/boardList.do">게시판</a></th>
		<th width="25%"><a href="/board0416/memberModifyWrite.do">회원정보</a></th>
		<th width="25%"><a href="/board0416/logout.do">로그아웃</a></th>
	</tr>
</table>

<form name="frm" id="frm">
<table>
	<caption>회원정보 수정</caption>
	<tr>
		<th><label for="userid">아이디</label></th>
		<td>
			${memberVO.userid }
		</td>
	</tr>
	<tr>
		<th><label for="pass">암호</label></th>
		<td>
			<p>**********<p>
		</td>
	</tr>
	<tr>
		<th><label for="name">이름</label></th>
		<td>
		<input type="text" name="name" id="name" value="${memberVO.name }">
		</td>
	</tr>
	<tr>
		<th><label for="gender">성별</label></th>
		<td>
		<input type="radio" name="gender" id="gender" value="M"><c:if test="${memberVO.gender == 'M'}"></c:if> 남 
		<input type="radio" name="gender" id="gender" value="F"><c:if test="${memberVO.gender == 'F'}"></c:if> 여
		</td>
	</tr>
	<tr>
		<th><label for="birth">생년월일</label></th>
		<td>
		<input type="text" name="birth" id="birth" value="${memberVO.birth }">
		</td>
	</tr>
	<tr>
		<th><label for="phone">연락처</label></th>
		<td>
		<input type="text" name="phone" id="phone" value="${memberVO.phone }"> (예:010-1234-1234)
		</td>
	</tr>
	<tr>
		<th><label for="address">주소</label></th>
		<td>
			<input type="text" name="zipcode" id="zipcode" value="${memberVO.zipcode }">
			<button type="button" id="btn_zipcode">우편번호찾기</button> 
			<br>
			<input type="text" name="address" id="address" value="${memberVO.address }">
		</td>
	</tr>
</table>
<div class="div_button">
	<button type="button" id="btn_submit">저장</button>
	<button type="reset">취소</button>
</div>
</form>

</body>
</html>