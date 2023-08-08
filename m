Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDC8774E51
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjHHWei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjHHWeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:37 -0400
Received: from out-78.mta1.migadu.com (out-78.mta1.migadu.com [95.215.58.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B9101
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:36 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQgYw5lX3SkYq1STywg88ED6q5FjX9omCE5FKYEvLx8=;
        b=V2b/yZWh7iqOPKRM+woaS0Pcn2y/ZwlopGA/To5CR6hBItv7RHn++t0bdatVP+jBdJY3WF
        XEy5JoecUt0pwfcntmWSCZuzjtsjWYXbh4aYIVQPplR1enGjSuBkUvCm7NtvjmK/1e2a/q
        t2IOEGUJZhKpiH+y+nQ3gBn4OCPe5HA=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>
Subject: [PATCH v2 05/11] PCI/VGA: Move the new_state assignment out of the loop
Date:   Wed,  9 Aug 2023 06:34:06 +0800
Message-Id: <20230808223412.1743176-6-sui.jingfeng@linux.dev>
In-Reply-To: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
References: <20230808223412.1743176-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

In the vga_arbiter_notify_clients() function, the value of the 'new_state'
variable will be 'false' on systems that have more than one VGA device.
The value will be 'true' if there is only one VGA device or no VGA device
at all. Hence, its value is not relevant to the iteration of the loop.

So move the assignment clause out of the loop. For a system with multiple
video cards, this patch saves unnecessary assignment.

Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index dc10a262fb5e..6883067a802a 100644
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
2.34.1

