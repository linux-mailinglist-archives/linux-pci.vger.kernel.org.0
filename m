Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB1C2C4AC5
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbgKYWVx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 17:21:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:3189 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733124AbgKYWVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 17:21:53 -0500
IronPort-SDR: XUSjHKNhUvg/oP/s/GotJs2fl/Xgma0jJk3xQoijDNX9o6E9QBwIt0uPzaHF0Umgg7RHosf/h1
 3IzeY1TFx6Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="236340289"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="236340289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 14:21:52 -0800
IronPort-SDR: BIp/AhTmJ4Q0OMqgk6O3zg6279ezfWE6wxCFJE6HenFdB7nbSg1df7iZT4jJI1bSl357IYRJSS
 Grsm9CWjNrpA==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333158955"
Received: from jjbeatty-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 14:21:52 -0800
Subject: Re: [PATCH v11 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
References: <20201125201215.GA673882@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ad9cd8ca-4c22-f691-b344-699d82a75872@linux.intel.com>
Date:   Wed, 25 Nov 2020 14:21:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125201215.GA673882@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the review.

On 11/25/20 12:12 PM, Bjorn Helgaas wrote:
> On Mon, Oct 26, 2020 at 07:57:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
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
>>   drivers/acpi/pci_root.c           | 35 ++++++++++++++++++++++---------
>>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>>   drivers/pci/pci-acpi.c            |  3 ---
>>   drivers/pci/pcie/aer.c            |  2 +-
>>   drivers/pci/pcie/portdrv_core.c   |  9 +++-----
>>   include/linux/acpi.h              |  2 ++
>>   6 files changed, 32 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index c12b5fb3e8fb..a9e6b782622d 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -41,6 +41,12 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>>   				| OSC_PCI_CLOCK_PM_SUPPORT \
>>   				| OSC_PCI_MSI_SUPPORT)

>> +
>> +	if (pcie_ports_native) {
>> +		decode_osc_control(root, "OS forcibly taking over",
>> +				   OSC_PCI_EXPRESS_CONTROL_MASKS);
> 
> The only place OSC_PCI_EXPRESS_CONTROL_MASKS is used is right here, so
> it's kind of pointless.
> 
> I think I'd rather have this:
> 
>    dev_info(&root->device->dev, "Ignoring PCIe-related _OSC results because \"pcie_ports=native\" specified\n");
I was trying to keep the same print format. In pci_root.c,
decode_os_control() is repeatedly used to print info related to
PCIe capability ownership.

But either way is fine with me. I can use the format you mentioned.
> 
> 
> followed by something like this after we're done fiddling with all the
> host_bridge->native* bits:
> 

>    #define FLAG(x) ((x) ? '+' : '-')
> 
>    dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeCapability%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
>             FLAG(host_bridge->native_shpc_hotplug),
> 	   ?,
>             FLAG(host_bridge->native_pcie_hotplug),
> 	   ...);
> 
> But I don't know how to handle OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> since we don't track it the same way.  Maybe we'd have to omit it from
> this message for now?
I will add it in next version. But for now, its not worry about
OSC_PCI_EXPRESS_CAPABILITY_CONTROL.
> 

>>   	/*
>>   	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it

>> -- 
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
