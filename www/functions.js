function rNumber(nStr) {
    return Number(nStr) || 0;
}

function convertToObject(fileStr) {
    const cols = [...fileStr.matchAll(/\"(\w+)\"/g)];
    const lines = [...fileStr.matchAll(/\w+,\w+/g)];
    var table = new Array(), x = new Array(), y = new Array();
    for (let i = 0; i < lines.length; i++) {
        table[i] = new Object();
        const line = lines[i][0].split(",");
        for (let j = 0; j < cols.length; j++) {
            table[i][cols[j][0]] = rNumber(line[j]);
        }
    }
    return [table, colValues];
}