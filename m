Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58764455031
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 23:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241063AbhKQWSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 17:18:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241020AbhKQWSg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Nov 2021 17:18:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B69961B39;
        Wed, 17 Nov 2021 22:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637187337;
        bh=pz9u+Rr/Rm1PkxcOKHWRWOjVj9iL6xXGwQ0FX4HJdQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CBfSI8+kPxXtYUTMTdk+21jYnWy1mdDwK55lHA9qzgwVL1lMWfjf2z4TiFxErxdJg
         hTMDiBIv6fc/1orjg78O9BXAu7MsFRabAr9uE7OXLR7y5rD8mQyp2odvTxNH8WdRY2
         xhc2kqsXkpiaxKJD1t6hP5NGNPYU0dRnURNp1g4aO7c8b5WyuTTFW3AB2+o7DnVUG4
         o/JBRl8JNrFqNQka1JkqT46Mot93fNMG2KTPjomF1FXg/37xN3HHP7LRn8m1nZnqdC
         SYwGguiMupYnmjzVOlc6xwPu/1553wk3yFBol0oRnXA7Vo+WDAznNTQM1AFuwGa7pX
         HUJm0t6u0EAwA==
Date:   Wed, 17 Nov 2021 16:15:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211117221536.GA1778765@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117122335.00000b35@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, Thomas for INTx/MSI/bus mastering question below]

On Wed, Nov 17, 2021 at 12:23:35PM +0000, Jonathan Cameron wrote:
> On Tue, 16 Nov 2021 17:48:29 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Nov 05, 2021 at 04:50:54PM -0700, ira.weiny@intel.com wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > CXL devices have DOE mailboxes.  Create auxiliary devices which can be
> > > driven by the generic DOE auxiliary driver.  

> > Based on the ECN, it sounds like any PCI device can have DOE
> > capabilities, so I suspect the support for it should be in
> > drivers/pci/, not drivers/cxl/.  I don't really see anything
> > CXL-specific below.
> 
> Agreed though how it all gets tied together isn't totally clear
> to me yet. The messy bit is interrupts given I don't think we have
> a model for enabling those anywhere other than in individual PCI drivers.

Ah.  Yeah, that is a little messy.  The only real precedent where the
PCI core and a driver might need to coordinate on interrupts is the
portdrv.  So far we've pretended that bridges do not have
device-specific functionality that might require interrupts.  I don't
think that's actually true, but we haven't integrated drivers for the
tuning, performance monitoring, and similar features that bridges may
have.  Yet.

In any case, I think the argument that DOE capabilities are not
CXL-specific still holds.

> > What do these DOE capabilities look like in lspci?  I don't see any
> > support in the current version (which looks like it's a year old).
> 
> I don't think anyone has added support yet, but it would be simple to do.
> Given possibility of breaking things if we actually exercise the discovery
> protocol, we'll be constrained to just reporting there is a DOE instances
> which is of limited use.

I think it's essential that lspci at least show the existence of DOE
capabilities and the safe-to-read registers (Capabilities, Control,
Status).

There's a very long lead time between adding the support and getting
updated versions of lspci into distros.

> > > +	 * An implementation of a cxl type3 device may support an unknown
> > > +	 * number of interrupts. Assume that number is not that large and
> > > +	 * request them all.
> > > +	 */
> > > +	irqs = pci_msix_vec_count(pdev);
> > > +	rc = pci_alloc_irq_vectors(pdev, irqs, irqs, PCI_IRQ_MSIX);
> > > +	if (rc != irqs) {
> > > +		/* No interrupt available - carry on */
> > > +		dev_dbg(dev, "No interrupts available for DOE\n");
> > > +	} else {
> > > +		/*
> > > +		 * Enabling bus mastering could be done within the DOE
> > > +		 * initialization, but as it potentially has other impacts
> > > +		 * keep it within the driver.
> > > +		 */
> > > +		pci_set_master(pdev);  
> > 
> > This enables the device to perform DMA, which doesn't seem to have
> > anything to do with the rest of this code.  Can it go somewhere
> > near something to do with DMA?
> 
> Needed for MSI/MSIx as well.  The driver doesn't do DMA for anything
> else.  Hence it's here in the interrupt enable path.

Oh, right, of course.  A hint here that MSI/MSI-X depends on bus
mastering would save me the trouble.

I wonder if the infrastructure, e.g., something inside
pci_alloc_irq_vectors_affinity() should do this for us.  The
connection is "obvious" but not mentioned in
Documentation/PCI/msi-howto.rst and I'm not sure how callers that
supply PCI_IRQ_ALL_TYPES would know whether they got a single MSI
vector (which requires bus mastering) or an INTx vector (which does
not).

> > So we get an auxiliary device for every instance of a DOE
> > capability?  I think the commit log should mention something about
> > how many are created (e.g., "one per DOE capability"), how they
> > are named, whether they appear in sysfs, how drivers bind to them,
> > etc.
> > 
> > I assume there needs to be some coordination between possible
> > multiple users of a DOE capability?  How does that work?
> 
> The DOE handling implementation makes everything synchronous - so if
> multiple users each may have to wait on queueing their query /
> responses exchanges.
> 
> The fun of non OS software accessing these is still an open
> question.

Sounds like something that potentially could be wrapped up in a safe
but slow interface that could be usable by others, including lspci?

Bjorn
