package com.codingdojo.project.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingdojo.project.models.Budget;
import com.codingdojo.project.models.Expense;
import com.codingdojo.project.models.LoginUser;
import com.codingdojo.project.models.Temporary;
import com.codingdojo.project.models.User;
import com.codingdojo.project.services.BudgetService;
import com.codingdojo.project.services.ExpenseService;
import com.codingdojo.project.services.TemporaryService;
import com.codingdojo.project.services.UserService;

@Controller
public class HomeController {
	@Autowired
	private final UserService userSer;
	private final BudgetService budSer;
	private final ExpenseService expSer;
	private final TemporaryService tempSer;
	
	public HomeController(UserService userSer, BudgetService budSer,ExpenseService expSer,TemporaryService tempSer){
		super();
		this.userSer = userSer;
		this.budSer = budSer;
		this.expSer = expSer;
		this.tempSer = tempSer;
	}
	
	// ================================ GENERAL ================================
	@GetMapping("/")
	public String index(Model model, HttpSession session) {
		if(session.getAttribute("user_id") != null ) {
			return "dashboard.jsp";
		}else {
			model.addAttribute("newUser", new User());
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
			}	
		}
			
	@GetMapping("/dashboard")
	public String dashboard(Model model, HttpSession session) {
		if(session.getAttribute("user_id") != null ) {
			Long loggedID = (Long) session.getAttribute("user_id");
			User userName = userSer.oneUser(loggedID);
			model.addAttribute("logged",userName);
		
				return "dashboard.jsp";
			}else {
				return "redirect:/";
			}
		}
	
	// ================================ LOGIN / REGISTRATION ================================
	@PostMapping("/api/register")
	public String register(@Valid @ModelAttribute("newUser") User newUser,BindingResult result, Model model, HttpSession session) {					
		userSer.register(newUser, result);	
		if(result.hasErrors()) {
			String register = "active";
			model.addAttribute("register",register);
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		}			
		session.setAttribute("user_id", newUser.getId());
		return "redirect:/dashboard";
	}
						
	@PostMapping("/api/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		User user = userSer.login(newLogin, result);
		if(result.hasErrors()) {
			String login = "active";
			model.addAttribute("login",login);
			model.addAttribute("newUser", new User());
			return "index.jsp";
		}				
		session.setAttribute("user_id", user.getId());
		return "redirect:/dashboard";
	}
	
