Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023621C67B
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 23:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgGKVpS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 17:45:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:4471 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgGKVpS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jul 2020 17:45:18 -0400
IronPort-SDR: IGIGpwABWFTmBsr3RBJbqvrSv4VWSOLuRuq5k2jTPLliLR2674m/0qjGKJ/4CkCyGwf7pELs6e
 4XQETjLeXUrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="149903429"
X-IronPort-AV: E=Sophos;i="5.75,341,1589266800"; 
   d="scan'208";a="149903429"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 14:45:17 -0700
IronPort-SDR: IwKLLPRqS4CYlJbcYhqSY6sGQUINUKW8NxDufdHH24CCO9Dpalbw/qxoTC50wDFZNpDOJI8jrc
 jUg2A3UAmj2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,341,1589266800"; 
   d="scan'208";a="269375260"
Received: from nholling-mobl.amr.corp.intel.com (HELO [10.251.10.249]) ([10.251.10.249])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2020 14:45:16 -0700
Subject: Re: [PATCH v6 1/4] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <20200709230716.GA23972@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <02f2c538-c192-65d3-75ec-7874436b966c@linux.intel.com>
Date:   Sat, 11 Jul 2020 14:45:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200709230716.GA23972@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 7/9/20 4:07 PM, Bjorn Helgaas wrote:
> On Fri, Jun 26, 2020 at 11:32:33AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
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
>>   drivers/acpi/pci_root.c           | 26 ++++++++++++++------------
>>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>>   drivers/pci/pci-acpi.c            |  3 ---
>>   drivers/pci/pcie/aer.c            |  2 +-
>>   drivers/pci/pcie/portdrv_core.c   |  9 +++------
>>   drivers/pci/probe.c               |  5 +++--
>>   6 files changed, 22 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index f90e841c59f5..02fab8b0118e 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -914,18 +914,20 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>>   		goto out_release_info;
>>   
>>   	host_bridge = to_pci_host_bridge(bus->bridge);
>> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>> -		host_bridge->native_pcie_hotplug = 0;
>> -	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
>> -		host_bridge->native_shpc_hotplug = 0;
>> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
>> -		host_bridge->native_aer = 0;
>> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
>> -		host_bridge->native_pme = 0;
>> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>> -		host_bridge->native_ltr = 0;
>> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>> -		host_bridge->native_dpc = 0;
>> +	if (!pcie_ports_native) {
>> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
>> +			host_bridge->native_pcie_hotplug = 0;
>> +		if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
>> +			host_bridge->native_shpc_hotplug = 0;
>> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
>> +			host_bridge->native_aer = 0;
>> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
>> +			host_bridge->native_pme = 0;
>> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>> +			host_bridge->native_ltr = 0;
>> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
>> +			host_bridge->native_dpc = 0;
>> +	}
> 
> When the user boots with "pcie_ports=native", should we evaluate _OSC
> at all?  
Since pcie_ports="native" does not override 
OSC_PCI_SHPC_NATIVE_HP_CONTROL, I think we should still evaluate _OSC.
Also firmware might still wants to know about supported features during
_OSC call.

It seems confusing to say "OK, Mr. Firmware, here are the
> features we want to use", and then turn around and use them all
> regardless of what the platform said.  Why not just ignore the
> firmware completely and go ahead and use everything?|
AFAIK, for PCIe features, It should functionally make no difference
(evaluating _OSC vs not). But, IMO, its useful if we print some warnings
if firmware denies some of the PCIe feature control.
> 
> I can't remember if there's a reason we need to call
> negotiate_os_control() so early and then hang on to the results until
> we get here:
> 
>    acpi_pci_root_add
>      negotiate_os_control                      <--- eval _OSC
>      pci_acpi_scan_root
>        acpi_pci_root_create
>          pci_create_root_bus
>          if (!(root->osc_control_set & ...))   <--- use results
>            host_bridge->native_... = 0;
> 
> I think it would be a lot simpler if we could do the _OSC negotiation
> right here where we need most of the results.  It would be even better
> if we could update the host_bridge->native_... items directly inside
> negotiate_os_control() so we wouldn't have to hang onto the
> osc_control_set mask.
Makes sense. I also don't see any one use _OSC negotiated results until
pci_create_root_bus(). But I think this should be a seperate patch.
> 
>>   	/*
>>   	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
>> index bf779f291f15..5fc999bf6f1b 100644
>> --- a/drivers/pci/hotplug/pciehp_core.c
>> +++ b/drivers/pci/hotplug/pciehp_core.c
>> @@ -255,7 +255,7 @@ static bool pme_is_native(struct pcie_device *dev)
>>   	const struct pci_host_bridge *host;
>>   
>>   	host = pci_find_host_bridge(dev->port->bus);
>> -	return pcie_ports_native || host->native_pme;
>> +	return host->native_pme;
>>   }
>>   
>>   static void pciehp_disable_interrupt(struct pcie_device *dev)
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 7224b1e5f2a8..e09589571a9d 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -800,9 +800,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
>>   	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
>>   		return false;
>>   
>> -	if (pcie_ports_native)
>> -		return true;
>> -
>>   	host = pci_find_host_bridge(bridge->bus);
>>   	return host->native_pcie_hotplug;
>>   }
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 3acf56683915..d663bd9c7257 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -219,7 +219,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>   	if (!dev->aer_cap)
>>   		return 0;
>>   
>> -	return pcie_ports_native || host->native_aer;
>> +	return host->native_aer;
>>   }
>>   
>>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>> index 50a9522ab07d..ccd5e0ce5605 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>>   	int services = 0;
>>   
>> -	if (dev->is_hotplug_bridge &&
>> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
>> +	if (dev->is_hotplug_bridge && host->native_pcie_hotplug) {
>>   		services |= PCIE_PORT_SERVICE_HP;
>>   
>>   		/*
>> @@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	}
>>   
>>   #ifdef CONFIG_PCIEAER
>> -	if (dev->aer_cap && pci_aer_available() &&
>> -	    (pcie_ports_native || host->native_aer)) {
>> +	if (dev->aer_cap && pci_aer_available() && host->native_aer) {
>>   		services |= PCIE_PORT_SERVICE_AER;
>>   
>>   		/*
>> @@ -238,8 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>>   	 * Event Collectors can also generate PMEs, but we don't handle
>>   	 * those yet.
>>   	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
>> -	    (pcie_ports_native || host->native_pme)) {
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT && host->native_pme) {
>>   		services |= PCIE_PORT_SERVICE_PME;
> 
> I *love* that you removed pcie_ports_native from all these places.
> 
>>   		/*
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2f66988cea25..5fb90bb9b4e3 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -588,13 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>>   	 * may implement its own AER handling and use _OSC to prevent the
>>   	 * OS from interfering.
>>   	 */
>> +#ifdef CONFIG_PCIEPORTBUS
>>   	bridge->native_aer = 1;
>>   	bridge->native_pcie_hotplug = 1;
>> -	bridge->native_shpc_hotplug = 1;
>>   	bridge->native_pme = 1;
>>   	bridge->native_ltr = 1;
>>   	bridge->native_dpc = 1;
>> -
>> +#endif
>> +	bridge->native_shpc_hotplug = 1;
> 
> This looks like a bugfix that should be its own patch.
Agreed. I will split it in next version.
> 
>>   	device_initialize(&bridge->dev);
>>   }
>>   
>> -- 
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
