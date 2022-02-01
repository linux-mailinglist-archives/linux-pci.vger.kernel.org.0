Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816CD4A579C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiBAHUA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:64023 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234690AbiBAHT7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643699999; x=1675235999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4KjNTNkBCcqgnLHqu+gmyWgiooiCJUymCv84l6vQB44=;
  b=Li38Z4zlMq+NbDFX6UJ732DXA1PeOoJatHAmqa4miYe+IbSbQ/GLxRoZ
   gs5XSXMnFoGgEPthYRxaVwRX34YNNvu0uDl0mCdNmFhkX59OxL8hCyeC1
   p+dHMIWL+8xjyPIbDaM2/pzp8Q+/BpUM0+Q9AuNLP8q9F2ssJozYLeDX/
   Ys31isP4cyKHeZa/mQD3zYRFfRnVD2DC03EJmegO6vIxYQv3lQiU77MJZ
   X1F+abMO4S1duAyobXZApWsmOSNjgOlPCmD9uox2vK5qOsXjQ9JG+OIER
   TbJUkbNMBLq1NiZ5iEHyyI+tNkzA0nPToG5jo7qgVcL0vqYDdZGGp0OBD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246468436"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="246468436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000458"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 06/10] cxl/pci: Find the DOE mailbox which supports CDAT
Date:   Mon, 31 Jan 2022 23:19:48 -0800
Message-Id: <20220201071952.900068-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Memory devices need the CDAT data from the device.  This data is read
from a DOE mailbox which supports the CDAT protocol.

Search the DOE auxiliary devices for the one which supports the CDAT
protocol.  Cache that device to be used for future queries.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/cxl/cxl.h    |  3 +++
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 962629c5775f..7169101db553 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -90,6 +90,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+#define CXL_DOE_PROTOCOL_COMPLIANCE 0
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5d33ce24fe09..0fefe43951e3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -117,6 +117,7 @@ struct cxl_endpoint_dvsec_info {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -149,6 +150,7 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_dev_state {
 	struct device *dev;
 
+	struct pci_doe_dev *cdat_doe;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d4ae79b62a14..dcc55c4efd85 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -536,12 +536,53 @@ static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 	return rc;
 }
 
+static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
+{
+	const struct cxl_dev_state *cxlds = data;
+	struct auxiliary_device *adev;
+	struct pci_doe_dev *doe_dev;
+
+	/* First determine if this auxiliary device belongs to the cxlds */
+	if (cxlds->dev != dev->parent)
+		return 0;
+
+	adev = to_auxiliary_dev(dev);
+	doe_dev = container_of(adev, struct pci_doe_dev, adev);
+
+	/* If it is one of ours check for the CDAT protocol */
+	if (pci_doe_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
+				  CXL_DOE_PROTOCOL_TABLE_ACCESS))
+		return 1;
+
+	return 0;
+}
+
 static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct auxiliary_device *adev;
+	int rc;
 
-	return pci_doe_create_doe_devices(pdev);
+	rc = pci_doe_create_doe_devices(pdev);
+	if (rc)
+		return rc;
+
+	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
+
+	if (adev) {
+		struct pci_doe_dev *doe_dev = container_of(adev,
+							   struct pci_doe_dev,
+							   adev);
+
+		/*
+		 * No reference need be taken.  The DOE device lifetime is
+		 * longer that the CXL device state lifetime
+		 */
+		cxlds->cdat_doe = doe_dev;
+	}
+
+	return 0;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.31.1

