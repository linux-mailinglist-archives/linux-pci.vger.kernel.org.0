Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF99078DB64
	for <lists+linux-pci@lfdr.de>; Wed, 30 Aug 2023 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbjH3SjI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Aug 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbjH3LYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Aug 2023 07:24:36 -0400
Received: from out-251.mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365F6CDA
        for <linux-pci@vger.kernel.org>; Wed, 30 Aug 2023 04:24:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693394147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duMfcSX8fViHE4Nde8EnuLeu99bLF0srnO8TViASf/g=;
        b=mcBA/F25UOYO/KXJJ64vjpnG+5RuiwByGc4xNO5cbK45vy4PlO3ZPV/X4BtfQnP0FAAde1
        VDqD/IWTzwtopdOE1yBNJzg+V1RDwrfmfWBFny8QuamUf7qfc18SkgIQ/YrA0AdE80FdTb
        n3mRig5+pwFqLgnMMXd33NhWAcmuYQg=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [-next 2/5] PCI/VGA: Deal with VGA devices
Date:   Wed, 30 Aug 2023 19:15:29 +0800
Message-Id: <20230830111532.444535-3-sui.jingfeng@linux.dev>
In-Reply-To: <20230830111532.444535-1-sui.jingfeng@linux.dev>
References: <20230830111532.444535-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

VGAARB only cares about PCI(e) VGA devices, thus filtering out unqualified
devices as early as possible. This also means that deleting a non-VGA
device snooped won't unnecessarily call into vga_arbiter_del_pci_device()
function. By using the newly implemented pci_is_vga(),
PCI(e) with PCI_CLASS_NOT_DEFINED_VGA class code will also be handled.

Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/pci/vgaarb.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 5e6b1eb54c64..ef8fe685de67 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -764,10 +764,6 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	struct pci_dev *bridge;
 	u16 cmd;
 
-	/* Only deal with VGA class devices */
-	if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
-		return false;
-
 	/* Allocate structure */
 	vgadev = kzalloc(sizeof(struct vga_device), GFP_KERNEL);
 	if (vgadev == NULL) {
@@ -1503,6 +1499,9 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
+	if (!pci_is_vga(pdev))
+		return 0;
+
 	/*
 	 * For now, we're only interested in devices added and removed.
 	 * I didn't test this thing here, so someone needs to double check
@@ -1537,8 +1536,8 @@ static struct miscdevice vga_arb_device = {
 
 static int __init vga_arb_device_init(void)
 {
+	struct pci_dev *pdev = NULL;
 	int rc;
-	struct pci_dev *pdev;
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
@@ -1547,11 +1546,11 @@ static int __init vga_arb_device_init(void)
 	bus_register_notifier(&pci_bus_type, &pci_notifier);
 
 	/* Add all VGA class PCI devices by default */
-	pdev = NULL;
-	while ((pdev =
-		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-			       PCI_ANY_ID, pdev)) != NULL)
-		vga_arbiter_add_pci_device(pdev);
+	do {
+		pdev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, pdev);
+		if (pci_is_vga(pdev))
+			vga_arbiter_add_pci_device(pdev);
+	} while (pdev);
 
 	pr_info("loaded\n");
 	return rc;
-- 
2.34.1

