Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A19A411E56
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 19:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347479AbhITRaU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 13:30:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:31514 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343952AbhITR1I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Sep 2021 13:27:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="284199575"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="284199575"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 10:18:31 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="548876785"
Received: from pvani-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.5.167])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 10:18:30 -0700
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jon Derrick <jonathan.derrick@linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
 <20210912084547.GA26678@wunner.de>
 <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
 <20210914144621.GA30031@wunner.de>
From:   Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <3f7773e0-1c20-f96f-097f-f545a905151d@intel.com>
Date:   Mon, 20 Sep 2021 12:18:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210914144621.GA30031@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/14/21 9:46 AM, Lukas Wunner wrote:
> On Mon, Sep 13, 2021 at 04:07:22PM -0500, Jon Derrick wrote:
>> On 9/12/21 3:45 AM, Lukas Wunner wrote:
>>> On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
>>>> When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
>>>> ports both support hotplugging on each respective x4 device, a slot
>>>> management system for the SSD requires both x4 slots to have power
>>>> removed via sysfs (echo 0 > slot/N/power), from the OS before it can
>>>> safely turn-off physical power for the whole x8 device. The implications
>>>> are that slot status will display powered off and link inactive statuses
>>>> for the x4 devices where the devices are actually powered until both
>>>> ports have powered off.
>>>
>>> Just to get a better understanding, does the P5608 have an internal
>>> PCIe switch with hotplug capability on the Downstream Ports or
>>> does it plug into two separate PCIe slots?  I recall previous patches
>>> mentioned a CEM interposer?  (An lspci listing might be helpful.)
>>
>> It looks like 2 NVMe endpoints plugged into two different root ports, ex,
>> 80:00.0 Root port to [81-86]
>> 80:01.0 Root port to [87-8b]
>> 81:00.0 NVMe
>> 87:00.0 NVMe
>>
>> The x8 is bifurcated to x4x4. Physically they share the same slot
>> power/clock/reset but are logically separate per root port.
> 
> So are these two P5608 drives attached to a single Root Port with an
> interposer in-between?
> 
> I assume the Root Port needs to know that it's bifurcated and has to
> appear as two slots on the bus.  Is this configured with a BIOS setting?
> 
> If these assumptions are true, the quirk isn't really specific to
> the P5608 but should rather apply to the bifurcation-capable Root Port
> and the quirk should set the flag if the Root Port is indeed configured
> for bifurcation.
It's a function of the slot + card combination, but we can't distinguish this
slot's special power handling behavior from the vanilla behavior. It's modified
to handle power on the logically bifurcated, singular physical device.


> 
> 
>>>> @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>>>  		cancel_delayed_work(&ctrl->button_work);
>>>>  		fallthrough;
>>>>  	case OFF_STATE:
>>>> +		if (pdev->shared_pcc_and_link_slot &&
>>>> +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
>>>> +			mutex_unlock(&ctrl->state_lock);
>>>> +			break;
>>>> +		}
>>>> +
>>>
>>> I think you also need to add...
>>>
>>> 			pdev->shared_pcc_and_link_slot = false;
>>>
>>> ... here to reset the shared_pcc_and_link_slot attribute in case the
>>> next card plugged into the slot doesn't have the quirk.
>>>
>>> (This can't be done in pciehp_unconfigure_device() because the attribute
>>> is queried *after* the slot has been brought down.)
>>
>> Agreed. I'll find a good spot for it.
> 
> Adding it in the if-clause above should work.  The if-clause is only
> entered when the sibling card has had its power removed, and this
> only happens once.  When power is reinstated via sysfs, the device
> in the slot is reenumerated and pdev->shared_pcc_and_link_slot is
> set to true again if there's a quirked device in the slot.
> 
> Thanks,
> 
> Lukas
> 
