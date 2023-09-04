Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA31791E01
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236919AbjIDT6X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbjIDT6W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 15:58:22 -0400
Received: from out-214.mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB64170B
        for <linux-pci@vger.kernel.org>; Mon,  4 Sep 2023 12:57:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693857474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fhoRcuVch+7Gf4upXx5ouxYbS2GV0Aor2KTGkzLAL+I=;
        b=MsA02426tkJinkpz1/CD7KSiRYKyWnFWxA5gA3o4DzZdbtVyCxWD9yLCkse2QF1pq+rwCH
        GgV2R6PtMuA8UlGOKYY/J4alpOdakscn17HMIelz71RXSqt63hYGHhWu34q9bHpuwiM08Z
        xATVnBtvw/osh/XBPWbOGOPfG3A0KXc=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [RFC,drm-misc-next v4 9/9] drm/gma500: Register as a VGA client by calling vga_client_register()
Date:   Tue,  5 Sep 2023 03:57:24 +0800
Message-Id: <20230904195724.633404-10-sui.jingfeng@linux.dev>
In-Reply-To: <20230904195724.633404-1-sui.jingfeng@linux.dev>
References: <20230904195724.633404-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Because the display controller in N2000/D2000 series can be VGA-compatible,
so let's register gma500 as a VGA client, despite the firmware may alter
the PCI class code of IGD on a multiple GPU co-exist configuration. But
this commit no crime, because VGAARB only cares about VGA devices.

Noticed that the display controller in N2000/D2000 processor don't has a
valid VRAM BAR, the firmware put the EFI firmware framebuffer into the
stolen memory, so the commit <86fd887b7fe3> ("vgaarb: Don't default
exclusively to first video device with mem+io") is not effictive on such
a case. But the benefits of the stolen memory is that it will not suffer
from PCI resource relocation. Becase the stolen memory is carved out by
the firmware and reside in system RAM. Therefore, while at it, provided a
naive version of firmware framebuffer identification function and use the
new machanism just created.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/gma500/psb_drv.c | 57 ++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index 8b64f61ffaf9..eb95d030d981 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -14,7 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/delay.h>
-
+#include <linux/vgaarb.h>
 #include <asm/set_memory.h>
 
 #include <acpi/video.h>
@@ -36,6 +36,11 @@
 #include "psb_irq.h"
 #include "psb_reg.h"
 
+static int gma500_modeset = -1;
+
+MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
+module_param_named(modeset, gma500_modeset, int, 0400);
+
 static const struct drm_driver driver;
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 
@@ -446,6 +451,49 @@ static int gma_remove_conflicting_framebuffers(struct pci_dev *pdev,
 	return __aperture_remove_legacy_vga_devices(pdev);
 }
 
+static bool gma_contain_firmware_fb(u64 ap_start, u64 ap_end)
+{
+	u64 fb_start;
+	u64 fb_size;
+	u64 fb_end;
+
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_start = (u64)screen_info.ext_lfb_base << 32 | screen_info.lfb_base;
+	else
+		fb_start = screen_info.lfb_base;
+
+	fb_size = screen_info.lfb_size;
+	fb_end = fb_start + fb_size - 1;
+
+	/* No firmware framebuffer support */
+	if (!fb_start || !fb_size)
+		return false;
+
+	if (fb_start >= ap_start && fb_end <= ap_end)
+		return true;
+
+	return false;
+}
+
+static bool gma_want_to_be_primary(struct pci_dev *pdev)
+{
+	struct drm_device *drm = pci_get_drvdata(pdev);
+	struct drm_psb_private *priv = to_drm_psb_private(drm);
+	u64 vram_base = priv->stolen_base;
+	u64 vram_size = priv->vram_stolen_size;
+
+	if (gma500_modeset == 10)
+		return true;
+
+	/* Stolen memory are not going to be moved */
+	if (gma_contain_firmware_fb(vram_base, vram_base + vram_size)) {
+		drm_dbg(drm, "Contains firmware FB in the stolen memory\n");
+		return true;
+	}
+
+	return false;
+}
+
 static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct drm_psb_private *dev_priv;
@@ -475,6 +523,8 @@ static int psb_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	vga_client_register(pdev, NULL, gma_want_to_be_primary);
+
 	psb_fbdev_setup(dev_priv);
 
 	return 0;
@@ -526,7 +576,10 @@ static struct pci_driver psb_pci_driver = {
 
 static int __init psb_init(void)
 {
-	if (drm_firmware_drivers_only())
+	if (drm_firmware_drivers_only() && (gma500_modeset == -1))
+		return -ENODEV;
+
+	if (!gma500_modeset)
 		return -ENODEV;
 
 	return pci_register_driver(&psb_pci_driver);
-- 
2.34.1

