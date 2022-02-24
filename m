Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF544C390E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Feb 2022 23:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiBXWs4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 17:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbiBXWsz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 17:48:55 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4198A122210;
        Thu, 24 Feb 2022 14:48:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 534B1CE1E7C;
        Thu, 24 Feb 2022 22:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B053C340F2;
        Thu, 24 Feb 2022 22:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645742892;
        bh=XYpwsHgyyItYISu4q7GCS4JsRJ+aB3M/Y8SVWHvmy1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5yG4LdctzoCawmBWMCnkwhC2wAjKXXwHeHiC4ymkYZfT01nFp3MvebAyXzWCcWCF
         FYf9qHMtbgeoh2kuYC3xuDMrPDZ+o7wAEOFRoWeGOTzELzRoGyTDp/peOiw6VvmQ42
         YTMQoDwIKOi8cnddmRkNvg6iImze6bXeLWRbSZ3x5YDzTr9PctEC6CPXbrdV4yUFmr
         jrf3qwD0dvDG+UFIWTfvH0o+xXD+1H9mSlo+DAvk1np7HfKcgNoWwGKGPgxfgtgnD3
         SdprcfpfIRjE4tpbL2DH4MztXY8m/pPntkRjpx/f94DzrvaGLs50VLsV46PPane0sD
         R92XIa5T0HtqQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v9 04/11] PCI/VGA: Factor out default VGA device selection
Date:   Thu, 24 Feb 2022 16:47:46 -0600
Message-Id: <20220224224753.297579-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224224753.297579-1-helgaas@kernel.org>
References: <20220224224753.297579-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Huacai Chen <chenhuacai@loongson.cn>

Default VGA device selection fails when PCI devices are enumerated after
the vga_arb_device_init() subsys_initcall.

vga_arbiter_add_pci_device() selects the first fully enabled device to
which legacy VGA resources are routed as the default VGA device.  This is
an ADD_DEVICE notifier, so it runs after every PCI device is enumerated.

vga_arb_select_default_device() may select framebuffer devices, partially
enabled GPUs, or non-legacy devices that don't have legacy VGA resources
routed to them as the default VGA device.  But this only happens once, from
the vga_arb_device_init() subsys_initcall, so it doesn't consider devices
enumerated after that:

  acpi_init
    acpi_scan_init
      acpi_pci_root_init         # PCI device enumeration (ACPI systems)

  vga_arb_device_init
    for_each_pci_device
      vga_arbiter_add_pci_device      # ADD_DEVICE notifier
        if (VGA-owner)
          vga_set_default_device      <-- set default VGA
    vga_arb_select_default_device     # only called ONCE
      for_each_vga_device
        if (framebuffer)
          vga_set_default_device      <-- set default VGA to framebuffer
      if (!vga_default_device())
        if (non-legacy, integrated GPU, etc)
          vga_set_default_device      <-- set default VGA
      if (!vga_default_device())
        vga_set_default_device        <-- set default VGA

  pcibios_init
    pcibios_scanbus              # PCI device enumeration (non-ACPI systems)
      ...
        vga_arbiter_add_pci_device    # ADD_DEVICE notification
          if (VGA-owner)
            vga_set_default_device    <-- set default VGA

Note that on non-ACPI systems, vga_arb_select_default_device() runs before
pcibios_init(), so it sees no VGA devices and can never set a framebuffer
device, a non-legacy integrated GPU, etc., as the default device.

Factor out the default VGA device selection to vga_is_boot_device(), called
from vga_arbiter_add_pci_device().

Then we can migrate the default device selection from
vga_arb_select_default_device() to the vga_arbiter_add_pci_device() path.

[bhelgaas: commit log, split to separate patch]
Link: https://lore.kernel.org/r/20211015061512.2941859-4-chenhuacai@loongson.cn
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/pci/vgaarb.c | 45 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3f8fead49197..58e0a12e623b 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -628,6 +628,41 @@ static bool vga_arb_integrated_gpu(struct device *dev)
 #endif
 }
 
+/*
+ * Return true if vgadev is a better default VGA device than the best one
+ * we've seen so far.
+ */
+static bool vga_is_boot_device(struct vga_device *vgadev)
+{
+	struct vga_device *boot_vga = vgadev_find(vga_default_device());
+
+	/*
+	 * We select the default VGA device in this order:
+	 *   Firmware framebuffer (see vga_arb_select_default_device())
+	 *   Legacy VGA device (owns VGA_RSRC_LEGACY_MASK)
+	 *   Non-legacy integrated device (see vga_arb_select_default_device())
+	 *   Non-legacy discrete device (see vga_arb_select_default_device())
+	 *   Other device (see vga_arb_select_default_device())
+	 */
+
+	/*
+	 * A legacy VGA device has MEM and IO enabled and any bridges
+	 * leading to it have PCI_BRIDGE_CTL_VGA enabled so the legacy
+	 * resources ([mem 0xa0000-0xbffff], [io 0x3b0-0x3bb], etc) are
+	 * routed to it.
+	 *
+	 * We use the first one we find, so if we've already found one,
+	 * vgadev is no better.
+	 */
+	if (boot_vga)
+		return false;
+
+	if ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)
+		return true;
+
+	return false;
+}
+
 /*
  * Rules for using a bridge to control a VGA descendant decoding: if a bridge
  * has only one VGA descendant then it can be used to control the VGA routing
@@ -755,12 +790,10 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 		bus = bus->parent;
 	}
 
-	/* Deal with VGA default device. Use first enabled one
-	 * by default if arch doesn't have it's own hook
-	 */
-	if (vga_default == NULL &&
-	    ((vgadev->owns & VGA_RSRC_LEGACY_MASK) == VGA_RSRC_LEGACY_MASK)) {
-		vgaarb_info(&pdev->dev, "setting as boot VGA device\n");
+	if (vga_is_boot_device(vgadev)) {
+		vgaarb_info(&pdev->dev, "setting as boot VGA device%s\n",
+			    vga_default_device() ?
+			    " (overriding previous)" : "");
 		vga_set_default_device(pdev);
 	}
 
-- 
2.25.1

