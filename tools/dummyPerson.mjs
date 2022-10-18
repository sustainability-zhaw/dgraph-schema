/**
 * This tool converts the feed.json from the dashboard mock API into 
 * Person records.
 */

import * as fs from "node:fs/promises";

const data = await fs.readFile("../sustainability-dashboard/site/mock/api/feed.json");

function arrayToKey(value, array) {
    return array
            .map((name) => `{\n  ${value}: ${JSON.stringify(name)}\n}`);
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
    .map((record) =>  arrayToKey("name", record.authors))
    .flat()
    .join(", \n");



 console.log(result);
