Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B75B40D4A9
	for <lists+linux-pci@lfdr.de>; Thu, 16 Sep 2021 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhIPIiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 04:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231273AbhIPIiJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Sep 2021 04:38:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A86060F58;
        Thu, 16 Sep 2021 08:36:47 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V6 09/12] PCI/VGA: Log bridge control messages when adding devices
Date:   Thu, 16 Sep 2021 16:29:38 +0800
Message-Id: <20210916082941.3421838-10-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210916082941.3421838-1-chenhuacai@loongson.cn>
References: <20210916082941.3421838-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Previously vga_arb_device_init() iterated through all VGA devices and
indicated whether legacy VGA routing to each could be controlled by an
upstream bridge.

But we determine that information in vga_arbiter_add_pci_device(), which we
call for every device, so we can log it there without iterating through the
VGA devices again.

Note that we call vga_arbiter_check_bridge_sharing() before adding the
device to vga_list, so we have to handle the very first device separately.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 7cd989c5d03b..7f52db439c11 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -672,8 +672,10 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
 
 	vgadev->bridge_has_one_vga = true;
 
-	if (list_empty(&vga_list))
+	if (list_empty(&vga_list)) {
+		vgaarb_info(&vgadev->pdev->dev, "bridge control possible\n");
 		return;
+	}
 
 	/* okay iterate the new devices bridge hierarachy */
 	new_bus = vgadev->pdev->bus;
@@ -712,6 +714,11 @@ static void vga_arbiter_check_bridge_sharing(struct vga_device *vgadev)
 		}
 		new_bus = new_bus->parent;
 	}
+
+	if (vgadev->bridge_has_one_vga)
+		vgaarb_info(&vgadev->pdev->dev, "bridge control possible\n");
+	else
+		vgaarb_info(&vgadev->pdev->dev, "no bridge control possible\n");
 }
 
 /*
@@ -1504,7 +1511,6 @@ static int __init vga_arb_device_init(void)
 {
 	int rc;
 	struct pci_dev *pdev;
-	struct vga_device *vgadev;
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
@@ -1520,15 +1526,6 @@ static int __init vga_arb_device_init(void)
 			       PCI_ANY_ID, pdev)) != NULL)
 		vga_arbiter_add_pci_device(pdev);
 
-	list_for_each_entry(vgadev, &vga_list, list) {
-		struct device *dev = &vgadev->pdev->dev;
-
-		if (vgadev->bridge_has_one_vga)
-			vgaarb_info(dev, "bridge control possible\n");
-		else
-			vgaarb_info(dev, "no bridge control possible\n");
-	}
-
 	return rc;
 }
 subsys_initcall(vga_arb_device_init);
-- 
2.27.0

