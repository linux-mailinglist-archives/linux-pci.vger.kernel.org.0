Return-Path: <linux-pci+bounces-22238-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E284DA42849
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E61616827A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872952638AC;
	Mon, 24 Feb 2025 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ECXd+PR2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9742627F2;
	Mon, 24 Feb 2025 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415817; cv=none; b=QhzWcwfUlhAu0W1PdSQYlHngS/SlwDC5KjLLX2wh8Q5YqEmTnf4R/vGioXVwNJHH5IZiszmJoK+l6B2gMSG/9hkRfDg0bisoMD8kk9l0imY6Naj1BX7gTvZc+QFIjIK20z1HFVZQgwhS6pHeM/JArhvGMAbLFJtqx80JYw0jS7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415817; c=relaxed/simple;
	bh=u645ArcxXOLOCxn7/YNh9zPyBzoTHAmi+f8xGVWI7qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uh8v9wrQr/jSMExOcrtlx/73djjhLOyAESrHVFHkLyzjzSp+0qSY4AUt1tEIV8CTMBV7zlCRL1fEDmG5XlN2uidvte34iK1JtudF+mVO1FSW5dlfGXGwRdlU54dOQPZNrat+uk7YtZDLkvAqS+xYWQkUeDGTq1ozvHdtHbJI4AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ECXd+PR2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740415815; x=1771951815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u645ArcxXOLOCxn7/YNh9zPyBzoTHAmi+f8xGVWI7qg=;
  b=ECXd+PR2gWPxeX/JPMhbovEB66G2IxX7pV14VjGcQEYfKggSVtf2QGhK
   yPAq0Z87BHZtVgOWdmglha95GJCppIP1RZtGYgXHFFcJuzvHJJR+kCsDA
   q7lvog/MMxggENU9/KMwjFhYOW5qBqUIYMnhQ2Fq7nmSURnspr9sXzbW/
   wPgFsCv+TTnsxRvhpaYCvdUt4zZI/bGo5ulIy1LBWQajVabEiIKxc+Bli
   /+O/qpQXEFuBPVdg8c2UqTqO3tkclYaUnm0C6jK1Uq7Vh3kB0QGmcGSWi
   iMohZXgHNUItpLntZUFvUQssL9/nH6oTHpu155nz+0HrHLJObjc/82MSU
   w==;
X-CSE-ConnectionGUID: ZQF0xlu8QXWZNLn7jhUGhg==
X-CSE-MsgGUID: qcLNuJF8RVeQWNwi6hvxQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41063180"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41063180"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:15 -0800
X-CSE-ConnectionGUID: BILZrv8lS3y0iJQqhLhTIg==
X-CSE-MsgGUID: ywJhN5AFTny/kjp3CERjfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="121032338"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 08:50:12 -0800
From: Anshuman Gupta <anshuman.gupta@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com,
	badal.nilawar@intel.com,
	kam.nasim@intel.com,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Varun Gupta <varun.gupta@intel.com>
Subject: [RFC 1/6] PCI/ACPI: Implement PCI FW _DSM method
Date: Mon, 24 Feb 2025 22:18:44 +0530
Message-Id: <20250224164849.3746751-2-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224164849.3746751-1-anshuman.gupta@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement _DSM method 10 and _DSM Method 11 as per PCI firmware specs
section 4.6.10 and 4.6.11.

Current assumption is only one PCIe Endpoint driver (XeKMD for Battlemage GPU)
will request for Aux Power Limit under a given Root Port but
theoretically it is possible that other Non-Intel GPU or Non-GPU
PCIe Endpoint driver can also request for Aux Power Limit and request to
block the core power removal under same Root Port.
That will disrupt the Battlemage GPU VRAM Self Refresh.

One possible mitigation would be only allowing only first PCIe
Non-Bridge Endpoint Function 0 driver to call_DSM method 10.

