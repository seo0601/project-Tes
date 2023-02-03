<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>views/lecture/detail.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
<jsp:include page="/WEB-INF/views/include/bootCss.jsp"></jsp:include>
<link href="${pageContext.request.contextPath }/resources/css/lecture.css" rel="stylesheet">

</head>
<body>
	<div class="wrapper">
		<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
		<div class="container">
			<div class="box">
				<div class="box1">
				<div class="d-flex justify-content-end mt-3">
				      <c:if test="${id eq 'admin'}">
				         <button class="btn btn-secondary btn-sm me-2 mb-3" type="button" onclick="location.href='${pageContext.request.contextPath}/lecture/updateform?num=${dto.num }'">수정</button>
				      	 <button class="btn btn-danger btn-sm me-2 mb-3" type="button" onclick="deleteConfirm()">삭제</button>
				      </c:if>
				  </div>
			        <script>
			            function deleteConfirm(){
			               const isDelete=confirm("이 글을 삭제 하겠습니까?");
			               if(isDelete){
			                  location.href="${pageContext.request.contextPath}/lecture/delete?num=${dto.num}";
			               }
			            }
			        </script>
					<div>
						<img style="width:500px; height:350px;" src="${pageContext.request.contextPath }/lecture/images/${dto.imagePath}">
		
					<div>					   
				    	<p>${dto.describe}</p>
			  	    </div>
			  	    
				<br/>
				
				<h4>수강 후기를 작성해주세요</h4>
			      <!-- 원글에 댓글을 작성할 폼 -->
			      <form class="comment-form insert-form" action="lectureReview_insert" method="post" name="myform" id="myform">
			         <!-- 원글의 글번호가 댓글의 ref_group 번호가 된다. -->
			         <input type="hidden" name="ref_group" value="${dto.num }"/>
			         <!-- 원글의 작성자가 댓글의 대상자가 된다. -->
			         <input type="hidden" name="target_id" value="${dto.writer }"/>
			         <div class="star-rating">
						  <input type="radio" id="5-stars" name="star" value="5" />
						  <label for="5-stars" class="star">&#9733;</label>
						  <input type="radio" id="4-stars" name="star" value="4" />
						  <label for="4-stars" class="star">&#9733;</label>
						  <input type="radio" id="3-stars" name="star" value="3" />
						  <label for="3-stars" class="star">&#9733;</label>
						  <input type="radio" id="2-stars" name="star" value="2" />
						  <label for="2-stars" class="star">&#9733;</label>
						  <input type="radio" id="1-star" name="star" value="1" />
						  <label for="1-star" class="star">&#9733;</label>
					</div>
			         <textarea name="content" class="me-3">${empty id ? '수강 후기 작성을 위해 로그인이 필요 합니다.' : '' }</textarea>
			         <button type="submit" class="button btn mb-5">등록</button>
			      </form>
			      
			      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
			      <script>
			      	$( ".star_rating a" ).click(function() {
			    	     $(this).parent().children("a").removeClass("on");
			    	     $(this).addClass("on").prevAll("a").addClass("on");
			    	     let starCount=$(".star_rating .on").length;
			    	     $("input[name=star]").val(starCount);
			    	     return false;
			    	});
			      </script>
			      
			      <!-- 댓글 목록 -->
			      <div class="comments">      
			      
			         <ul>
			            <c:forEach var="tmp" items="${commentList }">
			               <c:choose>
			                  <c:when test="${tmp.deleted eq 'yes' }">
			                     <li>삭제된 댓글 입니다.</li>
			                  </c:when>
			                  <c:otherwise>
			                     <c:if test="${tmp.num eq tmp.comment_group }">
			                        <li id="reli${tmp.num }">
			                     </c:if>
			                     <c:if test="${tmp.num ne tmp.comment_group }">
			                        <li id="reli${tmp.num }" style="padding-left:50px;">
			                           <svg class="reply-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-return-right" viewBox="0 0 16 16">
			                                <path fill-rule="evenodd" d="M1.5 1.5A.5.5 0 0 0 1 2v4.8a2.5 2.5 0 0 0 2.5 2.5h9.793l-3.347 3.346a.5.5 0 0 0 .708.708l4.2-4.2a.5.5 0 0 0 0-.708l-4-4a.5.5 0 0 0-.708.708L13.293 8.3H3.5A1.5 1.5 0 0 1 2 6.8V2a.5.5 0 0 0-.5-.5z"/>
			                           </svg>
			                     </c:if>
			                           <dl>
			                              <dt>
			                                 <c:if test="${ empty tmp.profile }">
			                                    <svg class="profile-image" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
			                                      <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
			                                      <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
			                                    </svg>
			                                 </c:if>
			                                 <c:if test="${not empty tmp.profile }">
			                                    <img class="profile-image" src="${pageContext.request.contextPath}/users/images/${tmp.profile }"/>
			                                 </c:if>
			                                 <span>${tmp.writer }</span>
			                                 <c:if test="${tmp.num ne tmp.comment_group }">
			                                    @<i>${tmp.target_id }</i>
			                                 </c:if>
			                                 <span>${tmp.regdate }</span>
			                                 
			                                 <c:if test="${ (id ne null) and (tmp.writer eq id) }">
			                                    <a data-num="${tmp.num }" class="update-link" href="javascript:">수정</a>
			                                    <a data-num="${tmp.num }" class="delete-link" href="javascript:">삭제</a>
			                                 </c:if>
			                              </dt>
			                              <dd>
			                              	<span class="star-rating2">
												  <input type="radio" id="5-stars" name="star" value="5" />
												  <label style='<c:if test="${tmp.star > 4 }">color:#f90;</c:if>' for="5-stars" class="star">&#9733;</label>
												  <input type="radio" id="4-stars" name="star" value="4" />
												  <label style='<c:if test="${tmp.star > 3 }">color:#f90;</c:if>' for="4-stars" class="star">&#9733;</label>
												  <input type="radio" id="3-stars" name="star" value="3" />
												  <label style='<c:if test="${tmp.star > 2 }">color:#f90;</c:if>' for="3-stars" class="star">&#9733;</label>
												  <input type="radio" id="2-stars" name="star" value="2" />
												  <label style='<c:if test="${tmp.star > 1 }">color:#f90;</c:if>' for="2-stars" class="star">&#9733;</label>
												  <input type="radio" id="1-star" name="star" value="1" />
												  <label style='<c:if test="${tmp.star > 0 }">color:#f90;</c:if>' for="1-star" class="star">&#9733;</label>
											 </span>
			                              </dd>
			                              <dd>
			                                 <pre id="pre${tmp.num }">${tmp.content }</pre>                  
			                              </dd>
			                           </dl>
			                           <form id="reForm${tmp.num }" class="animate__animated comment-form re-insert-form" action="lectureReview_insert" method="post">
			                              <input type="hidden" name="ref_group" value="${dto.num }"/>
			                              <input type="hidden" name="target_id" value="${tmp.writer }"/>
			                              <input type="hidden" name="comment_group" value="${tmp.comment_group }"/>
			                              <textarea name="content"></textarea>
			                              <button type="submit">등록</button>
			                           </form>
			                        <c:if test="${tmp.writer eq id }">
			                           <form id="updateForm${tmp.num }" class="comment-form update-form" action="lectureReview_update" method="post">
			                              <input type="hidden" name="num" value="${tmp.num }" />
			                              <textarea name="content">${tmp.content }</textarea>
			                              <button type="submit">수정</button>
			                           </form>
			                        </c:if>
			                        </li>      
			                  </c:otherwise>
			               </c:choose>
			            </c:forEach>
			         </ul>
			      </div>      
			      <div class="loader">
			         <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
			              <path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z"/>
			              <path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z"/>
			         </svg>
			      </div>      
				</div>
			</div>
			<div class="box2">
				<c:choose>
					<c:when test="${lsDto2.id == null}">
						<form action="lectureSignup" class= "mt-5 mb-3 d-flex justify-content-center" method="post">
							<input type="hidden" name="ref_group" value="${dto.num }"/>
							<button class="button" onclick="lectureSignupConfirm()">수강 신청</button>
						</form>	
					</c:when>
					<c:otherwise>
						<div class="d-flex justify-content-center mb-3">
				        	<button type="button" onclick="location.href='${pageContext.request.contextPath}/lecture/lecture_view?num=${dto.num}'">강의보기</button>		   
				  	    </div>
					</c:otherwise>
				</c:choose>  	
		  	    <div class="d-flex justify-content-center">
		        	<button type="button" onclick="location.href='${pageContext.request.contextPath}/qna_board/list'">1:1문의</button>		   
		  	    </div>
	  	 	</div>
		</div>
		</div>
	</div>
	<script>
       function lectureSignupConfirm(){
          const isSignup=confirm("강의를 신청하시겠습니까?");
          if(isSignup){
             location.href="${pageContext.request.contextPath}/lecture/lectureSignup?num=${dto.num}";
          }
       }
  	</script>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"></jsp:include>
	
	<script src="${pageContext.request.contextPath}/resources/js/gura_util.js"></script>
	<script>
      
      //클라이언트가 로그인 했는지 여부
      let isLogin=${ not empty id };
      
      document.querySelector(".insert-form")
         .addEventListener("submit", function(e){
            //만일 로그인 하지 않았으면 
            if(!isLogin){
               //폼 전송을 막고 
               e.preventDefault();
               //로그인 폼으로 이동 시킨다.
               location.href=
                  "${pageContext.request.contextPath}/users/loginform?url=${pageContext.request.contextPath}/lecture/detail?num=${dto.num}";
            }
         });
      
      /*
         detail
          페이지 로딩 시점에 만들어진 1 페이지에 해당하는 
         댓글에 이벤트 리스너 등록 하기 
      */
      addUpdateFormListener(".update-form");
      addUpdateListener(".update-link");
      addDeleteListener(".delete-link");
      addReplyListener(".reply-link");
      
      
      //댓글의 현재 페이지 번호를 관리할 변수를 만들고 초기값 1 대입하기
      let currentPage=1;
      //마지막 페이지는 totalPageCount 이다.
      <%-- 댓글의 개수가 0일때 오류를 방지하기 위해 --%>
      let lastPage=${ totalPageCount eq 0 ? 1 : totalPageCount};
      
      //추가로 댓글을 요청하고 그 작업이 끝났는지 여부를 관리할 변수 
      let isLoading=false; //현재 로딩중인지 여부 
      
      /*
         window.scrollY => 위쪽으로 스크롤된 길이
         window.innerHeight => 웹브라우저의 창의 높이
         document.body.offsetHeight => body 의 높이 (문서객체가 차지하는 높이)
      */
      window.addEventListener("scroll", function(){
         //바닥 까지 스크롤 했는지 여부 
         const isBottom = 
            window.innerHeight + window.scrollY  >= document.body.offsetHeight;
         //현재 페이지가 마지막 페이지인지 여부 알아내기
         let isLast = currentPage == lastPage;   
         //현재 바닥까지 스크롤 했고 로딩중이 아니고 현재 페이지가 마지막이 아니라면
         if(isBottom && !isLoading && !isLast){
            //로딩바 띄우기
            document.querySelector(".loader").style.display="block";
            
            //로딩 작업중이라고 표시
            isLoading=true;
            
            //현재 댓글 페이지를 1 증가 시키고 
            currentPage++;
            
            /*
               해당 페이지의 내용을 ajax 요청을 통해서 받아온다.
               "pageNum=xxx&num=xxx" 형식으로 GET 방식 파라미터를 전달한다. 
            */
            ajaxPromise("ajax_review_list","get",
                  "pageNum="+currentPage+"&num=${dto.num}")
            .then(function(response){
               //json 이 아닌 html 문자열을 응답받았기 때문에  return response.text() 해준다.
               return response.text();
            })
            .then(function(data){
               //data 는 html 형식의 문자열이다. 
               console.log(data);
               // beforebegin | afterbegin | beforeend | afterend
               document.querySelector(".comments ul")
                  .insertAdjacentHTML("beforeend", data);
               //로딩이 끝났다고 표시한다.
               isLoading=false;
               //새로 추가된 댓글 li 요소 안에 있는 a 요소를 찾아서 이벤트 리스너 등록 하기 
               addUpdateListener(".page-"+currentPage+" .update-link");
               addDeleteListener(".page-"+currentPage+" .delete-link");
               addReplyListener(".page-"+currentPage+" .reply-link");
               //새로 추가된 댓글 li 요소 안에 있는 댓글 수정폼에 이벤트 리스너 등록하기
               addUpdateFormListener(".page-"+currentPage+" .update-form");
               
               //로딩바 숨기기
               document.querySelector(".loader").style.display="none";
            });
         }
      });
      
      //인자로 전달되는 선택자를 이용해서 이벤트 리스너를 등록하는 함수 
      function addUpdateListener(sel){
         //댓글 수정 링크의 참조값을 배열에 담아오기 
         // sel 은  ".page-xxx  .update-link" 형식의 내용이다 
         let updateLinks=document.querySelectorAll(sel);
         for(let i=0; i<updateLinks.length; i++){
            updateLinks[i].addEventListener("click", function(){
               //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
               const num=this.getAttribute("data-num"); //댓글의 글번호
               document.querySelector("#updateForm"+num).style.display="block";
               
            });
         }
      }
      function addDeleteListener(sel){
         //댓글 삭제 링크의 참조값을 배열에 담아오기 
         let deleteLinks=document.querySelectorAll(sel);
         for(let i=0; i<deleteLinks.length; i++){
            deleteLinks[i].addEventListener("click", function(){
               //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
               const num=this.getAttribute("data-num"); //댓글의 글번호
               const isDelete=confirm("댓글을 삭제 하시겠습니까?");
               if(isDelete){
                  // gura_util.js 에 있는 함수들 이용해서 ajax 요청
                  ajaxPromise("lectureReview_delete", "post", "num="+num)
                  .then(function(response){
                     return response.json();
                  })
                  .then(function(data){
                     //만일 삭제 성공이면 
                     if(data.isSuccess){
                        //댓글이 있는 곳에 삭제된 댓글입니다를 출력해 준다. 
                        document.querySelector("#reli"+num).innerText="삭제된 댓글입니다.";
                     }
                  });
               }
            });
         }
      }
      function addReplyListener(sel){
         //댓글 링크의 참조값을 배열에 담아오기 
         let replyLinks=document.querySelectorAll(sel);
         //반복문 돌면서 모든 링크에 이벤트 리스너 함수 등록하기
         for(let i=0; i<replyLinks.length; i++){
            replyLinks[i].addEventListener("click", function(){
               
               if(!isLogin){
                  const isMove=confirm("로그인이 필요 합니다. 로그인 페이지로 이동 하시겠습니까?");
                  if(isMove){
                     location.href=
                        "${pageContext.request.contextPath}/users/loginform?url=${pageContext.request.contextPath}/lecture/detail?num=${dto.num}";
                  }
                  return;
               }
               
               //click 이벤트가 일어난 바로 그 요소의 data-num 속성의 value 값을 읽어온다. 
               const num=this.getAttribute("data-num"); //댓글의 글번호
               
               const form=document.querySelector("#reForm"+num);
               
               //현재 문자열을 읽어온다 ( "답글" or "취소" )
               let current = this.innerText;
               
               if(current == "답글"){
                  //번호를 이용해서 댓글의 댓글폼을 선택해서 보이게 한다. 
                  form.style.display="block";
                  form.classList.add("animate__fadeInLeft");
                  this.innerText="취소";   
                  form.addEventListener("animationend", function(){
                     form.classList.remove("animate__fadeInLeft");
                  }, {once:true});
               }else if(current == "취소"){
                  form.classList.add("animate__fadeOut");
                  this.innerText="답글";
                  form.addEventListener("animationend", function(){
                     form.classList.remove("animate__fadeOut");
                     form.style.display="none";
                  },{once:true});
               }
            });
         }
      }
      
      function addUpdateFormListener(sel){
         //댓글 수정 폼의 참조값을 배열에 담아오기
         let updateForms=document.querySelectorAll(sel);
         for(let i=0; i<updateForms.length; i++){
            //폼에 submit 이벤트가 일어 났을때 호출되는 함수 등록 
            updateForms[i].addEventListener("submit", function(e){
               //submit 이벤트가 일어난 form 의 참조값을 form 이라는 변수에 담기 
               const form=this;
               //폼 제출을 막은 다음 
               e.preventDefault();
               //이벤트가 일어난 폼을 ajax 전송하도록 한다.
               ajaxFormPromise(form)
               .then(function(response){
                  return response.json();
               })
               .then(function(data){
                  if(data.isSuccess){
                     /*
                        document.querySelector() 는 html 문서 전체에서 특정 요소의 
                        참조값을 찾는 기능
                        
                        특정문서의 참조값.querySelector() 는 해당 문서 객체의 자손 요소 중에서
                        특정 요소의 참조값을 찾는 기능
                     */
                     const num=form.querySelector("input[name=num]").value;
                     const content=form.querySelector("textarea[name=content]").value;
                     //수정폼에 입력한 value 값을 pre 요소에도 출력하기 
                     document.querySelector("#pre"+num).innerText=content;
                     form.style.display="none";
                  }
               });
            });
         }
      }
      
   </script>
</body>
</html>