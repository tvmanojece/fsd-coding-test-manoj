package com.documenthandler.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.lang3.StringUtils;
import org.bson.BsonBinarySubType;
import org.bson.types.Binary;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.documenthandler.model.FileDocument;
import com.documenthandler.model.FileDocumentRepository;

@Controller
public class FileUploadController {

	@Autowired
	FileDocumentRepository fileDocumentRepository;

	@RequestMapping(value = { "/uploadFile" }, method = RequestMethod.GET)
	public ModelAndView uploadFile(Model model) {
		return new ModelAndView("uploadFile");
	}

	@ResponseBody
	@RequestMapping(value = { "/uploadFileToDB" }, method = RequestMethod.POST)
	public String uploadFileToDb(@RequestParam("file") MultipartFile file) {
		if (file.isEmpty()) {
			return "Uploaded file is empty";
		}
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			FileDocument fileDocument = new FileDocument(String.valueOf(new Random().nextInt(100000000)));
			fileDocument.setDocumentName(file.getOriginalFilename());
			fileDocument.setDocument(new Binary(BsonBinarySubType.BINARY, file.getBytes()));
			fileDocument.setUploadDate(dateFormat.format(new Date()));
			fileDocument.setUploadUser(SecurityContextHolder.getContext().getAuthentication().getName());
			fileDocumentRepository.save(fileDocument);
		} catch (Exception e) {
			// TODO: log error
			return "Document upload got failed. Please check with Administrator.";
		}
		return "Document " + file.getOriginalFilename() + " uploaded successfully";
	}

	@RequestMapping(value = { "/listFilesFromDb" }, method = RequestMethod.GET)
	public ModelAndView listFilesFromDb() {
		ModelAndView mv = new ModelAndView("showFiles");
		try {
			List<FileDocument> documents = fileDocumentRepository.findAll();
			mv.addObject("documents", documents);
			mv.addObject("totalnoofdocuments", documents.size());
		} catch (Exception e) {
			// TODO: log error
		}
		return mv;
	}

	@RequestMapping(value = { "/deleteDocument" }, method = RequestMethod.GET)
	public ModelAndView deleteDocument(String documentId) {
		ModelAndView mv = new ModelAndView("showFiles");
		try {
			if (StringUtils.isNotEmpty(documentId)) {
				fileDocumentRepository.deleteById(documentId);
			}
			List<FileDocument> documents = fileDocumentRepository.findAll();
			mv.addObject("documents", documents);
			mv.addObject("totalnoofdocuments", documents.size());

		} catch (Exception e) {
			// TODO: log error
		}
		return mv;
	}

}
