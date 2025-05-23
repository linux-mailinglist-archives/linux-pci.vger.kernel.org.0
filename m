Return-Path: <linux-pci+bounces-28344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D3AC2A14
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7B41B6840B
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 19:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E3029B774;
	Fri, 23 May 2025 19:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqejBsVd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603DC29B200;
	Fri, 23 May 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748026801; cv=none; b=QKgJERqA/1344WAJ+zXkTLxtLNa6eJGtgkt1SEU1xw1nh2/q+easMf2HcQt8amq8t8ZkRBqR6VhcGo8QBS57DdHSrhuOTVVha/1mnjts/59LF5zWaznp7n170jGliuHI2rRhuXCI7hpw0muxxbexqdtEXWvq5JyIw/8TkcigVGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748026801; c=relaxed/simple;
	bh=XZYMSdRM/CeVnis/V3tbQbWjyaGZsUwIMsXLqecNb9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=amEj/dJX+5AFdyjV/ZyrPIZE7GPuL7SWnNlhhNyvzSoVGYaIacijrmaKynM4CVEqqNeecjjxRc38+hESxPCDe+qnenI4pur/6P8oUcxfjy6AVMbvI53KnOvIit6MtY1AlkXHtNDE6L/Eo5tKpI8SVPqfOWzmYCE/zpFGh7SzARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqejBsVd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748026800; x=1779562800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XZYMSdRM/CeVnis/V3tbQbWjyaGZsUwIMsXLqecNb9Q=;
  b=cqejBsVdb6WMwrvGQSK0dhI8CriOCwWCS6E6m7OiZ5uL1jMNZiMyzwLj
   B0AFW1lYdfhssgbWjgKb/17QjatD9B+0BcmG4kLj7Uj3VzYO4L96RAfq6
   /QucYelage2SVY8u66JZjXfBNiHq6S+n0EBngUdURmhBC2OkD3Oza1eWg
   yGLQF8YHjEGXtbNV7y8z5QjYxTOVG8+oq/4z2oOPbhpBFIdvg+SpptLPv
   krbiGIfI4GkEE/lrVCZS0sEMoV7FK5fdKsGVla1tgMpzW7/ORbQQdo3qh
   XEEU2w9foRBUrHaDmk4qMKjFv+fdEUQCupaBIsd11HR0BvfrikR6DA1iE
   A==;
X-CSE-ConnectionGUID: mnR3S5egRKyBtW+fx0NTWg==
X-CSE-MsgGUID: T+Hz8P3FRIaqOY5ZFtgp4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="61498472"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="61498472"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:59 -0700
X-CSE-ConnectionGUID: UviwiJiBQH6hdYJ00UcQKA==
X-CSE-MsgGUID: QV17UTgbRRaIffwc524iIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141758894"
Received: from unknown (HELO bnilawar-desk2.iind.intel.com) ([10.190.239.41])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 11:59:55 -0700
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
Subject: [PATCH v3 03/11] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Date: Sat, 24 May 2025 00:31:47 +0530
Message-Id: <20250523190155.2623462-4-badal.nilawar@intel.com>
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

Implement _DSM Method 0Bh as per PCI firmware specs
section 4.6.11 Rev 3.3.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
---
 drivers/pci/pci-acpi.c   | 57 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  8 +++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 53ba67678c3d..678c48f72010 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1531,6 +1531,63 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
 }
 EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
 
+/**
+ * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI DSM
+ * @dev: PCI device instance
+ * @delay_us: Requested delay_us
+ *
+ * This function sends a request to the host BIOS via ACPI _DSM to grant the
+ * required PERST# delay for the specified PCI device. It evaluates the _DSM
+ * to request the PERST# delay and handles the response accordingly.
+ *
+ * Return: returns 0 on success and errno on failure.
+ */
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
+{
+	union acpi_object in_obj = {
+		.integer.type = ACPI_TYPE_INTEGER,
+		.integer.value = delay_us,
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
+	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_PERST_ASSERTION_DELAY)) {
+		pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_PERST_ASSERTION_DELAY);
+		return -ENODEV;
+	}
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
+					  DSM_PCI_PERST_ASSERTION_DELAY,
+					  &in_obj, ACPI_TYPE_INTEGER);
+	if (!out_obj)
+		return -EINVAL;
+
+	result = out_obj->integer.value;
+
+	if (result == delay_us) {
+		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
+		ret = 0;
+	} else if (result == 0) {
+		pci_warn(dev, "PERST# Assertion Delay request failed, no previous valid request\n");
+	} else {
+		pci_warn(dev, "PERST# Assertion Delay request failed, Previous valid delay: %u microseconds\n",
+			 result);
+	}
+
+	ACPI_FREE(out_obj);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_add_perst_assertion_delay);
+
 static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 1705d03bfe26..889e469206e2 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
+#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
@@ -135,7 +136,7 @@ int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_de
 void pci_acpi_clear_companion_lookup_hook(void);
 int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
 				      u32 *retry_interval);
-
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
@@ -144,6 +145,11 @@ static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_
 {
 	return -EOPNOTSUPP;
 }
+
+static int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.34.1


