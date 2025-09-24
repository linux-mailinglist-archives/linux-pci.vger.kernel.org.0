Return-Path: <linux-pci+bounces-36894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3239B9BC0E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 21:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E43E3A8BDE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE6E21CA03;
	Wed, 24 Sep 2025 19:49:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB21DDDD;
	Wed, 24 Sep 2025 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743375; cv=none; b=n7F6HNbdyrqdFPUfMk+vNvKLUjVmui89WRMF7D5bko1BVye3FC9h3FopXWaIsk+R5EBU16OZmkI++KCp4mVvJp1QW/qQoSwVIWncHI8ojbF+sffOZIRbrIZ65d2SWewQ0pCdtEozSmi9K4N8w+A4LcriE4wFvBTjTruLiHLwC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743375; c=relaxed/simple;
	bh=FEJg+t1FKAiteeSKBWppRBndkBft/Nyve/5+/2CHD+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hg4ez+ySauxDRqTTmWxxtxk6baeCiRkpUlaBZBZDADPe22uQMDYS2VEUKZogDdq/eVjX21nYzx117R5NoKb4CUsiGkVLlwov343kEcQxhYP8gDLc4zIgbucY/w1BBdsaMH8G3QhaDdWp23281gvvBpswr/NnvFteFCQUsNPhHwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D485106F;
	Wed, 24 Sep 2025 12:49:24 -0700 (PDT)
