Return-Path: <linux-pci+bounces-15064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 158949AB950
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EA21F23CF4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 22:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15991CCB50;
	Tue, 22 Oct 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbWxnOU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D413B58A
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 22:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634758; cv=none; b=JhFfTR69nw5Oy9yMpDP/6/vnRz1ddQ15cpBshTe9+5i3jqj8DTap0h6PJrR6uJ5dGFb2a6F49uuKkzRbYB/pZsyttN8MnYBbczwtkni9rhqTqUZOeaWFfcKmQXOMz7RHSUUPbLwv/ppY+ip4xyyzpGuwOAUqyd+SXFLSBxXnvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634758; c=relaxed/simple;
	bh=lNx0k8Y88rFJJBYAPnXXZExVsZqVdVRSmPS0Az9OfaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reoJDF0CZ34ZfeXtsUqVOS3wd2pHPvqxi5O/nONeOSu6ZjZ9s8+R70ufcDMRHsyP/7IDdZ/083Xls3jZTIJzWb7ScG7rfedzoRqcg4oVEnwpSrNrTGiDxvYm8jXXvO3dWgv+YHCdJd5kDkZUuSfLopwB76JJyOPD64ZAfGPA9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbWxnOU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB05C4CEC3;
	Tue, 22 Oct 2024 22:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729634758;
	bh=lNx0k8Y88rFJJBYAPnXXZExVsZqVdVRSmPS0Az9OfaE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bbWxnOU6j4ew/XA0AlqQ7IiFc79zI0s3PUrllvw+WXEoln400DE005LBIk5PbiPon
	 xAJHT2bOniiM70g0POirHldYhrPU4V6zAozl7wZ29s4akTsJtDJV55s3VvaoA6eA7V
	 XLlZLGzki/RcTQL3GQHExDvPVj09TPSBZu30ns2NkFhuxugI3toX7eUwKE3QrCTaeV
	 gunUv+IabTXZkLMVVksrnQzx6JpQD0pSxLq7BTio1fV2VekmXZn9ZMzf3AKTmq/ZQR
	 shUOdeWQ4XldbHVOWuBgtegCv556+iKrNnm4ZJ5KcIYR9EIRUz9Ea3wmLhcnadXyQZ
	 m47f+6Ys1BSgg==
Message-ID: <2632a47f-c627-4a9b-98a9-d5dc6fd25ef8@kernel.org>
Date: Wed, 23 Oct 2024 07:05:54 +0900
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
References: <20241022204752.GA881656@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241022204752.GA881656@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/24 05:47, Bjorn Helgaas wrote:
> On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
>> On 10/22/24 07:19, Bjorn Helgaas wrote:
>>> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
>>>> This series introduces the new functions pci_epc_mem_map() and
>>>> pci_epc_mem_unmap() to improve handling of the PCI address mapping
>>>> alignment constraints of endpoint controllers in a controller
>>>> independent manner.
>>>
>>> Hi Damien, I know this is obvious to everybody except me, but who
>>> uses this mapping?  A driver running on the endpoint that does
>>> MMIO?  DMA (Memory Reads or Writes that target an endpoint BAR)?
>>> I'm still trying to wrap my head around the whole endpoint driver
>>> model.
>>
>> The mapping API is for mmio or DMA using endpoint controller memory
>> mapped to a host PCI address range. It is not for BARs. BARs setup
>> does not use the same API and has not changed with these patches.
>>
>> BARs can still be accessed on the endpoint (within the EPF driver)
>> with regular READ_ONCE()/WRITE_ONCE() once they are set. But any
>> data transfer between the PCI RC host and the EPF driver on the EP
>> host that use mmio or DMA generic channel (memory copy offload
>> channel) needs the new mapping API. DMA transfers that can be done
>> using dedicated DMA rx/tx channels associated with the endpoint
>> controller do not need to use this API as the mapping to the host
>> PCI address space is automatically handled by the DMA driver.
> 
> Sorry I'm dense.  I'm really not used to thinking in the endpoint
> point of view.  Correct me where I go off the rails:
> 
>   - This code (pci_epc_mem_map()) runs on an endpoint, basically as
>     part of some endpoint firmware, right?

Not sure what you mean by "firmware" here. pci_epc_mem_map() is intended for use
by a PCI endpoint function driver on the EP side, nothing else.

>   - On the endpoint's PCIe side, it receives memory read/write TLPs?

