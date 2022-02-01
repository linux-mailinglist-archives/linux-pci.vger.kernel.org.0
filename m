Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE64A57A8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbiBAHUF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:44741 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234726AbiBAHUB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700001; x=1675236001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aPeKKV0gDoanUOEMeYIF7O9O6eyMIx4vHTay2OJltXQ=;
  b=CwsHAYPkpu8ddowYP6VAVrQaglN7w9XH4jiG4Rg1qzArFZcQQFt31z/w
   mExVsj4A/+JpJLFmcm7EMacbAnBEo4jIftncRUwXCzOVMr7zEk13KbVnJ
   h2xRiEGjmlbXtIO5LYhLk7NuA3NbFKOZrnP2yA1abj+uJNel9bgxnqkO4
   75i5p5f88w1yXBtDbalRSXYJ3LTqTj12ZaScdFBl82UYjgFafM0mKlxKE
   qieTJzQAT2yh4Pkyye/FZYQUl2MbNQefl/PNLU7J+xyU7Js7VHkGv/ZjD
   h3+P/PNhsSkVr9p+nYlBvjWG83JspN0QT6COboX59e2hnn/BN42OWvwNC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235028380"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="235028380"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:20:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000471"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 10/10] cxl/cdat: Parse out DSMAS data from CDAT table
Date:   Mon, 31 Jan 2022 23:19:52 -0800
Message-Id: <20220201071952.900068-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL memory devices need the information in the Device Scoped Memory
Affinity Structure (DSMAS).  This information is contained within the
CDAT table buffer which is already read and cached.

Parse and cache DSMAS data from the CDAT table.  Store this data in
unmarshaled struct dsmas data structures for ease of use.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V5
	Fix up sparse warnings
	Split out cdat_hdr_valid()
	Update cdat_hdr_valid()
		Remove revision and cs field parsing
			There is no point in these
		Add seq check and debug print.
	From Jonathan
		Add spaces around '+' and '/'
		use devm_krealloc() for dmas_ary

Changes from V4
	New patch
---
 drivers/cxl/cdat.h        | 21 ++++++++++++
 drivers/cxl/core/memdev.c | 70 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
index a7725d26f2d2..f8c126190d18 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -83,17 +83,38 @@
 #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
 #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
 
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
+	u8 non_volatile:1;
+};
+
 /**
  * struct cxl_cdat - CXL CDAT data
  *
  * @table: cache of CDAT table
  * @length: length of cached CDAT table
  * @seq: Last read Sequence number of the CDAT table
+ * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
+ * @nr_dsmas: Number of entries in dsmas_ary
  */
 struct cxl_cdat {
 	void *table;
 	size_t length;
 	u32 seq;
+	struct cxl_dsmas *dsmas_ary;
+	int nr_dsmas;
 };
 
 #endif /* !__CXL_CDAT_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 11d721c56f08..32342a15e991 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -6,6 +6,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include "cdat.h"
 #include "core.h"
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
@@ -386,6 +387,71 @@ static int read_cdat_data(struct cxl_memdev *cxlmd,
 	return rc;
 }
 
+static int parse_dsmas(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dsmas *dsmas_ary = NULL;
+	u32 *data = cxlmd->cdat.table;
+	int bytes_left = cxlmd->cdat.length;
+	int nr_dsmas = 0;
+
+	if (!data)
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
+			new_ary = devm_krealloc(&cxlmd->dev, dsmas_ary,
+					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
+					   GFP_KERNEL);
+			if (!new_ary) {
+				dev_err(&cxlmd->dev,
+					"Failed to allocate memory for DSMAS data\n");
+				return -ENOMEM;
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
+		data += (length / sizeof(u32));
+		bytes_left -= length;
+	}
+
+	if (nr_dsmas == 0)
+		return -ENXIO;
+
+	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
+	cxlmd->cdat.dsmas_ary = dsmas_ary;
+	cxlmd->cdat.nr_dsmas = nr_dsmas;
+
+	return 0;
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
@@ -407,6 +473,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
+	rc = parse_dsmas(cxlmd);
+	if (rc)
+		dev_warn(dev, "No DSMAS data found: %d\n", rc);
+
 	/*
 	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
 	 * needed as this is ordered with cdev_add() publishing the device.
-- 
2.31.1

