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
import edu.equipment.model.Equipment;
import edu.equipment.model.Student;
import edu.equipment.model.Teacher;
import edu.equipment.service.AdminService;
import edu.equipment.service.CategoryService;
import edu.equipment.service.EquipmentService;
import edu.equipment.service.StudentService;
import edu.equipment.service.TeacherService;



@Controller()
public class EquipmentController {
	@Autowired 
	EquipmentService eqs;	
	@Autowired 
	CategoryService cs;	
	
	
	/********************************************数据******************************/
	
	//列表
		@RequestMapping("/equPage")
	    public ModelAndView equPage(HttpServletRequest request,ModelMap map){
			return new ModelAndView("equipment/equipment_list");
		} 
	@RequestMapping(value = "/selectequData", method = RequestMethod.GET)
    @ResponseBody
    public String selectequData(HttpServletRequest request,Equipment eq)  {
        int page = eq.getPage();
        int limit = eq.getLimit();
        PageHelper.startPage(page, limit);
        List<Equipment> list=eqs.findAll(eq);
        PageInfo<Equipment> pageInfo = new PageInfo<Equipment>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }
	
	
	//删除
		@RequestMapping( "/delequInfo")
	    @ResponseBody
	    public String delequInfo(HttpServletRequest request,Integer id)  {
	       eqs.delUser(id);
	       return "ok";
	    }
		
		
		@RequestMapping( "/stateequInfo")
	    @ResponseBody
	    public String stateequInfo(HttpServletRequest request,Equipment e)  {
			Equipment t = eqs.findById(e.getId());
			t.setStatus(e.getStatus());
	       eqs.update(t);
	       return "ok";
	    }
		
		
		//修改
		@RequestMapping("/toEditequAct")
		public String toEditequAct (Integer id,ModelMap map) throws IOException{		
			Equipment t = eqs.findById(id);
			map.put("t", t);
			List<Category> c = cs.findAll(null);
			map.put("c", c);
			return "equipment/edit_equipment";
		}
	
		@RequestMapping( "/editequInfo")
	    @ResponseBody
	    public String editequInfo(HttpServletRequest request,Equipment tt)  {
			String msg ="";
			Equipment eq = eqs.findById(tt.getId());
			tt.setCreate_date(eq.getCreate_date());
			tt.setAdmin_d(eq.getAdmin_d());
			tt.setStatus(eq.getStatus());
			eqs.update(tt);
			msg="success";	
			
	       return msg;
	    }
	
		
		@RequestMapping("/toAddequAct")
		public String toAddequAct (ModelMap map) throws IOException{	
			List<Category> c = cs.findAll(null);
			map.put("c", c);
			return "equipment/add_equipment";
		}
	
	
		@RequestMapping( "/addequInfo")
	    @ResponseBody
	    public String addequInfo(HttpServletRequest request,Equipment e)  {
			Admin user=(Admin)request.getSession().getAttribute("admin");
			String msg ="";
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String d = formatter.format(date);
				e.setCreate_date(d);
				e.setStatus("1");
				e.setAdmin_d(user.getId());
				eqs.insert(e);
				msg="success";	
			
	       return msg;
	    }
	
	
	
	
	
}
