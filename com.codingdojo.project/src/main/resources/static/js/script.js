// INDEX - POPUP
function onPopup(element){
	if(document.querySelector('.loginWrap.active')){
		document.querySelector('.loginWrap.active').classList.remove('active');
	}
	if(document.querySelector('.registorWrap.active')){
		document.querySelector('.registorWrap.active').classList.remove('active');
	}
	var ele = document.querySelector('.'+element);
	
	if(ele.classList.contains('active')){
		ele.classList.remove('active');
	}else{
		ele.classList.add('active');
	}	
}

function onPopupRemove(element){
	var ele = document.querySelector('.'+element);
	
	if(ele.classList.contains('active')){
		ele.classList.remove('active');
	}else{
		ele.classList.add('active');
	}
	
}

//addExpense

function addExpense(event){
	event.preventDefault();
	// var newInput ='<input type="hidden" 
}