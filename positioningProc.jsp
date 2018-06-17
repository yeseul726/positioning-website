<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.util.Random"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.io.BufferedWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
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
	height: 100%;
	outline: none;
	padding: 10px 15px 10px 15px;
	border: 1px solid #aeaeae;
	border-radius: 7px;
	cursor: pointer;
}
span {
	display: table-cell;
	vertical-align:middle;
	width: 100%;
	height: 100%;
}
.teacher {
	display: inline-block;
	width: 150px;
	height: 100px;
	border: 1px solid #595959;
	background-color: #cccccc;
	border-radius: 7px;
}
</style>
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
									html += "<div class='cell'></div>&nbsp;";
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
					});

	$(".section").on("click", "#studentDel", function() {
		$(this).parent().remove();
	});
	
	return false;
})
</script>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String student_name[] = request.getParameterValues("name[]");
	
	int[] rand = null;
	
	if(student_name != null){
		for(int i = 0; i < student_name.length; i++) {
			student_name[i] = new String(student_name[i].getBytes("ISO-8859-1"), "UTF-8"); //한글 인코딩
		}
		
		rand = new int[student_name.length];
		
		for(int many = 0; many < 100; many++) {
			for(int i = 0; i < student_name.length; i++) {
				rand[i] = (int)(Math.random()*student_name.length) + 1;
				for(int j = 0; j < i; j++) {
					if(rand[i] == rand[j]) {
						i--;
						break;
					}
				}
			}
		}
	}
    BufferedWriter writer = null;
    BufferedWriter writer2 = null;
    try {
    	String filePath = application.getRealPath("/WEB-INF/student.txt");
    	String filePath2 = application.getRealPath("/WEB-INF/random.txt");
    	writer = new BufferedWriter(new FileWriter(filePath));
    	writer2 = new BufferedWriter(new FileWriter(filePath2));
        for(int i = 0; i < student_name.length; i++) {
        	writer.write(student_name[i]);
        	writer2.write(String.valueOf(rand[i]));
        	//out.println(String.valueOf(rand[i]));
        	if(i != student_name.length - 1) {
        		writer.write(",");
        		writer2.write(",");
        	}
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
    	writer.flush();
    	writer.close();
    	writer2.flush();
    	writer2.close();
    }
    
    
%>
<%
	int ccnt = 0;
	BufferedReader reader = null;
	BufferedReader reader2 = null;
	int cnt = 0;
	int id = 1;
	
	/* int col = Integer.parseInt(request.getParameter("col"));
	int row = Integer.parseInt(request.getParameter("row"));
	int section = Integer.parseInt(request.getParameter("section")); */
	
	String col = request.getParameter("col");
	String row = request.getParameter("row");
	String section = request.getParameter("section");
	int studentNum = 0;
	
	try {
		String filePath = application.getRealPath("/WEB-INF/student.txt");
		String filePath2 = application.getRealPath("/WEB-INF/random.txt");
		reader = new BufferedReader(new FileReader(filePath));
		reader2 = new BufferedReader(new FileReader(filePath2));
		String str = "";
		String str2 = "";
		String student[];
		String random[];
		int studentCnt = -1;
		while ((str = reader.readLine()) != null && (str2 = reader2.readLine()) != null) {
			student = str.split(",");
			random = str2.split(",");
			studentNum = student.length;
			/* out.println(Integer.parseInt(col));
			out.println(Integer.parseInt(row));
			out.println(Integer.parseInt(section)); */
			int c = Integer.parseInt(col);
			int r = Integer.parseInt(row);
			int s = Integer.parseInt(section);
			int sn = studentNum;
			%>
			<div align='center'><br><br>
			<div class="teacher"><br><br>교 탁</div><br><br>
			<%
			if(row != null && col != null && section != null) {
				for(int i = 0; i < s; i++) {
					out.println("<div style='display: inline-block; margin: 30px;'>");
					for (int j = 0; j < r; j++) {
						for (int k = 0; k < c; k++) {
							studentCnt++;
							if(studentCnt >= sn) {
								out.println("<div class='cell'></div>&nbsp;");
							}
							else {
								out.println("<div class='cell'><span><br>" + student[Integer.parseInt(random[studentCnt]) - 1] + 
										"</span></div>&nbsp;");
							}
						}
						out.println("<br><br>");
					}
					out.println("</div>");
				}
			}
			%>
			<%
			%>
			<br><br><br><button type='button' class='btnType' onclick="location.href='main.jsp';">메인으로</button>
			<button type='button' class='btnType' onclick="location.reload();">다시배치</button>
			<%
		}
	} catch (Exception e) {
		out.println(e);
	} finally {
		reader.close();
	}
%>
</body>
</html>
