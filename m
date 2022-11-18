Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5D962FBAE
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiKRRcM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbiKRRbq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:31:46 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BDD922C4;
        Fri, 18 Nov 2022 09:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668792705; x=1700328705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FK7VWWZnBEBBQNB3Od04oVvJc7SjUNlUBNNk/tfoy3E=;
  b=Y7en3z9AVR4RQylqkAB1Pw9YwszWVtS2JljaRU7JptLn8jXbSDuayWee
   KcNfK1ehn2xuhnNxR4ZwjE4oo56juqAzWfvGEXg0L5ZpL9sTJMhHdOM3d
   jDz+sWk0Qzwg8Tok/e/4ZI8TS5ZPZ1WvFvmwXwftYOg6ulk95qQL6Tskz
   SgfYBE3ibELpDgwpBs3TCZg5tcYKMl1ZgoUrRw3xW3diWdPE//V1CGJA8
   woyqKDV1+9aTlkgPzSDpepZKBwLizC1Cg8ILQ2TFUOTB7AA2aEnmYn4UU
   MS582bnJahwBm7dIivYnMQo+Iw5cpxEPg7RBaytkZ4DWHr7jTDEfsQ26B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="340031487"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="340031487"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:31:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703816775"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="703816775"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.83.104]) ([10.212.83.104])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:31:44 -0800
Message-ID: <e9db375a-34bd-cc21-7650-a9d074a060b7@intel.com>
Date:   Fri, 18 Nov 2022 10:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v3 08/11] cxl/pci: add tracepoint events for CXL RAS
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, terry.bowman@amd.com,
        bhelgaas@google.com
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
 <166879132997.674819.12112190531427523276.stgit@djiang5-desk3.ch.intel.com>
 <20221118121731.128df10c@gandalf.local.home>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221118121731.128df10c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/18/2022 10:17 AM, Steven Rostedt wrote:
> On Fri, 18 Nov 2022 10:08:49 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> +TRACE_EVENT(cxl_aer_uncorrectable_error,
>> +	TP_PROTO(const char *dev_name, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(dev_name, status, fe, hl),
>> +	TP_STRUCT__entry(
>> +		__string(dev_name, dev_name)
>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__dynamic_array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> 
> If this is a fixed size, you do not need to use __dynamic_array, but
> instead just use __array()
> 
> 		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32);

Thanks! I will update.

> 
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(dev_name, dev_name);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		/*
>> +		 * Embed the 512B headerlog data for user app retrieval and
>> +		 * parsing, but no need to print this in the trace buffer.
>> +		 */
>> +		memcpy(__get_dynamic_array(header_log), hl, CXL_HEADERLOG_SIZE);
> 
> 		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> 
> This will be smaller and faster.
> 
> -- Steve
> 
> 
>> +	),
>> +	TP_printk("%s: status: '%s' first_error: '%s'",
>> +		  __get_str(dev_name),
>> +		  show_uc_errs(__entry->status),
>> +		  show_uc_errs(__entry->first_error)
>> +	)
>> +);
>> +
