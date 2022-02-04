Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A374A9B7A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359470AbiBDOvZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 09:51:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4679 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359459AbiBDOvY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 09:51:24 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqyzG6WRRz67HW3;
        Fri,  4 Feb 2022 22:46:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 15:51:22 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 14:51:21 +0000
Date:   Fri, 4 Feb 2022 14:51:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 04/10] PCI/DOE: Introduce pci_doe_create_doe_devices
Message-ID: <20220204145116.00000f5c@Huawei.com>
In-Reply-To: <20220203224437.GA120552@bhelgaas>
References: <20220201071952.900068-5-ira.weiny@intel.com>
 <20220203224437.GA120552@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.86]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 3 Feb 2022 16:44:37 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Mon, Jan 31, 2022 at 11:19:46PM -0800, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL and/or PCI devices can define DOE mailboxes.    
> 
> In concrete terms, "DOE mailbox" refers to a DOE Capability, right?
> PCIe devices are allowed to implement several instances of the DOE
> Capability, of course.  I'm kind of partial to concreteness because it
> makes it easier to map between the code and the spec.

I'll throw my opinions in here, though a lot of this is really
about the justification for representing this via an Aux bus.
Personally I wouldn't mind if we decided the kernel was always in
charge of DOEs.  Others have a different opinion :)

Changing references to be the DOE Capability makes sense to me to me
though may be worth a one line statement that each DOE capability
provides a single mailbox interface.

> 
> > Normally the kernel will want to maintain control of all of these
> > mailboxes.  However, under a limited number of use cases users may
> > want to allow user space access to some of these mailboxes while the
> > kernel retains control of the rest.  
> 
> Is there something in this patch related to user-space vs kernel
> control of things?  To me this patch looks like "for every DOE
> Capability on a device, create an auxiliary device and try to attach
> an auxiliary device driver to it."

Only the 'unbind' and access it directly (setpci etc) route.
These section of commentary was introduced because some people felt
we needed a standard way to do that unbind - that's one of the main
arguments in favour of using an auxbus as I understand it.

> 
> If part of creating the auxiliary devices is adding things in sysfs, I
> think it would be useful to mention that here.

The sysfs side of things is protocol specific. We dropped the plan
to have a generic interface. It will add a device though, with basic
controls, so good to call that out here (it's mentioned in a later
patch description).

> 
> > An example of this is for CXL Compliance Testing (see CXL 2.0
> > 14.16.4 Compliance Mode DOE) which offers a mechanism to set
> > different test modes for a device.  
> 
> Not sure exactly what this contributes here.  I guess you're saying
> you might want user-space access to this, but I don't see anything in
> this patch related to that.

Again, was part of the requirement raised to allow unbinding of the
DOE driver. Don't need to mention specifics here though so I'd be
fine with dropping this text.

> 
> > Rather than re-invent the wheel the architecture creates auxiliary
> > devices for each DOE mailbox which can then be driven by a generic
> > DOE mailbox driver.  If access to an individual mailbox is required
> > by user space the driver for that mailbox can be unloaded and access
> > handed to user space.  
> 
> IIUC a device can have several DOE Capabilities, and each Capability
> can support several protocols.  So I would think the granularity might
> be "protocol" rather than "mailbox" (DOE Capability).

