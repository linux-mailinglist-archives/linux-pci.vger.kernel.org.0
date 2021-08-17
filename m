Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF383EF5D7
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 00:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236185AbhHQWnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 18:43:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:15594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235920AbhHQWnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 18:43:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215940912"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="215940912"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="573066695"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2021 15:42:46 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 9248C580871;
        Tue, 17 Aug 2021 15:42:46 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/5] MFD: intel_pmt: Add support for PCIe VSEC structures
Date:   Tue, 17 Aug 2021 15:40:16 -0700
Message-Id: <20210817224018.1013192-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817224018.1013192-1-david.e.box@linux.intel.com>
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds support for discovering Intel extended capability features from
Vendor Specific Extended Capability (VSEC) registers in PCIe config space.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2:	Implemented in intel_pmt.c instead new file.

 drivers/mfd/intel_pmt.c | 158 +++++++++++++++++++++++++++++-----------
 1 file changed, 115 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index 08cd3357577e..08e07b31aeec 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -40,7 +40,8 @@ static int intel_ext_cap_allow_list[] = {
 	INTEL_EXT_CAP_ID_CRASHLOG,
 };
 
-struct intel_dvsec_header {
+struct intel_ext_cap_header {
+	u8	rev;
 	u16	length;
 	u16	id;
 	u8	num_entries;
@@ -65,7 +66,7 @@ enum pmt_quirks {
 
 struct pmt_platform_info {
 	unsigned long quirks;
-	struct intel_dvsec_header **capabilities;
+	struct intel_ext_cap_header **capabilities;
 };
 
 static const struct pmt_platform_info tgl_info = {
@@ -74,7 +75,7 @@ static const struct pmt_platform_info tgl_info = {
 };
 
 /* DG1 Platform with DVSEC quirk*/
-static struct intel_dvsec_header dg1_telemetry = {
+static struct intel_ext_cap_header dg1_telemetry = {
 	.length = 0x10,
 	.id = 2,
 	.num_entries = 1,
@@ -83,7 +84,7 @@ static struct intel_dvsec_header dg1_telemetry = {
 	.offset = 0x466000,
 };
 
-static struct intel_dvsec_header *dg1_capabilities[] = {
+static struct intel_ext_cap_header *dg1_capabilities[] = {
 	&dg1_telemetry,
 	NULL
 };
@@ -118,7 +119,7 @@ static bool intel_ext_cap_disabled(u16 id, unsigned long quirks)
 	}
 }
 
-static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
+static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_ext_cap_header *header,
 				 unsigned long quirks)
 {
 	struct device *dev = &pdev->dev;
@@ -160,7 +161,7 @@ static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_dvsec_header
 		header->offset >>= 3;
 
 	/*
-	 * The DVSEC contains the starting offset and count for a block of
+	 * The DVSEC/VSEC contains the starting offset and count for a block of
 	 * discovery tables, each providing access to monitoring facilities for
 	 * a section of the device. Create a resource list of these tables to
 	 * provide to the driver.
@@ -179,13 +180,113 @@ static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_dvsec_header
 	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1, NULL, 0, NULL);
 }
 
+static bool intel_ext_cap_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
+{
+	int count = 0;
+	int pos = 0;
+
+	do {
+		struct intel_ext_cap_header header;
+		u32 table, hdr;
+		u16 vid;
+		int ret;
+
+		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
+		if (!pos)
+			break;
+
+		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER1, &hdr);
+		vid = PCI_DVSEC_HEADER1_VID(hdr);
+		if (vid != PCI_VENDOR_ID_INTEL)
+			continue;
+
+		/* Support only revision 1 */
+		header.rev = PCI_DVSEC_HEADER1_REV(hdr);
+		if (header.rev != 1) {
+			dev_warn(&pdev->dev, "Unsupported DVSEC revision %d\n",
+				 header.rev);
+			continue;
+		}
+
+		header.length = PCI_DVSEC_HEADER1_LEN(hdr);
+
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
+				     &header.num_entries);
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
+				     &header.entry_size);
+		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
+				      &table);
+
+		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+
+		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
+		header.id = PCI_DVSEC_HEADER2_ID(hdr);
+
+		ret = intel_ext_cap_add_dev(pdev, &header, quirks);
+		if (ret)
+			continue;
+
+		count++;
+	} while (true);
+
+	return count;
+}
+
+static bool intel_ext_cap_walk_vsec(struct pci_dev *pdev, unsigned long quirks)
+{
+	int count = 0;
+	int pos = 0;
+
+	do {
+		struct intel_ext_cap_header header;
+		u32 table, hdr;
+		int ret;
+
+		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_VNDR);
+		if (!pos)
+			break;
+
+		pci_read_config_dword(pdev, pos + PCI_VNDR_HEADER, &hdr);
+
+		/* Support only revision 1 */
+		header.rev = PCI_VNDR_HEADER_REV(hdr);
+		if (header.rev != 1) {
+			dev_warn(&pdev->dev, "Unsupported VSEC revision %d\n",
+				 header.rev);
+			continue;
+		}
+
+		header.id = PCI_VNDR_HEADER_ID(hdr);
+		header.length = PCI_VNDR_HEADER_LEN(hdr);
+
+		/* entry, size, and table offset are the same as DVSEC */
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
+				     &header.num_entries);
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
+				     &header.entry_size);
+		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
+				      &table);
+
+		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+
+		ret = intel_ext_cap_add_dev(pdev, &header, quirks);
+		if (ret)
+			continue;
+
+		count++;
+	} while (true);
+
+	return count;
+}
 
 static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pmt_platform_info *info;
 	unsigned long quirks = 0;
-	bool found_devices = false;
-	int ret, pos = 0;
+	int device_count = 0;
+	int ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -196,8 +297,11 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (info)
 		quirks = info->quirks;
 
+	device_count += intel_ext_cap_walk_dvsec(pdev, quirks);
+	device_count += intel_ext_cap_walk_vsec(pdev, quirks);
+
 	if (info && (info->quirks & PMT_QUIRK_NO_DVSEC)) {
-		struct intel_dvsec_header **header;
+		struct intel_ext_cap_header **header;
 
 		header = info->capabilities;
 		while (*header) {
@@ -207,45 +311,13 @@ static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 					 "Failed to add device for DVSEC id %d\n",
 					 (*header)->id);
 			else
-				found_devices = true;
+				device_count++;
 
 			++header;
 		}
-	} else {
-		do {
-			struct intel_dvsec_header header;
-			u32 table;
-			u16 vid;
-
-			pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
-			if (!pos)
-				break;
-
-			pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
-			if (vid != PCI_VENDOR_ID_INTEL)
-				continue;
-
-			pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2,
-					     &header.id);
-			pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
-					     &header.num_entries);
-			pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
-					     &header.entry_size);
-			pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
-					      &table);
-
-			header.tbir = INTEL_DVSEC_TABLE_BAR(table);
-			header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
-
-			ret = intel_ext_cap_add_dev(pdev, &header, quirks);
-			if (ret)
-				continue;
-
-			found_devices = true;
-		} while (true);
 	}
 
-	if (!found_devices)
+	if (!device_count)
 		return -ENODEV;
 
 	pm_runtime_put(&pdev->dev);
-- 
2.25.1

