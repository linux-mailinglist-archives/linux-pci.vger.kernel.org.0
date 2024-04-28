Return-Path: <linux-pci+bounces-6749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA48B4A7E
	for <lists+linux-pci@lfdr.de>; Sun, 28 Apr 2024 09:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466981F21840
	for <lists+linux-pci@lfdr.de>; Sun, 28 Apr 2024 07:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BFF4F8BD;
	Sun, 28 Apr 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE66YgTI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE82D50251;
	Sun, 28 Apr 2024 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714289005; cv=none; b=Gc6UpBcHvPO8UfzeaFr5mXk9XN1AEsASoAbvhLZC9B5Q3fFa3hrhMDLv+QmiRbftogrbj7pvl3fVMfDsHl5/RJ1FTTKlqBf7rxGEYOGFiWICrZHhV5kJT+Tj8ZX+pRBP2ROs9zUF07L3VKjnBKZ2rKCfxCxSzad9S4gytDG7+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714289005; c=relaxed/simple;
	bh=DP/Aemdi0KQCVAXsAFaA/0biCg9ptDN5YTYd2q7KhJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNT/n7rh7YZdPSoroBBKT1U33ohcDND7V19Iih0S7Dh7Qp3AtpaAEgyRCSR0IIWL5jmOhNWD8lG7uXKFxWGffgTJso9sGTmm400Zc466nzP90OWQI7ImJyNtVMthg727alQJB6x001BAK4GUbB3/F7av4UGRAB6YlDBfP15MbmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE66YgTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02F1C113CC;
	Sun, 28 Apr 2024 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714289004;
	bh=DP/Aemdi0KQCVAXsAFaA/0biCg9ptDN5YTYd2q7KhJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nE66YgTI69QfmVwPjTW2XnkJQBVd7P/4BPQ3n0Sz3wK+PAt5TCm2pCZuuKN6PDgoX
	 pD2uajeEUrDUANVaxos2Kkcfj8zcJ7j9KAqtwBrRpK7YmQ5Uc3jv6WoMAd5EgUQKPr
	 jF4ihlx0R1lV4LNlNeyt9D79u3zgWW4ci81MQAWx/xu19H+sMAUaSKXX3HxrAL4edU
	 WTdcu8YK2R1QRkzCuP9BoDL5t1GJ8y/FlIT/TNzoM4t6b9EjuWNbScqd1nWhNsAKsd
	 EiCPeUtKIrqHhyRIqX/2u2B8O2XZ+LFNdgVFKJ+l+qfFNBWLTG6uSpMkEeWd2iCHa2
	 PNIV8SeDkhd1g==
Date: Sun, 28 Apr 2024 08:23:18 +0100
From: Will Deacon <will@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [Query] ACS enablement in the DT based boot flow
Message-ID: <20240428072318.GA11447@willie-the-truck>
References: <PH8PR12MB667446D4A4CAD6E0A2F488B5B83F2@PH8PR12MB6674.namprd12.prod.outlook.com>
 <20240410192840.GA2147526@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410192840.GA2147526@bhelgaas>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Apr 10, 2024 at 02:28:40PM -0500, Bjorn Helgaas wrote:
> [+cc Will, Joerg]
> 
> On Mon, Apr 01, 2024 at 10:40:15AM +0000, Vidya Sagar wrote:
> > Hi folks,
> > ACS (Access Control Services) is configured for a PCI device through
> > pci_enable_acs().  The first thing pci_enable_acs() checks for is
> > whether the global flag 'pci_acs_enable' is set or not.  The global
> > flag 'pci_acs_enable' is set by the function pci_request_acs().
> > 
> > pci_enable_acs() function is called whenever a new PCI device is
> > added to the system
> > 
> >  pci_enable_acs+0x4c/0x2a4
> >  pci_acs_init+0x38/0x60
> >  pci_device_add+0x1a0/0x670
> >  pci_scan_single_device+0xc4/0x100
> >  pci_scan_slot+0x6c/0x1e0
> >  pci_scan_child_bus_extend+0x48/0x2e0
> >  pci_scan_root_bus_bridge+0x64/0xf0
> >  pci_host_probe+0x18/0xd0
> > 
> > In the case of a system that boots using device-tree blob,
> > pci_request_acs() is called when the device driver binds with the
> > respective device
> > 
> > of_iommu_configure+0xf4/0x230
> > of_dma_configure_id+0x110/0x340
> > pci_dma_configure+0x54/0x120
> > really_probe+0x80/0x3e0
> > __driver_probe_device+0x88/0x1c0
> > driver_probe_device+0x3c/0x140
> > __device_attach_driver+0xe8/0x1e0
> > bus_for_each_drv+0x78/0xf0
> > __device_attach+0x104/0x1e0
> > device_attach+0x14/0x30
> > pci_bus_add_device+0x50/0xd0
> > pci_bus_add_devices+0x38/0x90
> > pci_host_probe+0x40/0xd0
> > 
> > Since the device addition always happens first followed by the
> > driver binding, this flow effectively makes sure that ACS never gets
> > enabled.
> > 
> > Ideally, I would expect the pci_request_acs() get called (probably
> > by the OF framework itself) before calling pci_enable_acs().
> > 
> > This happens in the ACPI flow where pci_request_acs() is called
> > during IORT node initialization (i.e. iort_init_platform_devices()
> > function).
> > 
> > Is this understanding correct? If yes, would it make sense to call
> > pci_request_acs() during OF initialization (similar to IORT
> > initialization in ACPI flow)?
> 
> Your understanding looks correct to me.  My call graph notes, FWIW:
> 
>   mem_init
>     pci_iommu_alloc                   # x86 only
>       amd_iommu_detect                # init_state = IOMMU_START_STATE
>         iommu_go_to_state(IOMMU_IVRS_DETECTED)
>           state_next
>             switch (init_state)
>             case IOMMU_START_STATE:
>               detect_ivrs
>                 pci_request_acs
>                   pci_acs_enable = 1  # <--
>       detect_intel_iommu
>         pci_request_acs
>           pci_acs_enable = 1          # <--
> 
>   pci_scan_single_device              # PCI enumeration
>     ...
>       pci_init_capabilities
>         pci_acs_init
>           pci_enable_acs
>             if (pci_acs_enable)       # <--
>               pci_std_enable_acs
> 
>   __driver_probe_device
>     really_probe
>       pci_dma_configure               # pci_bus_type.dma_configure
>         if (OF)
>           of_dma_configure
>             of_dma_configure_id
>               of_iommu_configure
>                 pci_request_acs       # <-- 6bf6c24720d3
>                 iommu_probe_device
>         else if (ACPI)
>           acpi_dma_configure
>             acpi_dma_configure_id
>               acpi_iommu_configure_id
>                 iommu_probe_device
> 
> The pci_request_acs() in of_iommu_configure(), which happens too late
> to affect pci_enable_acs(), was added by 6bf6c24720d3 ("iommu/of:
> Request ACS from the PCI core when configuring IOMMU linkage"), so I
> cc'd Will and Joerg.  I don't know if that *used* to work and got
> broken somehow, or if it never worked as intended.

I don't have any way to test this, but I'm supportive of having the same
flow for DT and ACPI-based flows. Vidya, are you able to cook a patch?

Will

