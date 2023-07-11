Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8474F08F
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjGKNog (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjGKNod (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:44:33 -0400
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [91.218.175.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D11702;
        Tue, 11 Jul 2023 06:44:25 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689083063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NIy4iyC9nuH2OGqIfvEGjD1H7yPmKE3hN2OnCkSSwos=;
        b=M5PbJsEas/pXLhY4bwrSzQ/fEGUVORpMVmQVcHLy3OjgNETQPgCHeJLRfbT1A5TZr4ofaV
        dciq2+E7wwBjI1+3/pnGDRSITsSwsg8a3lf3w7+pXO+C1xXKSp248NOmqPKXo1bWwUIb/l
        Vf2D+/G31gJ7u+EAJbM2VTSEsHDQm6s=
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
Subject: [PATCH 4/6] PCI/VGA: Move the new_state assignment out the loop
Date:   Tue, 11 Jul 2023 21:43:52 +0800
Message-Id: <20230711134354.755966-5-sui.jingfeng@linux.dev>
In-Reply-To: <20230711134354.755966-1-sui.jingfeng@linux.dev>
References: <20230711134354.755966-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

In the vga_arbiter_notify_clients() function, the value of the 'new_state'
variable will be 'false' on systems that have more than one PCI VGA card.
Its value will be 'true' on systems that have one or no PCI VGA compatible
card. In other words, its value is not relevant to the iteration, so move
the assignment () out of the loop.

For a system with multiple video cards, this patch saves the redundant
assignment.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 668139f7c247..4c448c758bab 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1468,22 +1468,20 @@ static void vga_arbiter_notify_clients(void)
 {
 	struct vga_device *vgadev;
 	unsigned long flags;
-	uint32_t new_decodes;
-	bool new_state;
+	bool state;
 
 	if (!vga_arbiter_used)
 		return;
 
+	state = (vga_count > 1) ? false : true;
+
 	spin_lock_irqsave(&vga_lock, flags);
 	list_for_each_entry(vgadev, &vga_list, list) {
-		if (vga_count > 1)
-			new_state = false;
-		else
-			new_state = true;
 		if (vgadev->set_decode) {
-			new_decodes = vgadev->set_decode(vgadev->pdev,
-							 new_state);
-			vga_update_device_decodes(vgadev, new_decodes);
+			unsigned int decodes;
+
+			decodes = vgadev->set_decode(vgadev->pdev, state);
+			vga_update_device_decodes(vgadev, decodes);
 		}
 	}
 	spin_unlock_irqrestore(&vga_lock, flags);
-- 
2.25.1

