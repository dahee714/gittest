<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#container{
	width : 800px;
	background:  #f1f1f1;
	height: 400px;
	padding :80px  40px 150px 40px;
	border-radius: 10px;
	position : absolute;
	text-align:center;
	left:50%;
	top:50%;
	transform :translate(-50%,-50%); 
	line-height: 40px;
}
form#findid{
	
	padding :80px 40px;
	border-radius: 10px;
	position : absolute;
	width:30%;
	top:26%;


	line-height: 40px;}


form#findpw{
	
	padding :80px 40px;
	border-radius: 10px;
	position : absolute;
	width:30%;
	left:55%;
	top:26%;


	line-height: 40px;}


table {
	padding : 0 0 50px 0;
}
.regbtn{
  display: block;
  width: 50%;
  height: 50px;
  border: none;
  background-color: darkorange;
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
  border-radius: 15px;
  margin-top: 10px;
}
.regbtn:hover{ background-color: red;}
</style>
</head>

<body style="background-color: #fdde60">
<div id="container">
<h1>아이디 비밀 번호 찾기</h1>
<form id="findid" action="member.do" method="post">
<input type="hidden" name="command" value="findid"/>
	<table>
		<tr>
			<td colspan="2"> ID 찾기 </td>
		</tr>
		<tr>
			<td>이름</td>
			<td> <input type="text" name ="name" /></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email"name ="email"/></td>
		</tr>
		
		<tr>
			<td colspan = "2" align="center"> <button type="submit" class="regbtn findidbtn">ID 찾기</button> </td>
		</tr>
		<tr>
			<td colspan = "2" class="showid"> </td>
		</tr>
	</table>
	
</form>


<hr/>


<form id="findpw" action="member.do" method="post">
<input type="hidden" name="command" value="findpw"/>
	<table>
		<tr>
			<td colspan="2"> 비밀번호 찾기 </td>
		</tr>
		<tr>
			<td>이름</td>
			<td> <input type="text" name ="name" /></td>
		</tr>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="id"/></td>
		</tr>
		<tr>
			<td>이메일</td>
			<td><input type="email"name ="email"/></td>
		</tr>
		
		<tr>
			<td colspan = "2" align ="center"> <button class="regbtn" type="submit">비밀번호 찾기</button> </td>
		</tr>
		<tr>
			<td colspan="2" class="showpw"></td>
		</tr>
	</table>
	
</form>
</div>
<script type="text/javascript">
	<%
		String err = (String)request.getAttribute("err");
		String msg = (String)request.getAttribute("msg");
		String errpw=(String)request.getAttribute("errpw");
		String msgpw = (String)request.getAttribute("msgpw");
		
		if(err!=null&&msg ==null){
	%>
	document.getElementsByClassName('showid')[0].textContent = "<%=err%>";
	<%
		}else if(msg != null){
	%>
		document.getElementsByClassName('showid')[0].textContent = "<%=msg%>";
	<%		
		}else if(errpw!=null&&msgpw ==null){
	%>
		document.getElementsByClassName('showpw')[0].textContent = "<%=errpw%>";
	<%
		}else if(msgpw != null){
	%>
		document.getElementsByClassName('showpw')[0].textContent = "<%=msgpw%>";
	<%		
		}
	%>

	

</script>
</body>
</html>