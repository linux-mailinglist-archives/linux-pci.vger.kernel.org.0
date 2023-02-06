Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6281F68C7F1
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjBFUuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjBFUuE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:50:04 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD9A2CC51;
        Mon,  6 Feb 2023 12:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716601; x=1707252601;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVxqrflyskXxJAcWJicsZWPFmU0oE+WsKb5As7c0Ac8=;
  b=iMF73XUWvLKHqGqkjsMhyiTubl+bYgubRqD8evn/hOVGt2Sfe7DRc4ph
   u7261ExLWSx5uqkITebPZdUVTIhfvQUjfzLAUIq43M7aMEezHdMAsDN97
   fRlyyZtPRBeNDO42BqafymX+JUtowexVN8UnKIXeGJ5D/rXyBAmoAI7mE
   bT8WEWVR34xoGvfRKrAKuvgdKFYVRSV1iGv1cxqLXjmjIXOYzVQXCFClY
   1IToyf0hJ+aP4o7wYbKVIhUxTmEy5EZ7zofrlRoYa1bVbBxgBV8LKX4dR
   Onq1AKgbUMe33+QdH5IvPIwq4evf3s7dIFfYxSZDzZrHyWGcQksxkJmp/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="330604654"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="330604654"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:50:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="995471573"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="995471573"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:49:59 -0800
Subject: [PATCH 04/18] cxl: Add common helpers for cdat parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:49:58 -0700
Message-ID: <167571659666.587790.1381783105886436293.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add helper functions to parse the CDAT table and provide a callback to
parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
parsing. The code is patterned after the ACPI table parsing helpers.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/Makefile |    1 
 drivers/cxl/core/cdat.c   |   98 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/cdat.h   |   15 +++++++
 drivers/cxl/cxl.h         |    9 ++++
 4 files changed, 123 insertions(+)
 create mode 100644 drivers/cxl/core/cdat.c
 create mode 100644 drivers/cxl/core/cdat.h

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 79c7257f4107..438ce27faf77 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -10,4 +10,5 @@ cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
 cxl_core-y += hdm.o
+cxl_core-y += cdat.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
new file mode 100644
index 000000000000..be09c8a690f5
--- /dev/null
+++ b/drivers/cxl/core/cdat.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+#include "cxl.h"
+#include "cdat.h"
+
+static u8 cdat_get_subtable_entry_type(struct cdat_subtable_entry *entry)
+{
+	return entry->hdr->type;
+}
+
+static u16 cdat_get_subtable_entry_length(struct cdat_subtable_entry *entry)
+{
+	return entry->hdr->length;
+}
+
+static bool has_handler(struct cdat_subtable_proc *proc)
+{
+	return proc->handler;
+}
+
+static int call_handler(struct cdat_subtable_proc *proc,
+			struct cdat_subtable_entry *ent)
+{
+	if (proc->handler)
+		return proc->handler(ent->hdr, proc->arg);
+	return -EINVAL;
+}
+
+static int cdat_table_parse_entries(enum acpi_cdat_type type,
+				    struct acpi_table_cdat *table_header,
+				    struct cdat_subtable_proc *proc,
+				    unsigned int max_entries)
+{
+	struct cdat_subtable_entry entry;
+	unsigned long table_end, entry_len;
+	int count = 0;
+	int rc;
+
+	if (!has_handler(proc))
+		return -EINVAL;
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	if (type >= ACPI_CDAT_TYPE_RESERVED)
+		return -EINVAL;
+
+	entry.type = type;
+	entry.hdr = (struct acpi_cdat_header *)((unsigned long)table_header +
+					       sizeof(*table_header));
+
+	while ((unsigned long)entry.hdr < table_end) {
+		entry_len = cdat_get_subtable_entry_length(&entry);
+
+		if ((unsigned long)entry.hdr + entry_len > table_end)
+			return -EINVAL;
+
+		if (max_entries && count >= max_entries)
+			break;
+
+		if (entry_len == 0)
+			return -EINVAL;
+
+		if (cdat_get_subtable_entry_type(&entry) == type) {
+			rc = call_handler(proc, &entry);
+			if (rc)
+				return rc;
+		}
+
+		entry.hdr = (struct acpi_cdat_header *)((unsigned long)entry.hdr + entry_len);
+		count++;
+	}
+
+	return count;
+}
+
+int cdat_table_parse_dsmas(void *table, cdat_tbl_entry_handler handler, void *arg)
+{
+	struct acpi_table_cdat *header = (struct acpi_table_cdat *)table;
+	struct cdat_subtable_proc proc = {
+		.handler	= handler,
+		.arg		= arg,
+	};
+
+	return cdat_table_parse_entries(ACPI_CDAT_TYPE_DSMAS, header, &proc, 0);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dsmas, CXL);
+
+int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler, void *arg)
+{
+	struct acpi_table_cdat *header = (struct acpi_table_cdat *)table;
+	struct cdat_subtable_proc proc = {
+		.handler	= handler,
+		.arg		= arg,
+	};
+
+	return cdat_table_parse_entries(ACPI_CDAT_TYPE_DSLBIS, header, &proc, 0);
+}
+EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dslbis, CXL);
diff --git a/drivers/cxl/core/cdat.h b/drivers/cxl/core/cdat.h
new file mode 100644
index 000000000000..f690325e82a6
--- /dev/null
+++ b/drivers/cxl/core/cdat.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2023 Intel Corporation. */
+#ifndef __CXL_CDAT_H__
+#define __CXL_CDAT_H__
+
+struct cdat_subtable_proc {
+	cdat_tbl_entry_handler handler;
+	void *arg;
+};
+
+struct cdat_subtable_entry {
+	struct acpi_cdat_header *hdr;
+	enum acpi_cdat_type type;
+};
+#endif
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f558bbfc0332..839a121c1997 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -9,6 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <linux/io.h>
+#include <linux/acpi.h>
 
 /**
  * DOC: cxl objects
@@ -697,6 +698,14 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
 }
 #endif
 
+typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
+
+u8 cdat_table_checksum(u8 *buffer, u32 length);
+int cdat_table_parse_dsmas(void *table, cdat_tbl_entry_handler handler,
+			   void *arg);
+int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
+			    void *arg);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.


