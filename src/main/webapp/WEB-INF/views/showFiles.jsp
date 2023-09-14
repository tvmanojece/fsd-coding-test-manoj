<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Uploaded documents</title>

<style>
* {
	box-sizing: border-box;
}

#filterDocInput {
	background-position: 10px 10px;
	background-repeat: no-repeat;
	width: 100%;
	font-size: 16px;
	padding: 12px 20px 12px 40px;
	border: 1px solid #ddd;
	margin-bottom: 12px;
}

#docsTable {
	border-collapse: collapse;
	width: 100%;
	border: 1px solid #ddd;
	font-size: 18px;
}

#docsTable th {
	background-color: #f1f1f1;
}

#docsTable th:hover {
	cursor: pointer;
}

#docsTable th, #docsTable td {
	text-align: left;
	padding: 12px;
}

#docsTable tr {
	border-bottom: 1px solid #ddd;
}

#docsTable tr.header, #docsTable tr:hover {
	background-color: #f1f1f1;
}

.arrow {
	display: inline-block;
	width: 0.5em;
}

.arrow.up:after {
	content: '\25B2';
}

.arrow.down:after {
	content: '\25BC';
}
</style>
<script>
	function filterDocInputFunction() {
		var input, filter, table, tr, td, i, txtValue;
		input = document.getElementById("filterDocInput");
		filter = input.value.toUpperCase();
		table = document.getElementById("docsTable");
		tr = table.getElementsByTagName("tr");
		for (i = 0; i < tr.length; i++) {
			td = tr[i].getElementsByTagName("td")[0];
			if (td) {
				txtValue = td.textContent || td.innerText;
				if (txtValue.toUpperCase().indexOf(filter) > -1) {
					tr[i].style.display = "";
				} else {
					tr[i].style.display = "none";
				}
			}
		}
	}

	var sortDirection = {
		asc : "up",
		desc : "down"
	};

	function sortTable(columnIndex) {
		var table, rows, switching, i, x, y, shouldSwitch, dir, arrow;

		table = document.getElementById("docsTable");
		switching = true;
		dir = table.getAttribute("data-sort-dir") || "asc";
		arrow = table.getElementsByTagName("th")[columnIndex]
				.getElementsByClassName("arrow")[0];

		// Toggle sorting direction and arrow
		dir = dir === "asc" ? "desc" : "asc";
		arrow.classList.remove(sortDirection.asc, sortDirection.desc);
		arrow.classList.add(sortDirection[dir]);
		table.setAttribute("data-sort-dir", dir);

		while (switching) {
			switching = false;
			rows = table.rows;

			for (i = 1; i < rows.length - 1; i++) {
				shouldSwitch = false;
				x = rows[i].getElementsByTagName("td")[columnIndex];
				y = rows[i + 1].getElementsByTagName("td")[columnIndex];

				if (dir === "asc" ? x.innerHTML.toLowerCase() > y.innerHTML
						.toLowerCase()
						: x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
					shouldSwitch = true;
					break;
				}
			}

			if (shouldSwitch) {
				rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
				switching = true;
			}
		}
	}
</script>

</head>
<body>
	<div>
		<h2>Total no.of documents uploaded : ${totalnoofdocuments}</h2>
	</div>


	<form action="">
		<h2>Documents list</h2>

		<input type="text" id="filterDocInput"
			onkeyup="filterDocInputFunction()"
			placeholder="Filter with document name.." title="Type in a doc name"
			style="width: 300px;">
		<table id="docsTable">

			<tr>
				<th onclick="sortTable(0)">Document Name <span class="arrow"></span></th>
				<th onclick="sortTable(1)">Uploaded By <span class="arrow"></span></th>
				<th onclick="sortTable(2)">Uploaded Date <span class="arrow"></span></th>
				<th>Delete ?</th>

			</tr>

			<c:forEach items="${documents}" var="document">
				<tr>
					<td><c:out value="${document.documentName}" /></td>
					<td><c:out value="${document.uploadUser}" /></td>
					<td><c:out value="${document.uploadDate}" /></td>
					<td><a
						href="deleteDocument?documentId=<c:out value="${document.documentId}"/>">Delete</a>
					</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>

</html>