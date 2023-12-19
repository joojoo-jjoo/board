package com.great.gatsby.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.great.gatsby.vo.AlgorithmVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	double[] moneyInfo = new double[21];
	double[] coinAmount = new double[21];
	double[] coinPrice = new double[21];
	@Override
	public ArrayList calculate(AlgorithmVO algorithmVO) {
		double currentPrice = algorithmVO.getCurrentPrice();
		double gap = algorithmVO.getGap();
		double firstInput = algorithmVO.getFirstInput();
		double secondInput = algorithmVO.getSecondInput();
		
		// 이 부분에서 20개 호가창 밑까지의 코인 가격을 결정함
        coinPrice[1] = currentPrice;
        for(int i=2;i<=20;i++) {
        	coinPrice[i] = currentPrice-(gap*(i-1));
        }
        
        moneyInfo[1] = firstInput;
        moneyInfo[2] = secondInput;
        coinAmount[1] = firstInput/ coinPrice[1];
        coinAmount[2] = secondInput/ coinPrice[2];
        
        //여기서부터 호가창 3개 밑~20개 밑까지의 투입금액을 결정함
        for(int i=3;i<=20;i++) {
        	double totalCoin = 0;
        	moneyInfo[i]=(totalCoinAmount(i-1)*coinPrice[i-1]-totalMoneyInput(i-1))/(1-(coinPrice[i-1]/coinPrice[i]));
        	//이 식을 통해 바로 위 호가로 돌아갈 경우 돈이 그대로 보존됨
        	moneyInfo[i]*=1.1; // 이 식을 통해 수수료를 극복할 수 있고 흑자 전환을 시킬 수 있음. 단 투입시키는 돈을 늘린다는 전제조건임(10퍼센트)
        	coinAmount[i] = moneyInfo[i]/coinPrice[i]; //여기서 구매한 코인 갯수를 업데이트함
        }
        for(int i=3;i<=20;i++) {
        	System.out.println(i+"번째 투입해야 하는 금액:"+moneyInfo[i]);
        	System.out.println(i+"번째까지 투입한 돈 총액:"+totalMoneyInput(i));
        	System.out.println();
        }
        ArrayList result = new ArrayList<Object>();
        result.add(moneyInfo);
        result.add(coinAmount);
        result.add(coinPrice);
       
        
       return result;

	}
	
	
	public double totalMoneyInput(int index) {
    	double total=0;
    	try {
    		
    		for(int i=1;i<=index;i++) {
        		total+=moneyInfo[i];
        	}
		} catch (Exception e) {
			System.out.println("(totalMoneyInput)아마도 범위를 초과한 인덱스를 입력한 오류 발생");
		}
    	return total;
    }
	
	
    public double totalCoinAmount(int index) {
    	double total=0;
    	try {
    		
    		for(int i=1;i<=index;i++) {
        		total+=coinAmount[i];
        	}
		} catch (Exception e) {
			System.out.println("(totalCoinAmount)아마도 범위를 초과한 인덱스를 입력한 오류 발생");
		}
    	return total;
    }
}
