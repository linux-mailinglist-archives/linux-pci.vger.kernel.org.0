Return-Path: <linux-pci+bounces-25075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B704FA77F17
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3199188F2C9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA820B7FE;
	Tue,  1 Apr 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mR2yX8iI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BA420AF77;
	Tue,  1 Apr 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743521785; cv=none; b=LpjeDgR2jCHghPR4myM9iQLjGOLRiR+JQf4wD+FeQSvsyRgJSdG9VlHqWKPUOm5Sx7X1VXxbFmqH1dRuCiHlI7V02HEUq3ZXoBrwzBrL3GWP5TlwXJzlRM9H90sG7MLfUxvth0vshtX2G+3vrY1KV0DoU0aog5B+lojSqe9HoX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743521785; c=relaxed/simple;
	bh=46JUgl+6vaQPaPwaARcd8Y1Jg6gjnPnlcycQ5y7QLZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REOYxrsaai+9KwGFWU4K/Oqe5xkjL8C8YWiwDE7b0H2ubE5hkzd6ie8j+gvLg910A0+/Dn9nnmafwruQ1iJdG+FTOnVp+Ar5t6m5tWWUyysx9T/d1YDHKDFEbp1UNdsE2DtQhKUQDlY6NTFdMG1Cw6fn2wp+T9SmV+4X65STYiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mR2yX8iI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743521784; x=1775057784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=46JUgl+6vaQPaPwaARcd8Y1Jg6gjnPnlcycQ5y7QLZQ=;
  b=mR2yX8iId9TxaBwGlG6bHXmxnCSC+4epFxfHLRCiKY5q6cdGZTnT/rG2
   WYKOd/fPELFWfhGnliZuoYJbzcAyfY+dDiJ7FDVkW4CjD3roWiHD3fe9K
   CV/uleclv+HI2UBZJXLSgVnwxQahR2HYMzN2m7R9Y68SIxaWMToJpuwRq
   hpxRnNyrA6NFrP2ffV1h5Gdai61YDA6wQGD6nwii/WYvKO2R3DsLhsgfa
   oc0K5e7WzAxOUv9XhWH5MVs3acNOF45j00e11uuv2ZJMhArDEFzE/yqzI
   54bvfkDvIdVBsF9hdB1HFUo9VW3F+nqcMoFR77YKNZ5OvQALJXiFf0GKC
   w==;
X-CSE-ConnectionGUID: //cRqAfiTlm36NZl+kUmZA==
X-CSE-MsgGUID: 4xgTNBR+StyVpvSDeniFMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="67324793"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="67324793"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:11 -0700
X-CSE-ConnectionGUID: etIrAIWtRnijZgdupovB6g==
X-CSE-MsgGUID: jjcCTox1SyWZWOgMsdAKdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; 
   d="scan'208";a="126410769"
Received: from anshuma1-desk.iind.intel.com ([10.190.239.112])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 08:36:08 -0700
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
Subject: [PATCH 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Date: Tue,  1 Apr 2025 21:02:15 +0530
Message-ID: <20250401153225.96379-3-anshuman.gupta@intel.com>
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

Implement _DSM Method 11 as per PCI firmware specs
section 4.6.11 Rev 3.3.

Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
 drivers/pci/pci-acpi.c   | 53 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  7 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index ebd49e43457e..04149f037664 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1499,6 +1499,59 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
 }
 EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
 
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
+	if (!dev || !ACPI_HANDLE(&dev->dev))
+		return -EINVAL;
+
+	handle = ACPI_HANDLE(&dev->dev);
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
+		dev_info(&dev->dev, "PERST# Assertion Delay set to"
+			 "%u microseconds\n", delay_us);
+		ret = 0;
+	} else if (result == 0) {
+		dev_warn(&dev->dev, "PERST# Assertion Delay request failed,"
+			 "no previous valid request\n");
+	} else {
+		dev_warn(&dev->dev,
+			 "PERST# Assertion Delay request failed"
+			 "Previous valid delay: %u microseconds\n", result);
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
index dbc4b0ed433c..4b7373f91a9a 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
 #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
 #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
 #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
+#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
 
 #ifdef CONFIG_PCIE_EDR
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
@@ -134,6 +135,7 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
 int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
 void pci_acpi_clear_companion_lookup_hook(void);
 int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power);
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
@@ -142,6 +144,11 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
 {
 	return -EOPNOTSUPP;
 }
+
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.43.0


