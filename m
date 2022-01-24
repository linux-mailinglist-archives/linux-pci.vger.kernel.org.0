Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05344976A0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiAXAa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:30:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:22246 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235253AbiAXAa6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984257; x=1674520257;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7V3Ra/ExuPLrDCzXd0F5DBtK8mU8SaZyL/uYcXMqIp4=;
  b=EAXR8cOtHZrAQhbVamOZZsbIpK3dFTwjAjMVbp1zOLjoQ/5L0QV+2XLO
   9NcwuUoRlYl2zEqnZAKMc+CFD1jrf9k4SdF2AF5N1m251yiL//9+e1Zad
   v1Xu8Ov70xaNXdClErDH8YpVBBpICxONH/y1+pjrp2x4Y3BEtSJUJrMfW
   Ynj9MxB77Ho/jAUZQRb+nqp6nfSVGabczD8Nx/bncfgZ2djMd6Os94U7N
   pUgpi20rQjR9ezViOYIg6hApPd/xwciuVIEHk4lQIOLteZ3/DakEw2dcq
   v+ns/z7A3GJCWhYrucbgyjom9fI7uWo9Zrcrm9Crnk85xry7jieyqjl/w
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226608137"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226608137"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617061726"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:57 -0800
Subject: [PATCH v3 26/40] cxl/pci: Store component register base in cxlds
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:30:57 -0800
Message-ID: <164298425711.3018233.16653457511648347954.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for defining a cxl_port object to represent the decoder
resources of a memory expander capture the compont register base
address.

The port driver uses the component register base to enumerate the HDM
Decoder Capability structure. Unlike other cxl_port objects the endpoint
port decodes from upstream SPA to downstream DPA rather than upstream
port to downstream port.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
[djbw: clarify changelog]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
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
index c29d50660c21..e54dbdf9ac15 100644
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

