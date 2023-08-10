Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4824D778376
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 00:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjHJWJc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 18:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjHJWJb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 18:09:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1480E2713
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691705371; x=1723241371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e26SLykpwcCqlyEYGFMs37elfva8wT9r3CfKd9N4/v0=;
  b=PpJ2gdTDJXxxTe19mdjue0VgvKkYi4sE/kd73BkhjVq+6HvkNB/PC626
   UjQkH74QyhWHnI0IxDe9kKDN5G9DV/BWyl9VsL0jJlbdmZCZDPMPFuiTo
   CcrnUlbSQMj6BzegZfOBYnD5KA6JtXPbKcJXAUxSUzke6exeOVo73O2dI
   8+jYp5wH7/8mEJ/2yaWuDEL0nHjGtuQOMbVzPgS07WUQN4nk6vEYtOsin
   MHQQv/DeONRf0QOy/qQZJj4CS7zggsj5yfc9QWPYuC++wU9U5CEX53q1v
   /B2fWnwqku/RhsIBvssoEDO9mx83bVkjLSWnF5USrr56387qx4o4Fuw0i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="361671807"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="361671807"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 15:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="802421660"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="802421660"
Received: from patelni-mobl1.amr.corp.intel.com (HELO [10.213.168.212]) ([10.213.168.212])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 15:09:30 -0700
Message-ID: <e8f399bf-8ce1-cf07-1758-e8f0abb5ccef@linux.intel.com>
Date:   Thu, 10 Aug 2023 15:09:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] PCI: vmd: Disable bridge window for domain reset
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20230810032444.GA16254@bhelgaas>
From:   "Patel, Nirmal" <nirmal.patel@linux.intel.com>
In-Reply-To: <20230810032444.GA16254@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 8/9/2023 8:24 PM, Bjorn Helgaas wrote:
> On Wed, Aug 09, 2023 at 04:14:06PM -0700, Patel, Nirmal wrote:
>> On 8/9/2023 3:00 PM, Bjorn Helgaas wrote:
>>> On Wed, Aug 09, 2023 at 05:14:54PM -0400, Nirmal Patel wrote:
>>>> During domain reset process vmd_domain_reset() clears PCI
>>>> configuration space of VMD root ports. But certain platform
>>>> has observed following errors and failed to boot.
>>>>   ...
>>>>   DMAR: VT-d detected Invalidation Queue Error: Reason f
>>>>   DMAR: VT-d detected Invalidation Time-out Error: SID ffff
>>>>   DMAR: VT-d detected Invalidation Completion Error: SID ffff
>>>>   DMAR: QI HEAD: UNKNOWN qw0 = 0x0, qw1 = 0x0
>>>>   DMAR: QI PRIOR: UNKNOWN qw0 = 0x0, qw1 = 0x0
>>>>   DMAR: Invalidation Time-out Error (ITE) cleared
>>>>
>>>> The root cause is that memset_io() clears prefetchable memory base/limit
>>>> registers and prefetchable base/limit 32 bits registers sequentially.
>>>> This seems to be enabling prefetchable memory if the device disabled
>>>> prefetchable memory originally.
>>>>
>>>> Here is an example (before memset_io()):
>>>>
>>>>   PCI configuration space for 10000:00:00.0:
>>>>   86 80 30 20 06 00 10 00 04 00 04 06 00 00 01 00
>>>>   00 00 00 00 00 00 00 00 00 01 01 00 00 00 00 20
>>>>   00 00 00 00 01 00 01 00 ff ff ff ff 75 05 00 00
>>>>   ...
>>>>
>>>> So, prefetchable memory is ffffffff00000000-575000fffff, which is
>>>> disabled. When memset_io() clears prefetchable base 32 bits register,
>>>> the prefetchable memory becomes 0000000000000000-575000fffff, which is
>>>> enabled and incorrect.
>>> It's not clear to me how this window config causes the VT-d errors.
>>> But empirically it seems to be related, and maybe that's enough.
>>>
>>>> Here is the quote from section 7.5.1.3.9 of PCI Express Base 6.0 spec:
>>>>
>>>>   The Prefetchable Memory Limit register must be programmed to a smaller
>>>>   value than the Prefetchable Memory Base register if there is no
>>>>   prefetchable memory on the secondary side of the bridge.
>>>>
>>>> This is believed to be the reason for the failure and in addition the
>>>> sequence of operation in vmd_domain_reset() is not following the PCIe
>>>> specs.
>>>>
>>>> Disable the bridge window by executing a sequence of operations
>>>> borrowed from pci_disable_bridge_window() and pci_setup_bridge_io(),
>>>> that comply with the PCI specifications.
>>>>
>>>> Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
>>>> ---
>>>> v3->v4: Following same operation as pci_setup_bridge_io.
>>>> v2->v3: Add more information to commit description.
>>>> v1->v2: Follow same chain of operation as pci_disable_bridge_window
>>>>         and update commit log.
>>>> ---
>>>>  drivers/pci/controller/vmd.c | 17 +++++++++++++++--
>>>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>>>> index 769eedeb8802..ae5b4c1704e4 100644
>>>> --- a/drivers/pci/controller/vmd.c
>>>> +++ b/drivers/pci/controller/vmd.c
>>>> @@ -526,8 +526,21 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
>>>>  				     PCI_CLASS_BRIDGE_PCI))
>>>>  					continue;
>>>>  
>>>> -				memset_io(base + PCI_IO_BASE, 0,
>>>> -					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
>>>> +				/* Temporarily disable the I/O range before updating PCI_IO_BASE */
>>>> +				writel(0x0000ffff, base + PCI_IO_BASE_UPPER16);
>>>> +				/* Update lower 16 bits of I/O base/limit */
>>>> +				writew(0x00f0, base + PCI_IO_BASE);
>>>> +				/* Update upper 16 bits of I/O base/limit */
>>>> +				writel(0, base + PCI_IO_BASE_UPPER16);
>>>> +
>>>> +				/* MMIO Base/Limit */
>>>> +				writel(0x0000fff0, base + PCI_MEMORY_BASE);
>>>> +
>>>> +				/* Prefetchable MMIO Base/Limit */
>>>> +				writel(0, base + PCI_PREF_LIMIT_UPPER32);
>>>> +				writel(0x0000fff0, base + PCI_PREF_MEMORY_BASE);
>>>> +				writel(0xffffffff, base + PCI_PREF_BASE_UPPER32);
>>>> +				writeb(0, base + PCI_CAPABILITY_LIST);
>>> What's the purpose of this PCI_CAPABILITY_LIST write?  I guess you
>>> don't want to find PM, MSI, MSI-X, PCIe, etc. capabilities?
>>>
>>> It's been there since the v1 patch, but the commit log only mentions
>>> disabling bridge windows.
>> I added it since it was part of original memset_io range. However
>> from your previous comment, I checked the lspci output for
>> PCI_CAPABILITY_LIST with and without the change and it doesn't seem
>> to make any difference.
> Ah, I see.  My guess is that was a mistake in the original memset_io()
> because I don't see a reason to clear PCI_CAPABILITY_LIST.
>
> PCI_CAPABILITY_LIST is HwInit, so should be read-only in terms of
> config accesses, and if lspci sees the same capability list before and
> after writing a zero to it, it sounds like it *is* read-only.
>
> Bjorn

Yes, I will remove it. Thanks.

