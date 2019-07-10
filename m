Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92664EC5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 00:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfGJWrU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jul 2019 18:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbfGJWrU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Jul 2019 18:47:20 -0400
Received: from localhost (98.sub-174-234-128.myvzw.com [174.234.128.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94FAF20665;
        Wed, 10 Jul 2019 22:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562798839;
        bh=/i3JxqJDDtwq8v2QHqOwjTHnPWZUNPKzkFPSlQoJ2VI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MudOyC79oCFsyRrwzgUoVz4WElVZmZSZJ/nRJGSzUPOd+3hNvuizbpPZ+Zq/ip9/h
         1J3O7EGzSwuIUmSFqbByGSrMlwHJgtDiux3P/1xjOfoQD80g4mKpt8mt8vOqxDLW7z
         BDR6p8685TUdrTDx6lKQBlFAluFPbFv+eTjh5pEc=
Date:   Wed, 10 Jul 2019 17:47:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Drake <drake@endlessm.com>
Cc:     linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, lukas@wunner.de,
        aplattner@nvidia.com, peter@lekensteyn.nl, imirkin@alum.mit.edu,
        kherbst@redhat.com, hhfeuer@gmx.de
Subject: Re: [PATCH v2] PCI: Expose hidden NVIDIA HDA controllers
Message-ID: <20190710224716.GD35486@google.com>
References: <20190708051744.24039-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708051744.24039-1-drake@endlessm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 08, 2019 at 01:17:44PM +0800, Daniel Drake wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> The integrated HDA controller on Nvidia GPUs can be hidden with a bit in
> the GPU's config space. Information about this scheme was provided by
> NVIDIA on their forums.
> 
> Many laptops now ship with this device hidden, meaning that Linux users
> of affected platforms (where the HDMI connector comes off the NVIDIA GPU)
> cannot use HDMI audio functionality.
> 
> Some platforms have ACPI DSDT code that will make the device visible if
> the HDMI cable was connected at boot time, but this does not handle the
> hotplug case, and this limitation has also been confirmed under Windows.
> 
> Avoid this issue by exposing the HDMI audio device on device enumeration
> and resume.
> 
> The GPU and HDA controller are two functions of the same PCI device
> (VGA class device on function 0 and audio device on function 1).
> The multifunction flag in the GPU's Header Type register is cleared when
> the HDA controller is hidden and set if it's exposed, so reread the flag
> after exposing the HDA.
> 
> According to Ilia Mirkin, the HDA controller is only present on GPUs with
> PCI ID values from MCP89's onwards, so do not touch config space on older
> GPUs.
> 
> This quirk is limited to NVIDIA PCI devices with the VGA Controller
> device class. This is expected to correspond to product configurations
> where the NVIDIA GPU has connectors attached. Other products where the
> device class is 3D Controller are expected to correspond to configurations
> where the NVIDIA GPU is dedicated (dGPU) and has no connectors.
> 
> It's sensible to avoid exposing the HDA controller on dGPU setups,
> especially because we've seen cases where the PCI BARs are not set
> up correctly by the platform in this case, causing Linux to log
> errors if the device is visible. This assumption of device class
> accurately corresponding to product configuration is true for 6 of 6
> laptops recently checked at the Endless lab, and there are also signs of
> agreement checking the data from 74 previously tested products, however
> Ilia Mirkin comments that he's seen cases where it is not true. Anyway, it
> looks like this quirk should fix audio support for the majority of
> affected users.
> 
> This commit takes inspiration from an earlier patch by Daniel Drake.
> 
> Link: https://devtalk.nvidia.com/default/topic/1024022
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=75985
> Cc: Aaron Plattner <aplattner@nvidia.com>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Maik Freudenberg <hhfeuer@gmx.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Daniel Drake <drake@endlessm.com>

I applied this (slightly revised as below) to pci/misc and I think we
can still squeeze it in for v5.3.

My revisions:

  - Don't write the enable bit if it's already set.

  - Log a note when enabling the HDA.  I don't like writing
    undocumented config bits in *every* current and future NVIDIA GPU,
    so the note is just a hint that we're doing something slightly
    risky.

  - Use "hdr_type & 0x80" to match the other places we set
    pdev->multifunction.

  - Remove the commit log parts that don't seem relevant for future
    maintenance and add the URL to the original posting.

Let me know if I broke anything.

commit b678f90a1a6f
Author: Lukas Wunner <lukas@wunner.de>
Date:   Mon Jul 8 13:17:44 2019 +0800

    PCI: Enable NVIDIA HDA controllers
    
    Many NVIDIA GPUs can be configured as either a single-function video device
    or a multi-function device with video at function 0 and an HDA audio
    controller at function 1.  The HDA controller can be enabled or disabled by
    a bit in the function 0 config space.
    
    Some BIOSes leave the HDA disabled, which means the HDMI connector from the
    NVIDIA GPU may not work.  Sometimes the BIOS enables the HDA if an HDMI
    cable is connected at boot time, but that doesn't handle hotplug cases.
    
    Enable the HDA controller on device enumeration and resume and re-read the
    header type, which tells us whether the GPU is a multi-function device.
    
    This quirk is limited to NVIDIA PCI devices with the VGA Controller device
    class.  This is expected to correspond to product configurations where the
    NVIDIA GPU has connectors attached.  Other products where the device class
    is 3D Controller are expected to correspond to configurations where the
    NVIDIA GPU is dedicated (dGPU) and has no connectors.  See original post
    (URL below) for more details.
    
    This commit takes inspiration from an earlier patch by Daniel Drake.
    
    Link: https://lore.kernel.org/r/20190708051744.24039-1-drake@endlessm.com
    Link: https://devtalk.nvidia.com/default/topic/1024022
    Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=75985
    Signed-off-by: Lukas Wunner <lukas@wunner.de>
    Signed-off-by: Daniel Drake <drake@endlessm.com>
    [bhelgaas: commit log, log message, return early if already enabled]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: Aaron Plattner <aplattner@nvidia.com>
    Cc: Peter Wu <peter@lekensteyn.nl>
    Cc: Ilia Mirkin <imirkin@alum.mit.edu>
    Cc: Karol Herbst <kherbst@redhat.com>
    Cc: Maik Freudenberg <hhfeuer@gmx.de>

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index c66c0ca446c4..208aacf39329 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5011,6 +5011,36 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_SERIAL_UNKNOWN, 8,
 			      quirk_gpu_usb_typec_ucsi);
 
+/*
+ * Enable the NVIDIA GPU integrated HDA controller if the BIOS left it
+ * disabled.  https://devtalk.nvidia.com/default/topic/1024022
+ */
+static void quirk_nvidia_hda(struct pci_dev *gpu)
+{
+	u8 hdr_type;
+	u32 val;
+
+	/* There was no integrated HDA controller before MCP89 */
+	if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
+		return;
+
+	/* Bit 25 at offset 0x488 enables the HDA controller */
+	pci_read_config_dword(gpu, 0x488, &val);
+	if (val & BIT(25))
+		return;
+
+	pci_info(gpu, "Enabling HDA controller\n");
+	pci_write_config_dword(gpu, 0x488, val | BIT(25));
+
+	/* The GPU becomes a multi-function device when the HDA is enabled */
+	pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
+	gpu->multifunction = !!(hdr_type & 0x80);
+}
+DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
+DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
+
 /*
  * Some IDT switches incorrectly flag an ACS Source Validation error on
  * completions for config read requests even though PCIe r4.0, sec
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..66898463b81f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1336,6 +1336,7 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS    0x0752
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE       0x0759
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS     0x07D8
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE_320M           0x08A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85
 
