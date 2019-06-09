package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BaseController {

    @GetMapping("/{root}")
    public void getView() {
    }

    @GetMapping("/{root}/{view}")
    public void getView2() {
    }
	/*@GetMapping("/{root}/{root2}/{view}")
	public void getView3() {}*/
}
