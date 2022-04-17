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

<table>
	<caption>
		<div>게시판 리스트</div>
		<div>Total : ${total }</div>
		<div>
			<form name="searchfrm" method="post" action="boardList.do">
				<select name="searchGubun" id="searchGubun">
					<option value="title">제목</option>
					<option value="name">글쓴이</option>
					<option value="content">내용</option>
				</select>
				<input type="text" name="searchText" id="searchText">
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

<div style="width:600px;margin-top:5px;text-align:center;">
	<c:forEach var="i" begin="1" end="${totalPage }">
			<a href="boardList.do?viewPage=${i }"> ${i }</a> 
	</c:forEach>
</div>
<div style="width:600px;margin-top:5px;text-align:right;">
	<button type="button" onclick="location='boardWrite.do'">글쓰기</button>
</div>






</body>
</html>