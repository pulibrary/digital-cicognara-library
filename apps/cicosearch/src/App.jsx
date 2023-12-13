import { useState } from 'react';
import Fuse from "fuse.js";
// import SearchBar from "./SearchBar";
// import ResultList from "./ResultList";
import cicoData from "./cicoindex.json";

function App() {
    const[items, setItems] = useState(cicoData);

    const options = {
        includeScore: true,
        includeMatches: true,
        threshold: 0.2,
        keys: ["ciconum",
               "dclnums",
               "title",
               "creator",
               "language",
               "publisher",
               "issued",
               "provider",
               "subjects",
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
                            <h4>{ item.ciconum }</h4>
                            <dl class="compact">
                                <dt>dclNumber</dt>
                                <dd>{ item.dclnums.join("; ") } </dd>

                                <dt>title</dt>
                                <dd>{ item.title}</dd>

                                <dt>creator</dt>
                                <dd>{ item.creator}</dd>

                                <dt>language</dt>
                                <dd>{ item.language }</dd>

                                <dt>publisher</dt>
                                <dd>{ item.publisher }</dd>

                                <dt>issued</dt>
                                <dd>{ item.issued }</dd>

                                <dt>provider</dt>
                                <dd>{ item.provider }</dd>

                                <dt>subjects</dt>
                                <dd>{ item.subjects.join("; ") }</dd>
                            </dl>
                        </div>
                    </li>
                ))}
            </ul>

    </section>
  )
}

export default App
