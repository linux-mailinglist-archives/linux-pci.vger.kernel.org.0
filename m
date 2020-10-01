Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCBC280995
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 23:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgJAVo6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 17:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAVo6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 17:44:58 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB0B2074B;
        Thu,  1 Oct 2020 21:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601588697;
        bh=IKsaYEbmVrdzhmmOfVyKxU4AZlQRCzGCFO38zCYOt+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfwN5K46WemFrVz2od9+zPnc4E4FARAF3Q3hiq97PA6iZx0mD4tgAv1nPuH4GTbWW
         UInDL4c9Fx0zYr1EP76LMHjFhqc0v90eBEbm7qDtkhIl6tkxc69gCvjg458BOm8rrs
         LgpGqnzjgEKIHGPjNXnwggh73GoDLU6meDbVCy48=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 2/2] PCI/ASPM: Add support for LTR _DSM
Date:   Thu,  1 Oct 2020 16:44:36 -0500
Message-Id: <20201001214436.2735412-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001214436.2735412-1-helgaas@kernel.org>
References: <20201001214436.2735412-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Puranjay Mohan <puranjay12@gmail.com>

Latency Tolerance Reporting (LTR) is required for the ASPM L1.2 PM
substate.  Devices with Upstream Ports (Endpoints and Switches) may support
the optional LTR Capability.  When LTR is enabled, devices transmit LTR
messages containing Snoop and No-Snoop Latencies upstream.  The L1.2
substate may be entered if the most recent LTR values are greater than or
equal to the LTR_L1.2_THRESHOLD from the L1 PM Substates Control 1
register.

Add a new function pci_ltr_init() which will be called from
pci_init_capabilities() to initialize every PCIe device's LTR values.
Add code in probe.c to evaluate LTR _DSM and save the latencies in pci_dev.

Link: https://lore.kernel.org/r/20200926052917.20247-1-puranjay12@gmail.com
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci-acpi.c   | 35 ++++++++++++++++++++
 drivers/pci/pci.h        |  4 +++
 drivers/pci/pcie/aspm.c  | 71 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |  4 +++
 include/linux/pci-acpi.h |  1 +
 include/linux/pci.h      |  2 ++
 6 files changed, 117 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a03f748..dc1623de3475 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1213,6 +1213,41 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+/* pci_acpi_evaluate_ltr_latency
+ *
+ * @dev - pci_dev for which to evaluate Latency Tolerance Reporting _DSM
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
+			    1ULL << DSM_PCI_LTR_MAX_LATENCY))
+		return;
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 2,
+				DSM_PCI_LTR_MAX_LATENCY, NULL);
+	if (!obj)
+		return;
+
+	if (obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 4) {
+		elements = obj->package.elements;
+		dev->max_snoop_latency = (u16) (elements[1].integer.value |
+			(elements[0].integer.value << PCI_LTR_SCALE_SHIFT));
+		dev->max_nosnoop_latency = (u16) (elements[3].integer.value |
+			(elements[2].integer.value << PCI_LTR_SCALE_SHIFT));
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
index beb6e2e4e5d2..0ca25628ba4a 100644
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
index 03d37128a24f..25ed03cd4757 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2106,6 +2106,9 @@ static void pci_configure_ltr(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return;
 
+	/* Read latency values (if any) from platform */
+	pci_acpi_evaluate_ltr_latency(dev);
+
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
 	if (!(cap & PCI_EXP_DEVCAP2_LTR))
 		return;
@@ -2400,6 +2403,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
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
2.25.1

