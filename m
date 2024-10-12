Return-Path: <linux-pci+bounces-14375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE1B99B299
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D1D283E7B
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434A14A639;
	Sat, 12 Oct 2024 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lbi69ocq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F013D516
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 09:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726013; cv=none; b=XoZNbWhQRgcR1djFYb1UcvZ9LkqYMXqjZPOqmsswzODOHdgo07ICAXuioQSqLLYkDxRewSxeh8fGchnr7mMM8/+QQRIKYrlbDTkg534IrBxNdrWNIEGUBNi77Pnfxnbz9hZAmlAHXgChFYBX+xfUEjfNzpNoj4lGMeMssrYD+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726013; c=relaxed/simple;
	bh=ExxT1eAA3/W6Y2mZ1x2DtTByKVOFeITfMjmJefrAtIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7xBo0RVCIwS0PaU+McQhN62L1kJQJvqb2kzquZ9UQQ1Q15vxtbzDluVrWge5DMHvBvYOcsCqIet7QcEkubO0pPnh7xQ1MjzQUSUPanbGS1GnnUGpp7zraLxuToj/2a3/HgMCbu3PZKnynrI1XGyc0/e+OBJPT/ZpOA4lvVcPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lbi69ocq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e3d45bbb5so903755b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 02:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728726011; x=1729330811; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b3DpRq9yfP/kk5PhTkvvpshs821BkSv3itjhkB8n50M=;
        b=Lbi69ocqqq+IaZuRv8r+NN0Tbdub2J97rfvZG1WqykKUnCJMotu84ZkMjn603oVyF1
         +YqCnD8JZ3LDt8CXkY2Z3rZHn4bqHwprbeYV93ejs3UqqCCOjVfjesYgUREnJClsMGnj
         xQd0oW2ibPTrf6kYgx39TMn8JcFbJxbQM2b3fg/Ej8kQOTOkFa7Yg9TeWoVElaH6YFh2
         15oGpewCBH27qUQaM7W6TAK3sEbbDKBySGdsqsJrDF4n+/OqP+Yf+Ee7APh9HuDt2ySl
         VMMWq0FE51wm8/KSFC3lXd8bkNqX7EZ48WARKHf0v5UPP56KOX9zbj5ZHuWjGwwXXw4T
         xpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726011; x=1729330811;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3DpRq9yfP/kk5PhTkvvpshs821BkSv3itjhkB8n50M=;
        b=Jht7JgRYEIVff1ZWoQj1w+JYyleBAkMYcifQfMJBIEx9nuG2zMVmMlWC0ttWbbtbgm
         QHsKR3jVS8q2w6/v+Zzjanvrf0ycMiVHWyLSs3vWhRj34HPcZU9jLH9rzdLxwi0tFnpJ
         S2rqstOT2n9MUK9dZX3bAqMnBGKtqyG6/viUtGk5XQDOanMJffWky/Ydb2czjEQppsnA
         vg8lN/ar+AqM7bUkLvZ8UbAHmUfCMMEv5JQAT5ymfrFPeAlG4T13oibx5+kLa4yJ5aTh
         UJnOWAZ6faBm2+ZSBcw1CRX9SIZWzXLvS/7MjB5gz280Cyva+Dt8GN/7v8kkteSrjrPD
         vLIw==
X-Forwarded-Encrypted: i=1; AJvYcCW4o3Vp0TwQjMoOUkNObFprFM8605gNhujGBee5EBjNoLPIrHIODESVGdlRRmqAEw/caNn+g2isjlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYslTIG5JFSPVoCzrCL66RfWN9WnW8jSqnI+LouBUlbEx3oxu
	hbpZdFqJ7dLJgQqFeBrQ5ihPo+XdTCPttrRNjzdkdbiq6XYzHh6CE9Or6icXAtIxDUrP6nV9cmc
	=
