<%@page import="com.whatsup.dto.Member_BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="css/admin.css" rel="stylesheet" type="text/css"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
<style type="text/css">

body {
	background-color: #fdde60;
	font-family: 'Do Hyeon', sans-serif;
}

h1 {
	position: absolute;
	left: 45%;
}
.admin{
    width: 90%;
    
}

#adminview {
    
    width: 50%;
    margin-top:60px;
    margin-bottom: 80px;
    margin-left: 100px;
    margin-right: 20px;
    }

#qnaboard {
    margin-top: 90px;
    margin-left:100px;
    width: 20%;
      
}

.button {
  background-color: #fdde60; 
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px; 
  transition-duration: 0.4s;
  cursor: pointer;
  
}

.button1 {
  border-radius: 12px;
  color: black; 
  font-family: 'Do Hyeon', sans-serif;
}

.button1:hover {
  color: white;
}

.button2 {
  border-radius: 12px;
  color: black; 
  font-family: 'Do Hyeon', sans-serif;
}

.button2:hover {
  color: white;
}


</style>
<%
	Member_BoardDto member_dto = (Member_BoardDto) session.getAttribute("login");
if (member_dto == null) {
	member_dto = new Member_BoardDto();
}
%>

</head>

<body>

<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">


	<%@include file="./format/header.jsp"%>
	

</script>
	<h1>관리자 페이지</h1>
	<article>
	<div class=admin>
		<div id="adminview">
			<h2>

				<button onclick="location.href='move.do?command=adminview'"
					class="button button1"><br/>
					회원 전체 조회<br/><i class="fas fa-address-book fa-8x"></i>
				</button>
			</h2>
		</div>

		<div id="qnaboard">
			<h2>

				<button onclick="location.href='move.do?command=qnaboard'"
					class="button button2"><br/>
					문의내역 전체 보기<br/><i class="far fa-question-circle fa-8x"></i>
				</button>
			</h2>
		</div>
	</div>
<!-- 	<div id="adminview"> -->
<!-- 		<h2> -->
<!-- 			가입자 조회<br /> -->
<!-- 			<button onclick="location.href='move.do?command=adminview'" class="button01">회원 전체 조회 </button> -->
<!-- 		</h2> -->
<!-- 	</div> -->

<!-- 	<div id="qnaboard"> -->
<!-- 		<h2> -->
<!-- 			문의게시판 관리<br /> -->
<!-- 			<button onclick="location.href='move.do?command=qnaboard&currentPage=1'" class="button02">문의내역 전체 보기</button> -->
<!-- 		</h2> -->
<!-- 	</div> -->
	</article>








	<!-- 관리자 채팅 -->
	<div class="template" style="display: none">
		<form>
			<!-- 메시지 텍스트 박스 -->
			<input type="text" class="message"
				onkeydown="if(event.keyCode === 13) return false;">
			<!-- 전송 버튼 -->
			<input value="Send" type="button" class="sendBtn">
		</form>
		<br />
		<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 -->
		<textarea rows="10" cols="50" class="console" disabled="disabled"></textarea>
	</div>

	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
		// 서버의 admin의 서블릿으로 웹 소켓을 한다.
		var webSocket = new WebSocket(
				"ws://localhost:8787/semi_project03/admin");
		// 운영자에서의 open, close, error는 의미가 없어서 형태만 선언
		webSocket.onopen = function(message) {
		};
		webSocket.onclose = function(message) {
		};
		webSocket.onerror = function(message) {
		};
		// 서버로 부터 메시지가 오면
		webSocket.onmessage = function(message) {
			// 메시지의 구조는 JSON 형태로 만들었다.
			let node = JSON.parse(message.data);
			// 메시지의 status는 유저의 접속 형태이다.
			// visit은 유저가 접속했을 때 알리는 메시지다.
			if (node.status === "visit") {
				// 위 템플릿 div를 취득한다.
				let form = $(".template").html();
				// div를 감싸고 속성 data-key에 unique키를 넣는다.
				form = $("<div class='float-left'></div>").attr("data-key",
						node.key).append(form);
				// body에 추가한다.
				$("body").append(form);
				// message는 유저가 메시지를 보낼 때 알려주는 메시지이다.
			} else if (node.status === "message") {
				// key로 해당 div영역을 찾는다.
				let $div = $("[data-key='" + node.key + "']");
				// console영역을 찾는다.
				let log = $div.find(".console").val();
				// 아래에 메시지를 추가한다.
				$div.find(".console").val(log +  + ":" + node.message + "\n");
				// bye는 유저가 접속을 끊었을 때 알려주는 메시지이다.
			} else if (node.status === "bye") {
				// 해당 키로 div를 찾아서 dom을 제거한다.
				$("[data-key='" + node.key + "']").remove();
			}
		};
		// 전송 버튼을 클릭하면 발생하는 이벤트
		$(document).on("click", ".sendBtn", function() {
			// div 태그를 찾는다.
			let $div = $(this).closest(".float-left");
			// 메시지 텍스트 박스를 찾아서 값을 취득한다.
			let message = $div.find(".message").val();
			// 유저 key를 취득한다.
			let key = $div.data("key");
			// console영역을 찾는다.
			let log = $div.find(".console").val();
			// 아래에 메시지를 추가한다.
			$div.find(".console").val(log + "(me) => " + message + "\n");
			// 텍스트 박스의 값을 초기화 한다.
			$div.find(".message").val("");
			// 웹소켓으로 메시지를 보낸다.
			webSocket.send(key + "#####" + message);
		});
		// 텍스트 박스에서 엔터키를 누르면
		$(document).on(
				"keydown",
				".message",
				function() {
					// keyCode 13은 엔터이다.
					if (event.keyCode === 13) {
						// 버튼을 클릭하는 트리거를 발생한다.
						$(this).closest(".float-left").find(".sendBtn")
								.trigger("click");
						// form에 의해 자동 submit을 막는다.
						return false;
					}
					return true;
				});
	</script>

	<%@include file="./format/footer.jsp"%>

</body>
</html>