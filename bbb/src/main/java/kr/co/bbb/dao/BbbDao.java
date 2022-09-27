package kr.co.bbb.dao;

import java.util.ArrayList;

import kr.co.bbb.dto.BbbDto;

public interface BbbDao {
	  public void write_ok(BbbDto bdto);
	  public ArrayList<BbbDto> list();
	  public void readnum(String id);
	  public BbbDto content(String id);
	  public BbbDto update(String id);
	  public void update_ok(BbbDto bdto);
}