The granularity of whether to have control from a driver or not has
to be at the capability level, because we need to mediate access
to the capability, not the protocol (that may need additional mediation,
but that's a problem for whatever controls the capability).
So either the capability is in control of userspace, or it is in control
of kernel.

> 
> But either way this text seems like it would go with a different patch
> since this patch has nothing to specify a particular protocol or even
> a particular mailbox/DOE Capability.
> 
> > Create the helper pci_doe_create_doe_devices() which iterates each DOE
> > mailbox found in the device and creates a DOE auxiliary device on the
> > auxiliary bus.  While doing so ensure that the auxiliary DOE driver
> > loads to drive that device.  
> 
> Here's a case where "iterating over DOE mailboxes found in the device"
> is slightly abstract.  The code obviously iterates over DOE
> *Capabilities* (PCI_EXT_CAP_ID_DOE), and that's something I can easily
> find in the spec.
> 
> Knowing that this is a PCIe Capability is useful because it puts it in
> the context of other capabilities ("optional things that live in
> config space") and the mechanisms for synchronization and user-space
> access.

Agreed.

> 
> > +/**
> > + * pci_doe_create_doe_devices - Create auxiliary DOE devices for all DOE
> > + *                              mailboxes found
> > + * @pci_dev: The PCI device to scan for DOE mailboxes
> > + *
> > + * There is no coresponding destroy of these devices.  This function associates
> > + * the DOE auxiliary devices created with the pci_dev passed in.  That
> > + * association is device managed (devm_*) such that the DOE auxiliary device
> > + * lifetime is always greater than or equal to the lifetime of the pci_dev.  
> 
> This seems backwards.  What does it mean if the DOE aux dev lifetime
> is *greater* than that of the pci_dev?  Surely you can't access a PCI
> DOE Capability if the pci_dev is gone?

I think the description is inaccurate - the end of life is the same
as that of the PCI driver binding to the pci_dev.  It'll get cleared
up if that is unbound etc.


> 
> > + * RETURNS: 0 on success -ERRNO on failure.
> > + */
> > +int pci_doe_create_doe_devices(struct pci_dev *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	int irqs, rc;
> > +	u16 pos = 0;
> > +
> > +	/*
> > +	 * An implementation may support an unknown number of interrupts.
> > +	 * Assume that number is not that large and request them all.  
> 
> This doesn't really inspire confidence :)  Playing devil's advocate,
> since pdev is an arbitrary device, I would assume the number *is*
> large.

Thomas's recent series on enabling expanding msi-X vectors after enabling
msi-X may be useful.

https://lore.kernel.org/linux-arm-kernel/20211210221642.869015045@linutronix.de/
  
But as I understand it that is still a work in progress and only applies
to MSI-X anwyay.

Perhaps we are better off just making this the callers problem and
documenting that MSI or MSI-X must be enabled and vectors requested
before we call this function.

> 
> > +	irqs = pci_msix_vec_count(pdev);
> > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);  
> 
> pci_msix_vec_count() is apparently sort of discouraged; see
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/msi-howto.rst?id=v5.16#n179

We can just pass in INT_MAX then if we want the maximum available.

> 
> A DOE Capability may be implemented by any device, e.g., a NIC or
> storage HBA, etc.  I'm a little queasy about IRQ alloc happening both
> here and in the driver for the device's primary functionality.  Can
> you reassure me that this is actually OK and safe?

> Sorry if I've asked this before.  If I have, perhaps a comment would
> be useful.

I went looking and earlier versions (pre Aux bus) made these calls in
the main driver before calling the DOE specific element.  So I don't think this came up
in previous reviews.

> 
> > +	if (rc != irqs) {
> > +		/* No interrupt available - carry on */
> > +		pci_dbg(pdev, "No interrupts available for DOE\n");
> > +	} else {
> > +		/*
> > +		 * Enabling bus mastering is require for MSI/MSIx.  It could be  
> 
> s/require/required/
> s/MSIx/MSI-X/ to match spec usage.
> 
> But I think you only support MSI-X, since you passed "PCI_IRQ_MSIX", not
> "PCI_IRQ_MSI | PCI_IRQ_MSIX" above?

Good point. I think it should be both.

> 
> > +		 * done later within the DOE initialization, but as it
> > +		 * potentially has other impacts keep it here when setting up
> > +		 * the IRQ's.  
> 
> s/IRQ's/IRQs/
> 
> "Potentially has other impacts" is too vague, and this doesn't explain
> why bus mastering should be enabled here rather than later.  The
> device should not issue an MSI-X until DOE Interrupt Enable is set, so
> near there seems like a logical place.

I can't remember what lead to that comment so hopefully moving to just
before the enable would be fine - if there was somewhere to do it.
I'm not sure there is as the IRQ enable is in the Auxilliary
Bus driver.  If we pull the pci_alloc_irq_vectors() out of here
into the caller, then the pci_set_master() should go with it.


> 
> > +		 */
> > +		pci_set_master(pdev);
> > +		rc = devm_add_action_or_reset(dev,
> > +					      pci_doe_free_irq_vectors,
> > +					      pdev);
> > +		if (rc)
> > +			return rc;
> > +	}  
> 
> > +++ b/include/linux/pci-doe.h
> > @@ -13,6 +13,8 @@
> >  #ifndef LINUX_PCI_DOE_H
> >  #define LINUX_PCI_DOE_H
> >  
> > +#define DOE_DEV_NAME "doe"  
> 
> This is only used once, above.  Why not just use the string there
> directly and skip the #define?  If it's needed elsewhere eventually,
> we can add a #define then.
> 
> Bjorn

