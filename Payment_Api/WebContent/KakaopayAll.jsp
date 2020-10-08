<%@page import="com.whatsup.dto.Member_BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
<%
		Member_BoardDto member_dto=(Member_BoardDto)session.getAttribute("login");
			if(member_dto==null){
				member_dto=new Member_BoardDto();
			}
%>


IMP.init('imp18787783');
IMP.request_pay({
    pg : 'kakao', // version 1.1.0부터 지원.
    pay_method : 'card', // 결제 방법 지정
    merchant_uid : 'merchant_' + new Date().getTime(),
    name : '주문명:결제테스트',
    amount : 30000,
    buyer_postcode :  '${dto.member_seq}' 
}, function(rsp) {
    if ( rsp.success ) {
        var msg = '결제가 완료되었습니다.';
        msg += '고유ID : ' + rsp.imp_uid;
        msg += '상점 거래ID : ' + rsp.merchant_uid;
        msg += '결제 금액 : ' + rsp.paid_amount;
        msg += '카드 승인번호 : ' + rsp.apply_num;
        
        location.href= "KakaopayController?command=kakaopayall01&member_seq=" + <%=member_dto.getMember_seq() %>
        
        
    } else {
        var msg = '결제에 실패하였습니다.';
        msg += '에러내용 : ' + rsp.error_msg;
    }
    alert(msg);
});
</script>
</head>
<body>

</body>
</html>