Return-Path: <linux-pci+bounces-39537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4407C1509B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 15:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49CA9622E31
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926F32BF43;
	Tue, 28 Oct 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uOeqyrTx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZyyuACtX"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15646233704;
	Tue, 28 Oct 2025 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659882; cv=none; b=NUwchYoQyseurlASFc/WA5/htFB9tegTIIudTBC6v5rbTVxIxv8vK+fdM8hoHTzhgYAg0eaNfTgdmjvFdW9aKK8W7QO0+DyTwETt+/cuwwvXhAs80aARB6x75bflgdZkz8VoIxjlnVBownAa2a0efGj7xKHV2bkmfqNVdExy3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659882; c=relaxed/simple;
	bh=jwhkSKyIAKFcKFKcHbcE5yLIWsbhuzQegvHxTtFBzts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsNevQpHhVkWayBsMytRCOv3xoSij57c2PxqQ4EBFwkjXywl7mEGafOquHSSE17U2VuVfp2WmFDVwo5YDRLFYl/M9iXSsRbagXFAD2LfO4yDBQ5prFHBi4Igx7INtBCPVrYvG5xVIdiGpmm+3BBpHDzc2NlxrxGnOxuQ86rDWek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uOeqyrTx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZyyuACtX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 14:57:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761659878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4sSQfkLnUOR6EYFSrWyzoEwtf3zqvnnuhYr4uBXt5w=;
	b=uOeqyrTxLDYiEMrmWVSQnhrBNLXvhfmhLJnXro8s8e/5+TaBX3e5hHYQ6wrfnnpA/D+2Br
	VepBCLLZ3mf2vpT0Gz3Vb2syn2mtMHOQBa2es2M8TlOQbwY7PIJcir1YnIN+/U8BCAMrWA
	edD/Gv6/wrcYXy5koz4y8dRqXZtGvoc0VWUDzWnBYMQEBG2nmOYC5G6McQ9BmDx4OF87w1
	vnxRNlqLwuHgl9jkDfCCuwOe99j4HoazKUy46yw4w5zbHDiLrTiRWzlxqmDAKBPNpBC3WT
	XLBBTN4PVOzTnm4pvMmbTyTZOa3kY6kt5hU+6zicfLmRuiMJrLthYfYgMrumAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761659878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q4sSQfkLnUOR6EYFSrWyzoEwtf3zqvnnuhYr4uBXt5w=;
	b=ZyyuACtX6WpVEwXwNANDHp34V24b0xcRAwXy5gpP9ecmQBqdeOCJKHHu1j6YtOcJWLigfB
	Jd3qSDCN9nglHQAg==
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
Message-ID: <20251028135756.31PG0uHY@linutronix.de>
References: <f6dcdb41be2694886b8dbf4fe7b3ab89e9d5114c.1761569303.git.lukas@wunner.de>
 <20251028120652.AJUTgtwZ@linutronix.de>
 <aQDIxvU18vzB-1G-@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQDIxvU18vzB-1G-@wunner.de>

On 2025-10-28 14:44:38 [+0100], Lukas Wunner wrote:
> On Tue, Oct 28, 2025 at 01:06:52PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-10-27 13:59:31 [+0100], Lukas Wunner wrote:
> > > The issue does not show on non-PREEMPT_RT because the primary handler
> > > runs in hardirq context and thus can preempt the threaded secondary
> > > handler, clear the Root Error Status register and prevent the secondary
> > > handler from getting stuck.
> > 
> > Not sure if I mentioned it before but this is due to forced threaded
> > IRQs which can also be enabled on non-PREEMPT_RT systems via `threadirqs`.
> 
> According to the commit which introduced the "threadirqs" command line
> option, 8d32a307e4fa ("genirq: Provide forced interrupt threading"),
> it is "mostly a debug option".  I guess the option allows testing
> the waters on arches which do not yet "select ARCH_SUPPORTS_RT"
> to see if force-threaded interrupts break anything.  I recall the
> option being available in mainline for much longer than PREEMPT_RT
> and it was definitely useful as a justification to upstream changes
> which were otherwise only needed by the out-of-tree PREEMPT_RT patches.

There are people using it without PREEMPT_RT due to $reasons. It is not
documented in Documentation/admin-guide/kernel-parameters.txt as an
option meant only for debugging.

> Intuitively I would assume that debug options are not worth calling out
> in commit messages or code comments as users and developers will
> primarily be interested in the real deal (i.e. PREEMPT_RT) and not
> an option which gets us only halfway there.  However if you
> (or anyone else) feels strongly about it, I'll be happy to respin.

I argued and sent patches to fix code which was wrong on PREEMPT_RT due
to threadirqs and was also wrong without PREEMPT_RT enabled but solely
with forced-threaded irqs.

But please wait once tglx/irq or peterz/sched says something here before
repining.

> Thanks for taking a look!
> 
> Lukas

Sebastian

