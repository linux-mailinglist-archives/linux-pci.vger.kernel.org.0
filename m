Return-Path: <linux-pci+bounces-44631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBECD1A484
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F7FC3003FC3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC5F2DCC08;
	Tue, 13 Jan 2026 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WLIdmx7H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC033093BB;
	Tue, 13 Jan 2026 16:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321924; cv=none; b=A/Qpto2li4iFTDkDpq0ZRxuS6LqFwt84edpMs0jTxqzPnb47SqAZg9FNVxCNnbI5B9u6AGiWbhJj0PQWIqtuyKpdAnxmF3uLQ6O5WINYuojBO51pAKbYgHo6Uoanhst5vB9N4ZWoKDFoP1zyr5wr5zBO4tt8NSfdgS29l0YJtr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321924; c=relaxed/simple;
	bh=2ynAKcq4Vs/lBCn3G+wxF3Ly8bhHvu6+th+M/NpcBqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvzmfQJYV90zAv/9gqT67c6ewuQLEqn63W1P1fKnFSEGcaJmbNEqlOg2qzsEoyVohP/G9C+cLadtGafcyVoB+PwQrOYj1zRW16yPhrcciEwT8xKlxB5/73NwWlMDW6ygbHospDnMb0NvMMfKXm50a6pSUevvuoDlh+T+Qk64Wmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WLIdmx7H; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768321923; x=1799857923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ynAKcq4Vs/lBCn3G+wxF3Ly8bhHvu6+th+M/NpcBqw=;
  b=WLIdmx7HLFGwVWDQK8sXFDjIiorahrgeAVdoHePLo+d17n2XxyV6ziHy
   0CaKU+RUaph5r+W4WwWaAM0/6o9w53ELYFgTQHMTiBOrz7629E1wIJTm+
   8A3dgh9Cml9A2cUFoiebiPa6GdGWDSV687JNimw5LUm08Cvu/rpexbqvh
   iQgprInDn8PRstJmVzidUctuYSgoCgIpgnyqx49PfFm6C6e4Lw4XW9p/E
   5qgZKWV1Bu+o4Qn+zswAAXxh2LZwDInY7gFeCnuovpUT2wUiYt4plAKxJ
   6pHPm4FFeCgQigXbvXhhg0CxKNNGrTZgqAN4bW8QKOB/LgqFPP9TJFe8P
   w==;
X-CSE-ConnectionGUID: TP5x9+ehTr6gYPXYt1qRYA==
X-CSE-MsgGUID: EkQF/rjKRf+FkvC8qTLdXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69520992"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69520992"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:32:02 -0800
X-CSE-ConnectionGUID: 8BdwML9LSnCBscQPtVXkGw==
X-CSE-MsgGUID: nHp2r3+LQuKTKqXr0Z4IfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204060108"
Received: from bnilawar-desk2.iind.intel.com ([10.190.239.41])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 08:31:58 -0800
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
Subject: [PATCH v6 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Date: Tue, 13 Jan 2026 22:12:02 +0530
Message-ID: <20260113164200.1151788-15-badal.nilawar@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260113164200.1151788-14-badal.nilawar@intel.com>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
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

Implementation allows only a single device below the Downstream Port to
request for Aux Power Limit under a given Root Port/Downstream Port
because it does not track and aggregate requests from all child devices
below the Downstream Port as required by PCI Firmware r3.3, sec 4.6.10.

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
V5(Rafael)
  - Remove function 0 check and allow first caller of the given
    downstream port (with _DSM) to requst aux power including
    different function
  - Squash Patch v5.02 to this patch
  - In the logic, to allow single device to req power, use linked list
    instead of adding extra variables to acpi device structure
  - return positive code for no main power removal to distinguish from
    aux power request granted
---
 drivers/pci/pci-acpi.c   | 136 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-acpi.h |   9 +++
 2 files changed, 145 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 9369377725fa..645d3005ba50 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1418,6 +1418,142 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
 	ACPI_FREE(obj);
 }
 
+static LIST_HEAD(acpi_aux_pwr_list);
+static DEFINE_MUTEX(acpi_aux_pwr_lock);
+
+struct aux_pwr {
+	u32 aux_pwr_limit;		/* aux power limit granted by platform firmware */
+	struct device *dev;		/* device to which aux power is granted  */
+	struct acpi_device *adev;	/* root port/downstream port */
+	struct list_head list;
+};
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
+ * Return: 0 Aux power request granted
+ *	   1 No main power removal
+ *         errno on failure.
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
+	int result;
+	struct pci_dev *bdev;
+	struct acpi_device *adev;
+	acpi_handle handle;
+	struct aux_pwr *apwr, *next;
+
+	if (!dev)
+		return -EINVAL;
+
+	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {
+		handle = ACPI_HANDLE(&bdev->dev);
+		if (handle &&
+		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
+				   1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT))
+			break;
+	}
+
+	if (!bdev)
+		return -ENODEV;
+
+	adev = ACPI_COMPANION(&bdev->dev);
+	if (!adev)
+		return -EINVAL;
+
+	guard(mutex)(&acpi_aux_pwr_lock);
+	/* Check if aux power already granted to different device */
+	list_for_each_entry_safe(apwr, next, &acpi_aux_pwr_list, list) {
+		if (apwr->adev == adev && apwr->dev != &dev->dev) {
+			pci_info(to_pci_dev(apwr->dev),
+				 "D3cold Aux Power request already granted: %u mW\n",
+				 apwr->aux_pwr_limit);
+			return -EALREADY;
+		}
+		if (apwr->adev == adev && apwr->dev == &dev->dev) {
+			list_del(&apwr->list);
+			kfree(apwr);
+			break;
+		}
+	}
+
+	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
+					  &pci_acpi_dsm_guid, 4,
+					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
+					  &in_obj, ACPI_TYPE_INTEGER);
+	if (!out_obj)
+		return -EINVAL;
+
+	result = out_obj->integer.value;
+	ACPI_FREE(out_obj);
+
+	if (retry_interval)
+		*retry_interval = 0;
+
+	switch (result) {
+	case AUX_PWR_REQ_DENIED:
+		pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
+			requested_mw);
+		return -EINVAL;
+	case AUX_PWR_REQ_GRANTED:
+		pci_info(bdev, "D3cold Aux Power request granted: %u mW\n",
+			 requested_mw);
+		apwr = kzalloc(sizeof(*apwr), GFP_KERNEL);
+		if (apwr) {
+			apwr->aux_pwr_limit = requested_mw;
+			apwr->dev = &dev->dev;
+			apwr->adev = adev;
+			INIT_LIST_HEAD(&apwr->list);
+			list_add(&acpi_aux_pwr_list,
+				 &apwr->list);
+		}
+		return 0;
+	case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
+		pci_info(bdev, "D3cold Aux Power: Main power won't be removed\n");
+		return 2;
+	case AUX_PWR_REQ_RETRY_INTERVAL_MIN ... AUX_PWR_REQ_RETRY_INTERVAL_MAX:
+		pci_info(bdev, "D3cold Aux Power request needs retry, interval: %u seconds\n",
+			 result & 0xF);
+		if (retry_interval) {
+			*retry_interval = result & 0xF;
+			return -EAGAIN;
+		}
+		return -EINVAL;
+	default:
+		pci_err(bdev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
+			result);
+		return -EINVAL;
+	}
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
2.52.0


