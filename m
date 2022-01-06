Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54F8485CDD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343503AbiAFAH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245760AbiAFAHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 19:07:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25181C061212;
        Wed,  5 Jan 2022 16:07:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D436199B;
        Thu,  6 Jan 2022 00:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AA8C36AEB;
        Thu,  6 Jan 2022 00:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427643;
        bh=QvBYfgQFxgIJLEsygEejf0q/8P2zDm4EbtVDmjAMLW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LlUfS4cfTK2DaHGYqFx6o8so6vN+0fRCV5y4uLSZ8ipPoWXwIHfT6g2Uq/Aa7JI3N
         ckeVQHF3Kp/alUYxddkIvdl3CctNqrOS3RN0Z6AnelJGaDOnG1Tgg4LaHUzjL3FTfK
         3uED0M4WulPkCegDsEvFSN/whg8m/dj2srcZSXXCBsLBLWOBoUw+Uicd/ukQa71EJQ
         cCQZVtZ8KTXGS2rLFxETKWGB+gxq/Kkh7ASJclhl/a1xBrFhjIxej11+b9eTKD+0R+
         u35LpEaNXaKyGezkwnw1SQAeymPHeoIIxNdC55Tdr8S4IDonSupOp+Xx6kIbZygQ0z
         yZK17rcvPi4+w==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v8 06/10] vgaarb: Move disabled VGA device detection to ADD_DEVICE path
Date:   Wed,  5 Jan 2022 18:06:54 -0600
Message-Id: <20220106000658.243509-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106000658.243509-1-helgaas@kernel.org>
References: <20220106000658.243509-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

a37c0f48950b ("vgaarb: Select a default VGA device even if there's no
legacy VGA") extended the vga_arb_device_init() subsys_initcall so that if
there are no other eligible devices, it could select a disabled VGA device
as the default.

Move this detection from vga_arb_select_default_device() to
vga_arbiter_add_pci_device() so every device, even those hot-added or
enumerated after vga_arb_device_init() is eligible for selection as the
default VGA device.

Link: https://lore.kernel.org/r/20211015061512.2941859-5-chenhuacai@loongson.cn
Based-on-patch-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/gpu/vga/vgaarb.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 123b81628061..ad548917e602 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -656,7 +656,8 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	 * We use the first one we find, so if we've already found one,
 	 * vgadev is no better.
 	 */
-	if (boot_vga)
+	if (boot_vga &&
+	    (boot_vga->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
 		return false;
 
 	if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
@@ -693,6 +694,13 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 		return true;
 	}
 
+	/*
+	 * vgadev has neither IO nor MEM enabled.  If we haven't found any
+	 * other VGA devices, it is the best candidate so far.
+	 */
+	if (!boot_vga)
+		return true;
+
 	return false;
 }
 
@@ -1559,21 +1567,6 @@ static struct miscdevice vga_arb_device = {
 	MISC_DYNAMIC_MINOR, "vga_arbiter", &vga_arb_device_fops
 };
 
-static void __init vga_arb_select_default_device(void)
-{
-	struct vga_device *vgadev;
-
-	if (!vga_default_device()) {
-		vgadev = list_first_entry_or_null(&vga_list,
-						  struct vga_device, list);
-		if (vgadev) {
-			struct device *dev = &vgadev->pdev->dev;
-			vgaarb_info(dev, "setting as boot device (VGA legacy resources not available)\n");
-			vga_set_default_device(vgadev->pdev);
-		}
-	}
-}
-
 static int __init vga_arb_device_init(void)
 {
 	int rc;
@@ -1603,8 +1596,6 @@ static int __init vga_arb_device_init(void)
 			vgaarb_info(dev, "no bridge control possible\n");
 	}
 
-	vga_arb_select_default_device();
-
 	pr_info("loaded\n");
 	return rc;
 }
-- 
2.25.1

