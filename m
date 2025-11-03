Return-Path: <linux-pci+bounces-40139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7CC2DE60
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 20:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEF51897156
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 19:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287028507E;
	Mon,  3 Nov 2025 19:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a4OCmgtf"
X-Original-To: linux-pci@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ED6347C3;
	Mon,  3 Nov 2025 19:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762198037; cv=none; b=maqBmKclJka2saQOJVKWLs6E+7/P1+r8rEbILAnyzlUwCNndoTOQtUqGkn8sskNmA78kpa7TB02ur8oqFLNse7/EF3ubT6hS8YZEEzQTPkxbzdpgz6KRh3LY6vrZmy9+h9C9Wo4PiSz1heLKK63EzFW6mO3wdf6R8DCcFW/xH0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762198037; c=relaxed/simple;
	bh=NAUhLLt3/jTcnrppg7GdWFRrsyL86tZSX439YJgfZ7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeTeYNydcxPzAHn1YEBe2IfLKjUAFGu2jZslpGU6PhgE6QPnb6EuBLlOrL30+YBndDv/SMDIRD50Iz/N0K8nfrXTyKM8Mv5OZTzgnLORd/GG5aC0CPXLpXoug8KNXB7cVXlCzS2KvoH6/WJyeKNrwer3NgjHr0Y2U3zu/ceDrmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a4OCmgtf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4rjLSzb8k/TGHTsZ2ITxS6HP2I1FgybxEp8aEoJ0Ytg=; b=a4OCmgtfGVVDqfTa2zVXtrOq1h
	gKY63TN6QPA3TruMwd7EHhfeLaGwZjRw7Gxo9nJN/Ew+MkjPyKbcoO+t8u1EY6YK0eeQdAm2exf6C
	Vie2ibCMtk6dAN4bLvhIGvdWzFzkdViAo3Q8rxYFxdtnwlCDGjsgNOZGwlUgg6yL1Y39eyOzfbWfW
	1j/iGrve1uBGReH/XOMV9hTkBdrmPkt1qjUK0KaFeAsQKSuJT35Gni5z7FAnukzcDkpGhSh9Btb2q
	mCeteEhXKNP9YRt/sqvGZRZXecpgAh5WBh1ReaPz1lOu4tlTf+uPUjuK2S0t+7cnoMK2Z9IbI7W5a
	H0m2j4Pg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFzLA-0000000GB97-3dVR;
	Mon, 03 Nov 2025 18:31:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72A38300230; Mon, 03 Nov 2025 20:27:09 +0100 (CET)
Date: Mon, 3 Nov 2025 20:27:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI/aer_inject: Convert inject_lock to
 raw_spinlock_t
Message-ID: <20251103192709.GV1386988@noisy.programming.kicks-ass.net>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
 <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>

On Mon, Nov 03, 2025 at 08:21:20PM +0100, Peter Zijlstra wrote:
> On Sun, Nov 02, 2025 at 10:57:06AM +0000, Guangbo Cui wrote:
> > The AER injection path may run in interrupt-disabled context while
> > holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
> > sleeping lock, so it must not be taken while a raw_spinlock_t is held.
> > Doing so violates lock ordering rules and trigger lockdep reports
> > such as “Invalid wait context”.
> > 
> > Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
> > semantics. The protected list is bounded and used only for debugging,
> > so raw locking will not cause latency issues.
> 
> Bounded how?
> 

And

---
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -128,15 +128,14 @@ static struct pci_ops *__find_pci_bus_op
 
 static struct pci_bus_ops *pci_bus_ops_pop(void)
 {
-	unsigned long flags;
 	struct pci_bus_ops *bus_ops;
 
-	raw_spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	bus_ops = list_first_entry_or_null(&pci_bus_ops_list,
 					   struct pci_bus_ops, list);
 	if (bus_ops)
 		list_del(&bus_ops->list);
-	raw_spin_unlock_irqrestore(&inject_lock, flags);
+
 	return bus_ops;
 }
 
