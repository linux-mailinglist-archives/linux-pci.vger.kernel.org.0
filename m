Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE719C25AC
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 19:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfI3RHo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 13:07:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfI3RHo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 13:07:44 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5BF1F859FF
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 17:07:43 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q9so95142wmj.9
        for <linux-pci@vger.kernel.org>; Mon, 30 Sep 2019 10:07:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=cs776fH4erFtXUSzzVn3rAy9fW72VGqJRx6dq549BTs=;
        b=exjrlw7W3ZP6wVkBSg+AgHROtBF+Vtvmfi6EWR58iBDDPJYYyihYzskQ6EU6nw5A1z
         c6LjrOeqyErfcWcmqujHgV52UJh9cn0uVQXzeKtKc+Sr1FUzqa7pJDiHH/Gh6Jke6OvM
         i1aQjdxXM+GssDWQsdTXRbb1GTHnZLTiTVoqvKCN3gr+VoMFo9Or0/PcB7BdZBkgDb6E
         vDwD1nQuaOcR8uV7GRx+Qhk/3xCOQO2u3VgMBMccXkhTVAdR2sXXE7Q8lPr6MIBquC+J
         W7rkXz01Rh8XGLMamHq4S1ykzkjCGndeEyMVWf1EigxPr42PkKnwqPJjx4m/HgXDZy+/
         xfQA==
X-Gm-Message-State: APjAAAVAsUeFvlUosvZ9zKSejbHc2I3bqKLgF3m7bljLrySD1VsZki4V
        YPYhwnRjmo3sA9WiKsBbMtoyqssA4cZjMxfR/ZumeTcKOxuULPP8EyVRVoIhfOihrK3/lbm6GOx
        /E/7tjngfqMzBpR9BQGBL
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr199039wmk.150.1569863262034;
        Mon, 30 Sep 2019 10:07:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzb0zH1A2+zMb9dORMy0r94rwSyu0arMgvSfgbq6H2j091sJVKqDUCQszgUPNoaGIR1IOjP4g==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr199015wmk.150.1569863261784;
        Mon, 30 Sep 2019 10:07:41 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:7db2:cb58:5fb:97a5])
        by smtp.gmail.com with ESMTPSA id r12sm12077573wrq.88.2019.09.30.10.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 10:07:40 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [RFC PATCH] pci: prevent putting pcie devices into lower device states on certain intel bridges
Date:   Mon, 30 Sep 2019 19:07:38 +0200
Message-Id: <20190930170738.20162-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
Reply-To: CACO55tuk4SA6-xUtJ-oRePy8MPXYAp2cfmSPxwW3J5nQuX3y2g@mail.gmail.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
states.

v2: convert to pci_dev quirk
    put a proper technical explenation of the issue as a in-code comment

RFC comment (copied from last sent):
We are quite sure that there is a higher amount of bridges affected by this,
but I was only testing it on my own machine for now.

I've stresstested runpm by doing 5000 runpm cycles with that patch applied
and never saw it fail.

I mainly wanted to get a discussion going on if that's a feasable workaround
indeed or if we need something better.

I am also sure, that the nouveau driver itself isn't at fault as I am able
to reproduce the same issue by poking into some PCI registers on the PCIe
bridge to put the GPU into D3cold as it's done in ACPI code.

I've written a little python script to reproduce this issue without the need
of loading nouveau:
https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runpm_bug_test.py

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
 drivers/pci/quirks.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 088fcdc8d2b4..65516b024ee5 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -799,6 +799,13 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+static inline bool parent_broken_child_pm(struct pci_dev *dev)
+{
+	if (!dev->bus || !dev->bus->self)
+		return false;
+	return dev->bus->self->broken_child_pm;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -844,6 +851,10 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	   || (state == PCI_D2 && !dev->d2_support))
 		return -EIO;
 
+	/* check if the bus controller causes issues */
+	if (state != PCI_D0 && parent_broken_child_pm(dev))
+		return 0;
+
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
 
 	/*
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0f16acc323c6..2be0deec2c3d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5198,3 +5198,53 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
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
+static void quirk_broken_child_pm(struct pci_dev *dev)
+{
+	dev->broken_child_pm = 1;
+	printk("applied broken child pm quirk!\n");
+}
+/* kaby lake */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1901,
+			quirk_broken_child_pm);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index dd436da7eccc..01eb0a9e6c13 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -413,6 +413,7 @@ struct pci_dev {
 	unsigned int	__aer_firmware_first_valid:1;
 	unsigned int	__aer_firmware_first:1;
 	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
+	unsigned int	broken_child_pm:1;	/* children put into lower PCI PM states won't recover after D3cold transition */
 	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
 	unsigned int	irq_managed:1;
 	unsigned int	has_secondary_link:1;
-- 
2.21.0

