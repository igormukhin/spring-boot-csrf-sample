package org.igormukhin.samples.csrfdemoapp;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

@Controller
public class HomeController {

    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @RequestMapping("/")
    public String home() {
        return "home";
    }

    @RequestMapping(value = "/get")
    @ResponseBody
    public String get() {
        logger.info("/get called: Some private info from a GET request");
        return "Some private info from a GET request";
    }

    @RequestMapping(value = "/post", method = POST)
    @ResponseBody
    public String post() {
        logger.info("/post called: A private POST was successful");
        return "A private POST was successful";
    }

}
