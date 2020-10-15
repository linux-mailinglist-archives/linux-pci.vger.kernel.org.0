Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B268E28EE24
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 10:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbgJOIDf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 04:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbgJOIDe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 04:03:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FFC061755
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2020 01:03:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a1so1508517pjd.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2020 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ui17qZcRFEKOHdzyaMHq3tlMs4QKWABTwWk8AGdHnU=;
        b=K0ePxdUjdp+YL36a2L2lkbGHIw6LkPxVf+1hbzVnyozpFZpEEikUHpTEWJH8/fK5dj
         pFgAIFtwZLpf41NomE9eVcvrdC2Wk1HY2TH6aRww2M8U/Kh8hXZUeXoibfSy3WFSLoFV
         3hrmTz/LL62XX2NqhQv/iDwpbGHk0dBacD8CQsAqAcjmIa3G55y1pAGV3uUXgh9VmGwO
         P9LmykxncQxSARn0yoLPr5QOczat4LwoqHfx2rpDMQdi4EHUKj6jWeCU+mdjK2Cu2jMq
         p48FkqE8xwo2lIpyoJFPNNM9J9eSCaiVZ5NRly6ii03lnX6srIV6YiffoPc99u5s7/CY
         ANGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5Ui17qZcRFEKOHdzyaMHq3tlMs4QKWABTwWk8AGdHnU=;
        b=jAXjtzpYH4ZS/7AWLbzb3f8BijscDwjUZJWimSFoV2hqvZH/3RO8h9B1CTX0ubrYAc
         CFD7VcG7DhXi976+9NrIRzEtv8fFxkgga6vtXJpZtA1eBIvBjA68Dha3iewLSv+lfipe
         +Oshfbf5aucEaVczowhi5Q5IzTVTq7JOKwnQbcnDbnCkf/JuUKe5WFpZiW0hHfcII9bX
         eTcemuLCq8bRB/4HIQn53AEo5vhkQiSnVmdXvhr/YZAnRQX+/1fc4Su7aeu0O3QRjFD8
         LDhrFhc6XAgD4uocJGiL5x3IWfPkeIokM7xyrMs9/CE5GQFjYH/30tx3zyzLqvWcLk0p
         qH9g==
X-Gm-Message-State: AOAM530cXRuRBHjWU4GI+wfTP3onreBVOHPDfARQqJohjEVq36aoRkew
        hJtnqbG7HNXRNPk0O0yWsJ4=
X-Google-Smtp-Source: ABdhPJxJS4AQyZVXsVIOPr9+RbwzKKjQ6r3wxrLIIR/4H8WtXWfSLRVBf/a//cvmQJLvuWRUua5WAg==
X-Received: by 2002:a17:902:aa0c:b029:d3:8087:c88d with SMTP id be12-20020a170902aa0cb02900d38087c88dmr2781737plb.41.1602749014127;
        Thu, 15 Oct 2020 01:03:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4056:216:fcbe:f65a:1cbd:1b41:bc23])
        by smtp.googlemail.com with ESMTPSA id fy24sm2283415pjb.35.2020.10.15.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 01:03:33 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v6] PCI/ASPM: Add support for LTR _DSM
Date:   Thu, 15 Oct 2020 13:33:11 +0530
Message-Id: <20201015080311.7811-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Latency Tolerance Reporting (LTR) is required for the ASPM L1.2 PM
substate.  Devices with Upstream Ports (Endpoints and Switches) may support
the optional LTR Capability.  When LTR is enabled, devices transmit LTR
messages containing Snoop and No-Snoop Latencies upstream.  The L1.2
substate may be entered if the most recent LTR values are greater than or
equal to the LTR_L1.2_THRESHOLD from the L1 PM Substates Control 1
register.

Add a new function pci_ltr_init() which will be called from
pci_configure_ltr() to initialize every PCIe device's LTR values.
Add code in probe.c to evaluate LTR _DSM and save the latencies in pci_dev.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
v6 - Change the order of the function calls so, the messages are
     enabled only after the LTR registers have been initialized.
v5 - Add static keyword with pci_ltr_encode() and pci_ltr_decode()
v4 - remove pci_upstream_bridge and use acpi_pci_find_companion()
     to get the handle for evaluating _DSM.
     Add acpi_check_dsm()
     Change the logging mechanism.
v3 - change the algorithm to add latencies, add helper funtions for
     encoding and decoding the latencies.
