<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!--  파일 업로드 -->
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>

<%
	Date nowDate = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시글 상세 페이지</title>
		<script src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
		<link href="<c:url value='/css/board/board.css'/>" rel="stylesheet" type="text/css">	
		<script src="<c:url value='/js/mainBanner.js'/>"></script>
		<script src="<c:url value='/js/commentForm.js'/>"></script>
		
	    <link href="<c:url value='/css/mainBanner.css'/>" rel="stylesheet" type="text/css">	
	</head>
	
	<style>
		.container {
	    width: fit-content; /* 태그의 넓이를 500px로 */
		margin:0 auto; /* 양쪽 여백을 위아래는 0 좌우는 자동으로 잡아주겠다! */
		margin-top : 40px;
		}
		
		td > textarea {
		    height: 450px;
    width: 600px;
    border-color: #cfe2f6;
    background: #cfe2f6;
    color: #3f63b5;
    font-size: 16px;
    border: none;
    resize: none;
    border:1px soild #cfe2f6;
    outline:none;
    
    
		}
		
	.commentText {
	    height: 85px;
	    width: 500px;
	    float: right;
	}
	
		#button2{
	    background: #f2f9fb;
    color: #3f63b5;
    border-color: #f2f9fb;
    height: 38px;
    width: 70px;
    border-radius: 10px;
    font-size: 15px;
    
    float: right;
    margin-right: 127px;
    
		
		
	</style>
	
	
	<body>
		<div id="wrap">
			
			<!-- TOP -->
			<jsp:include page="/WEB-INF/views/layout/top.jsp" flush='true' />
			<div id="navMargin"></div>
			
			<section id="section">
	
	<br>
		<!-- 게시판 글 보기 양식 영역 시작 -->
	<div class="container">
		<div class="row">
			<table class="table table-stripedDetail">
				<thead>
					<tr>
						<th width=600px; colspan="3" style="background-color: #f2f9fb; text-align: center; font-size:25px;">알약요
						<c:if test="${board.boardCtgNo eq '0'}">소식</c:if>
						<c:if test="${board.boardCtgNo eq '1'}">카드뉴스</c:if>
						<c:if test="${board.boardCtgNo eq '2'}">주문/결제</c:if>
						<c:if test="${board.boardCtgNo eq '3'}">교환/반품</c:if>
						<c:if test="${board.boardCtgNo eq '4'}">제품</c:if>
						<c:if test="${board.boardCtgNo eq '5'}">회원</c:if>
						Q&A
						</th>
						
					</tr>
					<tr>
					</tr>
					<tr>
					<th style="width:90px;">분류</th>
					<th style="width:470px;">제목</th>
					<!-- <th style="background-color: #eeeeee; text-align: center; width:100px;">작성자</th> -->
					<th style="width:100px;">작성일</th>
				</tr>
				</thead>
				<tbody>
				<tr>
						<!-- <td style="width: 20%;">글 제목</td> -->
						<td><c:if test="${board.boardCtgNo eq '0'}">소식</c:if>
						<c:if test="${board.boardCtgNo eq '1'}">카드뉴스</c:if>
						<c:if test="${board.boardCtgNo eq '2'}">주문/결제</c:if>
						<c:if test="${board.boardCtgNo eq '3'}">교환/반품</c:if>
						<c:if test="${board.boardCtgNo eq '4'}">제품</c:if>
						<c:if test="${board.boardCtgNo eq '5'}">회원</c:if></td>
					
						<!-- <td style="width: 20%;">글 제목</td> -->
						<td>${board.boardTitle}</td>
					
						<%-- <!-- <td>작성자</td> -->
						<td>${board.userId}</td> --%>
					
						
						<td>${board.boardWriteDate}</td>
					</tr>
					<tr>
						<!-- <td>내용</td> -->
						<td colspan="3" style="background:#cfe3f6; height: 500px; text-align:center;"><textarea readonly>${board.boardContent}</textarea></td>
					</tr>
				
				</tbody>
				
			</table>
				
			
<form id= "/commentForm" name="/commentForm" enctype="multipart/form-data" method="post" action="<c:url value='/insertboard2'/>"> <!--  writedo로 넘겨주고 post방식으로 넘겨주겠다 -->
		<textarea class="commentText" placeholder="댓글 내용" name="commentCotent">${comment.commentContent}</textarea>
			<input type="submit" id="button2" class="btn btn-primary pull-right" value="댓글쓰기">
			<input type="hidden" name="userId" value="${sessionScope.sid}">  <!-- 세션 아이디 받아오기 -->
			<input type="hidden" name="commentWriteDate" value="<%= sf.format(nowDate) %>"> 
<!-- 		<button type="submit" button style="float:right;">작성</button>
 -->				</form>
		
			
			
			
			
			<br><br><br><br><br><br><br>
			
			<table class="table table-striped2">
						<thead>
							<tr>
								<th>작성자</th>
								<!-- <th style="width:90px;">제목</th> -->	
								<!-- <th style="background-color: #eeeeee; text-align: center; width:100px;">작성자</th> -->
								<th>작성일</th>
							</tr>
							<!-- <tr>
								<th style="width:180px;">내용	</th>
							</tr> -->
						</thead>
						<tbody>
				        	<c:forEach items="${commentList }" var="comment">
				        		<tr>
						   			<%-- <td>댓글 번호 ${comment.commentNo}</td> --%>
						   			<td>${comment.userId}</td>
						   			<%-- <td>${comment.commentTitle}</td> --%>
						   			
						   			<td>${comment.commentWriteDate}</td>
						   		</tr>	
						   	<%-- 	<tr>
						   			<td>${comment.commentContent}</td>
						   		</tr> --%>
							</c:forEach>
						</tbody>
						
						<thead>
							
							<tr>
								<th colspan="2"">내용	</th>
							</tr>
						</thead>
						<tbody>
				        	<c:forEach items="${commentList }" var="comment">
				        	<%-- 	<tr class="drugBox">
						   			<td>댓글 번호 ${comment.commentNo}</td>
						   			<td>${comment.userId}</td>
						   			<td>${comment.commentTitle}</td>
						   			
						   			<td>${comment.commentWriteDate}</td>
						   		</tr> --%>	
						   		<tr>
						   			<td>${comment.commentContent}</td>
						   		</tr>
							</c:forEach>
							
								<tr>
						<td style="float: left;">
							<a href="<c:url value='/listAllBoard'/>"><button>목록</button></a></td>
			
			<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
			<td>
			<a href="<c:url value='/updateBoardForm/${board.boardNo}'/>"><button  >게시글 수정</button></a>
			<a href="javascript:deleteCheck();"><button>게시글 삭제</button></a>
			
						</td>
					</tr>
						</tbody>
			</table>	
			<br>
			
			
<%-- 			<input type="hidden" name="id" value="${board.id}">
 --%>			
			
			
			<script type="text/javascript">
				function deleteCheck(){
					var answer = confirm("게시글을 삭제하시겠습니까?");
					if(answer == true){
						location.href="<c:url value='/deleteBoard/${board.boardNo}' />";
					}
				}
			</script>
		
		</div>
	</div>
	<!-- 게시판 글 보기 양식 영역 끝 -->

	</section>
	        
			<!-- BOTTOM  -->
			<jsp:include page="/WEB-INF/views/layout/bottom.jsp" flush='true' />
		
      </div> <!-- wrap -->
	</body>
</html>