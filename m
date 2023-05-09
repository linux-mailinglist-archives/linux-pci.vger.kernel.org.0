Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131BC6FD2AE
	for <lists+linux-pci@lfdr.de>; Wed, 10 May 2023 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbjEIWbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 May 2023 18:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjEIWbv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 May 2023 18:31:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639BE10F7;
        Tue,  9 May 2023 15:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683671507; x=1715207507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1R2Gg6wlaBtXe+4zx8PrBpi9i8hSxKDH4nvvTPsLK2E=;
  b=RFurPuMGXS6KGqG2LxYWQzmrO4vLHIPV7BLP9GZ8HodizhjSwVXCtPob
   YjbkyAdsEtczC9JWeB+A5NNnN0ReIVM5chBaFa9CM0zpwv7gg98SGP1px
   HJo1x50zNlVpeFDEySw/UadnTztIJ9lwcBl25alyIiD957s3EuyhEL6Mh
   ltY2eVlOp+YU8y7frSWq0j8qRUvHK/H4Rqk7lEdOQZPQhAmNNV4U6qa7w
   i1Wzn37T4HUHVrquzV8ZJu6VxNyuRFFjKUedi72N4ntH1AMYMV/uE66b/
   F4JG3OMmw0U2WoRyEMGsSknG4vVGgNPEoDs4hBP4QVBBidC2PKtlelR/u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="330430580"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="330430580"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 15:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="649520053"
X-IronPort-AV: E=Sophos;i="5.99,263,1677571200"; 
   d="scan'208";a="649520053"
Received: from dcovax-mobl.amr.corp.intel.com (HELO [10.212.97.226]) ([10.212.97.226])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 15:31:43 -0700
Message-ID: <7d35c9f2-9070-32d0-2ddc-ff6b0a8b5c26@intel.com>
Date:   Tue, 9 May 2023 15:31:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v7 8/8] cxl/test: Simulate event log overflow
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
 <20221216-cxl-ev-log-v7-8-2316a5c8f7d8@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221216-cxl-ev-log-v7-8-2316a5c8f7d8@intel.com>
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
> Log overflow is marked by a separate trace message.
> 
> Simulate a log with lots of messages and flag overflow until space is
> cleared.
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
>   tools/testing/cxl/test/mem.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 00bf19a68604..9263b04d35f7 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -78,6 +78,8 @@ struct mock_event_log {
>   	u16 clear_idx;
>   	u16 cur_idx;
>   	u16 nr_events;
> +	u16 nr_overflow;
> +	u16 overflow_reset;
>   	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
>   };
>   
> @@ -116,6 +118,7 @@ static void event_reset_log(struct mock_event_log *log)
>   {
>   	log->cur_idx = 0;
>   	log->clear_idx = 0;
> +	log->nr_overflow = log->overflow_reset;
>   }
>   
>   /* Handle can never be 0 use 1 based indexing for handle */
> @@ -147,8 +150,12 @@ static void mes_add_event(struct mock_event_store *mes,
>   		return;
>   
>   	log = &mes->mock_logs[log_type];
> -	if (WARN_ON(log->nr_events >= CXL_TEST_EVENT_CNT_MAX))
> +
> +	if ((log->nr_events + 1) > CXL_TEST_EVENT_CNT_MAX) {
> +		log->nr_overflow++;
> +		log->overflow_reset = log->nr_overflow;
>   		return;
> +	}
>   
>   	log->events[log->nr_events] = event;
>   	log->nr_events++;
> @@ -159,6 +166,7 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
>   {
>   	struct cxl_get_event_payload *pl;
>   	struct mock_event_log *log;
> +	u16 nr_overflow;
>   	u8 log_type;
>   	int i;
>   
> @@ -191,6 +199,19 @@ static int mock_get_event(struct cxl_dev_state *cxlds,
>   	if (!event_log_empty(log))
>   		pl->flags |= CXL_GET_EVENT_FLAG_MORE_RECORDS;
>   
> +	if (log->nr_overflow) {
> +		u64 ns;
> +
> +		pl->flags |= CXL_GET_EVENT_FLAG_OVERFLOW;
> +		pl->overflow_err_count = cpu_to_le16(nr_overflow);
> +		ns = ktime_get_real_ns();
> +		ns -= 5000000000; /* 5s ago */
> +		pl->first_overflow_timestamp = cpu_to_le64(ns);
> +		ns = ktime_get_real_ns();
> +		ns -= 1000000000; /* 1s ago */
> +		pl->last_overflow_timestamp = cpu_to_le64(ns);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -231,6 +252,9 @@ static int mock_clear_event(struct cxl_dev_state *cxlds,
>   		}
>   	}
>   
> +	if (log->nr_overflow)
> +		log->nr_overflow = 0;
> +
>   	/* Clear events */
>   	log->clear_idx += pl->nr_recs;
>   	return 0;
> @@ -353,6 +377,30 @@ static void cxl_mock_add_event_logs(struct mock_event_store *mes)
>   		      (struct cxl_event_record_raw *)&mem_module);
>   	mes->ev_status |= CXLDEV_EVENT_STATUS_INFO;
>   
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &maint_needed);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +		      (struct cxl_event_record_raw *)&dram);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +		      (struct cxl_event_record_raw *)&gen_media);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +		      (struct cxl_event_record_raw *)&mem_module);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL,
> +		      (struct cxl_event_record_raw *)&dram);
> +	/* Overflow this log */
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes_add_event(mes, CXL_EVENT_TYPE_FAIL, &hardware_replace);
> +	mes->ev_status |= CXLDEV_EVENT_STATUS_FAIL;
> +
>   	mes_add_event(mes, CXL_EVENT_TYPE_FATAL, &hardware_replace);
>   	mes_add_event(mes, CXL_EVENT_TYPE_FATAL,
>   		      (struct cxl_event_record_raw *)&dram);
> 
