<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- 引入c:foreach -->
	<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表页面</title>
<!-- 相对路径 。以/开始，不以/结束 -->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>



<!-- Bootstrap -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<!--  jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
<script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<!--  加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>

	<!-- 搭建显示页面 -->
	<div class="container">

		<!-- 表头 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CRUD</h1>
			</div>
		</div>
		<!--  按钮-->
		<div class="row">
			<div class="col-md-4  col-md-offset-8">
				<button class="btn  btn-primary">新增</button>
				<button class="btn  btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<div class="table-responsive">
					<table class="table  table-hover">
						<tr>
							<th>id</th>
							<th>empName</th>
							<th>empGender</th>
							<th>empEmail</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
						<!-- c:forEach表中数据全部展示出来 ,emp是别名 -->
						<c:forEach   items="${pageInfo.list}"  var="emp">
						<tr>
							<th>${emp.empId}</th>
							<th>${emp.empName}</th>
							<th>${emp.gender=="M"?"男":"女"}</th>
							<th>${ emp.email}</th>
							<th>${ emp.department.deptName}</th>
							<th>
								<button type="button " class="btn btn-primary btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									编辑
								</button>
								<button type="button" class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>
							</th>
						</tr>
						</c:forEach>
						
					</table>
				</div>
			</div>
		</div>
		<!-- 分页文字和数字 -->
		<div class="row">
			<!--分页文字  -->
			<div class="col-md-6">
			当前第${pageInfo.pageNum}页,共${pageInfo.pages}页,共${pageInfo.total}条记录
			</div>
			<!-- 首页下一页尾页 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
					<!--  判断是否有上一页-->
					<c:if  test="${pageInfo.hasPreviousPage}">
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous"> <span
							aria-hidden="true">&laquo;</span>
					</a>
					</li>
					</c:if>
					<!-- 显示5个，1 2 3 4 5 -->
					<c:forEach  items="${pageInfo.navigatepageNums}"  var="page_num">
					<c:if test="${page_num  == pageInfo.pageNum}">
					  <li class="active"><a href="#">${page_num}</a></li>
					</c:if>
					<!--不相等就不显示高亮  -->
					<c:if test="${ page_num != pageInfo.pageNum}">
					  <li ><a href="${APP_PATH }/emps?pn=${page_num}">${page_num}</a></li>
					</c:if>
					</c:forEach>
					<!-- 判断是否最后一页 。是最后一页取消 > 箭头-->
					<c:if test="${pageInfo.hasNextPage}">
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+1}" aria-label="Next"> <span
							aria-hidden="true">&raquo;</span>
					</a>
					</li>
					</c:if>
					<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}">尾页</a></li>
				</ul>
				</nav>
			</div>
		</div>
		<!-- 最后一个div -->
	</div>















</body>
</html>