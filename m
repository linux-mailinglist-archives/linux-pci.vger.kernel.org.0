Return-Path: <linux-pci+bounces-14364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F03999B149
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 08:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE92B220FD
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C2C84D0F;
	Sat, 12 Oct 2024 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USn35wAS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395AD4C83
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728714773; cv=none; b=nub4pzLIo7ydU1mVhgU/TEU+j4ntjerR3jDwJGmwbe1Olc4p6Z93KTKsg6RKA2mqvdY0aELbTtzBKVb7kTOPDN4lAO0bHcfiLD9/u4me73ju3Ks0Qqn0k37UqoE5Hb1hirNsjVNSrKiV/3cJ49OW+hYs4UG3v1b6e+b4CA6jGfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728714773; c=relaxed/simple;
	bh=IReiaRetzuCqrbZQkaZag1euHtuqT/6FV8X9zJSFf74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evIJDhU8YjwTDuXMOPot157UstqVK2B7VBnTiXixy9ThPUHgwtPltvNrLQJQN2UwM4d72JxNyc3baHUQZYxrO5khGFQaJyrUJsPmf2qD/F1bS389Izq4SIZzhuj8BhZCkk7olbpe+G5WQ7GZRiRD16xvIUeHH6+xrpnx+9S9K0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USn35wAS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71df1fe11c1so2274801b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728714771; x=1729319571; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kp5rxDM8t2ZYzteSHeInYo7x4xHcgKXhq7ybTtqMkoU=;
        b=USn35wASsXd+H9Gb7C93kRo2XIVIAj0QWFPMrM/kW8P6OnoejCoZmRrLWikUSf7PNH
         I7/NrKSeoQ8af0a5NCqpJpoKHXAzmArizB6PxhTh5aMzI264vfQHPU9I4GK0GicBbF14
         ghVTjJZVJgoSL6Ou6VaUUcmGjdxOMJFdxpR9jNfTnm8A7EiUo6wRmScQy4GlGU5/0TFp
         qjWnalrn7WfQOZk+ARqe8sfE1juWw5Dj3O9DfNqFuH21JCQScviXzSNAjq0LCtmAWXzL
         o9SLIqpeC2HnpYrBgt+IgtjmJJ9mxF/SW82pY6dwQbfO9sXLAknpJRy0lGFdKFCdIol1
         mUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728714771; x=1729319571;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp5rxDM8t2ZYzteSHeInYo7x4xHcgKXhq7ybTtqMkoU=;
        b=cxi4CkS8y59d5jPEjSvDzdng11yihgk6xHrA5tvkf1djBzY1ZeDbNNix50JA8H3m0s
         7BnMGv2MVMfeB0oY3YI1j1DZC+GEHCNsfCgRtZtNmXoW37ngzPYHIlJG7kGZqisFWrR/
         FLbcnqtkPvim7IaQEBJuBeFddYo9hdxvdk2LxlCvXqhBbkhG9U5RlF8pAgpEqM9378Cj
         LSUnr4cq24G53Wa68Mg4JEcKxXSU6FjwazArIXpi1TKJTV2dAr+Rb62H/D0oVkif53hN
         l9LwUyZ+2ZRoZLpy31+Yi4zHjZvqTasn1tD/EDqtXeSClgJcgzDI1bTLZ9myNtXJ/Qx9
         3V+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFdpBZsxl1J8nvGBJTUqXqaTioGiC3+CPHV8gQsm4tkg5kfD92egR1M8wzOsZlbw2l/blYydL8/d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN7c59d6AFjtK1O2W2pi7aKhhuAul/8zL8eQhwIDbkV35+N1X2
	Zm0uFZZFw3/HfIN4WVn4UlhgtD4iuYb6gC624X7LV+RfICvgYPS+KFuQ1/QhqA==
X-Google-Smtp-Source: AGHT+IH4jzVJhB0xSo82C1kjazKACipjpThk9lCSIEDm/ppESo3x4fQbGxNJ/Rd4U9srnLrlT3T2og==
X-Received: by 2002:a05:6a20:c896:b0:1d2:e888:3a8e with SMTP id adf61e73a8af0-1d8bcf0ffb1mr6355148637.18.1728714771307;
        Fri, 11 Oct 2024 23:32:51 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9ea499sm3629330b3a.28.2024.10.11.23.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 23:32:50 -0700 (PDT)
Date: Sat, 12 Oct 2024 12:02:46 +0530
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
Message-ID: <20241012063246.2ogwe26edelljpth@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-4-dlemoal@kernel.org>
 <20241010143627.5eo5n2rp75pgtgpt@thinkpad>
 <2b3c7dfb-94ba-404a-94c0-6fd37a0cb20c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b3c7dfb-94ba-404a-94c0-6fd37a0cb20c@kernel.org>

