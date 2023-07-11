Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4774F08C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjGKNo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbjGKNoY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:44:24 -0400
Received: from out-27.mta0.migadu.com (out-27.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A3BB4
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 06:44:21 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689083060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nSELRnxi3WNW936UlC8GM9d7GKkUecfY1U1Y7wjl+uY=;
        b=xJyYazfcQNg5BkenFjHDBatlKKm0dhriClEVMtpSJ0VFseaNKgOJNiTxOUYiKr2cnh7/um
        z5uVCpJIXf9DPBH/tnLaP7PP4CYkNlRcgiB8Sgp3cf9dk1Aovox2BT0Ky6waQnsC7ENo6V
        Tlv9Vq/fuRA085J2lVe38D/l0AOB6/M=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Sui@vger.kernel.org,
        Jingfeng@loongson.cn
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 3/6] PCI/VGA: drop the inline of vga_update_device_decodes() function
Date:   Tue, 11 Jul 2023 21:43:51 +0800
Message-Id: <20230711134354.755966-4-sui.jingfeng@linux.dev>
In-Reply-To: <20230711134354.755966-1-sui.jingfeng@linux.dev>
References: <20230711134354.755966-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The vga_update_device_decodes() function is NOT a trivial function, It is
not performance critical either. So, drop the inline.

This patch also make the parameter and argument consistent, use unsigned
int type instead of the signed type to store the decode. Change the second
argument of vga_update_device_decodes() function as 'unsigned int' type.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 021116ed61cb..668139f7c247 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -860,24 +860,24 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 	return ret;
 }
 
-/* this is called with the lock */
-static inline void vga_update_device_decodes(struct vga_device *vgadev,
-					     int new_decodes)
+/* This is called with the lock */
+static void vga_update_device_decodes(struct vga_device *vgadev,
+				      unsigned int new_decodes)
 {
 	struct device *dev = &vgadev->pdev->dev;
-	int old_decodes, decodes_removed, decodes_unlocked;
+	unsigned int old_decodes = vgadev->decodes;
+	unsigned int decodes_removed = ~new_decodes & old_decodes;
+	unsigned int decodes_unlocked = vgadev->locks & decodes_removed;
 
-	old_decodes = vgadev->decodes;
-	decodes_removed = ~new_decodes & old_decodes;
-	decodes_unlocked = vgadev->locks & decodes_removed;
 	vgadev->decodes = new_decodes;
 
-	vgaarb_info(dev, "changed VGA decodes: olddecodes=%s,decodes=%s:owns=%s\n",
-		vga_iostate_to_str(old_decodes),
-		vga_iostate_to_str(vgadev->decodes),
-		vga_iostate_to_str(vgadev->owns));
+	vgaarb_info(dev,
+		    "VGA decodes changed: olddecodes=%s,decodes=%s:owns=%s\n",
+		    vga_iostate_to_str(old_decodes),
+		    vga_iostate_to_str(vgadev->decodes),
+		    vga_iostate_to_str(vgadev->owns));
 
-	/* if we removed locked decodes, lock count goes to zero, and release */
+	/* If we removed locked decodes, lock count goes to zero, and release */
 	if (decodes_unlocked) {
 		if (decodes_unlocked & VGA_RSRC_LEGACY_IO)
 			vgadev->io_lock_cnt = 0;
-- 
2.25.1

