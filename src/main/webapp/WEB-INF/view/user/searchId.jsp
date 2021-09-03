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
    <title>아이디 찾기</title>
    <%@ include file="/WEB-INF/view/include/head.jsp" %>
    <!-- 
    <jsp:include page="/WEB-INF/view/include/head.jsp"/>
    <c:import url="/WEB-INF/view/include/head.jsp"/>
     -->
     <script>
     function searchId() {
    	 $.ajax({
    		 url:'searchId.do',
    		 method:'post',
    		 data:{
    			 name:$("#name").val(),
    			 email:$("#email").val()
    		 },
    		 success:function(res) {
    			 //console.log(res);
    			 if (res.trim()=='') {
    				 $("#msg").text('아이디가 존재하지 않습니다.');
    			 } else {
    				 $("#msg").text('아이디는 "'+res.trim()+'"입니다.');
    			 }
    		 }
    	 })
    	 
    	 return false;
     }
     </script>
</head>
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/view/include/top.jsp" %>
        <form action="" method="post" id="board1" name="board1" onsubmit="return searchId();"><!-- header에서 id="board"이미 사용중이라서 board2로 함 -->
            <div class="sub">
                <div class="size">
                    <h3 class="sub_title">아이디 찾기</h3>
                    
                    <div class="member">
                        <div class="box">
                            <fieldset class="login_form">
                                <ul>
                                    <li><input type="text" id="name" name="name" placeholder="이름" ></li>
                                    <li><input type="text" id="email" name="email" placeholder="이메일"></li>
                                    <li id="msg"></li>
                                </ul>
                                <div class="login_btn"><input type="submit" value="아이디 찾기" alt="아이디 찾기" /></div>
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