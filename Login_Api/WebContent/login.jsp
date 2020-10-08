<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="google-signin-scope" content="profile">
<meta name="google-signin-client_id" content="910896443172-llnq01i6rrc8hlgruf3sm3c40bqhvvp4.apps.googleusercontent.com">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
</body>

   
<style>
*{
	margin : 0;
	padding : 0;
	text-decoration: none;
	font-family: montserrat;
	box-sizing :border-box;
	
}

body {
	min-height: 100vh;
	background-image: linear-gradient(45deg,#e66465,yellow);
}

form{
	width : 360px;
	background:  #f1f1f1;
	height: 580px;
	padding :80px 40px;
	border-radius: 10px;
	position : absolute;
	text-align:center;
	left:50%;
	top:50%;
	transform :translate(-50%,-50%); 
}

form  h1{
text-align : center;
margin-bottom :30px;
}
.textb{
  border-bottom: 2px solid #adadad;
  position: relative;
  margin: 30px 0;
}


.textb input{
  font-size: 15px;
  color: #333;
  border: none;
  width: 100%;
  outline: none;
  background: none;
  padding: 0 5px;
  height: 40px;
}

.textb span::before{
  content: attr(data-placeholder);
  position: absolute;
  top: 50%;
  left: 5px;
  color: #adadad;
  transform: translateY(-50%);
  z-index: -1;
  transition: .5s;
}


td.snsbtn {
	margin : 40px 0px;
}
.focus+span::before{
  top: -5px;
}
.focus+span::after{
  width: 100%;
}

.logbtn{
  display: block;
  width: 100%;
  height: 50px;
  border: none;
  background: linear-gradient(120deg,green,yellow,red);
  background-size: 200%;
  color: #fff;
  outline: none;
  cursor: pointer;
  transition: .5s;
}

.logbtn:hover{
  background-position: right;
}
b{color:red;}

</style>

</head>
<body>
 <%
    String clientId = "bGlgaATXhrDCX6ib_fDu";//애플리케이션 클라이언트 아이디값";
    String redirectURI = URLEncoder.encode("http://localhost:8787/semi_project03/member.do?command=naverlogin", "UTF-8");
    SecureRandom random = new SecureRandom();
    String state = new BigInteger(130, random).toString();
    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
    apiURL += "&client_id=" + clientId;
    apiURL += "&redirect_uri=" + redirectURI;
    apiURL += "&state=" + state;
    session.setAttribute("state", state);
    String redirect = URLEncoder.encode("http://localhost:8787/semi_project03/member.do?command=googlelogin", "UTF-8");
 %>
 
 
<div id="input">


<form action="member.do" method="post">
	<a href="index.jsp"><img alt="로고" src="resources/logo.png" style="width:200px; height:40px;"></a>
	<h1>로그인</h1>
		<input type="hidden" name="command" value="login"/>
	
	

		
		<div class="textb">
          <input type="text" name="id">
          <span data-placeholder="아이디"></span>
        </div>

        <div class="textb">
          <input type="password" name="pw">
          <span data-placeholder="비밀번호"></span>
        </div>
        <table >
		<tr>
			
			<td colspan="2" class="err" style="padding:10px 0px;"> </td>
		</tr>
		
		<tr>
			<td colspan="2"><button type="submit" class="logbtn" >로그인</button></td>
			
		</tr>
		<tr>
		
 			<td colspan="2" class="snsbtn"><a href="<%=apiURL%>"><img height="50" width="300" src="resources/naver.png"/></a></td>
		</tr>
		<tr>
		<td colspan="2"  class="snsbtn"><div id="my-signin2"></div></td>
 			
		</tr>
		
		
		
		<tr>
			
			<td colspan="2" style="text-align:center; margin-top:10px;"> <a href="findidpw.jsp">아이디 패스워드 찾기</a> | <a href="register.jsp">회원가입</a></td>
		</tr>
		
	</table>
</form>
</div>
<script>
      $(".textb input").on("focus",function(){
        $(this).addClass("focus");
      });

      $(".textb input").on("blur",function(){
        if($(this).val() == "")
        $(this).removeClass("focus");
      });

</script>
<script>
function onSuccess(googleUser) {

	

	var id_token = googleUser.getAuthResponse().id_token;
   
	var redirectUrl = 'member.do?command=googlelogin';

    //using jquery to post data dynamically
    var form = $('<form action="' + redirectUrl + '" method="post">' +
                     '<input type="hidden" name="id_token" value="' +
                      googleUser.getAuthResponse().id_token + '" />'+
                                                           '</form>');
    $('body').append(form);
    form.submit();
    console.log(form);
  }
  function onFailure(error) {
    console.log(error);
  }
  
    function renderButton() {
      gapi.signin2.render('my-signin2', {
        'scope': 'profile email',
        'width': 300,
        'height': 50,
        'longtitle': true,
        'theme': 'dark',
        'onsuccess': onSuccess,
        'onfailure': onFailure
      });
    }
  
  </script>
	
	
	  <script type="text/javascript">
   		<%
   			String error = (String)request.getAttribute("err");
   			if(error==null){
 					error = "";
   			}else{
   		%>
			const error = "<b><%=error%></b>"
			const dom = document.getElementsByClassName('err')[0];
   			dom.innerHTML = error;
   			   		
   		<%
   			}
   		%>
  	</script>
</body>
</html>