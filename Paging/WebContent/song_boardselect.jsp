<%@page import="com.whatsup.dto.CommentDto"%>
<%@page import="java.util.List"%>
<%@page import="com.whatsup.dto.Member_BoardDto"%>
<%@page import="com.whatsup.dto.Song_BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.0/css/all.css" integrity="sha384-OLYO0LymqQ+uHXELyx93kblK5YIS3B2ZfLGBmsJaUyor7CpMTBsahDHByqSuWW+q" crossorigin="anonymous">
<style>
	table {width:80%; line-height: 50px; margin : 50px 0px 50px 50px;}
	#content{padding: 30px 20px 100px; background-color: #e9ecef;}
	.line{display: inline-block;}
  
</style>
<%
	Song_BoardDto song_dto=(Song_BoardDto)request.getAttribute("dto");
	Member_BoardDto member_dto=(Member_BoardDto)session.getAttribute("login");
	List<CommentDto> comment_list = (List<CommentDto>)request.getAttribute("comment_list");
	if(member_dto==null){
		member_dto=new Member_BoardDto();
	}
%>
<script type="text/javascript">
	function commentinsert(){
		if(<%=member_dto.getNickname()==null%>){
			alert("먼저 로그인을 해주세요.");
			return false;
		}
	}
</script>
</head>
<body style="    background-color: #fdde60;">
<h1><i class="fas fa-arrow-circle-right"></i>노래게시판</h1>
	<table>
		<tr>
			<th>이름</th>
			<td><input class="form-control form-control-lg"  type="text" name="myname" value="<%=song_dto.getNickname() %>" readonly="readonly" /></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input  class="form-control form-control-lg"  type="text" name="mytitle" value="<%=song_dto.getSong_title()%>" readonly="readonly" /></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><input class="form-control form-control-lg"  type="text" name="mytitle" value="<%=song_dto.getSong_cnt()%>" readonly="readonly" /></td>
		</tr>
		<tr>
			<th>내용</th>
			<td id ="content"><%=song_dto.getSong_content() %></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			<%
			if(member_dto.getNickname().equals(song_dto.getNickname())&& member_dto.getNickname()!=null){
			%>		
				<input class="btn btn-warning"  type="button" value="수정" onclick="location.href='move.do?command=songupdatepage&song_no=<%=song_dto.getSong_no()%>'"/>
				
				<form class="line" action="board.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="command" value="song_delete"/>
					<input type="hidden" name="song_no" value="<%=song_dto.getSong_no()%>">
					<input class="btn btn-warning"  type="submit" value="삭제"/>
				</form>
			<%		
				}
			%>
				<input type="button" value="목록" onclick="location.href='move.do?command=songboard&currentPage=1'"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				--------------댓글--------------
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>댓글내용</td>
		</tr>
<%
		if(comment_list.size()==0){
			
		}else{
			for(int i=0;i<comment_list.size();i++){
%>
		<tr>
			<td><%=comment_list.get(i).getNickname() %></td>
			<td><%=comment_list.get(i).getComment_content() %>
<%
			if(member_dto.getNickname().equals(song_dto.getNickname())&& member_dto.getNickname()!=null){
%>	
				<form class="line" action="board.do" method="post" enctype="multipart/form-data">
					<input type="hidden" name="command" value="song_comment_delete"/>
					<input type="hidden" name="song_no" value="<%=song_dto.getSong_no()%>">
					<input type="hidden" name="comment_no" value="<%=comment_list.get(i).getComment_no()%>">
					<input type="submit" value="삭제"/>
				</form>
<%	
			}
%>
			</td>
		</tr>
		
<%
			}
		}
%>
	</table>
	<form action="board.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="command" value="song_comment_insert"/>
		<input type="hidden" name="member_seq" value="<%=member_dto.getMember_seq()%>">
		<input type="hidden" name="song_no" value="<%=song_dto.getSong_no()%>"/>
		<input type="text" name="comment_content"/>
		<input type="submit" value="댓글작성" onclick="commentinsert()"/>
	</form>
</body>
</html>