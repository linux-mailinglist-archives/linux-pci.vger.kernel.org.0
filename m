Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08256648AA2
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 23:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiLIWOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 17:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLIWOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 17:14:05 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B33C6F4A4
        for <linux-pci@vger.kernel.org>; Fri,  9 Dec 2022 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670624044; x=1702160044;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xqO0yDZgus0CVqC3MeG8fXqQkNxh2xQLv/NMsmOEZfE=;
  b=VF4eNUiHibhjkMd0SLCKz+JlJ/zLsSnJBcQ+krbgvUxZnQXbIaWwd74v
   V+VkErnr6F7B67PLzRFDFAedVfnwcw93L4+23Nlxu1lV15BJy+bKA6d1M
   0MwJy7z4TwLfZrGmRnR7HxBiWVtTE5WLdVk+uLYn2fud3/FvA1coiV+vl
   yOFxzBZmviAgdpdu54xW4Iqd7Zz5ZwF6+rp1FyGTa2JfLkWSOmYG1ggUA
   hjjjbs2p8SCJQmk0+JeQPR38IxElx70J+jBfr9CyIj4I+iR/fLTFNWcX6
   7vyxW97Xrsc0tewPz6mQTpXG5m3yLwL4R14dXQall6ln5sRIkuPYJbD1m
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="319419068"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="319419068"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:13:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="625250455"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="625250455"
Received: from rrode-mobl1.amr.corp.intel.com (HELO [10.251.24.37]) ([10.251.24.37])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 14:13:53 -0800
Message-ID: <c96da230-bd9d-a9db-2b89-a48314b6d056@linux.intel.com>
Date:   Fri, 9 Dec 2022 14:13:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH v2] PCI/portdrv: Do not require an interrupt for all AER
 capable ports
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20221209214835.GA1734545@bhelgaas>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20221209214835.GA1734545@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 12/9/22 1:48 PM, Bjorn Helgaas wrote:
> On Fri, Dec 09, 2022 at 01:04:22PM -0800, Sathyanarayanan Kuppuswamy wrote:
>> On 12/9/22 9:07 AM, Bjorn Helgaas wrote:
>>> On Wed, Dec 07, 2022 at 10:41:05AM +0200, Mika Westerberg wrote:
>>>> Only Root Ports and Event Collectors use MSI for AER. PCIe Switch ports
>>>> or endpoints on the other hand only send messages (that get collected by
>>>> the former). For this reason do not require PCIe switch ports and
>>>> endpoints to use interrupt if they support AER.
>>>>
>>>> This allows portdrv to attach PCIe switch ports of Intel DG1 and DG2
>>>> discrete graphics cards. These do not declare MSI or legacy interrupts.
>>>>
>>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>
>>> Thanks for the additional info!  This seems like something we should
>>> definitely do.
>>>
>>> I'm wondering whether we should check for this in
>>> get_port_device_capability().  It already has similar checks for
>>> device type for other services.  This would skip pci_set_master() for
>>> these non-RP, non-RCEC devices, which is probably harmless, since I
>>> assume we only need that to make sure MSI works.
>>
>> Currently, we only have high level (cap or enable/disable) checks in 
>> get_port_device_capability(). Why bring in more AER specific checks
>> there and make it complicated? Is there any benefit in doing this?
> 
> Thanks a lot for taking a look!
> 
> I agree, I hate how complicated the expressions in
> get_port_device_capability() are, but I don't think my idea is
> significantly worse than what's already there.
> 
> Here's some existing code from get_port_device_capability():
> 
>         /* Root Ports and Root Complex Event Collectors may generate PMEs */
>         if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>             (pcie_ports_native || host->native_pme)) {
>                 services |= PCIE_PORT_SERVICE_PME;
> 
> And here's what the corresponding AER code would look like:
> 
>         if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>              pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>             dev->aer_cap && pci_aer_available() &&
>             (pcie_ports_native || host->native_aer))
>                 services |= PCIE_PORT_SERVICE_AER;
> 
> I do have some ideas about simplifying these, see below.
> 
> The benefits would be to make similar checks in the same place, avoid
> setting Bus Master when we don't need it, and remove the AER child
> service for non-RP/RCECs (it wouldn't appear in sysfs and they
> wouldn't be eligible for PCIE_PORT_SERVICE_AER registration).

I did not notice the PME part. But if possible, we should simplify
these conditions in the future.

I have no objections about this change.

> 
>>> It would also prevent allocation of the AER service for non-RP,
>>> non-RCEC devices.  That's also probably harmless, since aer_probe()
>>> ignores those devices anyway.
>>>
>>> What do you think of something like this?  (This is based on my
>>> pci/portdrv branch which squashed everything into portdrv.c:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/portdrv)
>>>
>>> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
>>> index a6c4225505d5..8b16e96ec15c 100644
>>> --- a/drivers/pci/pcie/portdrv.c
>>> +++ b/drivers/pci/pcie/portdrv.c
>>> @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>>>  	}
>>>  
>>>  #ifdef CONFIG_PCIEAER
>>> -	if (dev->aer_cap && pci_aer_available() &&
>>> +	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>>> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>>> +	    dev->aer_cap && pci_aer_available() &&
>>>  	    (pcie_ports_native || host->native_aer))
>>>  		services |= PCIE_PORT_SERVICE_AER;
>>>  #endif
>>
>> If you want to do it, will you remove the relevant check in AER driver
>> probe?
> 
> That would be a good idea, although I was hoping to squeeze this into
> v6.2, and I would probably postpone the rest until the next cycle.
> 
> I think aer_probe() could also be simplified by dropping the
> set_downstream_devices_error_reporting() stuff.  pci_aer_init()
> already takes care of that, IIUC, and that's a more natural place for
> it since it handles the hot-add case.

Agree. Since pci_ear_init() already configures the AER bits for all
devices, repeating it in aer_probe() is redundant. 

> 
> There may also be opportunity to simplify some of these ugly checks of
> pci_aer_available(), pcie_ports_native, and host->native_aer that are
> littered all over the place by doing them in pci_aer_init() and
> setting dev->aer_cap only if they are satisfied.
> 
> Bjorn

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
