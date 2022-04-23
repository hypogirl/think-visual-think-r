const dropArea = document.getElementById('dragdrop');
var fileContent;

function importData(files) {
    readFile(files[0]);
}

function convertToObject(fileStr) {
    const cols = [...fileStr.matchAll(/\"(\w+)\"/g)];
    const lines = [...fileStr.matchAll(/\w+,\w+/g)];
    var table = new Array();
    for (let i = 0; i < lines.length; i++) {
        table[i] = new Object();
        const line = lines[i][0].split(",");
        for (let j = 0; j < cols.length; j++) table[i][cols[j][0]] = Number(line[j]);
    }
    return table;
}

function readFile(file) {
    const fl = new FileReader();
    const dataFile = document.getElementById('dataFile');
    fl.addEventListener("load", () => {
        // this will then display a text file
        fileContent = convertToObject(fl.result);
        console.log(fl.result);
      }, false);

    if (file) fl.readAsText(file);
}

;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, preventDefaults, false);
})
  
function preventDefaults (e) {
    e.preventDefault();
    e.stopPropagation();
}

;['dragenter', 'dragover'].forEach(eventName => {
    dropArea.addEventListener(eventName, highlight, false);
})
  
;['dragleave', 'drop'].forEach(eventName => {
    dropArea.addEventListener(eventName, unhighlight, false);
})
  
function highlight(e) {
    dropArea.classList.add('highlight');
    dropArea.innerHTML = "Drop the file to import it."
}
  
function unhighlight(e) {
    dropArea.classList.remove('highlight');
    dropArea.innerHTML = '\t<input type="file" id="dataFile" onchange="importData(this.files)" style="display: none;">\n\t<label for="dataFile" style="display: block;"><i class="bi bi-upload"></i></label>\n\t<label for="dataFile" style="text-decoration: underline;">Choose a file</label> or drag it here.'
}

dropArea.addEventListener('drop', handleDrop, false);

function handleDrop(e) {
    let dt = e.dataTransfer;
    let files = dt.files;

    readFile(files[0]);
}