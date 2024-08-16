import { joinSegments, pathToRoot } from "../util/path"
import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"
import { i18n } from "../i18n"

const PageTitle: QuartzComponent = ({ fileData, cfg, displayClass }: QuartzComponentProps) => {
  const title = cfg?.pageTitle ?? i18n(cfg.locale).propertyDefaults.title
  const baseDir = pathToRoot(fileData.slug!)
  return (
    <h2 class={classNames(displayClass, "page-title")}>
      <div style={{ display: "inline-block", position: "relative", bottom: "0.1em" }}>
        <div style={{ display: "flex", alignItems: "center", justifyContent: "center", height: "1em", width: "1em", marginRight: "0.35em", padding: "0.1em", background: "#11111b", borderRadius: "1em" }}>
          <img
            src={joinSegments(baseDir, "static/HY_Light_and_Color_2.svg")}
            alt="Logo"
            style={{ height: "0.5em", margin: 0, padding: 0, borderRadius: "0" }}
          />
        </div>
      </div>
      <a href={baseDir}>{title}</a>
    </h2>
  )
}

PageTitle.css = `
.page-title {
  font-size: 1.75rem;
  margin: 0;
}
`

export default (() => PageTitle) satisfies QuartzComponentConstructor
