package edu.equipment.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang.StringUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import edu.equipment.model.Admin;
import edu.equipment.model.Appointment;
import edu.equipment.model.Equipment;
import edu.equipment.service.AdminService;
import edu.equipment.service.AppService;
import edu.equipment.service.EquipmentService;



@Controller()
public class AdminController {
	@Autowired 
	AdminService as;	
	@Autowired 
	AppService apps;	
	
	@Autowired 
	EquipmentService eqs;	
	@RequestMapping(value="/addPhotoAct",method = {RequestMethod.POST})
	@ResponseBody
	public  Map<String,Object>  addBannerAct( HttpServletRequest request, HttpServletResponse response,@RequestParam(value="file",required=false) MultipartFile file)throws Exception {	
		    String prefix="";
		    String dateStr="";
		    //保存上传
		     OutputStream out = null;
		    InputStream fileInput=null;
		    String filepath = "";
		    String originalName ="";
		    try{
		        if(file!=null){
		             originalName = file.getOriginalFilename();
		            prefix=originalName.substring(originalName.lastIndexOf(".")+1);
		            dateStr =  System.currentTimeMillis()/ 1000 + ""; 
		             filepath = request.getServletContext().getRealPath("/upload/") +dateStr+"." + prefix;
		            filepath = filepath.replace("\\", "/");
		            File files=new File(filepath);
		            //打印查看上传路径
		            System.out.println(filepath);
		            if(!files.getParentFile().exists()){
		                files.getParentFile().mkdirs();
		            }
		            file.transferTo(files);
		        }
		    }catch (Exception e){
		    }finally{
		        try {
		            if(out!=null){
		                out.close();
		            }
		            if(fileInput!=null){
		                fileInput.close();
		            }
		        } catch (IOException e) {
		        }
		    }
		    Map<String,Object> map2=new HashMap<>();
		    Map<String,Object> map=new HashMap<>();
		    map.put("code",0);
		    map.put("msg","1");
		    map.put("data",map2);
		    map2.put("src",dateStr+"."+prefix);
		return map;
	}
	//后台登录
	@RequestMapping("/loginInfo")
	//处理login.jsp传递的数据进行登陆校验
    public  ModelAndView loginInfo(ModelAndView mv) throws ServletException {			
			mv.setViewName("views/login");		
	
	return mv;
}
		@RequestMapping("/loginAct")
		//处理login.jsp传递的数据进行登陆校验
	    public  ModelAndView login(@RequestParam("eno")String eno, HttpServletRequest request,
	    		@RequestParam("pwd")String pwd,HttpSession session,HttpServletResponse response,ModelAndView mv) throws ServletException {			
			Admin admin=as.findByPhoneAndPwd(eno, pwd);			
			if(admin==null){
				mv.addObject("msg", "用户或者密码错误");
				mv.setViewName("views/login");		
			}else{
				session.setAttribute("admin", admin);		
				mv.setViewName("views/index");						
			}
		
		return mv;
	}
		
		//跳转到控制台
		@RequestMapping("/toConsoleAct")
		public String toConsoleAct (ModelMap map) throws IOException{	
			
			
			return "views/console";
		}

		@RequestMapping("/report1Data")
		@ResponseBody
		public Map<String, Integer> report1Data(){
			Map<String, Integer> map = new HashedMap();
			
			Equipment e = new Equipment();
			e.setStatus("1");
			List<Equipment> Equipments = eqs.findAll(e);
			for(Equipment s : Equipments) {
				map.put(s.getTitle(),s.getStock());
			}
			return map;
		}
	
	//管理员编辑个人信息
	@RequestMapping("/findMyInfoAct")
	public String toEditAdminAct (@RequestParam("id") Integer id,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Admin record=as.findById(id);
		request.setAttribute("admin", record);
		return "views/edit_admin";
	}
	@RequestMapping("/updateAdminAct")
	public String updateAdmin(HttpSession session,HttpServletRequest request,HttpServletResponse response,Admin admin)throws Exception{
		
		Admin user=(Admin)request.getSession().getAttribute("admin");
		if(user==null) {
			PrintWriter out = response.getWriter();					
			out.write("<script>");
			out.write("alert('请先登录 ')");
			out.write("location.href='toLoginOutAct'");
			out.write("</script>");			
			
		}else {
			user.setPhoto(admin.getPhoto());
			user.setRealname(admin.getRealname());
			as.update(user);
			request.setAttribute("admin", user);
		}
		return "views/update_success";
	}
	
