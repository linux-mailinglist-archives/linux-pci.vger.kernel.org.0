Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65D774E4D
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjHHWeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjHHWeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 18:34:36 -0400
Received: from out-72.mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2ADB10B
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 15:34:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691534069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=noQeSrC40sd/EXkeg8fxahy+pA50ftyssyowKNSXpwM=;
        b=bmnuHOjNxAVhqjQOMstFLbhvA7AheHtRPdPVazLBqkBj17xtd3uGnHL/K2InWr0ptnzDFD
        ObY6ZX76LkF1kTuK4SxezbX0dBOd2wGgTr9nMpWDU3JDp173MGKw9ID+4bBl63G0cBZc7O
        hT1KYhpjhwPNNTyUYGFhYaX3lUZEIYA=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dave Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 03/11] PCI/VGA: Deal with VGA class devices
Date:   Wed,  9 Aug 2023 06:34:04 +0800
Message-Id: <20230808223412.1743176-4-sui.jingfeng@linux.dev>
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

vgaarb only cares about PCI(e) VGA devices (pdev->class == 0x0300XX)
Currently, hence we only need to add VGA devices has its class code equals
to 0x0300 to the arbiter. To keep align with the previous behavior. we
ignore the programming interface byte (the least significant 8 bits)
intentionally.

After apply this patch, We will filter the unqualified devices out in the
vga_arb_device_init() function. While the current implementation is to
search all PCI devices in a system, this is not efficient. This also means
that deleting a PCI device no longer needs to walk the list.

Note that the major contribution of this patch is optimization.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 68 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c1bc6c983932..8742a51d450f 100644
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
@@ -1493,6 +1489,42 @@ static void vga_arbiter_notify_clients(void)
 	spin_unlock_irqrestore(&vga_lock, flags);
 }
 
+/*
+ * The PCI Class Code spec implies that only VGA devices with programming
+ * interface 0x00 can depend on the legacy VGA address range. VGA devices
+ * with programming interface 0x01 are 8514-compatible controllers. Since
+ * VGA devices with programming interface 0x00 is VGA compatible, the 'vga'
+ * suffix here should refer to the VGA-compatible devices after a strict
+ * reading of that specification. But considering the fact that there
+ * probably don't has a 8514-compatible controller that could be used with
+ * upstream kernel anymore, we would like to just ignore the programming
+ * interface byte.
+ *
+ * Besides, there do exist non VGA-compatible display controllers in the
+ * world and hardware vendors may abandon the old VGA standard someday.
+ * The meaning of 'vga' suffix here may change to evolve with time.
+ *
+ * A strict understanding of 'vga' certainly should be VGA-compatible, While
+ * a relaxed understanding of 'vga' would be PCI devices that are able to
+ * display. Currently, we just keep aligned to the previous behavior.
+ * Deal with VGA class devices.
+ */
+static bool pci_dev_is_vga(struct pci_dev *pdev)
+{
+	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+		return true;
+
+	/*
+	 * The PCI_CLASS_NOT_DEFINED_VGA is defined to provide backward
+	 * compatibility for devices that were built before the class code
+	 * field was defined.
+	 */
+	if ((pdev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA)
+		return true;
+
+	return false;
+}
+
 static int pci_notify(struct notifier_block *nb, unsigned long action,
 		      void *data)
 {
@@ -1502,6 +1534,9 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
+	if (!pci_dev_is_vga(pdev))
+		return 0;
+
 	/* For now we're only intereted in devices added and removed. I didn't
 	 * test this thing here, so someone needs to double check for the
 	 * cases of hotplugable vga cards. */
@@ -1534,8 +1569,8 @@ static struct miscdevice vga_arb_device = {
 
 static int __init vga_arb_device_init(void)
 {
+	struct pci_dev *pdev = NULL;
 	int rc;
-	struct pci_dev *pdev;
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
@@ -1543,13 +1578,22 @@ static int __init vga_arb_device_init(void)
 
 	bus_register_notifier(&pci_bus_type, &pci_notifier);
 
-	/* We add all PCI devices satisfying VGA class in the arbiter by
-	 * default */
-	pdev = NULL;
-	while ((pdev =
-		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-			       PCI_ANY_ID, pdev)) != NULL)
-		vga_arbiter_add_pci_device(pdev);
+	/*
+	 * We add all PCI devices satisfying VGA class in the arbiter
+	 * by default, but we ignore the programming interface byte
+	 * intentionally.
+	 */
+	do {
+		pdev = pci_get_class_masked(PCI_CLASS_DISPLAY_VGA << 8, 0xFFFF00, pdev);
+		if (pdev && pci_dev_is_vga(pdev))
+			vga_arbiter_add_pci_device(pdev);
+	} while (pdev);
+
+	do {
+		pdev = pci_get_class_masked(PCI_CLASS_NOT_DEFINED_VGA << 8, 0xFFFF00, pdev);
+		if (pdev && pci_dev_is_vga(pdev))
+			vga_arbiter_add_pci_device(pdev);
+	} while (pdev);
 
 	pr_info("loaded\n");
 	return rc;
-- 
2.34.1