X-Google-Smtp-Source: AGHT+IFveZI18u9vycLvii2tQ2oZ5AlGljGxfgc1HocY4hcHr/J07zZm83F/PIlBk2vW4sOTn5NQEg==
X-Received: by 2002:a05:6a20:43ac:b0:1d2:e8f6:818 with SMTP id adf61e73a8af0-1d8bcf2ace7mr8292677637.17.1728726011487;
        Sat, 12 Oct 2024 02:40:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448f9b71sm3387833a12.36.2024.10.12.02.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:40:11 -0700 (PDT)
Date: Sat, 12 Oct 2024 15:10:06 +0530
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
Message-ID: <20241012094006.v5uod6765wpzyx7c@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-4-dlemoal@kernel.org>
 <20241010143627.5eo5n2rp75pgtgpt@thinkpad>
 <2b3c7dfb-94ba-404a-94c0-6fd37a0cb20c@kernel.org>
 <20241012063246.2ogwe26edelljpth@thinkpad>
 <fa8cde24-28a4-4e8c-ab4f-1c4a40382ea3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa8cde24-28a4-4e8c-ab4f-1c4a40382ea3@kernel.org>

On Sat, Oct 12, 2024 at 05:30:29PM +0900, Damien Le Moal wrote:
> On 10/12/24 15:32, Manivannan Sadhasivam wrote:
> > On Fri, Oct 11, 2024 at 10:07:30AM +0900, Damien Le Moal wrote:
> >> On 10/10/24 23:36, Manivannan Sadhasivam wrote:
> >>> On Mon, Oct 07, 2024 at 01:03:15PM +0900, Damien Le Moal wrote:
> >>>> Some endpoint controllers have requirements on the alignment of the
> >>>> controller physical memory address that must be used to map a RC PCI
> >>>> address region. For instance, the rockchip endpoint controller uses
> >>>> at most the lower 20 bits of a physical memory address region as the
> >>>> lower bits of an RC PCI address. For mapping a PCI address region of
> >>>> size bytes starting from pci_addr, the exact number of address bits
> >>>> used is the number of address bits changing in the address range
> >>>> [pci_addr..pci_addr + size - 1].
> >>>>
> >>>> For this example, this creates the following constraints:
> >>>> 1) The offset into the controller physical memory allocated for a
> >>>>    mapping depends on the mapping size *and* the starting PCI address
> >>>>    for the mapping.
> >>>> 2) A mapping size cannot exceed the controller windows size (1MB) minus
> >>>>    the offset needed into the allocated physical memory, which can end
> >>>>    up being a smaller size than the desired mapping size.
> >>>>
> >>>> Handling these constraints independently of the controller being used
> >>>> in an endpoint function driver is not possible with the current EPC
> >>>> API as only the ->align field in struct pci_epc_features is provided
> >>>> and used for BAR (inbound ATU mappings) mapping. A new API is needed
> >>>> for function drivers to discover mapping constraints and handle
> >>>> non-static requirements based on the RC PCI address range to access.
> >>>>
> >>>> Introduce the function pci_epc_map_align() and the endpoint controller
> >>>> operation ->map_align to allow endpoint function drivers to obtain the
> >>>> size and the offset into a controller address region that must be
> >>>> allocated and mapped to access an RC PCI address region. The size
> >>>> of the mapping provided by pci_epc_map_align() can then be used as the
> >>>> size argument for the function pci_epc_mem_alloc_addr().
> >>>> The offset into the allocated controller memory provided can be used to
> >>>> correctly handle data transfers.
> >>>>
> >>>> For endpoint controllers that have PCI address alignment constraints,
> >>>> pci_epc_map_align() may indicate upon return an effective PCI address
> >>>> region mapping size that is smaller (but not 0) than the requested PCI
> >>>> address region size. For such case, an endpoint function driver must
> >>>> handle data accesses over the desired PCI address range in fragments,
> >>>> by repeatedly using pci_epc_map_align() over the PCI address range.
> >>>>
> >>>> The controller operation ->map_align is optional: controllers that do
> >>>> not have any alignment constraints for mapping a RC PCI address region
> >>>> do not need to implement this operation. For such controllers,
> >>>> pci_epc_map_align() always returns the mapping size as equal to the
> >>>> requested size of the PCI region and an offset equal to 0.
> >>>>
> >>>> The new structure struct pci_epc_map is introduced to represent a
> >>>> mapping start PCI address, mapping effective size, the size and offset
> >>>> into the controller memory needed for mapping the PCI address region as
> >>>> well as the physical and virtual CPU addresses of the mapping (phys_base
> >>>> and virt_base fields). For convenience, the physical and virtual CPU
> >>>> addresses within that mapping to access the target RC PCI address region
> >>>> are also provided (phys_addr and virt_addr fields).
> >>>>
> >>>
> >>> I'm fine with the concept of this patch, but I don't get why you need an API for
> >>> this and not just a callback to be used in the pci_epc_mem_{map/unmap} APIs.
> >>> Furthermore, I don't see an user of this API (in 3 series you've sent out so
> >>> far). Let me know if I failed to spot it.
> >>>
> >>> Also, the API name pci_epc_map_align() sounds like it does the mapping, but it
> >>> doesn't. So I'd not have it exposed as an API at all.
> >>
> >> OK. Fine with me. I will move this inside pci_epc_mem_map(). But note that
> >> without this function, pci_epc_mem_alloc_addr() and pci_epc_map_addr() are
> >> totally useless for EP controllers that have a mapping alignment requirement,
> >> which without the pci_epc_map_align() function, an endpoint function driver
> >> cannot discover *at all* currently. That does not fix the overall API of EPC...
> >>
> > 
> > Not at all. EPF drivers still can use "epf_mhi->epc_features->align" to discover
> > the alignment requirement and calculate the offset on their own (please see
> > pci-epf-mhi). But I'm not in favor of that approach since the APIs need to do
> > that job and that's why I like your pci_epc_mem_map() API.
> 
> That is *not* correct, at least in general. For two reasons:
> 1) epc_features->align defines alignment for BARs, that is, inbound windows
> memory. It is not supposed to be about the outbound windows for mapping PCI
> address space for doing mmio or DMA. Some controllers may have the same
> alignment constraint for both ib and ob, in which case things will work, but
> that is "just being lucky". I spent weeks with the RK3399 understanding that I
> was not lucky with that one :)
> 2) A static alignment constraint does not work for all controllers. C.f. my
> series fixing the RK3399 were I think I clearly explain that alignment of a
> mapping depends on the PCI address AND the size being mapped, as both determine
> the number of bits of address changing within the PCI address range to access.
> Using a fixed boundary alignment for the RK3399 simply does not work at all. An
> epf cannot know that simply looking at a fixed value...
> 
> What you said may be true for the mhi epf, because it requires special hardware
> that has a simple fixed alignment constraint. ntb and vntb are also coded
> assuming such constraint. So If I try to run ntb or vntg on the RK3399 it will
> likely not work (actually it may, but out of sheer luck given that the addresses
> that will be mapped will likely be aligned to 1MB, that is, the memory window size).
> 
> Developping the nvme epf driver where I was seeing completely random PCI
> addresses for command buffers, I could make things work only after developping
> the pci_epc_mem_map() with the controller operation telling the mapping
> (.get_mem_map()) for every address to map.
> 

Fair enough...

> > 
> >> By not having pci_epc_map_align(), pci_epc_mem_alloc_addr() and
> >> pci_epc_map_addr() remain broken, but the introduction of pci_epc_mem_map() does
> >> provide a working solution for the general case.
> >>
> >> So I think we will still need to do something about this bad state of the API later.
> >>
> > 
> > We can always rework the APIs to incorporate the alignment requirement.
> 
> See above. An API that advertise a simple alignment requirement will not work
> for all controllers... But anyway, given that we are not getting any problem
> report, people using the EP framework likely have setups that combine
> controllers and endpoint drivers playing well together. So I do not think there
> is any urgency about the API. I really do need this series for the nvme endpoint
> driver though, as a first step for the API improvement.
> 

No, what I meant was that you can use the new alignment callback (that takes
care of the complex alignment restrictions) in the existing map API to properly
map the addresses for all controllers in the future.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

