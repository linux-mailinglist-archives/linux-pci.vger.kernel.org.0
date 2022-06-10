Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30127546E41
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350659AbiFJUXs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 16:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350663AbiFJUXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 16:23:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D43002DC;
        Fri, 10 Jun 2022 13:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654892592; x=1686428592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GVPoZlK4ltB/0G1Mh7IA4ovpJiayX5Zj53Z9lohkfN4=;
  b=mqzkCAZEpR+2r5qmgaYWXijJFWzxVkYHJtnkGtnPnLJUCzQphkWf7vE6
   s1fcFscN+bqMMZlQEbtowBCvRCizK9HGFLPDKVREumaXG/RuGquLt0DJJ
   1PSAkjehngp3F2Aq910ASP5ncCYUKT6apAvF4aV5jrEOPo1H0vN6MwAxa
   nkotawaAKR6fLI2P3oEfk6uRMTwTjmG8GOtEnQ0tavXobWZYmn219/70B
   wtY1t/TMN/nX2mIEfxuxLXHCu79SROOgTJpoaRLYrqRB8Qbf/+8/djN1n
   3DEOd/bPo/WzBzBs3MnGAU8vVJHQskRBBGDOWlFlM5y9lp80jBJ1nxzxt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="275268585"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="275268585"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="650001202"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:11 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V11 8/8] cxl/port: Parse out DSMAS data from CDAT table
Date:   Fri, 10 Jun 2022 13:22:59 -0700
Message-Id: <20220610202259.3544623-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610202259.3544623-1-ira.weiny@intel.com>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index fd02bc7c0d97..68b1a7c5359e 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -688,3 +688,75 @@ void read_cdat_data(struct cxl_port *port)
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
index f0f5c24789bc..bc9237466f33 100644
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
2.35.1

