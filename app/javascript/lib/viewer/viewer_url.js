import queryString from 'query-string';
import stampit from 'stampit';

export default stampit({
  props: {
    q: '',
    history: window.history,
    origin: document.location.origin,
    search: document.location.search,
    pathName: document.location.pathname,
    id: false,
    child_id: false,
    sidebar_page: null,
  },
  init({ history = this.history,
         origin = this.origin,
         search = this.search,
         q = this.q,
         id = this.id,
         child_id = this.child_id,
         sidebar_page = 1 }) {

    this.history = history;
    this.sidebar_page = sidebar_page;
    const defaultPath = this.pathName;

    const idsPath = function() {
      return [id, child_id].filter(id => id).join('/')
    }

    const pathName = function() {
      return (idsPath() != '') ? `/item/${idsPath()}` : defaultPath;
    }

    const queryParams = function() {
      return { ...queryString.parse(search), ...{query: q}, ...{sidebar_page: sidebar_page} }
    }

    this.newURL = function() {
      const searchString = queryString.stringify(queryParams());
      return `${origin}${pathName()}?${searchString}`
    }

  },
  methods: {
    update() {
      this.history.pushState(null,"", this.newURL());
    }
  }
});