Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D6444557
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392287AbfFMQnf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 12:43:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43452 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfFMGfW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 02:35:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so7657462plb.10
        for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2019 23:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuVptW7+/rVg73C/cVY3PxglIIDzq6v+boQkzm8gPXw=;
        b=tTHreuwa5Gl5hG5mRCZOIcgm7Y1KWgOatyEfgy9w+38FSpObzYleao4+JvnyAtaIBY
         bLh2nFGX9+4yMaAQCtcJyMDx81aIM3RYsVy3tpzVM+XsBR2QhLg/vyx5dG4jVXGzRRxH
         rbUP6x2tt2R1xK9c8VLhnM5zafCjzUR07wkrOGufszuEjj7yOaoPD9w6n/dQcBHbjNEf
         F1pxUpHJidOHHSozB4H+koWiST+5CK3rIBZ5VaEAppyxnxy3ybTuNU2Sry/66KaqRv0v
         t56cuiMvyHnuoBARNwa4+AGc4CCbm7mNdWkbJuvKcHJ+BOhlq+dO0xIHY1546QXz7LpG
         ytWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UuVptW7+/rVg73C/cVY3PxglIIDzq6v+boQkzm8gPXw=;
        b=V0yqlSQE4E9ZxyU/umlv6zu/qBEVkl5Azdh1avK9PVM0PcE/hclJOhYtlrmdGgi724
         XJyqB27z4RxNd+h6XGOKszV/yWY2+oO9y4YVk8nrWn8cA89ojxt/tnWXq2tzKBVij/xd
         FmZbnCVC3i0COBx5YM9gmOiex9sfD4amoX9/NmK/h061cnCaJdN++X1IlgC1WvYC2oYr
         0s+WRLn14odY8AqoNwtOo1u00txIjjoNg9v7BY0QfgLcXvm57A952HxNv7lfCIyMy5Gi
         NwAL0xwXwH4uyTpL+rfVvy35pjnHsijsaZODmjoSxY/1tBBWksKsC/nAZi8MYAaaMmy5
         cZUw==
X-Gm-Message-State: APjAAAUPFHRE43Qje1TuFXmqZOQP4Dwzfb95sP/cZYGv9vqhIAKfhVzc
        UIo1Dnm9KWFpo8U0gUr+0t5+QA==
X-Google-Smtp-Source: APXvYqw3P9R2gnma8ARJTrahC35D2wK2AOLaXvKGn8r1LxYilVT6GoGf82uSiUuE7+6vRVAn2ZRYtw==
X-Received: by 2002:a17:902:6947:: with SMTP id k7mr14461279plt.253.1560407720918;
        Wed, 12 Jun 2019 23:35:20 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id c130sm1516706pfc.105.2019.06.12.23.35.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 23:35:19 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>
Subject: [PATCH] PCI: Expose hidden NVIDIA HDA controllers
Date:   Thu, 13 Jun 2019 14:35:14 +0800
Message-Id: <20190613063514.15317-1-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

The integrated HDA controller on Nvidia GPUs can be hidden with a bit in
the GPU's config space. Information about this scheme was provided by
NVIDIA on their forums.

Many laptops now ship with this device hidden, meaning that Linux users
of affected platforms (where the HDMI connector comes off the NVIDIA GPU)
cannot use HDMI audio functionality.

Avoid this issue by exposing the HDMI audio device on device enumeration
and resume.

The GPU and HDA controller are two functions of the same PCI device
(VGA class device on function 0 and audio device on function 1).
The multifunction flag in the GPU's Header Type register is cleared when
the HDA controller is hidden and set if it's exposed, so reread the flag
after exposing the HDA.

According to Ilia Mirkin, the HDA controller is only present from MCP89
onward, so do not touch config space on older GPUs.

This quirk is limited to NVIDIA PCI devices with the VGA Controller
device class. This is expected to correspond to product configurations
where the NVIDIA GPU has connectors attached. Other products where the
device class is 3D Controller are expected to correspond to configurations
where the NVIDIA GPU is dedicated (dGPU) and has no connectors.

It's sensible to avoid exposing the HDA controller on dGPU setups,
especially because we've seen cases where the PCI BARs are not set
up correctly by the platform in this case, causing Linux to log
errors if the device is visible. This assumption of device class
accurately corresponding to product configuration is true for 6 of 6
laptops recently checked at the Endless lab, and there are also signs of
agreement checking the data from 74 previously tested products, however
Ilia Mirkin comments that he's seen cases where it is not true. Anyway, it
looks like this quirk should fix audio support for the majority of
affected users.

This commit takes inspiration from an earlier patch by Daniel Drake.

Link: https://devtalk.nvidia.com/default/topic/1024022
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=75985
Cc: Aaron Plattner <aplattner@nvidia.com>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Maik Freudenberg <hhfeuer@gmx.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Tested-by: Daniel Drake <drake@endlessm.com>
---
 drivers/pci/quirks.c    | 28 ++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 29 insertions(+)

Submitting Lukas's patch from over a year ago.

It got held up before on patch dependencies (which are now all merged)
and also the concern around the device class assumption not being true
in all cases. However, there hasn't been any progress towards finding a
better approach, and we don't have any logs to hand from the cases where
this isn't true, so I think we should go with this approach which will
work in the (vast?) majority of cases.

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f16acc323c6..52046b517e2e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4971,6 +4971,34 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
 
+/*
+ * Many laptop BIOSes hide the integrated HDA controller on NVIDIA GPUs
+ * via a special bit. This prevents Linux from seeing and using it.
+ * Unhide it here.
+ * https://devtalk.nvidia.com/default/topic/1024022
+ */
+static void quirk_nvidia_hda(struct pci_dev *gpu)
+{
+	u8 hdr_type;
+	u32 val;
+
+	/* there was no integrated HDA controller before MCP89 */
+	if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
+		return;
+
+	/* bit 25 at offset 0x488 hides or exposes the HDA controller */
+	pci_read_config_dword(gpu, 0x488, &val);
+	pci_write_config_dword(gpu, 0x488, val | BIT(25));
+
+	/* the GPU becomes a multifunction device when the HDA is exposed */
+	pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
+	gpu->multifunction = !!(hdr_type & BIT(7));
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
 
-- 
2.20.1

