package kr.co.hb.main.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hb.main.dto.MainDTO;
import kr.co.hb.main.service.MainService;
import kr.co.hb.member.dto.MemberDTO;

@Controller
public class MainController {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired MainService service;
	
	@RequestMapping(value="/")
	public String main(Model model) {
		return "main";
	}
	
	@RequestMapping(value="/gnb.go")
	public String gnb(Model model) {
		return "gnb";
	}
	@RequestMapping(value = "/logout.go", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("loginId");
		session.removeAttribute("adminChk");
		session.invalidate();
		return "main";
	}
	
	@RequestMapping(value = "/admin.go", method = RequestMethod.GET)
	public String admin(HttpSession session, Model model) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		if(session.getAttribute("loginId")!= null) {
			map.put("msg", "관리자 로그인이 필요한 서비스 입니다.");
		}

		return "admin";
	}
	@RequestMapping(value = "/RandomList.go", method = RequestMethod.GET)
	public String random(HttpSession session) {
		return "randomList";
	}
	@RequestMapping(value = "/noNameList.go", method = RequestMethod.GET)
	public String noNameRandom(HttpSession session) {
		return "noNameList";
	}
	@RequestMapping(value = "/idFind.go", method = RequestMethod.GET)
	public String idFind(HttpSession session) {
		return "idFind";
	}
	@RequestMapping(value = "/pwFind.go", method = RequestMethod.GET)
	public String pwFind(HttpSession session) {
		return "pwFind";
	}
	@RequestMapping(value = "/qboard.go", method = RequestMethod.GET)
	public String qboard(HttpSession session) {
		return "qBoardList";
	}	
	@RequestMapping(value = "/reportList.go", method = RequestMethod.GET)
	public String report(HttpSession session) {
		return "reportList";
	}
	@RequestMapping(value = "/secretList.go", method = RequestMethod.GET)
	public String secret(HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
	    if(session.getAttribute("loginId")!= null) {
	         map.put("msg", "관리자 로그인이 필요한 서비스 입니다.");
	    }
		return "secretList";
	}
	
	@RequestMapping(value = "pwFind2.go", method = RequestMethod.GET)
	public String pwFind2(Model model, HttpSession session, @RequestParam String id, @RequestParam String phone) {
		String page = "pwFind2";
		logger.info(id,phone);
		
		MainDTO dto = service.pwFind2(id,phone);
		
		if(dto != null) {
			model.addAttribute("chkreq",dto.getChkreq());
			model.addAttribute("id",id);
			session.setAttribute("chkreq",dto.getChkreq());
			session.setAttribute("id",id);
		}		
		if(dto == null) {
			String result = "해당 아이디와 번호에 맞는 회원정보가 없습니다.";
			model.addAttribute("result",result);
			page = "pwFind";
		}		
		return page;
	}
	
	@RequestMapping(value = "pwFind3.go", method = RequestMethod.GET)
	public String pwFind3(Model model, HttpSession session, @RequestParam String id, @RequestParam String chkreq, @RequestParam String chkresp) {
		logger.info(id,chkresp);
		String page = "pwFind2";
		
		MainDTO dto = service.pwFind3(id,chkresp);
		
		if(dto != null) {
			model.addAttribute("msg","비밀번호가 1111로 변경되었습니다.");
			service.pwFind4(id);
			page = "main";
		}		
		if(dto == null) {
			model.addAttribute("msg","해당 아이디에 대한 답변이 틀렸습니다.");
			
		}		
		return page;
	}
	
	
	@RequestMapping(value="/idFind.do", method = RequestMethod.GET)
	public String idFind2(@RequestParam HashMap<String, String> params, Model model){
		logger.info("idFind2 : "+ params);
		ArrayList<MainDTO> findId = service.idFind2(params);
		
		logger.info("findId : "+ findId);
		model.addAttribute("findId",findId);
		return "idFind";
	}
}
	

