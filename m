Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787E346C888
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 01:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbhLHANX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 19:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242706AbhLHANX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 19:13:23 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6BC061748
        for <linux-pci@vger.kernel.org>; Tue,  7 Dec 2021 16:09:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id a4-20020a170902ecc400b00142562309c7so145210plh.6
        for <linux-pci@vger.kernel.org>; Tue, 07 Dec 2021 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ZhZqkrbXveIv+sF93ngTV4dolBugW8SLj/WlAruMndc=;
        b=haiug30QueIEeXZKZerIrWwOlLcx0NPxj7oel7q56Ms8ORjWmUu9ma6nCYk3HGP9se
         5VNC3XnJZl7K49uY1Oc/xFgfRvzp/jxuYce7gFsXHMmSr8jE9xESun8kOV8FRbBjgj2B
         CnBFDKO/kc43Pq+s0ijBeQqN2Pf3x9nFfhhP3hwQ2YErRpR9U75gJbtXLJwxEdbEiqg0
         LrnWnwjRbB1facyrnQ4D9WykXTyN62sBIrm7fdpQm+15MRK5O7Blfev6HsOIf2x0WyjN
         jIwId55vj6zmWbfLat3BDge1gULMlu9HH5531oFsrZ7ebSDUM0nDiAKFwPT5qVTwG+YK
         9aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ZhZqkrbXveIv+sF93ngTV4dolBugW8SLj/WlAruMndc=;
        b=eM7P3XlE0odb9q7qmiMYCcdf2V3Ue0fbLm2zRX/DU63JhXv9/ZWChweNwPDS7F5ysJ
         g62Wntrz+MY3e/WiEfQQJlKxlAkNXxs/uXMCTiVQjgBM6s1riAF48RNysiP5o1UBrEWQ
         gOAGArRl2OWF7yV4Tt9ie0FKxpvJztv6XsYFBkbWiZxm9vt5TE+vSg42UobYTdHATdBu
         YQ+Rv0tIi1IjofZILx9yfb7rv7DGBnJLInLddUv3dHKt1+jf81t3kZfaYYnN9NlCG/XW
         DX5vh0l9F7zO+7sLoKyozZrsFoMlxWrQbxaa78Awx2oibAaP/1k9HRjy0lEOTUSjLiO9
         GcAQ==
X-Gm-Message-State: AOAM530GalIwvzYd33FeXMH0g6KYTGW3z9Azxk9uh3cuFv74c8QDfRdg
        /Dk+/CG/DjnoRMIiVZZrTRV2rJPTt68C
X-Google-Smtp-Source: ABdhPJxhbqVDGRB2UnUeMhC2ilGnjp0KZLlmkebCf87L92SjvQNJGuprErGx53WG4SkzAMyY9RC6303YyY7X
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:acaf:41ab:cb2e:2a2])
 (user=rajatja job=sendgmr) by 2002:a17:903:186:b0:141:eda2:d5fa with SMTP id
 z6-20020a170903018600b00141eda2d5famr54935956plg.63.1638922192032; Tue, 07
 Dec 2021 16:09:52 -0800 (PST)
Date:   Tue,  7 Dec 2021 16:09:48 -0800
Message-Id: <20211208000948.487820-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH] pci/quirks: Add quirk for Bayhub O2 SD controller
From:   Rajat Jain <rajatja@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        jsbarnes@google.com, gwendal@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This particular SD controller from O2 / Bayhub only allows dword
accesses to its LTR max latency registers:
https://github.com/rajatxjain/public_shared/blob/main/OZ711LV2_appnote.pdf

Thus add a quirk that saves and restores these registers
manually using dword acesses:
LTR Max Snoop Latency Register
LTR Max No-Snoop Latency Register

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/mmc/host/sdhci-pci.h |  1 -
 drivers/pci/quirks.c         | 39 ++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h      |  1 +
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 5e3193278ff9..d47cc0ba7ca4 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -10,7 +10,6 @@
 #define PCI_DEVICE_ID_O2_SDS1		0x8421
 #define PCI_DEVICE_ID_O2_FUJIN2		0x8520
 #define PCI_DEVICE_ID_O2_SEABIRD0	0x8620
-#define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
 
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
 #define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..b7bd19802744 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5857,3 +5857,42 @@ static void nvidia_ion_ahci_fixup(struct pci_dev *pdev)
 	pdev->dev_flags |= PCI_DEV_FLAGS_HAS_MSI_MASKING;
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_NVIDIA, 0x0ab8, nvidia_ion_ahci_fixup);
+
+/*
+ * Bayhub OZ711LV2 SD controller has an errata that only allows DWORD accesses
+ * to the LTR max latency registers. Thus need to save and restore these
+ * registers manually.
+ */
+static void o2_seabird1_save_ltr(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *reg32;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (save_state) {
+		reg32 = &save_state->cap.data[0];
+		/* Preserve PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
+		pci_read_config_dword(dev, 0x234, reg32);
+	} else {
+		pci_err(dev, "quirk can't save LTR snoop latency\n");
+	}
+}
+
+static void o2_seabird1_restore_ltr(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *reg32;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_LTR);
+	if (save_state) {
+		reg32 = &save_state->cap.data[0];
+		/* Restore PCI_LTR_MAX_SNOOP_LAT & PCI_LTR_MAX_NOSNOOP_LAT */
+		pci_write_config_dword(dev, 0x234, *reg32);
+	} else {
+		pci_err(dev, "quirk can't restore LTR snoop latency\n");
+	}
+}
+DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
+			       o2_seabird1_save_ltr);
+DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_O2, PCI_DEVICE_ID_O2_SEABIRD1,
+			       o2_seabird1_restore_ltr);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..6ed16aa38196 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1717,6 +1717,7 @@
 #define PCI_DEVICE_ID_O2_8221		0x8221
 #define PCI_DEVICE_ID_O2_8320		0x8320
 #define PCI_DEVICE_ID_O2_8321		0x8321
+#define PCI_DEVICE_ID_O2_SEABIRD1	0x8621
 
 #define PCI_VENDOR_ID_3DFX		0x121a
 #define PCI_DEVICE_ID_3DFX_VOODOO	0x0001
-- 
2.34.1.400.ga245620fadb-goog

