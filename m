Return-Path: <linux-pci+bounces-39363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE430C0C45D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18B84E77E6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 08:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1212E7BB4;
	Mon, 27 Oct 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SeQqQxcX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ue+Jdu1w"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A627707;
	Mon, 27 Oct 2025 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553091; cv=none; b=NFfLOfg15E27wiJSXK/4plox55smKvxm0CY68uhIpKFU+saTAi6TEb6tulxiXxbfl9yhRtWCryCttDelFf+Jf5dIPPogvfTi3o3ir22P62PwrG5Hso6aNvHDplYwhkUEqckjq5adk8EM4ecwHOVQUAgDPLxVDjkPvG9N6Bx0ilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553091; c=relaxed/simple;
	bh=DLi8g6Oj/iDrhzEAtnGQgxVttfk4hh/NPB/PrtkWn1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ml/CLp1F5USnzgTY27ZeOUeao+JL045eXaOgRMcdQJK0CVyi6EyD3sYwvQFxnbYBm/hFQSdVR94wHxVyXURdLQs0O9IqFzsLTAiZVeFEl5mC6zHvjAb/baozHijpnmFrqjji4o54CjfUqp6mJ/vQerSS299dfZay5Kuf+w9AFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SeQqQxcX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ue+Jdu1w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 09:18:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761553088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gqwfnd8t9SkEUWxijRcqaEcKFFa1ld0wc1cHax1Cfzc=;
	b=SeQqQxcXDd0RzcAXMscFU/guFBAi2ZyoUFD69PseIs8UaVMC1hm8x27V6sIGCfG+wO5d7J
	/wL6aV7pYKleuWgbJn+yNDDO46ZX2gOoTkM+IhukwK+EqGqpiAqdptC/b0pdgcqQ+B7K2p
	LY7o4PXvX89SoEvGNUKCFROgU4Hlt9s5Rl4No4OkdBY1HUzZQQ5ns5qXU49IGfLmNzlI+r
	B1hhx0vhwFX5kGnyMPjRrIsSdBrVQVWoeupZZEmmCbyTBW7+9tsYZgNzw7BFjwpmfhZeUB
	6+xoq6vwhp8HGZbfb5wzdzwJis3t9UenJNChmJcQsP2yhi0eFxVUY+u/NKlfHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761553088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gqwfnd8t9SkEUWxijRcqaEcKFFa1ld0wc1cHax1Cfzc=;
	b=ue+Jdu1wW99KrwTGoxpoKZOFMSpRePbHG3BTg9vUaDLbdj6acFJUOd+xjapHc5LRJKYjWb
	eefgB2MAAsyGy2Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Crystal Wood <crwood@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20251027081806.qoogsX3l@linutronix.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
 <87348g95yd.ffs@tglx>
 <aM_5uXlknW286cfg@wunner.de>
 <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
 <20251024133332.wSQOgUZb@linutronix.de>
 <de1ec7fcc1711e3062cc321ab55552339630de30.camel@redhat.com>
 <aP8T7rahGYzJqnP5@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aP8T7rahGYzJqnP5@wunner.de>

On 2025-10-27 07:40:46 [+0100], Lukas Wunner wrote:
> > I suspect it was a non-issue because of IRQCHIP_ONESHOT_SAFE disabling
> > the forced oneshot (the other irq was pciehp).  Given that these are
> > pcie-specific, do they ever get used without MSI (which sets
> > IRQCHIP_ONESHOT_SAFE)[1]?
> 
> It seems fragile to depend on IRQCHIP_ONESHOT_SAFE.  What about irqchips
> which don't set that?  What about PCIe ports which use legacy INTx
> instead of MSI?

exactly.

> Long story short, I'll respin the patch to reduce the forced secondary
> thread's priority, taking into account Thomas' feedback.
> (Apologies for not having done this earlier.)

no worries, thanks for the spin up.

> Thanks,
> 
> Lukas

Sebastian

