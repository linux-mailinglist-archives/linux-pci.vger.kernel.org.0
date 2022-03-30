Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407DB4ED088
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 01:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351965AbiCaABY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351941AbiCaABW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 20:01:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A047865810;
        Wed, 30 Mar 2022 16:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684773; x=1680220773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e3VfFz++MQ57r3VMx1Qll9FF7SCTUqFcUJ7v5m5VFpA=;
  b=C9W4B6O+GT1TRGfhxXDmz9LY/T7SXlEdVbaM4Il6KVLq+I/ttWXQh9lA
   fHoCT+quaE7dXZBsH7A0uEITzaZz38M0AsR143rACVrkLa+iXa98LOuZN
   mD2iYHl1OsyrecJkufWtdJxtvH3VVpUnLOCydt+CTYcBdUjbiZcSBhXXT
   vXeXXMvKYE9QAkgrgkRrWvHNoAc8diGNXWVrOe204lM3NK1XDC6GwKhsf
   EJRXdOPypyeqpN9AwvnmgkOObmXZ2TXEus/OAtmbZQ8iAYdvDFbsRpeLp
   QftvLsG5TSQ9JXq5K8lk9pUQ5Bndk9kSpJ8IKoAv5X3UKFGbHRVa5tgZw
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259386306"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259386306"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="565929808"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:32 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V7 10/10] cxl/port: Parse out DSMAS data from CDAT table
Date:   Wed, 30 Mar 2022 16:59:20 -0700
Message-Id: <20220330235920.2800929-11-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330235920.2800929-1-ira.weiny@intel.com>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL Ports with memory devices attached need the information from the
Device Scoped Memory Affinity Structure (DSMAS).  This information is
contained within the CDAT table buffer which is previously read and
cached in the device state.

If CDAT data is available, parse and cache DSMAS data from the table.
Store this data in unmarshaled struct dsmas data structures for ease of
use.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 drivers/cxl/cdat.h | 17 ++++++++++++
 drivers/cxl/cxl.h  |  6 +++++
 drivers/cxl/port.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
index a7725d26f2d2..66706b238bc9 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -83,6 +83,23 @@
 #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
 #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
 
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 80f462509b13..bd719da602ce 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -9,6 +9,8 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 
+#include "cdat.h"
+
 /**
  * DOC: cxl objects
  *
@@ -343,6 +345,8 @@ struct cxl_nvdimm {
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
+ * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
+ * @nr_dsmas: Number of entries in dsmas_ary
  */
 struct cxl_port {
 	struct device dev;
@@ -354,6 +358,8 @@ struct cxl_port {
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
+	struct cxl_dsmas *dsmas_ary;
+	int nr_dsmas;
 };
 
 /**
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index f3c11a780bed..67abb2104e09 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -73,6 +73,70 @@ static int set_decoders(struct device *dev, void *data)
 	return 0;
 }
 
+static void parse_dsmas(struct cxl_port *port, struct cxl_dev_state *cxlds)
+{
+	struct device *dev = &port->dev;
+	struct cxl_dsmas *dsmas_ary = NULL;
+	u32 *data = cxlds->cdat.table;
+	int bytes_left = cxlds->cdat.length;
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
+	port->dsmas_ary = dsmas_ary;
+	port->nr_dsmas = nr_dsmas;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
@@ -87,6 +151,7 @@ static int cxl_port_probe(struct device *dev)
 		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
 		if (rc)
 			return rc;
+		parse_dsmas(port, cxlmd->cxlds);
 	} else {
 		rc = devm_cxl_port_enumerate_dports(port);
 		if (rc < 0)
-- 
2.35.1