On Fri, Oct 11, 2024 at 10:07:30AM +0900, Damien Le Moal wrote:
> On 10/10/24 23:36, Manivannan Sadhasivam wrote:
> > On Mon, Oct 07, 2024 at 01:03:15PM +0900, Damien Le Moal wrote:
> >> Some endpoint controllers have requirements on the alignment of the
> >> controller physical memory address that must be used to map a RC PCI
> >> address region. For instance, the rockchip endpoint controller uses
> >> at most the lower 20 bits of a physical memory address region as the
> >> lower bits of an RC PCI address. For mapping a PCI address region of
> >> size bytes starting from pci_addr, the exact number of address bits
> >> used is the number of address bits changing in the address range
> >> [pci_addr..pci_addr + size - 1].
> >>
> >> For this example, this creates the following constraints:
> >> 1) The offset into the controller physical memory allocated for a
> >>    mapping depends on the mapping size *and* the starting PCI address
> >>    for the mapping.
> >> 2) A mapping size cannot exceed the controller windows size (1MB) minus
> >>    the offset needed into the allocated physical memory, which can end
> >>    up being a smaller size than the desired mapping size.
> >>
> >> Handling these constraints independently of the controller being used
> >> in an endpoint function driver is not possible with the current EPC
> >> API as only the ->align field in struct pci_epc_features is provided
> >> and used for BAR (inbound ATU mappings) mapping. A new API is needed
> >> for function drivers to discover mapping constraints and handle
> >> non-static requirements based on the RC PCI address range to access.
> >>
> >> Introduce the function pci_epc_map_align() and the endpoint controller
> >> operation ->map_align to allow endpoint function drivers to obtain the
> >> size and the offset into a controller address region that must be
> >> allocated and mapped to access an RC PCI address region. The size
> >> of the mapping provided by pci_epc_map_align() can then be used as the
> >> size argument for the function pci_epc_mem_alloc_addr().
> >> The offset into the allocated controller memory provided can be used to
> >> correctly handle data transfers.
> >>
> >> For endpoint controllers that have PCI address alignment constraints,
> >> pci_epc_map_align() may indicate upon return an effective PCI address
> >> region mapping size that is smaller (but not 0) than the requested PCI
> >> address region size. For such case, an endpoint function driver must
> >> handle data accesses over the desired PCI address range in fragments,
> >> by repeatedly using pci_epc_map_align() over the PCI address range.
> >>
> >> The controller operation ->map_align is optional: controllers that do
> >> not have any alignment constraints for mapping a RC PCI address region
> >> do not need to implement this operation. For such controllers,
> >> pci_epc_map_align() always returns the mapping size as equal to the
> >> requested size of the PCI region and an offset equal to 0.
> >>
> >> The new structure struct pci_epc_map is introduced to represent a
> >> mapping start PCI address, mapping effective size, the size and offset
> >> into the controller memory needed for mapping the PCI address region as
> >> well as the physical and virtual CPU addresses of the mapping (phys_base
> >> and virt_base fields). For convenience, the physical and virtual CPU
> >> addresses within that mapping to access the target RC PCI address region
> >> are also provided (phys_addr and virt_addr fields).
> >>
> > 
> > I'm fine with the concept of this patch, but I don't get why you need an API for
> > this and not just a callback to be used in the pci_epc_mem_{map/unmap} APIs.
> > Furthermore, I don't see an user of this API (in 3 series you've sent out so
> > far). Let me know if I failed to spot it.
> > 
> > Also, the API name pci_epc_map_align() sounds like it does the mapping, but it
> > doesn't. So I'd not have it exposed as an API at all.
> 
> OK. Fine with me. I will move this inside pci_epc_mem_map(). But note that
> without this function, pci_epc_mem_alloc_addr() and pci_epc_map_addr() are
> totally useless for EP controllers that have a mapping alignment requirement,
> which without the pci_epc_map_align() function, an endpoint function driver
> cannot discover *at all* currently. That does not fix the overall API of EPC...
> 

Not at all. EPF drivers still can use "epf_mhi->epc_features->align" to discover
the alignment requirement and calculate the offset on their own (please see
pci-epf-mhi). But I'm not in favor of that approach since the APIs need to do
that job and that's why I like your pci_epc_mem_map() API.

> By not having pci_epc_map_align(), pci_epc_mem_alloc_addr() and
> pci_epc_map_addr() remain broken, but the introduction of pci_epc_mem_map() does
> provide a working solution for the general case.
> 
> So I think we will still need to do something about this bad state of the API later.
> 

We can always rework the APIs to incorporate the alignment requirement.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

