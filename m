Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FC162FB2B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiKRRJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiKRRJK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:09:10 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE772701B1;
        Fri, 18 Nov 2022 09:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791349; x=1700327349;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e2QHRfiu8f+Jdd+htf/CMAkOlQJDiFc8YQXAZJZ7SBY=;
  b=dl5gEwzmvKdFFdLA9s5VelNIRMprGIDYKK1vSiBC8YnxsLnNeXbtMFER
   hZo9RfUltQwNucWrFIm7xrS956QNozc8cMA7Pjn+RO+M8aC1tpnVq4EVr
   XfBgBQVy1yF26dYKd3SlWlkQQ5nFUnWWn+/8JHCFlibD6QcjO+GQu4Toc
   dn4ePX4diwwLMW1NbFP5BqfnSQ1M6Txxt9NZN2R8NXB3Wc5IbnAnX/GoP
   tcElAltWFNQTupYYBAiq2w1mU9g+IyAPn1A4buk+iSQkc5EU6bt81Q1ZF
   EblU4bXoopk/OHuOgv5GxzqXTDaszNgKJDySb/HhYYjSAeCPDOWkVEGn/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="399469781"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="399469781"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:09:09 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765224277"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="765224277"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:09:08 -0800
Subject: [PATCH v3 11/11] cxl/pci: Add callback to log AER correctable error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:09:08 -0700
Message-ID: <166879134802.674819.8577415268687156421.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
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
error.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index dad69110291d..b394fd227949 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -621,10 +621,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
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


