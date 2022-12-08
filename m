Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E17E64687E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 06:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiLHFVn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 00:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiLHFV3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 00:21:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3790E88B69;
        Wed,  7 Dec 2022 21:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670476887; x=1702012887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQU7Z+Wm7nBhQ+b4GpG/lIkO8WYp5cL/jEE+yXAeGD0=;
  b=BAHzDMoyWcMMH6VHeDB1tQROaFHbd/DSjhbqihQ4Sx5hyrC1IhwA8Fv0
   Bx4H9xwrlKVUSj+hucdtNDCMxIM2hT138Ms3lqshbWYg73gxMReSi04x1
   np2TQIJP3xv6TXnd03OMB/sgvQBYupjS/bIEddiEHbnRvzhzDhes7v38d
   /A+PxrnUf9ODAU6Mdx63Nf8El/t03qL7K8mytj/5DjqQcFnrlg23XQSuG
   6mb+L++yXFRKogLs1/P5T47de7ajOfj5vXOBAuNHRUdYCqaiTzao2YT9h
   7HG24K06/4sf5McptnJMkqUc8vmhaxAMiu/S7ihn22LlqSI8E59WgMaZ6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="381367254"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="381367254"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="710324474"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="710324474"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.25.22])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 21:21:24 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: [PATCH V3 4/8] cxl/mem: Trace DRAM Event Record
Date:   Wed,  7 Dec 2022 21:21:10 -0800
Message-Id: <20221208052115.800170-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221208052115.800170-1-ira.weiny@intel.com>
References: <20221208052115.800170-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL rev 3.0 section 8.2.9.2.1.2 defines the DRAM Event Record.

Determine if the event read is a DRAM event record and if so trace the
record.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v2:
	Dan
		Move tracing to cxl core
		Remove trace_*_enabled() calls
		Pass struct device to trace points

Changes from RFC v2:
	Output DPA flags as a separate field.
	Ensure field names match TP_print output
	Steven
		prefix TRACE_EVENT with 'cxl_'
	Jonathan
		Formatting fix
		Remove reserved field

Changes from RFC:
	Add reserved byte data
	Use new CXL header macros
	Jonathan
		Use get_unaligned_le{24,16}() for unaligned fields
		Use 'else if'
	Dave Jiang
		s/cxl_dram_event/dram
		s/cxl_evt_dram_rec/cxl_event_dram
	Adjust for new phys addr mask
---
 drivers/cxl/core/mbox.c  | 13 ++++++
 drivers/cxl/core/trace.h | 92 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h     | 23 ++++++++++
 3 files changed, 128 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0d8c66f1cdc5..2fa4645f0ed9 100644
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
 static void cxl_trace_event_record(const struct device *dev,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
@@ -738,6 +746,11 @@ static void cxl_trace_event_record(const struct device *dev,
 
 		trace_cxl_general_media(dev, type, rec);
 		return;
+	} else if (uuid_equal(id, &dram_event_uuid)) {
+		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
+
+		trace_cxl_dram(dev, type, rec);
+		return;
 	}
 
 	/* For unknown record types print just the header */
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 82462942590b..5c6cd9aa9450 100644
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
index a5f5d4a380af..19c9cb6d6ccd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -475,6 +475,29 @@ struct cxl_event_gen_media {
 	u8 reserved[0x2e];
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
2.37.2

