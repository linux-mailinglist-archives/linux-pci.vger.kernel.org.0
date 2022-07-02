Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99583563F2E
	for <lists+linux-pci@lfdr.de>; Sat,  2 Jul 2022 11:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiGBJKS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 2 Jul 2022 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBJKR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Jul 2022 05:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84941ADB3
        for <linux-pci@vger.kernel.org>; Sat,  2 Jul 2022 02:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 721E260AE9
        for <linux-pci@vger.kernel.org>; Sat,  2 Jul 2022 09:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9D9C34114;
        Sat,  2 Jul 2022 09:10:13 +0000 (UTC)
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
Subject: [PATCH V15 4/7] PCI: loongson: Don't access non-existant devices
Date:   Sat,  2 Jul 2022 17:08:05 +0800
Message-Id: <20220702090808.1221300-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220702090808.1221300-1-chenhuacai@loongson.cn>
References: <20220702090808.1221300-1-chenhuacai@loongson.cn>
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

On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
scanning (they are hidden devices for debug in fact, access the config
space may cause machine hang). This is a hardware flaw but we can only
avoid it by software now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 30 +++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index a1222fc15454..de5be6d9bcbc 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -26,6 +26,7 @@
 #define FLAG_CFG0	BIT(0)
 #define FLAG_CFG1	BIT(1)
 #define FLAG_DEV_FIX	BIT(2)
+#define FLAG_DEV_HIDDEN	BIT(3)
 
 struct loongson_pci_data {
 	u32 flags;
@@ -134,10 +135,17 @@ static void __iomem *cfg0_map(struct loongson_pci *priv, int bus,
 	return priv->cfg0_base + addroff;
 }
 
+static bool pdev_may_exist(struct pci_bus *bus, unsigned int device, unsigned int function)
+{
+	return !(pci_is_root_bus(bus) && (device >= 9 && device <= 20) && (function > 0));
+}
+
 static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where)
 {
 	unsigned char busnum = bus->number;
+	unsigned int device = PCI_SLOT(devfn);
+	unsigned int function = PCI_FUNC(devfn);
 	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
 
 	if (pci_is_root_bus(bus))
@@ -147,9 +158,16 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus.
 	 */
-	if (priv->data->flags & FLAG_DEV_FIX &&
-			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
-		return NULL;
+	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
+		if (!pci_is_root_bus(bus) && (device > 0))
+			return NULL;
+	}
+
+	/* Don't access non-existant devices */
+	if (priv->data->flags & FLAG_DEV_HIDDEN) {
+		if (!pdev_may_exist(bus, device, function))
+			return NULL;
+	}
 
 	/* CFG0 can only access standard space */
 	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
@@ -197,12 +215,12 @@ static struct pci_ops loongson_pci_ops32 = {
 };
 
 static const struct loongson_pci_data ls2k_pci_data = {
-	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	.flags = FLAG_CFG1 | FLAG_DEV_FIX | FLAG_DEV_HIDDEN,
 	.ops = &loongson_pci_ops,
 };
 
 static const struct loongson_pci_data ls7a_pci_data = {
-	.flags = FLAG_CFG1 | FLAG_DEV_FIX,
+	.flags = FLAG_CFG1 | FLAG_DEV_FIX | FLAG_DEV_HIDDEN,
 	.ops = &loongson_pci_ops,
 };
 
@@ -297,7 +315,7 @@ static int loongson_pci_ecam_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 
 	cfg->priv = priv;
-	data->flags = FLAG_CFG1;
+	data->flags = FLAG_CFG1 | FLAG_DEV_HIDDEN;
 	priv->data = data;
 	priv->cfg1_base = cfg->win - (cfg->busr.start << 16);
 
-- 
2.27.0

