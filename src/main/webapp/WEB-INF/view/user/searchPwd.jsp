<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>비밀번호 찾기</title>
    <%@ include file="/WEB-INF/view/include/head.jsp" %>
    <!-- 
    <jsp:include page="/WEB-INF/view/include/head.jsp"/>
    <c:import url="/WEB-INF/view/include/head.jsp"/>
     -->
     <script>
     function searchPwd() {
    	 $.ajax({
    		 url:'searchPwd.do',
    		 data:{
    			 id:$("#id").val(),
    			 email:$("#email").val()
    		 },
    		 method:"post",
    		 success:function(res) {
    			 if (res.trim()=='ok') {
    				 alert('임시비밀번호를 이메일로 발송하였습니다. 이메일을 확인해 주세요');
    			 } else {
    				 alert('아이디/이메일이 올바르지 않습니다.');
    			 }
    		 }
    	 });
    	 return false;
     }
     </script>
</head>
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/view/include/top.jsp" %>
        <form action="" method="post" id="board1" name="board1" onsubmit="return searchPwd();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
            <div class="sub">
                <div class="size">
                    <h3 class="sub_title">비밀번호 찾기</h3>
                    
                    <div class="member">
                        <div class="box">
                            <fieldset class="login_form">
                                <ul>
                                    <li><input type="text" id="id" name="id" placeholder="아이디" ></li>
                                    <li><input type="text" id="email" name="email" placeholder="이메일"></li>
                                    <li></li>
                                </ul>
                                <div class="login_btn"><input type="submit" value="비밀번호 찾기" alt="비밀번호 찾기" /></div>
                            </fieldset>
                            <div class="btnSet clear">
                                <div>
                                    <a href="searchId.do" class="btn">아이디 찾기</a> 
                                    <a href="searchPwd.do" class="btn">비밀번호 찾기</a>
                                </div>
                            </div>
                        </div>
                    </div>
        
                </div>
            </div>
            </form>
        <%@ include file="/WEB-INF/view/include/bottom.jsp" %>
    </div>
</body>
</html>