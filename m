Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CBF6FD1A8
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 23:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjEIVwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjEIVwS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 17:52:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE530CB;
        Tue,  9 May 2023 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683669137; x=1715205137;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aY3sj0838H3phyC7aslgMHty3wURSyxQyFlG8o8LJLc=;
  b=RbXr9HXrJ8fLMUAu4BnSJ0358j2LCCgJ9RKLASZgJ7mXm1pfRj5c8qvP
   5PqIJro+XCyrLx10dNX3DoF+GWZXTOy47TyjJfpZulzYBXXtOc8xIh9ws
   xQ4OgnOEXC1m7dl701bJ/tDdC4JUreZfGH7PdPoH8SxqcIHYiR87vjBdI
   65HDBx0VB4/mBjhi62X1PeDJ4j9fW0RXfBWHA+cDfRyYOXavgOLrJk2o3
   7YYNpvlf8cjN/BCS2LyP0g1oNBFfhK2t/AERCzv1ZIMYBvV/4cA8RO8WA
   XZy3LnkzWmtM9GCDrxxwH8jEC3sub2HYADJauvNmWqhtkA4a+FPLFk2kJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="347524396"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="347524396"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 14:52:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="693153864"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="693153864"
Received: from dcovax-mobl.amr.corp.intel.com (HELO [10.212.97.226]) ([10.212.97.226])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 14:52:15 -0700
Message-ID: <62c0eda2-0409-4745-7267-c8e8e5352c49@intel.com>
Date:   Tue, 9 May 2023 14:52:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v7 5/8] cxl/mem: Trace Memory Module Event Record
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20221216-cxl-ev-log-v7-0-2316a5c8f7d8@intel.com>
 <20221216-cxl-ev-log-v7-5-2316a5c8f7d8@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-5-2316a5c8f7d8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/17/23 10:53 PM, Ira Weiny wrote:
> CXL rev 3.0 section 8.2.9.2.1.3 defines the Memory Module Event Record.
> 
> Determine if the event read is memory module record and if so trace the
> record.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Just a minor nit below
> ---
> Changes in v7:
> 	Jonathan
> 		Fix LSA spelling
> ---
>   drivers/cxl/core/mbox.c  |  13 +++++
>   drivers/cxl/core/trace.h | 143 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h     |  26 +++++++++
>   3 files changed, 182 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 552d98bc9f93..6ed8e3654939 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -734,6 +734,14 @@ static const uuid_t dram_event_uuid =
>   	UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
>   		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24);
>   
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +static const uuid_t mem_mod_event_uuid =
> +	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> +		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
> +
>   static void cxl_event_trace_record(const struct device *dev,
>   				   enum cxl_event_log_type type,
>   				   struct cxl_event_record_raw *record)
> @@ -749,6 +757,11 @@ static void cxl_event_trace_record(const struct device *dev,
>   		struct cxl_event_dram *rec = (struct cxl_event_dram *)record;
>   
>   		trace_cxl_dram(dev, type, rec);
> +	} else if (uuid_equal(id, &mem_mod_event_uuid)) {
> +		struct cxl_event_mem_module *rec =
> +				(struct cxl_event_mem_module *)record;
> +
> +		trace_cxl_memory_module(dev, type, rec);
>   	} else {
>   		/* For unknown record types print just the header */
>   		trace_cxl_generic_event(dev, type, record);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index b6321cfb1d9f..c7e2af9d9c4d 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -439,6 +439,149 @@ TRACE_EVENT(cxl_dram,
>   	)
>   );
>   
> +/*
> + * Memory Module Event Record - MMER
> + *
> + * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +#define CXL_MMER_HEALTH_STATUS_CHANGE		0x00
> +#define CXL_MMER_MEDIA_STATUS_CHANGE		0x01
> +#define CXL_MMER_LIFE_USED_CHANGE		0x02
> +#define CXL_MMER_TEMP_CHANGE			0x03
> +#define CXL_MMER_DATA_PATH_ERROR		0x04
> +#define CXL_MMER_LSA_ERROR			0x05
> +#define show_dev_evt_type(type)	__print_symbolic(type,			   \
> +	{ CXL_MMER_HEALTH_STATUS_CHANGE,	"Health Status Change"	}, \
> +	{ CXL_MMER_MEDIA_STATUS_CHANGE,		"Media Status Change"	}, \
> +	{ CXL_MMER_LIFE_USED_CHANGE,		"Life Used Change"	}, \
> +	{ CXL_MMER_TEMP_CHANGE,			"Temperature Change"	}, \
> +	{ CXL_MMER_DATA_PATH_ERROR,		"Data Path Error"	}, \
> +	{ CXL_MMER_LSA_ERROR,			"LSA Error"		}  \
> +)
> +
> +/*
> + * Device Health Information - DHI
> + *
> + * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
> +#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
> +#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
> +#define show_health_status_flags(flags)	__print_flags(flags, "|",	   \
> +	{ CXL_DHI_HS_MAINTENANCE_NEEDED,	"MAINTENANCE_NEEDED"	}, \
> +	{ CXL_DHI_HS_PERFORMANCE_DEGRADED,	"PERFORMANCE_DEGRADED"	}, \
> +	{ CXL_DHI_HS_HW_REPLACEMENT_NEEDED,	"REPLACEMENT_NEEDED"	}  \
> +)
> +
> +#define CXL_DHI_MS_NORMAL							0x00
> +#define CXL_DHI_MS_NOT_READY							0x01
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOST					0x02
> +#define CXL_DHI_MS_ALL_DATA_LOST						0x03
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS			0x04
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN			0x05
> +#define CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT				0x06
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS				0x07
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN				0x08
> +#define CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT					0x09
> +#define show_media_status(ms)	__print_symbolic(ms,			   \
> +	{ CXL_DHI_MS_NORMAL,						   \
> +		"Normal"						}, \
> +	{ CXL_DHI_MS_NOT_READY,						   \
> +		"Not Ready"						}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOST,				   \
> +		"Write Persistency Lost"				}, \
> +	{ CXL_DHI_MS_ALL_DATA_LOST,					   \
> +		"All Data Lost"						}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_POWER_LOSS,		   \
> +		"Write Persistency Loss in the Event of Power Loss"	}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_EVENT_SHUTDOWN,		   \
> +		"Write Persistency Loss in Event of Shutdown"		}, \
> +	{ CXL_DHI_MS_WRITE_PERSISTENCY_LOSS_IMMINENT,			   \
> +		"Write Persistency Loss Imminent"			}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_POWER_LOSS,		   \
> +		"All Data Loss in Event of Power Loss"			}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_EVENT_SHUTDOWN,		   \
> +		"All Data loss in the Event of Shutdown"		}, \
> +	{ CXL_DHI_MS_WRITE_ALL_DATA_LOSS_IMMINENT,			   \
> +		"All Data Loss Imminent"				}  \
> +)
> +
> +#define CXL_DHI_AS_NORMAL		0x0
> +#define CXL_DHI_AS_WARNING		0x1
> +#define CXL_DHI_AS_CRITICAL		0x2
> +#define show_two_bit_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}, \
> +	{ CXL_DHI_AS_CRITICAL,		"Critical"	}  \
> +)
> +#define show_one_bit_status(as) __print_symbolic(as,	   \
> +	{ CXL_DHI_AS_NORMAL,		"Normal"	}, \
> +	{ CXL_DHI_AS_WARNING,		"Warning"	}  \
> +)
> +
> +#define CXL_DHI_AS_LIFE_USED(as)			(as & 0x3)
> +#define CXL_DHI_AS_DEV_TEMP(as)				((as & 0xC) >> 2)
> +#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)			((as & 0x10) >> 4)
> +#define CXL_DHI_AS_COR_PER_ERR_CNT(as)			((as & 0x20) >> 5)
> +
> +TRACE_EVENT(cxl_memory_module,
> +
> +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> +		 struct cxl_event_mem_module *rec),
> +
> +	TP_ARGS(dev, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Memory Module Event */
> +		__field(u8, event_type)
> +
> +		/* Device Health Info */
> +		__field(u8, health_status)
> +		__field(u8, media_status)
> +		__field(u8, life_used)
> +		__field(u32, dirty_shutdown_cnt)
> +		__field(u32, cor_vol_err_cnt)
> +		__field(u32, cor_per_err_cnt)
> +		__field(s16, device_temp)
> +		__field(u8, add_status)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> +
> +		/* Memory Module Event */
> +		__entry->event_type = rec->event_type;
> +
> +		/* Device Health Info */
> +		__entry->health_status = rec->info.health_status;
> +		__entry->media_status = rec->info.media_status;
> +		__entry->life_used = rec->info.life_used;
> +		__entry->dirty_shutdown_cnt = get_unaligned_le32(rec->info.dirty_shutdown_cnt);
> +		__entry->cor_vol_err_cnt = get_unaligned_le32(rec->info.cor_vol_err_cnt);
> +		__entry->cor_per_err_cnt = get_unaligned_le32(rec->info.cor_per_err_cnt);
> +		__entry->device_temp = get_unaligned_le16(rec->info.device_temp);
> +		__entry->add_status = rec->info.add_status;
> +	),
> +
> +	CXL_EVT_TP_printk("event_type='%s' health_status='%s' media_status='%s' " \
> +		"as_life_used=%s as_dev_temp=%s as_cor_vol_err_cnt=%s " \
> +		"as_cor_per_err_cnt=%s life_used=%u device_temp=%d " \
> +		"dirty_shutdown_cnt=%u cor_vol_err_cnt=%u cor_per_err_cnt=%u",
> +		show_dev_evt_type(__entry->event_type),
> +		show_health_status_flags(__entry->health_status),
> +		show_media_status(__entry->media_status),
> +		show_two_bit_status(CXL_DHI_AS_LIFE_USED(__entry->add_status)),
> +		show_two_bit_status(CXL_DHI_AS_DEV_TEMP(__entry->add_status)),
> +		show_one_bit_status(CXL_DHI_AS_COR_VOL_ERR_CNT(__entry->add_status)),
> +		show_one_bit_status(CXL_DHI_AS_COR_PER_ERR_CNT(__entry->add_status)),
> +		__entry->life_used, __entry->device_temp,
> +		__entry->dirty_shutdown_cnt, __entry->cor_vol_err_cnt,
> +		__entry->cor_per_err_cnt
> +	)
> +);
> +
>   #endif /* _CXL_EVENTS_H */
>   
>   #define TRACE_INCLUDE_FILE trace
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 82832dd74e4c..af4f0876fdef 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -486,6 +486,32 @@ struct cxl_event_dram {
>   	u8 reserved[0x17];
>   } __packed;
>   
> +/*
> + * Get Health Info Record
> + * CXL rev 3.0 section 8.2.9.8.3.1; Table 8-100
> + */
> +struct cxl_get_health_info {
> +	u8 health_status;
> +	u8 media_status;
> +	u8 add_status;
> +	u8 life_used;
> +	u8 device_temp[2];
> +	u8 dirty_shutdown_cnt[4];
> +	u8 cor_vol_err_cnt[4];
> +	u8 cor_per_err_cnt[4];
> +} __packed;
> +
> +/*
> + * Memory Module Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +struct cxl_event_mem_module {
> +	struct cxl_event_record_hdr hdr;
> +	u8 event_type;
> +	struct cxl_get_health_info info;
> +	u8 reserved[0x3d];

Use decimal instead of hex for the array size?

> +} __packed;
> +
>   struct cxl_mbox_get_partition_info {
>   	__le64 active_volatile_cap;
>   	__le64 active_persistent_cap;
> 