@@ -222,18 +221,18 @@ static int aer_inj_write(struct pci_bus
 static int aer_inj_read_config(struct pci_bus *bus, unsigned int devfn,
 			       int where, int size, u32 *val)
 {
-	u32 *sim;
 	struct aer_error *err;
-	unsigned long flags;
 	int domain;
-	int rv;
+	u32 *sim;
 
-	raw_spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	if (size != sizeof(u32))
 		goto out;
+
 	domain = pci_domain_nr(bus);
 	if (domain < 0)
 		goto out;
+
 	err = __find_aer_error(domain, bus->number, devfn);
 	if (!err)
 		goto out;
@@ -241,31 +240,29 @@ static int aer_inj_read_config(struct pc
 	sim = find_pci_config_dword(err, where, NULL);
 	if (sim) {
 		*val = *sim;
-		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
+
 out:
-	rv = aer_inj_read(bus, devfn, where, size, val);
-	raw_spin_unlock_irqrestore(&inject_lock, flags);
-	return rv;
+	return aer_inj_read(bus, devfn, where, size, val);
 }
 
 static int aer_inj_write_config(struct pci_bus *bus, unsigned int devfn,
 				int where, int size, u32 val)
 {
-	u32 *sim;
 	struct aer_error *err;
-	unsigned long flags;
-	int rw1cs;
 	int domain;
-	int rv;
+	int rw1cs;
+	u32 *sim;
 
-	raw_spin_lock_irqsave(&inject_lock, flags);
+	guard(raw_spinlock_irqsave)(&inject_lock);
 	if (size != sizeof(u32))
 		goto out;
+
 	domain = pci_domain_nr(bus);
 	if (domain < 0)
 		goto out;
+
 	err = __find_aer_error(domain, bus->number, devfn);
 	if (!err)
 		goto out;
@@ -276,13 +273,10 @@ static int aer_inj_write_config(struct p
 			*sim ^= val;
 		else
 			*sim = val;
-		raw_spin_unlock_irqrestore(&inject_lock, flags);
 		return 0;
 	}
 out:
-	rv = aer_inj_write(bus, devfn, where, size, val);
-	raw_spin_unlock_irqrestore(&inject_lock, flags);
-	return rv;
+	return aer_inj_write(bus, devfn, where, size, val);
 }
 
 static struct pci_ops aer_inj_pci_ops = {
@@ -301,22 +295,21 @@ static void pci_bus_ops_init(struct pci_
 
 static int pci_bus_set_aer_ops(struct pci_bus *bus)
 {
-	struct pci_ops *ops;
 	struct pci_bus_ops *bus_ops;
-	unsigned long flags;
+	struct pci_ops *ops;
 
 	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
 	if (!bus_ops)
 		return -ENOMEM;
 	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
-	raw_spin_lock_irqsave(&inject_lock, flags);
-	if (ops == &aer_inj_pci_ops)
-		goto out;
-	pci_bus_ops_init(bus_ops, bus, ops);
-	list_add(&bus_ops->list, &pci_bus_ops_list);
-	bus_ops = NULL;
-out:
-	raw_spin_unlock_irqrestore(&inject_lock, flags);
+
+	scoped_guard (raw_spinlock_irqsave, &inject_lock) {
+		if (ops == &aer_inj_pci_ops)
+			break;
+		pci_bus_ops_init(bus_ops, bus, ops);
+		list_add(&bus_ops->list, &pci_bus_ops_list);
+		bus_ops = NULL;
+	}
 	kfree(bus_ops);
 	return 0;
 }
@@ -388,69 +381,66 @@ static int aer_inject(struct aer_error_i
 				       uncor_mask);
 	}
 
-	raw_spin_lock_irqsave(&inject_lock, flags);
-
-	err = __find_aer_error_by_dev(dev);
-	if (!err) {
-		err = err_alloc;
-		err_alloc = NULL;
-		aer_error_init(err, einj->domain, einj->bus, devfn,
-			       pos_cap_err);
-		list_add(&err->list, &einjected);
-	}
-	err->uncor_status |= einj->uncor_status;
-	err->cor_status |= einj->cor_status;
-	err->header_log0 = einj->header_log0;
-	err->header_log1 = einj->header_log1;
-	err->header_log2 = einj->header_log2;
-	err->header_log3 = einj->header_log3;
-
-	if (!aer_mask_override && einj->cor_status &&
-	    !(einj->cor_status & ~cor_mask)) {
-		ret = -EINVAL;
-		pci_warn(dev, "The correctable error(s) is masked by device\n");
-		raw_spin_unlock_irqrestore(&inject_lock, flags);
-		goto out_put;
-	}
-	if (!aer_mask_override && einj->uncor_status &&
-	    !(einj->uncor_status & ~uncor_mask)) {
-		ret = -EINVAL;
-		pci_warn(dev, "The uncorrectable error(s) is masked by device\n");
-		raw_spin_unlock_irqrestore(&inject_lock, flags);
-		goto out_put;
-	}
-
-	rperr = __find_aer_error_by_dev(rpdev);
-	if (!rperr) {
-		rperr = rperr_alloc;
-		rperr_alloc = NULL;
-		aer_error_init(rperr, pci_domain_nr(rpdev->bus),
-			       rpdev->bus->number, rpdev->devfn,
-			       rp_pos_cap_err);
-		list_add(&rperr->list, &einjected);
-	}
-	if (einj->cor_status) {
-		if (rperr->root_status & PCI_ERR_ROOT_COR_RCV)
-			rperr->root_status |= PCI_ERR_ROOT_MULTI_COR_RCV;
-		else
-			rperr->root_status |= PCI_ERR_ROOT_COR_RCV;
-		rperr->source_id &= 0xffff0000;
-		rperr->source_id |= PCI_DEVID(einj->bus, devfn);
-	}
-	if (einj->uncor_status) {
-		if (rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV)
-			rperr->root_status |= PCI_ERR_ROOT_MULTI_UNCOR_RCV;
-		if (sever & einj->uncor_status) {
-			rperr->root_status |= PCI_ERR_ROOT_FATAL_RCV;
-			if (!(rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV))
-				rperr->root_status |= PCI_ERR_ROOT_FIRST_FATAL;
-		} else
-			rperr->root_status |= PCI_ERR_ROOT_NONFATAL_RCV;
-		rperr->root_status |= PCI_ERR_ROOT_UNCOR_RCV;
-		rperr->source_id &= 0x0000ffff;
-		rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
+	scoped_guard (raw_spinlock_irqsave, &inject_lock) {
+		err = __find_aer_error_by_dev(dev);
+		if (!err) {
+			err = err_alloc;
+			err_alloc = NULL;
+			aer_error_init(err, einj->domain, einj->bus, devfn,
+				       pos_cap_err);
+			list_add(&err->list, &einjected);
+		}
+		err->uncor_status |= einj->uncor_status;
+		err->cor_status |= einj->cor_status;
+		err->header_log0 = einj->header_log0;
+		err->header_log1 = einj->header_log1;
+		err->header_log2 = einj->header_log2;
+		err->header_log3 = einj->header_log3;
+
+		if (!aer_mask_override && einj->cor_status &&
+		    !(einj->cor_status & ~cor_mask)) {
+			ret = -EINVAL;
+			pci_warn(dev, "The correctable error(s) is masked by device\n");
+			goto out_put;
+		}
+		if (!aer_mask_override && einj->uncor_status &&
+		    !(einj->uncor_status & ~uncor_mask)) {
+			ret = -EINVAL;
+			pci_warn(dev, "The uncorrectable error(s) is masked by device\n");
+			goto out_put;
+		}
+
+		rperr = __find_aer_error_by_dev(rpdev);
+		if (!rperr) {
+			rperr = rperr_alloc;
+			rperr_alloc = NULL;
+			aer_error_init(rperr, pci_domain_nr(rpdev->bus),
+				       rpdev->bus->number, rpdev->devfn,
+				       rp_pos_cap_err);
+			list_add(&rperr->list, &einjected);
+		}
+		if (einj->cor_status) {
+			if (rperr->root_status & PCI_ERR_ROOT_COR_RCV)
+				rperr->root_status |= PCI_ERR_ROOT_MULTI_COR_RCV;
+			else
+				rperr->root_status |= PCI_ERR_ROOT_COR_RCV;
+			rperr->source_id &= 0xffff0000;
+			rperr->source_id |= PCI_DEVID(einj->bus, devfn);
+		}
+		if (einj->uncor_status) {
+			if (rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV)
+				rperr->root_status |= PCI_ERR_ROOT_MULTI_UNCOR_RCV;
+			if (sever & einj->uncor_status) {
+				rperr->root_status |= PCI_ERR_ROOT_FATAL_RCV;
+				if (!(rperr->root_status & PCI_ERR_ROOT_UNCOR_RCV))
+					rperr->root_status |= PCI_ERR_ROOT_FIRST_FATAL;
+			} else
+				rperr->root_status |= PCI_ERR_ROOT_NONFATAL_RCV;
+			rperr->root_status |= PCI_ERR_ROOT_UNCOR_RCV;
+			rperr->source_id &= 0x0000ffff;
+			rperr->source_id |= PCI_DEVID(einj->bus, devfn) << 16;
+		}
 	}
-	raw_spin_unlock_irqrestore(&inject_lock, flags);
 
 	if (aer_mask_override) {
 		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,

