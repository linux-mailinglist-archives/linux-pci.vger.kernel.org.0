Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF94C554D
	for <lists+linux-pci@lfdr.de>; Sat, 26 Feb 2022 11:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiBZKx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 26 Feb 2022 05:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiBZKx4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 Feb 2022 05:53:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A60FCF
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 02:53:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05FF16102F
        for <linux-pci@vger.kernel.org>; Sat, 26 Feb 2022 10:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92F13C340F1;
        Sat, 26 Feb 2022 10:53:19 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V12 6/6] PCI: Add quirk for multifunction devices of LS7A
Date:   Sat, 26 Feb 2022 18:47:31 +0800
Message-Id: <20220226104731.76776-7-chenhuacai@loongson.cn>
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

From: Jianmin Lv <lvjianmin@loongson.cn>

In LS7A, multifunction device use same PCI PIN (because the PIN register
report the same INTx value to each function) but we need different IRQ
for different functions, so add a quirk to fix it for standard PCI PIN
usage.

This patch only affect ACPI based systems (and only needed by ACPI based
systems, too). For DT based systems, the irq mappings is defined in .dts
files and be handled by of_irq_parse_pci().

Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/controller/pci-loongson.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/pci-loongson.c b/drivers/pci/controller/pci-loongson.c
index 9f90619c4277..8aa716846117 100644
--- a/drivers/pci/controller/pci-loongson.c
+++ b/drivers/pci/controller/pci-loongson.c
@@ -22,6 +22,13 @@
 #define DEV_LS2K_APB	0x7a02
 #define DEV_LS7A_CONF	0x7a10
 #define DEV_LS7A_LPC	0x7a0c
+#define DEV_LS7A_GMAC	0x7a03
+#define DEV_LS7A_DC1	0x7a06
+#define DEV_LS7A_DC2	0x7a36
+#define DEV_LS7A_GPU	0x7a15
+#define DEV_LS7A_AHCI	0x7a08
+#define DEV_LS7A_EHCI	0x7a14
+#define DEV_LS7A_OHCI	0x7a24
 
 #define FLAG_CFG0	BIT(0)
 #define FLAG_CFG1	BIT(1)
@@ -108,6 +115,31 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_LOONGSON,
 			DEV_PCIE_PORT_2, loongson_bmaster_quirk);
 
+static void loongson_pci_pin_quirk(struct pci_dev *pdev)
+{
+	pdev->pin = 1 + (PCI_FUNC(pdev->devfn) & 3);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_DC1, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_DC2, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_GPU, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_GMAC, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_AHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_EHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_LS7A_OHCI, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_0, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_1, loongson_pci_pin_quirk);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LOONGSON,
+			DEV_PCIE_PORT_2, loongson_pci_pin_quirk);
+
 static struct loongson_pci *pci_bus_to_loongson_pci(struct pci_bus *bus)
 {
 	struct pci_config_window *cfg;
-- 
2.27.0

