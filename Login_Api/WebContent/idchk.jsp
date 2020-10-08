<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
<script type="text/javascript">
onload=function(){
	var id = opener.document.getElementsByName("id")[0].value;
	document.getElementsByName("id")[0].value= id;
	
}
	function idConfirm(bool){
		if(bool==="true"){
			opener.document.getElementsByName("id")[0].title ="y";
			opener.document.getElementsByName("pw")[0].focus();
		}else{
			opener.document.getElementsByName("id")[0].focus();
		}
		self.close();
	}

</script>

<%String notUsed =request.getParameter("notUsed"); %>
</head>
<body>

	<table border ="1">
		<tr>
			<td><input type="text" name="id" readonly="readonly"/></td>
		</tr>	
		<tr>
			<td><%=notUsed.equals("true")?"생성가능":"중복된 유저 존재 "%></td>
		</tr>
		<tr>
			<td>
				<input type="button" value="확인" onclick="idConfirm('<%=notUsed%>');"/>
			</td>
		</tr>
	</table>


</body>
</html>