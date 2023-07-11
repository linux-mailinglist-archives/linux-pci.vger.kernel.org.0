Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4082C74F081
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 15:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjGKNoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjGKNoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 09:44:19 -0400
Received: from out-32.mta0.migadu.com (out-32.mta0.migadu.com [IPv6:2001:41d0:1004:224b::20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E3710DD
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 06:44:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689083056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDDNh+sBHMY69JnXGN2eCCl56IIKvpnc8EX4QusViis=;
        b=WUckSHg09hEzPNeV04y0qZK1g3Jy9t7p1rUsytc1VIEpkXvlHG61+vjN0q3AnCCGgpqhSs
        Ev+jicQte07i3NBYujTu9tcXWwIGZPveSSOVVHCEoNbZomNXUMlxpmz14wyegvfITmsQed
        7l+nv0PlzbWeGIJCvkQ9zw0SS77e7K0=
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
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/6] PCI/VGA: Deal with PCI VGA compatible devices only
Date:   Tue, 11 Jul 2023 21:43:50 +0800
Message-Id: <20230711134354.755966-3-sui.jingfeng@linux.dev>
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

Currently, vgaarb only cares about PCI VGA-compatible class devices.

While vga_arbiter_del_pci_device() gets called unbalanced when some PCI
device is about to be removed. This happens even during the boot process.

Another reason is that the vga_arb_device_init() function is not efficient.
Since we only care about VGA-compatible devices (pdev->class == 0x030000),
We could filter the unqualified devices out in the vga_arb_device_init()
function. While the current implementation is to search all PCI devices
in a system, this is not necessary.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c1bc6c983932..021116ed61cb 100644
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
@@ -1502,6 +1498,10 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
+	/* Deal with VGA compatible devices only */
+	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
+		return 0;
+
 	/* For now we're only intereted in devices added and removed. I didn't
 	 * test this thing here, so someone needs to double check for the
 	 * cases of hotplugable vga cards. */
@@ -1534,8 +1534,8 @@ static struct miscdevice vga_arb_device = {
 
 static int __init vga_arb_device_init(void)
 {
+	struct pci_dev *pdev = NULL;
 	int rc;
-	struct pci_dev *pdev;
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
@@ -1543,13 +1543,14 @@ static int __init vga_arb_device_init(void)
 
 	bus_register_notifier(&pci_bus_type, &pci_notifier);
 
-	/* We add all PCI devices satisfying VGA class in the arbiter by
-	 * default */
-	pdev = NULL;
-	while ((pdev =
-		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-			       PCI_ANY_ID, pdev)) != NULL)
-		vga_arbiter_add_pci_device(pdev);
+	/*
+	 * We add all PCI VGA compatible devices in the arbiter by default
+	 */
+	do {
+		pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev);
+		if (pdev)
+			vga_arbiter_add_pci_device(pdev);
+	} while (pdev);
 
 	pr_info("loaded\n");
 	return rc;
-- 
2.25.1

