package com.great.gatsby.vo;

public class AlgorithmVO {
	
	private double currentPrice;	//현재가격
	private double gap;				//gap
	private double firstInput;		//시작 투입금
	private double secondInput;		//두번째 투입금
	
	public double getCurrentPrice() {
		return currentPrice;
	}
	public void setCurrentPrice(double currentPrice) {
		this.currentPrice = currentPrice;
	}
	public double getGap() {
		return gap;
	}
	public void setGap(double gap) {
		this.gap = gap;
	}
	public double getFirstInput() {
		return firstInput;
	}
	public void setFirstInput(double firstInput) {
		this.firstInput = firstInput;
	}
	public double getSecondInput() {
		return secondInput;
	}
	public void setSecondInput(double secondInput) {
		this.secondInput = secondInput;
	}
	
}
