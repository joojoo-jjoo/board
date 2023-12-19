<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/templet/head.jsp"></jsp:include>
    <style>
      body { font-family: Consolas, sans-serif; }
      h1 { margin: 30px 0px; text-align: center; }
      img { max-width: 50%; display: block; align:middle;margin: 0px 0px 500px 0px; }
    </style>
<div class="jumbotron">
  <h1 class="display-4">코인자동매매</h1>
  <p class="lead">This is a simple hero unit, a simple jumbotron-style component for calling extra attention to featured content or information.</p>
  <hr class="my-4">
  <p>It uses utility classes for typography and spacing to space content out within the larger container.</p>
  <a class="btn btn-warning btn-lg" href="#" role="button">Learn more</a>
  <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>
</div>

<form action="/gatsby/algorithm.do">
	<div class="card-group">
	  <div class="card">
	    <img src="resources/img/Dogecoin.jpg" class="card-img-top" >
	    <div class="card-body">
	      <h5 class="card-title">호가창 API</h5>
	      <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
	    </div>
	    <div class="card-footer">
	      <small class="text-muted">Last updated 3 mins ago</small>
	    </div>
	  </div>
	  <div class="card"><!-- 매수 알고리즘 카드 부분 -->
	    <!-- <img src="..." class="card-img-top" > -->
	    <div class="card-body">
	      <h5 class="card-title">매수 알고리즘</h5>
	      
	<div class="input-group mb-3">
	  <div class="input-group-prepend">
	    <span class="input-group-text">$</span>
	  </div>
	  <input type="text" name="currentPrice" class="form-control" aria-label="Amount (to the nearest dollar)" placeholder="현재 코인 가격">
	</div>
	<div class="input-group mb-3">
	  <div class="input-group-prepend">
	    <span class="input-group-text">$</span>
	  </div>
	  <input type="text" name="gap"  class="form-control" aria-label="Amount (to the nearest dollar)"  placeholder="투입 가격 GAP">
	</div>
	<div class="input-group mb-3">
	  <div class="input-group-prepend">
	    <span class="input-group-text">$</span>
	  </div>
	  <input type="text" name="firstInput" class="form-control" aria-label="Amount (to the nearest dollar)"  placeholder="시작 투입 금액">
	</div>
	<div class="input-group mb-3">
	  <div class="input-group-prepend">
	    <span class="input-group-text">$</span>
	  </div>
	  <input type="text" name="secondInput" class="form-control" aria-label="Amount (to the nearest dollar)"  placeholder="두번째 투입 금액">
	</div>
	<button class="btn btn-outline-success my-2 my-sm-0" type="submit" name="submit">Submit</button>
	    </div>
	    <div class="card-footer">
	     <p>짜라란</p>
     <table border="1" align="center" width="70%" id="">
         <tr style="display:none">
             <td colspan="4"></td>
         </tr>
         <c:forEach var="result" items="${result}" varStatus="status">
          <tr>
              <td width="100px">
                  ${result.coinPrice} 원 일때
              </td> 
              <td width="100px">
                 ${result.money} 원 투입!!!
              </td>
          </tr>
      </c:forEach>
     </table>
	    </div>
	    
     
	  </div>
	</div>
	
</form>

</body>
</html>

<script type="text/javascript">

</script>
