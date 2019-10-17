Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22ABDABD7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 14:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393788AbfJQMTJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 08:19:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393739AbfJQMTJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Oct 2019 08:19:09 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E9C0757C2
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2019 12:19:08 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id o10so849299wrm.22
        for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2019 05:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ByTaLxAB+F0H69Cm8modgJ67wJ8Vn2On5FC62Q1PiM=;
        b=pwxWGnkgBEuv6r+MgADFblKUTT5LyAZbkaQgKwVjaVxVvWmIac4BCF6mgbeOtaDKnX
         XB2q6B/EuHLeAjFBcnJr2EmTCcUjkTZmE07oeXJnsVXieJyDDnPA2PXSm48qypXHpHRk
         e3kzYfDQiGYq17AEbp2euvYiiMtGxsbK0VSRYWGshIppJeXye8gZTJNTNqHRyRDRlLYB
         WzViD0hUAPDEOQJ0kzMHFVYopbbN0+E25d5g57sqUPUGI0jnfNNh5OTAdMa5buLo5u0M
         Bw6RNmkrhws86e3Z4XB6o0Iih3Gizkf86+gmnA7zeK9dBU6e2iT6rDVnZOz1MnZ0arEt
         7cRg==
X-Gm-Message-State: APjAAAVB7BZcWf6sHNDy2qc7g4g9hKwq+K786W8t+jbd7pnz5TSryK0u
        /bjTuluIGdqs0oY89poDEc9J+xOg7CmlS8tL2klQ2TvA2GQrsUPHGGjqgsl+DMlUHQ+zYL6GGBv
        kuxpkimlSLYBHK8gXnQOg
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr2820938wrw.176.1571314747147;
        Thu, 17 Oct 2019 05:19:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxb7W/PgRLjcJiTP8pYchkla4ZU2SNdmZiwnG7vymr8qEDJH1c/CguOGraOD9N0EIQdWll5yg==
X-Received: by 2002:a5d:55c2:: with SMTP id i2mr2820917wrw.176.1571314746919;
        Thu, 17 Oct 2019 05:19:06 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:74c6:f288:5e52:518b])
        by smtp.gmail.com with ESMTPSA id z9sm2163088wrv.1.2019.10.17.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 05:19:04 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v4] pci: prevent putting nvidia GPUs into lower device states on certain intel bridges
Date:   Thu, 17 Oct 2019 14:19:01 +0200
Message-Id: <20191017121901.13699-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
states.

v2: convert to pci_dev quirk
    put a proper technical explanation of the issue as a in-code comment
v3: disable it only for certain combinations of intel and nvidia hardware
v4: simplify quirk by setting flag on the GPU itself

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Mika Westerberg <mika.westerberg@intel.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
 drivers/pci/pci.c    |  7 ++++++
 drivers/pci/quirks.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 61 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b97d9e10c9cc..02e71e0bcdd7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/*
+	 * check if we have a bad combination of bridge controller and nvidia
+         * GPU, see quirk_broken_nv_runpm for more info
+	 */
+	if (state != PCI_D0 && dev->broken_nv_runpm)
+		return 0;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 
 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44c4ae1abd00..0006c9e37b6f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5268,3 +5268,56 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
+
+/*
+ * Some Intel PCIe bridges cause devices to disappear from the PCIe bus after
+ * those were put into D3cold state if they were put into a non D0 PCI PM
+ * device state before doing so.
+ *
+ * This leads to various issue different issues which all manifest differently,
+ * but have the same root cause:
+ *  - AIML code execution hits an infinite loop (as the coe waits on device
+ *    memory to change).
+ *  - kernel crashes, as all pci reads return -1, which most code isn't able
+ *    to handle well enough.
+ *  - sudden shutdowns, as the kernel identified an unrecoverable error after
+ *    userspace tries to access the GPU.
+ *
+ * In all cases dmesg will contain at least one line like this:
+ * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
+ * followed by a lot of nouveau timeouts.
+ *
+ * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of the
+ * PCIe bridge controller in order to power down the GPU.
+ * Nonetheless, there are other code paths inside the ACPI firmware which use
+ * other registers, which seem to work fine:
+ *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
+ *  - 0xb0 bit 0x10 (link disable)
+ * Changing the conditions inside the firmware by poking into the relevant
+ * addresses does resolve the issue, but it seemed to be ACPI private memory
+ * and not any device accessible memory at all, so there is no portable way of
+ * changing the conditions.
+ *
+ * The only systems where this behavior can be seen are hybrid graphics laptops
+ * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this issue
+ * only occurs in combination with listed Intel PCIe bridge controllers and
+ * the mentioned GPUs or if it's only a hw bug in the bridge controller.
+ *
+ * But because this issue was NOT seen on laptops with an Nvidia Pascal GPU
+ * and an Intel Coffee Lake SoC, there is a higher chance of there being a bug
+ * in the bridge controller rather than in the GPU.
+ *
+ * This issue was not able to be reproduced on non laptop systems.
+ */
+
+static void quirk_broken_nv_runpm(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+
+	if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
+	    bridge->device == 0x1901)
+		dev->broken_nv_runpm = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			      PCI_BASE_CLASS_DISPLAY, 16,
+			      quirk_broken_nv_runpm);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index ac8a6c4e1792..903a0b3a39ec 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -416,6 +416,7 @@ struct pci_dev {
 	unsigned int	__aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
+	unsigned int	broken_nv_runpm:1;	/* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
-- 
2.21.0

