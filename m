Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7283EF5DB
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbhHQWnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 18:43:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:15594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235605AbhHQWnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 18:43:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215940910"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="215940910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="573066692"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2021 15:42:46 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 7FEB65808DB;
        Tue, 17 Aug 2021 15:42:46 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 2/5] MFD: intel_pmt: Support non-PMT capabilities
Date:   Tue, 17 Aug 2021 15:40:15 -0700
Message-Id: <20210817224018.1013192-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817224018.1013192-1-david.e.box@linux.intel.com>
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel Platform Monitoring Technology (PMT) support is indicated by presence
of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
structures may also be used by Intel to indicate support for other
capabilities unrelated to PMT.  OOBMSM is a device that can have both PMT
and non-PMT capabilities. In order to support these capabilities it is
necessary to modify the intel_pmt driver to handle the creation of platform
devices more generically.

Currently PMT devices are named by their capability (e.g. pmt_telemetry).
Instead, generically name them by their capability ID (e.g.
intel-extended-cap-2). This allows the IDs to be created automatically,
minimizing the code needed to support future capabilities. However, to
ensure that unsupported devices aren't created, use an allow list to
specify supported capabilities.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2:	MFD changes implemented in intel_pmt.c instead of new driver.

 drivers/mfd/intel_pmt.c                    | 95 ++++++++++++++--------
 drivers/platform/x86/intel/pmt/crashlog.c  |  2 +-
 drivers/platform/x86/intel/pmt/telemetry.c |  2 +-
 3 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index dd7eb614c28e..08cd3357577e 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -27,9 +27,18 @@
 #define INTEL_DVSEC_ENTRY_SIZE		4
 
 /* PMT capabilities */
