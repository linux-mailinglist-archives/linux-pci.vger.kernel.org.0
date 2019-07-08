Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2154561A45
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2019 07:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbfGHFRx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jul 2019 01:17:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36166 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfGHFRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2019 01:17:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id k8so7627532plt.3
        for <linux-pci@vger.kernel.org>; Sun, 07 Jul 2019 22:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKGH7Fm+UtkRTmfD97dfpVU44Qifqi0eGIvlidQWlpA=;
        b=PjIyVxECy2DpiNfzVP3hPhOoGDGDU6HyuRGzJSl0c3QtRezCekJ4G7A/8/nq393Mf6
         l4H0SNF9CNLjtRdPbmzB0SOrhknHG+yQyJJYSuXsoX14OZYdctvWPuhufhD3/eNsrH5u
         WRWu9oZfV2BLHCXa0vs+HCJTxfZMxz/wNpvvclAkGBA/Skd2fkkEBui0ae4KAk4wyGYr
         1m2EisLHusHsc6yR9UN5CVUJgVJHr2tcHLvo7+CKd2vF77h84qrJI6v0GNF4HjPBa+uV
         qD1WoNkD0EqA2BkIlIS6GmAkRROxKnCyLjDMi5tWocgIVbcZmadLQ9fj8zQZ5ZirUzfa
         MJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kKGH7Fm+UtkRTmfD97dfpVU44Qifqi0eGIvlidQWlpA=;
        b=QEv6ZVDh18IFQaW7aDzomgBLoN0s8eO91tI2iMLW08aEyKLA6TXJZKxxS80e0SESv5
         SBA8ZqkyKIAvwGqdgBdYph+zanrfWIocJx8ZUel/SWASWWs8OpfXnOEXJSACOfcYWRRF
         tmYb0YbDqBl/bFT0tf+X+hiT2Ku8JproTxMFlH3avwZWJKXhyc6ndS6W2TsH2pqKLXf+
         FafhPLn2xHdP+iCci6NLGNEmmugPoNq8+WKA32qeaJOHql1sIqgdddzlmFpXpuX856si
         nIUKvlwqsgNkvQ7NFOlgAn+Pij9urB5qDKU/3RlI9jc9WVH3mQYUhZIiLtWUl96tbpP3
         LbRA==
X-Gm-Message-State: APjAAAX5g5iUL3uS1AbGr2jo/bokMQTQF88QNmhA62yXKVQeHW5O5CJ9
        51LCh12brP/a1K9bhVDSGo+RDQ==
X-Google-Smtp-Source: APXvYqwBzVoAarNEXzKqPoPbkAxtdk6tQuuubr5M3HlaUEkezuzrnQDMOGDMKPlqlGXFM9Qvg3sApQ==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr21925842plb.269.1562563071739;
        Sun, 07 Jul 2019 22:17:51 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id j16sm12954799pjz.31.2019.07.07.22.17.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 22:17:50 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux@endlessm.com,
        nouveau@lists.freedesktop.org, lukas@wunner.de,
        aplattner@nvidia.com, peter@lekensteyn.nl, imirkin@alum.mit.edu,
        kherbst@redhat.com, hhfeuer@gmx.de
Subject: [PATCH v2] PCI: Expose hidden NVIDIA HDA controllers
Date:   Mon,  8 Jul 2019 13:17:44 +0800
Message-Id: <20190708051744.24039-1-drake@endlessm.com>
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

Some platforms have ACPI DSDT code that will make the device visible if
the HDMI cable was connected at boot time, but this does not handle the
hotplug case, and this limitation has also been confirmed under Windows.

Avoid this issue by exposing the HDMI audio device on device enumeration
and resume.

The GPU and HDA controller are two functions of the same PCI device
(VGA class device on function 0 and audio device on function 1).
The multifunction flag in the GPU's Header Type register is cleared when
the HDA controller is hidden and set if it's exposed, so reread the flag
after exposing the HDA.

According to Ilia Mirkin, the HDA controller is only present on GPUs with
PCI ID values from MCP89's onwards, so do not touch config space on older
GPUs.

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
Signed-off-by: Daniel Drake <drake@endlessm.com>
---

Notes:
    v2:
     - Mention in commit message that the ACPI code that controls this bit
       is insufficient (also confirmed on Windows on the buglink)
     - Tweak commit message to clarify the MCP89 comparison, thanks to Ilia

 drivers/pci/quirks.c    | 28 ++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 29 insertions(+)

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

