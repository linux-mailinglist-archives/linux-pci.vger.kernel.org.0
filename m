Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C8E4C3907
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 23:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235852AbiBXWtD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 17:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiBXWsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 17:48:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A7D17FD08;
        Thu, 24 Feb 2022 14:48:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C55FFB829B0;
        Thu, 24 Feb 2022 22:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE85C340E9;
        Thu, 24 Feb 2022 22:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645742898;
        bh=05SqviysSW35ZEWRJ3D2DTeYvmlKy3PVigoBvBN3x0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IdjX5qsKbnPuB/tRR0ll2vJw5oZggTDqdFQLijiviXLnFczbj2yd2Y+v1bRRlj7SX
         yGeCj/h+unU4GbaqPz+4NiNEk8ad2ix3e+OeuZBu9rmdEC70uw9KL9R45umte7nnuB
         JYewGicYsXuO0TOQa2X9Qpf+1pS2lLMR8QBX8sNzfscCThhr6u2E6VDDIOX8Q7d5ZG
         gnvIKMSIDqddwRPqm2G+T0n12Yra0zrwcoFzD5vJWnOsvN/ZmQM0Lfp+467gGIpoxc
         wgWS3U6SLrtrBYQpgu1de14F9H6/7O5R0g0TwHpyiqJohKa57yRqm2zj9vRscWogjl
         SxYJUmB2/sn/Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v9 07/11] PCI/VGA: Move disabled VGA device detection to ADD_DEVICE path
Date:   Thu, 24 Feb 2022 16:47:49 -0600
Message-Id: <20220224224753.297579-8-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224224753.297579-1-helgaas@kernel.org>
References: <20220224224753.297579-1-helgaas@kernel.org>
MIME-Version: 1.0
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

a37c0f48950b ("vgaarb: Select a default VGA device even if there's no
legacy VGA") extended the vga_arb_device_init() subsys_initcall so that if
there are no other eligible devices, it could select a disabled VGA device
as the default.

Move this detection from vga_arb_select_default_device() to
vga_arbiter_add_pci_device() so every device, even those hot-added or
enumerated after vga_arb_device_init() is eligible for selection as the
default VGA device.

[bhelgaas: commit log, restructure]
Link: https://lore.kernel.org/r/20211015061512.2941859-5-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/pci/vgaarb.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index e36ccbfdbd89..e8d5efd85ba6 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
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

