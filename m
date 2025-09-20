Return-Path: <linux-pci+bounces-36598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF37B8D181
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6186B466B22
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2739427A906;
	Sat, 20 Sep 2025 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gS5GF416";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5hlu2eBl"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142AF279DAF;
	Sat, 20 Sep 2025 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758403233; cv=none; b=mQKyV8rXqGdkusT1cG8fjA6oKtKjqEIPZe6u0NfIfHcxnSKFyJhKO/gvYCfN+Q3JiFFX7Hj+izzXyeKlDDwJCiUwwRh26WT3JB0lV6df4fmUKebmcuR825zBpNXrrdzA4VJ04Yaaugx2aTl9XMd9orVN74jgMCwmCy7wJhhy+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758403233; c=relaxed/simple;
	bh=ZwZ18KFBzUZRHxbiRVz4unvYpDgokHGk1bhNOrbb3cw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uuJg1e4vnGkkl1XnfG/ZgecVYL1Y3JGcXXNw5fkvULNr5SghGKCtl0pIPhvNmi1qExTJivkNseSn5xWXJ0D+2HjvnKns7ezmzp0wf6t2m2zdNyiPW8FaY+Sknndw+Cl+5/B+9rGv5GV6rgxnR8QUppUr9NMyIM53/5baJ74Okuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gS5GF416; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5hlu2eBl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758403227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1GmvU8ma9x4F+83OCNr26kXzjtn2rKd3NDHRyJRbEQ=;
	b=gS5GF41697IWVILXXTfnRaLCFZ3dnNwAAmdy5hDVVCxHUKnAPbebrW0MR4aPcZp2gpCidk
	7r8psGgeaIQvsmsgPMLsjhftnlCj980WmewEuBcPr5YFCiH9OxrHI7w39X6sG1spkUTDOw
	Bnob7rUtf1NqyD5hqVJdlPOykYD/QcoM4247N9dPW7FOtJRjbIdc2JMv7fmPvCAcBFOH/T
	J4+ryolehwCT4BUMCEd0C50bCjqKYliOgJ8vZqZYXAZxUWNvf/tV8wUp4ALP0YBOJoVvKv
	fMFXHZsXdTtIsiFuGiPLZmTAXGd5HrWfMPjwX7/Oh8kbi9EtAj47bDhA02rTvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758403227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o1GmvU8ma9x4F+83OCNr26kXzjtn2rKd3NDHRyJRbEQ=;
	b=5hlu2eBl9ZXLefv8T82ofhCCllJaA2tjgj/l6uTzemIJC6DuQO7hCV54ikJGB78OIIi0R1
	MnWNyH+d8mgT5hDg==
To: Lukas Wunner <lukas@wunner.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Crystal Wood <crwood@redhat.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org, Attila Fazekas
 <afazekas@redhat.com>, linux-pci@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>, Mahesh
 J Salgaonkar <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
In-Reply-To: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
Date: Sat, 20 Sep 2025 23:20:26 +0200
Message-ID: <87348g95yd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 08 2025 at 18:08, Lukas Wunner wrote:
> Crystal reports the PCIe Advanced Error Reporting driver getting stuck
> in an infinite loop on PREEMPT_RT:  Both the primary IRQ handler

Can you please write out interrupt. This IRQ acronym is just not helpful
at all.

> aer_irq() as well as the secondary handler aer_isr() are forced into
> threads with identical priority.
>
> Crystal writes that on the ARM system in question, the primary IRQ
> handler has to clear an error in the Root Error Status register...
>
>    "before the next error happens, or else the hardware will set the
>     Multiple ERR_COR Received bit.  If that bit is set, then aer_isr()
>     can't rely on the Error Source Identification register, so it scans
>     through all devices looking for errors -- and for some reason, on
>     this system, accessing the AER registers (or any Config Space above
>     0x400, even though there are capabilities located there) generates
>     an Unsupported Request Error (but returns valid data).  Since this
>     happens more than once, without aer_irq() preempting, it causes
>     another multi error and we get stuck in a loop."
>
> The issue does not show on non-PREEMPT_RT since the primary IRQ handler
> runs in hardirq context and thus clears the Root Error Status register
> before waking the secondary IRQ handler's thread.

That sentence does not make sense at all because on RT this is not any
different. The primary handler clears the status register before waking
the secondary handler, no?

What's different on non-RT is that the primary handler can interrupt the
threaded secondary handler, which is required to make progress.

> Simulate the same behavior on PREEMPT_RT by assigning a lower default
> priority to forced secondary IRQ handlers.

I'm not really fond of this new minus one interface naming. It's a
horrible misnomer as it suggests that it sets the FIFO priority to -1,
which doesn't make any sense at all and is confusing at best.

Can you please pick a name, which makes it obvious what this is about
and as this is really a special case for forced secondary interrupt
handlers, it should just reflect that in the name.

I obviously understand that the proposed change squashs the whole class
of similar (not yet detected) issues, but that made me look at that
particular instance nevertheless.

All aer_irq() does is reading two PCI config words, writing one and then
sticking 64bytes into a KFIFO. All of that is hard interrupt safe. So
arguably this AER problem can be nicely solved by the below one-liner,
no?

