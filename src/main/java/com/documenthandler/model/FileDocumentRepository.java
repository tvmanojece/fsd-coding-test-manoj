package com.documenthandler.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface FileDocumentRepository extends CrudRepository<FileDocument, String> {
	public void deleteById (String id);
	List<FileDocument> findAll();
}
