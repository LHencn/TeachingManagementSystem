<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <base href="<%=basePath%>">
    <meta charset="utf-8">
    <title></title>
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/form-elements.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">


</head>
<body>
<!-- Top content -->
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong>东北林业大学</strong>软件工程专业</h1>
                    <div class="description">
                        <p>
                            这是东北林业大学软件工程专业工作管理系统
                        </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>Login to our site</h3>
                            <p>Enter your username and password to log on:</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-key"></i>
                        </div>
                    </div>
                    <div class="form-bottom">


                        <form action="login" method="post" class="login-form" role="form">
                            <div class="form-group">

                                <label class="sr-only" for="form-username">Username</label>
                                <input type="text" name="username" placeholder="Username..."
                                       class="form-username form-control" id="form-username"><br/>
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="form-password">Password</label>
                                <input type="password" name="password" placeholder="Password..."
                                       class="form-password form-control" id="form-password"><br/>
                            </div>
                            <div class="form-group">
                                <input id="loginform:codeInput" class="loginFormTdIpt form-control" type="text"
                                       name="checkcode" title="请输入验证码" placeholder="Checkcode..."/>
                                <img id="loginform:vCode" src="validatecode.jsp"
                                     onclick="javascript:document.getElementById('loginform:vCode').src='validatecode.jsp?'+Math.random();"/>
                                <br/>
                            </div>
                            <button class="btn">登陆</button>
                            <c:if test="${exception != null }">
                                <font color="red">${exception }</font>
                            </c:if>

                        </form>


                        <div class="copyrights"><a href="#">东北林业大学软件工程专业</a></div>


                        <!-- Javascript -->
                        <script src="assets/js/jquery-1.11.1.min.js"></script>
                        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
                        <script src="assets/js/jquery.backstretch.min.js"></script>
                        <script src="assets/js/scripts.js"></script>

</body>
</html>