Received: from [10.57.32.18] (unknown [10.57.32.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3BFC3F66E;
	Wed, 24 Sep 2025 12:49:29 -0700 (PDT)
Message-ID: <b8a871d8-d84b-4c86-8f63-f4e1b2a5fccf@arm.com>
Date: Wed, 24 Sep 2025 20:49:26 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/of: Call pci_request_acs() before enumerating
 the Root Port device
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
 iommu@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
 Xingang Wang <wangxingang5@huawei.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org
References: <20250924185750.GA2128243@bhelgaas>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250924185750.GA2128243@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-24 7:57 pm, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2025 at 02:20:52PM +0530, Manivannan Sadhasivam wrote:
>> On Tue, Sep 23, 2025 at 03:27:01PM -0500, Bjorn Helgaas wrote:
>>> On Wed, Sep 10, 2025 at 11:09:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
>>>> From: Xingang Wang <wangxingang5@huawei.com>
>>>>
>>>> When booting with devicetree, ACS is enabled for all ACS capable
>>>> PCI devices except the first Root Port enumerated in the system.
>>>> This is due to calling pci_request_acs() after the enumeration
>>>> and initialization of the Root Port device.
>>>
>>> I suppose you're referring to a path like below, where we *check*
>>> pci_acs_enable during PCI enumeration, but we don't *set* it until
>>> we add the device and look for a driver for it?
>>>
>>>    pci_host_common_init
>>>      devm_pci_alloc_host_bridge
>>>        devm_of_pci_bridge_init
>>>          pci_request_acs
>>>            pci_acs_enable = 1                    # ++ new set here
>>>      pci_host_probe
>>>        pci_scan_root_bus_bridge
>>>          pci_scan_device
>>>            pci_init_capabilities
>>>              pci_enable_acs
>>>                if (pci_acs_enable)               # test here
>>>                  ...
>>>        pci_bus_add_devices
>>>          driver_probe_device
>>>            pci_dma_configure
>>>              of_dma_configure
>>>                of_dma_configure_id
>>>                  of_iommu_configure
>>>                    pci_request_acs
>>>                      pci_acs_enable = 1          # -- previously set here
>>>
>>
>> Yes!
>>
>>>> But afterwards, ACS is getting enabled for the rest of the PCI
>>>> devices, since pci_request_acs() sets the 'pci_acs_enable' flag
>>>> and the PCI core uses this flag to enable ACS for the rest of
>>>> the ACS capable devices.
>>>
>>> I don't quite understand why ACS would be enabled for *any* of the
>>> devices because we generally enumerate all of them, which includes
>>> the pci_init_capabilities() and pci_enable_acs(), before adding
>>> and attaching drivers to them.
>>>
>>> But it does seem kind of dumb that we set the system-wide "enable
>>> ACS" property in a per-device place like an individual device
>>> probe.
>>
>> I had the same opinion when I saw the 'pci_acs_enable' flag. But I
>> think the intention was to enable ACS only if the controller is
>> capable of assigning different IOMMU groups per device. Otherwise,
>> ACS is more or less of no use.
>>
>>>> Ideally, pci_request_acs() should only be called if the
>>>> 'iommu-map' DT property is set for the host bridge device.
>>>> Hence, call pci_request_acs() from devm_of_pci_bridge_init() if
>>>> the 'iommu-map' property is present in the host bridge DT node.
>>>> This aligns with the implementation of the ARM64 ACPI driver
>>>> (drivers/acpi/arm64/iort.c) as well.
>>>>
>>>> With this change, ACS will be enabled for all the PCI devices
>>>> including the first Root Port device of the DT platforms.
>>>>
>>>> Cc: stable@vger.kernel.org # 5.6
>>>> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when configuring IOMMU linkage")
>>>> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
>>>> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
>>>> [mani: reworded subject, description and comment]
>>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>> ---
>>>>   drivers/iommu/of_iommu.c | 1 -
>>>>   drivers/pci/of.c         | 8 +++++++-
>>>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>>> index 6b989a62def20ecafd833f00a3a92ce8dca192e0..c31369924944d36a3afd3d4ff08c86fc6daf55de 100644
>>>> --- a/drivers/iommu/of_iommu.c
>>>> +++ b/drivers/iommu/of_iommu.c
>>>> @@ -141,7 +141,6 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
>>>>   			.np = master_np,
>>>>   		};
>>>>   
>>>> -		pci_request_acs();
>>>>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>>>>   					     of_pci_iommu_init, &info);
>>>>   		of_pci_check_device_ats(dev, master_np);
>>>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>>>> index 3579265f119845637e163d9051437c89662762f8..98c2523f898667b1618c37451d1759959d523da1 100644
>>>> --- a/drivers/pci/of.c
>>>> +++ b/drivers/pci/of.c
>>>> @@ -638,9 +638,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>>>>   
>>>>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>>>>   {
>>>> -	if (!dev->of_node)
>>>> +	struct device_node *node = dev->of_node;
>>>> +
>>>> +	if (!node)
>>>>   		return 0;
>>>>   
>>>> +	/* Enable ACS if IOMMU mapping is detected for the host bridge */
>>>> +	if (of_property_read_bool(node, "iommu-map"))
>>>> +		pci_request_acs();
>>>
>>> I'm not really convinced that the existence of 'iommu-map' in
>>> devicetree is a clear signal that ACS should be enabled, so I'm a
>>> little hesitant about this part.
>>>
>>> Is it possible to boot using a devicetree with 'iommu-map', but
>>> with the IOMMU disabled or the IOMMU driver not present?  Or other
>>> situations where we don't need ACS?
>>
>> Certainly possible. But the issue is, we cannot reliably detect the
>> presence of IOMMU until the first pci_dev is created, which will be
>> too late as pci_acs_init() is called during pci_device_add().
>>
>> This seems to be the case for ACPI platforms also.
> 
> I don't doubt that the current code doesn't detect presence or use of
> IOMMU until later.  But that feels like an implementation defect
> because logically the IOMMU is upstream of any PCI device that uses
> it, so architecturally I would expect it to be *possible* to detect it
> before PCI enumeration.
> 
> More to the point, it's not at all obvious how to infer that
> 'iommu-map' in the devicetree means the IOMMU will be used.

Indeed, I would say the way to go down that route would be to echo what 
we do for "iommus", and defer probing the entire host controller driver 
until the targets of an "iommu-map" are either present or assumed to 
never be appearing. (And of course an ACPI equivalent for that would be 
tricky...)

However, even that isn't necessarily the full solution, as just as it's 
not really appropriate for PCI to force ACS without knowing whether an 
IOMMU is actually present to make it meaningful, it's also not strictly 
appropriate for an IOMMU driver to request ACS globally without knowing 
that it actually serves any relevant PCIe devices. Even in the ideal 
scenario, I think the point of actually knowing is still a bit too late 
for the current API design:

   pci_device_add
     pci_init_capabilities
       pci_acs_init
         pci_enable_acs
     device_add
       iommu_bus_notifier
         iommu_probe_device
           //logically, request ACS for dev here

(at the moment, iommu_probe_device() will actually end up calling into 
the same of_iommu_configure()->pci_request_acs() path, but the plan is 
still to eventually shorten and streamline that.)

I guess we might want to separate the actual ACS enablement from the 
basic capability init, or at least perhaps just call pci_enable_acs() 
again after the IOMMU notifier may have changed the policy?

Thanks,
Robin.

