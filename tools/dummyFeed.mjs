/**
 * This tool converts the feed.json from the dashboard mock API into 
 * Publication records.
 */

import * as fs from "node:fs/promises";

const data = await fs.readFile("../sustainability-dashboard/site/mock/api/feed.json");

function arrayToKey(value, array) {
    return array
            .map((name) => `{ ${value}: ${JSON.stringify(name)} }`);
}

function objectToKeyList(names, object) {
    if (!object) {
        return [];
    }

    return Object.keys(object)
            .map((name, udx) => `{ ${names[0]}: "${name}" ${names[1]}: "${object[name]}" }`);
}

const result = JSON.parse(data)
    .publications
    .map((record) => {
        record.authors = arrayToKey("name", record.authors);
        record.keywords = arrayToKey("name", record.keywords);
        record.sdgs= arrayToKey("id", record.sdg);
        record.subtype = `{ name: "${record.type}" }`;
        record.language = record.lang;
        record.class = objectToKeyList(["id", "name"], record.class);
        delete record.department;
        delete record.sdg;
        delete record.type;
        delete record.lang

        return record
    }).
    map((record) => {
        return "{\n" + 
            Object
                .keys(record)
                .map((key) => {
                    if ( key === "subtype") {
                        return `${key}: ${record[key]}`;
                    }
                    if (["string", "number"].indexOf(typeof record[key]) >= 0) {
                        return `${key}: ${JSON.stringify(record[key])}`;
                    }
                    if (record[key] === undefined) {
                        return `${key}: []`
                    }

                    return `${key}: [${record[key].join(", ")}]`;
                }).join("\n ")
            + "\n}";
    }).join(", \n");



 console.log(result);
