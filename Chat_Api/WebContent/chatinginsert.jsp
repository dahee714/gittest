<%@page import="com.whatsup.dto.Member_BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
	Member_BoardDto member_dto=(Member_BoardDto)session.getAttribute("login");
	if(member_dto==null){
		member_dto=new Member_BoardDto();
	}
%>
</head>
<body>
	<form action="board.do" method="post">
		<input type="hidden" value="chatinginsert" name="command"/>
		<input type="hidden" value="<%=member_dto.getNickname() %>" name="chating_creator"/>
		<input type="text" name="chating_name"/><br/>
		<input type="submit" value="채팅방 생성"/>
		
	</form>
</body>
</html>