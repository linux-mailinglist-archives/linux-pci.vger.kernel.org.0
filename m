Return-Path: <linux-pci+bounces-14394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543399B4AC
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73558B20B5D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E34A13B58E;
	Sat, 12 Oct 2024 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8wpkVDe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5146014A4DC
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728734381; cv=none; b=c4LnTvzy/kRLuWMhK4jcD/PvY4eq3A1xZ8nBYyX5LRCGS63ywyn5xcVbw88j27xYHojpyU8oP6lnGEoWbkd//hstvzYvA21pHpbO/ySmwj2/ZBa1V4/xhjWKBb9yJr385ziHf8coKobiRpjrcS8JNeNQ1VF+3si9gR+tcyqPQ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728734381; c=relaxed/simple;
	bh=CSoUcYnZZv8TnyeqX0aTe4VRCa4rDvMA/1N34JsIM+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcemM482tJ7PoUzqInbkeOjRz6b1vSDgBW+g9MdAxnPX4WJ12JLg34IczCR+3WyUHmPA+2QoMv1WU00gN6pjDqnjaim9HyQbcYnpEzxRupjDoo3j6NunS6zhcGiNk6wSnQavEGNs7jjtfjNLwr6Wz0zn/eBfPydxwuin1Hl0qbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8wpkVDe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e30e56ce5so1598235b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728734378; x=1729339178; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftbgbyDaNpaY+WdDLh4V3PJKrueOa+r8NnNreDrMlxs=;
        b=Y8wpkVDexC2oGEidF+rHeuvEkU04ikgbBLW706RBoAoRIa7nScSJzKqcCYotC9caEf
         1hicVVqAgFmIeJjgsi8gxG+CBhdWJ9FoHEXLuwFjwEdMt2J9OBcJoeSqQbEa73sNcXJE
         pyLTwhHBOb16Ny+Xz6sxSgWKjR4TJXq83OQ78qutcLtduyNPqS7CYY3kyOP3Ma/cOgau
         O1iZ4U+zbPQTM4aynWtMu2/rf8ERgVjmRgZBTblg23ngfCBB1UircAehtd0bpoOpGycG
         4ve7mOflcffOv1hQZ9NMvh8f6Aakeo9G3ITHCe+Km2lnWn8kGzavqBto7RdKlHEGe1Gs
         KDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728734378; x=1729339178;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftbgbyDaNpaY+WdDLh4V3PJKrueOa+r8NnNreDrMlxs=;
        b=auiN1ei7uJDfPWF3xpRtkNqPmCsunbo+WHrkN49N9XG9uKVWNzeVwBXAqcU3gqYuqn
         N9h7Y4+E5YQOMuq5OBRf3svJ/J3jgrFrp3YGPqf0WbISs7Xb9l1S5dD9x4jKhyiphjyn
         E3/X/a1laOzMEH5saWD3RJGJvJKETP6qHd7qn0vOz3qnNvybtoI712GVTR15DdbKccQ3
         3m/TZhZhkuwssOcjNWjMlUsJ83XaZ5imS7ZvkQmi9+tq18bPODJ4LNDdytwfe55a2GN1
         eLzVam3oXgHKiIo0Vbsux6uTe9NxW5MWY8Z2y6r1GTDFS8sNXUvCImIL9CNT4dV8SZDr
         8EGw==
X-Forwarded-Encrypted: i=1; AJvYcCW9FYMytLwAflqtlVL8L8nfM9OmimaCoxQjXPmDM7PXk5G3Ye9939Dq37FvwZIGzNCCU8X3gS87ZR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jYJ6fPTpJy6wM6OpjrT8lF+yOL+y07Ka9cU65PYc1fsLNwvv
	ClFAGEAYnxG9ISDmGLAetZPGxcHUqQ5NetVyt43YlyjOLSXKY25EDIjc+f4xVg==
X-Google-Smtp-Source: AGHT+IGMsd+YT7wh40D/YAnk05xRGbqSBHNeypCXAaNAijzC2mNQLv/OjwJrB3bGVQEfrBGqF7LLXg==
X-Received: by 2002:a05:6a00:10c7:b0:71d:f012:6ddc with SMTP id d2e1a72fcca58-71e4c185c15mr4066975b3a.16.1728734378407;
        Sat, 12 Oct 2024 04:59:38 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e4ad1b97bsm1385482b3a.217.2024.10.12.04.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:59:37 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:29:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 3/7] PCI: endpoint: Introduce pci_epc_map_align()
