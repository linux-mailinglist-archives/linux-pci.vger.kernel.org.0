Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCB4C3913
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 23:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbiBXWs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 17:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235771AbiBXWsy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 17:48:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A8E12341F;
        Thu, 24 Feb 2022 14:48:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2474061B90;
        Thu, 24 Feb 2022 22:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB09C340E9;
        Thu, 24 Feb 2022 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645742894;
        bh=OQ79FR504d+gFFyAR5sZLOpMzAP/vH2wBNOitSrOZAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AeKhJkzruTB8zp3fGZOv1HkV7XVgDJphckkliH5trrpWOFw66kBTRlT5k3M4B5mnV
         cxuGBe2Uw3Vis59EOZ3jSFbmLq5G0YgLl1HnnUnplsKx4ZA0ftRDdv7wlVslq8Y/tR
         GDgk7tWkJBDdmOlGVu98D054aywl4OlonYTFrOBhDA51Ky5riSZqIWWhlzpoNhEtDf
         fTG8ncona3g3qfE0lppvPF6v68Rjs48Oevu+GcVAh8rfaskZLmeeSMWlIadHW63TCG
         E+5g2acWsU8y2ki8SE1hINgghhGbMzOs5ZBgc1LsWTZ0Llc5RBD+xwl27aoIAmTWpB
         GMFnZ2WyMpRRA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Subject: [PATCH v9 05/11] PCI/VGA: Move firmware default device detection to ADD_DEVICE path
Date:   Thu, 24 Feb 2022 16:47:47 -0600
Message-Id: <20220224224753.297579-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224224753.297579-1-helgaas@kernel.org>
References: <20220224224753.297579-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

Previously we selected the firmware default device, i.e., one that owns the
boot framebuffer, as the default device in vga_arb_select_default_device().
This was only done in the vga_arb_device_init() subsys_initcall, so devices
enumerated later, e.g., by pcibios_init(), were not eligible.

Fix this by moving the firmware default device selection from
vga_arb_select_default_device() to vga_arbiter_add_pci_device(), which is
called after every PCI device is enumerated, either by the
vga_arb_device_init() subsys_initcall or as an ADD_DEVICE notifier.

Note that if vga_arb_select_default_device() previously found a device
owning the boot framebuffer, it unconditionally set it to be the default
VGA device, and no subsequent device could replace it.

[bhelgaas: commit log, restructure slightly]
Link: https://lore.kernel.org/r/20211015061512.2941859-7-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bruno Prémont <bonbons@linux-vserver.org>
---
 drivers/pci/vgaarb.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 58e0a12e623b..c3323ab4f98e 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -72,6 +72,7 @@ struct vga_device {
 	unsigned int io_norm_cnt;	/* normal IO count */
 	unsigned int mem_norm_cnt;	/* normal MEM count */
 	bool bridge_has_one_vga;
+	bool is_firmware_default;	/* device selected by firmware */
 	unsigned int (*set_decode)(struct pci_dev *pdev, bool decode);
 };
 
@@ -565,10 +566,9 @@ void vga_put(struct pci_dev *pdev, unsigned int rsrc)
 }
 EXPORT_SYMBOL(vga_put);
 
-static void __init vga_select_framebuffer_device(struct pci_dev *pdev)
+static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
 #if defined(CONFIG_X86) || defined(CONFIG_IA64)
-	struct device *dev = &pdev->dev;
 	u64 base = screen_info.lfb_base;
 	u64 size = screen_info.lfb_size;
 	u64 limit;
@@ -583,15 +583,6 @@ static void __init vga_select_framebuffer_device(struct pci_dev *pdev)
 
 	limit = base + size;
 
-	/*
-	 * Override vga_arbiter_add_pci_device()'s I/O based detection
-	 * as it may take the wrong device (e.g. on Apple system under
-	 * EFI).
-	 *
-	 * Select the device owning the boot framebuffer if there is
-	 * one.
-	 */
-
 	/* Does firmware framebuffer belong to us? */
 	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
 		flags = pci_resource_flags(pdev, i);
@@ -608,13 +599,10 @@ static void __init vga_select_framebuffer_device(struct pci_dev *pdev)
 		if (base < start || limit >= end)
 			continue;
 
-		if (!vga_default_device())
-			vgaarb_info(dev, "setting as boot device\n");
-		else if (pdev != vga_default_device())
-			vgaarb_info(dev, "overriding boot device\n");
-		vga_set_default_device(pdev);
+		return true;
 	}
 #endif
+	return false;
 }
 
 static bool vga_arb_integrated_gpu(struct device *dev)
@@ -635,6 +623,7 @@ static bool vga_arb_integrated_gpu(struct device *dev)
 static bool vga_is_boot_device(struct vga_device *vgadev)
 {
 	struct vga_device *boot_vga = vgadev_find(vga_default_device());
+	struct pci_dev *pdev = vgadev->pdev;
 
 	/*
 	 * We select the default VGA device in this order:
@@ -645,6 +634,18 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	 *   Other device (see vga_arb_select_default_device())
 	 */
 
+	/*
+	 * We always prefer a firmware default device, so if we've already
+	 * found one, there's no need to consider vgadev.
+	 */
+	if (boot_vga && boot_vga->is_firmware_default)
+		return false;
+
+	if (vga_is_firmware_default(pdev)) {
+		vgadev->is_firmware_default = true;
+		return true;
+	}
+
 	/*
 	 * A legacy VGA device has MEM and IO enabled and any bridges
 	 * leading to it have PCI_BRIDGE_CTL_VGA enabled so the legacy
@@ -1531,10 +1532,6 @@ static void __init vga_arb_select_default_device(void)
 	struct pci_dev *pdev, *found = NULL;
 	struct vga_device *vgadev;
 
-	list_for_each_entry(vgadev, &vga_list, list) {
-		vga_select_framebuffer_device(vgadev->pdev);
-	}
-
 	if (!vga_default_device()) {
 		list_for_each_entry_reverse(vgadev, &vga_list, list) {
 			struct device *dev = &vgadev->pdev->dev;
-- 
2.25.1