-#define DVSEC_INTEL_ID_TELEMETRY	2
-#define DVSEC_INTEL_ID_WATCHER		3
-#define DVSEC_INTEL_ID_CRASHLOG		4
+#define INTEL_EXT_CAP_ID_TELEMETRY	2
+#define INTEL_EXT_CAP_ID_WATCHER	3
+#define INTEL_EXT_CAP_ID_CRASHLOG	4
+
+#define INTEL_EXT_CAP_PREFIX		"intel_extnd_cap"
+#define FEATURE_ID_NAME_LENGTH		25
+
+static int intel_ext_cap_allow_list[] = {
+	INTEL_EXT_CAP_ID_TELEMETRY,
+	INTEL_EXT_CAP_ID_WATCHER,
+	INTEL_EXT_CAP_ID_CRASHLOG,
+};
 
 struct intel_dvsec_header {
 	u16	length;
@@ -84,42 +93,58 @@ static const struct pmt_platform_info dg1_info = {
 	.capabilities = dg1_capabilities,
 };
 
-static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
-		       unsigned long quirks)
+static bool intel_ext_cap_allowed(u16 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(intel_ext_cap_allow_list); i++)
+		if (intel_ext_cap_allow_list[i] == id)
+			return true;
+
+	return false;
+}
+
+static bool intel_ext_cap_disabled(u16 id, unsigned long quirks)
+{
+	switch (id) {
+	case INTEL_EXT_CAP_ID_WATCHER:
+		return !!(quirks & PMT_QUIRK_NO_WATCHER);
+
+	case INTEL_EXT_CAP_ID_CRASHLOG:
+		return !!(quirks & PMT_QUIRK_NO_CRASHLOG);
+
+	default:
+		return false;
+	}
+}
+
+static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
+				 unsigned long quirks)
 {
 	struct device *dev = &pdev->dev;
 	struct resource *res, *tmp;
 	struct mfd_cell *cell;
-	const char *name;
+	char feature_id_name[FEATURE_ID_NAME_LENGTH];
 	int count = header->num_entries;
 	int size = header->entry_size;
 	int id = header->id;
 	int i;
 
-	switch (id) {
-	case DVSEC_INTEL_ID_TELEMETRY:
-		name = "pmt_telemetry";
-		break;
-	case DVSEC_INTEL_ID_WATCHER:
-		if (quirks & PMT_QUIRK_NO_WATCHER) {
-			dev_info(dev, "Watcher not supported\n");
-			return -EINVAL;
-		}
-		name = "pmt_watcher";
-		break;
-	case DVSEC_INTEL_ID_CRASHLOG:
-		if (quirks & PMT_QUIRK_NO_CRASHLOG) {
-			dev_info(dev, "Crashlog not supported\n");
-			return -EINVAL;
-		}
-		name = "pmt_crashlog";
-		break;
-	default:
+	if (!intel_ext_cap_allowed(id))
+		return -EINVAL;
+
+	if (intel_ext_cap_disabled(id, quirks))
+		return -EINVAL;
+
+	snprintf(feature_id_name, sizeof(feature_id_name), "%s_%d", INTEL_EXT_CAP_PREFIX, id);
+
+	if (!header->num_entries) {
+		dev_err(dev, "Invalid 0 entry count for %s header\n", feature_id_name);
 		return -EINVAL;
 	}
 
-	if (!header->num_entries || !header->entry_size) {
-		dev_err(dev, "Invalid count or size for %s header\n", name);
+	if (!header->entry_size) {
+		dev_err(dev, "Invalid 0 entry size for %s header\n", feature_id_name);
 		return -EINVAL;
 	}
 
@@ -135,26 +160,26 @@ static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
 		header->offset >>= 3;
 
 	/*
-	 * The PMT DVSEC contains the starting offset and count for a block of
+	 * The DVSEC contains the starting offset and count for a block of
 	 * discovery tables, each providing access to monitoring facilities for
 	 * a section of the device. Create a resource list of these tables to
 	 * provide to the driver.
 	 */
 	for (i = 0, tmp = res; i < count; i++, tmp++) {
 		tmp->start = pdev->resource[header->tbir].start +
-			     header->offset + i * (size << 2);
-		tmp->end = tmp->start + (size << 2) - 1;
+			     header->offset + i * (size * sizeof(u32));
+		tmp->end = tmp->start + (size * sizeof(u32)) - 1;
 		tmp->flags = IORESOURCE_MEM;
 	}
 
 	cell->resources = res;
 	cell->num_resources = count;
-	cell->name = name;
+	cell->name = feature_id_name;
 
-	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1, NULL, 0,
-				    NULL);
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1, NULL, 0, NULL);
 }
 
+
 static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pmt_platform_info *info;
@@ -176,7 +201,7 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 		header = info->capabilities;
 		while (*header) {
-			ret = pmt_add_dev(pdev, *header, quirks);
+			ret = intel_ext_cap_add_dev(pdev, *header, quirks);
 			if (ret)
 				dev_warn(&pdev->dev,
 					 "Failed to add device for DVSEC id %d\n",
@@ -212,7 +237,7 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			header.tbir = INTEL_DVSEC_TABLE_BAR(table);
 			header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
 
-			ret = pmt_add_dev(pdev, &header, quirks);
+			ret = intel_ext_cap_add_dev(pdev, &header, quirks);
 			if (ret)
 				continue;
 
diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index 1c1021f04d3c..86c4b016af59 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -17,7 +17,7 @@
 
 #include "class.h"
 
-#define DRV_NAME		"pmt_crashlog"
+#define DRV_NAME		"intel_extnd_cap_4"
 
 /* Crashlog discovery header types */
 #define CRASH_TYPE_OOBMSM	1
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index a58843360fbf..3559f6e7b388 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -17,7 +17,7 @@
 
 #include "class.h"
 
-#define TELEM_DEV_NAME		"pmt_telemetry"
+#define TELEM_DEV_NAME		"intel_extnd_cap_2"
 
 #define TELEM_SIZE_OFFSET	0x0
 #define TELEM_GUID_OFFSET	0x4
-- 
2.25.1

