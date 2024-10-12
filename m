Return-Path: <linux-pci+bounces-14381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA499B347
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D30791F2101D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750E11547CD;
	Sat, 12 Oct 2024 11:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1Y6mNER"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5029B14D2A7
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728731426; cv=none; b=KZ9dWb9TMfBpW62qmM5SDdCMuG8K4b022HYbBG89Tz6f5RkDpaGBSLwTPMr0E6HfjZtfuTHXCVR8AAA1VR4jOVa3hPLmoLOOe4uwT2CG28OGM7klIpYFl0XAdFEVycfynaKvPmlgDz83jkNPKKhDqRtWnDfZOUHRHE8EjiNBZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728731426; c=relaxed/simple;
	bh=qXYBwUsW6erE9fuVyP7OhTufIIAAUaw9V+TccvnrSFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td37lR64tzB0JyyBtHhiegBK2VlQ8eAYJAWu7dehNP675FSQ3sVL6fwodfkZHSl/HIwmVt3QJDZmCk/Lc59SlEqopw8YLFR+0pG7s9vh/X/GjcW6xqUtvPVCnP8g+Leno4u40KyUwHwBOCjBZ85du+xE3AlQiqChkAqdMPmseEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1Y6mNER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33952C4CEC6;
	Sat, 12 Oct 2024 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728731425;
	bh=qXYBwUsW6erE9fuVyP7OhTufIIAAUaw9V+TccvnrSFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R1Y6mNERDguJyYcq0yD+qWJLfVc33vwou3878hA1GT0GGPx7pcNvgBmoP2D+6ErNj
	 ijUHaF+hZvnawBlozcQ2xpYqDgYk7O4ZTH69caOwHSre6GcZxt6u4wFT+dBQekEBiZ
	 i3MaPmbYO59B5ikoLxMr2jXZEPhfggm88LmTo+nDj8nONXf/bcI2biXULzpTIorDQb
	 9n/XQK0d2C2rfBmG6mA7Raqf6W+xtbR2ojxfXEV7Qq95B3jYuv2JySyAWjuwRfs/WW
	 qcyUbN2JMYG4+7lWRizlpHL6Tc1ynnRAGbbrEjt2kYO/diH9o07BFu3G0lnSQ4eYwa
	 JUlJD9oWHAezw==
Message-ID: <71a867f6-1caa-4dea-b5f7-702ad6387a71@kernel.org>
Date: Sat, 12 Oct 2024 20:10:22 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-5-dlemoal@kernel.org>
 <20241010164355.okuasill4hzsipun@thinkpad>
 <ee174108-66d5-4a4e-8051-d4a5889ecd10@kernel.org>
 <20241012075654.d33yqcregmtjbkfi@thinkpad>
 <104e1cf9-f901-4e47-8a79-cf8df08d1ce1@kernel.org>
 <20241012094108.ovxmd2ikhisyejqs@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241012094108.ovxmd2ikhisyejqs@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/24 18:41, Manivannan Sadhasivam wrote:
