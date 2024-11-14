import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function main() {
  // Prismaクライアントを使用してデータベース操作を行う
  const users = await prisma.user.findMany();
  console.log(users);

  const categories = await prisma.category.findMany();
  console.log(categories);
}

main()
  .catch((e) => {
    throw e;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
