Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63E3743965
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjF3Kdd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjF3Kdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:33:32 -0400
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 03:33:31 PDT
Received: from out-51.mta1.migadu.com (out-51.mta1.migadu.com [95.215.58.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A083596
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 03:33:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688120662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8Qdp9pUoNDY5Mvuaf7+DmACBXhNJIeFau8zbx4GIwY4=;
        b=i/whvionwp7XeBI50BDtNvMp+ngKCUEzRxZds9j4ahAqhJmK6r1FRei7sRHniau8/OIylZ
        vkYcn7T9RIFYd2FTAJqNJPdp94Cw0Lh9dxWuAgFxtU0saOFKiEWU6uaZLWtLzP7g28/nL7
        Tzv1xubl9tHNvhORMxE04c8sI/Lclpo=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 2/2] PCI/VGA: drop the inline of vga_update_device_decodes() function
Date:   Fri, 30 Jun 2023 18:24:12 +0800
Message-Id: <20230630102412.134977-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

The vga_update_device_decodes() is NOT a trivial function, nor performance
critical. So drop the inline. Also keep the parameter and argument
consistent. The second argument should declared as 'unsigned int' type.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index cbd06bbf9dd7..17bd1268c36a 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -877,21 +877,21 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 }
 
 /* This is called with the lock */
-static inline void vga_update_device_decodes(struct vga_device *vgadev,
-					     int new_decodes)
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
 
 	/* If we removed locked decodes, lock count goes to zero, and release */
 	if (decodes_unlocked) {
-- 
2.25.1

