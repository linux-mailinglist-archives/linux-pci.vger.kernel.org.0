Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D133B2C4C58
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 02:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgKZA6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 19:58:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:55145 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729371AbgKZA6d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 19:58:33 -0500
IronPort-SDR: 1wPH6tbM+Wz9TGxIz/Pj4o+ol7VxtuNW3iVE+70DpzFGqhGaPxoDz+iY62765c2k6DbRCHXKM7
 pXaY+JGw973w==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190369959"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="190369959"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 16:58:32 -0800
IronPort-SDR: 8FPfiLr+YW1qbDVvow7KcVTGTmHWFULYOhjh65NArSE83EVZ8A2FfsnCWnZSqpa3pEyTz+i/JC
 8IFpZKT1bMSA==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333198399"
Received: from jjbeatty-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 16:58:31 -0800
Subject: Re: [PATCH v11 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
References: <20201125202810.GA674732@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <59eaec1e-d857-9122-8658-29ec3b62294e@linux.intel.com>
Date:   Wed, 25 Nov 2020 16:58:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201125202810.GA674732@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/20 12:28 PM, Bjorn Helgaas wrote:
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
> 
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
> 
> This is a nit, but I think this and similar checks should be reordered
> so we do the most generic test first, i.e.,
> 
>    if (host->native_pcie_hotplug && dev->is_hotplug_bridge)
ok. I can add this fix on top of your update.
> 
> Logically there's no point in looking at the device things if we
> don't have native control.
> 
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
> 
> Can't we clear host->native_aer when pci_aer_available() returns
> false?  I'd like to have all the checks about whether we have native
> control to be in one place instead of being scattered.  Something like
> this above:
> 
>    OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL, host_bridge->native_aer);
>    if (!pci_aer_available())
>      host_bridge->native_aer = 0;
> 
> So this test would become:
> 
>    if (host->native_aer && dev->aer_cap)
We already use it in pci_root.c to confirm AER availability before
we request control over it via _OSC. So if pci_aer_available() is false
OSC_*AER_CONTROL bit in ctrl_set will be left zero (which means
->native_aer will also be zero).

490         if (pci_aer_available())
491                 control |= OSC_PCI_EXPRESS_AER_CONTROL;

So, may we don't need pci_aer_available() check here.

> 
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
> Also here:
> 
>    if (host->native_pme && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
