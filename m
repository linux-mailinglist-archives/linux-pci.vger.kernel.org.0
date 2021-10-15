Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E546C42E8D1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 08:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJOGTj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 02:19:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231959AbhJOGTi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 02:19:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0779861090;
        Fri, 15 Oct 2021 06:17:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V7 03/11] PCI/VGA: Split out vga_arb_update_default_device()
Date:   Fri, 15 Oct 2021 14:15:04 +0800
Message-Id: <20211015061512.2941859-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015061512.2941859-1-chenhuacai@loongson.cn>
References: <20211015061512.2941859-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch is the first step of the rework: If there's no default VGA
device, and we find a VGA device that owns the legacy VGA resources, we
make that device the default. Split this logic out from vga_arbiter_add_
pci_device() into a new function, vga_arb_update_default_device().

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 29e725ebaa43..f8f95244d499 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -579,6 +579,21 @@ static bool vga_arb_integrated_gpu(struct device *dev)
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
@@ -706,15 +721,7 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
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