	@GetMapping("/logout")
	public String dashboard(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
		
	// ================================ SETTINGS ===============================
	
	@GetMapping("/settings")
	public String settings(Model model, @ModelAttribute("user") User user,@ModelAttribute("password") User pass,HttpSession session) {
		Long loggedID = (Long) session.getAttribute("user_id");
		User userName = userSer.oneUser(loggedID);
		model.addAttribute("logged",userName);
		return "settings.jsp";
	}
	
	@PostMapping("/api/update/user")
	public String updateSettings(Model model, @Valid @ModelAttribute("user") User user,BindingResult result) {
		if(result.hasErrors()) {
			return "settings.jsp";
		}else {
			userSer.updateUserSettings(user);
			return "redirect:/dashboard";
		}
	}
	@PostMapping("/api/update/password")
	public String updatePassword(Model model, @Valid @ModelAttribute("password") User pass,BindingResult result) {
		if(result.hasErrors()) {
			return "settings.jsp";
		}else {
			userSer.updatePasswordSettings(pass);
			return "redirect:/dashboard";
		}
	}
	// ================================ budget ===============================
	@GetMapping("/new/smuget")
	public String newSmuget(Model model, @ModelAttribute("budget") Budget budget,HttpSession session) {
		Long loggedID = (Long) session.getAttribute("user_id");
		User userName = userSer.oneUser(loggedID);

		model.addAttribute("userName",userName);
		return "newSmuget.jsp";
	}
	
	@PostMapping("/api/add/budget")
	public String addBudgetForm(Model model, @Valid @ModelAttribute("budget") Budget budget, BindingResult result, @RequestParam("copy")Long copy,HttpSession session) {
		
		if(result.hasErrors()) {
			return "newSmuget.jsp";
		}else {
			if(budget.getTag() != null) {
				budSer.removeCurrentActive("on");
			}
			budget.setOutcome(budget.getIncome());
			Budget bud = budSer.createBudget(budget);
			
//			Date
//			int ID = (int) session.getAttribute("user_id");
//			int month = bud.getCreatedAt().getMonth() + 1;
//			int year = bud.getCreatedAt().getYear()+ 1900; 
//			
//			if(month < 10) {
//				int data = ID + year + 0 + month;
//				budget.setSearchDate(data);
//			}else {
//				int data = ID + year + month;
//				budget.setSearchDate(data);
//			}
		
			
			budSer.updateBudgetSearchDate(budget);
			
			if(copy != 0) {
				Budget expenseCopy = budSer.oneBudget(copy);
			
				for(Expense expense : expenseCopy.getExpenses()){
					Expense newExpense = new Expense();
					newExpense.setBudget(bud);
					newExpense.setCost(expense.getCost());
					newExpense.setType(expense.getType());
				
					expSer.createExpense(newExpense);
				
					bud.setOutcome(bud.getOutcome() - newExpense.getCost());
					budSer.updateIncome(bud);
				}
			}
			
			return "redirect:/expense/"+bud.getId(); 
		}
	}
	
	@GetMapping("/expense/{budID}")
	public String addExpense(Model model,@PathVariable("budID") Long budID,@ModelAttribute("expense") Expense expense) {
		model.addAttribute("budget",budSer.oneBudget(budID));
		return "addExpense.jsp";
	}
	
	@PostMapping("/api/add/expense/{budID}")
	public String addExpenseForm(Model model,@PathVariable("budID") Long budID,@Valid  @ModelAttribute("expense") Expense expense, BindingResult result) {
		Budget budget = budSer.oneBudget(budID);
		model.addAttribute("budget",budget);
		
		if(result.hasErrors()) {
			return "redirect:/expense/"+budget.getId(); 
		}else {
			budget.setOutcome(budget.getOutcome() - expense.getCost());
			budSer.updateIncome(budget);
			expSer.createExpense(expense);
			return "redirect:/expense/"+budget.getId(); 
		}
	}
	
	@GetMapping("/expense/edit/{expID}/{budID}")
	public String editBudget(Model model, HttpSession session, @PathVariable("expID") Long expID,@PathVariable("budID") Long budID,@Valid @ModelAttribute("expense") Expense expense,BindingResult result) {
		Long loggedID = (Long) session.getAttribute("user_id");
		User userName = userSer.oneUser(loggedID);
		Budget bud = budSer.oneBudget(budID);
		Expense exp = expSer.oneExpense(expID);
		model.addAttribute("exp",exp);
		model.addAttribute("bud",bud);
		model.addAttribute("userName",userName);
		return "editSmuget.jsp";
	}
	
	@PostMapping("/api/update/expense/{expID}/{budID}")
	public String updateExpense(Model model, HttpSession session,@PathVariable("expID") Long expID,@PathVariable("budID") Long budID,@Valid @ModelAttribute("expense") Expense expense,BindingResult result,@RequestParam("old")Double old ) {
		Budget bud = budSer.oneBudget(budID);
		
		if(result.hasErrors()) {
			Long loggedID = (Long) session.getAttribute("user_id");
			User userName = userSer.oneUser(loggedID);
			Expense exp = expSer.oneExpense(expID);
			model.addAttribute("exp",exp);
			model.addAttribute("bud",bud);
			model.addAttribute("userName",userName);
			return "editSmuget.jsp";
		}else {
			bud.setOutcome(bud.getOutcome() + old - expense.getCost());
			budSer.updateIncome(bud);
			expSer.updateExpense(expense);
			return "redirect:/dashboard";
		}
	}
	
	@DeleteMapping("/delete/expense/{expID}")
	 public String destroyExpense(@PathVariable("expID") Long expID) {
		expSer.deleteExpense(expID);
        return "redirect:/dashboard";
    }
	
	// ================================ Temporary ===============================
	@GetMapping("/temporary/{budID}")
	public String createTemporary(Model model,@PathVariable("budID") Long budID, @ModelAttribute("temporary") Temporary temporary,HttpSession session) {
		Long loggedID = (Long) session.getAttribute("user_id");
		Budget budget = budSer.oneBudget(budID);
		model.addAttribute("budget",budget);
		return "newTemporary.jsp";
	}
	
	@PostMapping("/api/add/temporary/{budID}")
	public String createTemporaryForm(Model model,@PathVariable("budID") Long budID,@Valid  @ModelAttribute("temporary") Temporary temporary,BindingResult result,HttpSession session) {
		Budget bud = budSer.oneBudget(budID);
		if(!result.hasErrors()) {
			tempSer.createTemp(temporary);
		}
		bud.setOutcome(bud.getOutcome() - temporary.getCost());
		budSer.updateIncome(bud);
		return "redirect:/temporary/"+bud.getId();
	}
	
	@GetMapping("/temporary/edit/{tempID}/{budID}")
	public String editTemporary(Model model, HttpSession session, @PathVariable("tempID") Long tempID,@PathVariable("budID") Long budID,@Valid @ModelAttribute("temporary") Temporary temporary,BindingResult result) {
		Long loggedID = (Long) session.getAttribute("user_id");
		User userName = userSer.oneUser(loggedID);
		Budget bud = budSer.oneBudget(budID);
		Temporary temp = tempSer.oneTemp(tempID);
		model.addAttribute("temp",temp);
		model.addAttribute("bud",bud);
		model.addAttribute("userName",userName);
		return "editTemporary.jsp";
	}
	
	@PostMapping("/api/update/temporary/{tempID}/{budID}")
	public String updateTemporary(Model model, HttpSession session,@PathVariable("tempID") Long tempID,@PathVariable("budID") Long budID,@Valid @ModelAttribute("temporary") Temporary temporary,BindingResult result, @RequestParam("old")Double old ) {
		Budget bud = budSer.oneBudget(budID);
		if(result.hasErrors()) {
			Long loggedID = (Long) session.getAttribute("user_id");
			User userName = userSer.oneUser(loggedID);
			model.addAttribute("userName",userName);
			return "editTemporary.jsp";
		}else {
			bud.setOutcome(bud.getOutcome() + old - temporary.getCost());
			budSer.updateIncome(bud);
			tempSer.updateTemporary(temporary);
			return "redirect:/dashboard";
		}
	}
	
	@DeleteMapping("/delete/temporary/{tempID}")
	 public String destroyTemporary(@PathVariable("tempID") Long tempID) {
		tempSer.deleteTemporary(tempID);
       return "redirect:/dashboard";
   }
	
	// ================================ History  ===============================
	@GetMapping("/history")
	public String history(Model model,HttpSession session) {
		Long loggedID = (Long) session.getAttribute("user_id");
		User userName = userSer.oneUser(loggedID);
		model.addAttribute("logged",userName);
		return "history.jsp";
	}
	
	@GetMapping("/history/{budID}")
	public String indvHistory(Model model,HttpSession session, @PathVariable("budID") Long budID) {
		
		Long loggedID = (Long) session.getAttribute("user_id");
		User userName = userSer.oneUser(loggedID);
		Budget budget = budSer.oneBudget(budID);
		model.addAttribute("logged",userName);
		model.addAttribute("budget",budget);
		return "indvHistory.jsp";
	}
	
	// ================================ Search ===============================
	@PostMapping("/api/search")
	public String search(Model model,@RequestParam("month")int month,@RequestParam("year")int year) {
		String data = year + "/"+ month;
		List<Budget> allBugets = budSer.findSearchResults(data);
		model.addAttribute("allBugets",allBugets);
		return "search.jsp";
	}

	// ================================ Clear ===============================
	@GetMapping("/clear")
	public String clear() {
		budSer.removeCurrentActive("on");
		return "redirect:/dashboard";
	}
}
