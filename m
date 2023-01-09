Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950476630A8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jan 2023 20:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbjAITnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Jan 2023 14:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbjAITmq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Jan 2023 14:42:46 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3177D18;
        Mon,  9 Jan 2023 11:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673293362; x=1704829362;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ZgbC9P3gcujCZhGjAWqgON5swYwj79D5kiILPuw02bE=;
  b=e0ki4GDs6nB37D+H7bSu/9/sZbNaN3kZxISeVH3MmjvR8q/a2mRbbcru
   zz7cMWWfhswLhQDjU7C7CssllQELdJNG8PKKFKbF8LHudq99rfYkYNBpf
   P1D5/8gPSCcHYS3ARkQBgehiz7WtO1BcY/wVZ55+WRODu25igWud2hE5G
   i4zQKlCcQupj9KPFsL4X8cfIhQtL09kYS+YY7n+B3wMQ+Lc+U1iYn46hC
   T1zIFcgSdumG4frKYrgo+yRgUimeQBZ4g5FEi7eTU2wgsC/L/fV1QjMrD
   TWW0aMU2Hp1gp2LD0Q35zVqHP6wNLHClCD0SZm+9XHWtA32Ja7ol2GnSt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385269883"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="385269883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656783500"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="656783500"
Received: from cwchen-mobl.amr.corp.intel.com (HELO localhost) ([10.212.45.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 11:42:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 09 Jan 2023 11:42:22 -0800
Subject: [PATCH v6 3/8] cxl/mem: Trace General Media Event Record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v6-3-346583105b30@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673293350; l=7972;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=ZgbC9P3gcujCZhGjAWqgON5swYwj79D5kiILPuw02bE=;
 b=HtnlHhS/UPjwh2r6CDB8v2bQbE8OI0ZsPY/bTYOHb+vwNXjebI0xVfkgi9g+mc72/ty96Oip4WES
 3fhPohnVB7fo7iGdEjnFL+L+yRJMe8lhWNZcnnRh6ZNnDR5wHWCU
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

CXL rev 3.0 section 8.2.9.2.1.1 defines the General Media Event Record.

Determine if the event read is a general media record and if so trace
the record as a General Media Event Record.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4:
	Pick up tag
---
 drivers/cxl/core/mbox.c  |  29 ++++++++++-
 drivers/cxl/core/trace.h | 124 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h     |  19 ++++++++
 3 files changed, 170 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5ad4716f2e11..0ece1766f613 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -718,6 +718,31 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+static const uuid_t gen_media_event_uuid =
+	UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
+		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6);
+
+static void cxl_event_trace_record(const struct device *dev,
+				   enum cxl_event_log_type type,
+				   struct cxl_event_record_raw *record)
+{
+	uuid_t *id = &record->hdr.id;
+
+	if (uuid_equal(id, &gen_media_event_uuid)) {
+		struct cxl_event_gen_media *rec =
+				(struct cxl_event_gen_media *)record;
+
+		trace_cxl_general_media(dev, type, rec);
+	} else {
+		/* For unknown record types print just the header */
+		trace_cxl_generic_event(dev, type, record);
+	}
+}
+
 static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
 				  enum cxl_event_log_type log,
 				  struct cxl_get_event_payload *get_pl)
@@ -811,8 +836,8 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			trace_cxl_generic_event(cxlds->dev, type,
-						&payload->records[i]);
+			cxl_event_trace_record(cxlds->dev, type,
+					       &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlds->dev, type, payload);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index 6898212fcb47..d85f0481661d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -223,6 +223,130 @@ TRACE_EVENT(cxl_generic_event,
 		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
 );
 
