Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E04671361
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 06:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjARF4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 00:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjARFyV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 00:54:21 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0219582AD;
        Tue, 17 Jan 2023 21:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674021237; x=1705557237;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=rtCiEFF0u2oekwfY5opAHmF1ELPL2ODDO8SvNVmqo2Y=;
  b=b9MjQCvCqQkTFPjm0Js703YmfWCLr2bDsY9hwNLEnJq2PHw7GX1O3+UG
   9zvDdYnPCsIwHsEVJS+hlYwVldHyq4+MCLYZZWUpF7JNMfLWyW6g4aRWB
   xeqaR9829esZIpLkbba+HWSZjmgStktFkPS78yeP2zx40qvoGXtBjzACc
   I7XXjxbgXDcA4vYtuUHy/8RIigrFUfxLGnKZvTmoAGpDPZTjqsmkIcw2s
   2vv8+FK8VGf3akm4b6kbYGNs8y++guy1AJKsUol5jLi9r4sbTV2cxEDZ2
   1jjcQTen6wvIsYWK5ens0lbRWZUsufbHOu2Kq7pMQJ6r25xcGZAy1aAW+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="304586809"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="304586809"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:53:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="802043215"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="802043215"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.209.10.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 21:53:56 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Tue, 17 Jan 2023 21:53:40 -0800
Subject: [PATCH v7 5/8] cxl/mem: Trace Memory Module Event Record
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221216-cxl-ev-log-v7-5-2316a5c8f7d8@intel.com>
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1674021228; l=8622;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=rtCiEFF0u2oekwfY5opAHmF1ELPL2ODDO8SvNVmqo2Y=;
 b=Gjv1euzAcAF3d6FkYG57dqdJm0X6sIAStg7CjQgm5f+1fS1Ivw7sAPIUeIQdALi75xQHtmcFMp02
 gGc6G7TMCZNpNW8Z2agdJNRIMMXTpLXWWqZlDQJ9cuJJsiOGcgwI
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.

Determine if the event read is memory module record and if so trace the
record.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v7:
	Jonathan
		Fix LSA spelling
---
 drivers/cxl/core/mbox.c  |  13 +++++
 drivers/cxl/core/trace.h | 143 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h     |  26 +++++++++
 3 files changed, 182 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 552d98bc9f93..6ed8e3654939 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -734,6 +734,14 @@ static const uuid_t dram_event_uuid =
 	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
 		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
 
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const uuid_t mem_mod_event_uuid =
+	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
+		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
+
 static void cxl_event_trace_record(const struct device *dev,
 				   enum cxl_event_log_type type,
 				   struct cxl_event_record_raw *record)
@@ -749,6 +757,11 @@ static void cxl_event_trace_record(const struct device *dev,
 		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
 
 		trace_cxl_dram(dev, type, rec);
+	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
+		struct cxl_event_mem_module *rec =
+				(struct cxl_event_mem_module *)record;
+
+		trace_cxl_memory_module(dev, type, rec);
 	} else {
 		/* For unknown record types print just the header */
 		trace_cxl_generic_event(dev, type, record);
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index b6321cfb1d9f..c7e2af9d9c4d 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -439,6 +439,149 @@ TRACE_EVENT(cxl_dram,
 	)
 );
 
