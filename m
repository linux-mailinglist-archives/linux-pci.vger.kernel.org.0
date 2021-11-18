Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25064455973
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 11:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343530AbhKRKzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Nov 2021 05:55:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4103 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbhKRKzB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 05:55:01 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HvxRk2L3tz67bxx;
        Thu, 18 Nov 2021 18:51:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 18 Nov 2021 11:51:58 +0100
Received: from localhost (10.52.127.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 18 Nov
 2021 10:51:57 +0000
Date:   Thu, 18 Nov 2021 10:51:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211118105155.00005eab@Huawei.com>
In-Reply-To: <20211117221536.GA1778765@bhelgaas>
References: <20211117122335.00000b35@Huawei.com>
        <20211117221536.GA1778765@bhelgaas>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.127.148]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Nov 2021 16:15:36 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Christoph, Thomas for INTx/MSI/bus mastering question below]
> 
> On Wed, Nov 17, 2021 at 12:23:35PM +0000, Jonathan Cameron wrote:
> > On Tue, 16 Nov 2021 17:48:29 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:  
> > > On Fri, Nov 05, 2021 at 04:50:54PM -0700, ira.weiny@intel.com wrote:  
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > 
> > > > CXL devices have DOE mailboxes.  Create auxiliary devices which can be
> > > > driven by the generic DOE auxiliary driver.    
> 
> > > Based on the ECN, it sounds like any PCI device can have DOE
> > > capabilities, so I suspect the support for it should be in
> > > drivers/pci/, not drivers/cxl/.  I don't really see anything
> > > CXL-specific below.  
> > 
> > Agreed though how it all gets tied together isn't totally clear
> > to me yet. The messy bit is interrupts given I don't think we have
> > a model for enabling those anywhere other than in individual PCI drivers.  
> 
> Ah.  Yeah, that is a little messy.  The only real precedent where the
> PCI core and a driver might need to coordinate on interrupts is the
> portdrv.  So far we've pretended that bridges do not have
> device-specific functionality that might require interrupts.  I don't
> think that's actually true, but we haven't integrated drivers for the
> tuning, performance monitoring, and similar features that bridges may
> have.  Yet.

Upstream ports of CXL switches will have DOE / CDAT - though no one has
one yet and we haven't emulated one in QEMU either yet (will do that shortly).
Also CMA (IDE possibly) will be a requirement for switches soon.  Still all that
stuff is at least in various specs, so can probably fit in the existing port-drv
framework.

I dropped work on our RP / portdrv PMU from a few years back because we broke the
hardware out as a separate RCiEP.  Hacking custom support into portdrv wasn't
pretty IIRC. 

> 
> In any case, I think the argument that DOE capabilities are not
> CXL-specific still holds.

Agreed.

> 
> > > What do these DOE capabilities look like in lspci?  I don't see any
> > > support in the current version (which looks like it's a year old).  
> > 
> > I don't think anyone has added support yet, but it would be simple to do.
> > Given possibility of breaking things if we actually exercise the discovery
> > protocol, we'll be constrained to just reporting there is a DOE instances
> > which is of limited use.  
> 
> I think it's essential that lspci at least show the existence of DOE
> capabilities and the safe-to-read registers (Capabilities, Control,
> Status).
> 
> There's a very long lead time between adding the support and getting
> updated versions of lspci into distros.

I'll add lspci support to my todo list.

> 
> > > > +	 * An implementation of a cxl type3 device may support an unknown
> > > > +	 * number of interrupts. Assume that number is not that large and
> > > > +	 * request them all.
> > > > +	 */
> > > > +	irqs = pci_msix_vec_count(pdev);
> > > > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
> > > > +	if (rc != irqs) {
> > > > +		/* No interrupt available - carry on */
> > > > +		dev_dbg(dev, "No interrupts available for DOE\n");
> > > > +	} else {
> > > > +		/*
> > > > +		 * Enabling bus mastering could be done within the DOE
> > > > +		 * initialization, but as it potentially has other impacts
> > > > +		 * keep it within the driver.
> > > > +		 */
> > > > +		pci_set_master(pdev);    
> > > 
> > > This enables the device to perform DMA, which doesn't seem to have
> > > anything to do with the rest of this code.  Can it go somewhere
> > > near something to do with DMA?  
> > 
> > Needed for MSI/MSIx as well.  The driver doesn't do DMA for anything
> > else.  Hence it's here in the interrupt enable path.  
> 
> Oh, right, of course.  A hint here that MSI/MSI-X depends on bus
> mastering would save me the trouble.

Ira, please add a comment when you respin.  Thanks!

> 
> I wonder if the infrastructure, e.g., something inside
> pci_alloc_irq_vectors_affinity() should do this for us.  The
> connection is "obvious" but not mentioned in
> Documentation/PCI/msi-howto.rst and I'm not sure how callers that
> supply PCI_IRQ_ALL_TYPES would know whether they got a single MSI
> vector (which requires bus mastering) or an INTx vector (which does
> not).

I wonder if there are devices that drivers that deliberately delay
the pci_set_master() until more stuff is set up.  I'd hope no device
is broken enough that it would matter, but 'maybe'?

In this particular case we don't run into the what type of interrupt
question as the spec requires MSI / MSIX but agreed that could be
a problem more generally.

I wonder how many types of EP actually have interrupts but no DMA though?
There are the memory buffers used for some types of P2P + the bridges you
mention.

> 
> > > So we get an auxiliary device for every instance of a DOE
> > > capability?  I think the commit log should mention something about
> > > how many are created (e.g., "one per DOE capability"), how they
> > > are named, whether they appear in sysfs, how drivers bind to them,
> > > etc.
> > > 
> > > I assume there needs to be some coordination between possible
> > > multiple users of a DOE capability?  How does that work?  
> > 
> > The DOE handling implementation makes everything synchronous - so if
> > multiple users each may have to wait on queueing their query /
> > responses exchanges.
> > 
> > The fun of non OS software accessing these is still an open
> > question.  
> 
> Sounds like something that potentially could be wrapped up in a safe
> but slow interface that could be usable by others, including lspci?

So one version of this patch set had a generic IOCTL interface, but
discussions around that (we also briefly touched on it at the plumbers
microconf) were heading in the direction of protocol specific interfaces.

If we put that back we'd need a more complex means of controlling access,
possibly only allowing the discovery protocols.
The problem is some protocols have strict ordering requirements so exposing
anything close to raw access could for example let userspace break establishment of
secure channels or collapse an existing secure channel.

A simple answer might be to have the DOE driver expose the discovered protocols
via sysfs.  I don't think they will change over time so simply caching them
at first load should be fine.

Jonathan

> 
> Bjorn

