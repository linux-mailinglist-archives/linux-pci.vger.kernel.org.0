Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CCC4579E2
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236217AbhKTAGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhKTAGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542395"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542395"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088338"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 03/23] cxl/pci: Extract device status check
Date:   Fri, 19 Nov 2021 16:02:30 -0800
Message-Id: <20211120000250.1663391-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Memory Device Status register is inspected in the same way for at
least two flows in the CXL Type 3 Memory Device Software Guide
(Revision: 1.0): 2.13.9 Device discovery and mailbox ready sequence,
and 2.13.10 Media ready sequence. Extract this common functionality for
use by both.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
This patch did not exist in RFCv2
---
 drivers/cxl/pci.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a6ea9811a05b..6c8d09fb3a17 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -182,6 +182,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
+/*
+ * Implements roughly the bottom half of Figure 42 of the CXL Type 3 Memory
+ * Device Software Guide
+ */
+static int check_device_status(struct cxl_dev_state *cxlds)
+{
+	const u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+	if (md_status & CXLMDEV_DEV_FATAL) {
+		dev_err(cxlds->dev, "Fatal: replace device\n");
+		return -EIO;
+	}
+
+	if (md_status & CXLMDEV_FW_HALT) {
+		dev_err(cxlds->dev, "FWHalt: reset or replace device\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
  * @cxlds: The device state to gain access to.
@@ -231,17 +252,13 @@ static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
 	 * Hardware shouldn't allow a ready status but also have failure bits
 	 * set. Spit out an error, this should be a bug report
 	 */
-	rc = -EFAULT;
-	if (md_status & CXLMDEV_DEV_FATAL) {
-		dev_err(dev, "mbox: reported ready, but fatal\n");
+	rc = check_device_status(cxlds);
+	if (rc)
 		goto out;
-	}
-	if (md_status & CXLMDEV_FW_HALT) {
-		dev_err(dev, "mbox: reported ready, but halted\n");
-		goto out;
-	}
+
 	if (CXLMDEV_RESET_NEEDED(md_status)) {
 		dev_err(dev, "mbox: reported ready, but reset needed\n");
+		rc = -EFAULT;
 		goto out;
 	}
 
-- 
2.34.0

