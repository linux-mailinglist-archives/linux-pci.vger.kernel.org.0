Return-Path: <linux-pci+bounces-15086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9279ABBE0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 04:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917651C22591
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 02:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC5335C0;
	Wed, 23 Oct 2024 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ec2PaJPS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE317F7
	for <linux-pci@vger.kernel.org>; Wed, 23 Oct 2024 02:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651905; cv=none; b=iOTnHSIJIkLVkx/cRl9d96/yTGd9wHX0p3oey+CmoH80zb4Z+TdNLXqOL84qHVOxdact2eQQbyG+OrvkJlUY/kgdYpbBDt/kEgca4PyDNIbHVrkCfL/cLIAL2d0U9Ye5RGzEd8zB+rDfLU8+hDi1YZyj23L+iZIBWj6C/MTCcv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651905; c=relaxed/simple;
	bh=xYUzh5/iQ6AOc9DtwnrC+eGFrV7nATsTvqTevKDQO+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWY8fPmKEaK7iP8p+eZAVrZyaVQg1qLv4XYBrj+Y7WWqRX/OrNjQb0fl8heqnhXPwovXFod/kni2SsZ+DHTDX5seLOcZVt7IrF8YHa/VtV8RB5JGJIE+wIiFocpkneWkTmG9mU+mwk+yIVhd+2PYxDL2i+I0h5f5VuawrlDlTOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ec2PaJPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3BBC4CEC3;
	Wed, 23 Oct 2024 02:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729651904;
	bh=xYUzh5/iQ6AOc9DtwnrC+eGFrV7nATsTvqTevKDQO+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ec2PaJPSqkm5HZAp3dCxlqxuJPFoNnHhRezzcNPwzQNZ73pjc3j7vEVkv1fYz9n1+
	 XQaCLVvyNcJiV2EuHUAwuFeSCjlQykSVALPKSBBS1AaC82Y+Kvwlu/GKkJtx1wNnsd
	 hvIKTE9P+bd1tXj/z1s80MTvLTLOUOxwyVy8vHfPzA2DGH9axPTYCm00ZLx4Jrh0pW
	 5/Ur96rIcVfx4p4DLR2DiZ1m5SoShpSrSLZs2qfgndOPpmwgtSu6dO3pBI99qErK9/
	 D7jSKdpctNuoa3OeqNFmW+ESY8cJ2/gBaKBrP18SbAfljRauAVYNMU2T2GAyX2d4h9
	 WJUqD3BsW6ylg==
Message-ID: <fced0bf9-dcd3-4c04-af19-505b943c6440@kernel.org>
Date: Wed, 23 Oct 2024 11:51:41 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241022234926.GA893145@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241022234926.GA893145@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 08:49, Bjorn Helgaas wrote:
> On Wed, Oct 23, 2024 at 07:05:54AM +0900, Damien Le Moal wrote:
>> On 10/23/24 05:47, Bjorn Helgaas wrote:
>>> On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
>>>> On 10/22/24 07:19, Bjorn Helgaas wrote:
>>>>> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
>>>>>> This series introduces the new functions pci_epc_mem_map() and
>>>>>> pci_epc_mem_unmap() to improve handling of the PCI address mapping
>>>>>> alignment constraints of endpoint controllers in a controller
>>>>>> independent manner.
>>>>>
>>>>> Hi Damien, I know this is obvious to everybody except me, but who
>>>>> uses this mapping?  A driver running on the endpoint that does
>>>>> MMIO?  DMA (Memory Reads or Writes that target an endpoint BAR)?
>>>>> I'm still trying to wrap my head around the whole endpoint driver
>>>>> model.
>>>>
>>>> The mapping API is for mmio or DMA using endpoint controller memory
>>>> mapped to a host PCI address range. It is not for BARs. BARs setup
>>>> does not use the same API and has not changed with these patches.
>>>>
>>>> BARs can still be accessed on the endpoint (within the EPF driver)
>>>> with regular READ_ONCE()/WRITE_ONCE() once they are set. But any
>>>> data transfer between the PCI RC host and the EPF driver on the EP
>>>> host that use mmio or DMA generic channel (memory copy offload
>>>> channel) needs the new mapping API. DMA transfers that can be done
>>>> using dedicated DMA rx/tx channels associated with the endpoint
>>>> controller do not need to use this API as the mapping to the host
>>>> PCI address space is automatically handled by the DMA driver.
>>>
>>> Sorry I'm dense.  I'm really not used to thinking in the endpoint
>>> point of view.  Correct me where I go off the rails:
>>>
>>>   - This code (pci_epc_mem_map()) runs on an endpoint, basically as
>>>     part of some endpoint firmware, right?
>>
>> Not sure what you mean by "firmware" here. pci_epc_mem_map() is
>> intended for use by a PCI endpoint function driver on the EP side,
>> nothing else.
> 
> I mean the software operating the endpoint from the "inside", not from
> the PCIe side.

Got it. So yes, a real device firmware, or a PCI endpoint function driver for a
machine running the PCI endpoint framework.

> In a non-endpoint framework scenario, the kernel running on the host
> enumerates PCI devices using config reads, and a driver like nvme runs
> on the host and operates an NVMe device with config accesses and MMIO
> to the NVMe BARs.

