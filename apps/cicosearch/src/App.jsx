import { useState } from 'react';
import Fuse from "fuse.js";
import cicoData from "./fuseindex.json";


function App() {
    const[items, setItems] = useState(cicoData);

    const options = {
        includeScore: true,
        includeMatches: true,
        threshold: 0.2,
        keys: ["filename",
               "ciconum",
               "title",
               "people",
               "orgs",
               "languages",
               "dates",
               "places",
               "keywords",
              ],
    };

    const fuse = new Fuse(cicoData, options);

    const handleSearch = (event) => {
        const { value } = event.target;

        // If user searched for empty string,
        // display first 50 items.
        if (value.length === 0) {
            setItems(cicoData.slice(0,50));
            return;
        }

        const results = fuse.search(value);
        const items = results.map((result) => result.item);
        setItems(items)
    }

    return (
        <section>
            <h1>Items</h1>
            <input
                type="text"
                placeholder="Search by author, title, date, publisher, contributor, or language"
                onChange={handleSearch}
            />

            <ul>
                {items.slice(0,50).map((item, index) => (
                    <li key={index}>
                        <div>
                            <h4>{ item.ciconum.join(", ") }</h4>
                            <dl class="compact">
                                <dt>title</dt>
                                <dd>{ item.title[0] }</dd>
                            </dl>
                        </div>
                    </li>
                ))}
            </ul>

    </section>
  )
}

export default App
