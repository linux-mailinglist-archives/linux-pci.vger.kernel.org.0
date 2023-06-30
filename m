Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C67574394B
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjF3KXx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjF3KXu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:23:50 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [IPv6:2001:41d0:1004:224b::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6CF2D55
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 03:23:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688120627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qn2GXzSHm2puRLoEUfB5VD8PuaCwtWVklsWXBuMQskI=;
        b=cYajXrKD/mWxV/Z+Jm4eYwbPHJDv3nUOTsg/RsGMTvw1WR+pfx3rnZs6S1PFr20H9uyLro
        535XMh8Eu4bJWVm1PidfeUMbHbggjRA2UGbcvjh3rmGzJjyuJsvaAhvEH70u2WpIK/ZGpY
        NEZn2JwtNrr76IP1eBuPtjRQ8qayp/A=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH 1/2] PCI/VGA: Move the new_state assignment out the loop
Date:   Fri, 30 Jun 2023 18:23:42 +0800
Message-Id: <20230630102342.134919-1-sui.jingfeng@linux.dev>
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

In the vga_arbiter_notify_clients() function, the value of the 'new_state'
variable will be 'false' on the systems which have more than one PCI
display card. Its value will be 'true' on the systems which have only one
or no PCI display card. Its value is not relevant to the iteration, so move
the new_state assignment out the loop. For multiple video card systems this
could be an optimization.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index ceb914245383..cbd06bbf9dd7 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1482,22 +1482,20 @@ static void vga_arbiter_notify_clients(void)
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

