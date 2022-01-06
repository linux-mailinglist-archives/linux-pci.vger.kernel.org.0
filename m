Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35BE485CE1
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 01:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbiAFAHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 19:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343507AbiAFAHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jan 2022 19:07:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308ABC061201;
        Wed,  5 Jan 2022 16:07:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED14AB81D63;
        Thu,  6 Jan 2022 00:07:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A712C36AEB;
        Thu,  6 Jan 2022 00:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427637;
        bh=aAX5O9erMFRMC7V8Z9IDXdvpUyWpIonKB/j9UgUHLrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTCyLrbP20GIQ9387MqiZJ/V8QM+SM2acNJj21BDtDdgyqe40HO16u3x5zvqzDGHO
         WTqK3Fid28PhjDtSYT7FM5KmhWNQ0ugi0UkU2gCJbZZ661wjPQGn5SrvMjJF1Xm1DA
         GZ6f2H+pqdqD3Q0Hbj0XMZ1ak7z7UrjVBBYlZGOLHLC2TO7Keju01mZ6QfpWZkYB1S
         geylwFYcX6s6U/A1nU51NWsCLuHe5f+CQr+wd0oqjFyqaizRJGlb0t3mqSxuf+yYJ8
         FIrKfJx6TPoJwwXcObJKDv4tI6OMUJihAtbEtUShCOHS65A1j3gqsdT0DDuEzDNIjp
         BRYaPZixMkIYg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v8 03/10] vgaarb: Factor out default VGA device selection
Date:   Wed,  5 Jan 2022 18:06:51 -0600
Message-Id: <20220106000658.243509-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106000658.243509-1-helgaas@kernel.org>
References: <20220106000658.243509-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

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

Link: https://lore.kernel.org/r/20211015061512.2941859-4-chenhuacai@loongson.cn
Based-on-patch-by: Huacai Chen <chenhuacai@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/vga/vgaarb.c | 45 ++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/vga/vgaarb.c b/drivers/gpu/vga/vgaarb.c
index 36d9140c64f6..b0ae0f177c6f 100644
--- a/drivers/gpu/vga/vgaarb.c
+++ b/drivers/gpu/vga/vgaarb.c
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

