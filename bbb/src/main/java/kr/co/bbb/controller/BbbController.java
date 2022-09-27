package kr.co.bbb.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.bbb.dao.BbbDao;
import kr.co.bbb.dto.BbbDto;

@Controller
public class BbbController {
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/write")
	public String write() {
		return "/write";
	}
	
	@RequestMapping("/write_ok")
	public String write_ok(HttpServletRequest request) throws IOException {
		String path=request.getRealPath("resources/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy()); 
		
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		// 파일 이름 
		Enumeration file=multi.getFileNames(); // 폼태그에서의 파일 업로드하는 태그의 name을 가지고 온다..  만약 3개 ("fname1","fname2","fname3")
		// 저장된 파일의 이름이 필요 => multi.getFilesystemName("fname1") => 서버에 저장된 파일이름을 가져온다
		// Enumeration은  hasMoreElement()를 통해 다음내용으로 이동  => nextElement()를 통해서 저장된 값을 가져온다.
		String fnames="";
		  while(file.hasMoreElements()){
		    	 String fname=file.nextElement().toString();
		    	 fnames=fnames+multi.getFilesystemName(fname)+",";
		    }
			// 테이블의 fname필드에  "파일명,파일명,파일명,"
		    // null값 없애기  "null,"
		    fnames=fnames.replace("null,", "");
			System.out.println(fnames);
			
			// DB에 저장
			BbbDto bdto=new BbbDto();
			bdto.setTitle(title);
			bdto.setContent(content);
			bdto.setFname(fnames);
			
			BbbDao bdao=sqlSession.getMapper(BbbDao.class);
			bdao.write_ok(bdto);
			
			return "redirect:/list";
	}
	
	@RequestMapping("/list")
	public String list(Model model) {
		BbbDao bdao=sqlSession.getMapper(BbbDao.class);
		ArrayList<BbbDto> list=bdao.list();
		
		model.addAttribute("list",list);
		
		return"/list";
	}
	
	@RequestMapping("/readnum")
	public String readnum(HttpServletRequest request) {
		String id=request.getParameter("id");
		BbbDao bdao=sqlSession.getMapper(BbbDao.class);
		bdao.readnum(id);
		
		return "redirect:/content?id="+id;	
	}
	
	@RequestMapping("/content")
	public String content(HttpServletRequest request,Model model) {
		 String id=request.getParameter("id");
			
		BbbDao bdao=sqlSession.getMapper(BbbDao.class);
		BbbDto bdto=bdao.content(id);
			
		// content에  <br> 추가
		bdto.setContent(bdto.getContent().replace("\r\n", "<br>"));
		// 그림파일을 배열로  "그림1.jpg, 그림2.jpg, 그림3.jpg" 
		String[] img=bdto.getFname().split(",");
			
		// img배열을  전달
		// 1. dto에 필드를 추가하여 같이 전달
		// 2. 단독으로 전달
			
		model.addAttribute("img",img);
		model.addAttribute("bdto",bdto);
		
		return "/content";
	}
	
	@RequestMapping("/update")
	public String update(HttpServletRequest request,Model model) {
        String id=request.getParameter("id");
		
		BbbDao bdao=sqlSession.getMapper(BbbDao.class);
		BbbDto bdto=bdao.update(id);  // 하나의 레코드를 읽어옴
		String[] img=bdto.getFname().split(",");
		
		model.addAttribute("bdto",bdto);
		model.addAttribute("img",img);
		return "/update";
	}
	
	@RequestMapping("/update_ok")
	public String update_ok(HttpServletRequest request) throws Exception {
		String path=request.getRealPath("resources/img");
		int size=1024*1024*10;
		MultipartRequest multi=new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy()); 
		
		Enumeration file=multi.getFileNames(); // 폼태그에서의 파일 업로드하는 태그의 name을 가지고 온다..  만약 3개 ("fname1","fname2","fname3")
		// 저장된 파일의 이름이 필요 => multi.getFilesystemName("fname1") => 서버에 저장된 파일이름을 가져온다
		// Enumeration은  hasMoreElement()를 통해 다음내용으로 이동  => nextElement()를 통해서 저장된 값을 가져온다.
		String fnames="";
		  while(file.hasMoreElements()){
		    	 String fname=file.nextElement().toString();
		    	 fnames=fnames+multi.getFilesystemName(fname)+",";
		    }
			// 테이블의 fname필드에  "파일명,파일명,파일명,"
		    // null값 없애기  "null,"
		    fnames=fnames.replace("null,", "")+multi.getParameter("str");
		
		String title=multi.getParameter("title");
		String content=multi.getParameter("content");
		int id=Integer.parseInt(multi.getParameter("id"));
	
		BbbDto bdto=new BbbDto();
		bdto.setContent(content);
    	bdto.setTitle(title);
    	bdto.setId(id);
    	bdto.setFname(fnames);
		BbbDao bdao=sqlSession.getMapper(BbbDao.class);
		bdao.update_ok(bdto);
		
		String[] del=multi.getParameter("del").split(",");
		for(int i=0;i<del.length;i++) {
			File ff=new File(path+"/"+del[i]);
			if(ff.exists())
				ff.delete();
		}
		
		return "redirect:/content?id="+id;
	}
}
