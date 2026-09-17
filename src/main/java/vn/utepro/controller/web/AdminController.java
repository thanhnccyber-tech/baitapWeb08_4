package vn.utepro.controller.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @GetMapping("/category")
    public String category() { return "admin/category"; }

    @GetMapping("/product")
    public String product() { return "admin/product"; }
}