pci_epc_mem_map() does not receive anything itself. It only allocates local EP
controller memory from outbound ATU windows and map that to a PCI address region
of the host (RC side). Here "map" means programming the ATU using a correctly
aligned PCI address that satisfies the EP PCI controller alignment constraints.

The memory read/write TLPs will happen once the EP function driver access the
mapped memory with memcpy_fromio/toio() (or use generic memory copy offload DMA
channel).

>   - These TLPs would be generated elsewhere in the PCIe fabric, e.g.,
>     by a driver on the host doing MMIO to the endpoint, or possibly
>     another endpoint doing peer-to-peer DMA.

MMIO or DMA, yes.

> 
>   - Mem read/write TLPs are routed by address, and the endpoint
>     accepts them if the address matches one of its BARs.

Yes, but pci_epc_mem_map() is not for use for BARs on the EP side. BARs setup on
EP PCI controllers use inbound ATU windows. pci_epc_mem_map() programs outbound
ATU windows. BARs setup use pci_epf_alloc_space() + pci_epc_set_bar() to setup a
BAR.

> 
>   - This is a little different from a Root Complex, which would
>     basically treat reads/writes to anything outside the Root Port
>     windows as incoming DMA headed to physical memory.
> 
>   - A Root Complex would use the TLP address (the PCI bus address)
>     directly as a CPU physical memory address unless the TLP address
>     is translated by an IOMMU.
> 
>   - For the endpoint, you want the BAR to be an aperture to physical
>     memory in the address space of the SoC driving the endpoint.

Yes, and as said above this is done with pci_epf_alloc_space() +
pci_epc_set_bar(), not pci_epc_mem_map().

>   - The SoC physical memory address may be different from the PCI but
>     address in the TLP, and pci_epc_mem_map() is the way to account
>     for this?

pci_epc_mem_map() is essentially a call to pci_epc_mem_alloc_addr() +
pci_epc_map_addr(). pci_epc_mem_alloc_addr() allocates memory from the EP PCI
controller outbound windows and pci_epc_map_addr() programs an EP PCI controller
outbound ATU entry to map that memory to some PCI address region of the host (RC).

pci_epc_mem_map() was created because the current epc API does not hide any of
the EP PCI controller PCI address alignment constraints for programming outbound
ATU entries. This means that using directly pci_epc_mem_alloc_addr() +
pci_epc_map_addr(), things may or may not work (often the latter) depending on
the PCI address region (start address and its size) that is to be mapped and
accessed by the endpoint function driver.

Most EP PCI controllers at least require a PCI address to be aligned to some
fixed boundary (e.g. 64K for the RK3588 SoC on the Rock5B board). Even such
alignment boundary/mask is not exposed through the API (epc_features->align is
for BARs and should not be used for outbound ATU programming). Worse yet, some
EP PCI controllers use the lower bits of a local memory window address range as
the lower bits of the RC PCI address range when generating TLPs (e.g. RK3399 and
Cadence EP controller). For these EP PCI controllers, the programming of
outbound ATU entries for mapping a RC PCI address region thus endup depending on
the start PCI address of the region *and* the region size (as the size drives
the number of lower bits of address that will change over the entire region).

The above API issues where essentially unsolvable from a regular endpoint driver
correctly coded to be EP controller independent. I could not get my prototype
nvme endpoint function driver to work without introducing pci_epc_mem_map()
(nvme does not require any special alignment of command buffers, so on an nvme
EPF driver we end up having to deal with essentially random PCI addresses that
have no special alignment).

pci_epc_mem_map() relies on the new ->align_addr() EP controller operation to
get information about the start address and the size to use for mapping to local
memory a PCI address region. The size given is used for pci_epc_mem_alloc_addr()
and the start address and size given are used with pci_epc_map_addr(). This
generates a correct mapping regardless of the PCI address and size given.
And for the actual data access by the EP function driver, pci_epc_mem_map()
gives the address within the mapping that correspond to the PCI address that we
wanted mapped.

Et voila, problem solved :)

> 
>   - IOMMU translations from PCI to CPU physical address space are
>     pretty arbitrary and needn't be contiguous on the CPU side.
> 
>   - pci_epc_mem_map() sets up a conceptually similar PCI to CPU
>     address space translation, but it's much simpler because it
>     basically applies just a constant offset?


-- 
Damien Le Moal
Western Digital Research

