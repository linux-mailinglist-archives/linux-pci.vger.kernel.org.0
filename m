Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE354F221
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 09:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbiFQHon (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiFQHom (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 03:44:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E31674EF
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 00:44:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA31E61F5E
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 07:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF0CC3411B;
        Fri, 17 Jun 2022 07:44:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V14 2/7] PCI: loongson: Use generic 8/16/32-bit config ops on LS2K/LS7A
Date:   Fri, 17 Jun 2022 15:43:25 +0800
Message-Id: <20220617074330.12605-3-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220617074330.12605-1-chenhuacai@loongson.cn>
References: <20220617074330.12605-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LS2K/LS7A support 8/16/32-bits PCI config access operations via CFG1, so
we can disable CFG0 for them and safely use pci_generic_config_read()/
pci_generic_config_write() instead of pci_generic_config_read32()/pci_
generic_config_write32().

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 65 +++++++++++++++++++--------
 1 file changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 50a8e1d6f70a..565453882ffe 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -25,11 +25,16 @@
 #define FLAG_CFG1	BIT(1)
 #define FLAG_DEV_FIX	BIT(2)
 
+struct loongson_pci_data {
+	u32 flags;
+	struct pci_ops *ops;
+};
+
 struct loongson_pci {
 	void __iomem *cfg0_base;
 	void __iomem *cfg1_base;
 	struct platform_device *pdev;
-	u32 flags;
+	const struct loongson_pci_data *data;
 };
 
 /* Fixup wrong class code in PCIe bridges */
@@ -126,8 +131,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus. For our hardware the root bus is always bus 0.
 	 */
-	if (priv->flags & FLAG_DEV_FIX && busnum != 0 &&
-		PCI_SLOT(devfn) > 0)
+	if (priv->data->flags & FLAG_DEV_FIX &&
+			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
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
 
+static const struct loongson_pci_data ls2k_pci_data = {
+	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	.ops = &loongson_pci_ops,
+};
+
+static const struct loongson_pci_data ls7a_pci_data = {
+	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	.ops = &loongson_pci_ops,
+};
+
+static const struct loongson_pci_data rs780e_pci_data = {
+	.flags = FLAG_CFG0,
+	.ops = &loongson_pci_ops32,
+};
+
 static const struct of_device_id loongson_pci_of_match[] = {
 	{ .compatible = "loongson,ls2k-pci",
-		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+		.data = &ls2k_pci_data, },
 	{ .compatible = "loongson,ls7a-pci",
-		.data = (void *)(FLAG_CFG0 | FLAG_CFG1 | FLAG_DEV_FIX), },
+		.data = &ls7a_pci_data, },
 	{ .compatible = "loongson,rs780e-pci",
-		.data = (void *)(FLAG_CFG0), },
+		.data = &rs780e_pci_data, },
 	{}
 };
 
@@ -193,20 +220,20 @@ static int loongson_pci_probe(struct platform_device *pdev)
 
 	priv = pci_host_bridge_priv(bridge);
 	priv->pdev = pdev;
-	priv->flags = (unsigned long)of_device_get_match_data(dev);
+	priv->data = of_device_get_match_data(dev);
 
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

