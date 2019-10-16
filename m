Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF2BD942E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 16:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404672AbfJPOo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 10:44:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731768AbfJPOoz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 10:44:55 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2EA951EE6
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2019 14:44:54 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id o128so2431652wmo.1
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2019 07:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IRjHpnYNT4sbRQOMIirKpnwWpi19ynH9Iju8Io/i9X4=;
        b=lshCkmXPT6PWEj18OeV6L1bgQxrMMHCbPzPVlLDIURzmGUYlEsmC+qrLXp/6S//4J5
         vrJfFfZA8kz1miVEXGgAwzeyzVWiamEuJ7x+MQhKyPlcsCJub2mPh7KrqHFaJmbkfvqT
         Bb4pFdSGMYmR25xrDNc8uEHlGETrjRReDlwNoC6VQwLkuzc6fbz4m33NV9ViiRAT97tx
         C5cRYF6g3+P4gp4bsku0p2UnpkUsAdWq/3phxMamPTwesICWfRkjY96/Bkir+NMFuaey
         gjkY5CaqqvmB5ctzCOt7J6QXmpM2Ig7Z7bvVxMqVTCiBdbj1mYEztKMJp8bpsa/3v2R1
         m5Tg==
X-Gm-Message-State: APjAAAUDUFIv8XSUpNcjz9tGZH9YOnwbcM+ea5GiwQ9TUMhm4nx8q5Zg
        DA9hXqm93iMnHOHp75OQ3TijnanUCULln8RwAvG2wNvDYsw/f8YIdj/nLWtDMfdIU3s0UV/73je
        finKy1k1RB6R0v7xGnwT9
X-Received: by 2002:a1c:720a:: with SMTP id n10mr4061961wmc.0.1571237093735;
        Wed, 16 Oct 2019 07:44:53 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzVvbNuN5d0qg6PSKMOXh8qMP20JpD2mZs0ofIuVNkpoUlEkUmYc4sND9wo2dnmM4fjlX552A==
X-Received: by 2002:a1c:720a:: with SMTP id n10mr4061945wmc.0.1571237093477;
        Wed, 16 Oct 2019 07:44:53 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:cad:c7ca:f3fc:e27c])
        by smtp.gmail.com with ESMTPSA id 63sm37743603wri.25.2019.10.16.07.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 07:44:52 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH v3] pci: prevent putting nvidia GPUs into lower device states on certain intel bridges
Date:   Wed, 16 Oct 2019 16:44:49 +0200
Message-Id: <20191016144449.24646-1-kherbst@redhat.com>
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
 drivers/pci/pci.c    | 11 ++++++++++
 drivers/pci/quirks.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 64 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b97d9e10c9cc..8e056eb7e6ff 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -805,6 +805,13 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+static inline bool parent_broken_child_pm(struct pci_dev *dev)
+{
+	if (!dev->bus || !dev->bus->self)
+		return false;
+	return dev->bus->self->broken_nv_runpm && dev->broken_nv_runpm;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -850,6 +857,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/* check if the bus controller causes issues */
+	if (state != PCI_D0 && parent_broken_child_pm(dev))
+		return 0;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 
 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44c4ae1abd00..c2f20b745dd4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5268,3 +5268,55 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
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
+	dev->broken_nv_runpm = 1;
+}
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
+			      PCI_BASE_CLASS_DISPLAY, 16,
+			      quirk_broken_nv_runpm);
+/* kaby lake */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1901,
+			quirk_broken_nv_runpm);
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

