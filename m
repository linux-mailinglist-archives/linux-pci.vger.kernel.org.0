Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DB1456A63
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 07:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhKSGvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 01:51:36 -0500
Received: from verein.lst.de ([213.95.11.211]:50013 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhKSGvf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 01:51:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1F3EA68AFE; Fri, 19 Nov 2021 07:48:31 +0100 (CET)
Date:   Fri, 19 Nov 2021 07:48:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        ira.weiny@intel.com, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/5] cxl/pci: Add DOE Auxiliary Devices
Message-ID: <20211119064830.GA15425@lst.de>
References: <20211117122335.00000b35@Huawei.com> <20211117221536.GA1778765@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117221536.GA1778765@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 04:15:36PM -0600, Bjorn Helgaas wrote:
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

And portdrv really is conceptually part of the core PCI core, and
should eventually be fully integrated..

> In any case, I think the argument that DOE capabilities are not
> CXL-specific still holds.

Agreed.

> Oh, right, of course.  A hint here that MSI/MSI-X depends on bus
> mastering would save me the trouble.
> 
> I wonder if the infrastructure, e.g., something inside
> pci_alloc_irq_vectors_affinity() should do this for us.  The
> connection is "obvious" but not mentioned in
> Documentation/PCI/msi-howto.rst and I'm not sure how callers that
> supply PCI_IRQ_ALL_TYPES would know whether they got a single MSI
> vector (which requires bus mastering) or an INTx vector (which does
> not).

As a minimum step we should document that this.  That being said
I don't tink we can just make the interrupt API call pci_set_master
as there might be strange ordering requirements in the drivers.

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

I guess we have to.  I think this interface is a nightmare.  Why o why
does the PCI SGI keep doing these stupid things (see also VPDs).