> On Sat, Oct 12, 2024 at 05:33:34PM +0900, Damien Le Moal wrote:
>> On 10/12/24 16:56, Manivannan Sadhasivam wrote:
>>> On Fri, Oct 11, 2024 at 11:01:09AM +0900, Damien Le Moal wrote:
>>>> On 10/11/24 01:43, Manivannan Sadhasivam wrote:
>>>>> On Mon, Oct 07, 2024 at 01:03:16PM +0900, Damien Le Moal wrote:
>>>>>> Introduce the function pci_epc_mem_map() to facilitate controller memory
>>>>>> address allocation and mapping to a RC PCI address region in endpoint
>>>>>> function drivers.
>>>>>>
>>>>>> This function first uses pci_epc_map_align() to determine the controller
>>>>>> memory address size (and offset into) depending on the controller
>>>>>> address alignment constraints. The result of this function is used to
>>>>>> allocate a controller physical memory region using
>>>>>> pci_epc_mem_alloc_addr() and map that memory to the RC PCI address
>>>>>> space with pci_epc_map_addr().
>>>>>>
>>>>>> Since pci_epc_map_align() may indicate that the effective mapping
>>>>>> of a PCI address region is smaller than the user requested size,
>>>>>> pci_epc_mem_map() may only partially map the RC PCI address region
>>>>>> specified. It is the responsibility of the caller (an endpoint function
>>>>>> driver) to handle such smaller mapping.
>>>>>>
>>>>>> The counterpart of pci_epc_mem_map() to unmap and free the controller
>>>>>> memory address region is pci_epc_mem_unmap().
>>>>>>
>>>>>> Both functions operate using a struct pci_epc_map data structure
>>>>>> Endpoint function drivers can use struct pci_epc_map to access the
>>>>>> mapped RC PCI address region using the ->virt_addr and ->pci_size
>>>>>> fields.
>>>>>>
>>>>>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
>>>>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>>>>>
>>>>> Looks good to me. Just one comment below.
>>>>>
>>>>>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
>>>>>> ---
>>>>>>  drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
>>>>>>  include/linux/pci-epc.h             |  4 ++
>>>>>>  2 files changed, 82 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
>>>>>> index 1adccf07c33e..d03c753d0a53 100644
>>>>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>>>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>>>>> @@ -532,6 +532,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>>>>  }
>>>>>>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>>>>>  
>>>>>> +/**
>>>>>> + * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
>>>>>> + * @epc: the EPC device on which the CPU address is to be allocated and mapped
>>>>>> + * @func_no: the physical endpoint function number in the EPC device
>>>>>> + * @vfunc_no: the virtual endpoint function number in the physical function
>>>>>> + * @pci_addr: PCI address to which the CPU address should be mapped
>>>>>> + * @pci_size: the number of bytes to map starting from @pci_addr
>>>>>> + * @map: where to return the mapping information
>>>>>> + *
>>>>>> + * Allocate a controller memory address region and map it to a RC PCI address
>>>>>> + * region, taking into account the controller physical address mapping
>>>>>> + * constraints using pci_epc_map_align().
>>>>>> + * The effective size of the PCI address range mapped from @pci_addr is
>>>>>> + * indicated by @map->pci_size. This size may be less than the requested
>>>>>> + * @pci_size. The local virtual CPU address for the mapping is indicated by
>>>>>> + * @map->virt_addr (@map->phys_addr indicates the physical address).
>>>>>> + * The size and CPU address of the controller memory allocated and mapped are
>>>>>> + * respectively indicated by @map->map_size and @map->virt_base (and
>>>>>> + * @map->phys_base).
>>>>>> + *
>>>>>> + * Returns 0 on success and a negative error code in case of error.
>>>>>> + */
>>>>>> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>>>>> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
>>>>>> +{
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);
>>>>>
>>>>> I don't like the fact that one structure is passed to two functions and both
>>>>> modify some members. If you get rid of the pci_epc_map_align() API and just use
>>>>> the callback, then the arguments could be passed on their own without the 'map'
>>>>> struct.
>>>>
>>>> That would be far too many arguments. The pci_epc functions already have many
>>>> (minimum of 3 for epc, func and vfunc). So I prefer trying to minimize that.
>>>>
>>>
>>> Actually, there is no need to pass 'func, vfunc' as I don't think the controller
>>> can have different alignment requirements for each functions.
>>>
>>> So I'm envisioning a callback like this:
>>>
>>> 	u64 (*align_addr)(struct pci_epc *epc, u64 addr, size_t *offset, size_t *size);
>>>
>>> And there is no need to check the error return also. Also you can avoid passing
>>> 'offset', as the caller can derive the offset using the mapped and unmapped
>>> addresses. This also avoids the extra local function and allows the callers to
>>> just use the callback directly.
>>>
>>> NOTE: Please do not respin the patches without concluding the comments on
>>> previous revisions. I understand that you want to get the series merged asap and
>>> I do have the same adjective.
>>
>> v5 that I posted yesterday addressed all your comment, except the one above.
>> The controller operation (renamed get_mem_map) still uses the pci_mem_map
>> structure as argument.
>>
>> I need to respin a v6. Do you want me to change the controller op as you suggest
>> above ?
>>
> 
> Please do so. I will apply it right away as everything else looks good.

Done. Under test now but everything is looking good. Note that I kept the offset
argument as otherwise pci_epc_mem_map() needs to re-calculate it but the
controller ->align_addr() may already have calculated it (or can calculate it
more efficiently than with a substraction).

So keeping offset as an argument is cleaner I think.

I also remove the mutex lock/unlock around ->align_addr() call as I really do
not think it is necessary at all (and if needed a controller implementation of
align_addr can always take that mutex).


-- 
Damien Le Moal
Western Digital Research