Yep, I know that.

>> pci_epc_mem_map() does not receive anything itself. It only
>> allocates local EP controller memory from outbound ATU windows and
>> map that to a PCI address region of the host (RC side). Here "map"
>> means programming the ATU using a correctly aligned PCI address that
>> satisfies the EP PCI controller alignment constraints.
> 
> I assumed we were talking about an endpoint responding to PCIe traffic
> generated elsewhere, but I think my assumption was wrong.

Not at all. See below.

> I don't have any specs for these endpoint controllers, and there's
> nothing in Documentation/PCI/endpoint/ about ATUs.  Some doc and a few
> pictures would go a long ways.

Agree. The PCI endpoint API documentation is far from great and should be
improved. Will try to do something about it.

>> The memory read/write TLPs will happen once the EP function driver
>> access the mapped memory with memcpy_fromio/toio() (or use generic
>> memory copy offload DMA channel).
> 
> This would be the endpoint itself *initiating* DMA TLPs on PCIe, not
> responding to incoming DMA, I guess.

It can be both. What differs is how the endpint gets the PCI address to read/write.

For an endpoint initiated transfer, typically, the PCI address is obtained from
some "command" received through a BAR or through DMA. The command has the PCI
addresses to use for transfering data to/from the host (e.g. an nvme rw command
uses PRPs or SGLs to specify the PCI address segments for the data buffer of a
command). For this case, the EPF driver calls calls pci_epc_mem_map() for the
command buffer, does the transfer (memcpy_toio/fromio()) and unmaps with
pci_epc_mem_unmap(). Note though that here, if an eDMA channel is used for the
transfer, the DMA engine will do the mapping automatically and the epf does not
need to call pci_epc_mem_map()/pci_epc_mem_unmap(). There is still an issue in
this area which is that it is *not* clear if the DMA channel used can actually
do the mapping automatically or not. E.g. the generic DMA channel (mem copy
offload engine) will not. So there is still some API improvement needed to
abstract more HW dependent things here.

For a RC initiated transfer, the transfers are not done to random addresses.
E.g. using NVMe CMB (controller memory buffer), the host will tell the endpoint
"I want to use the CMB with this PCI address". Then the endpoint can use
pci_epc_mem_map() to map the CMB to said PCI address and exchange data with the
host through it.

>>>   - These TLPs would be generated elsewhere in the PCIe fabric, e.g.,
>>>     by a driver on the host doing MMIO to the endpoint, or possibly
>>>     another endpoint doing peer-to-peer DMA.
>>
>> MMIO or DMA, yes.
>>
>>>   - Mem read/write TLPs are routed by address, and the endpoint
>>>     accepts them if the address matches one of its BARs.
>>
>> Yes, but pci_epc_mem_map() is not for use for BARs on the EP side.
>> BARs setup on EP PCI controllers use inbound ATU windows.
>> pci_epc_mem_map() programs outbound ATU windows. BARs setup use
>> pci_epf_alloc_space() + pci_epc_set_bar() to setup a BAR.
>>
>>>   - This is a little different from a Root Complex, which would
>>>     basically treat reads/writes to anything outside the Root Port
>>>     windows as incoming DMA headed to physical memory.
>>>
>>>   - A Root Complex would use the TLP address (the PCI bus address)
>>>     directly as a CPU physical memory address unless the TLP address
>>>     is translated by an IOMMU.
>>>
>>>   - For the endpoint, you want the BAR to be an aperture to physical
>>>     memory in the address space of the SoC driving the endpoint.
>>
>> Yes, and as said above this is done with pci_epf_alloc_space() +
>> pci_epc_set_bar(), not pci_epc_mem_map().
> 
> And if the endpoint is *initiating* DMA, BARs of that endpoint are not
> involved at all.  The target of the DMA would be either host memory or
> a BAR of another endpoint.

Yes.

>>>   - The SoC physical memory address may be different from the PCI but
>>>     address in the TLP, and pci_epc_mem_map() is the way to account
>>>     for this?
>>
>> pci_epc_mem_map() is essentially a call to pci_epc_mem_alloc_addr()
>> + pci_epc_map_addr(). pci_epc_mem_alloc_addr() allocates memory from
>> the EP PCI controller outbound windows and pci_epc_map_addr()
>> programs an EP PCI controller outbound ATU entry to map that memory
>> to some PCI address region of the host (RC).
> 
> I see "RC" and "RC address" used often in this area, but I don't quite
> understand the RC connection.  It sounds like this might be the PCI
> memory address space, i.e., the set of addresses that might appear in
> PCIe TLPs?

Yes. Sorry about that. PCI address == RC address in my head since the endpoint
does not "own" the PCI address space, the host RC does.

> Does "EPC addr space" refer to the physical address space of the
> processor operating the endpoint, or does it mean something more
> specific?

Correct. EPC address is the local memory address on the endpoint, so CPU
addresses. For something that maps to a RC PCI address, that generally mean
addresses withing the EP PCI controller outbound memory regions.


-- 
Damien Le Moal
Western Digital Research

