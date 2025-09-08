Return-Path: <linux-pci+bounces-35647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03007B48616
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 09:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01FA81767F2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03A293C4E;
	Mon,  8 Sep 2025 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRhis5Od";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOGtTkor"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0464231A30
	for <linux-pci@vger.kernel.org>; Mon,  8 Sep 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317950; cv=none; b=gp50UsK0ZcCcpwjLC121mxMdOfrAHuwCrXdJ1BcxeY/JHCu9bZjScttWxyl6juy+SmIxw7LCN3poAo0+CgkG9W82vV9mNKg7wZtuDMZ9B0olvpMilKpXUx02Gejpgs2BIq7zpWhq1XtlwPgLjiEk7Bn1aJKejxGPR4e1Y4bIBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317950; c=relaxed/simple;
	bh=DXcnXLocAl6kKD5ARtjBtWR+sEUGB7iZZdBgBa/kqHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yzv77bzp3oIrieNYUmjGG7NB5TyYbU2ZNI9de9EvZxQl5LX9dCRma+EXkVN5Nix/Za/341GRuAeaeqszv39CaLlYWh2AJsPqVAOLw/C5jbiIt4rnnVuwDdeIbOoACP+fGR6I0eNnf2RonACSacR6yfvG5HinZzi/p4fC/+3AeOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRhis5Od; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOGtTkor; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 8 Sep 2025 09:52:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757317946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fV/AeyvJkYSbU7KIIcXFsvG9xWJ1rjVN+fwRKDkvfc=;
	b=jRhis5OdobiM+YPyQnsqtG9Ov3LjG9J3bmRJMDL+wKILGqoyBSV2qamZpZZc73BFDT+k0X
	Ys6Lp0p19J0zZTYJePRrDLJ6CTKnyNobvA8Jqd+GWjsImnydyPXzz9f4lH796BXyVBX69H
	+zkcgdKk155ILhC9vGviJR1Y1CiM8oKD3dmmr4FgpCyyaMRkd2efoxsaPyRVCxCf7PRMPJ
	8kn18I8dgkL/xyNuLbC1RHLodfMrRedEhMf7YEWvv+HUWW1G4i/tr5kEfMBgcPbwPhcds2
	Yg+QlAk8JyzvFTLBzD7zQXtpvlfiBcj0c/mMLAHMQi0+Od/fStIyNah6GfG0Xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757317946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3fV/AeyvJkYSbU7KIIcXFsvG9xWJ1rjVN+fwRKDkvfc=;
	b=SOGtTkorjkrjI/73Wuh2FYaflUrGBB82pK2JYxHGwYwhY0ySI5bn5BqwmRtZnJFveGiUsQ
	p6pucVqQsRgf08Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Crystal Wood <crwood@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>, linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Message-ID: <20250908075225.sDW_dYzG@linutronix.de>
References: <20250902224441.368483-1-crwood@redhat.com>
 <20250904073024.YsLeZqK_@linutronix.de>
 <aLmKlVaKSBurRys1@wunner.de>
 <bb2b9df1b13fccb7829c5d73a0bddbd0083d105a.camel@redhat.com>
 <aL55cDBjsNk2xK10@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aL55cDBjsNk2xK10@wunner.de>

On 2025-09-08 08:36:32 [+0200], Lukas Wunner wrote:
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -847,6 +847,15 @@ void sched_set_fifo(struct task_struct *p)
>  EXPORT_SYMBOL_GPL(sched_set_fifo);
>  
>  /*
> + * Secondary IRQ handler has slightly lower priority than primary IRQ handler.

  For tasks that should be sched_set_fifo() but require not to preempt
  another sched_set_fifo() task.

> + */
> +void sched_set_fifo_minus_one(struct task_struct *p)
> +{
> +	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 - 1 };
> +	WARN_ON_ONCE(sched_setscheduler_nocheck(p, SCHED_FIFO, &sp) != 0);
> +}
> +
> +/*
>   * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
>   */
>  void sched_set_fifo_low(struct task_struct *p)

