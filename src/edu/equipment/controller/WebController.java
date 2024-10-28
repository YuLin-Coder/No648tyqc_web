package edu.equipment.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import com.alibaba.fastjson.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.model.Model;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import edu.equipment.model.Admin;
import edu.equipment.model.Appointment;
import edu.equipment.model.Board;
import edu.equipment.model.Equipment;
import edu.equipment.model.Student;
import edu.equipment.model.Teacher;
import edu.equipment.service.AdminService;
import edu.equipment.service.AppService;
import edu.equipment.service.BoardService;
import edu.equipment.service.EquipmentService;
import edu.equipment.service.StudentService;
import edu.equipment.service.TeacherService;

@Controller
public class WebController {
	@Autowired 
	AdminService as;
	
	@Autowired 
	StudentService sts;	
	
	@Autowired 
	TeacherService ts;
	@Autowired 
	BoardService boardService;
	@Autowired 
	EquipmentService eqs;	
	@Autowired 
	AppService apps;	
	
	//首页
	@RequestMapping("/webIndex")
    public ModelAndView webIndex(HttpSession session,ModelMap map ){
		Student u = (Student)session.getAttribute("student");	
			Equipment e = new Equipment();
			e.setStatus("1");
			 List<Equipment> list=eqs.findAll(e);
			 map.put("dataTotal1",list.size());
			 map.put("dataSize",8);
			 map.put("list",list);
			 map.put("user",u);
		return new ModelAndView("web/product");
	} 
	//学生登录
	@RequestMapping("/toWebLoginstu")
	public String toWebLogin() {
		return "web/login";
	}
	
	//详情页
	@RequestMapping("/boardDetail")
	public String boardDetail(HttpSession session,HttpServletRequest request,Integer id) {
		Board board=boardService.queryById(id);
		Admin admin=as.findById(board.getUid());
		request.setAttribute("board",board);
		request.setAttribute("admin",admin);
		return "web/board_detail";
	}
	
	@RequestMapping("/webLoginstu")
	//处理login.jsp传递的数据进行登陆校验
     public  ModelAndView webLogin(@RequestParam("stuno")String stuno,
		 HttpServletRequest request,@RequestParam("pwd")String pwd,
		 HttpSession session,HttpServletResponse response,ModelAndView mv,ModelMap map) throws ServletException, IOException {			
			Student u = sts.findByPhoneAndPwd(stuno,pwd);
			if(u==null ){
				mv.addObject("msg", "用户或者密码错误");
				mv.setViewName("web/login");		
			}else{
				session.setAttribute("student", u);	
				Equipment e = new Equipment();
				e.setStatus("1");
				 List<Equipment> list=eqs.findAll(e);
				 map.put("dataTotal1",list.size());
				 map.put("dataSize",8);
				 map.put("list",list);
				 map.put("user",u);
				 map.put("loginstate", "1");
				 session.setAttribute("loginstate", "1");	
				mv.setViewName("web/product");						
			}
		
		return mv;
	}
	@RequestMapping("/webProduct")
	public String webProduct(HttpSession session,ModelMap map) {
		Equipment p = new Equipment();
		 p.setStatus("1");
		 List<Equipment> list=eqs.findAll(null);
		 map.put("dataTotal1",list.size());
		 map.put("dataSize",8);
		 map.put("list",list);
		 Admin u = (Admin)session.getAttribute("user");
		 map.put("user",u);
		 String loginstate = (String) session.getAttribute("loginstate");
		 map.put("loginstate",loginstate);
		return "web/product";
	}
	
	//教师端
	@RequestMapping("/toWebLogintec")
	public String toWebLogintec() {
		return "web/logintec";
	}
	@RequestMapping("/webLogintec")
	//处理login.jsp传递的数据进行登陆校验
     public  ModelAndView webLogintec(@RequestParam("tno")String tno,
		 HttpServletRequest request,@RequestParam("pwd")String pwd,
		 HttpSession session,HttpServletResponse response,ModelAndView mv,ModelMap map) throws ServletException, IOException {			
			Teacher u = ts.findByPhoneAndPwd(tno,pwd);
			if(u==null ){
				mv.addObject("msg", "用户或者密码错误");
				mv.setViewName("web/login");		
			}else{
				session.setAttribute("teacher", u);	
				Equipment e = new Equipment();
				e.setStatus("1");
				 List<Equipment> list=eqs.findAll(e);
				 map.put("dataTotal1",list.size());
				 map.put("dataSize",8);
				 map.put("list",list);
				 map.put("teacher",u);
				 map.put("loginstate", "2");
				 session.setAttribute("loginstate", "2");	
				mv.setViewName("web/product");						
			}
		
		return mv;
	}
	@RequestMapping("/webLoginOut")
	public String webLoginOut(HttpSession session,ModelMap map) {
		session.removeAttribute("loginstate");
		session.removeAttribute("student");
		session.removeAttribute("teacher");
		Equipment e = new Equipment();
		e.setStatus("1");
		 List<Equipment> list=eqs.findAll(e);
		 map.put("dataTotal1",list.size());
		 map.put("dataSize",8);
		 map.put("list",list);
		return "web/product";
	}
	//注册
	
