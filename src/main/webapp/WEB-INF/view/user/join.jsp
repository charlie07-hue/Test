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
    <script>
    	function goSave() {
    		var con = true;
    		
   			if ($('#id').val().trim()=='') {
   				alert('아이디를 입력해 주세요');
   				$('#id').focus();
   				return;
   			} else {
   				$.ajax({
   					url:'<%=request.getContextPath()%>/user/isDuplicateId.do',
   					data:{id:$('#id').val()},
   					async:false,
   					success : function(res) {
   						if (res.trim() == 'true') {
   							alert('중복된 아이디입니다. 다른 아이디를 입력해 주세요');
   							$('#id').val('');
   							$('#id').focus();
   							con = false;
   						}
   					}
   				});
   			}
   			if (con == false) return;
   			// 비밀번호 체크
   			// 이름
   			// 이메일
   			// 전화번호
    		if (confirm('가입하시겠습니까?')) {
    			//$('#frm').submit();
    			$.ajax({
    				url:'insertAjax.do',
    				data:$("#frm").serialize(),
    				method:'post',
    				success:function(res) {
    					if (res.trim() == 'true') {
    						alert('정상적으로 가입되었습니다.');
    						location.href='/project/sample/index.do';
    					} else {
    						alert('등록 실패');
    					}
    				}
    			});
    		}
    	}
    	$(function() {
    		$("#duplBtn").click(function() {
    			if ($('#id').val().trim()=='') {
    				alert('아이디를 입력해 주세요');
    				$('#id').focus();
    			} else {
    				$.ajax({
    					url:'<%=request.getContextPath()%>/user/isDuplicateId.do',
    					data:{id:$('#id').val()},
    					success : function(res) {
    						if (res.trim() == 'true') {
    							alert('중복된 아이디입니다. 다른 아이디를 입력해 주세요');
    							$('#id').val('');
    							$('#id').focus();
    						} else {
    							alert('사용 가능한 아이디입니다.');
    						}
    					}
    				});
    			}
    		})
    	});
    </script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function zipcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    //document.getElementById("sample6_extraAddress").value = extraAddr;
	                	addr += extraAddr;
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('zipcode').value = data.zonecode;
	                document.getElementById("addr1").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("addr2").focus();
	            }
	        }).open();
	    }
	</script>
</head>
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/view/include/top.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">회원가입</h3>
                <form name="frm" id="frm" action="insert.do" method="post" enctype="multipart/form-data">
                <table class="board_write">
                    <caption>회원가입</caption>
                    <colgroup>
                        <col width="20%" />
                        <col width="*" />
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>*아이디</th>
                            <td>
                                <input type="text" name="id" id="id" class="inNextBtn" style="float:left;">
                                <span class="email_check"><a href="javascript:;" id="duplBtn" class="btn bgGray" style="float:left; width:auto; clear:none;">중복확인</a></span>
                            </td>
                        </tr>
                        <tr>
                            <th>*비밀번호</th>
                            <td><input type="password" name="pwd" id="pwd" style="float:left;"> <span class="ptxt">비밀번호는 숫자, 영문 조합으로 8자 이상으로 입력해주세요.</span> </td>
                        </tr>
                        <tr>
                            <th>*비밀번호<span>확인</span></th>
                            <td><input type="password" name="pwd_check" id="pwd_check" style="float:left;"></td>
                        </tr>
                        <tr>
                            <th>*이름</th>
                            <td><input type="text" name="name" id="name" style="float:left;"> </td>
                        </tr>
                        <tr>
                            <th>*이메일</th>
                            <td>
                                <input type="text" name="email" id="email" class="inNextBtn" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th>연락처</th>
                            <td>
                                <input type="text" name="tel" id="tel" value=""  maxlength="15" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="3">주소</th>
                            <td>
                                <input type="text" name="zipcode" id="zipcode" value="" style="float:left;">
                                <span class="email_check"><a href="javascript:zipcode();" class="btn bgGray" style="float:left; width:auto; clear:none;">우편번호</a></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="addr1" id="addr1" value="" style="float:left;">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="text" name="addr2" id="addr2" value="" style="float:left;">
                            </td>
                        </tr>
                    </tbody>
                </table>
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