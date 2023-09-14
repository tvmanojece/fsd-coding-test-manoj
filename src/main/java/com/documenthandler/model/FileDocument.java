package com.documenthandler.model;

import org.bson.types.Binary;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;


@Document(collection = FileDocument.COLLECTION_NAME)
public class FileDocument {

	public static final String COLLECTION_NAME = "file_document";
	 
	@Id
	private String documentId;

	@Field
	private String documentName;

	@Field
	private Binary document;

	@Field
	private String uploadUser;

	@Field
	private String uploadDate;

	public FileDocument(String documentId) {
		this.documentId = documentId;
	}
	
	public String getDocumentId() {
		return documentId;
	}

	public void setDocumentId(String documentId) {
		this.documentId = documentId;
	}

	public String getDocumentName() {
		return documentName;
	}

	public void setDocumentName(String documentName) {
		this.documentName = documentName;
	}

	public Binary getDocument() {
		return document;
	}

	public void setDocument(Binary document) {
		this.document = document;
	}

	public String getUploadUser() {
		return uploadUser;
	}

	public void setUploadUser(String uploadUser) {
		this.uploadUser = uploadUser;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}
}