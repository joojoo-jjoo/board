package com.great.gatsby.controller;

import java.util.ArrayList;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.great.gatsby.service.BoardService;
import com.great.gatsby.vo.AlgorithmVO;
import com.great.gatsby.vo.PricePerMoney;


@Controller
public class BoardController {
	@Inject
	BoardService boardService;
	//게시글 목록 화면
	@RequestMapping("/gatsbyhome")	//url값 .do는 생략!!(why? web.xml에 servlet-mapping으로 해줘서)
	public String boardList(HttpServletRequest request) {
//		List<BoardVO> list = boardService.getList();
//		request.setAttribute("list", list);
		return "/home";		//jsp파일명
	}
	
	@RequestMapping("/coin")
	public String coin(HttpServletRequest request) {
		return "/board_write";
	}
	
	@RequestMapping("/algorithm")
	public ModelAndView algorithm(AlgorithmVO algorithmVO) {
		ModelAndView model = new ModelAndView();
		
		ArrayList result = boardService.calculate(algorithmVO);
		
		double[] moneyInfo  = (double[]) result.get(0);
		double[] coinAmount = (double[]) result.get(1);
		double[] coinPrice  = (double[]) result.get(2);
		ArrayList finalResult = new ArrayList<PricePerMoney>();
		for(int i=1;i<=20;i++) {
			PricePerMoney temp = new PricePerMoney();
			temp.setCoinPrice(coinPrice[i]);
			temp.setMoney(moneyInfo[i]);
			finalResult.add(temp);
			
		}
		model.addObject("result", finalResult);
		model.setViewName("board_write");
		return model;
	}
}
