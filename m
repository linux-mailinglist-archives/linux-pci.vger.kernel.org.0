Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9943D0630
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 02:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhGTXtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 19:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhGTXtg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 19:49:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42F1960BBB;
        Wed, 21 Jul 2021 00:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626827413;
        bh=oA6LUVtEtIPCXpJhxFUKzyM7hTN95PCWkcpLTJ+YT4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pbmtrLNrkZYFQkdU0kuOtTOeJfzUKbGu52QkdgdAuMv3fn9SroY+iz6gdFUVG5Yb/
         enLzZ04deMTAR7bQPV3QY6J8+qIRDfmA/uh3OPf2cldVkua5juXwId6NUJv6mKE6AH
         oS3g8bpcwuPWqhf5+Z4fzvdcsAkjAvMVQ09gqUREW/mElhJwEjl/2b/gG6+NR4seRZ
         jieHyIu3xrHenFcCoHFtTCgnAIC/Mg13pMqC4O7czpnFnTpi0/bS6VwNCH4ILcmdYf
         HWx+Mm8FgbuzFoPHj2djpLNP+S+CtX3V6thz08cJPHdhWZ/2JT4pF7W+gdv32zjUlG
         twPnb45fzlmyg==
Date:   Tue, 20 Jul 2021 19:30:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <20210721003011.GA144876@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPKjQxZ4roigdvbq@T590>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 17, 2021 at 05:30:43PM +0800, Ming Lei wrote:
> On Fri, Jul 16, 2021 at 03:01:54PM -0500, Bjorn Helgaas wrote:
> > On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> > > irq vector allocation with managed affinity may be used by driver, and
> > > blk-mq needs this info because managed irq will be shutdown when all
> > > CPUs in the affinity mask are offline.
> > > 
> > > The info of using managed irq is often produced by drivers(pci subsystem,
> > 
> > Add space between "drivers" and "(".
> > s/pci/PCI/
> 
> OK.
> 
> > Does this "managed IRQ" (or "managed affinity", not sure what the
> > correct terminology is here) have something to do with devm?
> > 
> > > platform device, ...), and it is consumed by blk-mq, so different subsystems
> > > are involved in this info flow
> > 
> > Add period at end of sentence.
> 
> OK.
> 
> > > Address this issue by adding one field of .irq_affinity_managed into
> > > 'struct device'.
> > > 
> > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  drivers/base/platform.c | 7 +++++++
> > >  drivers/pci/msi.c       | 3 +++
> > >  include/linux/device.h  | 1 +
> > >  3 files changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > > index 8640578f45e9..d28cb91d5cf9 100644
> > > --- a/drivers/base/platform.c
> > > +++ b/drivers/base/platform.c
> > > @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
> > >  				ptr->irq[i], ret);
> > >  			goto err_free_desc;
> > >  		}
> > > +
> > > +		/*
> > > +		 * mark the device as irq affinity managed if any irq affinity
> > > +		 * descriptor is managed
> > > +		 */
> > > +		if (desc[i].is_managed)
> > > +			dev->dev.irq_affinity_managed = true;
> > >  	}
> > >  
> > >  	devres_add(&dev->dev, ptr);
> > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > index 3d6db20d1b2b..7ddec90b711d 100644
> > > --- a/drivers/pci/msi.c
> > > +++ b/drivers/pci/msi.c
> > > @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> > >  	if (flags & PCI_IRQ_AFFINITY) {
> > >  		if (!affd)
> > >  			affd = &msi_default_affd;
> > > +		dev->dev.irq_affinity_managed = true;
> > 
> > This is really opaque to me.  I can't tell what the connection between
> > PCI_IRQ_AFFINITY and irq_affinity_managed is.
> 
> Comment for PCI_IRQ_AFFINITY is 'Auto-assign affinity',
> 'irq_affinity_managed' basically means that irq's affinity is managed by
> kernel.
> 
> What blk-mq needs is exactly if PCI_IRQ_AFFINITY is applied when
> allocating irq vectors. When PCI_IRQ_AFFINITY is used, genirq will
> shutdown the irq when all CPUs in the assigned affinity are offline,
> then blk-mq has to drain all in-flight IOs which will be completed
> via this irq and prevent new IO. That is the connection.
> 
> Or you think 'irq_affinity_managed' isn't named well?

I've been looking at "devm" management where there is a concept of
devm-managed IRQs, and you mentioned "managed IRQ" in the commit log.
But IIUC this is a completely different sort of management.

> > AFAICT the only place irq_affinity_managed is ultimately used is
> > blk_mq_hctx_notify_offline(), and there's no obvious connection
> > between that and this code.
> 
> I believe the connection is described in comment.

You mean the comment that says "hctx needn't to be deactivated in case
managed irq isn't used"?  Sorry, that really doesn't explain to me why
pci_alloc_irq_vectors_affinity() needs to set irq_affinity_managed.
There's just a lot of magic here that cannot be deduced by reading the
code.

Nit: s/needn't to be/needn't be/ in that comment.  Or maybe even
"Deactivate hctx only when managed IRQ is used"?  I still have no idea
what that means, but at least it's easier to read :)  Or maybe this is
actually "draining a queue" instead of "deactivating"?

Bjorn
