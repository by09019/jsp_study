<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>login_page</title>
    <link rel="stylesheet" href="/bootstrap-4.3.1-dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="/css/style.css">
    
    <!--    script 연결-->
    <script src="/js/jquery-3.5.0.min.js"></script>
    <script src="/bootstrap-4.3.1-dist/js/bootstrap.min.js"></script>
</head>
<body>
<section class="login rel">
    <div class="cover rel">
        <form action="/login_action" method="post">
            <div class="form-group">
                <p>아이디</p>
                <input class="form-control" required type="text" name="id" placeholder="아이디를 입력하여 주세요...">
            </div>
            <div class="form-group">
                <p>패스워드</p>
                <input class="form-control" required type="password" name="pw" placeholder="패스워드를 입력하여 주세요...">
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-info loginButton">로그인</button>
                <button type="button" onclick="location.replace('/user/join');" class="btn btn-secondary">회원가입</button>
            </div>
        </form>
    </div>
</section>

<script>
	window.onload = _ => {
		$(document)
		.on("click", ".loginButton", e => {
			let
			id = $("[name='id']").val(),
			pw = $("[name='pw']").val();
			
			$.ajax({
				url: '/login_action',
				type: 'POST',
				data: {id, pw},
				success:function(value, e1, e2) {
					if(value != "") location.replace('/UserList');
				}
			});
		});
	}
</script>
</body>
</html>