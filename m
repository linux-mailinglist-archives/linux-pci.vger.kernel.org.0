Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE49692D62
	for <lists+linux-pci@lfdr.de>; Sat, 11 Feb 2023 03:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjBKCd4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 21:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBKCdz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 21:33:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972BD5D1D0
        for <linux-pci@vger.kernel.org>; Fri, 10 Feb 2023 18:33:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E149BB82525
        for <linux-pci@vger.kernel.org>; Sat, 11 Feb 2023 02:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3092AC433EF;
        Sat, 11 Feb 2023 02:33:48 +0000 (UTC)
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
Subject: [PATCH] PCI: loongson: Add more PCI IDs need MRRS quirk
Date:   Sat, 11 Feb 2023 10:33:21 +0800
Message-Id: <20230211023321.3530080-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Loongson-2K SOC and LS7A2000 chipset add new PCI IDs that need MRRS
quirk. This is a sad story, but we can only add them now.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 33 +++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 759ec211c17b..fe0f732f6e43 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -15,9 +15,14 @@
 #include "../pci.h"
 
 /* Device IDs */
-#define DEV_PCIE_PORT_0	0x7a09
-#define DEV_PCIE_PORT_1	0x7a19
-#define DEV_PCIE_PORT_2	0x7a29
+#define DEV_LS2K_PCIE_PORT0	0x1a05
+#define DEV_LS7A_PCIE_PORT0	0x7a09
+#define DEV_LS7A_PCIE_PORT1	0x7a19
+#define DEV_LS7A_PCIE_PORT2	0x7a29
+#define DEV_LS7A_PCIE_PORT3	0x7a39
+#define DEV_LS7A_PCIE_PORT4	0x7a49
+#define DEV_LS7A_PCIE_PORT5	0x7a59
+#define DEV_LS7A_PCIE_PORT6	0x7a69
 
 #define DEV_LS2K_APB	0x7a02
 #define DEV_LS7A_GMAC	0x7a03
@@ -53,11 +58,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
 	dev->class = PCI_CLASS_BRIDGE_PCI_NORMAL;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_0, bridge_class_quirk);
+			DEV_LS7A_PCIE_PORT0, bridge_class_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_1, bridge_class_quirk);
+			DEV_LS7A_PCIE_PORT1, bridge_class_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_2, bridge_class_quirk);
+			DEV_LS7A_PCIE_PORT2, bridge_class_quirk);
 
 static void system_bus_quirk(struct pci_dev *pdev)
 {
@@ -87,11 +92,21 @@ static void loongson_mrrs_quirk(struct pci_dev *pdev)
 	bridge->no_inc_mrrs = 1;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_0, loongson_mrrs_quirk);
+			DEV_LS2K_PCIE_PORT0, loongson_mrrs_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_1, loongson_mrrs_quirk);
+			DEV_LS7A_PCIE_PORT0, loongson_mrrs_quirk);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
-			DEV_PCIE_PORT_2, loongson_mrrs_quirk);
+			DEV_LS7A_PCIE_PORT1, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_PCIE_PORT2, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_PCIE_PORT3, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_PCIE_PORT4, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_PCIE_PORT5, loongson_mrrs_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_PCIE_PORT6, loongson_mrrs_quirk);
 
 static void loongson_pci_pin_quirk(struct pci_dev *pdev)
 {
-- 
2.39.0

