Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA80D2C71A4
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 23:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgK1WAD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 17:00:03 -0500
Received: from mga01.intel.com ([192.55.52.88]:41245 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730912AbgK1Vvb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 16:51:31 -0500
IronPort-SDR: U+dvLNbAXCkrTE0OaIbNHB7qPt3wjuF5QqECk1ISEu6TYSd1fOHsiaK0rVjLBWcS0S2l50ul5T
 lisV3VcBF2Rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="190672554"
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="190672554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 13:49:50 -0800
IronPort-SDR: xPAILbRL8nzq+KLp4NwdGzLXjuc5GYLLH8NGDPYRo2NtKOfu54xWVq2dlhKoF8n0ZwJ4d4ksAl
 OAmQ62/SIYfA==
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="334093975"
Received: from chhaviga-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 13:49:49 -0800
Subject: Re: [PATCH 1/5] PCI/DPC: Ignore devices with no AER Capability
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
References: <20201128202408.GA906784@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c2a7c9e6-8916-2c14-4968-a963266e6c53@linux.intel.com>
Date:   Sat, 28 Nov 2020 13:49:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201128202408.GA906784@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/28/20 12:24 PM, Bjorn Helgaas wrote:
> On Wed, Nov 25, 2020 at 06:01:57PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>> On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Downstream Ports may support DPC regardless of whether they support AER
>>> (see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
>>> "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
>>> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
>>> depends on the AER Capability.
>>>
>>> dpc_probe() previously failed if:
>>>
>>>     !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
>>>     !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law
>>>
>>> so it succeeded if:
>>>
>>>     pcie_aer_is_native() || pcie_ports_dpc_native
>>>
>>> Fail dpc_probe() if the device has no AER Capability.
>>>
>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> ---
>>>    drivers/pci/pcie/dpc.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>> index e05aba86a317..ed0dbc43d018 100644
>>> --- a/drivers/pci/pcie/dpc.c
>>> +++ b/drivers/pci/pcie/dpc.c
>>> @@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
>>>    	int status;
>>>    	u16 ctl, cap;
>>> +	if (!pdev->aer_cap)
>>> +		return -ENOTSUPP;
>> Don't we check aer_cap support in drivers/pci/pcie/portdrv_core.c ?
>>
>> We don't enable DPC service, if AER service is not enabled. And AER
>> service is only enabled if AER capability is supported.
>>
>> So dpc_probe() should not happen if AER capability is not supported?
> 
> I don't think that's always true.  If I'm reading this right, we have
> this:
> 
>    get_port_device_capability(...)
>    {
>    #ifdef CONFIG_PCIEAER
>      if (dev->aer_cap && ...)
>        services |= PCIE_PORT_SERVICE_AER;
>    #endif
> 
>      if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>          pci_aer_available() &&
>          (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>        services |= PCIE_PORT_SERVICE_DPC;
>    }
> 
> and in the case where:
> 
>    - CONFIG_PCIEAER=y
>    - booted with "pcie_ports=dpc-native" (pcie_ports_dpc_native is true)
>    - "dev" has no AER capability
>    - "dev" has DPC capability
> 
> I think we do enable PCIE_PORT_SERVICE_DPC.
Got it. But further looking into it, I am wondering whether
we should keep this dependency? Currently we just use it to
dump the error information. Do we need to create dependency
between DPC and AER (which is functionality not dependent) just
to see more details about the error?
> 
>> 206 static int get_port_device_capability(struct pci_dev *dev)
>> ...
>> ...
>> 251         if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>> 252             host->native_dpc &&
>> 253             (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
>> 254                 services |= PCIE_PORT_SERVICE_DPC;
>> 255
>>
>>> +
>>>    	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
>>>    		return -ENOTSUPP;
>>>
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
