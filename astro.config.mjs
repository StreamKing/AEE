// @ts-check
import { defineConfig } from "astro/config";
import { BASE_URL } from "./config.js";

// https://astro.build/config
export default defineConfig({
  site: "https://StreamKing.github.io",
  base: BASE_URL,
});
