Return-Path: <linux-pci+bounces-25077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E786CA77F20
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5A23A6385
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473FE20B80D;
	Tue,  1 Apr 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cSy7w69S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861E20B7EA;
	Tue,  1 Apr 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521787; cv=none; b=WZc7K2wRFrDnzSNDKPx8jXA5szlbN+nvhvkZtMSVhTo4pHtjc1hGBs5/WwdP51t97DPmKqc0kJrgPzlmWoHNdAIRlzR81Hx4ufrEE/cQeKzp3MVZA8yCxpNT8C3DKBoQfUj9GYKI1+bY2jEQYfrtmrhPJTUi1fiS/CEIfuIxT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521787; c=relaxed/simple;
	bh=AJWExx/lhsVKyDjZNNUh1i5V9rLOaQaDVOBlExnNiiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLD3gUiP77CEM2LfJD1d3m+MiJK1I5DRCmAPNF4wIiexhRGF5xwBEIKxYxYjwyswIExdBabB5iqt2A524TZq1A6fua2YziCAXSpCgNPmuM3yP0bCCGv5QCVFJUuaQzfB6CbapHi4n8uWWT2RQOQMQDqyL4oDj65hiW0+6pBZKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cSy7w69S; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521786; x=1775057786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AJWExx/lhsVKyDjZNNUh1i5V9rLOaQaDVOBlExnNiiI=;
  b=cSy7w69S6dBFG3qhhaeaTXX9tLMBuV+8HepLFdhDeA8JG3y3pB4djDyZ
   wg5cqWWji9SB2DWMNQJo+oZmHPymUsUFlRh47E7j+9ew6MBhBcMS4lNZj
   u1a0rgJVq3y2RA2/nw2rFauI2h/uQ+Nl+fL1HbZpX/5qkgd+734CUtM+U
   WYDFz+Oky/ePKnONKMy24RoEJUrot6Us9sdV8vQyZ2ZUzDjCEP+5FdkFr
   Ho3X0iVjb4VYtTZw1sIk67zeAAPlYoooGtVoVfrox4Hqpo5to2Q6PG96r
   I2ivVS3opmf4VYQtDDn2nv3lLWHCuZOe2BZBX8HRYrF1ydIExD0qNf/Xe
   w==;
X-CSE-ConnectionGUID: n6yKgbJPRyu/FO6Mk6EB0A==
X-CSE-MsgGUID: rCGSk8bcQD60GnfT+YUH3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324811"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324811"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:16 -0700
X-CSE-ConnectionGUID: RSa7Q1WpQxm3car1WNtayw==
X-CSE-MsgGUID: 0JLK/ni1TCyRpmHZEfJr6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410797"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:12 -0700
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
	anshuman.gupta@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com
Subject: [PATCH 03/12] PCI/ACPI: Add aux power grant notifier
Date: Tue,  1 Apr 2025 21:02:16 +0530
Message-ID: <20250401153225.96379-4-anshuman.gupta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401153225.96379-1-anshuman.gupta@intel.com>
References: <20250401153225.96379-1-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding a notifier to notify all PCIe child devices about the
block main power removal. It is needed because theoretically
multiple PCIe Endpoint devices on same Root Port
can request for AUX power and _DSM method can return with
80000000h signifies that the hierarchy connected via
the slot cannot support main power removal when in D3Cold.
This may disrupt functionality of other child device.

Let's notify all PCIe devices requested Aux power resource
and Let PCIe End Point driver handle it in its callback.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/pci/pci-acpi.c   | 34 +++++++++++++++++++++++++++++++---
 include/linux/pci-acpi.h | 13 +++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 04149f037664..d1ca1649e6e8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1421,6 +1421,32 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+static BLOCKING_NOTIFIER_HEAD(pci_acpi_aux_power_notify_list);
+
+/**
+ * pci_acpi_register_aux_power_notifier - Register driver notifier
+ * @nb: notifier block
+ *
+ * This function shall be called by PCIe End Point device requested the Aux
+ * power resource in order to handle the any scenario gracefully when other
+ * child PCIe devices Aux power request returns with No main power removal.
+ * PCIe devices which register this notifier shall handle No main power
+ * removal scenario accordingly.
+ *
+ * Return: Returns 0 on success and errno on failure.
+ */
+int pci_acpi_register_aux_power_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&pci_acpi_aux_power_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(pci_acpi_register_aux_power_notifier);
+
+void pci_acpi_unregister_aux_power_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&pci_acpi_aux_power_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(pci_acpi_unregister_aux_power_notifier);
+
 /**
  * pci_acpi_request_d3cold_aux_power - Request D3cold aux power via ACPI DSM
  * @dev: PCI device instance
@@ -1466,17 +1492,19 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
 	result = out_obj->integer.value;
 
 	switch (result) {
-	case 0x0:
+	case ACPI_AUX_PW_DENIED:
 		dev_dbg(&dev->dev, "D3cold Aux Power %umW request denied\n",
 			requested_power);
 		break;
-	case 0x1:
+	case ACPI_AUX_PW_GRANTED:
 		dev_info(&dev->dev, "D3cold Aux Power request granted: %umW\n",
 			 requested_power);
 		ret = 0;
 		break;
-	case 0x2:
+	case ACPI_NO_MAIN_PW_REMOVAL:
 		dev_info(&dev->dev, "D3cold Aux Power: Main power won't be removed\n");
+		blocking_notifier_call_chain(&pci_acpi_aux_power_notify_list,
+					     ACPI_NO_MAIN_PW_REMOVAL, dev);
 		ret = -EBUSY;
 		break;
 	default:
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 4b7373f91a9a..793b979af98b 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -124,6 +124,10 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
 #define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
 
+#define ACPI_AUX_PW_DENIED			0x0
+#define ACPI_AUX_PW_GRANTED			0x1
+#define ACPI_NO_MAIN_PW_REMOVAL			0x2
+
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
 void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
@@ -134,12 +138,21 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
+int pci_acpi_register_aux_power_notifier(struct notifier_block *nb);
+void pci_acpi_unregister_aux_power_notifier(struct notifier_block *nb);
 int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power);
 int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
+int pci_acpi_register_aux_power_notifier(struct notifier_block *nb)
+{
+	return -EOPNOTSUPP;
+}
+
+void pci_acpi_unregister_aux_power_notifier(struct notifier_block *nb) { }
+
 int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


