function Spinner (obj) {
	this.element = obj;
	this.posX = 0;
	this.posY = 0;
	this.offsetX = 0;
	this.offsetX = 0;
	this.element.addEventListener("touchstart", this.touchEvent.bind(this));
	this.element.addEventListener("touchmove", this.drag.bind(this));
	setTimeout(this.update.bind(this), 1000/UDFR);
	this.rotation =   0;
	this.velocity =   3;
	this.decVel   = 0.125;
	this.incVel   =   4;
};

Spinner.prototype = Draggable.prototype;

Spinner.prototype.touchEvent = function (e) {
	e.preventDefault();
	console.log("HTMLElement "+this.element.tagName.toLowerCase()+(this.element.id!="" ? "#"+this.element.id : "")+" was clicked");
	this.offsetX = Math.abs(e.changedTouches[0].pageX-this.posX);
	this.offsetY = Math.abs(e.changedTouches[0].pageY-this.posY);
	this.velocity += this.incVel;
};

Spinner.prototype.update = function() {
	this.element.style.position = "absolute";
	this.element.style.left     = this.posX+"px";
	this.element.style.top      = this.posY+"px";
	this.element.style.transform= "rotate("+this.rotation+"deg)";
	this.rotation += this.velocity;
	if(this.velocity>this.decVel) {
		this.velocity -= this.decVel;
	} else {
		this.velocity =  0;
	}
	setTimeout(this.update.bind(this), 1000/UDFR);
};