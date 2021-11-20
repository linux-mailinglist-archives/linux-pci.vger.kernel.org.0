Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866C74579ED
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhKTAGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:5726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236143AbhKTAGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542413"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542413"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088392"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:59 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 16/23] cxl/pci: Cache device DVSEC offset
Date:   Fri, 19 Nov 2021 16:02:43 -0800
Message-Id: <20211120000250.1663391-17-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCIe device DVSEC, defined in the CXL 2.0 spec, 8.1.3 is required to
be implemented by CXL 2.0 endpoint devices. Since the information
contained within this DVSEC will be critically important for region
configuration, it makes sense to find the value early.

Since this DVSEC is not strictly required for mailbox functionality,
failure to find this information does not result in the driver failing
to bind.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxlmem.h | 2 ++
 drivers/cxl/pci.c    | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..3ef3c652599e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -98,6 +98,7 @@ struct cxl_mbox_cmd {
  *
  * @dev: The device associated with this CXL state
  * @regs: Parsed register blocks
+ * @device_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @lsa_size: Size of Label Storage Area
@@ -125,6 +126,7 @@ struct cxl_dev_state {
 	struct device *dev;
 
 	struct cxl_regs regs;
+	int device_dvsec;
 
 	size_t payload_size;
 	size_t lsa_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d2c743a31b0c..f3872cbee7f8 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -474,6 +474,13 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
 
+	cxlds->device_dvsec = pci_find_dvsec_capability(pdev,
+							PCI_DVSEC_VENDOR_ID_CXL,
+							CXL_DVSEC_PCIE_DEVICE);
+	if (!cxlds->device_dvsec)
+		dev_warn(&pdev->dev,
+			 "Device DVSEC not present. Expect limited functionality.\n");
+
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
-- 
2.34.0

