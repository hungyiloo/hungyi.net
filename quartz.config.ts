import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4.0 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Hung-Yi’s Notes",
    enableSPA: true,
    enablePopovers: true,
    analytics: {
      provider: "plausible",
    },
    locale: "en-US",
    baseUrl: "hungyi.net",
    ignorePatterns: ["private", "templates", ".obsidian"],
    defaultDateType: "created",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Inter",
        body: "Source Sans 3",
        code: "JetBrains Mono",
      },
      colors: {
        lightMode: {
          light: "#eff1f5", // Base
          lightgray: "#ccd0da", // Surface 0
          gray: "#9ca0b0",
          darkgray: "#5c5f77",
          dark: "#4c4f69",
          secondary: "#179299",
          tertiary: "#7287fd", // Lavender
          highlight: "#7c7f9311",
          textHighlight: "#df8e1d88",
        },
        darkMode: {
          light: "#181825", // Mantle
          lightgray: "#45475a", // Surface 1
          gray: "#6c7086", // Overlay 0
          darkgray: "#bac2de", // Subtext 1
          dark: "#cdd6f4", // Text
          secondary: "#70b6c2", // Sky, luminance set to 0.6, saturation set to 0.4
          tertiary: "#cba6f7", // Mauve
          highlight: "#9399b218", // Overlay 2
          textHighlight: "#f9e2af88", // Yellow
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "catppuccin-latte",
          dark: "catppuccin-mocha",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts(), Plugin.ExplicitPublish()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.NotFoundPage(),
    ],
  },
}

export default config
