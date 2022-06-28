Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BF55E32C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244227AbiF1EQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244077AbiF1EQZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:16:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9304027FFB;
        Mon, 27 Jun 2022 21:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389784; x=1687925784;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tpA5FJsBtzTqQaXxHQ1/5jItTcIF44B1UOgIkA2TMBw=;
  b=Phe/4bb+/aai01FecZA5h7NBKIbO2ay0+cTMERLpNGkszn1/ivIShddA
   mLNhZJ4KBKbFuiUXNcFXrVmhZWjzdVgUOEjsNs+ai/NGK6nKBV21L22Ln
   HA4mcrnLviZHezD0bPpwfuCyVzLosBRffgI+v9zDEYhhHsJtqL3bqYbjo
   b0JtdbOHa4fzYldXnj79VCJHLSAZyMiQ2xgURFF8Y2vV27RHL/zQPcnAZ
   a6k2Gwiu7gq1jRtyBTEFcXaKdWgYK76ZRICHsm/hpEwE6GxLRu+XiXwU6
   e8PqoTl3JHFaQeAj3RS14u4AC1ZzC5YkJMTar9kfCMPvZsQfln1ABIYWc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345627107"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345627107"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:20 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="590164502"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:16 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V12 9/9] cxl/port: Parse out DSMAS data from CDAT table
Date:   Mon, 27 Jun 2022 21:15:27 -0700
Message-Id: <20220628041527.742333-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628041527.742333-1-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL Ports with memory devices attached need the information from the
Device Scoped Memory Affinity Structure (DSMAS).  This information is
contained within the CDAT table buffer which is cached in the port
device.

If CDAT data is available, parse and cache DSMAS data from the table.
Store this data in unmarshaled struct dsmas data structures for ease of
use later.  Ensure DSMAS headers are not malicious or ill formed so as
to cause buffer overflow errors.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V10
	From Ben Widawsky
		Check data lengths to protect against malicious devices

Changes from V8
	Adjust to the cdat data being in cxl_port

Changes from V7
	Rebased on cxl-pending

Changes from V6
	Move to port.c
	It is not an error if no DSMAS data is found

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
---
 drivers/cxl/cdat.h     | 23 ++++++++++++++
 drivers/cxl/core/pci.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/cxlmem.h   |  4 +++
 drivers/cxl/cxlpci.h   |  1 +
 drivers/cxl/mem.c      |  1 +
 6 files changed, 103 insertions(+)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
index 39eb561081f2..ca1f55762416 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -51,6 +51,7 @@
 #define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
 #define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
 #define CDAT_DSMAS_NON_VOLATILE(flags)  ((flags & 0x04) >> 2)
+#define CDAT_DSMAS_ENTRY_SIZE		(6 * sizeof(u32))
 
 /* Device Scoped Latency and Bandwidth Information Structure */
 #define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
@@ -60,22 +61,26 @@
 #define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
 #define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
 #define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
+#define CDAT_DSLBIS_ENTRY_SIZE		(6 * sizeof(u32))
 
 /* Device Scoped Memory Side Cache Information Structure */
 #define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
 #define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
 	((u64)((entry)[3]) << 32 | (entry)[2])
 #define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
+#define CDAT_DSMSCIS_ENTRY_SIZE		(5 * sizeof(u32))
 
 /* Device Scoped Initiator Structure */
 #define CDAT_DSIS_DW1_FLAGS		0x000000ff
 #define CDAT_DSIS_DW1_HANDLE		0x0000ff00
+#define CDAT_DSIS_ENTRY_SIZE		(2 * sizeof(u32))
 
 /* Device Scoped EFI Memory Type Structure */
 #define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
 #define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
 #define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
 #define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
+#define CDAT_DSEMTS_ENTRY_SIZE		(6 * sizeof(u32))
 
 /* Switch Scoped Latency and Bandwidth Information Structure */
 #define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
@@ -83,9 +88,27 @@
 #define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
 #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
 #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
+#define CDAT_SSLBIS_HEADER_SIZE		(6 * sizeof(u32))
 
 #define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
 
