package edu.equipment.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import edu.equipment.model.Teacher;
import edu.equipment.service.TeacherService;



@Controller()
public class TeacherController {
	@Autowired 
	TeacherService ts;		
	/********************************************数据******************************/
	//列表
		@RequestMapping("/teacherPage")
	    public ModelAndView teacherPage(HttpServletRequest request,ModelMap map){
			return new ModelAndView("teacher/teacher_list");
		} 
	@RequestMapping(value = "/selectTrData", method = RequestMethod.GET)
    @ResponseBody
    public String selectTrData(HttpServletRequest request,Teacher tr)  {
        int page = tr.getPage();
        int limit = tr.getLimit();
        PageHelper.startPage(page, limit);
        List<Teacher> list=ts.findAll(tr);
        PageInfo<Teacher> pageInfo = new PageInfo<Teacher>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }
	
	
	//删除
		@RequestMapping( "/delTrInfo")
	    @ResponseBody
	    public String delTrInfo(HttpServletRequest request,Integer id)  {
	       ts.delUser(id);
	       return "ok";
	    }
		//修改
		@RequestMapping("/toEditTrAct")
		public String toEditTrAct (Integer id,ModelMap map) throws IOException{		
			Teacher t = ts.findById(id);
			map.put("t", t);
			return "teacher/edit_teacher";
		}
	
		@RequestMapping( "/editTrInfo")
	    @ResponseBody
	    public String editTrInfo(HttpServletRequest request,Teacher tt)  {
			String msg ="";
			Teacher tr = ts.findById(tt.getId());
			/*tr.setEno(admin.getEno());
			ad.setPwd(admin.getPwd());
			ad.setRealname(admin.getRealname());*/
			List<Teacher>trs = ts.selectByEno(tt.getTno());
			if(trs.size()>1) {
				msg="repeat";	
			}else {
				tt.setCreate_date(tr.getCreate_date());
				ts.update(tt);
				msg="success";	
			}
			
	       return msg;
	    }
	
		
		@RequestMapping("/toAddTrAct")
		public String toAddTrAct (ModelMap map) throws IOException{		
			return "teacher/add_teacher";
		}
	
	
		@RequestMapping( "/addTrInfo")
	    @ResponseBody
	    public String addTrInfo(HttpServletRequest request,Teacher tr)  {
			String msg ="";
			List<Teacher>trs = ts.selectByEno(tr.getTno());
			if(trs.size()>0) {
				msg="repeat";	
			}else {
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String d = formatter.format(date);
				tr.setCreate_date(d);
				ts.insert(tr);
				msg="success";	
			}
			
	       return msg;
	    }
	
	
	
	
	
}
