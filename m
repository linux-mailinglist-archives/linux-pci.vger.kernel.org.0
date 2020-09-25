Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BA2279008
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 20:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgIYSE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIYSE1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 14:04:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97046C0613CE
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 11:04:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id v14so2112831pjd.4
        for <linux-pci@vger.kernel.org>; Fri, 25 Sep 2020 11:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlJ1phCzV4Gyh0d+jKE5Xq3NkjRcylO3xgD8ZugmS5s=;
        b=oGJFQDaSEWjNfMnVtQuDJJ8068MVo0MHqJ/F42fcqLRRVUHtkIqcZRxVNcSVoby1pl
         iUD2DN62vSgMrMb+QoQ/dPov+1fkikLcA8z4cZWrUrbJBZttquIaYkrZ9M2WNT0Gpc3M
         6EUEv9+iDrwF1eg6HbOPPIQqVKXyjmRf5YFFh6Dj+kqYohZI5FOQW+DkTVhr5wq1WR46
         Y5JYa2iE1YVH1voeJg5eK1ooF9TPGItZjD55nNLCC8Tol7bbivGKWsdNKnRM0HAfWXw7
         u3ATpNJ83Wfml2PKdMQK/CQstZIKepdGrlP7m2qCgln4sVwKDVEB9la4cY4GfCWhOf0N
         cWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SlJ1phCzV4Gyh0d+jKE5Xq3NkjRcylO3xgD8ZugmS5s=;
        b=R+C2fFEKk1TpBnKj9M+8ZLUaieF/KPrbryzcUKvnNwfVVmHg3QT5XdGm86kH10ZEON
         BzKxErvtbf88hUfdCACYz5PHDkSXlLsldGfSTC84LE7P0DFgt3JsqGNefOkzGzkOtzSL
         bwE6F9PH18cqewlTQj+s2w2ITzAXUPmEuhyQSFk3dS6ogvXVne0T9mjI8/kRCbN0Yxpz
         w86kXCSijotSeAl1KJe85fwYd/tcFbk8/rlYGowySt6w+nSzSBGEn0s9vdTAT3dj8yhx
         e8Xi38pzMltJlTmTDmpINiEPUB1rtcFbdIqbZZ3xnOJa7FybsIxj1sHiG0mFUuCPhQiL
         pfUg==
X-Gm-Message-State: AOAM532AW2BItff8QbtEXrVov1DxRCQHet2zzXivFA3WVhNa8tFIChAE
        mlnCoN8XMp5pZiBroG8Yx+M=
X-Google-Smtp-Source: ABdhPJzoPO9cyIgcub04wElF2GrnfKicw3NsVaB+SWQ0ZgmHMfnbd/SH8bTaJsL0btakSoPp8nR/NQ==
X-Received: by 2002:a17:90a:e68f:: with SMTP id s15mr669570pjy.79.1601057066876;
        Fri, 25 Sep 2020 11:04:26 -0700 (PDT)
Received: from localhost.localdomain ([27.255.176.56])
        by smtp.googlemail.com with ESMTPSA id 64sm3286817pfd.7.2020.09.25.11.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 11:04:26 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     bjorn@helgaas.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>, linux-pci@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4] PCI: Add support for LTR
Date:   Fri, 25 Sep 2020 23:33:56 +0530
Message-Id: <20200925180356.13093-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new function pci_ltr_init() which will be called from
pci_init_capabilities() to initialize every PCIe device's LTR values.
Add code in probe.c to evaluate LTR _DSM and save the latencies in pci_dev.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
v4 - remove pci_upstream_bridge and use acpi_pci_find_companion()
     to get the handle for evaluating _DSM.
     Add acpi_check_dsm()
     Change the logging mechanism.
v3 - change the algorithm to add latencies, add helper funtions for
     encoding and decoding the latencies.
v2 - add an #ifdefin pci-acpi.c to fix the bug reported by test bot.
v1 - based the patch on v5.9-rc1 so it applies correctly.
---
 drivers/pci/pci-acpi.c   | 37 ++++++++++++++++
 drivers/pci/pci.c        | 96 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h        |  3 ++
 drivers/pci/probe.c      |  7 ++-
 include/linux/pci-acpi.h |  1 +
 include/linux/pci.h      |  2 +
 6 files changed, 145 insertions(+), 1 deletion(-)

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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a458c46d7e39..a44f07550fac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3056,6 +3056,102 @@ void pci_pm_init(struct pci_dev *dev)
 		dev->imm_ready = 1;
 }
 
