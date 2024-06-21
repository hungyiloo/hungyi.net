Instead of a blog, I now publish a subset of my notes as my digital garden using [Quartz](https://quartz.jzhao.xyz/). I don't heavily customize the layout, as it's now important for me to spend less time hand-crafting my website and, instead, spend more time recording and publishing my findings with as little friction as possible.

My notes themselves are not stored in this repo, as I wish to keep some of them personal and private. I build off an external source of notes by running `npx quartz build -d /path/to/my/notes` and filtering out what I want to publish using the [ExplicitPublish](https://quartz.jzhao.xyz/plugins/ExplicitPublish) plugin. To deploy to [hungyi.net](https://hungyi.net/), I use [Wrangler](https://developers.cloudflare.com/workers/wrangler/) to deploy the build result in `public` to Cloudflare Pages via [direct upload](https://developers.cloudflare.com/pages/get-started/direct-upload/).

Old blog content from the [previous incarnation of hungyi.net](https://github.com/hungyiloo/hungyi.net/tree/archive-2024) may be slowly migrated over to this garden, if I think it's still relevant.

