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
<body>
<%
	request.setCharacterEncoding("utf-8");
	String student_name[] = request.getParameterValues("name[]");
	
	for(int i = 0; i < student_name.length; i++) {
		student_name[i] = new String(student_name[i].getBytes("ISO-8859-1"), "UTF-8"); //한글 인코딩
	}
	
	int[] rand = new int[student_name.length];
	
	for(int i = 0; i < student_name.length; i++) {
		rand[i] = (int)(Math.random()*student_name.length) + 1;
		for(int j = 0; j < i; j++) {
			if(rand[i] == rand[j]) {
				i--;
				break;
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
	try {
		String filePath = application.getRealPath("/WEB-INF/student.txt");
		String filePath2 = application.getRealPath("/WEB-INF/random.txt");
		reader = new BufferedReader(new FileReader(filePath));
		reader2 = new BufferedReader(new FileReader(filePath2));
		String str = "";
		String str2 = "";
		String student[];
		String random[];
		while ((str = reader.readLine()) != null && (str2 = reader2.readLine()) != null) {
			student = str.split(",");
			random = str2.split(",");
			for(int i = 0; i < student.length; i++) {
				out.println(student[Integer.parseInt(random[i]) - 1]);
			}
		}
	} catch (Exception e) {
		out.println(e);
	} finally {
		reader.close();
	}
%>
</body>
</html>
