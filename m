Return-Path: <linux-pci+bounces-28342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8950AAC2A10
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15161B68278
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9C329ACEA;
	Fri, 23 May 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EEGra3BU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419329AB04;
	Fri, 23 May 2025 18:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026799; cv=none; b=leMceu70JVr2YyhROqU1rqk52oUY71ICmHW3QNjFdkA576VD8l/DCvqdMXS9PFysIxuT4oNRWpTCnB1WgnsPe327/ffTcBGKqjtA/Zg5beIwRxYosXnFlDmuGgsPCyETU1oaY1+U+pMevKM+I1QM1UxdsrAmnUnHIsX2kFQtVV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026799; c=relaxed/simple;
	bh=sY0NnDSms1Xf1JCRlFpt0/e3+SFgBMlluoazWQTLkB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ClT4cipKypThFVM/aVb0SOJHkV79if5HHf1Q0kpD9ympv/QVdnylm4lgh7PFY6EW2+ha910VgwDt/F64N1Bir6WFXoql4I7F2o523gLiUzsyDRZMaVY8JxGMXKNK8/SYCtyTFyrtzrqa/08zANQPejgoK+JAjaI52tA1rNa2buQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EEGra3BU; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026798; x=1779562798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sY0NnDSms1Xf1JCRlFpt0/e3+SFgBMlluoazWQTLkB0=;
  b=EEGra3BUdDgV4qvfcfRnmR0TW6WN/7CMBafGi8SzIImDnAbYsBC6L8xa
   T2LNdYZlWCI93chKm3iSgY9CKvFnBkzztdIZRG73O2QrPrVHtU19AmwGR
   bbvO6advFb+Q7LuZqAP6iaikzCimrVy8yE5M7Kzn1EewPlz8d31M7bo+6
   wtdByGhQGnQO1/GBxC1jnazXgw0GPB7EvaZvTTuxMH23uQe54k/kzvEBs
   eUH/3qRfWSWPlIPMI7J4tK48ToyU5hTclHz1oMNnlq7Sa3fhRUqGLLmU/
   PbUT8FfAz4/gVVph39BMhRrvtf3bjzYvGtvCjOZvoNwm+wBK0dAwkkA6+
   A==;
X-CSE-ConnectionGUID: zIDIFfiqQVSEoGsXvtoHhw==
X-CSE-MsgGUID: P7FrwospSA+9Rs7+I/PJlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498425"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498425"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:51 -0700
X-CSE-ConnectionGUID: 661m8WK6SrO5W5EEk1u8mQ==
X-CSE-MsgGUID: MfyNjCaOTParsSvDwLoenA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141758844"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:47 -0700
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH v3 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Date: Sat, 24 May 2025 00:31:45 +0530
Message-Id: <20250523190155.2623462-2-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523190155.2623462-1-badal.nilawar@intel.com>
References: <20250523190155.2623462-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anshuman Gupta <anshuman.gupta@intel.com>

Implement _DSM method 0Ah according to PCI firmware specifications,
section 4.6.10 Rev 3.3., to request auxilary power needed for the
device when in D3Cold.

Note that this implementation assumes only a single device below the
Downstream Port will request for Aux Power Limit under a given
Root Port because it does not track and aggregate requests
from all child devices below the Downstream Port as required
by Section 4.6.10 Rev 3.3.

One possible mitigation would be only allowing only first PCIe
Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.

V2(Bjorn/Rafael):
  - Call acpi_dsm_check() to find method 0Ah supported
  - Return retry interval to caller

Signed-off-by: Varun Gupta <varun.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  8 ++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..76b19525535f 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+/**
+ * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3Cold
+ * @dev: PCI device instance
+ * @requested_power: Requested auxiliary power in milliwatts
+ * @retry_interval: Retry interval returned by platform to retry auxiliary
+ *                  power request
+ *
+ * This function sends a request to the host BIOS via root port ACPI _DSM Function 0Ah
+ * for the auxiliary power needed by the PCI device when it is in D3Cold.
+ * It checks and evaluates the _DSM (Device Specific Method) to request the auxiliary
+ * power and handles the response accordingly.
+ *
+ * This function shall be only called by 1st non-bridge Endpoint driver
+ * on Function 0. For a Multi-Function Device, the driver for Function 0 is
+ * required to report an aggregate power requirement covering all
+ * functions contained within the device.
+ *
+ * Return: Returns 0 on success and errno on failure.
+ */
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
+				      u32 *retry_interval)
+{
+	union acpi_object in_obj = {
+		.integer.type = ACPI_TYPE_INTEGER,
+		.integer.value = requested_power,
+	};
+
+	union acpi_object *out_obj;
+	acpi_handle handle;
+	int result, ret = -EINVAL;
+
+	if (!dev)
+		return -EINVAL;
+
+	handle = ACPI_HANDLE(&dev->dev);
+	if (!handle)
+		return -EINVAL;
+
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT)) {
+		pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_D3COLD_AUX_POWER_LIMIT);
+		return -ENODEV;
+	}
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
+					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
+					  &in_obj, ACPI_TYPE_INTEGER);
+	if (!out_obj)
+		return -EINVAL;
+
+	result = out_obj->integer.value;
+	if (retry_interval)
+		*retry_interval = 0;
+
+	switch (result) {
+	case 0x0:
+		pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
+			requested_power);
+		break;
+	case 0x1:
+		pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
+			 requested_power);
+		ret = 0;
+		break;
+	case 0x2:
+		pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
+		ret = -EBUSY;
+		break;
+	default:
+		if (result >= 0x11 && result <= 0x1F) {
+			if (retry_interval) {
+				*retry_interval = result & 0xF;
+				pci_warn(dev, "D3cold Aux Power request needs retry interval: %u seconds\n",
+					 *retry_interval);
+				ret = -EAGAIN;
+			}
+		} else {
+			pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
+				result);
+		}
+		break;
+	}
+
+	ACPI_FREE(out_obj);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
+
 static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 078225b514d4..1705d03bfe26 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
+#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
@@ -132,10 +133,17 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
+				      u32 *retry_interval);
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
+static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
+					     u32 *retry_interval)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.34.1


