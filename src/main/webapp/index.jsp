<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 引入c:foreach -->
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>index页面</title>
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
				<button class="btn  btn-primary" id="emp_add_modal">新增</button>
				<button class="btn  btn-danger" id="del_ids">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<div class="table-responsive">
					<table class="table  table-hover" id="emps_table">
						<thead>
							<tr>
							<th>
							<input type="checkbox" id="check_all">
							</th>
								<th>id</th>
								<th>empName</th>
								<th>empGender</th>
								<th>empEmail</th>
								<th>deptName</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
			</div>
		</div>

		<!-- 员工新增模态框 -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">员工新增信息</h4>
					</div>
					<div class="modal-body">
						<!-- 添加员工新增信息 -->
						<form class="form-horizontal ">
							<!-- 员工姓名 -->
							<div class="form-group ">
								<label for="empNameaddinput" class="col-sm-2 control-label">empName</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="empName_add_input"
										name="empName" placeholder="empName"> <span
										class="help-block"></span>
								</div>
							</div>
							<!-- 员工邮箱 -->
							<div class="form-group">
								<label for="emailaddinput" class="col-sm-2 control-label">Email</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="email_add_input"
										name="email" placeholder="zhongguo@huawei.com"> <span
										class="help-block"></span>
								</div>
							</div>
							<!--Gender性别单选框按钮  -->
							<div class="form-group">
								<label for="genderaddinput" class="col-sm-2 control-label">gender</label>
								<div class="col-sm-8">
									<label class="radio-inline"> <input type="radio"
										name="gender" id="gender1_radio" value="M" checked="checked">男
									</label> <label class="radio-inline"> <input type="radio"
										name="gender" id="gender2_radio" value="G"> 女
									</label>
								</div>
							</div>
							<!-- 下拉框显示部门信息 -->
							<div class="form-group">
								<label for="departmentaddinput" class="col-sm-2 control-label">departMent</label>
								<div class="col-sm-6">
									<select class="form-control" name="dId">
									</select>
								</div>
							</div>

						</form>
						<!-- 新增员工信息结束 -->
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="emp_add">保存</button>
					</div>
				</div>
			</div>
		</div>

