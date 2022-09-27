<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body> 
   <table width="500" align="center">
     <tr>
       <td> 제목 </td>
       <td> ${bdto.title} </td>
     </tr>
     <tr>
       <td> 내용 </td>
       <td> ${bdto.content} </td>
     </tr>
     <tr>
       <td> 그림 </td>
       <td>
       <c:forEach items="${img}" var="bb">
          <img src="resources/img/${bb}" width="100"> <p>
       </c:forEach>
       </td>
     </tr>
     <tr>
       <td colspan="2" align="center">
         <a href="update?id=${bdto.id}"> 수정 </a>
         <a href="delete?id=${bdto.id}"> 삭제 </a>
         <a href="list"> 목록 </a>
       </td>
     </tr>
   </table>

</body>
</html>