Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F8A68C7FA
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjBFUui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjBFUui (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E473B2CC48;
        Mon,  6 Feb 2023 12:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716637; x=1707252637;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kG3UAx4/7B+P3TM5sA0oWhO+QJjyaL/AvJzU6IihwKo=;
  b=nXwVBxMRlMyozmJ5R77NelmxAznLgmSCx5Y170Yb+0x+3qYDHMj3oAcz
   WsnYxkDGhF2spyaamSnHzSyfMvevVLvfPjd7er2V+tya2TNynM4ECI9bo
   v/haxor6R4Wn/OL96Aer9uHO2EzxJmLDiULbY7DMiXRRITlY/SOTJBbI5
   wp2dwdhkdEbShlIptbNgdoipNb/06YQYYqyTqKanLNs4f3SOxTrM4/m1I
   TUqGcaN9ihsaQGBZigRpLJN1bXfnN91TDB/3EIVFQw2t9dnAnQVGrz65H
   DVr2RIRhkBEZC1byILCDDJyV0Yzh6GVxCCNQcoWPtwwTaN+zBhXxMFJf6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="393912014"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="393912014"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="616559659"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="616559659"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:35 -0800
Subject: [PATCH 08/18] cxl: Add support for _DSM Function for retrieving QTG
 ID
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:50:33 -0700
Message-ID: <167571663199.587790.13615282047168132392.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
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

CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)

Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
an input of an ACPI package with 4 dwords (read latency, write latency,
read bandwidth, write bandwidth). The call returns a package with 1 WORD
that provides the max supported QTG ID and a package that may contain 0 or
more WORDs as the recommended QTG IDs in the recommended order.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/Makefile |    1 
 drivers/cxl/core/acpi.c   |   99 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |   15 +++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/cxl/core/acpi.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 438ce27faf77..11ccc2016ab7 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -11,4 +11,5 @@ cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += cdat.o
+cxl_core-y += acpi.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
new file mode 100644
index 000000000000..86dc6c9c1f24
--- /dev/null
+++ b/drivers/cxl/core/acpi.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/pci.h>
+#include <asm/div64.h>
+#include "cxlpci.h"
+#include "cxl.h"
+
+const guid_t acpi_cxl_qtg_id_guid =
+	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
+		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
+
+/**
+ * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
+ * @handle: ACPI handle
+ * @input: bandwidth and latency data
+ *
+ * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
+ * the QTG IDs that falls within the performance data.
+ */
+struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
+						 struct qtg_dsm_input *input)
+{
+	struct qtg_dsm_output *output;
+	union acpi_object *out_obj, *out_buf, *pkg, in_buf, in_obj;
+	int len;
+	int rc;
+
+	in_obj.type = ACPI_TYPE_PACKAGE;
+	in_obj.package.count = 1;
+	in_obj.package.elements = &in_buf;
+	in_buf.type = ACPI_TYPE_BUFFER;
+	in_buf.buffer.pointer = (u8 *)input;
+	in_buf.buffer.length = sizeof(u32) * 4;
+
+	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
+	if (!out_obj)
+		return ERR_PTR(-ENXIO);
+
+	if (out_obj->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	/*
+	 * CXL spec v3.0 9.17.3.1
+	 * There should be 2 elements in the package. 1 WORD for max QTG ID supported
+	 * by the platform, and the other a package of recommended QTGs
+	 */
+	if (out_obj->package.count != 2) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	pkg = &out_obj->package.elements[1];
+	if (pkg->type != ACPI_TYPE_PACKAGE) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	out_buf = &pkg->package.elements[0];
+	if (out_buf->type != ACPI_TYPE_BUFFER) {
+		rc = -ENXIO;
+		goto err;
+	}
+
+	len = out_buf->buffer.length;
+	output = kmalloc(len + sizeof(*output), GFP_KERNEL);
+	if (!output) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	/* It's legal to have 0 QTG entries */
+	if (len == 0) {
+		output->nr = 0;
+		goto out;
+	}
+
+	/* Malformed package, not multiple of WORD size */
+	if (len % sizeof(u16)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	output->nr = len / sizeof(u16);
+	memcpy(output->qtg_ids, out_buf->buffer.pointer, len);
+out:
+	ACPI_FREE(out_obj);
+	return output;
+
+err:
+	ACPI_FREE(out_obj);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 849b22236f1d..e70df07f9b4b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -719,6 +719,21 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
 int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
 int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg);
 
+struct qtg_dsm_input {
+	u32 rd_lat;
+	u32 wr_lat;
+	u32 rd_bw;
+	u32 wr_bw;
+};
+
+struct qtg_dsm_output {
+	int nr;
+	u16 qtg_ids[];
+};
+
+struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
+						 struct qtg_dsm_input *input);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


