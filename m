Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700D36FD239
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 00:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjEIWI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 18:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjEIWI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 18:08:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2994C4498;
        Tue,  9 May 2023 15:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683670106; x=1715206106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sPVyYMoOpz4OLD+LBv/kiP3jyMi6pwJbGrXHjxsYGrQ=;
  b=IRoCEFPQBeamnvnIcOjhfDPxd/By2QFNzZ2wxU/EmgOYfwf3VvI2CP8X
   lyJV6jWlnSa3XD0qsEfg8aEQ5fhJMWMZR1YF3QjvE41+alt/0OuysiKNS
   yMcxzKl0BqueshEecBs1P9zZTByqXN8CenZVgUs4Sly0oWLiyRUpNzeaR
   ggdpTrVW4oL/d8tgWzP4dwPP2rj3pl18rYAlJmcQ1XwggLToWq0qece5t
   SaCSS5awoNv//DlwX2bAC8U+7/frrNiqrWkXtAOV/YVHHl5YvCVae4/4x
   /6JsFnS6gHvpxIxVCe7acymMY+oCDyHnwBN/V+0nsecP3gGE0qvSPgVlv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436385506"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="436385506"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 15:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="945453305"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="945453305"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.97.226]) ([10.212.97.226])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 15:08:24 -0700
Message-ID: <3d320d04-a0e6-12dd-490a-f0111c2ad98a@intel.com>
Date:   Tue, 9 May 2023 15:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v7 7/8] cxl/test: Add specific events
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
 <20221216-cxl-ev-log-v7-7-2316a5c8f7d8@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-7-2316a5c8f7d8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/17/23 10:53 PM, Ira Weiny wrote:
> Each type of event has different trace point outputs.
> 
> Add mock General Media Event, DRAM event, and Memory Module Event
> records to the mock list of events returned.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes in v7:
>          <no change>
> ---
>   tools/testing/cxl/test/mem.c | 73 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 73 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 90a463f83ae4..00bf19a68604 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -277,12 +277,85 @@ struct cxl_event_record_raw hardware_replace = {
>   	.data = { 0xDE, 0xAD, 0xBE, 0xEF },
>   };
>   
> +struct cxl_event_gen_media gen_media = {
> +	.hdr = {
> +		.id = UUID_INIT(0xfbcd0a77, 0xc260, 0x417f,
> +				0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
> +		.length = sizeof(struct cxl_event_gen_media),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_PERMANENT,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.phys_addr = cpu_to_le64(0x2000),
> +	.descriptor = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT,
> +	.type = CXL_GMER_MEM_EVT_TYPE_DATA_PATH_ERROR,
> +	.transaction_type = CXL_GMER_TRANS_HOST_WRITE,
> +	/* .validity_flags = <set below> */
> +	.channel = 1,
> +	.rank = 30
> +};
> +
> +struct cxl_event_dram dram = {
> +	.hdr = {
> +		.id = UUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,
> +				0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> +		.length = sizeof(struct cxl_event_dram),
> +		.flags[0] = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.phys_addr = cpu_to_le64(0x8000),
> +	.descriptor = CXL_GMER_EVT_DESC_THRESHOLD_EVENT,
> +	.type = CXL_GMER_MEM_EVT_TYPE_INV_ADDR,
> +	.transaction_type = CXL_GMER_TRANS_INTERNAL_MEDIA_SCRUB,
> +	/* .validity_flags = <set below> */
> +	.channel = 1,
> +	.bank_group = 5,
> +	.bank = 2,
> +	.column = {0xDE, 0xAD},
> +};
> +
> +struct cxl_event_mem_module mem_module = {
> +	.hdr = {
> +		.id = UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> +				0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74),
> +		.length = sizeof(struct cxl_event_mem_module),
> +		/* .handle = Set dynamically */
> +		.related_handle = cpu_to_le16(0),
> +	},
> +	.event_type = CXL_MMER_TEMP_CHANGE,
> +	.info = {
> +		.health_status = CXL_DHI_HS_PERFORMANCE_DEGRADED,
> +		.media_status = CXL_DHI_MS_ALL_DATA_LOST,
> +		.add_status = (CXL_DHI_AS_CRITICAL << 2) |
> +			      (CXL_DHI_AS_WARNING << 4) |
> +			      (CXL_DHI_AS_WARNING << 5),
> +		.device_temp = { 0xDE, 0xAD},
> +		.dirty_shutdown_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +		.cor_vol_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +		.cor_per_err_cnt = { 0xde, 0xad, 0xbe, 0xef },
> +	}
> +};
> +
>   static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>   {
> +	put_unaligned_le16(CXL_GMER_VALID_CHANNEL | CXL_GMER_VALID_RANK,
> +			   &gen_media.validity_flags);
> +
> +	put_unaligned_le16(CXL_DER_VALID_CHANNEL | CXL_DER_VALID_BANK_GROUP |
> +			   CXL_DER_VALID_BANK | CXL_DER_VALID_COLUMN,
> +			   &dram.validity_flags);
> +
>   	mes_add_event(mes, CXL_EVENT_TYPE_INFO, &maint_needed);
> +	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> +		      (struct cxl_event_record_raw *)&gen_media);
> +	mes_add_event(mes, CXL_EVENT_TYPE_INFO,
> +		      (struct cxl_event_record_raw *)&mem_module);
>   	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>   
>   	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
> +		      (struct cxl_event_record_raw *)&dram);
>   	mes->ev_status |= CXLDEV_EVENT_STATUS_FATAL;
>   }
>   
> 
