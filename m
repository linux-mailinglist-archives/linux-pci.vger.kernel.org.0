Return-Path: <linux-pci+bounces-13129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B09976F97
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 19:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 543AE285C19
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0A188592;
	Thu, 12 Sep 2024 17:34:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D193D17837A;
	Thu, 12 Sep 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162477; cv=none; b=oJ6hfAUKgCbHDzMJvvANb7N594BCRywfKGx7Q4/IuuOAkT752t0Gg0frJZP/mJhScUdLJHcLV79/+u/kokAnP1iP29Lns9ooFik+7cS2ylq2sDWVb/9MGMYZLsZFW2C+Ase2Tp0KLO8ykeGC5SwQn0BCvtcx9kIrSwzdO2Ln4l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162477; c=relaxed/simple;
	bh=YS5NIOvuMr3HztiHUTgI7VOt2WB4X20uJ8fduqZNSEs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XX0n4eibUPs6tizPyGwbimrA9T/h6ZD1CpPEmezzTdv6PKaV8obDDVCMrcA9OD6d6YqBB/RotCq6MP2lEE7iY6CE4psMDI+J2jIM+oMgbT4VKQU+eZ9gUVi2ohKyf5y0OpmlcPedfyCr0glgvdyZtDib0r7JwXn8E0tKwVGHM4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X4Pbx34ZWz6K7GV;
	Fri, 13 Sep 2024 01:30:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B294140B55;
	Fri, 13 Sep 2024 01:34:32 +0800 (CST)
Received: from localhost (10.126.170.50) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 19:34:31 +0200
Date: Thu, 12 Sep 2024 18:34:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, "Dave Jiang" <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, <terry.bowman@amd.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240912183429.00006fa7@Huawei.com>
In-Reply-To: <20240912173720.000077ac@Huawei.com>
References: <20240905122342.000001be@Huawei.com>
	<87jzfpdrc7.ffs@tglx>
	<20240906181832.00007dc7@Huawei.com>
	<20240910174743.000037c7@huawei.com>
	<87h6an9sxp.ffs@tglx>
	<20240912173720.000077ac@Huawei.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 12 Sep 2024 17:37:20 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 10 Sep 2024 22:04:18 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Tue, Sep 10 2024 at 17:47, Jonathan Cameron wrote:
> > > There are quite a few places that make the assumption that the
> > > preirq_data->parent->chip is the right chip to for example call
> > > irq_set_affinity on.
> > >
> > > So the simple way to make it all work is to just have
> > > a msi_domain_template->msi_domain_ops->prepare_desc
> > > that sets the desc->dev = to the parent device (here the
> > > pci_dev->dev)  
> > 
> > Creative :)
> 
> One bit that is challenging me is that the PCI access functions
> use the pci_dev that is embedded via irq_data->common->msi_desc->dev
> (and hence doesn't give us a obvious path to any hierarchical structures)
> E.g. __pci_write_msi_msg() and which checks the pci_dev is
> powered up.
> 
> I'd like to be able to do a call to the parent similar to irq_chip_unmask_parent
> to handle write_msi_msg() for the new device domain.
> 
> So how should this be avoided or should msi_desc->dev be the
> PCI device?

I thought about this whilst cycling home.  Perhaps my fundamental
question is more basic  Which device should
msi_dec->dev be?
* The ultimate requester of the msi  -  so here the one calling
our new pci_msix_subdev_alloc_at(),
* The one on which the msi_write_msg() should occur. - here
  that would be the struct pci_dev given the checks needed on
  whether the device is powered up.  If this is the case, can
  we instead use the irq_data->dev in __pci_write_msi_msg()?

Also, is it valid to use the irq_domain->dev for callbacks such
as msi_prepare_desc on basis that (I think) is the device
that 'hosts' the irq domain, so can we use it to replace the
use of msi_desc->dev in pci_msix_prepare_desc()
If we can that enables our subdev to use a prepare_desc callback
that does something like

	struct msi_domain *info;

	domain = domain->parent;
	info = domain->host_data;

	info->ops->prepare_desc(domain, arg, desc);

Thanks for any pointers!

Jonathan


> 
> I can see some options but maybe I'm missing the big picture.
> 1) Stop them using that path to get to the device because it
>   might not be the right one. Instead use device via irq_data->chip_data
>   (which is currently unused for these cases).
>   Some slightly fiddly work will be needed to handle changing __pci_write_msi_msg()
>   to talk irq_data though.
> 2) Maybe setting the msi descriptor dev to the one we actually write
>    on is the right solution? (smells bad to me but I'm still getting
>    my head around this stuff).
> 
> Any immediate thoughts?  Or am I still thinking about this the wrong
> way? (which is likely)
> 
> > 
> > > At that point everything more or less just works and all the
> > > rest of the callbacks can use generic forms.
> > >
> > > Alternative might be to make calls like the one in
> > > arch/x86/kernel/apic/msi.c msi_set_affinity search
> > > for the first ancestor device that has an irq_set_affinity().
> > > That unfortunately may affect quite a few places.  
> > 
> > What's the problem? None of the CXL drivers should care about that at
> > all. Delegating other callbacks to the parent domain is what hierarchical
> > domains are about. If there is some helper missing, so we add it.
> > 
> > > Anyhow, I'll probably send out the prepare_desc hack set with driver
> > > usage etc after I've written up a proper description of problems
> > > encountered etc so you can see what it all looks like and will be more
> > > palatable in general but in the meantime this is the guts of it of the
> > > variant where the subdev related desc has the dev set to the parent
> > > device.  
> > 
> > Let me look at this pile then :)
> > 
> > > Note for the avoidance of doubt, I don't much like this
> > > solution but maybe it will grow on me ;)  
> > 
> > Maybe, but I doubt it will survive my abstraction taste check.
> > 
> > > +static const struct msi_parent_ops pci_msix_parent_ops = {
> > > +	.supported_flags = MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN,
> > > +	.prefix = "PCI-MSIX-PROXY-",
> > > +	.init_dev_msi_info = msi_parent_init_dev_msi_info,  
> > 
> > The obligatory link to:
> > 
> > https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
> > 
> 
> Thanks. Will fix up before I get anywhere near a real posting!
> 
> > > +};
> > > +
> > > +int pci_msi_enable_parent_domain(struct pci_dev *pdev)
> > > +{
> > > +	struct irq_domain *msix_dom;
> > > +	/* TGLX: Validate has v2 parent domain */
> > > +	/* TGLX: validate msix enabled */
> > > +	/* TGLX: Validate msix domain supports dynamics msi-x */
> > > +
> > > +	/* Enable PCI device parent domain */
> > > +	msix_dom = dev_msi_get_msix_device_domain(&pdev->dev);
> > > +	msix_dom->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> > > +	msix_dom->msi_parent_ops = &pci_msix_parent_ops;  
> > 
> > That want's to be a call into the MSI core code, Something like:
> > 
> >      msi_enable_sub_parent_domain(&pdev->dev, DOMAIN_BUS_PCI_DEVICE_MSIX)
> > 
> > or something like that. I really don't want to expose the internals of
> > MSI. I spent a lot of effort to encapsulate that...
> > 
> > > +void pci_msi_init_subdevice(struct pci_dev *pdev, struct device *dev)
> > > +{
> > > +	dev_set_msi_domain(dev, dev_msi_get_msix_device_domain(&pdev->dev));  
> > 
> >      msi_set_parent_domain(.....);
> > 
> > > +static void pci_subdev_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > > +					struct msi_desc *desc)
> > > +{
> > > +	struct device *parent = desc->dev->parent;
> > > +
> > > +	if (!desc->pci.mask_base) {
> > > +		/* Not elegant - but needed for irq affinity to work? */  
> > 
> > Which makes me ask the question why desc->pci.mask_base is NULL in the
> > first place. That needs some thought at the place which initializes the
> > descriptor.
> 
> Maybe this is the other way around?  The descriptor is 'never' initialized
> for this case.  The equivalent code in msix_prepare_msi_desc() has
> comments 
> " This is separate from msix_setup_msi_descs() below to handle dynamic
>  allocations for MSI-X after initial enablement."
> So I think this !desc->pci.mask_base should always succeed 
> (and so I should get rid of it and run the descriptor initialize unconditionally)
> 
> It might be appropriate to call the prepare_desc from the parent msi_domain though
> via irq_domain->parent_domain->host_data
> However this has the same need to not be based on the msi_desc->dev subject
> to the question above.
> 
> Jonathan
> 
> 
> 
> > 
> > > --- a/kernel/irq/msi.c
> > > +++ b/kernel/irq/msi.c
> > > @@ -1720,3 +1720,8 @@ bool msi_device_has_isolated_msi(struct device *dev)
> > >  	return arch_is_isolated_msi();
> > >  }
> > >  EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
> > > +struct irq_domain *dev_msi_get_msix_device_domain(struct device *dev)  
> > 
> > You clearly run out of new lines here :)
> > 
> > > +{
> > > +	return dev->msi.data->__domains[0].domain;
> > > +}  
> > 
> > But aside of that. No. See above.
> > 
> > Thanks,
> > 
> >         tglx
> > 
> 


