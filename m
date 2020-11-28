Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A032C7185
	for <lists+linux-pci@lfdr.de>; Sat, 28 Nov 2020 22:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391357AbgK1V6M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 28 Nov 2020 16:58:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:45311 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391431AbgK1V6I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 28 Nov 2020 16:58:08 -0500
IronPort-SDR: QPxc2KfhL7zJsxy4ejqThiH+7qjG89vFDZFGu7g8HVnlEGC4VBo69v+iYMLVoIXEzSh/qlHV1C
 3aq/Wg2VUf3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9819"; a="169004412"
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="169004412"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 13:56:27 -0800
IronPort-SDR: keiUCRZk0TETNAPKJJJSCo/axBw1rmuISWUohGFmnDDMhsRYMrr4gG9xcfXYQDTHbDPnW1i1/x
 eoa/pPpHqc2g==
X-IronPort-AV: E=Sophos;i="5.78,378,1599548400"; 
   d="scan'208";a="334094934"
Received: from chhaviga-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.149])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2020 13:56:26 -0800
Subject: Re: [PATCH 1/5] PCI/DPC: Ignore devices with no AER Capability
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>
References: <20201128215318.GA924062@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5646ac56-3b4a-d060-18ab-28722c337d00@linux.intel.com>
Date:   Sat, 28 Nov 2020 13:56:23 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201128215318.GA924062@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/28/20 1:53 PM, Bjorn Helgaas wrote:
> On Sat, Nov 28, 2020 at 01:49:46PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>> On 11/28/20 12:24 PM, Bjorn Helgaas wrote:
>>> On Wed, Nov 25, 2020 at 06:01:57PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>>>> On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
>>>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>>>
>>>>> Downstream Ports may support DPC regardless of whether they support AER
>>>>> (see PCIe r5.0, sec 6.2.10.2).  Previously, if the user booted with
>>>>> "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
>>>>> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
>>>>> depends on the AER Capability.
>>>>>
>>>>> dpc_probe() previously failed if:
>>>>>
>>>>>      !pcie_aer_is_native(pdev) && !pcie_ports_dpc_native
>>>>>      !(pcie_aer_is_native() || pcie_ports_dpc_native)    # by De Morgan's law
>>>>>
>>>>> so it succeeded if:
>>>>>
>>>>>      pcie_aer_is_native() || pcie_ports_dpc_native
>>>>>
>>>>> Fail dpc_probe() if the device has no AER Capability.
>>>>>
>>>>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Cc: Olof Johansson <olof@lixom.net>
>>>>> ---
>>>>>     drivers/pci/pcie/dpc.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>>>> index e05aba86a317..ed0dbc43d018 100644
>>>>> --- a/drivers/pci/pcie/dpc.c
>>>>> +++ b/drivers/pci/pcie/dpc.c
>>>>> @@ -287,6 +287,9 @@ static int dpc_probe(struct pcie_device *dev)
>>>>>     	int status;
>>>>>     	u16 ctl, cap;
>>>>> +	if (!pdev->aer_cap)
>>>>> +		return -ENOTSUPP;
>>>> Don't we check aer_cap support in drivers/pci/pcie/portdrv_core.c ?
>>>>
>>>> We don't enable DPC service, if AER service is not enabled. And AER
>>>> service is only enabled if AER capability is supported.
>>>>
>>>> So dpc_probe() should not happen if AER capability is not supported?
>>>
>>> I don't think that's always true.  If I'm reading this right, we have
>>> this:
>>>
>>>     get_port_device_capability(...)
>>>     {
>>>     #ifdef CONFIG_PCIEAER
>>>       if (dev->aer_cap && ...)
>>>         services |= PCIE_PORT_SERVICE_AER;
>>>     #endif
>>>
>>>       if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>>>           pci_aer_available() &&
>>>           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
>>>         services |= PCIE_PORT_SERVICE_DPC;
>>>     }
>>>
>>> and in the case where:
>>>
>>>     - CONFIG_PCIEAER=y
>>>     - booted with "pcie_ports=dpc-native" (pcie_ports_dpc_native is true)
>>>     - "dev" has no AER capability
>>>     - "dev" has DPC capability
>>>
>>> I think we do enable PCIE_PORT_SERVICE_DPC.
>> Got it. But further looking into it, I am wondering whether
>> we should keep this dependency? Currently we just use it to
>> dump the error information. Do we need to create dependency
>> between DPC and AER (which is functionality not dependent) just
>> to see more details about the error?
> 
> That's a good question, but I don't really want to get into the actual
> operation of the AER and DPC drivers in this series, so maybe
> something we should explore later.
In that case, can you move this check to drivers/pci/pcie/portdrv_core.c?
I don't see the point of distributed checks in both get_port_device_capability()
and dpc_probe().
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
