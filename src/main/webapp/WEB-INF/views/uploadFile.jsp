<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>File Uploader</title>
<style>
.upload-container {
	position: relative;
	margin-left: 100px;
}

.upload-container input {
	border: 1px solid #92b0b3;
	background: #f1f1f1;
	outline: 2px dashed #92b0b3; outline-offset : -10px;
	padding: 100px 0px 100px 250px;
	text-align: center !important;
	width: 500px;
	outline-offset: -10px;
}

.upload-container input:hover {
	background: #ddd;
}

.upload-container:before {
	position: absolute;
	bottom: 50px;
	left: 245px;
	content: " (or) Drag and Drop files here. ";
	font-weight: 900;
}

#uploadbutton {
	margin-left: 400px;
	margin-top: 50px;
	padding: 7px 20px;
}

#submitbutton {
	margin-left: 375px;
	padding: 7px 20px;
}

#message {
	margin-left: 310px;
}

.body-container {
	margin-left: 20px;
}
</style>
<script>
	async function uploadFile() {
		document.getElementById("uploadbutton").disabled = true;
		let formData = new FormData();
		formData.append("file", fileupload.files[0]);

		
		let fetchPromise = fetch('/uploadFileToDB', {
			method : "POST",
			body : formData
		});
		
		await fetchPromise.then(res => res.text()).then(data => document.getElementById("message").innerHTML = data);
		
		document.getElementById('fileupload').value = "";
		document.getElementById("uploadbutton").disabled = false;

	}
	
	function selectFile() {
		document.getElementById("message").innerHTML = "";
	}
</script>
</head>


<body class="body-container">
	<form method="get" target="_blank" action="listFilesFromDb">
		<h3>File Uploader</h3>
		Select a file to upload: <br /> <br />

		<div class="upload-container">
			<input id="fileupload" type="file" name="fileupload"
				onclick="selectFile()" />

		</div>
		<button id="uploadbutton" onclick="uploadFile()">Upload</button>
		<br /> <br />
		<div id="message"></div>
		<br /> <br /> <input type="submit" name="submitbutton"
			id="submitbutton" value="See uploaded files">
	</form>

</body>

</html>