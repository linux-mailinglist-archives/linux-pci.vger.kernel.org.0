Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2A6AA53E
	for <lists+linux-pci@lfdr.de>; Sat,  4 Mar 2023 00:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjCCXCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Mar 2023 18:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjCCXCT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Mar 2023 18:02:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BE14B804;
        Fri,  3 Mar 2023 15:02:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 757AE61943;
        Fri,  3 Mar 2023 21:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C03C4339C;
        Fri,  3 Mar 2023 21:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677880029;
        bh=eaqxMiW+hFInlOzEsD+yg/ipaGPuNxTLH2jXqymyuGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7tSG6ZXKt1jeF2/uZZf7hxsaZCo7NhihKigsPnmY2xPvjIjOSVNLLjhx+0fAPddp
         /8rmbQWESreUwqTEfXxWjpdh5WsRcEfBIoYVvsk7w5qZbP5bvK30qNxImE0xFmDG1S
         o+7/uOG4oaQtSMzbRTyvpDZwRqBMMGAd63av+d4Qog3tP9kOUVUM84Lfs6cR2+HILj
         f3g6qaqw64KwBrM4T1EVmat1hFesI/uuFSqm5ufywk5jfue95GaWiq0acVazpXNbyN
         ZgQR8tPGKQnqBwwJ02FwO0qlXA4w7imfRqIRXdxAQIpZg7trE0MDsRXFBglFKTd6kR
         n18st8x5cqy1w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 46/50] PCI: loongson: Add more devices that need MRRS quirk
Date:   Fri,  3 Mar 2023 16:45:27 -0500
Message-Id: <20230303214531.1450154-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303214531.1450154-1-sashal@kernel.org>
References: <20230303214531.1450154-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit c768f8c5f40fcdc6f058cc2f02592163d6c6716c ]

Loongson-2K SOC and LS7A2000 chipset add new PCI IDs that need MRRS
quirk.  Add them.

Link: https://lore.kernel.org/r/20230211023321.3530080-1-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pci-loongson.c | 33 +++++++++++++++++++--------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index dc7b4e4293ced..e73e18a73833b 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -13,9 +13,14 @@
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
 #define DEV_LS7A_CONF	0x7a10
@@ -38,11 +43,11 @@ static void bridge_class_quirk(struct pci_dev *dev)
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
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
@@ -72,11 +77,21 @@ static void loongson_mrrs_quirk(struct pci_dev *pdev)
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
 
 static void __iomem *cfg1_map(struct loongson_pci *priv, int bus,
 				unsigned int devfn, int where)
-- 
2.39.2