Message-ID: <20241012115933.c3ivxnrizmxqvhtc@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-4-dlemoal@kernel.org>
 <20241010143627.5eo5n2rp75pgtgpt@thinkpad>
 <2b3c7dfb-94ba-404a-94c0-6fd37a0cb20c@kernel.org>
 <20241012063246.2ogwe26edelljpth@thinkpad>
 <fa8cde24-28a4-4e8c-ab4f-1c4a40382ea3@kernel.org>
 <20241012094006.v5uod6765wpzyx7c@thinkpad>
 <f3cc4eb4-87b3-4e35-861c-291d7122bc87@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f3cc4eb4-87b3-4e35-861c-291d7122bc87@kernel.org>

On Sat, Oct 12, 2024 at 08:06:46PM +0900, Damien Le Moal wrote:
> On 10/12/24 18:40, Manivannan Sadhasivam wrote:
> > On Sat, Oct 12, 2024 at 05:30:29PM +0900, Damien Le Moal wrote:
> >> On 10/12/24 15:32, Manivannan Sadhasivam wrote:
> >>> On Fri, Oct 11, 2024 at 10:07:30AM +0900, Damien Le Moal wrote:
> >>>> On 10/10/24 23:36, Manivannan Sadhasivam wrote:
> >>>>> On Mon, Oct 07, 2024 at 01:03:15PM +0900, Damien Le Moal wrote:
> >>>>>> Some endpoint controllers have requirements on the alignment of the
> >>>>>> controller physical memory address that must be used to map a RC PCI
> >>>>>> address region. For instance, the rockchip endpoint controller uses
> >>>>>> at most the lower 20 bits of a physical memory address region as the
> >>>>>> lower bits of an RC PCI address. For mapping a PCI address region of
> >>>>>> size bytes starting from pci_addr, the exact number of address bits
> >>>>>> used is the number of address bits changing in the address range
> >>>>>> [pci_addr..pci_addr + size - 1].
> >>>>>>
> >>>>>> For this example, this creates the following constraints:
> >>>>>> 1) The offset into the controller physical memory allocated for a
> >>>>>>    mapping depends on the mapping size *and* the starting PCI address
> >>>>>>    for the mapping.
> >>>>>> 2) A mapping size cannot exceed the controller windows size (1MB) minus
> >>>>>>    the offset needed into the allocated physical memory, which can end
> >>>>>>    up being a smaller size than the desired mapping size.
> >>>>>>
> >>>>>> Handling these constraints independently of the controller being used
> >>>>>> in an endpoint function driver is not possible with the current EPC
> >>>>>> API as only the ->align field in struct pci_epc_features is provided
> >>>>>> and used for BAR (inbound ATU mappings) mapping. A new API is needed
> >>>>>> for function drivers to discover mapping constraints and handle
> >>>>>> non-static requirements based on the RC PCI address range to access.
> >>>>>>
> >>>>>> Introduce the function pci_epc_map_align() and the endpoint controller
> >>>>>> operation ->map_align to allow endpoint function drivers to obtain the
> >>>>>> size and the offset into a controller address region that must be
> >>>>>> allocated and mapped to access an RC PCI address region. The size
> >>>>>> of the mapping provided by pci_epc_map_align() can then be used as the
> >>>>>> size argument for the function pci_epc_mem_alloc_addr().
> >>>>>> The offset into the allocated controller memory provided can be used to
> >>>>>> correctly handle data transfers.
> >>>>>>
> >>>>>> For endpoint controllers that have PCI address alignment constraints,
> >>>>>> pci_epc_map_align() may indicate upon return an effective PCI address
> >>>>>> region mapping size that is smaller (but not 0) than the requested PCI
> >>>>>> address region size. For such case, an endpoint function driver must
> >>>>>> handle data accesses over the desired PCI address range in fragments,
> >>>>>> by repeatedly using pci_epc_map_align() over the PCI address range.
> >>>>>>
> >>>>>> The controller operation ->map_align is optional: controllers that do
> >>>>>> not have any alignment constraints for mapping a RC PCI address region
> >>>>>> do not need to implement this operation. For such controllers,
> >>>>>> pci_epc_map_align() always returns the mapping size as equal to the
> >>>>>> requested size of the PCI region and an offset equal to 0.
> >>>>>>
> >>>>>> The new structure struct pci_epc_map is introduced to represent a
> >>>>>> mapping start PCI address, mapping effective size, the size and offset
> >>>>>> into the controller memory needed for mapping the PCI address region as
> >>>>>> well as the physical and virtual CPU addresses of the mapping (phys_base
> >>>>>> and virt_base fields). For convenience, the physical and virtual CPU
> >>>>>> addresses within that mapping to access the target RC PCI address region
> >>>>>> are also provided (phys_addr and virt_addr fields).
> >>>>>>
> >>>>>
> >>>>> I'm fine with the concept of this patch, but I don't get why you need an API for
> >>>>> this and not just a callback to be used in the pci_epc_mem_{map/unmap} APIs.
> >>>>> Furthermore, I don't see an user of this API (in 3 series you've sent out so
> >>>>> far). Let me know if I failed to spot it.
> >>>>>
> >>>>> Also, the API name pci_epc_map_align() sounds like it does the mapping, but it
> >>>>> doesn't. So I'd not have it exposed as an API at all.
> >>>>
> >>>> OK. Fine with me. I will move this inside pci_epc_mem_map(). But note that
> >>>> without this function, pci_epc_mem_alloc_addr() and pci_epc_map_addr() are
> >>>> totally useless for EP controllers that have a mapping alignment requirement,
> >>>> which without the pci_epc_map_align() function, an endpoint function driver
> >>>> cannot discover *at all* currently. That does not fix the overall API of EPC...
> >>>>
> >>>
> >>> Not at all. EPF drivers still can use "epf_mhi->epc_features->align" to discover
> >>> the alignment requirement and calculate the offset on their own (please see
> >>> pci-epf-mhi). But I'm not in favor of that approach since the APIs need to do
> >>> that job and that's why I like your pci_epc_mem_map() API.
> >>
> >> That is *not* correct, at least in general. For two reasons:
> >> 1) epc_features->align defines alignment for BARs, that is, inbound windows
> >> memory. It is not supposed to be about the outbound windows for mapping PCI
> >> address space for doing mmio or DMA. Some controllers may have the same
> >> alignment constraint for both ib and ob, in which case things will work, but
> >> that is "just being lucky". I spent weeks with the RK3399 understanding that I
> >> was not lucky with that one :)
> >> 2) A static alignment constraint does not work for all controllers. C.f. my
> >> series fixing the RK3399 were I think I clearly explain that alignment of a
> >> mapping depends on the PCI address AND the size being mapped, as both determine
> >> the number of bits of address changing within the PCI address range to access.
> >> Using a fixed boundary alignment for the RK3399 simply does not work at all. An
> >> epf cannot know that simply looking at a fixed value...
> >>
> >> What you said may be true for the mhi epf, because it requires special hardware
> >> that has a simple fixed alignment constraint. ntb and vntb are also coded
> >> assuming such constraint. So If I try to run ntb or vntg on the RK3399 it will
> >> likely not work (actually it may, but out of sheer luck given that the addresses
> >> that will be mapped will likely be aligned to 1MB, that is, the memory window size).
> >>
> >> Developping the nvme epf driver where I was seeing completely random PCI
> >> addresses for command buffers, I could make things work only after developping
> >> the pci_epc_mem_map() with the controller operation telling the mapping
> >> (.get_mem_map()) for every address to map.
> >>
> > 
> > Fair enough...
> > 
> >>>
> >>>> By not having pci_epc_map_align(), pci_epc_mem_alloc_addr() and
> >>>> pci_epc_map_addr() remain broken, but the introduction of pci_epc_mem_map() does
> >>>> provide a working solution for the general case.
> >>>>
> >>>> So I think we will still need to do something about this bad state of the API later.
> >>>>
> >>>
> >>> We can always rework the APIs to incorporate the alignment requirement.
> >>
> >> See above. An API that advertise a simple alignment requirement will not work
> >> for all controllers... But anyway, given that we are not getting any problem
> >> report, people using the EP framework likely have setups that combine
> >> controllers and endpoint drivers playing well together. So I do not think there
> >> is any urgency about the API. I really do need this series for the nvme endpoint
> >> driver though, as a first step for the API improvement.
> >>
> > 
> > No, what I meant was that you can use the new alignment callback (that takes
> > care of the complex alignment restrictions) in the existing map API to properly
> > map the addresses for all controllers in the future.
> 
> The existing map API cannot alone use ->align_addr() to get the correct mapping.
> It is because the memory needed to handle a mapping may be larger than the PCI
> address range to map. In fact, it almost always is larger for any controller
> that has a constraint. As a result, the memory allocation side
> (pci_epc_alloc_addr()) must also be aware of the mapping constraint and
> resulting size of the memory to allocate... Hence pci_epc_mem_map() using both
> functions.
> 

Ah, I missed that. Thanks for clarifying!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

