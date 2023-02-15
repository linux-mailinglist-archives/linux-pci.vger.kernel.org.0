Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84D369810B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 17:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBOQjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Feb 2023 11:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjBOQjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Feb 2023 11:39:02 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D03432B;
        Wed, 15 Feb 2023 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676479135; x=1708015135;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SA6yZ1GuWbNnqcPK4T064NP2+l9OXsQyEUrjHXqnI2Y=;
  b=QkBPVo1l4eFDIis4xhnGYEzybT9Jxs+beJvW2zOSdFfspbgU/9JmUo3b
   BeaqZUb4ffdubmU9ooTXm+AcPfndzT4mQpe01UtUhV+NZgm5nXQqd10yv
   mKw6UG2LuEPAF/EcSCbCnKgn8SoHFxWNJwY72R9FSwzGKTOJAzqZKjI9P
   yzXDix42CPymBA5daEX/N8iCh79jxRraS7/NKm2hOrHI5EIaL0QqJrbck
   xfoCT3jyuioCYwrAofPXKmaxkJoRJcJ+jgclnC9ZxrVn88SV+oqEKMWZF
   N+fHwEJ3hoGSdjcPUVsW3dSlJCTWYZpJx9Db0nAzl40A5VwlJGJdGRSSo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="311838684"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="311838684"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:38:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10622"; a="812525207"
X-IronPort-AV: E=Sophos;i="5.97,300,1669104000"; 
   d="scan'208";a="812525207"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.39.121]) ([10.212.39.121])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 08:38:54 -0800
Message-ID: <6c15f65d-d007-ff7e-55c7-a1c120ac1c62@intel.com>
Date:   Wed, 15 Feb 2023 09:38:53 -0700
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
 <8b2bbf7b-fe3f-c80b-163b-8247e0c47821@intel.com>
 <20230215131706.0000592d@Huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230215131706.0000592d@Huawei.com>
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



On 2/15/23 6:17 AM, Jonathan Cameron wrote:
> On Tue, 14 Feb 2023 16:03:27 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 2/9/23 8:24 AM, Jonathan Cameron wrote:
>>> On Mon, 06 Feb 2023 13:51:19 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>    
>>>> CXL Memory Device SW Guide rev1.0 2.11.2 provides instruction on how to
>>>> caluclate latency and bandwidth for CXL memory device. Calculate minimum
>>>
>>> Spell check your descriptions (I often forget to do this as well!
>>> )
>>>> bandwidth and total latency for the path from the CXL device to the root
>>>> port. The calculates values are stored in the cached DSMAS entries attached
>>>> to the cxl_port of the CXL device.
>>>>
>>>> For example for a device that is directly attached to a host bus:
>>>> Total Latency = Device Latency (from CDAT) + Dev to Host Bus (HB) Link
>>>> 		Latency
>>>> Min Bandwidth = Link Bandwidth between Host Bus and CXL device
>>>>
>>>> For a device that has a switch in between host bus and CXL device:
>>>> Total Latency = Device (CDAT) Latency + Dev to Switch Link Latency +
>>>> 		Switch (CDAT) Latency + Switch to HB Link Latency
>>>
>>> For QTG purposes, are we also supposed to take into account HB to
>>> system interconnect type latency (or maybe nearest CPU?).
>>> That is likely to be non trivial.
>>
>> Dan brought this ECN [1] to my attention. We can add this if we can find
>> a BIOS that implements the ECN. Or should we code a place holder for it
>> until this is available?
>>
>> https://lore.kernel.org/linux-cxl/e1a52da9aec90766da5de51b1b839fd95d63a5af.camel@intel.com/
> 
> I've had Generic Ports on my list to add to QEMU for a while but not been
> high enough priority to either do it myself, or make it someone else's problem.
> I suspect the biggest barrier in QEMU is going to be the interface to add
> these to the NUMA description.
> 
> It's easy enough to hand build and inject a SRAT /SLIT/HMAT tables with
> these in (that's how we developed the Generic Initiator support in Linux before
> any BIOS support).
> 
> So I'd like to see it soon, but I'm not hugely bothered if that element
> follows this patch set. However, we are potentially going to see different
> decisions made when that detail is added so it 'might' count as ABI
> breakage if it's not there from the start. I think we are fine as probably
> no BIOS' yet though.
> 
>>
>>>    
>>>> Min Bandwidth = min(dev to switch bandwidth, switch to HB bandwidth)
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> Stray sign off.
>>>    
>>>>
>>>> The internal latency for a switch can be retrieved from the CDAT of the
>>>> switch PCI device. However, since there's no easy way to retrieve that
>>>> right now on Linux, a guesstimated constant is used per switch to simplify
>>>> the driver code.
>>>
>>> I'd like to see that gap closed asap. I think it is fairly obvious how to do
>>> it, so shouldn't be too hard, just needs a dance to get the DOE for a switch
>>> port using Lukas' updated handling of DOE mailboxes.
>>
>> Talked to Lukas and this may not be difficult with his latest changes. I
>> can take a look. Do we support switch CDAT in QEMU yet?
> 
> I started typing no, then thought I'd just check.  Seems I did write support
> for CDAT on switches (and then completely forgot about it ;)
> It's upstream and everything!
> https://elixir.bootlin.com/qemu/latest/source/hw/pci-bridge/cxl_upstream.c#L194
> 
Awesome! I'll go poke around a bit. Also it's very helpful to see the 
creation code. Helped me realize that I need to support parsing of 
SSLBIS sub-table for switches. Thanks!
