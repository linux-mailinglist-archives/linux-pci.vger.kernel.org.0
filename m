Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B91774F7F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 01:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjHHXoa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 19:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHHXoa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 19:44:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7F619AD
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 16:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691538269; x=1723074269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gw1QqayeHzblxn9dakKceoVHdLLyFxIaJdlUf5wypeM=;
  b=SRhPHuBzVjEMSmx+12jtbVrako4nRBJp5z0d6GIOWsXu6NwQyC/2pLy3
   0lD5sMM+31k7y0cYoE9ET2dZ1pWr1gccoNjwPaJwoZdw+x5VN+jCNHUsS
   t7rM5CrIPim3nC2fVp4Qnlw1Ww8MzMytUW9RDYfD+3UxxE9J9ODYdTi8G
   3Sx9uljz8NI+jRd4rMImVwoNq1UpODCuGW4QCvdqweOpRbtshWQ6g4N61
   gHqM2mcjF7wHoSX4s1KT1apyUK2Ksk4zFv3eyCc7HeOybbV8/YvWmrSIP
   RTxuZhP5znVYmUFgyYdkuqB3GmBG2oSCxrP0xoK/IovFAZBf8rqwFV5Dk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373760924"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="373760924"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708486144"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="708486144"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.17.38]) ([10.78.17.38])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 16:44:28 -0700
Message-ID: <9a2fc662-a66a-89f7-3454-f673c155e3d3@linux.intel.com>
Date:   Tue, 8 Aug 2023 16:44:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] PCI: vmd: Disable bridge window for domain reset
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20230807222315.GA272397@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230807222315.GA272397@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/7/2023 3:23 PM, Bjorn Helgaas wrote:
> On Mon, Aug 07, 2023 at 04:45:20PM -0400, Nirmal Patel wrote:
>> During domain reset process vmd_domain_reset() clears PCI
>> configuration space of VMD root ports. But certain platform
>> has observed following errors and failed to boot.
>>   ...
>>   DMAR: VT-d detected Invalidation Queue Error: Reason f
>>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
>>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
>>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
>>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
>>   DMAR: Invalidation Time-out Error (ITE) cleared
>>
>> The root cause is that memset_io() clears prefetchable memory base/limit
>> registers and prefetchable base/limit 32 bits registers sequentially.
>> This seems to be enabling prefetchable memory if the device disabled
>> prefetchable memory originally.
>> Here is an example (before memset_io()):
> Paragraph separation or wrapping error.
I will fix it.
>
>>   PCI configuration space for 10000:00:00.0:
>>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
>>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
>>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
>>   ...
>>
>> So, prefetchable memory is ffffffff00000000-575000fffff, which is
>> disabled. When memset_io() clears prefetchable base 32 bits register,
>> the prefetchable memory becomes 0000000000000000-575000fffff, which is
>> enabled.
>>
>> This is believed to be the reason for the failure and in addition the
>> sequence of operation in vmd_domain_reset() is not following the PCIe
>> specs.
>>
>> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>>
>>   The Prefetchable Memory Limit register must be programmed to a smaller
>>   value than the Prefetchable Memory Base register if there is no
>>   prefetchable memory on the secondary side of the bridg
> s/bridg/bridge/
>
> The [mem 0x0-0x575000fffff] state is transient, right?  After the
> memset_io() completes, the window is [mem 0x0-0x000fffff], which still
> not what you want, since it's enabled, while you want to *disable* the
> window.
>
> I don't know what the connection between this and the DMAR
> invalidation queue errors is.  Maybe those can happen with either the
> transient [mem 0x0-0x575000fffff] state or the [mem 0x0-0x000fffff]
> end state?
>
> IIUC there are two problems with the memset_io():
>
>   1) The memset_io() writes 0 to all the base and limit registers.
>      For address decoding purposes, the low bits of the base are
>      implicitly clear while the low bits of the limit are implicitly
>      set, so setting the base to zero always makes the windows
>      *enabled*, e.g., [io 0x0000-0x0fff].
>
>   2) The I/O and prefetchable base/limit can't be configured with a
>      single config write, so we have to write them in a specific order
>      to avoid transient enabled windows that could cause conflicts.
Yes. Your explanation is very accurate.
>
>> Disable the bridge window by executing a sequence of operations
>> borrowed from pci_disable_bridge_window(), that comply with the
>> PCI specifications.
>>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>> v3->v3: Add more information to commit description.
>> v1->v2: Follow same chain of operation as pci_disable_bridge_window
>>         and update commit log.
>> ---
>>  drivers/pci/controller/vmd.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 769eedeb8802..ca9081be917d 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -526,8 +526,16 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>>  				     PCI_CLASS_BRIDGE_PCI))
>>  					continue;
>>  
>> -				memset_io(base + PCI_IO_BASE, 0,
>> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>> +				writel(0, base + PCI_IO_BASE);
> This is a 32-bit write, so it writes zero to PCI_IO_BASE,
> PCI_IO_LIMIT, and PCI_SEC_STATUS.  Writing zero to PCI_SEC_STATUS is
> probably harmless since everything there is RO or RW1C, but is
> unnecessary and seems a little sloppy.
>
> Writing zero to PCI_IO_BASE and PCI_IO_LIMIT enables it as
> [io 0x0000-0x0fff].  I think the code in pci_setup_bridge_io() is more
> like what you want.
I will make changes according to pci_setup_bridge_io() ASAP.

Thanks.

>
>> +				/* MMIO Base/Limit */
>> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
>> +
>> +				/* Prefetchable MMIO Base/Limit */
>> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
>> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
>> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
>> +				writel(0, base + PCI_IO_BASE_UPPER16);
> kkkk
>> +				writeb(0, base + PCI_CAPABILITY_LIST);
>>  			}
>>  		}
>>  	}
>> -- 
>> 2.31.1
>>