+/*
+ * Memory Module Event Record - MMER
+ *
+ * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
+#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
+#define CXL_MMER_LIFE_USED_CHANGE		0x02
+#define CXL_MMER_TEMP_CHANGE			0x03
+#define CXL_MMER_DATA_PATH_ERROR		0x04
+#define CXL_MMER_LSA_ERROR			0x05
+#define show_dev_evt_type(type)	__print_symbolic(type,			   \
+	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
+	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
+	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
+	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
+	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
+	{ CXL_MMER_LSA_ERROR,			"LSA Error"		}  \
+)
+
+/*
+ * Device Health Information - DHI
+ *
+ * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
+#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
+#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
+#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
+	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"MAINTENANCE_NEEDED"	}, \
+	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"PERFORMANCE_DEGRADED"	}, \
+	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"REPLACEMENT_NEEDED"	}  \
+)
+
+#define CXL_DHI_MS_NORMAL							0x00
+#define CXL_DHI_MS_NOT_READY							0x01
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST					0x02
+#define CXL_DHI_MS_ALL_DATA_LOST						0x03
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS			0x04
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN			0x05
+#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT				0x06
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS				0x07
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN				0x08
+#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT					0x09
+#define show_media_status(ms)	__print_symbolic(ms,			   \
+	{ CXL_DHI_MS_NORMAL,						   \
+		"Normal"						}, \
+	{ CXL_DHI_MS_NOT_READY,						   \
+		"Not Ready"						}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOST,				   \
+		"Write Persistency Lost"				}, \
+	{ CXL_DHI_MS_ALL_DATA_LOST,					   \
+		"All Data Lost"						}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS,		   \
+		"Write Persistency Loss in the Event of Power Loss"	}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN,		   \
+		"Write Persistency Loss in Event of Shutdown"		}, \
+	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT,			   \
+		"Write Persistency Loss Imminent"			}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS,		   \
+		"All Data Loss in Event of Power Loss"			}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN,		   \
+		"All Data loss in the Event of Shutdown"		}, \
+	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT,			   \
+		"All Data Loss Imminent"				}  \
+)
+
+#define CXL_DHI_AS_NORMAL		0x0
+#define CXL_DHI_AS_WARNING		0x1
+#define CXL_DHI_AS_CRITICAL		0x2
+#define show_two_bit_status(as) __print_symbolic(as,	   \
+	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
+	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
+	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
+)
+#define show_one_bit_status(as) __print_symbolic(as,	   \
+	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
+	{ CXL_DHI_AS_WARNING,		"Warning"	}  \
+)
+
+#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
+#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
+#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
+#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
+
+TRACE_EVENT(cxl_memory_module,
+
+	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
+		 struct cxl_event_mem_module *rec),
+
+	TP_ARGS(dev, log, rec),
+
+	TP_STRUCT__entry(
+		CXL_EVT_TP_entry
+
+		/* Memory Module Event */
+		__field(u8, event_type)
+
+		/* Device Health Info */
+		__field(u8, health_status)
+		__field(u8, media_status)
+		__field(u8, life_used)
+		__field(u32, dirty_shutdown_cnt)
+		__field(u32, cor_vol_err_cnt)
+		__field(u32, cor_per_err_cnt)
+		__field(s16, device_temp)
+		__field(u8, add_status)
+	),
+
+	TP_fast_assign(
+		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
+
+		/* Memory Module Event */
+		__entry->event_type = rec->event_type;
+
+		/* Device Health Info */
+		__entry->health_status = rec->info.health_status;
+		__entry->media_status = rec->info.media_status;
+		__entry->life_used = rec->info.life_used;
+		__entry->dirty_shutdown_cnt = get_unaligned_le32(rec->info.dirty_shutdown_cnt);
+		__entry->cor_vol_err_cnt = get_unaligned_le32(rec->info.cor_vol_err_cnt);
+		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
+		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
+		__entry->add_status = rec->info.add_status;
+	),
+
+	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
+		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
+		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
+		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
+		show_dev_evt_type(__entry->event_type),
+		show_health_status_flags(__entry->health_status),
+		show_media_status(__entry->media_status),
+		show_two_bit_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
+		show_two_bit_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
+		show_one_bit_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
+		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
+		__entry->life_used, __entry->device_temp,
+		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
+		__entry->cor_per_err_cnt
+	)
+);
+
 #endif /* _CXL_EVENTS_H */
 
 #define TRACE_INCLUDE_FILE trace
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 82832dd74e4c..af4f0876fdef 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -486,6 +486,32 @@ struct cxl_event_dram {
 	u8 reserved[0x17];
 } __packed;
 
+/*
+ * Get Health Info Record
+ * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+struct cxl_get_health_info {
+	u8 health_status;
+	u8 media_status;
+	u8 add_status;
+	u8 life_used;
+	u8 device_temp[2];
+	u8 dirty_shutdown_cnt[4];
+	u8 cor_vol_err_cnt[4];
+	u8 cor_per_err_cnt[4];
+} __packed;
+
+/*
+ * Memory Module Event Record
+ * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+struct cxl_event_mem_module {
+	struct cxl_event_record_hdr hdr;
+	u8 event_type;
+	struct cxl_get_health_info info;
+	u8 reserved[0x3d];
+} __packed;
+
 struct cxl_mbox_get_partition_info {
 	__le64 active_volatile_cap;
 	__le64 active_persistent_cap;

-- 
2.39.0
