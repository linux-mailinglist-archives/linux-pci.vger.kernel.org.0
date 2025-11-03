Return-Path: <linux-pci+bounces-40140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A9C2DF74
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 21:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEF654E9878
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DDA299922;
	Mon,  3 Nov 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gE2zIT2x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YnykWyxQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447C28D84F;
	Mon,  3 Nov 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762200179; cv=none; b=u1+CTrsJF3s1OfISP1dHtDg0MzPEbaBm3HiG2hP4dS/1vVDTyI6AxsDVQ2219TsprqjueeuShb1UjL531I3ianGI73X2QA+6+vyumzc+MDRw/J8zG7xLwItfhd2d1n5A0O2/E1qON8uf4i7DfI3cHY0PsFBGyhaoGznzkrkhN60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762200179; c=relaxed/simple;
	bh=eLLV5bfs7vlqLenwB2xPzLvyxxpRw2ZmCSNdswygJho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQQtVSc0PWaIcOIVz5VboAvJcOKcCAZ/OI6+Nva9A29knRu2iCBnlLjUdtS5svXi+x9rrHaeqmDBW5aRf4PlMBgHVqBICITl9HJw/NsYMP3pscKZr37VbR0OBsjvYCajIaUNZpFSem6fPTqYLmqSdwJgBTwJV2cT8//2NWtLnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gE2zIT2x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YnykWyxQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 3 Nov 2025 21:02:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762200175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLLV5bfs7vlqLenwB2xPzLvyxxpRw2ZmCSNdswygJho=;
	b=gE2zIT2x9ivjMT0LlRA+hdc7PCZau3DuiL8jOCB+M4eOkZn8TM1B6dZgZK8UYBqFoY3zLx
	ujpkg0oPLSdN3J96UI7vehhLU8rQwvMRbk9h1KIhHlmQw76KCn0xd5YBYr5t86PNq/xppt
	VlaqxMpup0jWfBnQ/XQcFuhwQEv7LP1w7EQF5M1im68nWEV3bCzpcjjN9G2ZbrnijEH3m6
	JzxprESG6QZfPj2rW++b4Vn7OZFRGCx8dj9hQMZF3ZjBzTAfWW5Vsjew+O3nc9L8X50/Et
	ZE3sk6I+7a54UnmPUc78b2XiOcDlxUnMlaRUsPO59//rw3LcpM1RDmAs6/RClQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762200175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLLV5bfs7vlqLenwB2xPzLvyxxpRw2ZmCSNdswygJho=;
	b=YnykWyxQYySyeofv8f81TwuRuGCrUIah/dRELJiTeC/3eIZlYKKegOMaJcsMSNGSFw5H08
	A3TrxgWZSlPd2UAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20251103200253.SlYC8MU7@linutronix.de>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251103192120.GJ3419281@noisy.programming.kicks-ass.net>

On 2025-11-03 20:21:20 [+0100], Peter Zijlstra wrote:
> On Sun, Nov 02, 2025 at 10:57:06AM +0000, Guangbo Cui wrote:
> > The AER injection path may run in interrupt-disabled context while
> > holding inject_lock. On PREEMPT_RT kernels, spinlock_t becomes a
> > sleeping lock, so it must not be taken while a raw_spinlock_t is held.
> > Doing so violates lock ordering rules and trigger lockdep reports
> > such as =E2=80=9CInvalid wait context=E2=80=9D.
> >=20
> > Convert inject_lock to raw_spinlock_t to ensure non-sleeping locking
> > semantics. The protected list is bounded and used only for debugging,
> > so raw locking will not cause latency issues.
>=20
> Bounded how?

I think I used the term "not bounded" and said "it does not matter
because it is debugging only". Best would be to leave that part and use
only "only for debugging".

> Also,

Sebastian

