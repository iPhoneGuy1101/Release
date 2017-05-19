var UDFR = 60;

function Draggable (obj) {
	this.element = obj;
	this.posX = 0;
	this.posY = 0;
	this.offsetX = 0;
	this.offsetY = 0;
	this.element.addEventListener("touchstart", this.touchEvent.bind(this));
	this.element.addEventListener("touchmove", this.drag.bind(this));
	setTimeout(this.update.bind(this), 1000/UDFR);
};


Draggable.prototype.update = function() {
	this.element.style.position = "absolute";
	this.element.style.left     = this.posX+"px";
	this.element.style.top      = this.posY+"px";
	setTimeout(this.update.bind(this), 1000/UDFR);
};

Draggable.prototype.touchEvent = function (e) {
	e.preventDefault();
	console.log("HTMLElement "+this.element.tagName.toLowerCase()+(this.element.id!="" ? "#"+this.element.id : "")+" was clicked");
	this.offsetX = Math.abs(e.changedTouches[0].pageX-this.posX);
	this.offsetY = Math.abs(e.changedTouches[0].pageY-this.posY);
};

Draggable.prototype.drag = function(e){
	e.preventDefault();
	this.posX = e.changedTouches[0].pageX-this.offsetX;
	this.posY = e.changedTouches[0].pageY-this.offsetY;
}
