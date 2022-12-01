Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A6663E62B
	for <lists+linux-pci@lfdr.de>; Thu,  1 Dec 2022 01:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiLAAIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 19:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiLAAGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 19:06:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931A695817;
        Wed, 30 Nov 2022 16:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669852949; x=1701388949;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a7Q19w1eNvdrsRPi8yRiG+pDxwSC8c5/WmkbQ9ncDiM=;
  b=YLy9n0DWgZWfStRs+2t6vBwaOdTZo21+49mwuNFzXxkkRY1ZUwKpYMt6
   Ae60nvwwptmd3y0INREkETorsvTM7MadyjPjBtezDeMa16HHTz2J8vuYn
   EyWHM/jqpCbaT2rcCFcBq29udapOfDagXIbS/V+tcN647VP7CLu1R7rUL
   9OkSIjBGc8FMsKpOdG9ELJxND+swq89Wcr0MYhUGeS7xqliE8VsWf1gZJ
   oeW2coWm6qdQxQk7guj6N2s/ryeXV0sRYahlMriuPfAUb2p5ll0klOaVo
   DCOqX0KZ8i/05hq2mMcCaUSdfnblhtpf+yvbl4OR4EASXKTzC2Y6yQk85
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="295236931"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="295236931"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:02:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="638186625"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="638186625"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 16:02:26 -0800
Subject: [v6 11/11 PATCH] cxl/pci: Add callback to log AER correctable error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com
Date:   Wed, 30 Nov 2022 17:02:25 -0700
Message-ID: <166985287203.2871899.13605149073500556137.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20221130224714.GA846634@bhelgaas>
References: <20221130224714.GA846634@bhelgaas>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add AER error handler callback to read the RAS capability structure
correctable error (CE) status register for the CXL device. Log the
error as a trace event and clear the error. For CXL devices, the driver
also needs to write back to the status register to clear the
unmasked correctable errors.

See CXL spec rev3.0 8.2.4.16 for RAS capability structure CE Status
Register.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v6:
- Update commit log to point to RAS capability structure. (Bjorn)
- Change cxl_correctable_error_logging() to cxl_cor_error_detected().
  (Bjorn)

 drivers/cxl/pci.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 11f842df9807..02342830b612 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -622,10 +622,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static void cxl_cor_error_detected(struct pci_dev *pdev)
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
+	.cor_error_detected	= cxl_cor_error_detected,
 };
 
 static struct pci_driver cxl_pci_driver = {


