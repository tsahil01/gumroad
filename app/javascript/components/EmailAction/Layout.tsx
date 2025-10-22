import * as React from "react";

import { useDomains } from "$app/components/DomainSettings";

export const Layout = ({ heading, children }: { heading: string; children: React.ReactNode }) => {
  const { rootDomain } = useDomains();

  return (
    <>
      <div className="grid bg-background border border-border rounded-sm">
        <header className="flex flex-wrap items-center justify-between p-4 gap-4">
          <h2 className="flex-grow">{heading}</h2>
        </header>
        <p className="flex flex-wrap items-center justify-between p-4 gap-4">{children}</p>
      </div>
      <footer
        style={{
          textAlign: "center",
          padding: "var(--spacer-4)",
        }}
      >
        Powered by&ensp;
        <a href={Routes.root_url({ host: rootDomain })} className="logo-full" aria-label="Gumroad" />
      </footer>
    </>
  );
};
