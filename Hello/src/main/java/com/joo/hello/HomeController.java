package com.joo.hello;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@ResponseBody
	//viewpage의 경로를 찾는게 아닌 문자열을 응답하기 위해서
	@RequestMapping("/test/json1")
	public String json1() {
		return "{\"num\":1, \"name\":\"kim\", \"addr\":\"seoul\"}";
	}
	
	
	//viewpage의 경로를 찾는게 아닌 문자열을 응답하기 위해서
	@ResponseBody
	@RequestMapping("/test/json2")
	public List<String> json2() {
		List<String> names = new ArrayList();
		names.add("또꾸");
		names.add("주도일");
		names.add("딱찌");
		return names;
	}
	
	@RequestMapping("/home.do")
	public String home(HttpServletRequest req) {
		req.setAttribute("fortuneEveryDay", "홈!!!!");
		return "home";
	}
	
	@RequestMapping("/list.do")
	public String boardList(){
		return "board_list";
	}
}
