Return-Path: <linux-pci+bounces-12901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C799E96F9D6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D3B23570
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2024 17:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094461D31B8;
	Fri,  6 Sep 2024 17:18:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F370C1C8FB6;
	Fri,  6 Sep 2024 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725643125; cv=none; b=tjtlp/am+slhDOJz3pRg0G4og7ASm8g3nO3jBeVVVXiaAvPK/OCo26hlbRIDpOEFQmcL1DaHJ0H3vkdaxIDnE6AdmJRtJgSOfPIeyipubuffvXjyvin5tSYQDiwtkTLSdDLZA78CphsVYJl+Uykg2CF+zwWK17hgsnmXp3Mg/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725643125; c=relaxed/simple;
	bh=ZTzBUKAGroNLqJ1odxdsYO7FH4rWOAcZlLGP2FUJcnE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gs598dOE8xg0MXVqOtC9czYPp/9ywpdxHPH1+IoSizwBMkOFki0In3iG1FACl2DrLKHrTwtuPUNRaIWJmF2RxmklJD6NL6bo42WnotB6vCK4iOBYAqi+lQtb2Heb+GF4+rmiTiZfq95O/irSb+9qu49QbSIBYG4gylBoBnloYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X0jXS1X6Sz6L77B;
	Sat,  7 Sep 2024 01:15:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 00AF81400CA;
	Sat,  7 Sep 2024 01:18:34 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 6 Sep
 2024 18:18:33 +0100
Date: Fri, 6 Sep 2024 18:18:32 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	<linuxarm@huawei.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<terry.bowman@amd.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvi?=
 =?ISO-8859-1?Q?nen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240906181832.00007dc7@Huawei.com>
In-Reply-To: <87jzfpdrc7.ffs@tglx>
References: <20240905122342.000001be@Huawei.com>
	<87jzfpdrc7.ffs@tglx>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 06 Sep 2024 12:11:36 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Sep 05 2024 at 12:23, Jonathan Cameron wrote:
