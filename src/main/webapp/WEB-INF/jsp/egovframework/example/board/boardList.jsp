<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 리스트</title>
</head>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>
$(document).mouseup(function (e){
	if($("#modal").has(e.target).length === 0){
		$("#modal").hide();
	}
});

</script>



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
	border:1px solid #333333;
	padding:5px;
	line-height:2.0;
}
.input1{
	width:98%;
}
.textarea{
	width:98%;
	height:70px;
}
#top_menu{
	width:600px;
	border-collapse:collapse;
}
caption{
	font-size:10pt;
	font-weight:bold;
	margin-top:10px;
	padding-bottom:5px;
}
a{
	text-decoration:none;
	color:#333333;
}
#notice_tr{
	background-color: lightpink;
}
#modal{
	width:200px;
	height:200px;
	border:1px solid gray;
	background-color:white;
	position:absolute;
	top:30px;
	left:100px;
	z-index:3;
}
</style>

<body>

<!-- 모달창 -->
<div id="modal">
	<p>공지사항을 확인해주세요</p>
</div>

<table id="top_menu">
	<tr>
		<th width="25%"><a href="">홈</a></th>
		<th width="25%"><a href="/board0416/boardList.do">게시판</a></th>
		<th width="25%"><a href="/board0416/memberModifyWrite.do">회원정보</a></th>
		<th width="25%"><a href="/board0416/logout.do">로그아웃</a></th>
	</tr>
</table>

<table>
	<caption>
		<div>게시판 리스트</div>
		<div>Total : ${total }</div>
		<div>
			<form name="searchfrm" method="post" action="boardList.do">
				<select name="searchGubun" id="searchGubun">
					<option value="unq" <c:if test="${searchGubun eq 'unq'}">selected</c:if>>전체</option>
					<option value="title" <c:if test="${searchGubun eq 'title'}">selected</c:if>>제목</option>
					<option value="name" <c:if test="${searchGubun eq 'name'}">selected</c:if>>글쓴이</option>
					<option value="content" <c:if test="${searchGubun eq 'content'}">selected</c:if>>내용</option>
				</select>
				<input type="text" name="searchText" id="searchText" value="${searchText }">
				<button type="submit">검색</button>
			</form>
		</div>
	</caption>

	<tr>
		<th width="15%">번호</th>
		<th width="40%">제목</th>
		<th width="15%">글쓴이</th>
		<th width="15%">등록일</th>
		<th width="15%">조회수</th>
	</tr>
	
	<!-- 공지사항 리스트 가져오기 -->
	<c:set var="ncnt" value="1"/>
	<c:forEach var="notice" items="${noticeList }">
	<tr id="notice_tr">
		<td><c:out value="${ncnt }"/></td>
		<td>${notice.title }</td>
		<td>${notice.name }</td>
		<td>${notice.rdate }</td>
		<td>${notice.hits }</td>
	</tr>
	<c:set var="ncnt" value="${ncnt+1 }"/>
	</c:forEach>
	
	
	<!-- 게시판 리스트  -->
	<c:set var="cnt" value="${startRowNo }"/>
	
	<c:forEach var="result" items="${resultList }">
	<tr>
		<td><c:out value="${cnt }"/></td> 
		<td align="left">
			<a href="boardDetail.do?unq=${result.unq }">${result.title }</a>
		</td>
		<td>${result.name }</td>
		<td>${result.rdate }</td>
		<td>${result.hits }</td>
	</tr>
	
	<c:set var="cnt" value="${cnt-1 }"/>
	</c:forEach>
	
</table>

<!-- 페이지번호 -->
<div style="width:600px;margin-top:5px;text-align:center;">
	<c:forEach var="i" begin="1" end="${totalPage }">
			<a href="boardList.do?viewPage=${i }"> ${i }</a> 
	</c:forEach>
</div>
<div style="width:600px;margin-top:5px;text-align:right;">
	<button type="button" onclick="location='boardWrite.do'">글쓰기</button>
</div>


<div>
<img src="images/dog.jpg" alt="강아지1"/>
<img src="images/dog2.jpg" alt="강아지2"/>
</div>

<div>
<form action="hashtag.do" method="post">
	<textarea id="tag" name="tag"></textarea>
	<button type="submit">전송</button>
</form>
</div>

</body>
</html>