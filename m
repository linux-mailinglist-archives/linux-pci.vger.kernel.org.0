Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCD63C6DB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236666AbiK2Ryn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236665AbiK2Ryf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:54:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC9642F70;
        Tue, 29 Nov 2022 09:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744475; x=1701280475;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7mz9SUDoz1hl6jr4oJTrYyo3Cu04D1Zr8uWanlzRRT8=;
  b=SUG+omafF3CeeZj/kWE0W8cETOjiWZY6bGsY2PjOjDxFjsl4z3BbBgSv
   ulTSGKRC1WpB+jTDxvGxfG/IR/pzhYtUMV0TeohCER9F+gOnLGBgEwgBQ
   4ThlZnNdPdQptakwmH5Lv/giiz3n6LI0yabkyvVt/PNxoUE0KkzCjHKyS
   JgUbCebYYaMznjlzuY9+tw/12W7CTUnpisWiSjvemyfNEgilt+o6rX6eZ
   rjWJCmK5u9KdOaahiDqQ9EgPZdTI3HoYz8rjff5s0GECB5Sd7KHKvfrm3
   zcY7GpRXBzHuFLb63/BoqIYK+FFfrKE3w2peedp8kHdPKrWAEONIXJ7gP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317038214"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317038214"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:49:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749957299"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="749957299"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:49:11 -0800
Subject: [PATCH v4 11/11] cxl/pci: Add callback to log AER correctable error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:49:11 -0700
Message-ID: <166974415139.1608150.13978145410258604882.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add AER error handler callback to read the correctable error status
register for the CXL device. Log the error as a trace event and clear the
error. For CXL devices, the driver also needs to write back to the AER CE
status register to clear the unmasked CEs.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 11f842df9807..93a68f0f032a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -622,10 +622,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static void cxl_correctable_error_log(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	void __iomem *addr;
+	u32 status;
+
+	if (!cxlds->regs.ras)
+		return;
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	status = le32_to_cpu(readl(addr));
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+		trace_cxl_aer_correctable_error(dev_name(dev), status);
+	}
+}
+
 static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
+	.cor_error_log	= cxl_correctable_error_log,
 };
 
 static struct pci_driver cxl_pci_driver = {