> >> Look at how the PCI device manages interrupts with the per device MSI
> >> mechanism. Forget doing this with either one of the legacy mechanisms.
> >> 
> >>   1) It creates a hierarchical interrupt domain and gets the required
> >>      resources from the provided parent domain. The PCI side does not
> >>      care whether this is x86 or arm64 and it neither cares whether the
> >>      parent domain does remapping or not. The only way it cares is about
> >>      the features supported by the different parent domains (think
> >>      multi-MSI).
> >>      
> >>   2) Driver side allocations go through the per device domain
> >> 
> >> That AUXbus is not any different. When the CPMU driver binds it wants to
> >> allocate interrupts. So instead of having a convoluted construct
> >> reaching into the parent PCI device, you simply can do:
> >> 
> >>   1) Let the cxl_pci driver create a MSI parent domain and set that in
> >>      the subdevice::msi::irqdomain pointer.
> >> 
> >>   2) Provide cxl_aux_bus_create_irqdomain() which allows the CPMU device
> >>      driver to create a per device interrupt domain.
> >> 
> >>   3) Let the CPMU driver create its per device interrupt domain with
> >>      the provided parent domain
> >> 
> >>   4) Let the CPMU driver allocate its MSI-X interrupts through the per
> >>      device domain
> >> 
> >> Now on the cxl_pci side the AUXbus parent interrupt domain allocation
> >> function does:
> >> 
> >>     if (!pci_msix_enabled(pdev))
> >>     	return pci_msix_enable_and_alloc_irq_at(pdev, ....);
> >>     else
> >>         return pci_msix_alloc_irq_at(pdev, ....);  
> 
> Ignore the above. Brainfart.
> 
> > I'm struggling to follow this suggestion
> > Would you expect the cxl_pci MSI parent domain to set it's parent as
> > msi_domain = irq_domain_create_hierarchy(dev_get_msi_domain(&pdev->dev),
> > 					 IRQ_DOMAIN_FLAG_MSI_PARENT,
> > 					 ...
> > which seems to cause a problem with deadlocks in __irq_domain_alloc_irqs()
> > or create a separate domain structure and provide callbacks that reach into
> > the parent domain as necessary?
> >
> > Or do I have this entirely wrong? I'm struggling to relate what existing
> > code like PCI does to what I need to do here.  
> 
> dev_get_msi_domain(&pdev->dev) is a nightmare due to the 4 different
> models we have:
> 
>    - Legacy has no domain
> 
>    - Non-hierarchical domain
> 
>    - Hierarchical domain v1
> 
>          That's the global PCI/MSI domain
> 
>    - Hierarchical domain v2
> 
>       That's the underlying MSI_PARENT domain, which is on x86
>       either the interrupt remap unit or the vector domain. On arm64
>       it's the ITS domain.
> 
> See e.g. pci_msi_domain_supports() which handles the mess.
> 
> Now this proposal will only work on hierarchical domain v2 because that
> can do the post enable allocations on MSI-X. Let's put a potential
> solution for MSI aside for now to avoid complexity explosion.
> 
> So there are two ways to solve this:
> 
>   1) Implement the CXL MSI parent domain as disjunct domain
> 
>   2) Teach the V2 per device MSI-X domain to be a parent domain
> 
> #1 Looks pretty straight forward, but does not seemlessly fit the
>    hierarchical domain model and creates horrible indirections.
> 
> #2 Is the proper abstraction, but requires to teach the MSI core code
>    about stacked MSI parent domains, which should not be horribly hard
>    or maybe just works out of the box.
> 
> The PCI device driver invokes the not yet existing function
> pci_enable_msi_parent_domain(pci_dev). This function does:
> 
>   A) validate that this PCI device has a V2 parent domain
> 
>   B) validate that the device has enabled MSI-X
> 
>   C) validate that the PCI/MSI-X domain supports dynamic MSI-X
>      allocation
> 
>   D) if #A to #C are true, it enables the PCI device parent domain
> 
> I made #B a prerequisite for now, as that's an orthogonal problem, which
> does not need to be solved upfront. Maybe it does not need to be solved
> at all because the underlying PCI driver always allocates a management
> interrupt before dealing with the underlying "bus", which is IMHO a
> reasonable expectation. At least it's a reasonable restriction for
> getting started.
> 
> That function does:
> 
>      msix_dom = pci_msi_get_msix_domain(pdev);
>      msix_dom->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
>      msix_dom->msi_parent_ops = &pci_msix_parent_ops;
> 
> When creating the CXL devices the CXL code invokes
> pci_msi_init_subdevice(pdev, &cxldev->device), which just does:
> 
>   dev_set_msi_domain(dev, pci_msi_get_msix_subdevice_parent(pdev));
> 
> That allows the CXL devices to create their own per device MSI
> domain via a new function pci_msi_create_subdevice_irq_domain().
> 
> That function can just use a variant of pci_create_device_domain() with
> a different domain template and a different irqchip, where the irqchip
> just redirects to the underlying parent domain chip, aka PCI-MSI-X.
> 
> I don't think the CXL device will require a special chip as all they
> should need to know is the linux interrupt number. If there are special
> requirements then we can bring the IMS code back or do something similar
> to the platform MSI code. 
> 
> Then you need pci_subdev_msix_alloc_at() and pci_subdev_msix_free()
> which are the only two functions which the CXL (or similar) need.
> 
> The existing pci_msi*() API function might need a safety check so they
> can't be abused by subdevices, but that's a problem for a final
> solution.
> 
> That's pretty much all what it takes. Hope that helps.

Absolutely!  Thanks for providing the detailed suggestion
this definitely smells a lot less nasty than previous approach.

I have things sort of working now but it's ugly code with a few
cross layer hacks that need tidying up (around programming the
msi registers from wrong 'device'), so may be a little
while before I get it in a state to post.

Jonathan

> 
> Thanks,
> 
>         tglx
> 
> 
> 


