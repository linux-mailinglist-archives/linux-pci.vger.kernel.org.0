Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC74976A8
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbiAXAbQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:51724 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240617AbiAXAbP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984274; x=1674520274;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5+FJpLB8Qt6mE4dbQ2E52eJSpXbZ7qQHR/gOMZALWOc=;
  b=j5rYPC2wlPZ8hrVXOci11N+hogGOW+EcmAatgV3IwnWvFb3lk3bKoYLm
   ela3cqZE/3tdHpQqboZJAn/QJ9Xwgmp7snejU7U2vWurIOiDZzz2Mc/yz
   8X55Yd3mPZFCZTZTe/ReTV/rR1g5+wyBLtIpqS4TNECrkJ8/wXx7cOF6D
   a8BVhp31AL/A9Wk99DYEGWqhPw9wrjgfi1MG6tGeHnI/OKTUVRgjo0st/
   9AWAII92H4TYf8tR3IVsHT7s/4OgQt/d6W30CnlairJiN9H0m8t1EeAYG
   fMrbDGWrNhqhoAyGPN2SMM1b5BHFHMif+xUPCQ/eJWA6A1D8Klabz8JCv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="246151739"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="246151739"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="531916698"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:14 -0800
Subject: [PATCH v3 29/40] cxl/pci: Implement wait for media active
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:13 -0800
Message-ID: <164298427373.3018233.9309741847039301834.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

CXL 2.0 8.1.3.8.2 states:

  Memory_Active: When set, indicates that the CXL Range 1 memory is
  fully initialized and available for software use. Must be set within
  Range 1. Memory_Active_Timeout of deassertion of reset to CXL device
  if CXL.mem HwInit Mode=1

Unfortunately, Memory_Active can take quite a long time depending on
media size (up to 256s per 2.0 spec). Provide a callback for the
eventual establishment of CXL.mem operations via the 'cxl_mem' driver
the 'struct cxl_memdev'. The implementation waits for 60s by default for
now and can be overridden by the mbox_ready_time module parameter.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: switch to sleeping wait]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxlmem.h         |    2 ++
 drivers/cxl/pci.c            |   49 +++++++++++++++++++++++++++++++++++++++++-
 tools/testing/cxl/test/mem.c |    8 +++++++
 3 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 00f55f4066b9..e70838e5dc17 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -132,6 +132,7 @@ struct cxl_endpoint_dvsec_info {
  * @component_reg_phys: register base of component registers
  * @info: Cached DVSEC information about the device.
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @wait_media_ready: @dev specific method to await media ready
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -165,6 +166,7 @@ struct cxl_dev_state {
 	struct cxl_endpoint_dvsec_info info;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
 };
 
 enum cxl_opcode {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5c43886dc2af..513cb0e2a70a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -49,7 +49,7 @@
 static unsigned short mbox_ready_timeout = 60;
 module_param(mbox_ready_timeout, ushort, 0600);
 MODULE_PARM_DESC(mbox_ready_timeout,
-		 "seconds to wait for mailbox ready status");
+		 "seconds to wait for mailbox ready / memory active status");
 
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
@@ -417,6 +417,51 @@ static int wait_for_valid(struct cxl_dev_state *cxlds)
 	return -ETIMEDOUT;
 }
 
+/*
+ * Wait up to @mbox_ready_timeout for the device to report memory
+ * active.
+ */
+static int wait_for_media_ready(struct cxl_dev_state *cxlds)
+{
+	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	int d = cxlds->cxl_dvsec;
+	bool active = false;
+	u64 md_status;
+	int rc, i;
+
+	rc = wait_for_valid(cxlds);
+	if (rc)
+		return rc;
+
+	for (i = mbox_ready_timeout; i; i--) {
+		u32 temp;
+		int rc;
+
+		rc = pci_read_config_dword(
+			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
+		if (rc)
+			return rc;
+
+		active = FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
+		if (active)
+			break;
+		msleep(1000);
+	}
+
+	if (!active) {
+		dev_err(&pdev->dev,
+			"timeout awaiting memory active after %d seconds\n",
+			mbox_ready_timeout);
+		return -ETIMEDOUT;
+	}
+
+	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+	if (!CXLMDEV_READY(md_status))
+		return -EIO;
+
+	return 0;
+}
+
 static int cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 {
 	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
@@ -520,6 +565,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENXIO;
 	}
 
+	cxlds->wait_media_ready = wait_for_media_ready;
+
 	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
 	if (rc)
 		return rc;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 8c2086c4caef..3af3f94de0c3 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -4,6 +4,7 @@
 #include <linux/platform_device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/bits.h>
 #include <cxlmem.h>
@@ -236,6 +237,12 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
 	return rc;
 }
 
+static int cxl_mock_wait_media_ready(struct cxl_dev_state *cxlds)
+{
+	msleep(100);
+	return 0;
+}
+
 static void label_area_release(void *lsa)
 {
 	vfree(lsa);
@@ -262,6 +269,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return PTR_ERR(cxlds);
 
 	cxlds->mbox_send = cxl_mock_mbox_send;
+	cxlds->wait_media_ready = cxl_mock_wait_media_ready;
 	cxlds->payload_size = SZ_4K;
 
 	rc = cxl_enumerate_cmds(cxlds);

