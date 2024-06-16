import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import style from "./styles/backlinks.scss"
import { resolveRelative, simplifySlug } from "../util/path"
import { i18n } from "../i18n"
import { classNames } from "../util/lang"

const Backlinks: QuartzComponent = ({
  fileData,
  allFiles,
  displayClass,
  cfg,
}: QuartzComponentProps) => {
  const slug = simplifySlug(fileData.slug!)
  const backlinkFiles = allFiles.filter((file) => file.links?.includes(slug))
  return (
    <div class={classNames(displayClass, "backlinks")}>
      <h3>{i18n(cfg.locale).components.backlinks.title}</h3>

      {/*
       * NOTE: I changed the below list from class="overflow" to one without
       *       because the popovers were broken. If this is fixed upstream,
       *       maybe I can consider changing it back.
       */}
      <ul style={{ marginTop: "0.75rem" }}>
        {backlinkFiles.length > 0 ? (
          backlinkFiles.map((f) => (
            <li>
              <a href={resolveRelative(fileData.slug!, f.slug!)} class="internal">
                {f.frontmatter?.title}
              </a>
            </li>
          ))
        ) : (
          <li>{i18n(cfg.locale).components.backlinks.noBacklinksFound}</li>
        )}
      </ul>
    </div>
  )
}

Backlinks.css = style
export default (() => Backlinks) satisfies QuartzComponentConstructor
