Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094FA3F9643
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhH0Igx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 04:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244471AbhH0Igw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 04:36:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E2C960EB3;
        Fri, 27 Aug 2021 08:36:02 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V4 07/10] PCI/VGA: Split out vga_arb_update_default_device()
Date:   Fri, 27 Aug 2021 16:31:26 +0800
Message-Id: <20210827083129.2781420-8-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210827083129.2781420-1-chenhuacai@loongson.cn>
References: <20210827083129.2781420-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If there's no default VGA device, and we find a VGA device that owns the
legacy VGA resources, we make that device the default.  Split this logic
out from vga_arbiter_add_pci_device() into a new function,
vga_arb_update_default_device().

[bhelgaas: split another piece to separate patch]
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index a6a5864ff538..4cecb599f5ed 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -577,6 +577,21 @@ static bool vga_arb_integrated_gpu(struct device *dev)
 }
 #endif
 
+static void vga_arb_update_default_device(struct vga_device *vgadev)
+{
+	struct pci_dev *pdev = vgadev->pdev;
+
+	/*
+	 * If we don't have a default VGA device yet, and this device owns
+	 * the legacy VGA resources, make it the default.
+	 */
+	if (!vga_default_device() &&
+	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
+		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
+		vga_set_default_device(pdev);
+	}
+}
+
 /*
  * Rules for using a bridge to control a VGA descendant decoding: if a bridge
  * has only one VGA descendant then it can be used to control the VGA routing
@@ -704,15 +719,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 		bus = bus->parent;
 	}
 
-	/* Deal with VGA default device. Use first enabled one
-	 * by default if arch doesn't have it's own hook
-	 */
-	if (!vga_default_device() &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
-		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
-		vga_set_default_device(pdev);
-	}
-
+	vga_arb_update_default_device(vgadev);
 	vga_arbiter_check_bridge_sharing(vgadev);
 
 	/* Add to the list */
-- 
2.27.0