	@RequestMapping("/toWebRegister")
	public String toWebRegister() {
		return "web/register";
	}
	@RequestMapping("/webRegister")
	//处理login.jsp传递的数据进行登陆校验
     public  ModelAndView webRegister(HttpServletRequest request,Student s,ModelAndView mv) throws ServletException{			
			List<Student>users = sts.selectByEno(s.getStuno());
		
			if(users.size()>0){
				mv.addObject("msg", "学号重复 ，请重试");
				mv.setViewName("web/register");		
			}else{
				;
				Date date = new Date();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String d = formatter.format(date);
				s.setRegiste_time(d);
				sts.insert(s);
				
				mv.setViewName("web/login");						
			}
		
		return mv;
	}	
	
	
	
	
	
	
	@RequestMapping(value = "/selectWebProductData", method = RequestMethod.GET)
	@ResponseBody
    public String technologylistData(HttpServletRequest request, Equipment p){
        String ret = "";
        JSONObject json = new JSONObject();
        try {
        	 int page = p.getPage();
             int limit = p.getLimit();
             PageHelper.startPage(page, limit);
             p.setStatus("1");
             List<Equipment> list=eqs.findAll(p);
             PageInfo<Equipment> listPage = new PageInfo<Equipment>(list);
            ret = json.toJSONString(listPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }
	
	@RequestMapping("/webProductDetail")
	public String webProductDetail(HttpSession session,ModelMap map,Integer id) {
		Equipment p = eqs.findById(id);
		map.put("p", p);
		List<Board> list=boardService.findAll(null);
		 if(list.size()>5) {
			 list= list.subList(0, 4);
			}
		 map.put("list",list);
		 String loginstate = (String) session.getAttribute("loginstate");
		 map.put("loginstate",loginstate);
		return "web/detail";
	}
	
	

	
	@RequestMapping("/toaddorder")
	public String toaddorder(HttpSession session,ModelMap map,Integer id) {
		
		return "web/add_order";
	}
	
	@RequestMapping( "/addOrderInfo")
    @ResponseBody
    public String addequInfo(HttpServletRequest request,Appointment e)  {
		Student user=(Student)request.getSession().getAttribute("student");
		Teacher tec=(Teacher)request.getSession().getAttribute("teacher");
		String state=(String)request.getSession().getAttribute("loginstate");
		String msg ="";
			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			String d = formatter.format(date);
			SimpleDateFormat formatter2 = new SimpleDateFormat("yyyyMMddhhmmss");
			String d2 = formatter2.format(date);
			e.setOrder_no(d2);
			e.setCreate_date(d);
			e.setStatus("2");
			e.setCode("0");
			if(StringUtils.equals(state,"1")) {
				e.setState("1");
				e.setStuno_or_tno(user.getStuno());
				e.setUid(user.getId());
			}else {
				e.setState("2");
				e.setStuno_or_tno(tec.getTno());
				e.setUid(tec.getId());
			}
			Equipment eq = eqs.findById(e.getE_id());
			if(eq.getStock()>e.getQuantity()) {
				
				apps.insert(e);
				eq.setStock(eq.getStock() - e.getQuantity());
				eqs.update(eq);
				msg="success";	
			}else {
				msg="nonum";	
			}
			
		
       return msg;
    }
	
	//公告
	@RequestMapping("/webNews")
	public String webNews(HttpSession session,ModelMap map) {
		List<Board> list=boardService.findAll(null);
		 map.put("dataTotal1",list.size());
		 map.put("dataSize",8);
		 if(list.size()>5) {
			 list= list.subList(0, 4);
			}
		 map.put("list",list);
		 Admin u = (Admin)session.getAttribute("user");
		
		 map.put("user",u);
		 String loginstate = (String) session.getAttribute("loginstate");
		 map.put("loginstate",loginstate);
		return "web/board";
	}
	@RequestMapping(value = "/selectWebNewsData", method = RequestMethod.GET)
	@ResponseBody
    public String selectWebNewsData(HttpServletRequest request, Board p){
        String ret = "";
        JSONObject json = new JSONObject();
        try {
        	 int page = p.getPage();
             int limit = p.getLimit();
             PageHelper.startPage(page, limit);
             List<Board> list=boardService.findAll(p);
             PageInfo<Board> listPage = new PageInfo<Board>(list);
            ret = json.toJSONString(listPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }
	
	
	/**********************************************************个人中心*********************************************/
	@RequestMapping("/toWebSetInfo")
	public  ModelAndView toWebSetInfo(HttpServletRequest request,
			 HttpSession session,HttpServletResponse response,ModelAndView mv,ModelMap map ) throws ServletException, IOException {		
		
			String loginstate =(String) session.getAttribute("loginstate");	
			if(StringUtils.equals("1", loginstate)) {
				Student s = (Student) session.getAttribute("student");	
				if(s==null){
					mv.setViewName("web/login");		
				}else{
					Student student = sts.findById(s.getId());
					map.put("student", student);		
					mv.setViewName("web/set");						
				}
			}else {
				Teacher t = (Teacher) session.getAttribute("teacher");	
				if(t==null){
					mv.setViewName("web/logintec");		
				}else{
					Teacher teacher = ts.findById(t.getId());
					map.put("teacher", teacher);		
					mv.setViewName("web/settec");						
				}
			}
			
		
		return mv;
	}
	
	
	@RequestMapping("/updateWebUserInfo")
	public String updateWebUserInfo(HttpSession session,HttpServletRequest request,@ModelAttribute Student record,ModelMap map)throws Exception{
		System.out.print(record);	
		Student user = sts.findById(record.getId());
       user.setPhone(record.getPhone());
       user.setNickname(record.getNickname());
       user.setBj(record.getBj());
       user.setRealname(record.getRealname());
       user.setMajor(record.getMajor());
       user.setSex(record.getSex());
       sts.update(user);
        map.put("student", user);
        session.setAttribute("student", user);
		return "web/set";
	}
	@RequestMapping("/updateWebUserPwd")
	public String updateWebUserPwd(HttpSession session,HttpServletRequest request,@ModelAttribute Student record,ModelMap map)throws Exception{
		System.out.print(record);	
		Student user = sts.findById(record.getId());
		user.setPwd(record.getPwd());
       
        sts.update(user);
        map.put("student", user);
        session.setAttribute("student", user);
		return "web/set";
	}
	
	@RequestMapping("/updateWebUserTX")
	public String updateWebUserTX(HttpSession session,HttpServletRequest request,@ModelAttribute Admin record,ModelMap map)throws Exception{
		System.out.print(record);	
		Student user = sts.findById(record.getId());
       user.setPhoto(record.getPhoto());
       
       sts.update(user);
        map.put("student", user);
        session.setAttribute("student", user);
		return "web/set";
	}
	//
	@RequestMapping("/toMyWebOrders")
	public  ModelAndView toMyWebComment(HttpServletRequest request,
		 HttpSession session,HttpServletResponse response,ModelAndView mv,ModelMap map,Appointment app ) throws ServletException, IOException {			
		Student u = (Student)session.getAttribute("student");
		if(u==null){
			mv.setViewName("web/login");		
		}else{
			map.put("student", u);	
			app.setUid(u.getId());
			List<Appointment> list=apps.findMyAll(app);
			 map.put("dataTotal1",list.size());
			 map.put("dataSize",8);
			mv.setViewName("web/my_orders");						
		}
		return mv;
	}
	@RequestMapping(value = "/selectWebMyOrdersData", method = RequestMethod.GET)
	@ResponseBody
    public String selectWebMyOrdersData( HttpSession session,HttpServletRequest request, Appointment app){
        String ret = "";
        JSONObject json = new JSONObject();
        try {
        	 int page = app.getPage();
             int limit = app.getLimit();
             PageHelper.startPage(page, limit);
             Student u = (Student)session.getAttribute("student");
             app.setUid(u.getId());
             app.setState("1");
             List<Appointment> list=apps.findMyAll(app);
             PageInfo<Appointment> listPage = new PageInfo<Appointment>(list);
            ret = json.toJSONString(listPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }
	
	@RequestMapping("/buyMyOrders")
	@ResponseBody
	public String buyMyOrders(HttpSession session,HttpServletRequest request,@RequestParam("id") Integer id)throws Exception{
		String msg = "";
		 Student u = (Student)session.getAttribute("student");
		if(u==null){
			msg =  "nologin";
		}else {
			Appointment app = apps.findById(id);
			app.setCode("1");
			Equipment eq = eqs.findById(app.getE_id());
			eq.setStock(eq.getStock()+app.getQuantity());
			apps.update(app);
			eqs.update(eq);
			msg = "ok";
		}
		return msg;
	}
	
	
	/******************************************************教师********************************************************/
	
	@RequestMapping("/updateWebUserInfotec")
	public String updateWebUserInfotec(HttpSession session,HttpServletRequest request,@ModelAttribute Teacher record,ModelMap map)throws Exception{
		System.out.print(record);	
		Teacher user = ts.findById(record.getId());
       user.setPhone(record.getPhone());
       user.setName(record.getName());
       user.setAge(record.getAge());
       user.setEducation(record.getEducation());
       user.setInsitute(record.getInsitute());
       user.setSex(record.getSex());
       user.setJob(record.getJob());
       ts.update(user);
        map.put("teacher", user);
        session.setAttribute("teacher", user);
		return "web/settec";
	}
	@RequestMapping("/updateWebUserPwdtec")
	public String updateWebUserPwdtec(HttpSession session,HttpServletRequest request,@ModelAttribute Teacher record,ModelMap map)throws Exception{
		System.out.print(record);	
		Teacher user = ts.findById(record.getId());
		user.setPwd(record.getPwd());
       
        ts.update(user);
        map.put("teacher", user);
        session.setAttribute("teacher", user);
		return "web/settec";
	}
	
	@RequestMapping("/updateWebUserTXtec")
	public String updateWebUserTXtec(HttpSession session,HttpServletRequest request,@ModelAttribute Teacher record,ModelMap map)throws Exception{
		System.out.print(record);	
		Teacher user = ts.findById(record.getId());
       user.setPhoto(record.getPhoto());
       
       ts.update(user);
        map.put("teacher", user);
        session.setAttribute("teacher", user);
		return "web/settec";
	}
	
	@RequestMapping("/toMyWebOrderstec")
	public  ModelAndView toMyWebOrderstec(HttpServletRequest request,
		 HttpSession session,HttpServletResponse response,ModelAndView mv,ModelMap map,Appointment app ) throws ServletException, IOException {			
		Teacher u = (Teacher)session.getAttribute("teacher");
		if(u==null){
			mv.setViewName("web/logintec");		
		}else{
			map.put("teacher", u);	
			app.setUid(u.getId());
			List<Appointment> list=apps.findMyAll(app);
			 map.put("dataTotal1",list.size());
			 map.put("dataSize",8);
			mv.setViewName("web/my_orderstec");						
		}
		return mv;
	}
	@RequestMapping(value = "/selectWebMyOrdersDatatec", method = RequestMethod.GET)
	@ResponseBody
    public String selectWebMyOrdersDatatec( HttpSession session,HttpServletRequest request, Appointment app){
        String ret = "";
        JSONObject json = new JSONObject();
        try {
        	 int page = app.getPage();
             int limit = app.getLimit();
             PageHelper.startPage(page, limit);
             Teacher u = (Teacher)session.getAttribute("teacher");
             app.setUid(u.getId());
             app.setState("2");
             List<Appointment> list=apps.findMyAll(app);
             PageInfo<Appointment> listPage = new PageInfo<Appointment>(list);
            ret = json.toJSONString(listPage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ret;
    }
	
	@RequestMapping("/buyMyOrderstec")
	@ResponseBody
	public String buyMyOrderstec(HttpSession session,HttpServletRequest request,@RequestParam("id") Integer id)throws Exception{
		String msg = "";
		Teacher u = (Teacher)session.getAttribute("teacher");
		if(u==null){
			msg =  "nologin";
		}else {
			Appointment app = apps.findById(id);
			app.setCode("1");
			Equipment eq = eqs.findById(app.getE_id());
			eq.setStock(eq.getStock()+app.getQuantity());
			apps.update(app);
			eqs.update(eq);
			msg = "ok";
		}
		return msg;
	}
}