Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C953F8E70
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 21:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhHZTGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 15:06:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:58076 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhHZTGP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 15:06:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10088"; a="215973506"
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="215973506"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 12:05:28 -0700
X-IronPort-AV: E=Sophos;i="5.84,354,1620716400"; 
   d="scan'208";a="528012643"
Received: from mwsmith1-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.7.24])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2021 12:05:27 -0700
Subject: Re: [PATCH v2] PCI: pciehp: Quirk to ignore spurious DLLSC when off
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20210823184919.3412-1-jonathan.derrick@intel.com>
 <20210824004101.GA67273@otc-nc-03>
From:   Jon Derrick <jonathan.derrick@intel.com>
Message-ID: <8d75cd15-e1e5-986f-73e0-7fb991afb165@intel.com>
Date:   Thu, 26 Aug 2021 13:05:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210824004101.GA67273@otc-nc-03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/23/21 6:41 PM, Raj, Ashok wrote:
> On Mon, Aug 23, 2021 at 12:49:19PM -0600, Derrick, Jonathan wrote:
>> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
>>
>> When a specific x8 CEM card is bifurcated into x4x4 mode, and the
>> upstream ports both support hotplugging on each respective x4 device, a
>> slot management system for the CEM card requires both x4 devices to be
>> sysfs removed from the OS before it can safely turn-off physical power.
> 
> sysfs removed from the OS seems a bit confusing.. Do you mean removed via
> sysfs by echo 0 > power?
Yes it seems to be related to slot power and not just virtual removal


> 
>> The implications are that Slot Control will display Powered Off status
>> for the device where the device is actually powered until both ports
>> have powered off.
>>
>> When power is removed from the first half, real power and link remains
>> active while waiting for the second half to have power removed. When
>> power is then removed from the second half, the first half starts
>> shutdown sequence and will trigger a DLLSC event. This is misinterpreted
>> as an enabling event and causes the first half to be re-enabled.
>>
>> The spurious enable can be resolved by ignoring link status change
>> events when no link is active when in the off state. This patch adds a
>> quirk for the card.
>>
>> Acked-by: Jon Derrick <jonathan.derrick@intel.com>
>> Signed-off-by: James Puthukattukaran <james.puthukattukaran@oracle.com>
>> ---
>> v1->v2: Device-specific quirk
>>
>>  drivers/pci/hotplug/pciehp_ctrl.c |  7 +++++++
>>  drivers/pci/quirks.c              | 30 ++++++++++++++++++++++++++++++
>>  include/linux/pci.h               |  1 +
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index 529c34808440..db41f78bfac8 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -225,6 +225,7 @@ void pciehp_handle_disable_request(struct controller *ctrl)
>>  void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  {
>>  	int present, link_active;
>> +	struct pci_dev *pdev = ctrl->pcie->port;
>>  
>>  	/*
>>  	 * If the slot is on and presence or link has changed, turn it off.
>> @@ -265,6 +266,12 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>  		cancel_delayed_work(&ctrl->button_work);
>>  		fallthrough;
>>  	case OFF_STATE:
>> +		if (pdev->shared_pcc_and_link_slot &&
>> +		    (events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
> 
> Is it !link_active? Based on the explanation, until we turn off both slots
> you would see link is still active correct? 
My understanding is the internal link is active but link_active shows negative
status while the one side is faking being 'powered off'.

Then if a DLLSC occurs while the slot is already OFF_STATE and !link_active, I
believe we can assume it was previously !link_active as well and it's an event
from the other side.


> 
>> +			mutex_unlock(&ctrl->state_lock);
>> +			break;
>> +		}
>> +
