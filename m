Return-Path: <linux-pci+bounces-39266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE7AC06878
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63263B5B3E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A6C31CA5B;
	Fri, 24 Oct 2025 13:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nqCm20sK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nv00PF8K"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26131961D;
	Fri, 24 Oct 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312817; cv=none; b=YyOJn78UwCDBcxNfpJNGaR0+uLNECnc1imSe+/bTrQlAdEAvTnPeQs9A7UR0znXdVSdxzZm83F9H+1VEuh4WqCh6dYBYtYOGui5uckAiB8e5/ryTLt0ItZVzOLww45A15h0uyG8UwVDlvspVwshv4E8pFpNZZarhOVa1p1DD4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312817; c=relaxed/simple;
	bh=qrnHo1FnXHCcCfqiCLQpWfnkISn2nzcUj2DtsUtO3wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qt6XhNpsZY+ocZZ9nIrliD+DZncU3NtcxwBztb6qvmwiy38OovbbpsAUwGQzhyElrqv8ysAI1DA+4ZOLuwpp2WC473bMogsMKmE6LyMT7HdV1wnJZGFni8fegIt6/uu93mcNk3syrExUO/+U2JTfGB2c8r7ofoIeUY53uzbxsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nqCm20sK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nv00PF8K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 15:33:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761312814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrnHo1FnXHCcCfqiCLQpWfnkISn2nzcUj2DtsUtO3wI=;
	b=nqCm20sKvMO5TsGNC/Hkxvr+cpaNJHYtQlbQBrsqJMaukcIxFqnVZe65hYnfP4qXpYOPX7
	kP2V0VRNteeWjS/MNpupKetHTdH09uAEdueDat4JDVxDZnt+OgnwbR/5TugDBiGSG6XeM0
	9wVp9J7zL2GlLGPLfem9odLo0FkU6NL0WX/XtgSkFjlUr1ufd/f45834ON3w2nHf7ujukY
	LIhPPY5V3XuS88c6hRUEcI5GmGgXDFiI/aJ9YrzJfruXMYGbqAz873J0IHLmmF0zO9/TvE
	jGel1GomJsnK7UCBnx/JwxPilullXe72SIzDeHc7i21wHquyZj9334xQ/wWy5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761312814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrnHo1FnXHCcCfqiCLQpWfnkISn2nzcUj2DtsUtO3wI=;
	b=nv00PF8KedcQZ1f0QT9sCAzjWfduQbJSOH0ZYHKqn8zFH7m95ecM7PUJa1kzLOil9N3Pku
	utUl3tnuGOTHDtCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Crystal Wood <crwood@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Lukas Wunner <lukas@wunner.de>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20251024133332.wSQOgUZb@linutronix.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
 <87348g95yd.ffs@tglx>
 <aM_5uXlknW286cfg@wunner.de>
 <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>

On 2025-10-03 13:25:53 [-0500], Crystal Wood wrote:
> On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> > On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > > I obviously understand that the proposed change squashs the whole cla=
ss
> > > of similar (not yet detected) issues, but that made me look at that
> > > particular instance nevertheless.
> > >=20
> > > All aer_irq() does is reading two PCI config words, writing one and t=
hen
> > > sticking 64bytes into a KFIFO. All of that is hard interrupt safe. So
> > > arguably this AER problem can be nicely solved by the below one-liner,
> > > no?
> >=20
> > The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> > proposed:
> >=20
> > https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
>=20
> So, is the plan to apply the original patch then?

Did we settle on something?
I wasn't sure if you can mix IRQF_NO_THREAD with IRQF_ONESHOT for shared
handlers. If that is a thing, we Crystal's original would do it. Then
there is the question if we want to go the "class" problem to ensure
that one handler can preempt the other.
And maybe I should clean up few ones tglx pointed out that provide a
primary handler for no reason=E2=80=A6

> Thanks,
> Crystal

Sebastian