<!-- 更新模态框 -->
		<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">修改信息</h4>
					</div>
					<div class="modal-body">
						<!-- 更新员工信息 -->
						<form class="form-horizontal ">
							<!-- 员工姓名 -->
							<div class="form-group ">
								<label for="empNameaddinput" class="col-sm-2 control-label">empName</label>
								<div class="col-sm-8">
								<!-- 设置empName不能修改 -->
									  <p class="form-control-static"  id="empName_update_input"></p>
								</div>
							</div>
							<!-- 员工邮箱 -->
							<div class="form-group">
								<label for="emailaddinput" class="col-sm-2 control-label">Email</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="email_update_input"
										name="email" placeholder="zhongguo@huawei.com"> <span
										class="help-block"></span>
								</div>
							</div>
							<!--Gender性别单选框按钮  -->
							<div class="form-group">
								<label for="genderaddinput" class="col-sm-2 control-label">gender</label>
								<div class="col-sm-8">
									<label class="radio-inline"> <input type="radio"
										name="gender" id="gender1_radio" value="M" checked="checked">男
									</label> <label class="radio-inline"> <input type="radio"
										name="gender" id="gender2_radio" value="G"> 女
									</label>
								</div>
							</div>
							<!-- 下拉框显示部门信息 -->
							<div class="form-group">
								<label for="departmentaddinput" class="col-sm-2 control-label">departMent</label>
								<div class="col-sm-6">
									<select class="form-control" name="dId">
									</select>
								</div>
							</div>

						</form>
						<!-- 更新员工信息结束 -->

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="emp_update">更新</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 分页文字和数字 -->
		<div class="row">
			<!--分页文字_左边  -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 首页下一页尾页_右边 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
		<script type="text/javascript">
		
		//总记录数，当前页
		var  totalRecord,thisPage;
		//1.页面加载完成，直接发送Ajax请求
		$(function(){
			to_page(1);
		});
		
		//点击数字进行跳转
		function to_page(pn){
			$.ajax({
				type:"post",
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				success:function(result){
					//console.log(result);
					//2.解析并显示员工信息
					emps_table(result);
					//3.解析分页：显示右边，一串数字
					page_nav(result);
					//4.解析分页：显示左边，数字
					page_info(result);
				}
			});
		}
		
		
		//解析并显示员工信息
		function emps_table(result){
			//清空表格
			$("#emps_table tbody").empty();
			var  emps=result.data.list;
			$.each(emps,function(index,item){
				//alert(item.empName);
				var  checkTd=$("<td></td>").append("<input type='checkbox' class='checkass'>");
				var  empIdTd=$("<td></td>").append(item.empId);
				var  empNameTd=$("<td></td>").append(item.empName);
				var  genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
				var  emailTd=$("<td></td>").append(item.email);
				var  deptNameTd=$("<td></td>").append(item.department.deptName);
				//编辑按钮
				var  editBtn=$("<button></button>").addClass("btn btn-primary btn-sm  edit_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//给编辑按钮添加一个自定义属性，id=edit-id 表示当前id
				editBtn.attr("edit-id",item.empId);
				//删除按钮
				var  delBtn=$("<button></button>").addClass("btn btn-danger btn-sm  del_btn")
				.append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				//给删除按钮添加个自定义属性，表示当前id
				delBtn.attr("del-id",item.empId);
				//编辑删除合体
				var  allBtn=$("<td></td>").append(editBtn).append(" ").append(delBtn);
				
				$("<tr></tr>").append(checkTd).append(empIdTd).append(empNameTd).append(genderTd)
				.append(emailTd).append(deptNameTd).append(allBtn).appendTo("#emps_table  tbody");
			});
		}
		
		//分页：显示左边，数字
		function  page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前第"+result.data.pageNum+"页,共"+result.data.pages+"页,共"+result.data.total+"条记录");
			//共几条记录
			totalRecord=result.data.total;
			//当前第几页
			thisPage=result.data.pageNum;
		}
		
		//分页：显示右边，一串数字
		function page_nav(result){
			$("#page_nav_area").empty();
			var  ul=$("<ul></ul>").addClass("pagination");
			//解析首页
			var  firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			//解析左括号， <
			var  prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
			//判断是否有上一页,没有就不能点击
			if(result.data.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				//如果有则进行翻页
				firstPageLi.click(function(){
					to_page(1);
				});
				prePageLi.click(function(){
					to_page(result.data.pageNum -1);
				});
				
			}
			
			//添加：首页 ，< 
			ul.append(firstPageLi).append(prePageLi);
			//遍历数字，navigatepageNums":[1,2,3,4,5]
			$.each(result.data.navigatepageNums,function(index,item){
				var  numLi=$("<li></li>").append($("<a></a>").append(item));
				//判断pageNum  == item  , 就加高亮
				if(result.data.pageNum ==  item){
					numLi.addClass("active");
				}
				//给数字添加点击事件
				numLi.click(function(){
					to_page(item);
				});
				ul.append(numLi);
			});
			//解析右括号， >
			var  nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
			//解析未页
			var  LastPageLi=$("<li></li>").append($("<a></a>").append("未页").attr("href","#"));
			//判断是否有下一页,没有就不能点击
			if(result.data.hasNextPage == false){
				nextPageLi.addClass("disabled");
				LastPageLi.addClass("disabled");
			}else{
				//如果有则进行翻页
				nextPageLi.click(function(){
					to_page(result.data.pageNum +1);
				});
				LastPageLi.click(function(){
					to_page(result.data.pages);
				});
				
			}
			
			//添加： >， 未页
			ul.append(nextPageLi).append(LastPageLi);
			//把 ul加入到nva
			var nav=$("<nav></nav>").append(ul);
			// 全部添加进去
			nav.appendTo("#page_nav_area");
		}
	
		//清空表单数据和表单样式
		function reset_form(legaeall){
			//清空表单内容
			$(legaeall)[0].reset();
			//清空表单样式
			$(legaeall).find("*").removeClass("has-error  has-success");
			$(legaeall).find(".help-block").text("");
		}
		
			//点击新增按钮弹出模态框	
			$("#emp_add_modal").click(function() {
				//清空表单所有信息:数据和样式
				reset_form("#empAddModal form");
				//弹出模态框
				$("#empAddModal").modal({
					//设置点击模态框之外的，模态框不消失
					backdrop : "static"
				});
				//点击新增按钮前获取部门所有信息
				getDepart("#empAddModal  select");
			});
			
			
			function getDepart(depart) {
				//清空之前下拉列表的值
				$(depart).empty();
				
				$.ajax({
					url : "${APP_PATH}/departs",
					type : "GET",
					success : function(result) {
						//遍历展示下拉框部门
						$.each(result.data, function() {
							var optionEle = $("<option></option>").append(
									this.deptName).attr("value", this.deptId);
							optionEle.appendTo(depart);
						});
					}

				});
			}

			//正则表达式校验姓名和邮箱

			function verify_add_form() {
				//1.校验姓名
				var empName = $("#empName_add_input").val();
				//中文(2-5),字母数据和_-(5-16)
				var regName = /(^[a-zA-Z0-9_-]{5,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
				if (!regName.test(empName)) {
					show_verify_msg("#empName_add_input", "error",
							"用户名格式要求2-5位中文或者5-16位的数字和字母的组合");
					return false;
				} else {
					show_verify_msg("#empName_add_input", "success", "");
				};

				//2.校验邮箱
				var email = $("#email_add_input").val();
				var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if (!regEmail.test(email)) {
					//alert("邮箱格式不正确");
					show_verify_msg("#email_add_input", "error", "请输入正确的邮箱格式:lisi@baidu.com");
					return false;
				} else {
					show_verify_msg("#email_add_input", "success", "");
				}
				return true;
			}

			//校验姓名和邮箱
			function show_verify_msg(showeai, status, msg) {
				//清空当前的样式
				$(showeai).parent().removeClass("has-error   has-success  ");
				$(showeai).next("span").text("");
				//判断姓名和邮箱格式正确否
				if ("success" == status) {
					$(showeai).parent().addClass("has-success");
					$(showeai).next("span").text(msg);
				} else if ("error" == status) {
					$(showeai).parent().addClass("has-error");
					$(showeai).next("span").text(msg);
				}
			}

			
			//检测用户名与数据库里数据重复
			$("#empName_add_input").change(
					function() {
						//发送ajax请求检测用户名有重复不
						var  empName=this.value;
						$.ajax({
							url : "${APP_PATH}/checkuser",
							type : "POST",
							data : "empName=" + empName,
							success : function(result) {
								if (result.state == 200) {
									show_verify_msg("#empName_add_input",
											"success", result.message);
									//保存按钮添加个属性判断用户名重复不
									$("#emp_add").attr("ajax-va", "success");
								} else {
									show_verify_msg("#empName_add_input",
											"error", result.message);
									//保存按钮添加个属性判断用户名重复不
									$("#emp_add").attr("ajax-va", "error");
								}
							}
						});

					});

			//点击保存按钮发送AJAX请求
			//jquery的serialize()序列化表单值
			$("#emp_add").click(function() {
				//保存之前对姓名和邮箱进行校验
				  if (!verify_add_form()) {
					return false;
				}  
				//保存用户名属性值判断
				if ($(this).attr("ajax-va") == "error") {
					return false;
				}

				$.ajax({
					url : "${APP_PATH}/insert",
					type : "POST",
					data : $("#empAddModal form").serialize(),
					success : function(result) {
						//保存前判断成功或失败,用户名和邮箱
						if(result.code == 200){
							//1.用户名和邮箱都成功后关闭模态框
							$('#empAddModal').modal('hide');
							//2.新数据显示再最后一页，总记录数（totalRecord）
							to_page(totalRecord);
						}else{
							//3.保存失败错误信息提醒(哪个错误就提醒那个)
							//3.1提醒邮箱错误
							if(undefined != result.extend.errorField.email){
								show_verify_msg("#email_add_input", "error", result.extend.errorField.email);
							}
							//3.2提醒姓名错误
							if( undefined != result.extend.errorField.empName){
								show_verify_msg("#empName_add_input",
										"error", result.extend.errorField.empName);
							} 
						}
					}
				});
			});
			
			//点击编辑按钮弹出模态框. 采用Jquery的on()方法   http://api.jquery.com/on/
			$(document).on('click','.edit_btn',function(){
				//弹出模态框
				$("#empUpdateModal").modal({
					//设置点击模态框之外的，模态框不消失
					backdrop : "static"
				});
				//显示下拉框
				getDepart("#empUpdateModal select");
                //弹出框时显示指定员工信息
				getEmp($(this).attr("edit-id"));
				//给更新添加个属性，把员工的ID给模态框更新按钮的edit-id=1
				$("#emp_update").attr("edit-id",$(this).attr("edit-id"));
			});
			
			//点击编辑按钮后发送Ajax请求数据
			function getEmp(id){
				$.ajax({
					url:"${APP_PATH}/select/"+id,
					type:"GET",
					success:function(result){
						var  empData=result.data;
						console.log(result);
						//获取empName
						$("#empName_update_input").text(empData.empName);
						//获取email
						$("#email_update_input").val(empData.email);
						//获取gender
						$("#empUpdateModal input[name=gender]").val([empData.gender]);
						//获取部门
						$("#empUpdateModal  select").val([empData.dId]);
					}
				});
			}
			
			/*点击更新按钮后更新数据 */
			$("#emp_update").click(function(){
				//1.对邮箱进行验证
				var email = $("#email_update_input").val();
				var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
				if (!regEmail.test(email)) {
					//alert("邮箱格式不正确");
					show_verify_msg("#email_update_input", "error", "请输入正确的邮箱格式:wangwu@baidu.com");
					return false;
				} else {
					show_verify_msg("#email_update_input", "success", "");
				}
				//2.发送Ajax请求获取数据
				$.ajax({
					url:"${APP_PATH}/update/"+$(this).attr("edit-id"),
					type:"PUT",
					//jquery的serialize()序列化表单值
					data:$("#empUpdateModal form").serialize(),
					success:function(result){
						console.log(result);
						//3.关闭模态框
						$("#empUpdateModal").modal("hide");
						//回到本页并刷新数据
						to_page(thisPage);
					}
				});
			});
			
			/*点击删除按钮进行删除 ,并提醒删除成功 */
			$(document).on("click",".del_btn",function(){
				//1.获取empName
				var empName=$(this).parents("tr").find("td:eq(2)").text();
				//获取empId
				var empId=$(this).attr("del-id");
				//2.弹出删除确认框，点击确认发送AJAX请求
				if(confirm("确认删除："+empName)){
					$.ajax({
						url:"${APP_PATH}/delete/"+empId,
						type:"PUT",
						success:function(result){
							//删除成功回到本页
							to_page(thisPage);
						}
					});
				}
			});
		
			/* 全选与全不选，使用jquery的prop()方法 */
			$("#check_all").click(function(){
				//chepro解释说明，选中返回true，不选返回false
				var chepro=$(this).prop("checked");
				//alert(chepro)
				$(".checkass").prop("checked",chepro);
			});
			
			/* 选中5个后，主按钮框被选中 */
			$(document).on("click",".checkass",function(){
				//对是否选中5个进行判断.使用jQuery的 :checked
				var flag=$(".checkass:checked").length == $(".checkass").length;
				//如果选中5个则主按钮被选中.选满返回true
				$("#check_all").prop("checked",flag);
			});
			
			//主删除按钮。 选中5个进行删除
			$("#del_ids").click(
					function() {
						//选择多个empName后，提醒是否删除
						var empNames = "";
						var delIds = "";
						$.each($(".checkass:checked"), function() {
							empNames += $(this).parents("tr").find("td:eq(2)").text()+ ",";
							//组装多个id
							delIds += $(this).parents("tr").find("td:eq(1)").text()+ "-";
						});
						//去除empNames的最后一个,
						empNames = empNames.substring(0, empNames.length - 1);
						//去掉多余ids的 -
						delIds = delIds.substring(0, delIds.length - 1);
						//直接点击主删除按钮，则进行提醒。
						if(empNames.length == 0 && delIds.length == 0){
							confirm("请选中要删除的内容");
						}else  if (confirm("确认删除【" + empNames + "】")) {
							//点击确认发送AJAX请求
							$.ajax({
								url : "${APP_PATH}/delete/" + delIds,
								type : "PUT",
								success : function(result) {
									//删除成功后回到当前页
									to_page(thisPage);
								}
							});
						}
					});
		</script>
		<!-- 最后一个div -->
	</div>



</body>
</html>