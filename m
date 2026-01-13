Return-Path: <linux-pci+bounces-44632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF60D1A4F6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01DAA30734EB
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C730AAC9;
	Tue, 13 Jan 2026 16:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUQCrZH6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293163093BB;
	Tue, 13 Jan 2026 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321928; cv=none; b=PzNhtfy7LxJp/a4G9BDHatAx0IW54KiwUSYq3KrsXu6VC4KYX4nUvznY/v7p+EJDDU7kmYAo042tgwumzWbTdB4yyYoE5q4iMkZDBZEkya+na8EhfNGg4L+kkXJpsnP37Pc3ZqOii3TqPnbD7NH4XXltDPSov7av0ol9cq+QOCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321928; c=relaxed/simple;
	bh=JCDcpEwXSkcksxWw7gSXLwgP4YIv9jpvViSWIWG2LmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhVYOvBEODvz6Oz3f/Cl/GrY+GTDyvZfwmbi5/S8xW0n66Jty+zvE9E1SrkB8WqjKNRtk/bjd4HhfmdsmdBCP4oL9NDWUxhm1KlSECcpY350aIbxBkrL8Ckf9+RhWsT4HicsCcPyRfgeja26oG+3L5h2X5SI6E6Jo1ciOsrz4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUQCrZH6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321927; x=1799857927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JCDcpEwXSkcksxWw7gSXLwgP4YIv9jpvViSWIWG2LmI=;
  b=KUQCrZH6clES70NeqI8StNs3OXasuHt87126/Q3j+zCCg+Q5WB/PMp/R
   ArToxQcxhK/I0/Gk8azOcEoVRUTZNBKvdN3LclSXA14tHBgGPrMlrX+T6
   d6bf4avGOvL3vNzH1cd1Aww953DqyGbe6JmW2KhSIxlYw4NokpQzhu5o5
   KizXQK4t4h0f1g0CDPbxGPjlyZ2FYIJbmapCTTA4IoRsIlnZb0DPLqSuJ
   TXPJpAoJQlCVUJh4MGpiaq/PJ739F+kLnDPnhTg6oM8iQmIIDoNuTBgPz
   VEuQGxj6NIwGbHY1BIQ8pKrY6o7pjhIH/ry9lJnrQxxM2F/qUI6aWVCV6
   A==;
X-CSE-ConnectionGUID: MQ2nGibCTPyjrjQ8WIjCZQ==
X-CSE-MsgGUID: D3FDj5HCSUGACronIV69Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69521002"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69521002"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:07 -0800
X-CSE-ConnectionGUID: 3Ffs4sxTSimV0n5rzGSdHg==
X-CSE-MsgGUID: 4ilgcgxiTGKA3TwUw4e0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060116"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:02 -0800
From: Badal Nilawar <badal.nilawar@intel.com>
To: intel-xe@lists.freedesktop.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	varun.gupta@intel.com,
	ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	karthik.poosa@intel.com,
	matthew.auld@intel.com,
	sk.anirban@intel.com,
	raag.jadav@intel.com
Subject: [PATCH v6 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Date: Tue, 13 Jan 2026 22:12:03 +0530
Message-ID: <20260113164200.1151788-16-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113164200.1151788-14-badal.nilawar@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anshuman Gupta <anshuman.gupta@intel.com>

Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10, to request
fixed delay in timing between the time the PME_TO_Ack message is received
at the PCI Express Downstream Port that originated the PME_Turn_Off
message, and the time the platform asserts PERST# to the slot during the
corresponding Endpoint’s or PCI Express Upstream Port’s transition to
D3cold while the system is in an ACPI operational state.
Host platform supporting this feature ensures that device is observing
this delay in every applicable D3Cold transition.

Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
---
For VRSR feature with PERST# Assertion delay device will get enough time
to transition to auxiliary power before main power removal.
---
 drivers/pci/pci-acpi.c   | 60 ++++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |  9 +++++-
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 645d3005ba50..73eaee20a270 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1554,6 +1554,66 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
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
+	acpi_handle handle;
+
+	if (!dev)
+		return -EINVAL;
+
+	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {
+		handle = ACPI_HANDLE(&bdev->dev);
+		if (handle &&
+		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
+				   1 << DSM_PCI_PERST_ASSERTION_DELAY))
+			break;
+	}
+
+	if (!bdev)
+		return -ENODEV;
+
+	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
+					  &pci_acpi_dsm_guid, 4,
+					  DSM_PCI_PERST_ASSERTION_DELAY,
+					  &in_obj, ACPI_TYPE_INTEGER);
+	if (!out_obj)
+		return -EINVAL;
+
+	result = out_obj->integer.value;
+	ACPI_FREE(out_obj);
+
+	if (result == delay_us) {
+		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
+		ret = 0;
+	} else {
+		pci_info(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
+			 result);
+	}
+
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
2.52.0


