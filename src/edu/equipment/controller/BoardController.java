package edu.equipment.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import edu.equipment.model.Admin;
import edu.equipment.model.Board;
import edu.equipment.service.BoardService;



@Controller
public class BoardController {
	
	@Autowired 
	BoardService boardService;
	
	@RequestMapping("/boardPage")
    public ModelAndView boardPage(){
		
		return new ModelAndView("board/board_list");
	} 
	
	@RequestMapping(value = "/selectBoardData", method = RequestMethod.GET)
    @ResponseBody
    public String selectBoardData(HttpServletRequest request,Board b)  {
        int page = b.getPage();
        int limit = b.getLimit();
        PageHelper.startPage(page, limit);
        List<Board> list=boardService.findAll(b);
        PageInfo<Board> pageInfo = new PageInfo<Board>(list);
        
        JSONObject jsonObject = new JSONObject();  
        jsonObject.put("code", 0);
        jsonObject.put("msg", "");
        jsonObject.put("count", pageInfo.getTotal());
        jsonObject.put("data", pageInfo.getList());
        return jsonObject.toString();
    }

	
	@RequestMapping("/toAddBoardAct")
    public ModelAndView toAddBoardAct(){
		
		return new ModelAndView("board/add_board");
	} 	
	@RequestMapping( "/addBoardInfo")
    @ResponseBody
    public String addBoardInfo(HttpServletRequest request,HttpSession session, Board b)  {
		String msg ="";
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		String d = formatter.format(date);
		Admin a = (Admin)session.getAttribute("admin");
		b.setFbsj(d);
		b.setUid(a.getId());
		boardService.add(b);
		msg="success";	
       return msg;
    }
	
	@RequestMapping("/toEditBoardAct")
    public ModelAndView toEditBoardAct(Integer id,ModelMap map){
		Board board = boardService.findById(id);
		map.put("board", board);
		return new ModelAndView("board/edit_board");
	} 	
	@RequestMapping( "/editBoardInfo")
    @ResponseBody
    public String editBoardInfo(HttpServletRequest request, Board b)  {
		String msg ="";
		Board board = boardService.findById(b.getId());
		board.setContent(b.getContent());
		board.setTitle(b.getTitle());
		boardService.update(board);
		msg="success";	
       return msg;
    }
	
	//删除
	@RequestMapping( "/delBoardInfo")
    @ResponseBody
    public String delBoardInfo(HttpServletRequest request,Integer id)  {
		boardService.delete(id);
       return "ok";
    }
}
