export const SITE = {
  name: 'Business Name',
  shortName: 'Business',
  tagline: 'A memorable one-line description of your business.',
  description: 'Replace this with a concise, search-friendly description of your business.',
  url: 'https://example.com',
  language: 'en',
  locale: 'en_GB',
  logoPath: '/logo.svg',
  heroImage: { src: '/images/placeholder.svg', alt: 'Hero image — replace before launch', w: 1600, h: 900 },
  business: {
    legalName: 'Business Name',
    yearEstablished: '2026',
    priceRange: '€€',
    address: { street: 'YOUR_STREET', locality: 'YOUR_TOWN', region: 'YOUR_REGION', postalCode: 'YOUR_POSTCODE', country: 'GR' },
    geo: { lat: 39.162, lng: 23.49 },
    contact: {
      phone: { display: '+30 000 000 0000', raw: '300000000000' },
      email: 'hello@example.com',
      whatsappUrl: 'https://wa.me/300000000000',
    },
    hours: { display: 'Mon–Sun · 09:00–18:00', schema: ['Mo-Su 09:00-18:00'] },
    social: { instagram: '', facebook: '' },
    serviceAreas: ['Your area'],
    trustSignals: ['Locally owned', 'Personal service'],
  },
  seo: { titleSuffix: '· Business Name', defaultDescription: 'Replace this SEO description.', defaultOGImage: '/images/placeholder.svg', themeColor: '#7a663f', author: 'Float Creatives' },
  nav: { main: [{ label: 'Home', href: '/' }, { label: 'Services', href: '/services/' }, { label: 'Gallery', href: '/gallery/' }, { label: 'Contact', href: '/contact/' }], footer: [] },
  maps: { openStreetMap: 'https://www.openstreetmap.org/?mlat=39.162&mlon=23.49', googleMaps: '' },
} as const;

export const canonicalUrl = (path = '/') => new URL(path, SITE.url).toString();

export function generateBusinessSchema() {
  return {
    '@context': 'https://schema.org', '@type': 'LocalBusiness', name: SITE.business.legalName,
    url: SITE.url, description: SITE.description, image: canonicalUrl(SITE.heroImage.src),
    telephone: `+${SITE.business.contact.phone.raw}`, email: SITE.business.contact.email,
    address: { '@type': 'PostalAddress', streetAddress: SITE.business.address.street, addressLocality: SITE.business.address.locality, addressRegion: SITE.business.address.region, postalCode: SITE.business.address.postalCode, addressCountry: SITE.business.address.country },
    geo: { '@type': 'GeoCoordinates', latitude: SITE.business.geo.lat, longitude: SITE.business.geo.lng },
    openingHours: SITE.business.hours.schema, priceRange: SITE.business.priceRange,
  };
}

export function generateWebsiteSchema() {
  return { '@context': 'https://schema.org', '@type': 'WebSite', name: SITE.name, url: SITE.url, inLanguage: SITE.language };
}

export function generateBreadcrumbSchema(items: { name: string; path: string }[]) {
  return { '@context': 'https://schema.org', '@type': 'BreadcrumbList', itemListElement: items.map((item, index) => ({ '@type': 'ListItem', position: index + 1, name: item.name, item: canonicalUrl(item.path) })) };
}
