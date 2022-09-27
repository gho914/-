<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
  <script>
    function add_file() // file추가
    {
    	var fname=document.getElementsByClassName("fname");
    	var len=fname.length; // 현재 type="file"의 갯수
    	len++;
    	var inner="<p class='fname'> <input type='file' name='fname"+len+"'> </p> "; // 추가할 내용
    	    	
    	document.getElementById("outer").innerHTML=document.getElementById("outer").innerHTML+inner;
    	// $("#outer").html($("#outer").html()+inner);
    }
    function del_file() // 삭제
    {
    	var len=document.getElementsByClassName("fname").length;
    	if(len > 1)
    	{	
    	  len--;
    	  document.getElementsByClassName("fname")[len].remove();
    	}
    }
    function check(upform)
    {
   	 // checkbox가 체크된 그림파일명과 체크가 안된 그림파일명을 각각 저장
   	 var chk=document.getElementsByName("chk"); // 요소의 이름을 변수에 전달
   	 var len=chk.length; // 체크박스의 길이
   	 var del="";  // 삭제할 파일을 저장
   	 var str="";  // 삭제하지 않을 파일을 저장
   	 for(i=0;i<len;i++)
   	 {	 
   	     if(chk[i].checked) // 참 => 삭제할 파일
   		 {
   	    	 del=del+chk[i].value+",";
   		 }
   	     else   // 거짓 => 삭제하지 않겠다
   	     {
   	    	 str=str+chk[i].value+",";
   	     }	 
   		
   	 }
   	   
   	 upform.del.value=del; // 삭제파일 목록
   	 upform.str.value=str; // 보존파일 목록
        //alert(del);
        //alert(str);
        return true;
    }
  </script>
</head>
<body>
   <form method="post" action="update_ok" enctype="multipart/form-data" onsubmit="return check(this)">
     <input type="hidden" name="id" value="${bdto.id}">
     <input  type="hidden" name="del"> <!-- 삭제할 그림의 이름을 가지고 갈 변수 -->
     <input type="hidden" name="str">    <!-- 계속 남겨둘 사진의 이름을 가지고 갈 변수 -->
     <table width="500" align="center">
       <tr>
         <td> 제 목 </td>
         <td> <input type="text" name="title" size="40" value="${bdto.title}"> </td>
       </tr>
       <tr>
         <td> 내 용 </td>
         <td> <textarea rows="5" cols="40" name="content">${bdto.content}</textarea> </td>
       </tr>
       <tr>
         <td> 사진 </td>
         <td>
        <c:forEach items="${img}" var="bb">
          <img src="resources/img/${bb}" width="30" height="30" class="cimg">
          <input type="checkbox" name="chk" value="${bb}"> <!-- 삭제할 사진을 체크하시오 -->
        </c:forEach>
         </td>
       </tr>
       <tr>
         <td> 파일 </td>
         <td id="outer"> 
            <input type="button" onclick="add_file()" value="추가">
            <input type="button" onclick="del_file()" value="삭제">
            <p class="fname"> <input type="file" name="fname1"> </p> 
         </td>
       </tr>
       <tr>
         <td colspan="2" align="center"> <input type="submit" value="저장"> </td>
       </tr>
     </table>
   </form>
</body>
</html>