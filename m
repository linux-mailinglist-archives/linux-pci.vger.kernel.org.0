Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7EE697189
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 00:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBNXFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 18:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjBNXFF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 18:05:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521D2B0BA;
        Tue, 14 Feb 2023 15:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676415867; x=1707951867;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zk/24H30V44QTrX0+hioMhDc9nF3HOTa/Kvebga8EGA=;
  b=DW6xKf447UX6+aCrlFFO24tG0LxhTdG7JEc9312cYiU4R3l+c85fPAz+
   TRuLHqM2vdMlgdfUaMRP3S6pj0Vn8gCGuwpxR+6QOdJAF51jdKGp//Lpb
   bzbuqN5g1W7jzxSAEN0nWa7PcpFsCsX8dLcAcCybDsOtL4AEMadLtWLcI
   xl5dJXaKJOnxQgYVu86wCFTHTc3d6PO7lol7MDRpl3ZuIvDvPE2bBfBcV
   55lsnM2mHS5Cpw9mLDDZ/wMnBK99/1/ViHAq6U1br9qEmQ4JbWbo/9gde
   JJIRTjmO5nklOy77cElg/LIzdGPkmaaUscPIx+C8MR0zxcm2cTD717Noq
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329007444"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="329007444"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:03:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="669378412"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="669378412"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.93.192]) ([10.212.93.192])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 15:03:28 -0800
Message-ID: <8b2bbf7b-fe3f-c80b-163b-8247e0c47821@intel.com>
Date:   Tue, 14 Feb 2023 16:03:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 13/18] cxl: Add latency and bandwidth calculations for the
 CXL path
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, rafael@kernel.org, bhelgaas@google.com,
        robert.moore@intel.com
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
 <167571667794.587790.14172786993094257614.stgit@djiang5-mobl3.local>
 <20230209152417.00007f47@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230209152417.00007f47@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2/9/23 8:24 AM, Jonathan Cameron wrote:
> On Mon, 06 Feb 2023 13:51:19 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
>> caluclate latency and bandwidth for CXL memory device. Calculate minimum
> 
> Spell check your descriptions (I often forget to do this as well!
> )
>> bandwidth and total latency for the path from the CXL device to the root
>> port. The calculates values are stored in the cached DSMAS entries attached
>> to the cxl_port of the CXL device.
>>
>> For example for a device that is directly attached to a host bus:
>> Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
>> 		Latency
>> Min Bandwidth = Link Bandwidth between Host Bus and CXL device
>>
>> For a device that has a switch in between host bus and CXL device:
>> Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
>> 		Switch (CDAT) Latency + Switch to HB Link Latency
> 
> For QTG purposes, are we also supposed to take into account HB to
> system interconnect type latency (or maybe nearest CPU?).
> That is likely to be non trivial.

Dan brought this ECN [1] to my attention. We can add this if we can find 
a BIOS that implements the ECN. Or should we code a place holder for it 
until this is available?

https://lore.kernel.org/linux-cxl/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/

> 
>> Min Bandwidth = min(dev to switch bandwidth, switch to HB bandwidth)
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Stray sign off.
> 
>>
>> The internal latency for a switch can be retrieved from the CDAT of the
>> switch PCI device. However, since there's no easy way to retrieve that
>> right now on Linux, a guesstimated constant is used per switch to simplify
>> the driver code.
> 
> I'd like to see that gap closed asap. I think it is fairly obvious how to do
> it, so shouldn't be too hard, just needs a dance to get the DOE for a switch
> port using Lukas' updated handling of DOE mailboxes.

Talked to Lukas and this may not be difficult with his latest changes. I 
can take a look. Do we support switch CDAT in QEMU yet?

> 
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/port.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h       |    9 +++++++
>>   drivers/cxl/port.c      |   42 +++++++++++++++++++++++++++++++++
>>   3 files changed, 111 insertions(+)
>>
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 2b27319cfd42..aa260361ba7d 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -1899,6 +1899,66 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>>   
>> +int cxl_port_get_downstream_qos(struct cxl_port *port, long *bw, long *lat)
>> +{
>> +	long total_lat = 0, latency;
> 
> Similar to before, not good for readability to hide asignments in a list all on one line.
> 
