Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB771774E4C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjHHWeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjHHWee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:34 -0400
Received: from out-80.mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252EFD
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mu/MhoXFJ/cEi4FsJokzAE/sQ7XHHhWDIZhXGhQKIk8=;
        b=Adl1tcB78U1uq/fZLe6GYcn43LbRpfgPBKK17xeIW5yXvQaRZ0n/Abirru9G+fZ9WkrwIg
        C9ZiabiIncjvC0hXZT2kaf7Z7KaAf0tycBNkaCe8u87wtDhLXUmSxsGGtI9dyQZg1sKAHZ
        tIGGl4udI9xcc1Tdsvdo23/Yipt8Ehs=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 04/11] PCI/VGA: Drop the inline in the vga_update_device_decodes() function.
Date:   Wed,  9 Aug 2023 06:34:05 +0800
Message-Id: <20230808223412.1743176-5-sui.jingfeng@linux.dev>
In-Reply-To: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The vga_update_device_decodes() function is not performance-critical.
So drop the inline. This patch also makes the parameter consistent with
the argument, using the 'unsigned int' type instead of the 'signed' type
to store the decode.

Change the second argument of the vga_update_device_decodes() function
to 'unsigned int' type.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 8742a51d450f..dc10a262fb5e 100644
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
2.34.1

