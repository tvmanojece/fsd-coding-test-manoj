package com.documenthandler.model;

import java.util.List;
import java.util.Optional;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface FileDocumentRepository extends CrudRepository<FileDocument, String> {
	
       
	public void deleteById (String id);
	List<FileDocument> findAll();

}