<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 페이지</title>
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/fonts.css')}">
    <link rel="stylesheet" href="${resourceVersion.getVersionedUrl('/css/common.css')}">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f0f2f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>메인 페이지</h2>
        <jsp:include page="common/navigation.jsp" />
        <div style="margin-top: 20px;">
            <h3>환영합니다!</h3>
            <p>원하시는 기능을 선택해주세요.</p>
        </div>
    </div>
</body>
</html> 