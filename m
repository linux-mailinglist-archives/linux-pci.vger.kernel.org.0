Return-Path: <linux-pci+bounces-13015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E59743DC
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06681C25798
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10BB18C930;
	Tue, 10 Sep 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JV1CMcA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VwUYZulm"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E6E183CB5;
	Tue, 10 Sep 2024 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725998662; cv=none; b=TFPPluu3lyBPR2Mx4S+xscPYqHVcFbT7SZc6DEFKMG/GQaNeTXzOSTHg6YPyvGfx6XjWioXmHit9TgwMgobPZQxBp7NGHFRr/UFynNrjdJhrOeGpfWTtNTriSZV0X2UnGeUMGzoVIfaiNyNfhl0c+XoFyO27mij7LemRaPqmDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725998662; c=relaxed/simple;
	bh=WHDhuxva9GO2/WerZhHgC0RkfM916BwqPjIEdBr2QYk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O/4waWZKYnS4g7/yFe2K0XcMYIWXrU7jJwGzkVeUAPKr/JGIB2YXdMvq1671A2OygUhX1PzlHnUygcXKiUVnZq7jgwoY7YyhRJQu5e2RcHwvpzlU7Tc+yp2PIrqnJa39KPk2lvmsvziHrAh13Fjm1/M7xbojJ/FCjxeNA74ADYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JV1CMcA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VwUYZulm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725998658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVM34/u4Y/f4dl/hAeSYXJKGI8duu5TGFLhjrluOaog=;
	b=1JV1CMcArHl9mQhILyLZVUNiJiwGMIzHj3eeBHJTIwUbZXkOkLzV+gefl42eNlbnkVnrdz
	FmOXdbGiosptZXby/r6AONZ69OaY6sCz/jClGgXC2LNMDs8O2JwJaJVFkJ4qkErnsBqNXs
	n30ZxgeO/qD3LFjkX3Vv53aMCtr6+TceGn8bP95ujKKr2ji6D9nw9DTq0FDmwfybGnHgS2
	MWIVVaqux7EL0/sUt3L8bnHISXe2r7pASGw7NVmfaMBWYkRlKKJZc7E5Q/Qd+MdtYp8Q4u
	iSmTYihxDhTLs01AvuOrqoZ86h+rULk9VRzfQOG3f/Dqo7EHb1jIRDhEHDNX/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725998658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AVM34/u4Y/f4dl/hAeSYXJKGI8duu5TGFLhjrluOaog=;
	b=VwUYZulmKSK+rwre3C/Gh7aHbohIyHcroCJq59hqQKaqO7kJqbW9n4/UOoo7bkA+gY2+IL
	GoX2Vv3xyYgOJABQ==
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, Alison Schofield
 <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, terry.bowman@amd.com, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Ilpo
 =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [RFC PATCH 0/9] pci: portdrv: Add auxiliary bus and register
 CXL PMUs (and aer)
In-Reply-To: <20240910174743.000037c7@huawei.com>
References: <20240905122342.000001be@Huawei.com> <87jzfpdrc7.ffs@tglx>
 <20240906181832.00007dc7@Huawei.com> <20240910174743.000037c7@huawei.com>
Date: Tue, 10 Sep 2024 22:04:18 +0200
Message-ID: <87h6an9sxp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 10 2024 at 17:47, Jonathan Cameron wrote:
> There are quite a few places that make the assumption that the
> preirq_data->parent->chip is the right chip to for example call
> irq_set_affinity on.
>
> So the simple way to make it all work is to just have
> a msi_domain_template->msi_domain_ops->prepare_desc
> that sets the desc->dev = to the parent device (here the
> pci_dev->dev)

Creative :)

> At that point everything more or less just works and all the
> rest of the callbacks can use generic forms.
>
> Alternative might be to make calls like the one in
> arch/x86/kernel/apic/msi.c msi_set_affinity search
> for the first ancestor device that has an irq_set_affinity().
> That unfortunately may affect quite a few places.

What's the problem? None of the CXL drivers should care about that at
all. Delegating other callbacks to the parent domain is what hierarchical
domains are about. If there is some helper missing, so we add it.

> Anyhow, I'll probably send out the prepare_desc hack set with driver
> usage etc after I've written up a proper description of problems
> encountered etc so you can see what it all looks like and will be more
> palatable in general but in the meantime this is the guts of it of the
> variant where the subdev related desc has the dev set to the parent
> device.

Let me look at this pile then :)

> Note for the avoidance of doubt, I don't much like this
> solution but maybe it will grow on me ;)

Maybe, but I doubt it will survive my abstraction taste check.

> +static const struct msi_parent_ops pci_msix_parent_ops = {
> +	.supported_flags = MSI_FLAG_PCI_MSIX | MSI_FLAG_PCI_MSIX_ALLOC_DYN,
> +	.prefix = "PCI-MSIX-PROXY-",
> +	.init_dev_msi_info = msi_parent_init_dev_msi_info,

The obligatory link to:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +};
> +
> +int pci_msi_enable_parent_domain(struct pci_dev *pdev)
> +{
> +	struct irq_domain *msix_dom;
> +	/* TGLX: Validate has v2 parent domain */
> +	/* TGLX: validate msix enabled */
> +	/* TGLX: Validate msix domain supports dynamics msi-x */
> +
> +	/* Enable PCI device parent domain */
> +	msix_dom = dev_msi_get_msix_device_domain(&pdev->dev);
> +	msix_dom->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
> +	msix_dom->msi_parent_ops = &pci_msix_parent_ops;

That want's to be a call into the MSI core code, Something like:

     msi_enable_sub_parent_domain(&pdev->dev, DOMAIN_BUS_PCI_DEVICE_MSIX)

or something like that. I really don't want to expose the internals of
MSI. I spent a lot of effort to encapsulate that...

> +void pci_msi_init_subdevice(struct pci_dev *pdev, struct device *dev)
> +{
> +	dev_set_msi_domain(dev, dev_msi_get_msix_device_domain(&pdev->dev));

     msi_set_parent_domain(.....);

> +static void pci_subdev_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> +					struct msi_desc *desc)
> +{
> +	struct device *parent = desc->dev->parent;
> +
> +	if (!desc->pci.mask_base) {
> +		/* Not elegant - but needed for irq affinity to work? */

Which makes me ask the question why desc->pci.mask_base is NULL in the
first place. That needs some thought at the place which initializes the
descriptor.

> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1720,3 +1720,8 @@ bool msi_device_has_isolated_msi(struct device *dev)
>  	return arch_is_isolated_msi();
>  }
>  EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
> +struct irq_domain *dev_msi_get_msix_device_domain(struct device *dev)

You clearly run out of new lines here :)

> +{
> +	return dev->msi.data->__domains[0].domain;
> +}

But aside of that. No. See above.

Thanks,

        tglx


