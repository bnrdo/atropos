<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>AtroPOS</title>
		<link rel="stylesheet" type="text/css" href='<c:out value="${pageContext.request.contextPath}"/>/css/atropos.css' />
		<script src='<c:out value="${pageContext.request.contextPath}"/>/js/jquery-1.10.2.js'></script>
		<script type="text/javascript">
			$(document).ready(function(){
				$("#content-frame").attr("src", "pos.htm");
			});
		</script>
	</head>
	<body>
		<div id='page-toolbar'></div>
		<div id="nav-and-body-wrap">
			<div id='page-navigation'>
				<ul>
				    <li><a href="dashboard.htm" target="content-frame">Dashboard</a></li>
				    <li><a href="pos.htm" target="content-frame">POS</a></li>
				    <li><a href="browse.htm" target="content-frame">Browse</a></li>
				    <li><a href="reports.htm" target="content-frame">Reports</a></li>
				    <li><a href="settings.htm" target="content-frame">Settings</a></li>
				</ul>
			</div>
		<div id='page-body'></div>
			<iframe id="content-frame" name="content-frame"></iframe>
		</div>
	</body>
</html>
