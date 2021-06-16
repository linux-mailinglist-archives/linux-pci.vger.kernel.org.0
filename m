Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283F13A8DC3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 02:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhFPAml (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 20:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231792AbhFPAmk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 20:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623804034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=327NKSVoyLXkfvSgIC6wSAcEEzB6rOENlygol386mU8=;
        b=H1AXN8Na7VFbz6T/oxHoThve5uNLxrQbvKg5o8fuKIbLQ4I+cOBVDMgIH5X7ZLgH3mlJQV
        tIvOlTglEf6KyKwDob54SMuHcipS6myh7lsWOsgYL+rgcbP8KR666dh7pXkAqqsHv/HLit
        eYDTqTm1HEFRvkgBhW2XTkERIQtqt80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-8DNMEgDgOeeiz8UMqMeYGQ-1; Tue, 15 Jun 2021 20:40:30 -0400
X-MC-Unique: 8DNMEgDgOeeiz8UMqMeYGQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF3F71084F41;
        Wed, 16 Jun 2021 00:40:28 +0000 (UTC)
Received: from T590 (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AAA76620DE;
        Wed, 16 Jun 2021 00:40:18 +0000 (UTC)
Date:   Wed, 16 Jun 2021 08:40:14 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: Re: [patch v6 3/7] genirq/affinity: Add new callback for
 (re)calculating interrupt sets
Message-ID: <YMlIbt3EPyRJHNWf@T590>
References: <20190216172228.512444498@linutronix.de>
 <20210615195707.GA2909907@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615195707.GA2909907@bjorn-Precision-5520>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

The purpose is to provide chance to call ->calc_sets() for single
interrupt, maybe it can be improved by the following change:

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 217dc9f0231f..025c647279f5 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1223,8 +1223,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 * the device driver can adjust queue configuration
 			 * for the single interrupt case.
 			 */
-			if (affd)
-				irq_create_affinity_masks(1, affd);
+			irq_affinity_calc_sets_legacy(affd);
 			pci_intx(dev, 1);
 			return 1;
 		}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850a6dc7..f21f93ce460b 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -368,6 +368,7 @@ irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
 
 unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 				       const struct irq_affinity *affd);
+void irq_affinity_calc_sets_legacy(struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
@@ -419,6 +420,10 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	return maxvec;
 }
 
+static inline void irq_affinity_calc_sets_legacy(struct irq_affinity *affd)
+{
+}
+
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3b..d01f7dfa5712 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -405,6 +405,30 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 	affd->set_size[0] = affvecs;
 }
 
+static void irq_affinity_calc_sets(unsigned int affvecs,
+		struct irq_affinity *affd)
+{
+	/*
+	 * Simple invocations do not provide a calc_sets() callback. Install
+	 * the generic one.
+	 */
+	if (!affd->calc_sets)
+		affd->calc_sets = default_calc_sets;
+
+	/* Recalculate the sets */
+	affd->calc_sets(affd, affvecs);
+
+	WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS);
+}
+
+/* Provide a chance to call ->calc_sets for legacy */
+void irq_affinity_calc_sets_legacy(struct irq_affinity *affd)
+{
+	if (!affd)
+		return;
+	irq_affinity_calc_sets(0, affd);
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -429,17 +453,8 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	else
 		affvecs = 0;
 
-	/*
-	 * Simple invocations do not provide a calc_sets() callback. Install
-	 * the generic one.
-	 */
-	if (!affd->calc_sets)
-		affd->calc_sets = default_calc_sets;
-
-	/* Recalculate the sets */
-	affd->calc_sets(affd, affvecs);
-
-	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
+	irq_affinity_calc_sets(affvecs, affd);
+	if (affd->nr_sets > IRQ_AFFINITY_MAX_SETS)
 		return NULL;
 
 	/* Nothing to assign? */


Thanks, 
Ming

