Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083BD3ABE75
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 23:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhFQV5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 17:57:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:16700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231474AbhFQV5u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 17:57:50 -0400
IronPort-SDR: NEeFg25bXG5PX5/vKnnK3CEvjCseNoh2eQ7phqAo89Rn09asn76q24fSKuhYXwizUK0aIbxP9D
 +HH4K/B8hthw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270304155"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="270304155"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:55:41 -0700
IronPort-SDR: 6ZHkDpGlx3WOn7uW+LShkGAYsoxClCtz1c8DC6jJ2sPs1sryqVMZoFaktpayaobN/Dsw27577J
 AsJSvaZ63O1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="488810897"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2021 14:55:41 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id EC13C580224;
        Thu, 17 Jun 2021 14:55:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 4/4] MFD: intel-extended-cap: Add support for PCIe VSEC structures
Date:   Thu, 17 Jun 2021 14:54:08 -0700
Message-Id: <20210617215408.1412409-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617215408.1412409-1-david.e.box@linux.intel.com>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds support for discovering Intel extended capability features from
Vendor Specific Extended Capability (VSEC) registers in PCIe config space.
While doing so place the existing DVSEC and new VSEC code in separate
functions.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/mfd/intel_extended_caps.c | 159 ++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 50 deletions(-)

diff --git a/drivers/mfd/intel_extended_caps.c b/drivers/mfd/intel_extended_caps.c
index 89cf1ae6f65b..9b60defda856 100644
--- a/drivers/mfd/intel_extended_caps.c
+++ b/drivers/mfd/intel_extended_caps.c
@@ -105,7 +105,7 @@ static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_ext_cap_head
 		header->offset >>= 3;
 
 	/*
-	 * The DVSEC contains the starting offset and count for a block of
+	 * The DVSEC/VSEC contains the starting offset and count for a block of
 	 * discovery tables, each providing access to monitoring facilities for
 	 * a section of the device. Create a resource list of these tables to
 	 * provide to the driver.
@@ -124,11 +124,112 @@ static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_ext_cap_head
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
+
 int intel_ext_cap_probe(struct pci_dev *pdev, struct intel_ext_cap_platform_info *info)
 {
 	unsigned long quirks = 0;
-	bool found_devices = false;
-	int ret, pos;
+	int device_count = 0;
+	int ret;
 
 	if (info)
 		quirks = info->quirks;
@@ -144,59 +245,17 @@ int intel_ext_cap_probe(struct pci_dev *pdev, struct intel_ext_cap_platform_info
 					 "Failed to add device for DVSEC id %d\n",
 					 (*header)->id);
 			else
-				found_devices = true;
+				device_count++;
 
 			header++;
 		}
-	} else {
-		/* Find DVSEC features */
-		pos = 0;
-		do {
-			struct intel_ext_cap_header header;
-			u32 table, hdr;
-			u16 vid;
-
-			pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
-			if (!pos)
-				break;
-
-			pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER1, &hdr);
-			vid = PCI_DVSEC_HEADER1_VID(hdr);
-			if (vid != PCI_VENDOR_ID_INTEL)
-				continue;
-
-			/* Support only revision 1 */
-			header.rev = PCI_DVSEC_HEADER1_REV(hdr);
-			if (header.rev != 1) {
-				dev_warn(&pdev->dev, "Unsupported DVSEC revision %d\n",
-					 header.rev);
-				continue;
-			}
-
-			header.length = PCI_DVSEC_HEADER1_LEN(hdr);
-
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
-			pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
-			header.id = PCI_DVSEC_HEADER2_ID(hdr);
-
-			ret = intel_ext_cap_add_dev(pdev, &header, quirks);
-			if (ret)
-				continue;
 
-			found_devices = true;
-		} while (true);
+	} else {
+		device_count += intel_ext_cap_walk_dvsec(pdev, quirks);
+		device_count += intel_ext_cap_walk_vsec(pdev, quirks);
 	}
 
-	if (!found_devices)
+	if (!device_count)
 		return -ENODEV;
 
 	return 0;
-- 
2.25.1

