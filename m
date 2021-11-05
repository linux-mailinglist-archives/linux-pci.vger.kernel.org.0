Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13E446B5F
	for <lists+linux-pci@lfdr.de>; Sat,  6 Nov 2021 00:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhKEXxl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 19:53:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:30588 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhKEXxk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 19:53:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="230724058"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="230724058"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:50:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="639954981"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 16:50:59 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 5/5] cxl/cdat: Parse out DSMAS data from CDAT table
Date:   Fri,  5 Nov 2021 16:50:56 -0700
Message-Id: <20211105235056.3711389-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20211105235056.3711389-1-ira.weiny@intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Parse and cache the DSMAS data from the CDAT table.  Store this data in
Unmarshaled data structures for use later.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4
	New patch
---
 drivers/cxl/core/memdev.c | 111 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |  23 ++++++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index c35de9e8298e..e5a2d30a3491 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -6,6 +6,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "cdat.h"
 #include "core.h"
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
@@ -312,6 +313,112 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
+static bool cdat_hdr_valid(struct cxl_memdev *cxlmd)
+{
+	u32 *data = cxlmd->cdat_table;
+	u8 *data8 = (u8 *)data;
+	u32 length, seq;
+	u8 rev, cs;
+	u8 check;
+	int i;
+
+	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, data[0]);
+	if (length < CDAT_HEADER_LENGTH_BYTES)
+		return false;
+
+	rev = FIELD_GET(CDAT_HEADER_DW1_REVISION, data[1]);
+	cs = FIELD_GET(CDAT_HEADER_DW1_CHECKSUM, data[1]);
+	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, data[3]);
+
+	/* Store the sequence for now. */
+	cxlmd->cdat_seq = seq;
+
+	for (check = 0, i = 0; i < length; i++)
+		check += data8[i];
+
+	return check == 0;
+}
+
+static int parse_dsmas(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dsmas *dsmas_ary = NULL;
+	u32 *data = cxlmd->cdat_table;
+	int bytes_left = cxlmd->cdat_length;
+	int nr_dsmas = 0;
+	size_t dsmas_byte_size;
+	int rc = 0;
+
+	if (!data || !cdat_hdr_valid(cxlmd))
+		return -ENXIO;
+
+	/* Skip header */
+	data += CDAT_HEADER_LENGTH_DW;
+	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
+
+	while (bytes_left > 0) {
+		u32 *cur_rec = data;
+		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
+		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
+
+		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
+			struct cxl_dsmas *new_ary;
+			u8 flags;
+
+			new_ary = krealloc(dsmas_ary,
+					   sizeof(*dsmas_ary) * (nr_dsmas+1),
+					   GFP_KERNEL);
+			if (!new_ary) {
+				dev_err(&cxlmd->dev,
+					"Failed to allocate memory for DSMAS data\n");
+				rc = -ENOMEM;
+				goto free_dsmas;
+			}
+			dsmas_ary = new_ary;
+
+			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
+
+			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
+			dsmas_ary[nr_dsmas].dpa_length = CDAT_DSMAS_DPA_LEN(cur_rec);
+			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
+
+			dev_dbg(&cxlmd->dev, "DSMAS %d: %llx:%llx %s\n",
+				nr_dsmas,
+				dsmas_ary[nr_dsmas].dpa_base,
+				dsmas_ary[nr_dsmas].dpa_base +
+					dsmas_ary[nr_dsmas].dpa_length,
+				(dsmas_ary[nr_dsmas].non_volatile ?
+					"Persistent" : "Volatile")
+				);
+
+			nr_dsmas++;
+		}
+
+		data += (length/sizeof(u32));
+		bytes_left -= length;
+	}
+
+	if (nr_dsmas == 0) {
+		rc = -ENXIO;
+		goto free_dsmas;
+	}
+
+	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
+
+	dsmas_byte_size = sizeof(*dsmas_ary) * nr_dsmas;
+	cxlmd->dsmas_ary = devm_kzalloc(&cxlmd->dev, dsmas_byte_size, GFP_KERNEL);
+	if (!cxlmd->dsmas_ary) {
+		rc = -ENOMEM;
+		goto free_dsmas;
+	}
+
+	memcpy(cxlmd->dsmas_ary, dsmas_ary, dsmas_byte_size);
+	cxlmd->nr_dsmas = nr_dsmas;
+
+free_dsmas:
+	kfree(dsmas_ary);
+	return rc;
+}
+
 struct cxl_memdev *
 devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
@@ -339,6 +446,10 @@ devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 		cxl_mem_cdat_read_table(cxlds, cxlmd->cdat_table, cxlmd->cdat_length);
 	}
 
+	rc = parse_dsmas(cxlmd);
+	if (rc)
+		dev_err(dev, "No DSMAS data found: %d\n", rc);
+
 	/*
 	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
 	 * needed as this is ordered with cdev_add() publishing the device.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f6c62cd537bb..d68da2610265 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -29,6 +29,23 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
+/**
+ * struct cxl_dsmas - host unmarshaled version of DSMAS data
+ *
+ * As defined in the Coherent Device Attribute Table (CDAT) specification this
+ * represents a single DSMAS entry in that table.
+ *
+ * @dpa_base: The lowest DPA address associated with this DSMAD
+ * @dpa_length: Length in bytes of this DSMAD
+ * @non_volatile: If set, the memory region represents Non-Volatile memory
+ */
+struct cxl_dsmas {
+	u64 dpa_base;
+	u64 dpa_length;
+	/* Flags */
+	int non_volatile:1;
+};
+
 /**
  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
  * @dev: driver core device object
@@ -36,6 +53,9 @@
  * @cxlds: The device state backing this device
  * @cdat_table: cache of CDAT table
  * @cdat_length: length of cached CDAT table
+ * @cdat_seq: Last read Sequence number of the CDAT table
+ * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
+ * @nr_dsmas: Number of entries in dsmas_ary
  * @id: id number of this memdev instance.
  */
 struct cxl_memdev {
@@ -44,6 +64,9 @@ struct cxl_memdev {
 	struct cxl_dev_state *cxlds;
 	void *cdat_table;
 	size_t cdat_length;
+	u32 cdat_seq;
+	struct cxl_dsmas *dsmas_ary;
+	int nr_dsmas;
 	int id;
 };
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

