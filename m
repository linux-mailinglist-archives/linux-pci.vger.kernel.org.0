Return-Path: <linux-pci+bounces-38166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CECBDD491
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 10:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E57420AA8
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1D1238176;
	Wed, 15 Oct 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T58WFd29"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0980B248893;
	Wed, 15 Oct 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515358; cv=none; b=TNhFBE/++QvGYc17lRlRFY+gSQvdheW4NJGO5U3/vmkLxaIGNOHG6Iw/glRFsZBMybJQrFU8fwn0PEFndvHDVpEUBZxGztcB1vawy+aq61Iuzxsv/HLJB6XZvOnP3Pgw7Y8S6FhfsAlrWg2+fQLE7DiuvoGmRtQJDC6c7ZQSZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515358; c=relaxed/simple;
	bh=dNRxtWySpLibrKPkWySj76he1Hl9+a7V5AisItSqoz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aD30h5bL65iQKMtPiKQfccwhXi4MOE+jY6PCrn7cGR3lBnllUCjJQDgLPQHglvY0Y8aI/FOWiu6k+bMeKXeM+J+v/8abdll4lhyRObui1MGosRDmY/Sp/LBslvVYFgYMmMkoH882qpizxEw5to1bNnUcDY/Q6P1RTqiGjvWWfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T58WFd29; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515357; x=1792051357;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dNRxtWySpLibrKPkWySj76he1Hl9+a7V5AisItSqoz4=;
  b=T58WFd29rsEaDHBATyuQLhA6/o5ai9y5tV+UiuZ9gPWEFLkXpPrWUX5k
   mJguqhNgQr5CxCdbg2gFyEkno18Hv38YOhPYTCQfs/Fxl95cIb6kYUeVd
   F/g1qu1VHuYm/L+NTvTef4NmzqrNOHvV20ZXlBmtajr1d3G7qyiiDt2XD
   XtnRz30GP67Y1HyE2q/wAqKxqXdGC4srHtAbTs9fKiPYpUzNt0LD/O/vN
   oV0uwV2BQvyzRRDVkKawdcedtzcKycBjW2Ksk6WP78n/gxCdZThySVyWh
   MYluJZ4j14tqOz8i1uBYaLGfwXx/PEBncOLL/7FK0q4xsdR8AaU3qVLkc
   g==;
X-CSE-ConnectionGUID: tIfvfMUpTLqLmyMTl2cgnw==
X-CSE-MsgGUID: oFjVhbdnQtO0q5iRuQsqIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="61891462"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="61891462"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:37 -0700
X-CSE-ConnectionGUID: snpCK1oBQzuhTxSjR+Vc9w==
X-CSE-MsgGUID: sgH4KkcaRbeWQSOK+r/+kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="205805373"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:33 -0700
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
Subject: [PATCH v5 03/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Date: Wed, 15 Oct 2025 13:37:01 +0530
Message-Id: <20251015080710.1468409-4-badal.nilawar@intel.com>
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

Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10.

Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
V2:
 - Call acpi_check_dsm() to find method 0Bh supported
V3(Kappuswamy/Rafael):
 - %s/pci_warn/pci_info/ when PERST# Assertion Delay request fails
---
 drivers/pci/pci-acpi.c   | 53 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  9 ++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 74f118016b1d..230077200ce8 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1554,6 +1554,59 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
 }
 EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
 
+/**
+ * pci_acpi_add_perst_assertion_delay - Request PERST# Delay via ACPI DSM
+ * @dev: PCI device instance
+ * @delay_us: Requested delay_us
+ *
+ * Request PERST# Assertion Delay to platform firmware, via Root Port/
+ * Switch Downstream Port ACPI _DSM Function 0Bh, for the specified
+ * PCI device.
+ * Evaluate the _DSM and handle the response accordingly.
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
+	int result, ret = -EINVAL;
+	struct pci_dev *bdev;
+
+	if (!dev)
+		return -EINVAL;
+
+	bdev = pci_acpi_check_dsm(dev, 4, 1 << DSM_PCI_PERST_ASSERTION_DELAY);
+
+	if (IS_ERR(bdev))
+		return PTR_ERR(bdev);
+
+	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
+					  &pci_acpi_dsm_guid, 4,
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
+	} else {
+		pci_info(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
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
index ba48e7ddb360..4d8b8cea019e 100644
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
 int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
 				      u32 *retry_interval);
-
+int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
@@ -145,6 +146,12 @@ static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev,
+						     u32 delay_us)
+{
+	return -EOPNOTSUPP;
+}
 #endif	/* CONFIG_ACPI */
 
 #endif	/* _PCI_ACPI_H_ */
-- 
2.34.1


