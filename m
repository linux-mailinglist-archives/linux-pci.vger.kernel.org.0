Return-Path: <linux-pci+bounces-28597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E716CAC7C74
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 13:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA524A5081
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 11:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349F28E585;
	Thu, 29 May 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YGdeVD7F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2DD28E580;
	Thu, 29 May 2025 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748517291; cv=none; b=B161wv/l19l8K5w665XyOrjym9VRH3uKybllmFzesua/jUsYmCnhZXQPtmPIaChir8bRAnFRpSdqbDBVB2R8WneR7z+NWt5SblSX8DOXi8I9MCBNWL/C8xlfmtYoWF6QKToIwbdahVqQltmEhbW3ZGsVeVZQ7bw2xTLIhCdMTn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748517291; c=relaxed/simple;
	bh=63xE3b4gppfJTAf4t0apxS/FsrmUAxahH2v1ExrCUfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfq3KyTnbU5VUyNRd9omd/B222DEhaJg/PLTUWAHVNZU0FSMhYz4zgUJv6Zut32/4MCCZ73+NpIRuV3ue+HpKHKMuapWrH/KduENyOKUR7SpXCpNQ/6ua1nx/ZtW2T0NXBwsibmqWUZLhri18d36ZgzpvE/pWaRIVk1pSHPDD80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YGdeVD7F; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748517289; x=1780053289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63xE3b4gppfJTAf4t0apxS/FsrmUAxahH2v1ExrCUfM=;
  b=YGdeVD7F98/cz7kqocaCBwlYwxr24DbSXVSxzNZsFENokdMAPgImsiZp
   FJhMbU13WgHeBwtY8yVl0AnaPaPJnw/r3O+sTD5R7r4UuBkE6g1M4xPmj
   OA5U/d71Vkdk0cEADj70u/sKFUT9mHafJTYMK+WIODfYUpByrpDyUixgh
   qcSmV8jCcGpF8TQ3ZLSHukYS6OKG9lBC82j1xJ30H+IG1pj9dfJfx7BX9
   SjQnvMOLp/x9grkYM8r10badeBMbENd+tvTzUGPH/M5RLm7wrellbe7/J
   Ow/IdYSqxOJ8Y/2CT7K9xx5iqj1PwGe3R3cQOOE/D3rqKnqPNa8MVEUHV
   g==;
X-CSE-ConnectionGUID: f1+oz5qOSVmmv+39HR1jww==
X-CSE-MsgGUID: HNMJ6UYCT4Gtr3W1l4GpeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="68123095"
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="68123095"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:14:49 -0700
X-CSE-ConnectionGUID: K2ss1kdaQKyIqXaJ3DrRQQ==
X-CSE-MsgGUID: Hh5gyQ2xSnGuQS4VGS/f9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,192,1739865600"; 
   d="scan'208";a="143510380"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 04:14:45 -0700
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
Subject: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Date: Thu, 29 May 2025 16:46:44 +0530
Message-Id: <20250529111654.3140766-2-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529111654.3140766-1-badal.nilawar@intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
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

Signed-off-by: Varun Gupta <varun.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
V2(Bjorn/Rafael):
  - Call acpi_dsm_check() to find method 0Ah supported
  - Return retry interval to caller
V3(Kuppuswamy)
  - Add NULL check for retry interval
---
 drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  8 ++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..87f30910a5f1 100644
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
+	if (!dev || !retry_interval)
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
index 078225b514d4..6079306ad754 100644
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
+static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
+						    u32 *retry_interval)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.34.1


