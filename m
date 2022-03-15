Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BEC4DA499
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 22:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbiCOVah (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 17:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbiCOVah (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 17:30:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CF31BEB1;
        Tue, 15 Mar 2022 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647379764; x=1678915764;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A7BNzJil5UVOdacWFDYWEMOTLH+DuBVapnx31WlTQXY=;
  b=ElKfy/Iu4/s7abPLQTIeEQBXsrWkgyh6N8XY1/dvQjCfwSdJwth58+Np
   VRb/ifXZ9FnCKUqmTvQGybKv7uWlA+aXFtD7RQeCXuHMjWNOiKL3TiYMM
   LTt95iszkV0yFIHpwPiWDkJaL/Yv/WdqhGIijKegPhBOUjyvfA/+PGX3q
   bOf2KPq2MbibTq2wS/U9xEXLeYlrGS1VicSnh87t1LvBrFQSGarxT1WaO
   qgoc7odbymN4mgMuKLUyxJXC52NVk51V38Vgt7MkaXcAU1xxXvLGijk+y
   F7KnmAoIdP1quq1KPwJZ+R1Dsqd8K4srNJIqsEwlAeZRlpN6cqCX0gcdg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255256380"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="255256380"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:29:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="512767160"
Received: from rariley-mobl.amr.corp.intel.com (HELO [10.209.120.225]) ([10.209.120.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:29:23 -0700
Message-ID: <f794a3fb-4d3a-7e3d-1600-27ee831526fd@linux.intel.com>
Date:   Tue, 15 Mar 2022 14:29:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] PCI/AER: Handle Multi UnCorrectable/Correctable errors
 properly
Content-Language: en-US
To:     Eric Badger <ebadger@purestorage.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220315171425.GA1521135@ebps>
 <2d4e8811-dce6-c891-e92d-e3746434685e@linux.intel.com>
 <20220315195255.GA1523195@ebps>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220315195255.GA1523195@ebps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 3/15/22 12:52 PM, Eric Badger wrote:
> On Tue, Mar 15, 2022 at 10:26:46AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 3/15/22 10:14 AM, Eric Badger wrote:
>>>>    # Prep injection data for a correctable error.
>>>>    $ cd /sys/kernel/debug/apei/einj
>>>>    $ echo 0x00000040 > error_type
>>>>    $ echo 0x4 > flags
>>>>    $ echo 0x891000 > param4
>>>>
>>>>    # Root Error Status is initially clear
>>>>    $ setpci -s <Dev ID> ECAP0001+0x30.w
>>>>    0000
>>>>
>>>>    # Inject one error
>>>>    $ echo 1 > error_inject
>>>>
>>>>    # Interrupt received
>>>>    pcieport <Dev ID>: AER: Root Error Status 0001
>>>>
>>>>    # Inject another error (within 5 seconds)
>>>>    $ echo 1 > error_inject
>>>>
>>>>    # No interrupt received, but "multiple ERR_COR" is now set
>>>>    $ setpci -s <Dev ID> ECAP0001+0x30.w
>>>>    0003
>>>>
>>>>    # Wait for a while, then clear ERR_COR. A new interrupt immediately
>>>>      fires.
>>>>    $ setpci -s <Dev ID> ECAP0001+0x30.w=0x1
>>>>    pcieport <Dev ID>: AER: Root Error Status 0002
>>>>
>>>> Currently, the above issue has been only reproduced in the ICL server
>>>> platform.
>>>>
>>>> [Eric: proposed reproducing steps]
>>> Hmm, this differs from the procedure I described on v1, and I don't
>>> think will work as described here.
>>
>> I have attempted to modify the steps to reproduce it without returning
>> IRQ_NONE for all cases (which will break the functionality). But I
>> think I did not correct the last few steps.
> 
> Well, the thinking in always returning IRQ_NONE was so that only setpci
> modified the register and we could clearly see how writes to the
> register affect interrupt generation.

Got it. Makes sense.

> 
>> How about replacing the last 3 steps with following?
>>
>>   # Inject another error (within 5 seconds)
>>   $ echo 1 > error_inject
>>
>>   # You will get a new IRQ with only multiple ERR_COR bit set
>>   pcieport <Dev ID>: AER: Root Error Status 0002
> 
> This seems accurate. Though it does muddy a detail that I think was
> clearer in the original procedure: was the second interrupt triggered by
> the second error, or by the write of 0x1 to Root Error Status?

I think you are talking about the following command, right?

setpci -s <Dev ID> ECAP0001+0x30.w=0x1

If yes, my previously modified instructions already removed it. So
no confusion.

To summarize,

In your case, you have controlled both register read/write of Root
error status register to simulate the interrupt with only multi
ERR_COR bit set.

In my case, I have attempted to simulate it without changing the
default behavior of aer_irq() in the kernel.

Both seem ok to me. Although my personal preference is to trigger
the error without changing the code behavior, if both you and Bjorn
prefer to revert to old instructions, I will fix this in the next version.


> 
> Cheers,
> Eric

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
