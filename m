Return-Path: <linux-pci+bounces-13122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1053976EDE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 18:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310631F2526B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801711A0BF6;
	Thu, 12 Sep 2024 16:37:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE13143C40;
	Thu, 12 Sep 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159049; cv=none; b=LVyRkiD5PLNz7GTYC9TAfQex4YdrFX81pI3Mp62IQ0S4ZKg34HMVcFS5rDatUfeH//xcO9USoTOpL4zWjttlAJagtMtI3DPZcjMMf1bGMHEcTWq5g6gvPO/r0VM+0naHys5nWrKxfcj0bW/qIQ44agl7Etxbfz6SGfD0NHjhP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159049; c=relaxed/simple;
	bh=TKVJpDDZ+AB+iiQq/zZ20I8e81dLdwfJ8jsP7xSSAHQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rxm4H3r0Yw9JfjzxyJQk64DhMMlHl4pnj0IP0e5FTtC0NJdXvn79nIkrORQPTWbpotR4wvyx2cEPNPdgSF/yKMbr4HrMqLpwLGstPHXVt//5t4e7yzPEMoIAbbMYtY0J9p5JsZxRDZwlRYZqlCCLymtELdK4BmTOAE/KsOGyqdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X4NKZ21wTz6HJrJ;
	Fri, 13 Sep 2024 00:33:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E0325140519;
	Fri, 13 Sep 2024 00:37:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 18:37:22 +0200
Date: Thu, 12 Sep 2024 17:37:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, <terry.bowman@amd.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvi?= =?ISO-8859-1?Q?nen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
Message-ID: <20240912173720.000077ac@Huawei.com>
In-Reply-To: <87h6an9sxp.ffs@tglx>
References: <20240905122342.000001be@Huawei.com>
	<87jzfpdrc7.ffs@tglx>
	<20240906181832.00007dc7@Huawei.com>
	<20240910174743.000037c7@huawei.com>
	<87h6an9sxp.ffs@tglx>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 10 Sep 2024 22:04:18 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, Sep 10 2024 at 17:47, Jonathan Cameron wrote:
> > There are quite a few places that make the assumption that the
> > preirq_data->parent->chip is the right chip to for example call
> > irq_set_affinity on.
> >
> > So the simple way to make it all work is to just have
> > a msi_domain_template->msi_domain_ops->prepare_desc
> > that sets the desc->dev = to the parent device (here the
> > pci_dev->dev)  
> 
> Creative :)

One bit that is challenging me is that the PCI access functions
use the pci_dev that is embedded via irq_data->common->msi_desc->dev
(and hence doesn't give us a obvious path to any hierarchical structures)
E.g. __pci_write_msi_msg() and which checks the pci_dev is
powered up.

I'd like to be able to do a call to the parent similar to irq_chip_unmask_parent
to handle write_msi_msg() for the new device domain.

So how should this be avoided or should msi_desc->dev be the
PCI device?

I can see some options but maybe I'm missing the big picture.
1) Stop them using that path to get to the device because it
  might not be the right one. Instead use device via irq_data->chip_data
  (which is currently unused for these cases).
  Some slightly fiddly work will be needed to handle changing __pci_write_msi_msg()
  to talk irq_data though.
2) Maybe setting the msi descriptor dev to the one we actually write
   on is the right solution? (smells bad to me but I'm still getting
   my head around this stuff).

Any immediate thoughts?  Or am I still thinking about this the wrong
way? (which is likely)

> 
> > At that point everything more or less just works and all the
> > rest of the callbacks can use generic forms.
> >
> > Alternative might be to make calls like the one in
> > arch/x86/kernel/apic/msi.c msi_set_affinity search
> > for the first ancestor device that has an irq_set_affinity().
> > That unfortunately may affect quite a few places.  
> 
> What's the problem? None of the CXL drivers should care about that at
> all. Delegating other callbacks to the parent domain is what hierarchical
> domains are about. If there is some helper missing, so we add it.
> 
> > Anyhow, I'll probably send out the prepare_desc hack set with driver
> > usage etc after I've written up a proper description of problems
> > encountered etc so you can see what it all looks like and will be more
> > palatable in general but in the meantime this is the guts of it of the
> > variant where the subdev related desc has the dev set to the parent
> > device.  
> 
> Let me look at this pile then :)
> 
> > Note for the avoidance of doubt, I don't much like this
> > solution but maybe it will grow on me ;)  
> 
> Maybe, but I doubt it will survive my abstraction taste check.
> 
> > +static const struct msi_parent_ops pci_msix_parent_ops = {
> > +	.supported_flags = MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN,
> > +	.prefix = "PCI-MSIX-PROXY-",
> > +	.init_dev_msi_info = msi_parent_init_dev_msi_info,  
> 
> The obligatory link to:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers
> 

Thanks. Will fix up before I get anywhere near a real posting!

> > +};
> > +
> > +int pci_msi_enable_parent_domain(struct pci_dev *pdev)
> > +{
> > +	struct irq_domain *msix_dom;
> > +	/* TGLX: Validate has v2 parent domain */
> > +	/* TGLX: validate msix enabled */
> > +	/* TGLX: Validate msix domain supports dynamics msi-x */
> > +
> > +	/* Enable PCI device parent domain */
> > +	msix_dom = dev_msi_get_msix_device_domain(&pdev->dev);
> > +	msix_dom->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> > +	msix_dom->msi_parent_ops = &pci_msix_parent_ops;  
> 
> That want's to be a call into the MSI core code, Something like:
> 
>      msi_enable_sub_parent_domain(&pdev->dev, DOMAIN_BUS_PCI_DEVICE_MSIX)
> 
> or something like that. I really don't want to expose the internals of
> MSI. I spent a lot of effort to encapsulate that...
> 
> > +void pci_msi_init_subdevice(struct pci_dev *pdev, struct device *dev)
> > +{
> > +	dev_set_msi_domain(dev, dev_msi_get_msix_device_domain(&pdev->dev));  
> 
>      msi_set_parent_domain(.....);
> 
> > +static void pci_subdev_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> > +					struct msi_desc *desc)
> > +{
> > +	struct device *parent = desc->dev->parent;
> > +
> > +	if (!desc->pci.mask_base) {
> > +		/* Not elegant - but needed for irq affinity to work? */  
> 
> Which makes me ask the question why desc->pci.mask_base is NULL in the
> first place. That needs some thought at the place which initializes the
> descriptor.

Maybe this is the other way around?  The descriptor is 'never' initialized
for this case.  The equivalent code in msix_prepare_msi_desc() has
comments 
" This is separate from msix_setup_msi_descs() below to handle dynamic
 allocations for MSI-X after initial enablement."
So I think this !desc->pci.mask_base should always succeed 
(and so I should get rid of it and run the descriptor initialize unconditionally)

It might be appropriate to call the prepare_desc from the parent msi_domain though
via irq_domain->parent_domain->host_data
However this has the same need to not be based on the msi_desc->dev subject
to the question above.

Jonathan



> 
> > --- a/kernel/irq/msi.c
> > +++ b/kernel/irq/msi.c
> > @@ -1720,3 +1720,8 @@ bool msi_device_has_isolated_msi(struct device *dev)
> >  	return arch_is_isolated_msi();
> >  }
> >  EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
> > +struct irq_domain *dev_msi_get_msix_device_domain(struct device *dev)  
> 
> You clearly run out of new lines here :)
> 
> > +{
> > +	return dev->msi.data->__domains[0].domain;
> > +}  
> 
> But aside of that. No. See above.
> 
> Thanks,
> 
>         tglx
> 


