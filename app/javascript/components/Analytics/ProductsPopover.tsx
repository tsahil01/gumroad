import * as React from "react";

import { type Product } from "$app/components/Analytics";
import { Button } from "$app/components/Button";
import { Icon } from "$app/components/Icons";
import { Popover } from "$app/components/Popover";

export type ProductOption = Product & { selected: boolean };

export const ProductsPopover = ({
  products,
  setProducts,
}: {
  products: ProductOption[];
  setProducts: React.Dispatch<React.SetStateAction<ProductOption[]>>;
}) => (
  <Popover
    trigger={
      <span className="input">
        <div className="fake-input">Select products...</div>
        <Icon name="outline-cheveron-down" />
      </span>
    }
  >
    <div className="grid bg-background border border-border rounded-sm">
      <div className="flex flex-wrap items-center justify-between p-4 gap-4">
        <fieldset className="flex-grow basis-0">
          <label>
            <input
              type="checkbox"
              checked={products.filter((product) => product.selected).length === products.length}
              onChange={(event) =>
                setProducts((prevProducts) =>
                  prevProducts.map((product) => ({ ...product, selected: event.target.checked })),
                )
              }
            />
            All products
          </label>
          {products.map(({ id, name, unique_permalink, selected }) => (
            <label key={id}>
              <input
                type="checkbox"
                checked={selected}
                onChange={(event) =>
                  setProducts((prevProducts) =>
                    prevProducts.map((product) =>
                      product.unique_permalink === unique_permalink
                        ? { ...product, selected: event.target.checked }
                        : product,
                    ),
                  )
                }
              />
              {name}
            </label>
          ))}
        </fieldset>
      </div>
      <div className="flex flex-wrap items-center justify-between p-4 gap-4 border-t border-border">
        <Button className="flex-grow basis-0"
          onClick={() =>
            setProducts((prevProducts) => prevProducts.map((product) => ({ ...product, selected: !product.selected })))
          }
        >
          Toggle selected
        </Button>
      </div>
    </div>
  </Popover>
);
