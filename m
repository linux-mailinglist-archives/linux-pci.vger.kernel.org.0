Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AA11B896E
	for <lists+linux-pci@lfdr.de>; Sat, 25 Apr 2020 22:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDYUqr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Apr 2020 16:46:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:43867 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbgDYUqr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 25 Apr 2020 16:46:47 -0400
IronPort-SDR: aRIYVEQYw30kTZiy14keus3BzH1djfiKMn7uGb6LM/cpKQjIoOgSP9+FJ4+aGoilHGQnwRebNT
 0zBNiSuG65zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2020 13:46:47 -0700
IronPort-SDR: 1FPnQL6/es4xgUoHTgrFqVT3I3AXYsUema1U78zXK/KuI+id6H2Hs205LGwyxPHVCesUibvwi3
 cNu2FF2ILnlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,317,1583222400"; 
   d="scan'208";a="281228044"
Received: from jamesp6x-mobl.amr.corp.intel.com (HELO [10.254.108.128]) ([10.254.108.128])
  by fmsmga004.fm.intel.com with ESMTP; 25 Apr 2020 13:46:46 -0700
Subject: Re: [PATCH v2 2/2] PCI/DPC: Allow Native DPC Host Bridges to use DPC
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Cc:     "rajatja@google.com" <rajatja@google.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "fred@fredlawl.com" <fred@fredlawl.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "sbobroff@linux.ibm.com" <sbobroff@linux.ibm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
 <1587418630-13562-3-git-send-email-jonathan.derrick@intel.com>
 <0058b993-0663-7fed-ed31-cb0adf845a39@linux.intel.com>
 <ea21d9475b0af277c7288504ff2cd32b3f91e4ba.camel@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <7e574cc1-a24b-5c4b-7d4f-3fda3f395390@linux.intel.com>
Date:   Sat, 25 Apr 2020 13:46:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ea21d9475b0af277c7288504ff2cd32b3f91e4ba.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/23/20 8:11 AM, Derrick, Jonathan wrote:
> Hi Sathyanarayanan,
> 
> On Wed, 2020-04-22 at 15:50 -0700, Kuppuswamy, Sathyanarayanan wrote:
>>
>> On 4/20/20 2:37 PM, Jon Derrick wrote:
>>> The existing portdrv model prevents DPC services without either OS
>>> control (_OSC) granted to AER services, a Host Bridge requesting Native
>>> AER, or using one of the 'pcie_ports=' parameters of 'native' or
>>> 'dpc-native'.
>>>
>>> The DPC port service driver itself will also fail to probe if the kernel
>>> assumes the port is using Firmware-First AER. It's a reasonable
>>> expectation that a port using Firmware-First AER will also be using
>>> Firmware-First DPC, however if a Host Bridge requests Native DPC, the
>>> DPC driver should allow it and not fail to bind due to AER capability
>>> settings.
>>>
>>> Host Bridges which request Native DPC port services will also likely
>>> request Native AER, however it shouldn't be a requirement. This patch
>>> allows ports on those Host Bridges to have DPC port services.
>>>
>>> This will avoid the unlikely situation where the port is Firmware-First
>>> AER and Native DPC, and a BIOS or switch firmware preconfiguration of
>>> the DPC trigger could result in unhandled DPC events.
>>>
>>> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
>>> ---
>>>    drivers/pci/pcie/dpc.c          | 3 ++-
>>>    drivers/pci/pcie/portdrv_core.c | 3 ++-
>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>> index 7621704..3f3106f 100644
>>> --- a/drivers/pci/pcie/dpc.c
>>> +++ b/drivers/pci/pcie/dpc.c
>>> @@ -284,7 +284,8 @@ static int dpc_probe(struct pcie_device *dev)
>>>    	int status;
>>>    	u16 ctl, cap;
>>>    
>>> -	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
>>> +	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native &&
>>> +	    !pci_find_host_bridge(pdev->bus)->native_dpc)
>> Why do it in probe as well ? if host->native_dpc is not set then the
>> device DPC probe it self won't happen right ?
> 
> Portdrv only enables the interrupt and allows the probe to occur.

Please check the following snippet of code (from portdrv_core.c).

IIUC, pcie_device_init() will not be called if PCIE_PORT_SERVICE_DPC is
not set in capabilities. Your change in portdrv_core.c already
selectively enables the PCIE_PORT_SERVICE_DPC service based on
native_dpc value.

So IMO, adding native_dpc check in dpc_probe() is redundant.

int pcie_port_device_register(struct pci_dev *dev)
	/* Allocate child services if any */
	status = -ENODEV;
	nr_service = 0;
	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
		int service = 1 << i;
		if (!(capabilities & service))
			continue;
		if (!pcie_device_init(dev, service, irqs[i]))
			nr_service++;
	}

> 
> The probe itself will still fail if there's a mixed-mode _OSC
> negotiated AER & DPC, due to pcie_aer_get_firmware_first returning 1
> for AER and no check for DPC.
> 
> I don't know if such a platform will exist, but the kernel is already
> wired for 'dpc-native' so it makes sense to extend it for this..
> 
> This transform might be more readable:
> 	if (pcie_aer_get_firmware_first(pdev) &&
> 	    !(pcie_ports_dpc_native || hb->native_dpc))
> 
> 
> 
>>>    		return -ENOTSUPP;
>>>    
>>>    	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
>>> index 50a9522..f2139a1 100644
>>> --- a/drivers/pci/pcie/portdrv_core.c
>>> +++ b/drivers/pci/pcie/portdrv_core.c
>>> @@ -256,7 +256,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>>>    	 */
>>>    	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>>    	    pci_aer_available() &&
>>> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>>> +	    (pcie_ports_dpc_native || host->native_dpc ||
>>> +	     (services & PCIE_PORT_SERVICE_AER)))
>>>    		services |= PCIE_PORT_SERVICE_DPC;
>>>    
>>>    	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
>>>
