Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4787774E56
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjHHWeo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjHHWel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:41 -0400
Received: from out-76.mta1.migadu.com (out-76.mta1.migadu.com [95.215.58.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E201B4
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzZwtUzLVgyigIZtu0FTQnFL+tgS0hu77QEo/xERbug=;
        b=DGYotxqNLyZsNF2IhhW+hGPcxHM/d9eMPF9lhqKC3341P3IrJ+qrPvpcLToq9oBZD1PR0F
        A2j9JANAQEm7SnZ98HhQ6RDX0BuJJNhpHUfinaFEM9j29EBLRlA84huObzAoFTeTMViyZD
        1oWz4mA51DDBJiuVfb30E9SV7R7bhqY=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 07/11] PCI/VGA: vga_client_register() return -ENODEV on failure, not -1
Date:   Wed,  9 Aug 2023 06:34:08 +0800
Message-Id: <20230808223412.1743176-8-sui.jingfeng@linux.dev>
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

Fixes: 934f992c763a ("drm/i915: Recognise non-VGA display devices")
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 811510253553..a6b8c0def35d 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -964,7 +964,7 @@ EXPORT_SYMBOL(vga_set_legacy_decoding);
  *
  * To unregister just call vga_client_unregister().
  *
- * Returns: 0 on success, -1 on failure
+ * Returns: 0 on success, -ENODEV on failure
  */
 int vga_client_register(struct pci_dev *pdev,
 		unsigned int (*set_decode)(struct pci_dev *pdev, bool decode))
@@ -975,16 +975,13 @@ int vga_client_register(struct pci_dev *pdev,
 
 	spin_lock_irqsave(&vga_lock, flags);
 	vgadev = vgadev_find(pdev);
-	if (!vgadev)
-		goto bail;
-
-	vgadev->set_decode = set_decode;
-	ret = 0;
-
-bail:
+	if (vgadev) {
+		vgadev->set_decode = set_decode;
+		ret = 0;
+	}
 	spin_unlock_irqrestore(&vga_lock, flags);
-	return ret;
 
+	return ret;
 }
 EXPORT_SYMBOL(vga_client_register);
 
-- 
2.34.1

