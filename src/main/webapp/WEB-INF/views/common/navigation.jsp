<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="nav-container">
    <a href="/" class="nav-button ${currentPage eq 'home' ? 'active' : ''}">홈</a>
    <a href="/calculate" class="nav-button ${currentPage eq 'calculate' ? 'active' : ''}">계산기</a>
    <a href="/serverinfo" class="nav-button ${currentPage eq 'serverinfo' ? 'active' : ''}">서버 정보</a>
</div> 