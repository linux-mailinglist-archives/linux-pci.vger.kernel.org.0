Return-Path: <linux-pci+bounces-14248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBABD9998AB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 03:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15702B21218
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 01:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB83F10F9;
	Fri, 11 Oct 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3cuehmI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F197464
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 01:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728608853; cv=none; b=AyxmM/TuHugm+ML9xCDkFve0xvpAK1lGd9vb15MEGjPaYyqC+C+vPcRT9BVs3OrPr/lPL0HNzGjpf1eDd8bm95/pTdzhwWOjQXvl47/qna26zr/e6KLwzMXw+WyercUYs6KF4cmLGM+0WiTYk0ntJQvxRySHtj1ic++bsVas1mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728608853; c=relaxed/simple;
	bh=xo1+B3id4K2YxIyOveAbxs0I3jo8faN5oNCtT//PDW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESIlxz4ATlqZX5AqGNn+BfAg7oX586W3cpq2W+tHFqurUQfbiamNIW7aSF6MkbDzsWVPofEFxCNe4xhAtDITDM4Q7rjn1PAkt0QjUujUXWDZ1Pshe0Sj0vjgIZsiO/4foCg044LEABDW8gMJuIpj/Msq3LI75E0KPi9F4Usq17c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3cuehmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F0CC4CEC5;
	Fri, 11 Oct 2024 01:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728608853;
	bh=xo1+B3id4K2YxIyOveAbxs0I3jo8faN5oNCtT//PDW8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r3cuehmI+I8Gf1kpf5zmDKtfVNujMZUJROKXhzS0OqVLM00JsA72eJwyai6WAk5GA
	 xhDsi3oMhyevXNcIR+FaqEVAvMsDPnUevy0mae6XF1Wm0h+u/0w62iu5+uxGlCvllW
	 XRhYVTmPOw/3Zlvgqtp7PsPa68ZFTafH8H8lEytTs2217C1hh4YJyQLe4Ao3EdAeAv
	 nOZzkc9BaSO27cFaSNclxhJuWOvCkVPO8gSWWDfGc58l3Nd2WEfTXCdmaernIt4O+D
	 A8EceadlK54eMpLI4P8lT4rKmde9z3lPYVQZSuVIVrPJtT2gS94FQgIBW4ZjljBp8b
	 76O68XRcqs1hw==
Message-ID: <2b3c7dfb-94ba-404a-94c0-6fd37a0cb20c@kernel.org>
Date: Fri, 11 Oct 2024 10:07:30 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] PCI: endpoint: Introduce pci_epc_map_align()
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-4-dlemoal@kernel.org>
 <20241010143627.5eo5n2rp75pgtgpt@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010143627.5eo5n2rp75pgtgpt@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 23:36, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:03:15PM +0900, Damien Le Moal wrote:
>> Some endpoint controllers have requirements on the alignment of the
>> controller physical memory address that must be used to map a RC PCI
>> address region. For instance, the rockchip endpoint controller uses
>> at most the lower 20 bits of a physical memory address region as the
>> lower bits of an RC PCI address. For mapping a PCI address region of
>> size bytes starting from pci_addr, the exact number of address bits
>> used is the number of address bits changing in the address range
>> [pci_addr..pci_addr + size - 1].
>>
>> For this example, this creates the following constraints:
>> 1) The offset into the controller physical memory allocated for a
>>    mapping depends on the mapping size *and* the starting PCI address
>>    for the mapping.
>> 2) A mapping size cannot exceed the controller windows size (1MB) minus
>>    the offset needed into the allocated physical memory, which can end
>>    up being a smaller size than the desired mapping size.
>>
>> Handling these constraints independently of the controller being used
>> in an endpoint function driver is not possible with the current EPC
>> API as only the ->align field in struct pci_epc_features is provided
>> and used for BAR (inbound ATU mappings) mapping. A new API is needed
>> for function drivers to discover mapping constraints and handle
>> non-static requirements based on the RC PCI address range to access.
>>
>> Introduce the function pci_epc_map_align() and the endpoint controller
>> operation ->map_align to allow endpoint function drivers to obtain the
>> size and the offset into a controller address region that must be
>> allocated and mapped to access an RC PCI address region. The size
>> of the mapping provided by pci_epc_map_align() can then be used as the
>> size argument for the function pci_epc_mem_alloc_addr().
>> The offset into the allocated controller memory provided can be used to
>> correctly handle data transfers.
>>
>> For endpoint controllers that have PCI address alignment constraints,
>> pci_epc_map_align() may indicate upon return an effective PCI address
>> region mapping size that is smaller (but not 0) than the requested PCI
>> address region size. For such case, an endpoint function driver must
>> handle data accesses over the desired PCI address range in fragments,
>> by repeatedly using pci_epc_map_align() over the PCI address range.
>>
>> The controller operation ->map_align is optional: controllers that do
>> not have any alignment constraints for mapping a RC PCI address region
>> do not need to implement this operation. For such controllers,
>> pci_epc_map_align() always returns the mapping size as equal to the
>> requested size of the PCI region and an offset equal to 0.
>>
>> The new structure struct pci_epc_map is introduced to represent a
>> mapping start PCI address, mapping effective size, the size and offset
>> into the controller memory needed for mapping the PCI address region as
>> well as the physical and virtual CPU addresses of the mapping (phys_base
>> and virt_base fields). For convenience, the physical and virtual CPU
>> addresses within that mapping to access the target RC PCI address region
>> are also provided (phys_addr and virt_addr fields).
>>
> 
> I'm fine with the concept of this patch, but I don't get why you need an API for
> this and not just a callback to be used in the pci_epc_mem_{map/unmap} APIs.
> Furthermore, I don't see an user of this API (in 3 series you've sent out so
> far). Let me know if I failed to spot it.
> 
> Also, the API name pci_epc_map_align() sounds like it does the mapping, but it
> doesn't. So I'd not have it exposed as an API at all.

OK. Fine with me. I will move this inside pci_epc_mem_map(). But note that
without this function, pci_epc_mem_alloc_addr() and pci_epc_map_addr() are
totally useless for EP controllers that have a mapping alignment requirement,
which without the pci_epc_map_align() function, an endpoint function driver
cannot discover *at all* currently. That does not fix the overall API of EPC...

By not having pci_epc_map_align(), pci_epc_mem_alloc_addr() and
pci_epc_map_addr() remain broken, but the introduction of pci_epc_mem_map() does
provide a working solution for the general case.

So I think we will still need to do something about this bad state of the API later.


-- 
Damien Le Moal
Western Digital Research

