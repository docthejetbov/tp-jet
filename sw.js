// Rede primeiro (pega atualizações), cache como reserva para funcionar offline.
const CACHE = 'tpjet-v19';
const SHELL = ['./', 'index.html', 'manifest.webmanifest', 'icon-180.png', 'icon-192.png', 'icon-512.png', 'logo-wide.webp', 'config.js'];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET' || new URL(req.url).origin !== location.origin) return;
  // no-cache: confere com o servidor (o GitHub Pages manda guardar por 10 min) e pega a versão nova na hora
  e.respondWith(
    fetch(new Request(req.url, { cache: 'no-cache', credentials: 'same-origin' }))
      .then((res) => {
        const copy = res.clone();
        caches.open(CACHE).then((c) => c.put(req.mode === 'navigate' ? './' : req, copy));
        return res;
      })
      .catch(() => caches.match(req.mode === 'navigate' ? './' : req, { ignoreSearch: true }))
  );
});
