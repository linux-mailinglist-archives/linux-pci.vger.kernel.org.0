Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949B4C5548
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 11:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiBZKwq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 05:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbiBZKwq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 05:52:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7DA9A59
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 02:52:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3FD7B80E9E
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 10:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0977BC340E8;
        Sat, 26 Feb 2022 10:52:07 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V12 3/6] PCI: loongson: Don't access unexisting devices
Date:   Sat, 26 Feb 2022 18:47:28 +0800
Message-Id: <20220226104731.76776-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220226104731.76776-1-chenhuacai@loongson.cn>
References: <20220226104731.76776-1-chenhuacai@loongson.cn>
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

On LS2K/LS7A, some unexisting devices don't return 0xffffffff when
scanning. This is a hardware flaw but we can only avoid it by software
now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 164c0f6e419f..48d9d283cb59 100644
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
@@ -147,9 +149,12 @@ static void __iomem *pci_loongson_map_bus(struct pci_bus *bus, unsigned int devf
 	 * Do not read more than one device on the bus other than
 	 * the host bus. For our hardware the root bus is always bus 0.
 	 */
-	if (priv->data->flags & FLAG_DEV_FIX &&
-			busnum != 0 && PCI_SLOT(devfn) > 0)
-		return NULL;
+	if ((priv->data->flags & FLAG_DEV_FIX) && bus->self) {
+		if ((busnum != 0) && (device > 0))
+			return NULL;
+		if ((busnum == 0) && (device >= 9 && device <= 20 && function > 0))
+			return NULL;
+	}
 
 	/* CFG0 can only access standard space */
 	if (where < PCI_CFG_SPACE_SIZE && priv->cfg0_base)
-- 
2.27.0

