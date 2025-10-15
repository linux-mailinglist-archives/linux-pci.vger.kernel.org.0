Return-Path: <linux-pci+bounces-38164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D06BDD470
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20E90353CF1
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1634A2C21F6;
	Wed, 15 Oct 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TAFAN/mN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550522BEFF0;
	Wed, 15 Oct 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515351; cv=none; b=oAgXOF5Q21Kw6XxwppH+wIopyVnO/X0KwCXUxqO2i2xaSJlwdrMw9ru3oBtz18G5NyDSD4HQTYOAa6D0n97Z/SAkAmR/Kug1EC1Klwwof3NffnjikDWgdNHfsbRgvaFliTUjEhZI0dkMFJRPEloy6GM3nND47e9WyFKJ09jsMi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515351; c=relaxed/simple;
	bh=5ugmTtA9TV2ng/2i8o/Bv7Qs7iLX0E4gKXufe21cP10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ebhwerreS50ZAVumeZ0w9DrxyeDMo5j8AB0TDc/gWG3bB6PLSGu4L1rBbLcHwkRPtHxbDAzP8KvwvndsDeCClUtwClF7UEp8l7fk/WTvkPOKP7YKwcZ5Kq/as2bLjYjwtKALnjqGTP0LcwKuC7ZbfdLi14PDM4pHYcMLd3mNNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TAFAN/mN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515350; x=1792051350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ugmTtA9TV2ng/2i8o/Bv7Qs7iLX0E4gKXufe21cP10=;
  b=TAFAN/mNzR/uBx+ejSEtufiTNjFBoZfiipCmslzEcfmjN1Zp685SCVUW
   gUAgc3mpvWO+v1/xFrLHtQeS3eDZ+QFE87QrYWNVcxLS+Pa/7NQ12LGhx
   GpZjmx/hJoXnyQ73+BNpqUsASE4Vbq92zDNECcOTavOhiupMoRcY+Ztil
   pmS8mE62p+LKT0WzxjlhxPdmKWLX8K0d65KM/zMaHzSC9RMXh6C8/ZWMv
   r5+cqJx4rtrwBZtlWrsrEx7YqKDGNmPnoAZjgm6fk2LAh8bNhnXguukl/
   nLDCt+b4HphrCGKuIDn8ytcb6KVZMGr8EeeScbP1QlPBedIU2BJNL4miX
   w==;
X-CSE-ConnectionGUID: XpXT70pZS7OUmfE14rYG8w==
X-CSE-MsgGUID: gVRB5lamSN29K/tr8KpgSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891438"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891438"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:29 -0700
X-CSE-ConnectionGUID: lM6xYwq/Q6eAPR/HN3/nSQ==
X-CSE-MsgGUID: KYyik1rPREy11JXzNox0GQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805347"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:25 -0700
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
	uma.shankar@intel.com,
	karthik.poosa@intel.com
