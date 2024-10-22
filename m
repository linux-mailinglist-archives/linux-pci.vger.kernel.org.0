Return-Path: <linux-pci+bounces-15077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B5D9ABA34
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 01:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D431C22898
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 23:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9DB126C05;
	Tue, 22 Oct 2024 23:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFjtbd69"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052631CEAAB
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640969; cv=none; b=LGTD0bwd3dewmqMbQyc4gtrtOkzb0Slc8yMQD8D3CEE1Ar0tQ+ct9tQO9HJcaXj8xuAHM6xvggtB69t6aZ+xc44gda48enBDlYI0ZUblWLep12QbqxEvFllRptRiwisDADaBtDuPPnapxznZfhMjchLM/Pkv9Yubr61kz5qdDdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640969; c=relaxed/simple;
	bh=oWTR2IWF/62uegjUVt0JUaODHvF0FajkPcEnFXJk8UA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dCOQguiKqWCbjNai+Ol2Zruw9DZMf963Q8hlHkr5i8f/7aTuLguaqIRjy47LOGdCwN3qusjnbo9l3R+BX0bXKDjH6SIHmnt0oPZHsVjhma9HWQisl4LHz0/bV36JtQjkNEv+Q6kNRNTC6n6Ne27WQ/BaW6s64HWAGjf0EO4Ylo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFjtbd69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C71DC4CEC3;
	Tue, 22 Oct 2024 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729640968;
	bh=oWTR2IWF/62uegjUVt0JUaODHvF0FajkPcEnFXJk8UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lFjtbd69LH7LRalepAAkziim3PZUNlvaI4zVDYtJ524xIVcOlQqrhzAj8Cj+WUXlY
	 NaED/jeK+LCGB6xvYLkWTEl42hz3jmw5Ior6KhyxC49ZiAYYG1rynPLjpCdifZcTSU
	 CeptblevzlybwbfYAUTh+oMIBOZpSI3hVk6hNR3faEPgpPvZSvu3prsXiRgbMcT+Jy
	 +YDvpD06UXns7+8TfW07osPTMTJ90VbQ4ZQO/PKuV8JNLhj9b8ruYXFt70hZCOnEW7
	 Kq0zJR/VpTJRA1KpoTBw+8VJT6jRM+vMW6p0MnAuev8pH9Rrhti7erk3BnkiYIHFc1
	 sSOjLx6LuHBKg==
Date: Tue, 22 Oct 2024 18:49:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 0/6] Improve PCI memory mapping API
Message-ID: <20241022234926.GA893145@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2632a47f-c627-4a9b-98a9-d5dc6fd25ef8@kernel.org>

On Wed, Oct 23, 2024 at 07:05:54AM +0900, Damien Le Moal wrote:
> On 10/23/24 05:47, Bjorn Helgaas wrote:
> > On Tue, Oct 22, 2024 at 10:51:53AM +0900, Damien Le Moal wrote:
> >> On 10/22/24 07:19, Bjorn Helgaas wrote:
> >>> On Sat, Oct 12, 2024 at 08:32:40PM +0900, Damien Le Moal wrote:
> >>>> This series introduces the new functions pci_epc_mem_map() and
> >>>> pci_epc_mem_unmap() to improve handling of the PCI address mapping
> >>>> alignment constraints of endpoint controllers in a controller
> >>>> independent manner.
> >>>
> >>> Hi Damien, I know this is obvious to everybody except me, but who
> >>> uses this mapping?  A driver running on the endpoint that does
> >>> MMIO?  DMA (Memory Reads or Writes that target an endpoint BAR)?
> >>> I'm still trying to wrap my head around the whole endpoint driver
> >>> model.
> >>
> >> The mapping API is for mmio or DMA using endpoint controller memory
> >> mapped to a host PCI address range. It is not for BARs. BARs setup
> >> does not use the same API and has not changed with these patches.
> >>
> >> BARs can still be accessed on the endpoint (within the EPF driver)
> >> with regular READ_ONCE()/WRITE_ONCE() once they are set. But any
> >> data transfer between the PCI RC host and the EPF driver on the EP
> >> host that use mmio or DMA generic channel (memory copy offload
> >> channel) needs the new mapping API. DMA transfers that can be done
> >> using dedicated DMA rx/tx channels associated with the endpoint
> >> controller do not need to use this API as the mapping to the host
> >> PCI address space is automatically handled by the DMA driver.
> > 
> > Sorry I'm dense.  I'm really not used to thinking in the endpoint
> > point of view.  Correct me where I go off the rails:
> > 
> >   - This code (pci_epc_mem_map()) runs on an endpoint, basically as
> >     part of some endpoint firmware, right?
> 
> Not sure what you mean by "firmware" here. pci_epc_mem_map() is
> intended for use by a PCI endpoint function driver on the EP side,
> nothing else.

I mean the software operating the endpoint from the "inside", not from
the PCIe side.

In a non-endpoint framework scenario, the kernel running on the host
enumerates PCI devices using config reads, and a driver like nvme runs
on the host and operates an NVMe device with config accesses and MMIO
to the NVMe BARs.

I referred to "firmware" because if the endpoint were on a PCIe
plug-in card, an SoC on the card could run firmware that uses the
endpoint framework to respond to PCIe activity generated by the host.
(Of course, if the host driver programs the endpoint appropriately,
the endpoint might also initiate its own PCIe activity for DMA.)

