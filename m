Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D55263804D5
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 10:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhENIEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 04:04:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:41726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233407AbhENIEu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 04:04:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92DE361451;
        Fri, 14 May 2021 08:03:37 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jingfeng Sui <suijingfeng@loongson.cn>
Subject: [PATCH 5/5] PCI: Support ASpeed VGA cards behind a misbehaving bridge
Date:   Fri, 14 May 2021 16:00:25 +0800
Message-Id: <20210514080025.1828197-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210514080025.1828197-1-chenhuacai@loongson.cn>
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCI-to-PCI bridge spec, bit 3 of Bridge Control Register is
VGA Enable bit which modifies the response to VGA compatible addresses.

If the VGA Enable bit is set, the bridge will decode and forward the
following accesses on the primary interface to the secondary interface.

The ASpeed AST2500 hardward does not set the VGA Enable bit on its
bridge control register, which causes vgaarb subsystem don't think the
VGA card behind the bridge as a valid boot vga device.

So we provide a quirk to fix Xorg auto-detection.

See similar bug:

https://patchwork.kernel.org/project/linux-pci/patch/20170619023528.11532-1-dja@axtens.net/

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jingfeng Sui <suijingfeng@loongson.cn>
---
 drivers/pci/quirks.c | 47 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6ab4b3bba36b..adf5490706ad 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -28,6 +28,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pm_runtime.h>
 #include <linux/switchtec.h>
+#include <linux/vgaarb.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
 #include "pci.h"
 
@@ -297,6 +298,52 @@ static void loongson_mrrs_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, loongson_mrrs_quirk);
 
+
+static void aspeed_fixup_vgaarb(struct pci_dev *pdev)
+{
+	struct pci_dev *bridge;
+	struct pci_bus *bus;
+	struct pci_dev *vdevp = NULL;
+	u16 config;
+
+	bus = pdev->bus;
+	bridge = bus->self;
+
+	/* Is VGA routed to us? */
+	if (bridge && (pci_is_bridge(bridge))) {
+		pci_read_config_word(bridge, PCI_BRIDGE_CONTROL, &config);
+
+		/* Yes, this bridge is PCI bridge-to-bridge spec compliant,
+		 *  just return!
+		 */
+		if (config & PCI_BRIDGE_CTL_VGA)
+			return;
+
+		dev_warn(&pdev->dev, "VGA bridge control is not enabled\n");
+	}
+
+	/* Just return if the system already have a default device */
+	if (vga_default_device())
+		return;
+
+	/* No default vga device */
+	while ((vdevp = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, vdevp))) {
+		if (vdevp->vendor != 0x1a03) {
+			/* Have other vga devcie in the system, do nothing */
+			dev_info(&pdev->dev, "Another boot vga device: 0x%x:0x%x\n",
+				vdevp->vendor, vdevp->device);
+			return;
+		}
+	}
+
+	vga_set_default_device(pdev);
+
+	dev_info(&pdev->dev, "Boot vga device set as 0x%x:0x%x\n",
+			pdev->vendor, pdev->device);
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(0x1a03, 0x2000, PCI_CLASS_DISPLAY_VGA, 8, aspeed_fixup_vgaarb);
+
+
 /*
  * The Mellanox Tavor device gives false positive parity errors.  Disable
  * parity error reporting.
-- 
2.27.0

