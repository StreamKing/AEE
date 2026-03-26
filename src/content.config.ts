import { defineCollection, z } from "astro:content";
import { glob } from "astro/loaders";

const termine = defineCollection({
    loader: glob({ pattern: "**/*.md", base: "./src/content/termine" }),
    schema: z.object({
        title: z.string(),
        date: z.string().optional(),
        time: z
            .object({
                von: z.string(),
                bis: z.string(),
            })
            .optional(),
        description: z.string().optional(),
        tags: z.array(z.string()).optional(),
    }),
});

export const collections = { termine };
