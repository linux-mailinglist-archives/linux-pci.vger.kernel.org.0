Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E19E776CB0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjHIXON (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Aug 2023 19:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHIXOM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Aug 2023 19:14:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FA0E5B
        for <linux-pci@vger.kernel.org>; Wed,  9 Aug 2023 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691622851; x=1723158851;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EiP9lxCfzdyl/tR4QeQDE9JdicmRlInKKpIK/Rl7pVs=;
  b=CLOODE41JLEvPPhTRAT/T09ccPh/M5j0WCIwX7EyQfIvpwyUHtX/MXt/
   ZD8JR0wWw00hwJP/uUUhSfQHCRxLbEyzVOsqKgq1/FiLFzxHoCIa5YNzD
   iXfBbyISnarUFJOTQSMNfxh+iIA7xvQypuYuseqly8c7iRTKnl8IRumvk
   wf3M9Vf6tDk0jD7VSHyZ+n4QqBi8bxV6T2mp9+TfqEXHDzqtWwMPyhUXd
   /jCl97fh5eUXLv93CQptXwrl6TOZxoe+T+61bgM/BLTDZTM/53lvi8XOk
   DbnkAozYzItGkNL9/m9mIYw1nCzalRMg1yplSHAId29jdsjeuSBpotvZA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="351554441"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="351554441"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="801931216"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="801931216"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.78.17.38]) ([10.78.17.38])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 16:14:06 -0700
Message-ID: <0b5d53be-e735-496d-3a67-6f965982cef5@linux.intel.com>
Date:   Wed, 9 Aug 2023 16:14:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI: vmd: Disable bridge window for domain reset
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20230809220023.GA7042@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230809220023.GA7042@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/9/2023 3:00 PM, Bjorn Helgaas wrote:
> On Wed, Aug 09, 2023 at 05:14:54PM -0400, Nirmal Patel wrote:
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
>>
>> Here is an example (before memset_io()):
>>
>>   PCI configuration space for 10000:00:00.0:
>>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
>>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
>>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
>>   ...
>>
>> So, prefetchable memory is ffffffff00000000-575000fffff, which is
>> disabled. When memset_io() clears prefetchable base 32 bits register,
>> the prefetchable memory becomes 0000000000000000-575000fffff, which is
>> enabled and incorrect.
> It's not clear to me how this window config causes the VT-d errors.
> But empirically it seems to be related, and maybe that's enough.
>
>> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>>
>>   The Prefetchable Memory Limit register must be programmed to a smaller
>>   value than the Prefetchable Memory Base register if there is no
>>   prefetchable memory on the secondary side of the bridge.
>>
>> This is believed to be the reason for the failure and in addition the
>> sequence of operation in vmd_domain_reset() is not following the PCIe
>> specs.
>>
>> Disable the bridge window by executing a sequence of operations
>> borrowed from pci_disable_bridge_window() and pci_setup_bridge_io(),
>> that comply with the PCI specifications.
>>
>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>> ---
>> v3->v4: Following same operation as pci_setup_bridge_io.
>> v2->v3: Add more information to commit description.
>> v1->v2: Follow same chain of operation as pci_disable_bridge_window
>>         and update commit log.
>> ---
>>  drivers/pci/controller/vmd.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 769eedeb8802..ae5b4c1704e4 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -526,8 +526,21 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>>  				     PCI_CLASS_BRIDGE_PCI))
>>  					continue;
>>  
>> -				memset_io(base + PCI_IO_BASE, 0,
>> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>> +				/* Temporarily disable the I/O range before updating PCI_IO_BASE */
>> +				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
>> +				/* Update lower 16 bits of I/O base/limit */
>> +				writew(0x00f0, base + PCI_IO_BASE);
>> +				/* Update upper 16 bits of I/O base/limit */
>> +				writel(0, base + PCI_IO_BASE_UPPER16);
>> +
>> +				/* MMIO Base/Limit */
>> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
>> +
>> +				/* Prefetchable MMIO Base/Limit */
>> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
>> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
>> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
>> +				writeb(0, base + PCI_CAPABILITY_LIST);
> What's the purpose of this PCI_CAPABILITY_LIST write?  I guess you
> don't want to find PM, MSI, MSI-X, PCIe, etc. capabilities?
>
> It's been there since the v1 patch, but the commit log only mentions
> disabling bridge windows.
>
> Bjorn

I added it since it was part of original memset_io range. However from your previous
comment, I checked the lspci output for PCI_CAPABILITY_LIST with and without the
change and it doesn't seem to make any difference.

