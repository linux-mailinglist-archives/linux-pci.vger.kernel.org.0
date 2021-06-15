Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D83A89EE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 22:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFOUGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 16:06:52 -0400
Received: from verein.lst.de ([213.95.11.211]:51041 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFOUGw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 16:06:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA58368B05; Tue, 15 Jun 2021 22:04:43 +0200 (CEST)
Date:   Tue, 15 Jun 2021 22:04:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for
 (re)calculating interrupt sets
Message-ID: <20210615200443.GA6557@lst.de>
References: <20190216172228.512444498@linutronix.de> <20210615195707.GA2909907@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615195707.GA2909907@bjorn-Precision-5520>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 15, 2021 at 02:57:07PM -0500, Bjorn Helgaas wrote:
> On Sat, Feb 16, 2019 at 06:13:09PM +0100, Thomas Gleixner wrote:
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > The interrupt affinity spreading mechanism supports to spread out
> > affinities for one or more interrupt sets. A interrupt set contains one or
> > more interrupts. Each set is mapped to a specific functionality of a
> > device, e.g. general I/O queues and read I/O queus of multiqueue block
> > devices.
> > 
> > The number of interrupts per set is defined by the driver. It depends on
> > the total number of available interrupts for the device, which is
> > determined by the PCI capabilites and the availability of underlying CPU
> > resources, and the number of queues which the device provides and the
> > driver wants to instantiate.
> > 
> > The driver passes initial configuration for the interrupt allocation via a
> > pointer to struct irq_affinity.
> > 
> > Right now the allocation mechanism is complex as it requires to have a loop
> > in the driver to determine the maximum number of interrupts which are
> > provided by the PCI capabilities and the underlying CPU resources.  This
> > loop would have to be replicated in every driver which wants to utilize
> > this mechanism. That's unwanted code duplication and error prone.
> > 
> > In order to move this into generic facilities it is required to have a
> > mechanism, which allows the recalculation of the interrupt sets and their
> > size, in the core code. As the core code does not have any knowledge about the
> > underlying device, a driver specific callback is required in struct
> > irq_affinity, which can be invoked by the core code. The callback gets the
> > number of available interupts as an argument, so the driver can calculate the
> > corresponding number and size of interrupt sets.
> > 
> > At the moment the struct irq_affinity pointer which is handed in from the
> > driver and passed through to several core functions is marked 'const', but for
> > the callback to be able to modify the data in the struct it's required to
> > remove the 'const' qualifier.
> > 
> > Add the optional callback to struct irq_affinity, which allows drivers to
> > recalculate the number and size of interrupt sets and remove the 'const'
> > qualifier.
> > 
> > For simple invocations, which do not supply a callback, a default callback
> > is installed, which just sets nr_sets to 1 and transfers the number of
> > spreadable vectors to the set_size array at index 0.
> > 
> > This is for now guarded by a check for nr_sets != 0 to keep the NVME driver
> > working until it is converted to the callback mechanism.
> > 
> > To make sure that the driver configuration is correct under all circumstances
> > the callback is invoked even when there are no interrupts for queues left,
> > i.e. the pre/post requirements already exhaust the numner of available
> > interrupts.
> > 
> > At the PCI layer irq_create_affinity_masks() has to be invoked even for the
> > case where the legacy interrupt is used. That ensures that the callback is
> > invoked and the device driver can adjust to that situation.
> > 
> > [ tglx: Fixed the simple case (no sets required). Moved the sanity check
> >   	for nr_sets after the invocation of the callback so it catches
> >   	broken drivers. Fixed the kernel doc comments for struct
> >   	irq_affinity and de-'This patch'-ed the changelog ]
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> > @@ -1196,6 +1196,13 @@ int pci_alloc_irq_vectors_affinity(struc
> >  	/* use legacy irq if allowed */
> >  	if (flags & PCI_IRQ_LEGACY) {
> >  		if (min_vecs == 1 && dev->irq) {
> > +			/*
> > +			 * Invoke the affinity spreading logic to ensure that
> > +			 * the device driver can adjust queue configuration
> > +			 * for the single interrupt case.
> > +			 */
> > +			if (affd)
> > +				irq_create_affinity_masks(1, affd);
> 
> This looks like a leak because irq_create_affinity_masks() returns a
> pointer to kcalloc()ed space, but we throw away the pointer.
> 
> Or is there something very subtle going on here, like this special
> case doesn't allocate anything?  I do see the "Nothing to assign?"
> case that returns NULL with no alloc, but it's not completely trivial
> to verify that we take that case here.
> 
> >  			pci_intx(dev, 1);
> >  			return 1;
> >  		}
---end quoted text---
