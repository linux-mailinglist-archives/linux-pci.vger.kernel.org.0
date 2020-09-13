Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6F268137
	for <lists+linux-pci@lfdr.de>; Sun, 13 Sep 2020 22:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMUyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 16:54:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:56207 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgIMUyl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 13 Sep 2020 16:54:41 -0400
IronPort-SDR: /lDFCefnKTIz3FYzWysWavQwTk15dwXHQe46XfOXOTzCqE1tPshrdoxJgwCE/H26cmo0OQlWfn
 f3iI1IRHJb7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="156445076"
X-IronPort-AV: E=Sophos;i="5.76,423,1592895600"; 
   d="scan'208";a="156445076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 13:54:41 -0700
IronPort-SDR: 7EgD5AJh9Np/vDKs4N2lPf9pSfEI3KSxOUzlj+xJJ+l9UP7MCnlQyo73+GEnVN62zq5kbFIyRA
 590PELv9XA+g==
X-IronPort-AV: E=Sophos;i="5.76,423,1592895600"; 
   d="scan'208";a="330482178"
Received: from dhanken-mobl1.amr.corp.intel.com (HELO [10.251.29.129]) ([10.251.29.129])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 13:54:40 -0700
Subject: Re: [PATCH v8 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200910201426.GA809535@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <badc377a-09f9-aabe-0b34-9f806da4b255@linux.intel.com>
Date:   Sun, 13 Sep 2020 13:54:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910201426.GA809535@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 9/10/20 1:14 PM, Bjorn Helgaas wrote:
> On Fri, Jul 24, 2020 at 08:58:53PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> pcie_ports_native is set only if user requests native handling
>> of PCIe capabilities via pcie_port_setup command line option.
>> User input takes precedence over _OSC based control negotiation
>> result. So consider the _OSC negotiated result only if
>> pcie_ports_native is unset.
>>
>> Also, since struct pci_host_bridge ->native_* members caches the
>> ownership status of various PCIe capabilities, use them instead
>> of distributed checks for pcie_ports_native.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/acpi/pci_root.c           | 61 ++++++++++++++++++++++++++-----
>>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>>   drivers/pci/pci-acpi.c            |  3 --
>>   drivers/pci/pcie/aer.c            |  2 +-
>>   drivers/pci/pcie/portdrv_core.c   |  9 ++---
>>   5 files changed, 56 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index f90e841c59f5..f8981d4e044d 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -145,6 +145,17 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>>   	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>>   };
>>   

>> +		else
>> +			dev_warn(&bus->dev, "OS overrides %s firmware control",
>> +			get_osc_desc(OSC_PCI_EXPRESS_NATIVE_HP_CONTROL));
> 
> There's got to be a way to write this more concisely.  Maybe something
> like this?
> 
>    #define OSC_OWNER(ctrl, bit, flag) \
>      if (!(ctrl & bit)) \
>        flag = 0;
> 
>    if (pcie_ports_native)
>      decode_osc_control(root, "OS forcibly taking over", ~0);
BIT1 and BIT6 does not have PCIe dependency. And BIT7-31 are reserved.
So we can't force all _OSC bits based on pcie_ports_native value.
So, IM0, its better to handle PCIe features seperatly.
>    else {
>      ctrl = root->osc_control_set;
>      OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
>      OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL, host_bridge->native_pme);
>      ...
>    }


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
