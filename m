Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8FF3F6F27
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 08:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbhHYGJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 02:09:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232442AbhHYGJE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 02:09:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CFA89613A7;
        Wed, 25 Aug 2021 06:08:16 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V8 1/5] PCI: loongson: Use correct pci config access operations
Date:   Wed, 25 Aug 2021 14:07:20 +0800
Message-Id: <20210825060724.3385929-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825060724.3385929-1-chenhuacai@loongson.cn>
References: <20210825060724.3385929-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LS2K/LS7A support 8/16/32-bits pci config access operations via CFG1, so
we can disable CFG0 for them and safely use pci_generic_config_read()/
pci_generic_config_write() instead of pci_generic_config_read32()/pci_
generic_config_write32().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 36 +++++++++++++++++----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 48169b1e3817..b2c81c762599 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -159,8 +159,15 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return val;
 }
 
-/* H/w only accept 32-bit PCI operations */
+/* LS2K/LS7A accept 8/16/32-bit PCI operations */
 static struct pci_ops loongson_pci_ops = {
+	.map_bus = pci_loongson_map_bus,
+	.read	= pci_generic_config_read,
+	.write	= pci_generic_config_write,
+};
+
+/* RS780/SR5690 only accept 32-bit PCI operations */
+static struct pci_ops loongson_pci_ops32 = {
 	.map_bus = pci_loongson_map_bus,
 	.read	= pci_generic_config_read32,
 	.write	= pci_generic_config_write32,
@@ -168,9 +175,9 @@ static struct pci_ops loongson_pci_ops = {
 
 static const struct of_device_id loongson_pci_of_match[] = {
 	{ .compatible = "loongson,ls2k-pci",
-		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+		.data = (void *)(FLAG_CFG1 | FLAG_DEV_FIX), },
 	{ .compatible = "loongson,ls7a-pci",
-		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+		.data = (void *)(FLAG_CFG1 | FLAG_DEV_FIX), },
 	{ .compatible = "loongson,rs780e-pci",
 		.data = (void *)(FLAG_CFG0), },
 	{}
@@ -195,17 +202,17 @@ static int loongson_pci_probe(struct platform_device *pdev)
 	priv->pdev = pdev;
 	priv->flags = (unsigned long)of_device_get_match_data(dev);
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(dev, "missing mem resources for cfg0\n");
-		return -EINVAL;
+	if (priv->flags & FLAG_CFG0) {
+		regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!regs)
+			dev_err(dev, "missing mem resources for cfg0\n");
+		else {
+			priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
+			if (IS_ERR(priv->cfg0_base))
+				return PTR_ERR(priv->cfg0_base);
+		}
 	}
 
-	priv->cfg0_base = devm_pci_remap_cfg_resource(dev, regs);
-	if (IS_ERR(priv->cfg0_base))
-		return PTR_ERR(priv->cfg0_base);
-
-	/* CFG1 is optional */
 	if (priv->flags & FLAG_CFG1) {
 		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		if (!regs)
@@ -218,8 +225,11 @@ static int loongson_pci_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = priv;
-	bridge->ops = &loongson_pci_ops;
 	bridge->map_irq = loongson_map_irq;
+	if (!of_device_is_compatible(node, "loongson,rs780e-pci"))
+		bridge->ops = &loongson_pci_ops;
+	else
+		bridge->ops = &loongson_pci_ops32;
 
 	return pci_host_probe(bridge);
 }
-- 
2.27.0

