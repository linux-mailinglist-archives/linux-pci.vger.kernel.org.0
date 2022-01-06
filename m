Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E8485CE0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343548AbiAFAH3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343519AbiAFAHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 19:07:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB1C06118A;
        Wed,  5 Jan 2022 16:07:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C67136199B;
        Thu,  6 Jan 2022 00:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B32C36AED;
        Thu,  6 Jan 2022 00:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427641;
        bh=FzOZFXfRW7iKLHtKUv+FE2m7xC0KfPGeO0MaK0M98W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o0qhmJ3j/G2mtIHKxxqDDBK1w8cAKjIiIDTOyQxWV9nWlovR9m7yu+gurMc+WaHLx
         Gr00tvZAi7o51MYsw0ADN20Em4bZxOutyOV0QG+B+mKt3DLmn1yAnTQpD8DF0NChbU
         KGY+fDB8UbgkxgAasbJj05PMqIDilNVE29GmnyRz1AlXgI6YxbcYifjba7dimxKo8j
         IpuEM2z4nEHSQvFts9jJt0jpbPPZyFsFejCnCoYXG8BTm/nZtoo7jnTgM4GB4/HvDf
         HODbQ8iOYMBq8St2dhxt/PR8TSLdP5TSFyozomgJrQ22prL7gFYb71IAHmqnX/JTmS
         e1WFrCEPqvLOQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Daniel Axtens <dja@axtens.net>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH v8 05/10] vgaarb: Move non-legacy VGA detection to ADD_DEVICE path
Date:   Wed,  5 Jan 2022 18:06:53 -0600
Message-Id: <20220106000658.243509-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106000658.243509-1-helgaas@kernel.org>
References: <20220106000658.243509-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

a37c0f48950b ("vgaarb: Select a default VGA device even if there's no
legacy VGA") extended the vga_arb_device_init() subsys_initcall so it could
select a non-legacy VGA device as the default.

That failed to consider that PCI devices may be enumerated after
vga_arb_device_init(), e.g., hot-added devices or non-ACPI systems that do
PCI enumeration in pcibios_init().  Devices found then could never be
selected as the default.

One system where this is a problem is the MIPS-based Loongson where an
ASpeed AST2500 VGA device is behind a bridge that doesn't implement the VGA
Enable bit, so legacy resources are not routed to the VGA device. [1]

Fix this by moving the non-legacy VGA device selection from
vga_arb_select_default_device() to vga_arbiter_add_pci_device(), which is
called after every PCI device is enumerated, either by the
vga_arb_device_init() subsys_initcall or as an ADD_DEVICE notifier.

[1] https://lore.kernel.org/r/20210514080025.1828197-6-chenhuacai@loongson.cn

Link: https://lore.kernel.org/r/20211015061512.2941859-5-chenhuacai@loongson.cn
Link: https://lore.kernel.org/r/20211015061512.2941859-7-chenhuacai@loongson.cn
Based-on-patch-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/gpu/vga/vgaarb.c | 54 ++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index aefa4f406f7d..123b81628061 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
@@ -624,6 +624,7 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 {
 	struct vga_device *boot_vga = vgadev_find(vga_default_device());
 	struct pci_dev *pdev = vgadev->pdev;
+	u16 cmd, boot_cmd;
 
 	/*
 	 * We select the default VGA device in this order:
@@ -661,6 +662,37 @@ static bool vga_is_boot_device(struct vga_device *vgadev)
 	if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
 		return true;
 
+	/*
+	 * If we haven't found a legacy VGA device, accept a non-legacy
+	 * device.  It may have either IO or MEM enabled, and bridges may
+	 * not have PCI_BRIDGE_CTL_VGA enabled, so it may not be able to
+	 * use legacy VGA resources.  Prefer an integrated GPU over others.
+	 */
+	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
+	if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
+
+		/*
+		 * An integrated GPU overrides a previous non-legacy
+		 * device.  We expect only a single integrated GPU, but if
+		 * there are more, we use the *last* because that was the
+		 * previous behavior.
+		 */
+		if (vga_arb_integrated_gpu(&pdev->dev))
+			return true;
+
+		/*
+		 * We prefer the first non-legacy discrete device we find.
+		 * If we already found one, vgadev is no better.
+		 */
+		if (boot_vga) {
+			pci_read_config_word(boot_vga->pdev, PCI_COMMAND,
+					     &boot_cmd);
+			if (boot_cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY))
+				return false;
+		}
+		return true;
+	}
+
 	return false;
 }
 
@@ -1529,30 +1561,8 @@ static struct miscdevice vga_arb_device = {
 
 static void __init vga_arb_select_default_device(void)
 {
-	struct pci_dev *pdev, *found = NULL;
 	struct vga_device *vgadev;
 
-	if (!vga_default_device()) {
-		list_for_each_entry_reverse(vgadev, &vga_list, list) {
-			struct device *dev = &vgadev->pdev->dev;
-			u16 cmd;
-
-			pdev = vgadev->pdev;
-			pci_read_config_word(pdev, PCI_COMMAND, &cmd);
-			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
-				found = pdev;
-				if (vga_arb_integrated_gpu(dev))
-					break;
-			}
-		}
-	}
-
-	if (found) {
-		vgaarb_info(&found->dev, "setting as boot device (VGA legacy resources not available)\n");
-		vga_set_default_device(found);
-		return;
-	}
-
 	if (!vga_default_device()) {
 		vgadev = list_first_entry_or_null(&vga_list,
 						  struct vga_device, list);
-- 
2.25.1

