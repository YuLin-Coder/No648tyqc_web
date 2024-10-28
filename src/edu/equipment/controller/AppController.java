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
import edu.equipment.model.Appointment;
import edu.equipment.model.Equipment;
import edu.equipment.model.Student;
import edu.equipment.model.Teacher;
import edu.equipment.service.AdminService;
import edu.equipment.service.AppService;
import edu.equipment.service.StudentService;
import edu.equipment.service.TeacherService;



@Controller()
public class AppController {
	@Autowired 
	AppService apps;	
	
	
	
	/********************************************数据******************************/
	
	//列表
		@RequestMapping("/appPage")
	    public ModelAndView appPage(HttpServletRequest request,ModelMap map){
			return new ModelAndView("app/app_list");
		} 
	@RequestMapping(value = "/selectappData", method = RequestMethod.GET)
    @ResponseBody
    public String selectappData(HttpServletRequest request,Appointment a)  {
        int page = a.getPage();
        int limit = a.getLimit();
        PageHelper.startPage(page, limit);
        List<Appointment> list=apps.findAll(a);
        PageInfo<Appointment> pageInfo = new PageInfo<Appointment>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }
	
	
	//删除
		@RequestMapping( "/delappInfo")
	    @ResponseBody
	    public String delstuInfo(HttpServletRequest request,Integer id)  {
	       apps.delUser(id);
	       return "ok";
	    }
	
	
		
		
		@RequestMapping( "/stateAppInfo")
	    @ResponseBody
	    public String stateAppInfo(HttpServletRequest request,Appointment e)  {
			Appointment t = apps.findById(e.getId());
			t.setStatus(e.getStatus());
			apps.update(t);
	       return "ok";
	    }
}
