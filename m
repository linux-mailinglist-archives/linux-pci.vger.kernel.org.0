Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B11D42880A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhJKHtH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 03:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234129AbhJKHtH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Oct 2021 03:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 418016054F;
        Mon, 11 Oct 2021 07:47:06 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V10 1/6] PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A
Date:   Mon, 11 Oct 2021 15:45:59 +0800
Message-Id: <20211011074604.854340-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211011074604.854340-1-chenhuacai@loongson.cn>
References: <20211011074604.854340-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
we can disable CFG0 for them and safely use pci_generic_config_read()/
pci_generic_config_write() instead of pci_generic_config_read32()/pci_
generic_config_write32().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 65 +++++++++++++++++++--------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 48169b1e3817..433261c5f34c 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -25,11 +25,16 @@
 #define FLAG_CFG1	BIT(1)
 #define FLAG_DEV_FIX	BIT(2)
 
+struct pci_controller_data {
+	u32 flags;
+	struct pci_ops *ops;
+};
+
 struct loongson_pci {
 	void __iomem *cfg0_base;
 	void __iomem *cfg1_base;
 	struct platform_device *pdev;
-	u32 flags;
+	struct pci_controller_data *data;
 };
 
 /* Fixup wrong class code in PCIe bridges */
@@ -126,8 +131,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus. For our hardware the root bus is always bus 0.
 	 */
-	if (priv->flags & FLAG_DEV_FIX && busnum != 0 &&
-		PCI_SLOT(devfn) > 0)
+	if (priv->data->flags & FLAG_DEV_FIX &&
+			busnum != 0 && PCI_SLOT(devfn) > 0)
 		return NULL;
 
 	/* CFG0 can only access standard space */
@@ -159,20 +164,42 @@ static int loongson_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return val;
 }
 
-/* H/w only accept 32-bit PCI operations */
+/* LS2K/LS7A accept 8/16/32-bit PCI config operations */
 static struct pci_ops loongson_pci_ops = {
+	.map_bus = pci_loongson_map_bus,
+	.read	= pci_generic_config_read,
+	.write	= pci_generic_config_write,
+};
+
+/* RS780/SR5690 only accept 32-bit PCI config operations */
+static struct pci_ops loongson_pci_ops32 = {
 	.map_bus = pci_loongson_map_bus,
 	.read	= pci_generic_config_read32,
 	.write	= pci_generic_config_write32,
 };
 
+static const struct pci_controller_data ls2k_pci_data = {
+	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	.ops = &loongson_pci_ops,
+};
+
+static const struct pci_controller_data ls7a_pci_data = {
+	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	.ops = &loongson_pci_ops,
+};
+
+static const struct pci_controller_data rs780e_pci_data = {
+	.flags = FLAG_CFG0,
+	.ops = &loongson_pci_ops32,
+};
+
 static const struct of_device_id loongson_pci_of_match[] = {
 	{ .compatible = "loongson,ls2k-pci",
-		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+		.data = (void *)&ls2k_pci_data, },
 	{ .compatible = "loongson,ls7a-pci",
-		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+		.data = (void *)&ls7a_pci_data, },
 	{ .compatible = "loongson,rs780e-pci",
-		.data = (void *)(FLAG_CFG0), },
+		.data = (void *)&rs780e_pci_data, },
 	{}
 };
 
@@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
 
 	priv = pci_host_bridge_priv(bridge);
 	priv->pdev = pdev;
-	priv->flags = (unsigned long)of_device_get_match_data(dev);
+	priv->data = (struct pci_controller_data *)of_device_get_match_data(dev);
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!regs) {
-		dev_err(dev, "missing mem resources for cfg0\n");
-		return -EINVAL;
+	if (priv->data->flags & FLAG_CFG0) {
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
-	if (priv->flags & FLAG_CFG1) {
+	if (priv->data->flags & FLAG_CFG1) {
 		regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		if (!regs)
 			dev_info(dev, "missing mem resource for cfg1\n");
@@ -218,7 +245,7 @@ static int loongson_pci_probe(struct platform_device *pdev)
 	}
 
 	bridge->sysdata = priv;
-	bridge->ops = &loongson_pci_ops;
+	bridge->ops = priv->data->ops;
 	bridge->map_irq = loongson_map_irq;
 
 	return pci_host_probe(bridge);
-- 
2.27.0

