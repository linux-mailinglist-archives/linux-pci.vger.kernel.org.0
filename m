Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E479D4075DE
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbhIKJg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 05:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235481AbhIKJgx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Sep 2021 05:36:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B7CA610F8;
        Sat, 11 Sep 2021 09:35:38 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V5 05/11] PCI/VGA: Update default VGA device if a better one found
Date:   Sat, 11 Sep 2021 17:30:50 +0800
Message-Id: <20210911093056.1555274-6-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210911093056.1555274-1-chenhuacai@loongson.cn>
References: <20210911093056.1555274-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch is the second step of the rework: Update default VGA device if
a better one is found. What is a better one? A device with legacy I/O
resources enabled is better those not enabled. And the integrated GPU is
better than others.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/vgaarb.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index f8f95244d499..02b68810273a 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -582,14 +582,32 @@ static bool vga_arb_integrated_gpu(struct device *dev)
 static void vga_arb_update_default_device(struct vga_device *vgadev)
 {
 	struct pci_dev *pdev = vgadev->pdev;
+	struct device *dev = &pdev->dev;
+	struct vga_device *vgadev_default;
 
 	/*
 	 * If we don't have a default VGA device yet, and this device owns
 	 * the legacy VGA resources, make it the default.
 	 */
-	if (!vga_default_device() &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
-		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
+	if (!vga_default_device()) {
+		if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
+			vgaarb_info(dev, "setting as boot VGA device\n");
+		else
+			vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
+		vga_set_default_device(pdev);
+	}
+
+	vgadev_default = vgadev_find(vga_default);
+
+	/* Overridden by a better device */
+	if (vgadev_default && ((vgadev_default->owns & VGA_RSRC_LEGACY_MASK) == 0)
+		&& ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
+		vgaarb_info(dev, "overriding boot VGA device\n");
+		vga_set_default_device(pdev);
+	}
+
+	if (vga_arb_integrated_gpu(dev)) {
+		vgaarb_info(dev, "overriding boot VGA device\n");
 		vga_set_default_device(pdev);
 	}
 }
-- 
2.27.0

