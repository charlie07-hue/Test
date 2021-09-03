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
    <title>게시판 상세</title>
    <%@ include file="/WEB-INF/view/include/head.jsp" %>
</head>
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/view/include/top.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">게시판</h3>
                <div class="bbs">
                    <div class="view">
                        <div class="title">
                            <dl>
                                <dt>${vo.title }</dt>
                                <dd class="date">작성일 : ${vo.regdate } </dd>
                            </dl>
                        </div>
                        <div class="cont">${vo.content } </div>
                        <dl class="file">
                            <dt>첨부파일 </dt>
                            <dd>
                            <a href="/project/common/download.jsp?path=/upload/&org=${vo.filename_org}&real=${vo.filename_real}" 
                            target="_blank">${vo.filename_org }</a></dd>
                        </dl>
                                    
                        <div class="btnSet clear">
                            <div class="fl_l"><a href="index.do?<c:if test="${!empty param.reqPage}">reqPage=${param.reqPage}</c:if>&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}" class="btn">목록으로</a></div>
                            <c:if test="${userInfo.no == vo.user_no}">
                            <div class="fl_l"><a href="edit.do?no=${vo.no}" class="btn">수정</a></div>
                            <div class="fl_l"><a href="javascript:isDel();" class="btn">삭제</a></div>
                            </c:if>
                        </div>
                
                    </div>
                    
                    <table class="board_write">
                    	<colgroup>
                            <col width="*" />
                            <col width="80px" />
                        </colgroup>
                        <tbody>
                        <tr>
                            <td>
                                <textarea name="content" id="content" style="width:100%;height:80px;"></textarea>
                            </td>
                            <td>
                            	<div class="btnSet"  style="text-align:right;">
			                        <a class="btn" href="javascript:goSave();">저장 </a>
			                    </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <script>
                    	function goSave() {
                    		<c:if test="${!empty userInfo}">
                    		if ($("#content").val().trim()=='') {
                    			alert('내용을 입력해 주세요');
                    		} else {
                    			if (confirm('댓글을 등록하시겠습니까?')) {
                    				$.ajax({
                            			url:'/project/comment/insert.do',
                            			data:{
                            				content:$("#content").val(),
                            				board_no:${vo.no},
                            				user_no:${userInfo.no}
                            			},
                            			success:function(res) {
                            				if (res.trim()=='true') {
                            					alert('댓글이 등록되었습니다.');
                            					$("#content").val("");
                            					getComment(1);
                            				} else {
                            					alert('댓글 등록 실패');
                            				}
                            			}
                            		});
                    			}
                    		}
                    		</c:if>
                    		<c:if test="${empty userInfo}">
                    			alert('댓글은 로그인 후 등록가능합니다.');
                    		</c:if>
                    	}
                    	$(function(){
                    		getComment(1);
                    	});
                    	function getComment(reqPage) {
                    		$.ajax({
                    			url:'/project/comment/list.do',
                    			data:{
                    				board_no:${vo.no},
                    				reqPage:reqPage
                    			},
                    			success:function(res) {
                    				$("#commentArea").html(res);
                    			}
                    		})
                    	}
                    	function commentDel(no) {
                    		if (confirm('댓글을 삭제하시겠습니까?')) {
	                    		$.ajax({
	                    			url:'/project/comment/delete.do',
	                    			data:{
	                    				no:no
	                    			},
	                    			success:function(res) {
	                    				if (res.trim()=='true') {
		                    				alert('댓글이 삭제되었습니다.');
		                    				getComment(1);
	                    				} else {
	                    					alert('댓글 삭제 오류');
	                    				}
	                    			}
	                    		});
                    		}
                    	}
                    </script>
                    <div id="commentArea"></div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/view/include/bottom.jsp" %>
    </div>
    <script>
    	function isDel() {
    		if (confirm('삭제하시겠습니까?')) {
    			// 삭제처리
    			$.ajax({
    				url:'delete.do',
    				data:{
    					'no':${vo.no}
    				},
    				method:'post',
    				success:function(res) {
    					console.log(res);
    					if (res.trim() == 'true') {
    						alert('정상적으로 삭제되었습니다.');
    						location.href='index.do';
    					} else {
    						alert('삭제 실패');
    					}
    				},
    				error : function(res) {
    					console.log(res);
    				}
    			});
    		}
    	}
    </script>
</body>
</html>