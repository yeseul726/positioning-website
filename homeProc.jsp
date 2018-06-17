<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {
	font-family: 'Nanum Gothic';
}
h2 {
	font-family: 'Nanum Gothic';
}
.cell {
	display: inline-block;
	width: 100px;
	height: 70px;
	border: 1px solid #595959;
	background-color: #FFFFFF;
	border-radius: 7px;
}
.btnType {
	display: inline-block;
	background-color: #ffffff;
	color: #303030;
	height: 95%;
	outline: none;
	padding: 10px 15px 10px 15px;
	border: 1px solid #aeaeae;
	border-radius: 7px;
	cursor: pointer;
}
input {
	padding: 10px;
	border: 1px solid #aeaeae;
	border-radius: 7px;
	outline: none;
}
table .tb_section {
	border-collapse: collapse;
	height: 70px;
}
</style>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script>
	var cnt = 0;
	
	$(function() {
		$("#sectionAdd")
				.click(
						function() {
							col = document.getElementById("col").value;
							row = document.getElementById("row").value;
							if (col != "" && row != "") {
								cnt++;
								var html = "<div align='center' style='display: inline-block'>"
										+ cnt + "분단<br><br>";
								for (var i = 0; i < row; i++) {
									for (var j = 0; j < col; j++) {
										html += "<div class='cell'></span></div>&nbsp;";
									}
									html += "<br>";
								}
								html += '<button type="button" id="btnDel" class="btnType">X</button></div>&nbsp;&nbsp;&nbsp;&nbsp;';
							} else {
								alert("입력란을 모두 채워주세요.");
							}
							$(".section").append(html);
						});

		$(".section").on("click", "#btnDel", function() {
			cnt--;
			$(this).parent().remove();
		});
	})
	
	$(function() {
		$("#studentAdd")
				.click(
						function() {
							var col = document.getElementById("col").value;
							var row = document.getElementById("row").value;
							var section = document.getElementById("section").value;
							var student = document.getElementById("studentNum").value;
							if((col * row * section) >= student) {
								studentNum = document.getElementById("studentNum").value;
								if (studentNum != "") {
									var html = "<br><br><form action='positioning.jsp' method='post'>" +
									"<div align='center' style='display: inline-block'>";
									for (var i = 0; i < studentNum; i++) {
										html += "<input type='text' name='name[]'>&nbsp;&nbsp;"
										if((i + 1) % 5 == 0) html += "<br><br>";
									}
									html += "<button type='button' id='studentDel' class='btnType'>X</button></div>" +
									"<input type='hidden' name='col' value="+ col +"><input type='hidden' name='row' value="+ row +">"
									+ "<input type='hidden' name='section' value="+ section +">" +
									"<input type='hidden' name='studentNum' value="+ studentNum +">" +
									"<button type='submit' class='btnType' id='positioning'>배치하기</button></form>";
								} else {
									alert("학생 수를 입력해주세요.");
								}
								$(".section").append(html);
								$(".solo").focusin(function(){
									$(".studentNum").prop("disabled", true);
								});
							} else {
								alert("배치된 자리보다 학생 수가 더 많습니다.");
							}
						});

		$(".section").on("click", "#studentDel", function() {
			$(this).parent().remove();
		});
		
		return false;
	})
</script>
</head>
<body>



<br><br>
	<div align="center" class="section">
		<table class="tb_section">
			<tr>
				<td style="font-size: 15pt; width: 100px;">칸 : </td>
				<td><input type="number" id="col" min="1"><!-- 칸 --></td>
				<!-- <td rowspan="2"><button type="button" id="sectionAdd" class="btnType">추가</button></td> -->
			</tr>
			<tr>
				<td style="font-size: 15pt;">줄 : </td>
				<td colspan="3"><input type="number" id="row" min="1"><!-- 줄 --></td>
			</tr>
			<tr>
				<td style="font-size: 15pt;">분단 수 : </td>
				<td colspan="3"><input type="number" id="section" min="1"><!-- 분단 수 --></td>
			</tr>
			<tr>
				<td style="font-size: 15pt;">학생 수 : </td>
				<td><input type="number" id="studentNum" min="1"><!-- 학생 수 --></td>
				<td rowspan="3"><button type="button" class="btnType" id="studentAdd">생성</button></td>
			</tr>
		</table>
		<br>
		<!-- 학생 수가 홀수일 경우, 혼자 앉을 학생을 지정하시겠습니까? <input type="checkbox" id="odd"> -->
	</div>
</body>
</html>
