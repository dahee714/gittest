<%@page import="com.whatsup.dto.Member_BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="resources/kakaopay.css" rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<%
	Member_BoardDto dto = (Member_BoardDto)request.getAttribute("test");

%>


<script type="text/javascript">
	
	window.onload = function(){
		if(<%=dto != null%>){
			var con_test = confirm("결제를 계속 진행 하시겠습니까?");
			if(con_test == true){
				document.body();				
			}else if(con_test == false){
				self.close(); 
				location.href='index.jsp'; 
			}
			
		}
	}
	
		
	//체크박스를 radio처럼 
	function Checkbox(chk) {
		var check = false;
		var obj = document.getElementsByClassName("ch");
		
		for (var i = 0; i < obj.length; i++) {
			if (obj[i] != chk) {
				obj[i].checked = false;
			}
		}
		
	}
	
	function check01(){
		if (!$("input:checked[id='ch01']").is(":checked")){ alert("체크해 주세요!"); $("#ch").focus(); return; }
			
		
	}
	

	/*
	if (!$("input:checked[id='box1']").is(":checked")){ alert("에러문구를 표시"); $("#box1").focus(); return; }

	
	
	*/
	// 어려웅....
	//하나도 체크 안했을때 (JQ 4번 select04확인 )
	/*$("#confirm").click(function(){
				if($("input[class=ch]:checked").length == 0){
					alert("하나 이상 체크해 주세요!!!");
		} else {
			
		}
	}*/
</script>
</head>
<body>

	<!-- #fdde60 -->
	<h1><p>정회원이 되고 더 많은 혜택을 누리자!!</p></h1>
	
	<form action="KakaopayController" method="post" id = payment>
		<input type="hidden" name="command" value="Kakaopay" />
		 <input type="checkbox" class="ch" id="ch01" name="planA" value="PLAN A (노래방)" onclick="Checkbox(this); " />
		 <label for="ch01" id="plana">PLAN A (노래방)</label>
		 <br/> <br/> 
		 <input type="checkbox" class="ch" id="ch02" name="planB" value="PLAN B(노래방 & 춤)" onclick="Checkbox(this);" />
		 <label for="ch02" id="planb">PLAN B(노래방 & 춤)</label>
		 <br/> <br/> 
		 <input type="submit" value="" onclick="check01" id="confirm" style="background-image: url('resources/img/payment_icon_yellow_medium.png'); border: 0px; width: 120px; height: 50px; background-color: white; outline: 0; cursor: pointer; position: absolute; top:100px; left: 150px;" />
	
	</form>
	
<!-- border: 1px solid black;
	box-sizing: border-box;
	width: 300px;
	height: 320px;
	text-align: center;
	margin-left: auto;
	margin-right: auto;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	 -->

</body>
</html>