> >   - On the endpoint's PCIe side, it receives memory read/write TLPs?
> 
> pci_epc_mem_map() does not receive anything itself. It only
> allocates local EP controller memory from outbound ATU windows and
> map that to a PCI address region of the host (RC side). Here "map"
> means programming the ATU using a correctly aligned PCI address that
> satisfies the EP PCI controller alignment constraints.

I assumed we were talking about an endpoint responding to PCIe traffic
generated elsewhere, but I think my assumption was wrong.

I don't have any specs for these endpoint controllers, and there's
nothing in Documentation/PCI/endpoint/ about ATUs.  Some doc and a few
pictures would go a long ways.

> The memory read/write TLPs will happen once the EP function driver
> access the mapped memory with memcpy_fromio/toio() (or use generic
> memory copy offload DMA channel).

This would be the endpoint itself *initiating* DMA TLPs on PCIe, not
responding to incoming DMA, I guess.

> >   - These TLPs would be generated elsewhere in the PCIe fabric, e.g.,
> >     by a driver on the host doing MMIO to the endpoint, or possibly
> >     another endpoint doing peer-to-peer DMA.
> 
> MMIO or DMA, yes.
> 
> >   - Mem read/write TLPs are routed by address, and the endpoint
> >     accepts them if the address matches one of its BARs.
> 
> Yes, but pci_epc_mem_map() is not for use for BARs on the EP side.
> BARs setup on EP PCI controllers use inbound ATU windows.
> pci_epc_mem_map() programs outbound ATU windows. BARs setup use
> pci_epf_alloc_space() + pci_epc_set_bar() to setup a BAR.
>
> >   - This is a little different from a Root Complex, which would
> >     basically treat reads/writes to anything outside the Root Port
> >     windows as incoming DMA headed to physical memory.
> > 
> >   - A Root Complex would use the TLP address (the PCI bus address)
> >     directly as a CPU physical memory address unless the TLP address
> >     is translated by an IOMMU.
> > 
> >   - For the endpoint, you want the BAR to be an aperture to physical
> >     memory in the address space of the SoC driving the endpoint.
> 
> Yes, and as said above this is done with pci_epf_alloc_space() +
> pci_epc_set_bar(), not pci_epc_mem_map().

And if the endpoint is *initiating* DMA, BARs of that endpoint are not
involved at all.  The target of the DMA would be either host memory or
a BAR of another endpoint.

> >   - The SoC physical memory address may be different from the PCI but
> >     address in the TLP, and pci_epc_mem_map() is the way to account
> >     for this?
> 
> pci_epc_mem_map() is essentially a call to pci_epc_mem_alloc_addr()
> + pci_epc_map_addr(). pci_epc_mem_alloc_addr() allocates memory from
> the EP PCI controller outbound windows and pci_epc_map_addr()
> programs an EP PCI controller outbound ATU entry to map that memory
> to some PCI address region of the host (RC).

I see "RC" and "RC address" used often in this area, but I don't quite
understand the RC connection.  It sounds like this might be the PCI
memory address space, i.e., the set of addresses that might appear in
PCIe TLPs?

Does "EPC addr space" refer to the physical address space of the
processor operating the endpoint, or does it mean something more
specific?

> pci_epc_mem_map() was created because the current epc API does not
> hide any of the EP PCI controller PCI address alignment constraints
> for programming outbound ATU entries. This means that using directly
> pci_epc_mem_alloc_addr() + pci_epc_map_addr(), things may or may not
> work (often the latter) depending on the PCI address region (start
> address and its size) that is to be mapped and accessed by the
> endpoint function driver.
> 
> Most EP PCI controllers at least require a PCI address to be aligned
> to some fixed boundary (e.g. 64K for the RK3588 SoC on the Rock5B
> board). Even such alignment boundary/mask is not exposed through the
> API (epc_features->align is for BARs and should not be used for
> outbound ATU programming). Worse yet, some EP PCI controllers use
> the lower bits of a local memory window address range as the lower
> bits of the RC PCI address range when generating TLPs (e.g. RK3399
> and Cadence EP controller). For these EP PCI controllers, the
> programming of outbound ATU entries for mapping a RC PCI address
> region thus endup depending on the start PCI address of the region
> *and* the region size (as the size drives the number of lower bits
> of address that will change over the entire region).
> 
> The above API issues where essentially unsolvable from a regular
> endpoint driver correctly coded to be EP controller independent. I
> could not get my prototype nvme endpoint function driver to work
> without introducing pci_epc_mem_map() (nvme does not require any
> special alignment of command buffers, so on an nvme EPF driver we
> end up having to deal with essentially random PCI addresses that
> have no special alignment).
> 
> pci_epc_mem_map() relies on the new ->align_addr() EP controller
> operation to get information about the start address and the size to
> use for mapping to local memory a PCI address region. The size given
> is used for pci_epc_mem_alloc_addr() and the start address and size
> given are used with pci_epc_map_addr(). This generates a correct
> mapping regardless of the PCI address and size given.  And for the
> actual data access by the EP function driver, pci_epc_mem_map()
> gives the address within the mapping that correspond to the PCI
> address that we wanted mapped.

> >   - IOMMU translations from PCI to CPU physical address space are
> >     pretty arbitrary and needn't be contiguous on the CPU side.
> > 
> >   - pci_epc_mem_map() sets up a conceptually similar PCI to CPU
> >     address space translation, but it's much simpler because it
> >     basically applies just a constant offset?

