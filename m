Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB14579EF
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhKTAGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236282AbhKTAGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542415"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542415"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088398"
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
Subject: [PATCH 18/23] cxl/pci: Implement wait for media active
Date:   Fri, 19 Nov 2021 16:02:45 -0800
Message-Id: <20211120000250.1663391-19-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL 2.0 8.1.3.8.2 defines "Memory_Active: When set, indicates that the
CXL Range 1 memory is fully initialized and available for software use.
Must be set within Range 1. Memory_Active_Timeout of deassertion of
reset to CXL device if CXL.mem HwInit Mode=1" The CXL* Type 3 Memory
Device Software Guide (Revision 1.0) further describes the need to check
this bit before using HDM.

Unfortunately, Memory_Active can take quite a long time depending on
media size (up to 256s per 2.0 spec). Since the cxl_pci driver doesn't
care about this, a callback is exported as part of driver state for use
by drivers that do care.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
This patch did not exist in RFCv2
---
 drivers/cxl/cxlmem.h |  1 +
 drivers/cxl/pci.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index eac5528ccaae..a9424dd4e5c3 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -167,6 +167,7 @@ struct cxl_dev_state {
 	struct cxl_endpoint_dvsec_info *info;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
 };
 
 enum cxl_opcode {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b3f46045bf3e..f1a68bfe5f77 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -496,6 +496,60 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 	return valid ? 0 : -ETIMEDOUT;
 }
 
+/*
+ * Implements Figure 43 of the CXL Type 3 Memory Device Software Guide. Waits a
+ * full 256s no matter what the device reports.
+ */
+static int wait_for_media_ready(struct cxl_dev_state *cxlds)
+{
+	const unsigned long timeout = jiffies + (256 * HZ);
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	u64 md_status;
+	bool active;
+	int rc;
+
+	rc = wait_for_valid(cxlds);
+	if (rc)
+		return rc;
+
+	do {
+		u64 size;
+		u32 temp;
+		int rc;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, HIGH),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+		size = (u64)temp << 32;
+
+		rc = pci_read_config_dword(pdev, CDPDR(cxlds, 0, SIZE, LOW),
+					   &temp);
+		if (rc)
+			return -ENXIO;
+		size |= temp & CXL_DVSEC_PCIE_DEVICE_MEM_SIZE_LOW_MASK;
+
+		active = FIELD_GET(CXL_DVSEC_PCIE_DEVICE_MEM_ACTIVE, temp);
+		if (active)
+			break;
+		cpu_relax();
+		mdelay(100);
+	} while (!time_after(jiffies, timeout));
+
+	if (!active)
+		return -ETIMEDOUT;
+
+	rc = check_device_status(cxlds);
+	if (rc)
+		return rc;
+
+	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+	if (!CXLMDEV_READY(md_status))
+		return -EIO;
+
+	return 0;
+}
+
 static struct cxl_endpoint_dvsec_info *dvsec_ranges(struct cxl_dev_state *cxlds)
 {
 	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
@@ -598,6 +652,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!cxlds->device_dvsec)
 		dev_warn(&pdev->dev,
 			 "Device DVSEC not present. Expect limited functionality.\n");
+	else
+		cxlds->wait_media_ready = wait_for_media_ready;
 
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
-- 
2.34.0