	@RequestMapping("/findMyLoginInfoAct")
	public String findMyLoginInfoAct (@RequestParam("id") Integer id,HttpServletRequest request,HttpServletResponse response) throws IOException{
		Admin record=as.findById(id);
		request.setAttribute("admin", record);
		return "views/edit_adminLogin";
	}
	@RequestMapping("/updateAdminLoginAct")
	@ResponseBody
	public String updateAdminLoginAct(HttpSession session,HttpServletRequest request,HttpServletResponse response,Admin admin)throws Exception{
		String msg="";
		Admin user=(Admin)request.getSession().getAttribute("admin");
		if(user==null) {
			msg="nologin";	
			
		}else {
			user.setPwd(admin.getPwd());
			as.update(user);
			msg="success";	
		}
		return msg;
	}
	
	@RequestMapping("toLoginOutAct")
	public String toLoginOutAct(HttpSession session) {
		session.removeAttribute("user");
		return "views/login";
	}
	
	
	/********************************************管理员数据******************************/
	
	//管理员列表
		@RequestMapping("/adminPage")
	    public ModelAndView adminPage(HttpServletRequest request,ModelMap map){
			Admin user=(Admin)request.getSession().getAttribute("admin");
			map.put("admin", user);
			return new ModelAndView("admin/admin_list");
		} 
	@RequestMapping(value = "/selectAminData", method = RequestMethod.GET)
    @ResponseBody
    public String selectAminData(HttpServletRequest request,Admin amin)  {
		Admin user=(Admin)request.getSession().getAttribute("admin");
        int page = amin.getPage();
        int limit = amin.getLimit();
        PageHelper.startPage(page, limit);
        List<Admin> list=as.findAll(amin);
        for(Admin a : list) {
        	if(a.getId() == user.getId()) {
        		a.setState("1");
        	}else {
        		a.setState("0");
        	}
        }
        PageInfo<Admin> pageInfo = new PageInfo<Admin>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }
	
	
	//删除
		@RequestMapping( "/delAminInfo")
	    @ResponseBody
	    public String delAminInfo(HttpServletRequest request,Integer id)  {
	       as.delUser(id);
	       return "ok";
	    }
		//修改
		@RequestMapping("/toEditAminAct")
		public String toEditAminAct (Integer id,ModelMap map) throws IOException{		
			Admin admin = as.findById(id);
			map.put("admin", admin);
			return "admin/edit_admin";
		}
	
		@RequestMapping( "/editAdminInfo")
	    @ResponseBody
	    public String editUserYueInfo(HttpServletRequest request,Admin admin)  {
			String msg ="";
			/*Admin ad = as.findById(admin.getId());
			ad.setEno(admin.getEno());
			ad.setPhoto(admin.getPhoto());
			ad.setPwd(admin.getPwd());
			ad.setRealname(admin.getRealname());*/
			System.out.print(admin.getPhoto());
			List<Admin>admins = as.selectByEno(admin.getEno());
			if(admins.size()>1) {
				msg="repeat";	
			}else {
				as.update(admin);
				msg="success";	
			}
			
	       return msg;
	    }
	
		
		@RequestMapping("/toAddAdminAct")
		public String toAddAdminAct (ModelMap map) throws IOException{		
			return "admin/add_admin";
		}
	
	
		@RequestMapping( "/addAdminInfo")
	    @ResponseBody
	    public String addAdminInfo(HttpServletRequest request,Admin admin)  {
			String msg ="";
			List<Admin>admins = as.selectByEno(admin.getEno());
			if(admins.size()>0) {
				msg="repeat";	
			}else {
				as.insert(admin);
				msg="success";	
			}
			
	       return msg;
	    }
	
	
	
	
	
}
