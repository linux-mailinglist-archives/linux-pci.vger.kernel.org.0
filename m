Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6175B3CC22B
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jul 2021 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbhGQJeC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Jul 2021 05:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhGQJeC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jul 2021 05:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626514265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qpkQ64ZywmmGid3wm2wpO4W6jPhvZtPWa6GAG8VtSbo=;
        b=RPeTG1xP0ojA65g4BwQEHk70btfaozScT7QM38tKz4DBfopf/lBREQupUbbbknXGejDSt0
        zSqo0nj0g3d0sm4mW6XKodOjJZ9O+1bHPiJBPp5P67UB5ejquHNiFiUaC4cRRfkxkwpwY2
        oJBA8oHz2Fwl8qPhuPZ4AByP/cW3xYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-fkIVUY3gMrKMjaSGLm28wg-1; Sat, 17 Jul 2021 05:31:03 -0400
X-MC-Unique: fkIVUY3gMrKMjaSGLm28wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3B8100B3AC;
        Sat, 17 Jul 2021 09:31:00 +0000 (UTC)
Received: from T590 (ovpn-12-83.pek2.redhat.com [10.72.12.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DC6360C0F;
        Sat, 17 Jul 2021 09:30:48 +0000 (UTC)
Date:   Sat, 17 Jul 2021 17:30:43 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <YPKjQxZ4roigdvbq@T590>
References: <20210715120844.636968-2-ming.lei@redhat.com>
 <20210716200154.GA2113453@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716200154.GA2113453@bjorn-Precision-5520>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 16, 2021 at 03:01:54PM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 15, 2021 at 08:08:42PM +0800, Ming Lei wrote:
> > irq vector allocation with managed affinity may be used by driver, and
> > blk-mq needs this info because managed irq will be shutdown when all
> > CPUs in the affinity mask are offline.
> > 
> > The info of using managed irq is often produced by drivers(pci subsystem,
> 
> Add space between "drivers" and "(".
> s/pci/PCI/

OK.

> 
> Does this "managed IRQ" (or "managed affinity", not sure what the
> correct terminology is here) have something to do with devm?
> 
> > platform device, ...), and it is consumed by blk-mq, so different subsystems
> > are involved in this info flow
> 
> Add period at end of sentence.

OK.

> 
> > Address this issue by adding one field of .irq_affinity_managed into
> > 'struct device'.
> > 
> > Suggested-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/base/platform.c | 7 +++++++
> >  drivers/pci/msi.c       | 3 +++
> >  include/linux/device.h  | 1 +
> >  3 files changed, 11 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 8640578f45e9..d28cb91d5cf9 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
> >  				ptr->irq[i], ret);
> >  			goto err_free_desc;
> >  		}
> > +
> > +		/*
> > +		 * mark the device as irq affinity managed if any irq affinity
> > +		 * descriptor is managed
> > +		 */
> > +		if (desc[i].is_managed)
> > +			dev->dev.irq_affinity_managed = true;
> >  	}
> >  
> >  	devres_add(&dev->dev, ptr);
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 3d6db20d1b2b..7ddec90b711d 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> >  	if (flags & PCI_IRQ_AFFINITY) {
> >  		if (!affd)
> >  			affd = &msi_default_affd;
> > +		dev->dev.irq_affinity_managed = true;
> 
> This is really opaque to me.  I can't tell what the connection between
> PCI_IRQ_AFFINITY and irq_affinity_managed is.

Comment for PCI_IRQ_AFFINITY is 'Auto-assign affinity',
'irq_affinity_managed' basically means that irq's affinity is managed by
kernel.

What blk-mq needs is exactly if PCI_IRQ_AFFINITY is applied when
allocating irq vectors. When PCI_IRQ_AFFINITY is used, genirq will
shutdown the irq when all CPUs in the assigned affinity are offline,
then blk-mq has to drain all in-flight IOs which will be completed
via this irq and prevent new IO. That is the connection.

Or you think 'irq_affinity_managed' isn't named well?

> 
> AFAICT the only place irq_affinity_managed is ultimately used is
> blk_mq_hctx_notify_offline(), and there's no obvious connection
> between that and this code.

I believe the connection is described in comment.


Thanks, 
Ming

