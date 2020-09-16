Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B600926BA3F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 04:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIPCdr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 22:33:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:25625 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgIPCdq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Sep 2020 22:33:46 -0400
IronPort-SDR: sotF13FyDxkuw1yIByop4HW5y59pvXD8YicSjh8LaqCAYcBN7hUC0LThOS6NUayNAhR0YJx7+L
 VlXJxkaTai4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="223571177"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="223571177"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 19:33:45 -0700
IronPort-SDR: stg/E0L/mmaaif/WUAYwqUqjDrLpY9J5kW6Xa5s7Ayp6EZPs8lSUP+Rj4hlDtzXQc5+t7z6cJI
 h+eK8icYuJwQ==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="451664115"
Received: from gschatz-mobl2.amr.corp.intel.com (HELO [10.254.127.209]) ([10.254.127.209])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 19:33:44 -0700
Subject: Re: [PATCH v8 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200915222033.GA1438273@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <4a01ecb7-4116-08af-d63c-9d5b1a4770e0@linux.intel.com>
Date:   Tue, 15 Sep 2020 19:33:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915222033.GA1438273@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/15/20 3:20 PM, Bjorn Helgaas wrote:
> On Sun, Sep 13, 2020 at 01:54:38PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> On 9/10/20 1:14 PM, Bjorn Helgaas wrote:
>>> On Fri, Jul 24, 2020 at 08:58:53PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>
>>>> pcie_ports_native is set only if user requests native handling
>>>> of PCIe capabilities via pcie_port_setup command line option.
>>>> User input takes precedence over _OSC based control negotiation
>>>> result. So consider the _OSC negotiated result only if
>>>> pcie_ports_native is unset.
>>>>
>>>> Also, since struct pci_host_bridge ->native_* members caches the
>>>> ownership status of various PCIe capabilities, use them instead
>>>> of distributed checks for pcie_ports_native.
>>>>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> ---
>>>>    drivers/acpi/pci_root.c           | 61 ++++++++++++++++++++++++++-----
>>>>    drivers/pci/hotplug/pciehp_core.c |  2 +-
>>>>    drivers/pci/pci-acpi.c            |  3 --
>>>>    drivers/pci/pcie/aer.c            |  2 +-
>>>>    drivers/pci/pcie/portdrv_core.c   |  9 ++---
>>>>    5 files changed, 56 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>>>> index f90e841c59f5..f8981d4e044d 100644
>>>> --- a/drivers/acpi/pci_root.c
>>>> +++ b/drivers/acpi/pci_root.c
>>>> @@ -145,6 +145,17 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>>>>    	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>>>>    };
>>
>>>> +		else
>>>> +			dev_warn(&bus->dev, "OS overrides %s firmware control",
>>>> +			get_osc_desc(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL));
>>>
>>> There's got to be a way to write this more concisely.  Maybe something
>>> like this?
>>>
>>>     #define OSC_OWNER(ctrl, bit, flag) \
>>>       if (!(ctrl & bit)) \
>>>         flag = 0;
>>>
>>>     if (pcie_ports_native)
>>>       decode_osc_control(root, "OS forcibly taking over", ~0);
>>
>> BIT1 and BIT6 does not have PCIe dependency. And BIT7-31 are reserved.
>> So we can't force all _OSC bits based on pcie_ports_native value.
>> So, IM0, its better to handle PCIe features seperatly.
> 
> Yes, we may need to handle a few bits specially.  But we need to
> figure out a nicer-looking way of coding this.  It's too cumbersome to
> check pcie_ports_native and log a message for every _OSC bit
> individually.
ok. Let me check how to simplify it.
> 
>>>     else {
>>>       ctrl = root->osc_control_set;
>>>       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
>>>       OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
>>>       ...
>>>     }
>>
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
