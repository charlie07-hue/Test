<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
				<table class="list">
                    <p><span><strong>총 ${commentVo.totCount }개</strong>  |  ${commentVo.reqPage}/${commentVo.totPage }페이지</span></p>
                        <caption>게시판 목록</caption>
                        <colgroup>
                            <col width="*" />
                            <col width="100px" />
                            <col width="100px" />
                        </colgroup>
                        <tbody>
						<c:if test="${empty list }">
                            <tr>
                                <td class="first" colspan="5">등록된 댓글이 없습니다.</td>
                            </tr>
                        </c:if>
                        <c:forEach var="vo" items="${list }">     
                            <tr>
                                <td class="txt_l">
                                    ${vo.content}
                                    <c:if test="${userInfo.no == vo.user_no}">
                                    <a href="javascript:commentDel(${vo.no});">[X]</a>
                                    </c:if>
                                </td>
                                <td class="writer">
                                    ${vo.name }
                                </td>
                                <td class="date"><fmt:formatDate value="${vo.regdate }" pattern="yyyy-MM-dd"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="pagenate clear">
                        <ul class='paging'>
                        <c:if test="${commentVo.startPage > commentVo.pageRange}">
                        	<li><a href="javascript:getComment(${commentVo.startPage-1 })"><</a></li>
                        </c:if>
                        <c:forEach var="rp" begin="${commentVo.startPage}" end="${commentVo.endPage }">
                            <li><a href='javascript:getComment(${rp})' <c:if test="${rp==commentVo.reqPage }">class='current'</c:if>>${rp }</a></li>
                        </c:forEach>
                        <c:if test="${commentVo.totPage > commentVo.endPage}">
                        	<li><a href="javascript:getComment(${commentVo.endPage+1 })">></a></li>
                        </c:if>
                        </ul> 
                    </div>