+/**
+ * pci_ltr_decode - Decode the latency to a value in ns
+ * @latency: latency according to PCIe base specification 7.8.2.
+ */
+u64 pci_ltr_decode(u16 latency)
+{
+	u16 scale = (latency & PCI_LTR_SCALE_MASK) >> 10;
+	u16 value = latency & PCI_LTR_VALUE_MASK;
+
+	switch (scale) {
+	case 0: return value;
+	case 1: return value * 32;
+	case 2: return value * 1024;
+	case 3: return value * 32768;
+	case 4: return value * 1048576;
+	case 5: return value * 33554432;
+	}
+	return 0;
+}
+
+/**
+ * pci_ltr_encode - Encode the value in ns to a 16 bit register value
+ * @val: latency according to PCIe base specification 7.8.2.
+ */
+u16 pci_ltr_encode(u64 val)
+{
+	if (val <= 1UL * 0x3ff)
+		return (0 << 10) | (val & 0x3ff);
+	if (val <= 32UL * 0x3ff)
+		return (1 << 10) | ((val >> 5) & 0x3ff);
+	if (val <= 1024UL * 0x3ff)
+		return (2 << 10) | ((val >> 10) & 0x3ff);
+	if (val <= 32768UL * 0x3ff)
+		return (3 << 10) | ((val >> 15) & 0x3ff);
+	if (val <= 1048576UL * 0x3ff)
+		return (4 << 10) | ((val >> 20) & 0x3ff);
+	if (val <= 33554432UL * 0x3ff)
+		return (5 << 10) | ((val >> 25) & 0x3ff);
+	return 0;
+}
+
+/**
+ * pci_ltr_init - Initialize Latency Tolerance Information of given PCI device
+ * @dev: PCI device to handle.
+ */
+void pci_ltr_init(struct pci_dev *dev)
+{
+#ifdef CONFIG_PCIEASPM
+	struct pci_dev *bridge = dev;
+	int ltr;
+	u64 max_snoop = 0, max_nosnoop = 0;
+	u16 max_snoop_encoded, max_nosnoop_encoded;
+	u16 max_snoop_current, max_nosnoop_current;
+	u64 max_snoop_current_decoded, max_nosnoop_current_decoded;
+
+	ltr = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_LTR);
+	if (!ltr)
+		return;
+
+	bridge = pci_upstream_bridge(bridge);
+	while (bridge) {
+		max_snoop += pci_ltr_decode(bridge->max_snoop_latency);
+		max_nosnoop += pci_ltr_decode(bridge->max_nosnoop_latency);
+		bridge = pci_upstream_bridge(bridge);
+	}
+	max_snoop_encoded = pci_ltr_encode(max_snoop);
+	max_nosnoop_encoded = pci_ltr_encode(max_nosnoop);
+
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT,
+							&max_snoop_current);
+	max_snoop_current_decoded = pci_ltr_decode(max_snoop_current);
+	pci_read_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT,
+							&max_nosnoop_current);
+	max_nosnoop_current_decoded = pci_ltr_decode(max_nosnoop_current);
+
+	pci_dbg(dev,
+		"Calculated Max Snoop Latency %lluns Max No-Snoop Latency %lluns\n",
+							max_snoop, max_nosnoop);
+
+	if (max_snoop != max_snoop_current_decoded) {
+		pci_info(dev, "Max Snoop Latency %lluns (was %lluns)\n",
+					max_snoop, max_snoop_current_decoded);
+		pci_write_config_word(dev,
+					ltr + PCI_LTR_MAX_SNOOP_LAT,
+							max_snoop_encoded);
+	}
+	if (max_nosnoop != max_nosnoop_current_decoded) {
+		pci_info(dev, "Max No-Snoop Latency %lluns (was %lluns)\n",
+					max_nosnoop, max_nosnoop_current_decoded);
+		pci_write_config_word(dev,
+				ltr + PCI_LTR_MAX_NOSNOOP_LAT,
+						max_nosnoop_encoded);
+	}
+#endif
+}
+
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
 {
 	unsigned long flags = IORESOURCE_PCI_FIXED | IORESOURCE_PCI_EA_BEI;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..18890975d0f1 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -110,6 +110,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
 void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
+void pci_ltr_init(struct pci_dev *dev);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
@@ -680,11 +681,13 @@ static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL
 
 #ifdef CONFIG_ACPI
 int pci_acpi_program_hp_params(struct pci_dev *dev);
+void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev);
 #else
 static inline int pci_acpi_program_hp_params(struct pci_dev *dev)
 {
 	return -ENODEV;
 }
+static inline void pci_acpi_evaluate_ltr_latency(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 03d37128a24f..74433265ea7e 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2105,6 +2105,11 @@ static void pci_configure_ltr(struct pci_dev *dev)
 
 	if (!pci_is_pcie(dev))
 		return;
+	/*
+	 * Read latency values from _DSM and save in pci_dev
+	 * as a part of latency tolerance reporting mechanism.
+	 */
+	pci_acpi_evaluate_ltr_latency(dev);
 
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
@@ -2123,7 +2128,6 @@ static void pci_configure_ltr(struct pci_dev *dev)
 
 		return;
 	}
-
 	if (!host->native_ltr)
 		return;
 
@@ -2400,6 +2404,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ptm_init(dev);		/* Precision Time Measurement */
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
+	pci_ltr_init(dev);		/* Latency Tolerance Reporting */
 
 	pcie_report_downtraining(dev);
 
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

