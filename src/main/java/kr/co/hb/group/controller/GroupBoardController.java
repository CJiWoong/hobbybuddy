package kr.co.hb.group.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GroupBoardController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping(value="/")
	public String list(Model model) {		
						
		return "gBoardList";
	}

}
