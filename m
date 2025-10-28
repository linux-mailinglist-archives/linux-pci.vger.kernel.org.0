Return-Path: <linux-pci+bounces-39525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA559C148A8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 777AD4824B7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 12:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D73168FA;
	Tue, 28 Oct 2025 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qKQXrRO6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gocl/jMn"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FA328616;
	Tue, 28 Oct 2025 12:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653217; cv=none; b=RgLhDfI7Q0s+65o5tNLi2hzOnN+xoIMVjnJolgXGqa2SnOaF7yNDAHKsRKBv0CwzyBJZTtxaXz6AUMRrDLDdLfP4iaKTc5mtx5/cqrzbSgqHSM4X4I+0LJt3I9p/Z8GyWoZNRKn6f0Z7qv3r64ldSydSWNHQ4fVoijv8cjPO670=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653217; c=relaxed/simple;
	bh=ei+CA+ZBh3hHsRnekGA32bPDegEeVgJXMO6rrJReISs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pC95RjOqBd64nzlT5czh9AyjHwqEaAu2u6KXIC6dfgUyWihD5MvL9LZRTYMana08RentDQCVmx+uSBB0Va/xUQk6mV2QoEB2GrhlLY3sgln3fMyDevOHze33KVbGHqabcxTnO+eRmlFpzaxnbemdbkzSgboPf477JwIe3/yPBak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qKQXrRO6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gocl/jMn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 13:06:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761653214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crnGWfJ7+UbK0li8dGHZvc/h9PGKn2eAY0mmwg0N528=;
	b=qKQXrRO6OVuHEcDSuInE5tNxabxKnup1VtOzPffIvExXjuF4xJEmj38AHd0xhxDPKZp7kE
	MtM4/DZfqTPTSvLn6unZ520+2ok48bF8Ek0tfUKLejEKelVGlrIiXA3SMxx0AVIMpASl46
	x4nffQQ8rOedTcEBYrHQ3OXaW6CewuEHIw41zuIVFVJ5Sm9YqVfWWjo0qenTh7JF4zTcex
	NO+hEkwFLKbcVirJ/M/yvm0plZxdM3aTOSx5FcOh3nAeHQXpxuIqstMTSDl+zfKJN2szwv
	LvMykX7eBEdO+HCKpeRp98X8YHANIxFgq51nxx7QrZPlRDSF+8BJP+g3lCa3Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761653214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=crnGWfJ7+UbK0li8dGHZvc/h9PGKn2eAY0mmwg0N528=;
	b=gocl/jMnijFGp8u7+eYJkexAu4wF08rf5SfQNrcx5prs3WeJ9NFbyzWKcoQZjQi1SFSen7
	hpKTIBmKXAqe5MDw==
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
Subject: Re: [PATCH v2] genirq/manage: Reduce priority of forced secondary
 interrupt handler
Message-ID: <20251028120652.AJUTgtwZ@linutronix.de>
References: <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>

On 2025-10-27 13:59:31 [+0100], Lukas Wunner wrote:
> Crystal reports that the PCIe Advanced Error Reporting driver gets stuck
> in an infinite loop on PREEMPT_RT:
> 
> Both the primary interrupt handler aer_irq() as well as the secondary
> handler aer_isr() are forced into threads with identical priority.
> Crystal writes that on the ARM system in question, the primary handler
> has to clear an error in the Root Error Status register...
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
> The issue does not show on non-PREEMPT_RT because the primary handler
> runs in hardirq context and thus can preempt the threaded secondary
> handler, clear the Root Error Status register and prevent the secondary
> handler from getting stuck.

Not sure if I mentioned it before but this is due to forced threaded
IRQs which can also be enabled on non-PREEMPT_RT systems via `threadirqs`.

> Emulate the same behavior on PREEMPT_RT by assigning a lower default
> priority to the secondary handler if the primary handler is forced into
> a thread.
> 
> Reported-by: Crystal Wood <crwood@redhat.com>
> Tested-by: Crystal Wood <crwood@redhat.com>
> Closes: https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -856,6 +856,19 @@ void sched_set_fifo_low(struct task_struct *p)
>  }
>  EXPORT_SYMBOL_GPL(sched_set_fifo_low);
>  
> +/*
> + * For when the primary interrupt handler is forced into a thread, in addition
> + * to the (always threaded) secondary handler.  The secondary handler gets a
> + * slightly lower priority so that the primary handler can preempt it, thereby
> + * emulating the behavior of a non-PREEMPT_RT system where the primary handler
> + * runs in hardirq context.

s/non-PREEMPT_RT/non-forced threaded/ ?

Other than that,
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

