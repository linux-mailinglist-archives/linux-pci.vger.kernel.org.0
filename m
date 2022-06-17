Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9A254F228
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiFQHqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiFQHqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 03:46:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3D674F7
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 00:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D741E61F68
        for <linux-pci@vger.kernel.org>; Fri, 17 Jun 2022 07:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92F7C3411C;
        Fri, 17 Jun 2022 07:46:35 +0000 (UTC)
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
Subject: [PATCH V14 4/7] PCI: loongson: Don't access non-existant devices
Date:   Fri, 17 Jun 2022 15:43:27 +0800
Message-Id: <20220617074330.12605-5-chenhuacai@loongson.cn>
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

On LS2K/LS7A, some non-existant devices don't return 0xffffffff when
scanning. This is a hardware flaw but we can only avoid it by software
now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index a1222fc15454..e22142f75d97 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -134,10 +134,20 @@ static void __iomem *cfg0_map(struct loongson_pci *priv, int bus,
 	return priv->cfg0_base + addroff;
 }
 
+static bool pdev_is_existant(unsigned char bus, unsigned int device, unsigned int function)
+{
+	if ((bus == 0) && (device >= 9 && device <= 20) && (function > 0))
+		return false;
+
+	return true;
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
@@ -147,8 +157,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus.
 	 */
-	if (priv->data->flags & FLAG_DEV_FIX &&
-			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
+	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
+		if (!pci_is_root_bus(bus) && (device > 0))
+			return NULL;
+	}
+
+	/* Don't access non-existant devices */
+	if (!pdev_is_existant(busnum, device, function))
 		return NULL;
 
 	/* CFG0 can only access standard space */
-- 
2.27.0

