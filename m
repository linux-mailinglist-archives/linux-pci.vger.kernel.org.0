Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1AE743949
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jun 2023 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjF3KXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 06:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjF3KXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 06:23:32 -0400
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Jun 2023 03:23:31 PDT
Received: from out-2.mta0.migadu.com (out-2.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7A42D4C
        for <linux-pci@vger.kernel.org>; Fri, 30 Jun 2023 03:23:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688120266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ml7rkVkU9dTc0+Xfj7L5gDY8LPJxmXh8rcpwPh2b98=;
        b=BGaslFGf5MzqKg8hmjZQCbuFcW8ysx9xCnhDgdWOUZJyDhIpqCppGx4MdN0PN3JEm09nqk
        IXICgDA0TFnSpwMSzsvHUKky+eQnGOyURH6hEuDAWTxLZSMO+84otNiFMoM30NBFdK97j1
        iEulAEIbzcJr8RYBCQAmeihTHD6DaWo=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/4] PCI/VGA: Deal only with PCI VGA class devices
Date:   Fri, 30 Jun 2023 18:17:29 +0800
Message-Id: <20230630101731.134375-2-sui.jingfeng@linux.dev>
In-Reply-To: <20230630101731.134375-1-sui.jingfeng@linux.dev>
References: <20230630101731.134375-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

VGAARB should only care about PCI VGA class devices (pdev->class == 0x0300)
since only those devices might have VGA routed to them.
    
PCI_CLASS_DISPLAY_3D and PCI_CLASS_DISPLAY_OTHER are used to annotate the
render-only GPU. Render-only GPUs shouldn't decode the fixed VGA address.
For example, nvidia render-only GPU typically has 0x0380 as its PCI class.

A render-only GPU cannot be used to display something on the screen.
Hence, it should not be the default boot device in normal cases.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c1bc6c983932..22a505e877dc 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -754,10 +754,6 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	struct pci_dev *bridge;
 	u16 cmd;
 
-	/* Only deal with VGA class devices */
-	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-		return false;
-
 	/* Allocate structure */
 	vgadev = kzalloc(sizeof(struct vga_device), GFP_KERNEL);
 	if (vgadev == NULL) {
@@ -1500,7 +1496,9 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 	struct pci_dev *pdev = to_pci_dev(dev);
 	bool notify = false;
 
-	vgaarb_dbg(dev, "%s\n", __func__);
+	/* Only deal with VGA class devices */
+	if (pdev->class != PCI_CLASS_DISPLAY_VGA << 8)
+		return 0;
 
 	/* For now we're only intereted in devices added and removed. I didn't
 	 * test this thing here, so someone needs to double check for the
@@ -1510,6 +1508,8 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 	else if (action == BUS_NOTIFY_DEL_DEVICE)
 		notify = vga_arbiter_del_pci_device(pdev);
 
+	vgaarb_dbg(dev, "%s: action = %lu\n", __func__, action);
+
 	if (notify)
 		vga_arbiter_notify_clients();
 	return 0;
@@ -1534,8 +1534,8 @@ static struct miscdevice vga_arb_device = {
 
 static int __init vga_arb_device_init(void)
 {
+	struct pci_dev *pdev = NULL;
 	int rc;
-	struct pci_dev *pdev;
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
@@ -1545,11 +1545,13 @@ static int __init vga_arb_device_init(void)
 
 	/* We add all PCI devices satisfying VGA class in the arbiter by
 	 * default */
-	pdev = NULL;
-	while ((pdev =
-		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-			       PCI_ANY_ID, pdev)) != NULL)
+	while (1) {
+		pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev);
+		if (!pdev)
+			break;
+
 		vga_arbiter_add_pci_device(pdev);
+	}
 
 	pr_info("loaded\n");
 	return rc;
-- 
2.25.1

