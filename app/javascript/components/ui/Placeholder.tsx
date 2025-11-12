import * as React from "react";

import { classNames } from "$app/utils/classNames";

type PlaceholderProps = React.PropsWithChildren<{
  className?: string;
  role?: string;
  imgSrc?: string;
  "aria-label"?: string;
  style?: React.CSSProperties;
}>;

const Placeholder: React.FC<PlaceholderProps> = ({ className, children, imgSrc, ...rest }) => (
  <div
    className={classNames(
      "grid justify-items-center gap-3 rounded border border-dashed border-border bg-background p-6 text-center",
      "[&>.icon]:text-xl",
      className,
    )}
    {...rest}
  >
    {imgSrc && (
      <figure className="w-full">
        <img src={imgSrc} className="h-auto w-full" />
      </figure>
    )}
    {children}
  </div>
);

export default Placeholder;