And because that made me curious I looked at the first 40 instances of
interrupt requests which have a primary and a secondary handler.

   21 of them can simply set IRQF_NO_THREAD

    3 of them are just silly. I really could not resist to create the
      diff and append it below for entertainment.

Which means going through all the 231 instances is definitely a
worthwhile exercise.

The rest:

   1) is not immediately obvious as I did not follow (indirect)
      call chains to figure out what's really behind them

   2) sets IRQF_ONESHOT, which means the interrupt line is masked before
      the primary handler runs and stays masked until the secondary
      handler returns.

#1 needs eyeballs

#2 should actually not use the secondary thread mechanism at all when
   forced threaded. This really should do:

   hardirq()
        wake(primary_thread);

   primary_thread()
        if (primary_handler() == IRQ_WAKE_THREAD) {
              if (secondary_handler && ONESHOT)
                 secondary_handler();
              else
                 wake(secondary_thread);

   That spares a boat load of wakeups and scheduling on RT and reduces
   the actual problem space significantly. This might need a new
   IRQF_xxx flag to avoid overloading ONESHOT, but that's an
   implementation detail.

Hmm?

Thanks,

        tglx
---
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1671,7 +1671,7 @@ static int aer_probe(struct pcie_device
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
-					   IRQF_SHARED, "aerdrv", dev);
+					   IRQF_NO_THREAD | IRQF_SHARED, "aerdrv", dev);
 	if (status) {
 		pci_err(port, "request AER IRQ %d failed\n", dev->irq);
 		return status;

<ENTERTAINMENT>

--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1482,11 +1482,6 @@ static void btintel_pcie_msix_rx_handle(
 	}
 }
 
-static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 static inline bool btintel_pcie_is_rxq_empty(struct btintel_pcie_data *data)
 {
 	return data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM] == data->ia.cr_tia[BTINTEL_PCIE_RXQ_NUM];
@@ -1585,13 +1580,9 @@ static int btintel_pcie_setup_irq(struct
 		msix_entry = &data->msix_entries[i];
 		msix_entry->vector = pci_irq_vector(data->pdev, i);
 
-		err = devm_request_threaded_irq(&data->pdev->dev,
-						msix_entry->vector,
-						btintel_pcie_msix_isr,
-						btintel_pcie_irq_msix_handler,
-						IRQF_SHARED,
-						KBUILD_MODNAME,
-						msix_entry);
+		err = devm_request_threaded_irq(&data->pdev->dev, msix_entry->vector,
+						NULL, btintel_pcie_irq_msix_handler,
+						IRQF_SHARED, KBUILD_MODNAME, msix_entry);
 		if (err) {
 			pci_free_irq_vectors(data->pdev);
 			data->alloc_vecs = 0;
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -381,17 +381,6 @@ int dprc_scan_container(struct fsl_mc_de
 EXPORT_SYMBOL_GPL(dprc_scan_container);
 
 /**
- * dprc_irq0_handler - Regular ISR for DPRC interrupt 0
- *
- * @irq_num: IRQ number of the interrupt being handled
- * @arg: Pointer to device structure
- */
-static irqreturn_t dprc_irq0_handler(int irq_num, void *arg)
-{
-	return IRQ_WAKE_THREAD;
-}
-
-/**
  * dprc_irq0_handler_thread - Handler thread function for DPRC interrupt 0
  *
  * @irq_num: IRQ number of the interrupt being handled
@@ -525,10 +514,8 @@ static int register_dprc_irq_handler(str
 	 * NOTE: devm_request_threaded_irq() invokes the device-specific
 	 * function that programs the MSI physically in the device
 	 */
-	error = devm_request_threaded_irq(&mc_dev->dev,
-					  irq->virq,
-					  dprc_irq0_handler,
-					  dprc_irq0_handler_thread,
+	error = devm_request_threaded_irq(&mc_dev->dev, irq->virq,
+					  NULL, dprc_irq0_handler_thread,
 					  IRQF_NO_SUSPEND | IRQF_ONESHOT,
 					  dev_name(&mc_dev->dev),
 					  &mc_dev->dev);
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -1356,11 +1356,6 @@ void malidp_se_irq_hw_init(struct malidp
 			     hwdev->hw->map.se_irq_map.irq_mask);
 }
 
-static irqreturn_t malidp_se_irq_thread_handler(int irq, void *arg)
-{
-	return IRQ_HANDLED;
-}
-
 int malidp_se_irq_init(struct drm_device *drm, int irq)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
@@ -1371,8 +1366,7 @@ int malidp_se_irq_init(struct drm_device
 	malidp_hw_disable_irq(hwdev, MALIDP_SE_BLOCK, 0xffffffff);
 	malidp_hw_clear_irq(hwdev, MALIDP_SE_BLOCK, 0xffffffff);
 
-	ret = devm_request_threaded_irq(drm->dev, irq, malidp_se_irq,
-					malidp_se_irq_thread_handler,
+	ret = devm_request_threaded_irq(drm->dev, irq, malidp_se_irq, NULL,
 					IRQF_SHARED, "malidp-se", drm);
 	if (ret < 0) {
 		DRM_ERROR("failed to install SE IRQ handler\n");