+/**
+ * struct cxl_dsmas - host unmarshaled version of DSMAS data
+ *
+ * As defined in the Coherent Device Attribute Table (CDAT) specification this
+ * represents a single DSMAS entry in that table.
+ *
+ * @dpa_base: The lowest Device Physical Address associated with this DSMAD
+ * @length: Length in bytes of this DSMAD
+ * @non_volatile: If set, the memory region represents Non-Volatile memory
+ */
+struct cxl_dsmas {
+	u64 dpa_base;
+	u64 length;
+	/* Flags */
+	u8 non_volatile:1;
+};
+
 /**
  * struct cxl_cdat - CXL CDAT data
  *
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index d7c2a415cc5f..6d58fb1e46b0 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -679,3 +679,75 @@ void read_cdat_data(struct cxl_port *port)
 		retries);
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
+
+void parse_dsmas(struct cxl_memdev *cxlmd, struct cxl_port *port)
+{
+	struct device *dev = &port->dev;
+	struct cxl_dsmas *dsmas_ary = NULL;
+	u32 *data = port->cdat.table;
+	int bytes_left = port->cdat.length;
+	int nr_dsmas = 0;
+
+	if (!data) {
+		dev_info(dev, "No CDAT data available for DSMAS\n");
+		return;
+	}
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
+			/* Protect against malicious devices */
+			if (bytes_left < CDAT_DSMAS_ENTRY_SIZE ||
+			    length != CDAT_DSMAS_ENTRY_SIZE) {
+				dev_err(dev, "Invalid DSMAS data detected\n");
+				return;
+			}
+
+			new_ary = devm_krealloc(dev, dsmas_ary,
+					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
+					   GFP_KERNEL);
+			if (!new_ary) {
+				dev_err(dev,
+					"Failed to allocate memory for DSMAS data (nr_dsmas %d)\n",
+					nr_dsmas);
+				return;
+			}
+			dsmas_ary = new_ary;
+
+			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
+
+			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
+			dsmas_ary[nr_dsmas].length = CDAT_DSMAS_DPA_LEN(cur_rec);
+			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
+
+			dev_dbg(dev, "DSMAS %d: %llx:%llx %s\n",
+				nr_dsmas,
+				dsmas_ary[nr_dsmas].dpa_base,
+				dsmas_ary[nr_dsmas].dpa_base +
+					dsmas_ary[nr_dsmas].length,
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
+	dev_dbg(dev, "Found %d DSMAS entries\n", nr_dsmas);
+	cxlmd->dsmas_ary = dsmas_ary;
+	cxlmd->nr_dsmas = nr_dsmas;
+}
+EXPORT_SYMBOL_NS_GPL(parse_dsmas, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9a08379000a0..5332b4d52d55 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -10,6 +10,8 @@
 #include <linux/io.h>
 #include "cdat.h"
 
+#include "cdat.h"
+
 /**
  * DOC: cxl objects
  *
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 360f282ef80c..54231c26470c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -36,6 +36,8 @@
  * @cxlds: The device state backing this device
  * @detach_work: active memdev lost a port in its ancestry
  * @id: id number of this memdev instance.
+ * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
+ * @nr_dsmas: Number of entries in dsmas_ary
  */
 struct cxl_memdev {
 	struct device dev;
@@ -43,6 +45,8 @@ struct cxl_memdev {
 	struct cxl_dev_state *cxlds;
 	struct work_struct detach_work;
 	int id;
+	struct cxl_dsmas *dsmas_ary;
+	int nr_dsmas;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..3e68804d8935 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -75,4 +75,5 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 void read_cdat_data(struct cxl_port *port);
+void parse_dsmas(struct cxl_memdev *cxlmd, struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c310f1fd3db0..a8768df4ae38 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -35,6 +35,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
 	if (IS_ERR(endpoint))
 		return PTR_ERR(endpoint);
 
+	parse_dsmas(cxlmd, endpoint);
 	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
 
 	if (!endpoint->dev.driver) {
-- 
2.35.3

