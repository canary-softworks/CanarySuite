import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
  base: "/CanarySuite/",
  title: "CanarySuite",
  titleTemplate: "Canary Docs",
  description: "A public library of high usage packages",
  lastUpdated: true,
  lang: 'en-us',
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'API', link: '/api/benchmark'},
    ],

    sidebar: {
      '/api': [
        {
          text: 'CanarySuite',
          items: [
            {
              text: 'Benchmark',
              collapsed: true,
              items: [
                { text: 'Benchmark', link: '/api/benchmark' },
                { text: 'BenchmarkObject', link: '/api/benchmarkobject' }
              ]
            },

            { text: 'MDify', link: '/api/mdify' },
            { text: 'Snacky', link: '/api/snacky' },
            { text: 'Sprite', link: '/api/sprite' },
            { text: 'Statistics', link: '/api/statistics' },
          ]
        },
      ],
    },

    outline: [2, 3],

    search: {
      provider: 'local'
    },

    editLink: {
      pattern: 'https://github.com/canary-development/CanarySuite/edit/main/docs/:path'
    },

    footer: {
      message: 'Built with VitePress',
      copyright: 'Copyright © 2021 - 2023 Canary Softworks'
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/canary-development/CanarySuite' },
      { icon: 'discord', link: 'https://discord.gg/cwwcZtqJAt'},
    ]
  }
})
