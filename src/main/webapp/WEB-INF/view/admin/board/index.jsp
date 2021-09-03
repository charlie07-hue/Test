<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ include file="/WEB-INF/view/admin/include/headHtml.jsp" %>
<script>
function groupDel(name) {
	//console.log($('input[name="no"]'));
	var count=0;
	for (var i=0; i<$('input[name="'+name+'"]').length; i++) {
		//console.log(i);
		//console.log($('input[name="no"]').eq(i).prop('checked'));
		if ($('input[name="'+name+'"]').eq(i).prop('checked')) {
			count++;
			break;
		}
	}
	if (count == 0) {
		alert('하나 이상 체크해 주세요');
	} else {
		if (confirm('삭제하시겠습니까?')) {
			$("#frm").submit();
		}
	}
}
function check() {
	//console.log($("#allChk").prop('checked'));
	if ($("#allChk").prop('checked')) {
		for (var i=0; i<$('input[name="no"]').length; i++) {
			$('input[name="no"]').eq(i).prop('checked','checked');
		}
	} else {
		for (var i=0; i<$('input[name="no"]').length; i++) {
			$('input[name="no"]').eq(i).prop('checked','');
		}
	}
}
</script>
</head>
<body> 
<div id="wrap">
	<!-- canvas -->
	<div id="canvas">
		<!-- S T A R T :: headerArea-->
		<%@ include file="/WEB-INF/view/admin/include/top.jsp" %>
		<!-- E N D :: headerArea--> 
		
		<!-- S T A R T :: containerArea-->
		<div id="container">
			<div id="content">
				<div class="con_tit">
					<h2>공지사항 - [목록]</h2>
				</div>
				<!-- //con_tit -->
				<div class="con">
					<!-- 내용 : s -->
					<div id="bbs">
						<div id="blist">
							<p><span><strong>총 ${boardVo.totCount }개</strong>  |  ${boardVo.reqPage}/${boardVo.totPage }페이지</span></p>
							<form name="frm" id="frm" action="groupDelete2.do" method="post">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" summary="관리자 관리목록입니다.">
								<colgroup>
									<col class="w3" />
									<col class="w4" />
									<col class="" />
									<col class="w10" />
									<col class="w5" />
									<col class="w6" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="first"><input type="checkbox" name="allChk" id="allChk" onClick="check()"/></th>
										<th scope="col">번호</th>
										<th scope="col">제목</th> 
										<th scope="col">작성일</th> 
										<th scope="col">작성자</th> 
										<th scope="col" class="last">조회수</th>
									</tr>
								</thead>
								<tbody>
								<c:if test="${empty list }">
		                            <tr>
		                                <td class="first" colspan="6">등록된 글이 없습니다.</td>
		                            </tr>
		                        </c:if>
		                        <c:forEach var="vo" items="${list }" varStatus="status">
		                            <tr>
		                            	<td class="first"><input type="checkbox" name="nos" value="${vo.no}"/></td>
		                                <td>${(boardVo.totCount-status.index)-((boardVo.reqPage-1)*boardVo.pageRow)}</td>
		                                <td class="title">
		                                    <a href="detail.do?no=${vo.no }&reqPage=${boardVo.reqPage}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">${vo.title } [${vo.comment_count}]</a>
		                                </td>
		                                <td class="date"><fmt:formatDate value="${vo.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                                <td class="writer">
		                                    ${vo.name }
		                                </td>
		                                <td class="last">${vo.readcount }</td>
		                            </tr>
		                        </c:forEach>
								</tbody>
							</table>
							</form>
							<div class="btn">
								<div class="btnLeft">
									<a class="btns" href="#" onclick="groupDel('nos');"><strong>삭제</strong> </a>
								</div>
								<div class="btnRight">
									<a class="wbtn" href="write.do"><strong>등록</strong> </a>
								</div>
							</div>
							<!--//btn-->
							<!-- 페이징 처리 -->
							<div class='page'>
								<c:if test="${boardVo.startPage > boardVo.pageRange}">
		                        	<a href="index.do?reqPage=${boardVo.startPage-1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}"><</a>
		                        </c:if>
		                        <c:forEach var="rp" begin="${boardVo.startPage}" end="${boardVo.endPage }">
		                        	<c:if test="${rp==boardVo.reqPage }">
		                        		<strong>${boardVo.reqPage}</strong>
		                        	</c:if>
		                        	<c:if test="${rp!=boardVo.reqPage }">
		                            <a href='index.do?reqPage=${rp}&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}' >${rp }</a>
		                            </c:if>
		                        </c:forEach>
		                        <c:if test="${boardVo.totPage > boardVo.endPage}">
		                        	<a href="index.do?reqPage=${boardVo.endPage+1 }&stype=${param.stype}&sval=${param.sval}&orderby=${param.orderby}&direct=${param.direct}">></a>
		                        </c:if>
							</div>
							<!-- //페이징 처리 -->
							<form name="searchForm" id="searchForm" action="index.do"  method="get">
								<div class="search">
									<select name="stype" title="검색을 선택해주세요">
										<option value="all">전체</option>
										<option value="title" <c:if test="${param.stype=='title'}">selected</c:if>>제목</option>
                                    	<option value="content" <c:if test="${param.stype=='content'}">selected</c:if>>내용</option>
									</select>
									<input type="text" name="sval" value="${param.sval}" title="검색할 내용을 입력해주세요" />
									<input type="image" src="<%=request.getContextPath()%>/img/admin/btn_search.gif" class="sbtn" alt="검색" />
								</div>
							</form>
							<!-- //search --> 
						</div>
						<!-- //blist -->
					</div>
					<!-- //bbs --> 
					<!-- 내용 : e -->
				</div>
				<!--//con -->
			</div>
			<!--//content -->
		</div>
		<!--//container --> 
		<!-- E N D :: containerArea-->
	</div>
	<!--//canvas -->
</div>
<!--//wrap -->

</body>
</html>