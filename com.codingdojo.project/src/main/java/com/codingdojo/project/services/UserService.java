package com.codingdojo.project.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.project.models.LoginUser;
import com.codingdojo.project.models.User;
import com.codingdojo.project.repositories.UserRepository;



@Service
public class UserService {
	@Autowired
	private final UserRepository userRepo;
	
	public UserService(UserRepository userRepo) {
		super();
		this.userRepo = userRepo;
	}
	
	//find one User
	public User oneUser(Long id) {
		Optional<User> optUser = userRepo.findById(id);
		if(optUser.isPresent()) {
			return optUser.get();
		}else {
			return null;
		}
	}
	
	// method to register
	public User register(User newUser, BindingResult result) {
		
		if(userRepo.findByEmail(newUser.getEmail()).isPresent()) {
			result.rejectValue("email","Unquie","You better think of a new email");
		}
		if(!newUser.getPassword().equals(newUser.getConfirm())){
			result.rejectValue("confirm","Matches","Passwords do not match");
		}
		if(result.hasErrors()) {			
			return null;
		}else {
			String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashed);
			
			return userRepo.save(newUser);
		}
	}
	
	// method for login
	public User login(LoginUser newLogin, BindingResult result) {
		if(result.hasErrors()) {			
			return null;
		}
		
		Optional<User> potentiallUser = userRepo.findByEmail(newLogin.getEmail());
		if(!potentiallUser.isPresent()) {
			result.rejectValue("email","notFound","Email not found");
			return null;
		}
		
		
		User user = potentiallUser.get();
		if(!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
			result.rejectValue("password","Matches","Is this really your account?");
		}	
		
		if(result.hasErrors()) {
			return null;
		}else {
			return user;
		}	
	}
	
	public User updateUserSettings(User user) {
		Optional<User> optUser = userRepo.findById(user.getId());
		
		if(optUser.isPresent()) {
			User thisUser = optUser.get();
			
			thisUser.setFirstName(user.getFirstName());
			thisUser.setLastName(user.getLastName());
			thisUser.setEmail(user.getEmail());
			thisUser.setId(user.getId());
			thisUser.setPassword(user.getPassword());
			thisUser.setConfirm(user.getConfirm());
			
			return userRepo.save(thisUser);
		}else {
			return null;
		} 
	}
	
	public User updatePasswordSettings(User user) {
		Optional<User> optUser = userRepo.findById(user.getId());
		
		if(optUser.isPresent()) {
			User thisUser = optUser.get();
			
			thisUser.setFirstName(user.getFirstName());
			thisUser.setLastName(user.getLastName());
			thisUser.setEmail(user.getEmail());
			thisUser.setId(user.getId());
			
			String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
			thisUser.setPassword(hashed);
			thisUser.setConfirm(user.getConfirm());
			
			return userRepo.save(thisUser);
		}else {
			return null;
		} 
	}
	
}
