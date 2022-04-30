Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87758515B8F
	for <lists+linux-pci@lfdr.de>; Sat, 30 Apr 2022 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiD3IxJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 30 Apr 2022 04:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiD3IxJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Apr 2022 04:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC521B16
        for <linux-pci@vger.kernel.org>; Sat, 30 Apr 2022 01:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D9860C8B
        for <linux-pci@vger.kernel.org>; Sat, 30 Apr 2022 08:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12063C385A7;
        Sat, 30 Apr 2022 08:49:44 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V13 3/6] PCI: loongson: Don't access unexisting devices
Date:   Sat, 30 Apr 2022 16:48:43 +0800
Message-Id: <20220430084846.3127041-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220430084846.3127041-1-chenhuacai@loongson.cn>
References: <20220430084846.3127041-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
scanning. This is a hardware flaw but we can only avoid it by software
now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index adbfa4a2330f..48316daa1f23 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -138,6 +138,8 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 			       int where)
 {
 	unsigned char busnum = bus->number;
+	unsigned int device = PCI_SLOT(devfn);
+	unsigned int function = PCI_FUNC(devfn);
 	struct loongson_pci *priv = pci_bus_to_loongson_pci(bus);
 
 	if (pci_is_root_bus(bus))
@@ -147,8 +149,13 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus. For our hardware the root bus is always bus 0.
 	 */
-	if (priv->data->flags & FLAG_DEV_FIX &&
-			!pci_is_root_bus(bus) && PCI_SLOT(devfn) > 0)
+	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
+		if (!pci_is_root_bus(bus) && (device > 0))
+			return NULL;
+	}
+
+	/* Don't access unexisting devices */
+	if (pci_is_root_bus(bus) && (device >= 9 && device <= 20 && function > 0))
 		return NULL;
 
 	/* CFG0 can only access standard space */
-- 
2.27.0

