package edu.equipment.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import edu.equipment.model.Category;
import edu.equipment.model.Student;
import edu.equipment.model.Teacher;
import edu.equipment.service.AdminService;
import edu.equipment.service.CategoryService;
import edu.equipment.service.StudentService;
import edu.equipment.service.TeacherService;



@Controller()
public class CategoryController {
	@Autowired 
	CategoryService cs;	
	
	
	
	/********************************************数据******************************/
	
	//列表
		@RequestMapping("/catPage")
	    public ModelAndView stuPage(HttpServletRequest request,ModelMap map){
			return new ModelAndView("category/category_list");
		} 
	@RequestMapping(value = "/selectcatData", method = RequestMethod.GET)
    @ResponseBody
    public String selectstuData(HttpServletRequest request,Category category)  {
        int page = category.getPage();
        int limit = category.getLimit();
        PageHelper.startPage(page, limit);
        List<Category> list=cs.findAll(category);
        PageInfo<Category> pageInfo = new PageInfo<Category>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }
	
	
	//删除
		@RequestMapping( "/delcatInfo")
	    @ResponseBody
	    public String delcatInfo(HttpServletRequest request,Integer id)  {
	       cs.delUser(id);
	       return "ok";
	    }
		//修改
		@RequestMapping("/toEditcatAct")
		public String toEditcatAct (Integer id,ModelMap map) throws IOException{		
			Category t = cs.findById(id);
			map.put("t", t);
			return "category/edit_category";
		}
	
		@RequestMapping( "/editcatInfo")
	    @ResponseBody
	    public String editstuInfo(HttpServletRequest request,Category c)  {
			String msg ="";
			cs.update(c);
			msg="success";	
			
	       return msg;
	    }
	
		
		@RequestMapping("/toAddcatAct")
		public String toAddcatAct (ModelMap map) throws IOException{		
			return "category/add_category";
		}
	
	
		@RequestMapping( "/addcatInfo")
	    @ResponseBody
	    public String addcatInfo(HttpServletRequest request,Category ca)  {
			String msg ="";
			cs.insert(ca);
			msg="success";	
			
	       return msg;
	    }
	
	
	
	
	
}
