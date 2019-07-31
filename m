Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1457CE0D
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 22:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfGaUTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 16:19:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43212 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfGaUTg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jul 2019 16:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7EF230BC590;
        Wed, 31 Jul 2019 20:19:35 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 748DA1972D;
        Wed, 31 Jul 2019 20:19:30 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "PCI: Enable NVIDIA HDA controllers"
Date:   Wed, 31 Jul 2019 16:19:27 -0400
Message-Id: <20190731201927.22054-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 31 Jul 2019 20:19:36 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit b516ea586d717472178e6ef1c152e85608b0ce32.

While this fixes audio for a number of users, this commit has the
sideaffect of breaking the BIOS workaround that's required to make the
GPU on the nvidia P50 work, by causing the GPU's PCI device function to
stop working after it's been set to multifunction mode.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Aaron Plattner <aplattner@nvidia.com>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Maik Freudenberg <hhfeuer@gmx.de>
Cc: linux-pci@vger.kernel.org
---

I'm not really holding my breath on this patch to being accepted:
there's a good chance there's a better solution for this (and I'm going
to continue investigating for one after sending this patch), this is
more just to start a conversation on what the proper way to fix this is.

So, I'm kind of confused about why exactly this was implemented as an
early boot quirk in the first place. If we're seeing the GPU's PCI
device, we already know the GPU is there. Shouldn't we be able to check
for the existence of the HDA device once we probe the GPU in nouveau?
This would make a lot more sense and be a lot less troublesome. I can
see that in the discussion on

https://bugs.freedesktop.org/show_bug.cgi?id=75985

That people mentioned that unloading nouveau then trying to reprobe for
the audio device didn't work, but that still doesn't explain why this
was implemented as an early quirk and not as something we just do before
nouveau is setup. Can we maybe move this somewhere a little more
sensible?

 drivers/pci/quirks.c    | 30 ------------------------------
 include/linux/pci_ids.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 208aacf39329..c66c0ca446c4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5011,36 +5011,6 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_SERIAL_UNKNOWN, 8,
 			      quirk_gpu_usb_typec_ucsi);
 
-/*
- * Enable the NVIDIA GPU integrated HDA controller if the BIOS left it
- * disabled.  https://devtalk.nvidia.com/default/topic/1024022
- */
-static void quirk_nvidia_hda(struct pci_dev *gpu)
-{
-	u8 hdr_type;
-	u32 val;
-
-	/* There was no integrated HDA controller before MCP89 */
-	if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
-		return;
-
-	/* Bit 25 at offset 0x488 enables the HDA controller */
-	pci_read_config_dword(gpu, 0x488, &val);
-	if (val & BIT(25))
-		return;
-
-	pci_info(gpu, "Enabling HDA controller\n");
-	pci_write_config_dword(gpu, 0x488, val | BIT(25));
-
-	/* The GPU becomes a multi-function device when the HDA is enabled */
-	pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
-	gpu->multifunction = !!(hdr_type & 0x80);
-}
-DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
-DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-			       PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
-
 /*
  * Some IDT switches incorrectly flag an ACS Source Validation error on
  * completions for config read requests even though PCIe r4.0, sec
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c842735a4f45..f496fb619287 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1336,7 +1336,6 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS    0x0752
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE       0x0759
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS     0x07D8
-#define PCI_DEVICE_ID_NVIDIA_GEFORCE_320M           0x08A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85
 
-- 
2.21.0

