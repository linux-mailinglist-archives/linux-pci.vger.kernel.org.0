Return-Path: <linux-pci+bounces-36360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD496B80598
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1BE3A28D1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 15:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED436CE1F;
	Wed, 17 Sep 2025 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oEKU/7aK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TtFpB/M"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C2336C061;
	Wed, 17 Sep 2025 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121007; cv=none; b=ZPPFaUmH9BrHr/7B3+iYLt+Omu5v4kjzzX3b7WiFPZKnlC4xEIR+xWCC2AVvc9p1nky956iHVqIIkGeyLNBpRVgvnpYscFNw1qdOUucH0TWsi4R/RM504sa/cooRX2MTWklDLYq3rwf6+JwcClvo5yxwNYt7tXK4ctfSSa8pW9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121007; c=relaxed/simple;
	bh=kUeASiBxH3sOO+ZwrFN+yRAngloB4lCWSJg4w8j6c+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyqMjDFwi59fw4ByzuigQHwfO0SK1hkpfnKcRYEkvv2f+AXeCDv7/AaxQHinbrOOg+mecpl+UgBS9EGYRGnyj0fHxHtnrnmB9EIcNvOYKW7zoAgZbYgSm7nNEIrzK4wUTZfyH4ZzgW0k/S31gJnmwyYHNh8BYgcHvtnXiznWkAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oEKU/7aK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TtFpB/M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 16:56:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758121004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/r5OokIjbOb+NFrRfOaaODGH/r/Ubwc9cypITGzs6s=;
	b=oEKU/7aKfgKN9ginUW6CBLBh70hjpAoEmBJxXSt4FQ3hLFmJijHWChQCfZXR7X8DLmwgwH
	+0rWgdn6lkKJlwOiWNCs0HrNKPX5T0qiFBuRnLYv457fq0oqEMCtMmeLC8K5uaKPWu/wAJ
	XEDiJNCy+kq+IGQelfwrNwrhNhmW98aPQNRmR8fTFTfh2MYBJaFr0knUNuVkT/4kDQYt7M
	deza+3+LNfUF2gwH5Xrj2131cHOcOMYpX82Kj8C7AcdcIik1wuCI0OH38hQPjZZpG7yueW
	oIKaa87dJSPVcwO5ugzuAPhERz5CZXClEPk5Btbxt/T5cN5/vH+G5BX47GbnLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758121004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q/r5OokIjbOb+NFrRfOaaODGH/r/Ubwc9cypITGzs6s=;
	b=3TtFpB/M+EIobtaj/9bZH8FWtumXtrlKyw7MRcCfQOQOqTvCCLICgELYuxLggVbNCrpF+E
	w7iyAXQTfbdrZ6CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Crystal Wood <crwood@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>,
	linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
Message-ID: <20250917145642.Z0Q6pRfE@linutronix.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>

On 2025-09-08 18:08:31 [+0200], Lukas Wunner wrote:
> Crystal reports the PCIe Advanced Error Reporting driver getting stuck
> in an infinite loop on PREEMPT_RT:  Both the primary IRQ handler
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
> 
> Simulate the same behavior on PREEMPT_RT by assigning a lower default
> priority to forced secondary IRQ handlers.
> 
> Reported-by: Crystal Wood <crwood@redhat.com>
> Tested-by: Crystal Wood <crwood@redhat.com>
> Closes: https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Crystal provided a Tested-by off-list.  I've used Crystal's suggestion
> for the code comment, but if anyone prefers Sebastian's or some other
> wording, I don't mind either respinning myself or a maintainer amending
> this or any other aspect of the patch when applying.  Thanks!

Crystal's wording ist fine.

Sebastian

