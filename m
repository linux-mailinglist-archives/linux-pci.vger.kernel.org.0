Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C063E336
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiK3WN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 17:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK3WN7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 17:13:59 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84DC55A9B;
        Wed, 30 Nov 2022 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669846438; x=1701382438;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+mH4z/sNShHHPu4gAuEYR0d6/sUMSw4IDLOmsOPCps=;
  b=DF1x2QNEnPP2VO29q4uUy++2UdzNlmNlJGjlUf8Yk3zmxaQzR0pRpFq/
   63EFvgqgtqOZyi57k2b392hrUDkl5/MVwG+MsG0r/L5YbuwqaVJR91rz3
   Q3LS7BYkABxXMfjYjH63BG90ZlZlVSoaX6Yn6/e9EvKJd+wEOllYE0eMr
   1lMD1edJLXy9PciGFvFzqHZu2EVp+NnKtsFCsP4xo+kt1lYg9Ubftxi/b
   umnGjYJibiaB9//YJKQu4AkSI1s5FdLacNPbT6Q+Mt63VyN1RYsa+VSJk
   l8zrtQ+A0Cvf2XeOBv3yqvbPhvHRbtPZyNRstSDA/SC6L/D6VzJBkS5sR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="401800684"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="401800684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:13:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="786641062"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="786641062"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 14:13:45 -0800
Subject: [v5 11/11 PATCH] cxl/pci: Add callback to log AER correctable error
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, bhelgaas@google.com
Date:   Wed, 30 Nov 2022 15:13:45 -0700
Message-ID: <166984638949.2804499.1293428014191809830.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <20221130194521.GA829038@bhelgaas>
References: <20221130194521.GA829038@bhelgaas>
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

See CXL spec rev3.0 8.2.4.16 for Correctable Error Status Register.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v5:
- Update cor_error_log() to cor_error_detected(). 

 drivers/cxl/pci.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 11f842df9807..ffebd997dc15 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -622,10 +622,30 @@ static void cxl_error_resume(struct pci_dev *pdev)
 		 dev->driver ? "successful" : "failed");
 }
 
+static void cxl_correctable_error_logging(struct pci_dev *pdev)
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
+	.cor_error_detected	= cxl_correctable_error_logging,
 };
 
 static struct pci_driver cxl_pci_driver = {


