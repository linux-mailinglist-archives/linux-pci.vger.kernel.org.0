Return-Path: <linux-pci+bounces-40143-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB07C2E05C
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 21:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF5E3BE12B
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 20:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8590F2BDC05;
	Mon,  3 Nov 2025 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TkJoFSi/"
X-Original-To: linux-pci@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3029D27A;
	Mon,  3 Nov 2025 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201759; cv=none; b=JP85KJDj4IdBMbT7sd4CLSDyficB+TKVIeTkiCeUoJAqHosEP+Wo7OLcKIcGZmgSrr1S/h9ucNs7L/1sNYC03VKfj+lS0lvp9yDf3ZkppiMgwbeA0ouABwlMB+DeF4JFlL5wjOo551rSXQpZYJzVvJTEswiVZWlKc0200g1ezok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201759; c=relaxed/simple;
	bh=sMaK0mE3kZRSfEftp0IEwdJqLz2udRSH91vLy5dBj20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhBJNlmuMyiv0JvXCBAPAFwFEMnh8KE6jrfIDHtLBEXCo0ZSuRVEPgGO3ytYTthlM2QNpaDSxC16KX4TeK0Jl3aO/pgZRbme+uDwTwLWvRN7mneBIttaIkJiE1i11fmgaJgki7eVligW0t1seMTZT4NcTI5UE/d/dT/YPkxSEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TkJoFSi/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=AqWFvC9W9TbmCx8bnACnxtgLnR3mPIaEwzeZKsBjjRQ=; b=TkJoFSi/p5Xjs+SLSo0bdvlRMk
	f5cQfgjJtjh/lROVK39H/60Yj33VCtXCHWpp4CcvcDdlPcrE804nxhoWW7UvmXL9HsSNyR8Gn0NRs
	Ws5gqVqA0IVqdjZs5haC+DQfe0QO5mCvxFS5yNax6mzrPQRW5v0FlogKDQGnyoSvmpk0KsLzLMb8e
	Y0FMaW3h1lUB9OYcpXk99ak1Q3nZdPvMElWyhKjUvHtNCtH6ROzGnLcGNzMkXdioiMlM97uW6nOlw
	v81/i0dbEjoPw8+9jF2hIrgg8NB4xomxCsDEnVfq5ENb3a5qN0oZc0gSV8wJAwjr316QHD1fYyk9y
	dme0lWUg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG1Au-0000000HWlA-1Cfj;
	Mon, 03 Nov 2025 20:29:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0FBBB30029E; Mon, 03 Nov 2025 21:29:13 +0100 (CET)
Date: Mon, 3 Nov 2025 21:29:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Guangbo Cui <jckeep.cuiguangbo@gmail.com>,
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
Message-ID: <20251103202913.GG3245006@noisy.programming.kicks-ass.net>
References: <20251102105706.7259-1-jckeep.cuiguangbo@gmail.com>
 <20251102105706.7259-3-jckeep.cuiguangbo@gmail.com>
 <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>
 <20251103200253.SlYC8MU7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251103200253.SlYC8MU7@linutronix.de>

On Mon, Nov 03, 2025 at 09:02:53PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-11-03 20:21:20 [+0100], Peter Zijlstra wrote:
> > On Sun, Nov 02, 2025 at 10:57:06AM +0000, Guangbo Cui wrote:
> > > The AER injection path may run in interrupt-disabled context while
> > > holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
> > > sleeping lock, so it must not be taken while a raw_spinlock_t is held.
> > > Doing so violates lock ordering rules and trigger lockdep reports
> > > such as “Invalid wait context”.
> > > 
> > > Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
> > > semantics. The protected list is bounded and used only for debugging,
> > > so raw locking will not cause latency issues.
> > 
> > Bounded how?
> 
> I think I used the term "not bounded" and said "it does not matter
> because it is debugging only". Best would be to leave that part and use
> only "only for debugging".

Yes, that is clearer. Thanks!

