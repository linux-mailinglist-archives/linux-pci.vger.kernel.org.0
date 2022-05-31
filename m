Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9968F5393F9
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbiEaP1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 11:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbiEaP1H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 11:27:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DD543EF8;
        Tue, 31 May 2022 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010825; x=1685546825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TaRWwujRSzDps0+n1mHj1Y+SE2EDhfYhtniteEJhuw=;
  b=j3uRgsJn6pkQFC7vzuCOVESrzGWsVUB6cm5CU5L8Ptn6Fk3KmeMKZJVF
   EItrZF74O/ShY+lYUOCepDKN1JlL63kmiCiJpTiyFUzYkSq6IX/HBPrAu
   nNabAHmmwXq+o823QcmeeZLmEaUTMWsJKwWHvGyCGRBFPqvjOED6bsppY
   /ZHxEH0pt7NFpkhjPSD11tAGMwNJ+CTqDtkfOciD6ARcVdHEC8VuTe6kG
   0zh4veQXJZzQxrIYqUeKJbyqckLw9rJEecwKuFGB/oEr4RFnnUor7xnZ8
   01r75dlrTlV/08fIVVrybT4KTvb44x+dpJwJ3bVMmuTKLUoYxvxr5YJPo
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255161009"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="255161009"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:27:03 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="633088908"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:27:02 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V9 9/9] cxl/port: Parse out DSMAS data from CDAT table
Date:   Tue, 31 May 2022 08:26:32 -0700
Message-Id: <20220531152632.1397976-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531152632.1397976-1-ira.weiny@intel.com>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL Ports with memory devices attached need the information from the
Device Scoped Memory Affinity Structure (DSMAS).  This information is
contained within the CDAT table buffer which is previously read and
cached in the port device.

If CDAT data is available, parse and cache DSMAS data from the table.
Store this data in unmarshaled struct dsmas data structures for ease of
use later.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 drivers/cxl/cdat.h     | 17 +++++++++++
 drivers/cxl/core/pci.c | 65 ++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |  2 ++
 drivers/cxl/cxlmem.h   |  4 +++
 drivers/cxl/cxlpci.h   |  1 +
 drivers/cxl/mem.c      |  1 +
 6 files changed, 90 insertions(+)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
index 3d8945612511..0a510f73fe6d 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -85,6 +85,23 @@
 
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
index 7f7dac9030a6..a63c7dca056e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -660,3 +660,68 @@ void read_cdat_data(struct cxl_port *port)
 	}
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
index 531b77d296c7..4d779a8fb807 100644
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
index 4d2764b865ab..ce5b00f3ebcb 100644
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
index 35f0d4892eaa..5ab148fe7d65 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -76,4 +76,5 @@ struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
 void cxl_find_cdat_mb(struct cxl_port *port);
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
2.35.1