v2 - add an #ifdefin pci-acpi.c to fix the bug reported by test bot.
v1 - based the patch on v5.9-rc1 so it applies correctly.
---
 drivers/pci/pci-acpi.c   | 37 +++++++++++++++++++++
 drivers/pci/pci.h        |  4 +++
 drivers/pci/pcie/aspm.c  | 71 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |  6 ++++
 include/linux/pci-acpi.h |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 121 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a03f748..1bceee861bfc 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,6 +1213,43 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+/* pci_acpi_evaluate_ltr_latency
+ *
+ * @dev - the pci_dev to evaluate and save latencies
+ */
+void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCIEASPM
+	struct acpi_device *adev;
+	union acpi_object *obj, *elements;
+
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev && !pci_dev_is_added(dev))
+		adev = acpi_pci_find_companion(&dev->dev);
+	if (!adev)
+		return;
+
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 2,
+				1ULL << DSM_PCI_LTR_MAX_LATENCY))
+		return;
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 2,
+					DSM_PCI_LTR_MAX_LATENCY, NULL);
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 4) {
+		elements = obj->package.elements;
+		dev->max_snoop_latency = (u16)elements[1].integer.value |
+				((u16)elements[0].integer.value <<
+							PCI_LTR_SCALE_SHIFT);
+		dev->max_nosnoop_latency = (u16)elements[3].integer.value |
+				((u16)elements[2].integer.value <<
+							PCI_LTR_SCALE_SHIFT);
+	}
+	ACPI_FREE(obj);
+#endif
+}
+
 static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..cc1cc6f09530 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -561,11 +561,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
+void pci_ltr_init(struct pci_dev *dev);
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
 #else
+static inline void pci_ltr_init(struct pci_dev *pdev) { }
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
@@ -680,11 +682,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
+void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev);
 #else
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
+static inline void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index cc4aeeb13d8f..84752aad25ef 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -318,6 +318,77 @@ static void pci_lat_encode(u64 lat, u32 *scale, u32 *val)
 	else			 { *scale = 5; *val = (lat >> 25) & 0x3ff; }
 }
 
+/**
+ * pci_lat_decode - Decode the latency to a value in ns
+ * @latency: latency register value
+ *
+ * @latency is in the format of the LTR Capability Max Snoop Latency and
+ * Max No-Snoop Latency registers (see PCIe r5.0, sec 7.8.1 and 6.18).
+ */
+static u64 pci_lat_decode(u16 latency)
+{
+	u16 scale = (latency & PCI_LTR_SCALE_MASK) >> 10;
+	u64 val = latency & PCI_LTR_VALUE_MASK;
+
+	switch (scale) {
+	case 0: return val <<  0;
+	case 1: return val <<  5;
+	case 2: return val << 10;
+	case 3: return val << 15;
+	case 4: return val << 20;
+	case 5: return val << 25;
+	}
+	return 0;
+}
+
+/**
+ * pci_ltr_init - Initialize Latency Tolerance Reporting capability of
+ * 		  given PCI device
+ * @dev: PCI device
+ */
+void pci_ltr_init(struct pci_dev *dev)
+{
+	int ltr;
+	struct pci_dev *bridge;
+	u64 snoop = 0, nosnoop = 0;
+	u32 scale, val;
+	u16 snoop_enc, snoop_cur, nosnoop_enc, nosnoop_cur;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	bridge = pci_upstream_bridge(dev);
+	while (bridge) {
+		snoop += pci_lat_decode(bridge->max_snoop_latency);
+		nosnoop += pci_lat_decode(bridge->max_nosnoop_latency);
+		bridge = pci_upstream_bridge(bridge);
+	}
+
+	pci_dbg(dev, "calculated Max Snoop Latency %lluns Max No-Snoop Latency %lluns\n",
+		snoop, nosnoop);
+
+	pci_lat_encode(snoop, &scale, &val);
+	snoop_enc = (scale << 10) | val;
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, &snoop_cur);
+	if (snoop_enc != snoop_cur) {
+		pci_info(dev, "setting Max Snoop Latency %lluns (was %lluns)\n",
+			 snoop, pci_lat_decode(snoop_cur));
+		pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT,
+				      snoop_enc);
+	}
+
+	pci_lat_encode(nosnoop, &scale, &val);
+	nosnoop_enc = (scale << 10) | val;
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &nosnoop_cur);
+	if (nosnoop_enc != nosnoop_cur) {
+		pci_info(dev, "setting Max No-Snoop Latency %lluns (was %lluns)\n",
+			 nosnoop, pci_lat_decode(nosnoop_cur));
+		pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT,
+				      nosnoop_enc);
+	}
+}
+
 /* Convert L0s latency encoding to ns */
 static u32 calc_l0s_latency(u32 encoding)
 {
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..ded4986638a7 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2106,6 +2106,12 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	/* Read latency values (if any) from platform */
+	pci_acpi_evaluate_ltr_latency(dev);
+
+	/* Initialize the Latency Tolerance Reporting (LTR) Extended Capability */
+	pci_ltr_init(dev);
+
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 5ba475ca9078..e23236a4ff66 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -110,6 +110,7 @@ extern const guid_t pci_acpi_dsm_guid;
 
 /* _DSM Definitions for PCI */
 #define DSM_PCI_PRESERVE_BOOT_CONFIG		0x05
+#define DSM_PCI_LTR_MAX_LATENCY			0x06
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..af7558e3c331 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -380,6 +380,8 @@ struct pci_dev {
 	struct pcie_link_state	*link_state;	/* ASPM link state */
 	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
 					   supported from root to here */
+	u16 max_snoop_latency;		/* LTR Max Snoop latency */
+	u16 max_nosnoop_latency;	/* LTR Max No-Snoop latency */
 #endif
 	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
 
-- 
2.27.0

