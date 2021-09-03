<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, user-scalable=yes">
    <meta name="format-detection" content="telephone=no, address=no, email=no">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <title>게시판목록</title>
    <%@ include file="/WEB-INF/view/include/head.jsp" %>
    <script>
    function move() {
    	<c:if test="${!empty userInfo}">
    	location.href='write.do';
    	</c:if>
    	<c:if test="${empty userInfo}">
    	alert('로그인 후 사용가능합니다.');
    	</c:if>
    }
    </script>
</head>
<body>
    <div class="wrap">
        <%@ include file="/WEB-INF/view/include/top.jsp" %>
        <div class="sub">
            <div class="size">
                <h3 class="sub_title">게시판</h3>
    
                <div class="bbs">
                    <table class="list">
                    <p><span><strong>총 ${replyVo.totCount }개</strong>  |  ${replyVo.reqPage}/${replyVo.totPage }페이지</span></p>
                        <caption>게시판 목록</caption>
                        <colgroup>
                            <col width="80px" />
                            <col width="*" />
                            <col width="100px" />
                            <col width="200px" />
                            <col width="80px" />
                        </colgroup>
                        <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>조회수</th>
                            </tr>
                        </thead>
                        <tbody>
						<c:if test="${empty list }">
                            <tr>
                                <td class="first" colspan="5">등록된 글이 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="vo" items="${list }" varStatus="status">     
                            <tr>
                                <td>${(replyVo.totCount-status.index)-((replyVo.reqPage-1)*replyVo.pageRow)}</td>
                                <td class="txt_l">
                                    <a href="detail.do?no=${vo.no }&reqPage=${replyVo.reqPage}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">
                                    <c:forEach begin="1" end="${vo.nested}">&nbsp;&nbsp;&nbsp;</c:forEach>
                                    <c:if test="${vo.nested > 0}"><img src="/project/img/admin/answer_icon.gif"></c:if>
                                    	${vo.title } [${vo.comment_count}]
                                    </a>
                                </td>
                                <td class="writer">
                                    ${vo.name }
                                </td>
                                <td class="date"><fmt:formatDate value="${vo.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td>${vo.readcount }</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="btnSet"  style="text-align:right;">
                        <a class="btn" href="javascript:move();">글작성 </a>
                    </div>
                    <div class="pagenate clear">
                        <ul class='paging'>
                        <c:if test="${replyVo.startPage > replyVo.pageRange}">
                        	<li><a href="index.do?reqPage=${replyVo.startPage-1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}"><</a></li>
                        </c:if>
                        <c:forEach var="rp" begin="${replyVo.startPage}" end="${replyVo.endPage }">
                            <li><a href='index.do?reqPage=${rp}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}' <c:if test="${rp==replyVo.reqPage }">class='current'</c:if>>${rp }</a></li>
                        </c:forEach>
                        <c:if test="${replyVo.totPage > replyVo.endPage}">
                        	<li><a href="index.do?reqPage=${replyVo.endPage+1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">></a></li>
                        </c:if>
                        </ul> 
                    </div>
                
                    <!-- 페이지처리 -->
                    <div class="bbsSearch">
                        <form method="get" name="searchForm" id="searchForm" action="">
                            <span class="srchSelect">
                                <select id="stype" name="stype" class="dSelect" title="검색분류 선택">
                                    <option value="all">전체</option>
                                    <option value="title" <c:if test="${param.stype=='title'}">selected</c:if>>제목</option>
                                    <option value="content" <c:if test="${param.stype=='content'}">selected</c:if>>내용</option>
                                </select>
                            </span>
                            <span class="searchWord">
                                <input type="text" id="sval" name="sval" value="${param.sval }"  title="검색어 입력">
                                <input type="button" id="" value="검색" title="검색" onclick="$('#searchForm').submit();">
                            </span>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="/WEB-INF/view/include/bottom.jsp" %>
    </div>
</body>
</html>