+/*
+ * Physical Address field masks
+ *
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ *
+ * DRAM Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CXL_DPA_FLAGS_MASK			0x3F
+#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
+
+#define CXL_DPA_VOLATILE			BIT(0)
+#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
+#define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
+	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
+)
+
+/*
+ * General Media Event Record - GMER
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
+#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
+#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
+#define show_event_desc_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,		"UNCORRECTABLE_EVENT"	}, \
+	{ CXL_GMER_EVT_DESC_THRESHOLD_EVENT,		"THRESHOLD_EVENT"	}, \
+	{ CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW,	"POISON_LIST_OVERFLOW"	}  \
+)
+
+#define CXL_GMER_MEM_EVT_TYPE_ECC_ERROR			0x00
+#define CXL_GMER_MEM_EVT_TYPE_INV_ADDR			0x01
+#define CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR		0x02
+#define show_mem_event_type(type)	__print_symbolic(type,			\
+	{ CXL_GMER_MEM_EVT_TYPE_ECC_ERROR,		"ECC Error" },		\
+	{ CXL_GMER_MEM_EVT_TYPE_INV_ADDR,		"Invalid Address" },	\
+	{ CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,	"Data Path Error" }	\
+)
+
+#define CXL_GMER_TRANS_UNKNOWN				0x00
+#define CXL_GMER_TRANS_HOST_READ			0x01
+#define CXL_GMER_TRANS_HOST_WRITE			0x02
+#define CXL_GMER_TRANS_HOST_SCAN_MEDIA			0x03
+#define CXL_GMER_TRANS_HOST_INJECT_POISON		0x04
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB		0x05
+#define CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT	0x06
+#define show_trans_type(type)	__print_symbolic(type,					\
+	{ CXL_GMER_TRANS_UNKNOWN,			"Unknown" },			\
+	{ CXL_GMER_TRANS_HOST_READ,			"Host Read" },			\
+	{ CXL_GMER_TRANS_HOST_WRITE,			"Host Write" },			\
+	{ CXL_GMER_TRANS_HOST_SCAN_MEDIA,		"Host Scan Media" },		\
+	{ CXL_GMER_TRANS_HOST_INJECT_POISON,		"Host Inject Poison" },		\
+	{ CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,		"Internal Media Scrub" },	\
+	{ CXL_GMER_TRANS_INTERNAL_MEDIA_MANAGEMENT,	"Internal Media Management" }	\
+)
+
+#define CXL_GMER_VALID_CHANNEL				BIT(0)
+#define CXL_GMER_VALID_RANK				BIT(1)
+#define CXL_GMER_VALID_DEVICE				BIT(2)
+#define CXL_GMER_VALID_COMPONENT			BIT(3)
+#define show_valid_flags(flags)	__print_flags(flags, "|",		   \
+	{ CXL_GMER_VALID_CHANNEL,			"CHANNEL"	}, \
+	{ CXL_GMER_VALID_RANK,				"RANK"		}, \
+	{ CXL_GMER_VALID_DEVICE,			"DEVICE"	}, \
+	{ CXL_GMER_VALID_COMPONENT,			"COMPONENT"	}  \
+)
+
+TRACE_EVENT(cxl_general_media,
+
+	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+		 struct cxl_event_gen_media *rec),
+
+	TP_ARGS(dev, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+		/* General Media */
+		__field(u64, dpa)
+		__field(u8, descriptor)
+		__field(u8, type)
+		__field(u8, transaction_type)
+		__field(u8, channel)
+		__field(u32, device)
+		__array(u8, comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE)
+		__field(u16, validity_flags)
+		/* Following are out of order to pack trace record */
+		__field(u8, rank)
+		__field(u8, dpa_flags)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+
+		/* General Media */
+		__entry->dpa = le64_to_cpu(rec->phys_addr);
+		__entry->dpa_flags = __entry->dpa & CXL_DPA_FLAGS_MASK;
+		/* Mask after flags have been parsed */
+		__entry->dpa &= CXL_DPA_MASK;
+		__entry->descriptor = rec->descriptor;
+		__entry->type = rec->type;
+		__entry->transaction_type = rec->transaction_type;
+		__entry->channel = rec->channel;
+		__entry->rank = rec->rank;
+		__entry->device = get_unaligned_le24(rec->device);
+		memcpy(__entry->comp_id, &rec->component_id,
+			CXL_EVENT_GEN_MED_COMP_ID_SIZE);
+		__entry->validity_flags = get_unaligned_le16(&rec->validity_flags);
+	),
+
+	CXL_EVT_TP_printk("dpa=%llx dpa_flags='%s' " \
+		"descriptor='%s' type='%s' transaction_type='%s' channel=%u rank=%u " \
+		"device=%x comp_id=%s validity_flags='%s'",
+		__entry->dpa, show_dpa_flags(__entry->dpa_flags),
+		show_event_desc_flags(__entry->descriptor),
+		show_mem_event_type(__entry->type),
+		show_trans_type(__entry->transaction_type),
+		__entry->channel, __entry->rank, __entry->device,
+		__print_hex(__entry->comp_id, CXL_EVENT_GEN_MED_COMP_ID_SIZE),
+		show_valid_flags(__entry->validity_flags)
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e6b27e5d5009..7f6355bd6d23 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -451,6 +451,25 @@ struct cxl_mbox_clear_event_payload {
 	(offsetof(struct cxl_mbox_clear_event_payload, handle) +	\
 	 (nr_handles * sizeof(__le16)))
 
+/*
+ * General Media Event Record
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
+struct cxl_event_gen_media {
+	struct cxl_event_record_hdr hdr;
+	__le64 phys_addr;
+	u8 descriptor;
+	u8 type;
+	u8 transaction_type;
+	u8 validity_flags[2];
+	u8 channel;
+	u8 rank;
+	u8 device[3];
+	u8 component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+	u8 reserved[46];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;

-- 
2.39.0
