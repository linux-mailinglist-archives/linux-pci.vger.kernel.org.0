Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0F4579EE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhKTAGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:19 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236145AbhKTAGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542416"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542416"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088401"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 19/23] cxl/pci: Store component register base in cxlds
Date:   Fri, 19 Nov 2021 16:02:46 -0800
Message-Id: <20211120000250.1663391-20-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The component register base address is enumerated and stored in the
cxl_device_state structure for use by the endpoint driver.

Component register base addresses are obtained through PCI mechanisms.
As such it makes most sense for the cxl_pci driver to obtain that
address. In order to reuse the port driver for enumerating decoder
resources for an endpoint, it is desirable to be able to add the
endpoint as a port. The endpoint does know of the cxlds and can pull the
component register base from there and pass it along to port creation.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since RFCv2:
This patch was originally named, "cxl/core: Store component register
base for memdevs". It plumbed the component registers through memdev
creation. After more work, it became apparent we needed to plumb other
stuff from the pci driver, so going forward, cxlds will just be
referenced by the cxl_mem driver. This also allows us to ignore the
change needed to cxl_test

- Rework patch to store the base in cxlds
- Remove defunct comment (Dan)
---
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a9424dd4e5c3..b1d753541f4e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -134,6 +134,7 @@ struct cxl_endpoint_dvsec_info {
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
  * @info: Cached DVSEC information about the device.
+ * @component_reg_phys: register base of component registers
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -165,6 +166,7 @@ struct cxl_dev_state {
 	u64 next_persistent_bytes;
 
 	struct cxl_endpoint_dvsec_info *info;
+	resource_size_t component_reg_phys;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 	int (*wait_media_ready)(struct cxl_dev_state *cxlds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f1a68bfe5f77..a8e375950514 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -663,6 +663,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/*
+	 * If the component registers can't be found, the cxl_pci driver may
+	 * still be useful for management functions so don't return an error.
+	 */
+	cxlds->component_reg_phys = CXL_RESOURCE_NONE;
+	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		dev_warn(&cxlmd->dev, "No component registers (%d)\n", rc);
+	else
+		cxlds->component_reg_phys = cxl_reg_block(pdev, &map);
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;
-- 
2.34.0