Subject: [PATCH v5 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Date: Wed, 15 Oct 2025 13:36:59 +0530
Message-Id: <20251015080710.1468409-2-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015080710.1468409-1-badal.nilawar@intel.com>
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anshuman Gupta <anshuman.gupta@intel.com>

Implement _DSM method 0Ah, as per PCI Firmware r3.3, sec 4.6.10,
to request auxiliary power required by the device when in D3cold state.

Note that this implementation assumes only a single device below the
Downstream Port will request for Aux Power Limit under a given
Root Port/Downstream Port because it does not track and aggregate
requests from all child devices below the Downstream Port as required
by PCI Firmware r3.3, sec 4.6.10.

Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
V2(Bjorn/Rafael):
  - Call acpi_dsm_check() to find method 0Ah supported
  - Return retry interval to caller
V3(Kuppuswamy)
  - Add NULL check for retry interval
V4
  - Define enums for aux power request status (Rafael)
  - Add Co-developed-by and clean up Signed-off-by (Kappuswamy)
 (Bjorn)
  - Instead of root pci device pass the pci device of driver, traverse
    up the tree and discover _DSM
  - Allow only function 0 of device to request aux power
  - Allow retry_interval to be NULL
  - Refine commit message and function description
---
 drivers/pci/pci-acpi.c   | 114 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |   9 ++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9369377725fa..c7eab1e75dd5 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1418,6 +1418,120 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+static struct pci_dev *pci_acpi_check_dsm(struct pci_dev *dev, u64 rev, u64 funcs)
+{
+	struct pci_dev *bdev;
+	acpi_handle handle;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	bdev =  dev;
+	while (bdev) {
+		handle = ACPI_HANDLE(&bdev->dev);
+		if (handle && acpi_check_dsm(handle, &pci_acpi_dsm_guid, rev, 1 << funcs))
+			return bdev;
+
+		bdev = pci_upstream_bridge(bdev);
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+enum aux_pwr_req_status {
+	AUX_PWR_REQ_DENIED               = 0x0,
+	AUX_PWR_REQ_GRANTED              = 0x1,
+	AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL  = 0x2,
+	AUX_PWR_REQ_RETRY_INTERVAL_MIN   = 0x11,
+	AUX_PWR_REQ_RETRY_INTERVAL_MAX   = 0x1F
+};
+
+/**
+ * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3cold
+ * @dev: PCI device instance
+ * @requested_mw: Requested auxiliary power in milliwatts
+ * @retry_interval: Retry interval returned by platform to retry auxiliary
+ *                  power request
+ *
+ * Request auxilary power to platform firmware, via Root Port/Switch Downstream
+ * Port ACPI _DSM Function 0Ah, needed for the PCI device when it is in D3cold.
+ * Evaluate the _DSM and handle the response accordingly.
+ *
+ * For Multi-Function Devices, driver for Function 0 is required to report an
+ * aggregate power requirement covering all functions contained within the
+ * device.
+ *
+ * Note: Aggregation across multiple child devices beneath the Root/Switch Downstream
+ * Port is not supported.
+ *
+ * Return: Returns 0 on success and errno on failure.
+ */
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
+				      u32 *retry_interval)
+{
+	union acpi_object in_obj = {
+		.integer.type = ACPI_TYPE_INTEGER,
+		.integer.value = requested_mw,
+	};
+
+	union acpi_object *out_obj;
+	int result, ret = -EINVAL;
+	struct pci_dev *bdev;
+
+	if (!dev || PCI_FUNC(dev->devfn) != 0)
+		return -EINVAL;
+
+	bdev = pci_acpi_check_dsm(dev, 4, 1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT);
+
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
+					  &pci_acpi_dsm_guid, 4,
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
+	case AUX_PWR_REQ_DENIED:
+		pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
+			requested_mw);
+		break;
+	case AUX_PWR_REQ_GRANTED:
+		pci_info(bdev, "D3cold Aux Power request granted: %u mW\n",
+			 requested_mw);
+		ret = 0;
+		break;
+	case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
+		pci_info(bdev, "D3cold Aux Power: Main power won't be removed\n");
+		ret = -EBUSY;
+		break;
+	default:
+		if (result >= AUX_PWR_REQ_RETRY_INTERVAL_MIN &&
+		    result <= AUX_PWR_REQ_RETRY_INTERVAL_MAX) {
+			pci_info(bdev, "D3cold Aux Power request needs retry interval: %u seconds\n",
+				 result & 0xF);
+			if (retry_interval) {
+				*retry_interval = result & 0xF;
+				ret = -EAGAIN;
+			}
+		} else {
+			pci_err(bdev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
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
index 078225b514d4..ba48e7ddb360 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
+#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
@@ -132,10 +133,18 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
+				      u32 *retry_interval);
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
+static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev,
+						    u32 requested_mw,
+						    u32 *retry_interval)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.34.1


