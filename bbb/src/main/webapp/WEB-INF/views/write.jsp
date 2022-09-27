<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  </script>
</head>
<body>
   <form method="post" action="write_ok" enctype="multipart/form-data">
     <table width="500" align="center">
       <tr>
         <td> 제 목 </td>
         <td> <input type="text" name="title" size="40"> </td>
       </tr>
       <tr>
         <td> 내 용 </td>
         <td> <textarea rows="5" cols="40" name="content"></textarea> </td>
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