Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B5C6630AF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 20:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjAITnW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 14:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbjAITmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 14:42:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A9078E83;
        Mon,  9 Jan 2023 11:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673293363; x=1704829363;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=kWvn6Qr1CSO8z2/ljUd/ALZwW1xdg9LMvtmdC99bOC8=;
  b=h008qm9Bk/NYTe4xlCs6ufg/8slP+yDjoVyu06X52ujtBNCz848HisSz
   Yt5a5C3FZ8mTI0Mkga3tOpS1ZtWgaoGmRl4R4FvoR/Wtbv9/Av26pzQbP
   3DPKFfLBzSJFZOM39seE+f8PcVhW9pYjggblRKfkPBvKq1Md7JxdNMy7T
   z2G1VSzF2H5Dgcx8SWnSsebsO64ZPhrBrQK79i44IfLBDvkg0BEjXXd1E
   wS4Wq8Ezo0b+9j1qq2YeSK7+lzA1Wb8fYLInHoPRj01ICx44yd/ALRKWr
   wU+e34EXX+dAijcYDpPONQ8kfOZDkR9k9ni7t+kTSouc7X/HL5MjvfjEe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385269893"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385269893"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656783506"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656783506"
Received: from cwchen-mobl.amr.corp.intel.com (HELO localhost) ([10.212.45.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 09 Jan 2023 11:42:23 -0800
Subject: [PATCH v6 4/8] cxl/mem: Trace DRAM Event Record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v6-4-346583105b30@intel.com>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
X-Mailer: b4 0.12-dev-cc11a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673293350; l=6203;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=kWvn6Qr1CSO8z2/ljUd/ALZwW1xdg9LMvtmdC99bOC8=;
 b=H2P9/8r0f3qeZTDs3eeMvSMMc3++NjkyrIs/fzvkTrIFKHPJPIIRRQeopsN1SWTAsDVOSW51OVJA
 7p/au+Z4AKGgGJWLLg5SWmxTiK1+azQR/o5/0MXfjpF5jwgQSZSr
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Determine if the event read is a DRAM event record and if so trace the
record.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v4:
	pick up tag
---
 drivers/cxl/core/mbox.c  | 12 +++++++
 drivers/cxl/core/trace.h | 92 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h     | 23 ++++++++++++
 3 files changed, 127 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0ece1766f613..0101b4de700f 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -726,6 +726,14 @@ static const uuid_t gen_media_event_uuid =
 	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
 		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
 
+/*
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+static const uuid_t dram_event_uuid =
+	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
+		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
+
 static void cxl_event_trace_record(const struct device *dev,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
@@ -737,6 +745,10 @@ static void cxl_event_trace_record(const struct device *dev,
 				(struct cxl_event_gen_media *)record;
 
 		trace_cxl_general_media(dev, type, rec);
+	} else if (uuid_equal(id, &dram_event_uuid)) {
+		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
+
+		trace_cxl_dram(dev, type, rec);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(dev, type, record);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index d85f0481661d..b6321cfb1d9f 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -347,6 +347,98 @@ TRACE_EVENT(cxl_general_media,
 	)
 );
 
+/*
+ * DRAM Event Record - DER
+ *
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+/*
+ * DRAM Event Record defines many fields the same as the General Media Event
+ * Record.  Reuse those definitions as appropriate.
+ */
+#define CXL_DER_VALID_CHANNEL				BIT(0)
+#define CXL_DER_VALID_RANK				BIT(1)
+#define CXL_DER_VALID_NIBBLE				BIT(2)
+#define CXL_DER_VALID_BANK_GROUP			BIT(3)
+#define CXL_DER_VALID_BANK				BIT(4)
+#define CXL_DER_VALID_ROW				BIT(5)
+#define CXL_DER_VALID_COLUMN				BIT(6)
+#define CXL_DER_VALID_CORRECTION_MASK			BIT(7)
+#define show_dram_valid_flags(flags)	__print_flags(flags, "|",			   \
+	{ CXL_DER_VALID_CHANNEL,			"CHANNEL"		}, \
+	{ CXL_DER_VALID_RANK,				"RANK"			}, \
+	{ CXL_DER_VALID_NIBBLE,				"NIBBLE"		}, \
+	{ CXL_DER_VALID_BANK_GROUP,			"BANK GROUP"		}, \
+	{ CXL_DER_VALID_BANK,				"BANK"			}, \
+	{ CXL_DER_VALID_ROW,				"ROW"			}, \
+	{ CXL_DER_VALID_COLUMN,				"COLUMN"		}, \
+	{ CXL_DER_VALID_CORRECTION_MASK,		"CORRECTION MASK"	}  \
+)
+
+TRACE_EVENT(cxl_dram,
+
+	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+		 struct cxl_event_dram *rec),
+
+	TP_ARGS(dev, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+		/* DRAM */
+		__field(u64, dpa)
+		__field(u8, descriptor)
+		__field(u8, type)
+		__field(u8, transaction_type)
+		__field(u8, channel)
+		__field(u16, validity_flags)
+		__field(u16, column)	/* Out of order to pack trace record */
+		__field(u32, nibble_mask)
+		__field(u32, row)
+		__array(u8, cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE)
+		__field(u8, rank)	/* Out of order to pack trace record */
+		__field(u8, bank_group)	/* Out of order to pack trace record */
+		__field(u8, bank)	/* Out of order to pack trace record */
+		__field(u8, dpa_flags)	/* Out of order to pack trace record */
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+
+		/* DRAM */
+		__entry->dpa = le64_to_cpu(rec->phys_addr);
+		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
+		__entry->dpa &= CXL_DPA_MASK;
+		__entry->descriptor = rec->descriptor;
+		__entry->type = rec->type;
+		__entry->transaction_type = rec->transaction_type;
+		__entry->validity_flags = get_unaligned_le16(rec->validity_flags);
+		__entry->channel = rec->channel;
+		__entry->rank = rec->rank;
+		__entry->nibble_mask = get_unaligned_le24(rec->nibble_mask);
+		__entry->bank_group = rec->bank_group;
+		__entry->bank = rec->bank;
+		__entry->row = get_unaligned_le24(rec->row);
+		__entry->column = get_unaligned_le16(rec->column);
+		memcpy(__entry->cor_mask, &rec->correction_mask,
+			CXL_EVENT_DER_CORRECTION_MASK_SIZE);
+	),
+
+	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' descriptor='%s' type='%s' " \
+		"transaction_type='%s' channel=%u rank=%u nibble_mask=%x " \
+		"bank_group=%u bank=%u row=%u column=%u cor_mask=%s " \
+		"validity_flags='%s'",
+		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
+		show_event_desc_flags(__entry->descriptor),
+		show_mem_event_type(__entry->type),
+		show_trans_type(__entry->transaction_type),
+		__entry->channel, __entry->rank, __entry->nibble_mask,
+		__entry->bank_group, __entry->bank,
+		__entry->row, __entry->column,
+		__print_hex(__entry->cor_mask, CXL_EVENT_DER_CORRECTION_MASK_SIZE),
+		show_dram_valid_flags(__entry->validity_flags)
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7f6355bd6d23..27dc89d84037 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -470,6 +470,29 @@ struct cxl_event_gen_media {
 	u8 reserved[46];
 } __packed;
 
+/*
+ * DRAM Event Record - DER
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 3-44
+ */
+#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
+struct cxl_event_dram {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 nibble_mask[3];
+	u8 bank_group;
+	u8 bank;
+	u8 row[3];
+	u8 column[2];
+	u8 correction_mask[CXL_EVENT_DER_CORRECTION_MASK_SIZE];
+	u8 reserved[0x17];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;

-- 
2.39.0
