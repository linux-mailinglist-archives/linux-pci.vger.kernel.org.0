Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E33CB0B1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 04:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhGPCNz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 22:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32070 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhGPCNz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 22:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626401460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8zdmS2M4AoTM5t3X/fMwAB/1VAR1KIWx0jJpvolmL7M=;
        b=YxeIh2EA3ufzrGhB+7D9r4eSGNt9MqHoHOzDgiJ9w++5vqubwC8BFkSx8lAvTDRvnXyyMw
        RipKQrTWtzZoOIO0iML/sgbE182BoDSTTa0P7um2sTuKKt8AVjoP6n2QfVul+zXaTb8zY0
        /t+sT1ITHYGufG2clR3nWXj9NQPJVd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-IsJbHE3hN3ypkj4lfJNgnw-1; Thu, 15 Jul 2021 22:10:59 -0400
X-MC-Unique: IsJbHE3hN3ypkj4lfJNgnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B44B18D6A2E;
        Fri, 16 Jul 2021 02:10:57 +0000 (UTC)
Received: from T590 (ovpn-13-153.pek2.redhat.com [10.72.13.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48F2C60C13;
        Fri, 16 Jul 2021 02:10:50 +0000 (UTC)
Date:   Fri, 16 Jul 2021 10:10:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] genirq/affinity: add helper of irq_affinity_calc_sets
Message-ID: <YPDqphXYXtkpcfch@T590>
References: <20210715111827.569756-1-ming.lei@redhat.com>
 <20210715142714.GA1957636@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715142714.GA1957636@bjorn-Precision-5520>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 09:27:14AM -0500, Bjorn Helgaas wrote:
> On Thu, Jul 15, 2021 at 07:18:27PM +0800, Ming Lei wrote:
> > When driver requests to allocate irq affinity managed vectors,
> > pci_alloc_irq_vectors_affinity() may fallback to single vector
> > allocation. In this situation, we don't need to call
> > irq_create_affinity_masks for calling into ->calc_sets() for
> > avoiding potential memory leak, so add the helper for this purpose.
> > 
> > Fixes: c66d4bd110a1 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/pci/msi.c         |  3 ++-
> >  include/linux/interrupt.h |  7 +++++++
> >  kernel/irq/affinity.c     | 29 ++++++++++++++++++-----------
> >  3 files changed, 27 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index 9232255c8515..3d6db20d1b2b 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -1224,7 +1224,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> >  			 * for the single interrupt case.
> >  			 */
> >  			if (affd)
> > -				irq_create_affinity_masks(1, affd);
> > +				WARN_ON_ONCE(irq_affinity_calc_sets(1, affd));
> 
> Hmmm.  Not sure I like this yet:
> 
>   - I prefer required code to be on its own, not hidden inside a
>     WARN() (personal preference, I know).
> 
>   - WARN() doesn't seem like the right thing here.  I think this
>     generates a backtrace but the driver that called this has no
>     indication.  Isn't the problem that a .calc_sets() method set
>     "affd->nr_sets > IRQ_AFFINITY_MAX_SETS"?

Yes. When the warning is triggered, memory corruption may have been caused,
not sure if the indication is needed.

> 
>     It looks like those methods are supplied by drivers
>     (nvme_calc_irq_sets(), csio_calc_sets()) and it seems like they
>     should find out about this somehow.

Yeah. The WARN() here is just to report the bug earlier.


Thanks, 
Ming

