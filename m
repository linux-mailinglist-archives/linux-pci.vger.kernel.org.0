Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F0409ED3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhIMVIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 17:08:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:29033 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231976AbhIMVIt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 17:08:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="201971168"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="201971168"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 14:07:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="543465759"
Received: from greggjas-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.7.180])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 14:07:28 -0700
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
To:     Lukas Wunner <lukas@wunner.de>,
        Jon Derrick <jonathan.derrick@linux.dev>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
 <20210912084547.GA26678@wunner.de>
From:   Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
Date:   Mon, 13 Sep 2021 16:07:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210912084547.GA26678@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/12/21 3:45 AM, Lukas Wunner wrote:
> On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
>> When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
>> ports both support hotplugging on each respective x4 device, a slot
>> management system for the SSD requires both x4 slots to have power
>> removed via sysfs (echo 0 > slot/N/power), from the OS before it can
>> safely turn-off physical power for the whole x8 device. The implications
>> are that slot status will display powered off and link inactive statuses
>> for the x4 devices where the devices are actually powered until both
>> ports have powered off.
> 
> Just to get a better understanding, does the P5608 have an internal
> PCIe switch with hotplug capability on the Downstream Ports or
> does it plug into two separate PCIe slots?  I recall previous patches
> mentioned a CEM interposer?  (An lspci listing might be helpful.)

It looks like 2 NVMe endpoints plugged into two different root ports, ex,
80:00.0 Root port to [81-86]
80:01.0 Root port to [87-8b]
81:00.0 NVMe
87:00.0 NVMe

The x8 is bifurcated to x4x4. Physically they share the same slot
power/clock/reset but are logically separate per root port.


> 
> 
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -225,6 +225,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  {
>>  	int present, link_active;
>> +	struct pci_dev *pdev = ctrl->pcie->port;
> 
> Nit: Reverse christmas tree.
Sure


> 
> 
>> @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  		cancel_delayed_work(&ctrl->button_work);
>>  		fallthrough;
>>  	case OFF_STATE:
>> +		if (pdev->shared_pcc_and_link_slot &&
>> +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
>> +			mutex_unlock(&ctrl->state_lock);
>> +			break;
>> +		}
>> +
> 
> I think you also need to add...
> 
> 			pdev->shared_pcc_and_link_slot = false;
> 
> ... here to reset the shared_pcc_and_link_slot attribute in case the
> next card plugged into the slot doesn't have the quirk.
> 
> (This can't be done in pciehp_unconfigure_device() because the attribute
> is queried *after* the slot has been brought down.)
Agreed. I'll find a good spot for it.


> 
> 
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -5750,3 +5750,37 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>>  }
>>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>>  			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
>> +
>> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> 
> It's possible to put the quirk at the bottom of pciehp_ctrl.c and
> thus avoid the need for the #ifdef here.  (We've got another
> pciehp-specific quirk at the bottom of pciehp_hpc.c.)
Sure that would look fine


> 
> Otherwise LGTM.
> 
> Thanks,
> 
> Lukas
> 
