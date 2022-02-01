Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C374A6713
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 22:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232755AbiBAV2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 16:28:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:12601 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232754AbiBAV2z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 16:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643750935; x=1675286935;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qCnDTFX3Sh3Ge0zkXTpUeE7tPdzN+lWiIbW2aZ2X5ZU=;
  b=h/f3c200/nPdeoKTV56xogfQ/mNxfrtOi6RucBAaG7X3a19/QsgN51mq
   LQPp25zHDAzrfo1E+5zekpMBa8xSGKF06sp1nORIrY9alvgWQTuKAfouZ
   J2LrcUqXFHoflxXwZcJbWh6yRAabEhkNjCtGfwzOAsaZC72GfvAoGiBob
   Iln1YQZrEDmKpX5Nhi9TDuZ8mic0hlj3nPhorx9o9klkTejGwfLTc/04A
   swnmLUxDATaUZPu2rPWMCMP2cRmpTU4bNPx0r/ZAzgPwrxgcb9erPUpn0
   Wb4gsl6TTP9fEw2zB617zTSYQgC9SR1H6dnHWI+awQHFBxr+Mhgr4S44Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247569684"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247569684"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:28:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="534657967"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:28:53 -0800
Subject: [PATCH v4 26/40] cxl/pci: Store component register base in cxlds
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 01 Feb 2022 13:28:53 -0800
Message-ID: <164375084181.484304.3919737667590006795.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298425711.3018233.16653457511648347954.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298425711.3018233.16653457511648347954.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

In preparation for defining a cxl_port object to represent the decoder
resources of a memory expander capture the component register base
address.

The port driver uses the component register base to enumerate the HDM
Decoder Capability structure. Unlike other cxl_port objects the endpoint
port decodes from upstream SPA to downstream DPA rather than upstream
port to downstream port.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[djbw: clarify changelog]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- s/compont/component/ in changelog (Jonathan)

 drivers/cxl/cxlmem.h |    3 +++
 drivers/cxl/pci.c    |   11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index fca2d1b5f6ff..90d67fff5bed 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -116,6 +116,7 @@ struct cxl_mbox_cmd {
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
+ * @component_reg_phys: register base of component registers
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -145,6 +146,8 @@ struct cxl_dev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
+	resource_size_t component_reg_phys;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8b435b875b65..bf14c365ea33 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -416,6 +416,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/*
+	 * If the component registers can't be found, the cxl_pci driver may
+	 * still be useful for management functions so don't return an error.
+	 */
+	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
+	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
+
+	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;

