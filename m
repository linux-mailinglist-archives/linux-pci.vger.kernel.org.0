Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A2641E5BF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 03:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbhJABaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 21:30:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:35040 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351280AbhJABaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 21:30:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="204811519"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="204811519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 18:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="656096298"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2021 18:28:16 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id A3001580A31;
        Thu, 30 Sep 2021 18:28:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/5] platform/x86/intel: extended_caps: Add support for PCIe VSEC structures
Date:   Thu, 30 Sep 2021 18:28:13 -0700
Message-Id: <20211001012815.1999501-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001012815.1999501-1-david.e.box@linux.intel.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds support for discovering Intel extended capability features from
Vendor Specific Extended Capability (VSEC) registers in PCIe config space.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V1:	- Modified version of [1] applied to auxiliary bus driver. 
	- Use bool instead of int to track whether any device has been added.

[1] https://lore.kernel.org/all/20210922213007.2738388-4-david.e.box@linux.intel.com/

 drivers/platform/x86/intel/extended_caps.c | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/platform/x86/intel/extended_caps.c b/drivers/platform/x86/intel/extended_caps.c
index 03acea20b675..eca47d693b14 100644
--- a/drivers/platform/x86/intel/extended_caps.c
+++ b/drivers/platform/x86/intel/extended_caps.c
@@ -294,6 +294,54 @@ static bool extended_caps_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
 	return have_devices;
 }
 
+static bool extended_caps_walk_vsec(struct pci_dev *pdev, unsigned long quirks)
+{
+	bool have_devices = false;
+	int pos = 0;
+
+	do {
+		struct extended_caps_header header;
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
+		ret = extended_caps_add_dev(pdev, &header, quirks);
+		if (ret)
+			continue;
+
+		have_devices = true;
+	} while (true);
+
+	return have_devices;
+}
+
 static int extended_caps_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct extended_caps_platform_info *info;
@@ -310,6 +358,7 @@ static int extended_caps_pci_probe(struct pci_dev *pdev, const struct pci_device
 		quirks = info->quirks;
 
 	have_devices |= extended_caps_walk_dvsec(pdev, quirks);
+	have_devices |= extended_caps_walk_vsec(pdev, quirks);
 
 	if (info && (info->quirks & EXT_CAPS_QUIRK_NO_DVSEC))
 		have_devices |= extended_caps_walk_header(pdev, quirks, info->capabilities);
-- 
2.25.1