Signed-off-by: Varun Gupta <varun.gupta@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/pci/pci-acpi.c   | 123 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  13 +++++
 2 files changed, 136 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index af370628e583..806f6d19f46c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1421,6 +1421,129 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+/**
+ * pci_acpi_request_d3cold_aux_power - Request D3cold auxiliary power via ACPI DSM
+ * @dev: PCI device instance
+ * @requested_power: Requested auxiliary power in milliwatts
+ *
+ * This function sends a request to the host BIOS via ACPI _DSM Function 9 to grant
+ * the required D3Cold Auxiliary power for the specified PCI device.
+ * It evaluates the _DSM (Device Specific Method) to request the Auxiliary power and
+ * handles the response accordingly.
+ *
+ * This function shall be only called by 1st non-bridge Endpoint driver on Function 0.
+ * For a Multi-Function Device, the driver for Function 0 is required to report an
+ * aggregate power requirement covering all functions contained within the device.
+ *
+ * Return: Returns 0 on success and errno on failure.
+ */
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
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
+	if (!dev || !ACPI_HANDLE(&dev->dev))
+		return -EINVAL;
+
+	handle = ACPI_HANDLE(&dev->dev);
+
+	out_obj = acpi_evaluate_dsm_typed(handle,
+					  &pci_acpi_dsm_guid,
+					  4,
+					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
+					  &in_obj,
+					  ACPI_TYPE_INTEGER);
+	if (!out_obj)
+		return -EINVAL;
+
+	result = out_obj->integer.value;
+
+	switch (result) {
+	case 0x0:
+		dev_dbg(&dev->dev, "D3cold Aux Power request denied.\n");
+		break;
+	case 0x1:
+		dev_info(&dev->dev, "D3cold Aux Power request granted: %u mW.\n", requested_power);
+		ret = 0;
+		break;
+	case 0x2:
+		dev_info(&dev->dev, "D3cold Aux Power: Main power will not be removed.\n");
+		ret = -EBUSY;
+		break;
+	default:
+		if (result >= 0x11 && result <= 0x1F) {
+			int retry_interval = result & 0xF;
+
+			dev_warn(&dev->dev,
+				 "D3cold Aux Power request needs retry. Interval: %d seconds.\n", retry_interval);
+			msleep(retry_interval * 1000);
+			ret = -EAGAIN;
+		} else {
+			dev_err(&dev->dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x.\n", result);
+		}
+		break;
+	}
+
+	ACPI_FREE(out_obj);
+	return ret;
+}
+EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
+
+/**
+ * pci_acpi_add_perst_assertion_delay - Request PERST delay via ACPI DSM
+ * @dev: PCI device instance
+ * @delay_us: Requested delay_us
+ *
+ * This function sends a request to the host BIOS via ACPI _DSM to grant the required
+ * PERST dealy for the specified PCI device. It evaluates the _DSM (Device
+ * Specific Method) to request the PERST delay and handles the response accordingly.
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
+	if (!dev || !ACPI_HANDLE(&dev->dev))
+		return -EINVAL;
+
+	handle = ACPI_HANDLE(&dev->dev);
+
+	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
+					  DSM_PCI_PERST_ASSERTION_DELAY, &in_obj, ACPI_TYPE_INTEGER);
+	if (!out_obj)
+		return -EINVAL;
+
+	result = out_obj->integer.value;
+
+	if (result == delay_us) {
+		dev_info(&dev->dev, "PERST# Assertion Delay set to %u microseconds.\n", delay_us);
+		ret = 0;
+	} else if (result == 0) {
+		dev_warn(&dev->dev, "PERST# Assertion Delay request failed, no previous valid request.\n");
+	} else {
+		dev_warn(&dev->dev,
+			 "PERST# Assertion Delay request failed. Previous valid delay: %u microseconds.\n", result);
+	}
+
+	ACPI_FREE(out_obj);
+	return ret;
+}
+EXPORT_SYMBOL(pci_acpi_add_perst_assertion_delay);
+
 static void pci_acpi_set_external_facing(struct pci_dev *dev)
 {
 	u8 val;
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 078225b514d4..4b7373f91a9a 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -121,6 +121,8 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_DEVICE_NAME			0x07
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
+#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
+#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
@@ -132,10 +134,21 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power);
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
+int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
+{
+	return -EOPNOTSUPP;
+}
+
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.34.1


