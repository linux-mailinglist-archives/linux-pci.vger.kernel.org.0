Return-Path: <linux-pci+bounces-36606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AACB8E302
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457091898A72
	for <lists+linux-pci@lfdr.de>; Sun, 21 Sep 2025 18:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170021F03D9;
	Sun, 21 Sep 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zCBOqYbe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Efvzad1C"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2960142AA9;
	Sun, 21 Sep 2025 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758478521; cv=none; b=PpoMxYTVq3pePsGRN10vn1yu3xk/bG1PMizMGSSPK4BiLf0XGDYo9hX/3j6AKlpZVVLAU1BE9o/w1XTclmpNbQeWq+SD5H/p3FWdNBATeQU5KD1FVj+MZwj3LTXqz4jPWCtv22g2M+9ziujbrTsL/P5m5PbZGfwZ3Pe5zu5tYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758478521; c=relaxed/simple;
	bh=C0vpUIlspe5sVWfQ6N+HlWRfm2grKhPudRXOkB5RrCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PTURFUCyjCY6GmjmN/JbxB4UiUqgwbr0+lqiuu2M4M5reDGO7lJ7+2Hr6LdJ0PWelxxJDi38BYxJM9VUFphncoSKtzQxZs4qMma04//U3Ojkd5uhwSBfk5p3We5IR/8gnWFScLH+GSzXYtptnpUUrEwoy/ieJ1u4S+veU4JCaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zCBOqYbe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Efvzad1C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758478510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2dL4SHblJOy7vCZrKeyHuNdmrFo8jRhfuSaDzTsmf4=;
	b=zCBOqYbe5cOd30ByoCLO0pEUH8XdDpcYHk+zWUU4uyp0GYQVC0XXi3Py16h6cGMYmzeJ7P
	vc5RfrCiEzGHbs+aQS7E/WzS6vZ4xGVFrsGBka9uK+4KJDJQ2ah9QuxTEaG806F//+9Msw
	ZMpW7mTlRPt6fIpQxnRzQEuB82xo3/OYFONehBsg+qrETYeBiCWwWbrjsrIclaipFK+EHi
	XAU972FqyKvoTKYY3bn8LcIgNAo03qt4xvFd3LhH1aEOsi4i7otdEfKgjGYCJBh83U4aVk
	F5cHm89+wbTOnFkU31cNA/xF+cY8A8A6lyBOvK7Or/Q2d5MpgjeU6r66OEt++g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758478510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n2dL4SHblJOy7vCZrKeyHuNdmrFo8jRhfuSaDzTsmf4=;
	b=Efvzad1CfioBYK4Xjw1rP4rugdImq1k3X7KOohbES7s1NGvXPg5SF81E1zNuxh2hQm4UWy
	4r5gojsoX98CoqCQ==
To: Lukas Wunner <lukas@wunner.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Crystal Wood
 <crwood@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>,
 linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev, Bjorn Helgaas
 <helgaas@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 OHalloran <oohall@gmail.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
In-Reply-To: <aM_5uXlknW286cfg@wunner.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
 <87348g95yd.ffs@tglx> <aM_5uXlknW286cfg@wunner.de>
Date: Sun, 21 Sep 2025 20:15:09 +0200
Message-ID: <877bxr65aq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Sep 21 2025 at 15:12, Lukas Wunner wrote:
> On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> Your research that at first glance, at least 21 of 40 instances of
> request_threaded_irq() could just use IRQF_NO_THREAD, seems to
> support the notion that the majority of interrupt handlers only
> do minimal work in hard interrupt context.
>
> But if that is the case, and if you believe that deferring that
> small amount of work to a thread is nonsensical, then why is the
> primary handler forced into a thread by default in the first place,
> requiring drivers to explicitly opt out by setting IRQF_NO_THREAD?

Because there are primary handlers which are absolutely not RT safe.

> Shouldn't it rather be the other way round, i.e. by default the
> primary handler is *not* forced into a thread, but only if the
> driver explicitly opts in?  (In cases where the primary handler
> does a sufficient amount of work that is justified to be deferred
> to a thread.)

We had to do it this way before RT got upstream as there was no way to
play a whack a mole game with drivers constantly being added and
changed.

Thanks,

        tglx



