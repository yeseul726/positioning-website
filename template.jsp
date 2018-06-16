<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html name="template">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	@import url('https://fonts.googleapis.com/css?family=Nanum+Gothic|Dosis|Varela+Round|Song+Myung|Nanum+Myeongjo|Black+Han+Sans&subset=korean');
	/* * {
		box-sizing: border-box;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
	} */
	html {
		height: 100%;
	}
	body {
		margin: 0;
		height: 100%;
	}
	body {
		margin: 0px;
		padding: 0px;
	}
	.topBtn {
    	vertical-align: bottom;
	}
	.wrap {
		min-height: 100%;
		position: relative;
		padding-bottom: 10%; /* footer height */
	}
	#footer {
		position: absolute;
		bottom: 0;
		left: 0;
		right: 0;
		color: white;
		background-color: #9F7E69;
	}
	.admin {
		text-decoration: none;
		color: #737373;
		padding-bottom: 2px;
	}
	.admin:hover {
		border-bottom: 1px solid #737373;
	}
</style>
</head>
<body>
<%
	String contentPage = request.getParameter("CONTENTPAGE");
%>
<div align="center" class="wrap">
	<table style="border-spacing: 0px;
			width: 100%;
			margin: 0px;">
		<tr>
			<td style="border-bottom: 1px solid #C8135C;">
				<jsp:include page="top.jsp" flush="false"/>
			</td>
		</tr>
		<tr>
			<td>
				<jsp:include page="<%= contentPage %>" flush="false"/>
			</td>
		</tr>
		<tr>
			<td id="footer">
				<jsp:include page="bottom.jsp" flush="false"/>
			</td>
		</tr>
	</table>
</div>
</body>
</html>