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
import edu.equipment.model.Student;
import edu.equipment.model.Teacher;
import edu.equipment.service.AdminService;
import edu.equipment.service.StudentService;
import edu.equipment.service.TeacherService;



@Controller()
public class StudentController {
	@Autowired 
	StudentService sts;	
	
	
	
	/********************************************数据******************************/
	
	//列表
		@RequestMapping("/stuPage")
	    public ModelAndView stuPage(HttpServletRequest request,ModelMap map){
			return new ModelAndView("student/student_list");
		} 
	@RequestMapping(value = "/selectstuData", method = RequestMethod.GET)
    @ResponseBody
    public String selectstuData(HttpServletRequest request,Student stu)  {
        int page = stu.getPage();
        int limit = stu.getLimit();
        PageHelper.startPage(page, limit);
        List<Student> list=sts.findAll(stu);
        PageInfo<Student> pageInfo = new PageInfo<Student>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }
	
	
	//删除
		@RequestMapping( "/delstuInfo")
	    @ResponseBody
	    public String delstuInfo(HttpServletRequest request,Integer id)  {
	       sts.delUser(id);
	       return "ok";
	    }
		//修改
		@RequestMapping("/toEditstuAct")
		public String toEditstuAct (Integer id,ModelMap map) throws IOException{		
			Student t = sts.findById(id);
			map.put("t", t);
			return "student/edit_student";
		}
	
		@RequestMapping( "/editstuInfo")
	    @ResponseBody
	    public String editstuInfo(HttpServletRequest request,Student tt)  {
			String msg ="";
			Student stu = sts.findById(tt.getId());
			/*tr.setEno(admin.getEno());
			ad.setPwd(admin.getPwd());
			ad.setRealname(admin.getRealname());*/
			List<Student>ts = sts.selectByEno(tt.getStuno());
			if(ts.size()>1) {
				msg="repeat";	
			}else {
				tt.setRegiste_time(stu.getRegiste_time());
				sts.update(tt);
				msg="success";	
			}
			
	       return msg;
	    }
	
		
		@RequestMapping("/toAddstuAct")
		public String toAddstuAct (ModelMap map) throws IOException{		
			return "student/add_student";
		}
	
	
		@RequestMapping( "/addstuInfo")
	    @ResponseBody
	    public String addTrInfo(HttpServletRequest request,Student tr)  {
			String msg ="";
			List<Student>trs = sts.selectByEno(tr.getStuno());
			if(trs.size()>0) {
				msg="repeat";	
			}else {
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String d = formatter.format(date);
				tr.setRegiste_time(d);
				sts.insert(tr);
				msg="success";	
			}
			
	       return msg;
	    }
	
	
	
	
	
}
