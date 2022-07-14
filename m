Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A76C574E4F
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiGNMrW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 08:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbiGNMrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 08:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7596170C
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 05:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6C2961F91
        for <linux-pci@vger.kernel.org>; Thu, 14 Jul 2022 12:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01AC34115;
        Thu, 14 Jul 2022 12:45:12 +0000 (UTC)
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
Subject: [PATCH V16 4/7] PCI: loongson: Don't access non-existant devices
Date:   Thu, 14 Jul 2022 20:42:13 +0800
Message-Id: <20220714124216.1489304-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220714124216.1489304-1-chenhuacai@loongson.cn>
References: <20220714124216.1489304-1-chenhuacai@loongson.cn>
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
 drivers/pci/controller/pci-loongson.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 2db180a9e628..594653154deb 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -26,6 +26,7 @@
 #define FLAG_CFG0	BIT(0)
 #define FLAG_CFG1	BIT(1)
 #define FLAG_DEV_FIX	BIT(2)
+#define FLAG_DEV_HIDDEN	BIT(3)
 
 struct loongson_pci_data {
 	u32 flags;
@@ -138,18 +139,32 @@ static void __iomem *cfg1_map(struct loongson_pci *priv,
 	return priv->cfg1_base + addroff;
 }
 
+static bool pdev_may_exist(struct pci_bus *bus, unsigned int device, unsigned int function)
+{
+	return !(pci_is_root_bus(bus) && (device >= 9 && device <= 20) && (function > 0));
+}
+
 static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devfn,
 			       int where)
 {
+	unsigned int device = PCI_SLOT(devfn);
+	unsigned int function = PCI_FUNC(devfn);
 	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
 
 	/*
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
@@ -197,12 +212,12 @@ static struct pci_ops loongson_pci_ops32 = {
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
 
@@ -297,7 +312,7 @@ static int loongson_pci_ecam_init(struct pci_config_window *cfg)
 		return -ENOMEM;
 
 	cfg->priv = priv;
-	data->flags = FLAG_CFG1;
+	data->flags = FLAG_CFG1 | FLAG_DEV_HIDDEN;
 	priv->data = data;
 	priv->cfg1_base = cfg->win - (cfg->busr.start << 16);
 
-- 
2.31.1

