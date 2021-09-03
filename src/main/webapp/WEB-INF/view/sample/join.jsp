<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>회원가입</title>
    <%@ include file="/WEB-INF/view/include/head.jsp" %>
</head>
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/view/include/top.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">회원가입</h3>
                <form name="frm" id="frm" action="process.do" method="post" enctype="multipart/form-data">
                <table class="board_write">
                    <caption>회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>*이메일</th>
                            <td>
                                <input type="text" name="email" id="email" class="inNextBtn" style="float:left;">
                                <span class="email_check"><a href="javascript:;"  class="btn bgGray" style="float:left; width:auto; clear:none;">중복확인</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="pw" id="pw" style="float:left;"> <span class="ptxt">비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.</span> </td>
                        </tr>
                        <tr>
                            <th>*비밀번호<span>확인</span></th>
                            <td><input type="password" name="pw_check" id="pw_check" style="float:left;"></td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td><input type="text" name="name" id="name" style="float:left;"> </td>
                        </tr>
                        <tr>
                            <th>*성별</th>
                            <td>
                            <select name="gender" id="gender">
                            <option value="1">남성</option>
                            <option value="2">여성</option>
                            </select> 
                            </td>
                        </tr>
                        <tr>
                            <th>*생년월일</th>
                            <td><input type="text" name="birth" id="birth" style="float:left;"> </td>
                        </tr>
                        <tr>
                            <th>*휴대폰 번호</th>
                            <td>
                                <input type="text" name="hp" id="hp" value=""  maxlength="15" style="float:left;">
                            </td>
                        </tr>
                    </tbody>
                </table>
                        <input type="hidden" name="cmd" value="write.do"/>
                        <input type="hidden" name="checkEmail" id="checkEmail" value="0"/>
                </form>
                <!-- //write--->
                <div class="btnSet clear">
                    <div><a href="javascript:;" class="btn" onclick="goSave();">가입</a> <a href="javascript:;" class="btn" onclick="history.back();">취소</a></div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/view/include/bottom.jsp" %>
    </div>
</body>
</html>