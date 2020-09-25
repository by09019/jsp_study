<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>

<%
	List<String[]> list = (ArrayList<String[]>) request.getAttribute("list");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>list_page</title>

<!--    스타일 시트 연결-->
<link rel="stylesheet"
	href="/bootstrap-4.3.1-dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/style.css">

<!--    script 연결-->
<script src="/js/jquery-3.5.0.min.js"></script>
<script src="/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<section class="search rel">
		<div class="cover flex center align rel">
			<select name='choose' class="form-control" style="width:250px;">
				<option value="">검색 조건을 선택해주세요.</option>
				<option value="idx">No</option>
				<option value="id">회원 ID</option>
				<option value="name">회원 이름</option>
				<option value="dates">가입 일자</option>
			</select>
			<input type="text" class="form-control" name="search"
				placeholder="검색어를 입력하여 주세요...">
			<button class="btn btn-info searchButton">검색하기</button>
		</div>
	</section>
	<section class="uesr_list rel">
		<div class="cover rel">
			<table class="table">
				<thead>
					<tr>
						<th>No</th>
						<th>회원 ID</th>
						<th>회원 이름</th>
						<th>가입 일자</th>
						<th>회원 삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="name" items="${list}" varStatus="status">
						<tr>
							<td>${status.count}</td>
							<td><span class='openModal' data-toggle="modal"
								data-target="#user_modal" data-idx="${status.count}"><c:out
										value="${name[0]}" /></span></td>
							<td><c:out value="${name[1]}" /></td>
							<td><c:out value="${name[3]}" /></td>
							<td>
								<button class="btn btn-info removeButton" data-id="<c:out value="${name[0]}" />">회원삭제</button>
							</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
	</section>
	<div id="user_modal" class="modal fade" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h3>회원정보 수정 팝업</h3>
					<button class="btn" onclick="$('#user_modal').modal('hide');">X</button>
				</div>
				<div class="modal-body">
					<form action="/user_modify_action" method="post">
						<div class="form-group">
							<p>이름</p>
							<input class="form-control" type="text" name="name" value="asd">
						</div>
						<div class="form-group">
							<p>아이디</p>
							<input class="form-control" type="text" name="id" value="asd">
						</div>
						<div class="form-group">
							<p>패스워드</p>
							<input class="form-control" type="password" name="pw" value="asd">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script>
		const render = data => {
			$("#user_modal .modal-body form").html(data.map(v => `
			 <div class="form-group">
            <p>이름</p>
            <input class="form-control" type="text" name="name" value="`+v.name+`">
        </div>
         <div class="form-group">
            <p>아이디</p>
            <input class="form-control" type="text" name="id" value="`+v.id+`">
        </div>
         <div class="form-group">
            <p>패스워드</p>
            <input class="form-control" type="password" name="pw" value="`+v.pw+`">
        </div>
        <div class="modal-footer">
		<button type="button" class="btn btn-info modify_action_button">저장</button>
	</div>
					`).join(''));
		},
		render2 = data => {
			$("table tbody").html(data.map((v, idxs) => `
			<tr>
			<td>`+(v.idx)+`</td>
			<td><span class='openModal' data-toggle="modal"
				data-target="#user_modal" data-idx="`+(v.idx)+`"><c:out
						value="`+(v.id)+`" /></span></td>
			<td><c:out value="`+(v.name)+`" /></td>
			<td><c:out value="`+(v.dates)+`" /></td>
			<td>
				<button class="btn btn-info removeButton" data-id="`+(v.id)+`">회원삭제</button>
			</td>
		</tr> `).join(''));
		};

	window.onload = _ => {
		let arr = [];
		 <c:forEach var="name" items="${list}" varStatus="status">
		 arr.push({idx:${status.count}, id:"<c:out value="${name[0]}" />", name:"<c:out value="${name[1]}" />", dates:"<c:out value="${name[3]}" />", pw:"<c:out value="${name[2]}" />"});
	 </c:forEach>

		$(document)
		.on("click", ".openModal", ({ target }) => {
			let idx = $(target).data("idx");
			const search_list = arr.filter(v => v.idx === idx);
			render(search_list);
		})
		.on("click", ".removeButton", e => {
			let id = $(e.target).data("id");
			console.log("remove", id);
			$.ajax({
				url: "/user/delete",
				type: 'POST',
				data: {id},
				success:function(e) {
					location.reload();
				},
				error:function(e) {
					console.log(e, "error");
				}
			})

		})
		.on("click", ".modify_action_button", e => {
			let
			id = $("[name='id']").val(),
			pw = $("[name='pw']").val(),
			name = $("[name='name']").val();
			$.ajax({
				url: "/user_modify_action",
				type: 'POST',
				data: {id, pw, name},
				success:function(e) {
					location.reload();
				},
				error:function(e) {
					console.log(e, "error");
				}
			})
		})
		.on("click", ".searchButton", e => { // 검색 영역
			const value = $("[name='search']").val();
			const choose = $("[name='choose']").val();

			if(choose === "") return alert("선택을 하여 주세요.");
			console.log(choose, value, arr)
			const search_list = arr.filter(v => (choose == "idx") ? (v[choose] == value) : (v[choose].includes(value)) );

			render2(value === "" ? arr : search_list);
			$("[name='search']").val("");
		})
		.on("keydown", "[name='search']", ({key}) => {
			if(key === "Enter") $(".searchButton").click();
		})
	}
</script>
</body>
</html>