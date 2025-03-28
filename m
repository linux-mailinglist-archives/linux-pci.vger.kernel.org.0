Return-Path: <linux-pci+bounces-24933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7C5A74933
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 12:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AF63BC11E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1311218AA5;
	Fri, 28 Mar 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3J/oMR+p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swosjZEx"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B1145B27;
	Fri, 28 Mar 2025 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743161241; cv=none; b=EQU0MBVrLBG9rsAn5QgAGlq+cBe8olhWAmSMxcZxU9/aU9wEm/EOSLElARrcNBwBqtlB28oP3ESJkVQPzO4U2rV1zS+bPMCBw3/iStDhN1stkHjU4NrPjHH1hs1VNZ6+lifjmCwwhZ6P0F0LSjV61f20MMqe5jnd/rtdXRdrAs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743161241; c=relaxed/simple;
	bh=2kPJpnTzcGC0XDddPxH/fxFkaBQl1BQPYqmHSzE7kQs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=dwfrY9ukmFP6h0fJLDJ3Us8KR9bt8CkTHPQQqj8wxkDNPjyStOgPwakN8FjpOi6kOOVetXn9x5O/EC5yJoYCP9+3H1B5hZJn+5hrL+ZLeNfwN/U7mo+vigRggB0DOrz+8XFDZEnLWDz4ccbRuNe2iKV/iYaZ4JnBTf+OFAt35G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3J/oMR+p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swosjZEx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743161237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=UCv2LYhy+qHjJvbQ43Z92CZSDEUuxtS324OMj+L46D4=;
	b=3J/oMR+pa/YX7X2Qz3PNt44PyVWqbK5lWB9HfpmmTLuLocDtMccTGw1ZnuxEgNrhTwktHI
	P1JA0pr0SbVtxtnJMdC6+HmjjFAVjKsrNbKXwMG6HydCUeXQ64+dhacJW1RgkOBY6AvRmL
	VzSo54F/BOigHn8Zu5It1jtb9R58IXaYn1G5T7TG4vIW1ier5coOgl4Y5Kqn8S9tKlBadb
	EYHH9r8EUJ/xK48DdbJoHa4/MLma2+/wfcQDsqwLwVSDZhauboQ5szRwktE/QQ3ZocMCu2
	ASJ7XwtEopb42Hq2aNRfIIm4ZwAuzQ2o8lLlJ6TTaqd1xUlt7dJ5tzTfpT22qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743161237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=UCv2LYhy+qHjJvbQ43Z92CZSDEUuxtS324OMj+L46D4=;
	b=swosjZExrNPYITaGElmQZNNGiyJ01CKqxxnGbV8/w6rYwyx4VSUJNpCxE5UpXpgHYxcDnE
	mn+asDlrPU7lkACQ==
To: Wen Xiong <wenxiong@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, gjoyce@linux.ibm.com,
 linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] genirq/msi: Dynamic remove/add stroage adapter hits
 EEH
In-Reply-To: <8383b17f160bb75dd6ca6b47cd1a0d32@linux.ibm.com>
Date: Fri, 28 Mar 2025 12:27:16 +0100
Message-ID: <87wmc9wg2z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27 2025 at 16:36, Wen Xiong wrote:
> When secondary adapter doing a reset, we use the same code path as=20
> removing operation. We can=E2=80=99t free irqs for Secondary adapter sinc=
e=20
> kernel has assigned the irqs for Secondary adapter.
>
> Actually we discussed about "calling pci_free_irq_vectors()" before=20
> doing bist reset when we trying to fix in device driver.
> That might cause other problems. It is also not what a user would=20
> expect. For example, if they disabled irq balance and manually setup irq=
=20
> binding and affinity, if we go and free and reallocate the interrupts=20
> across a reset, this would wipe out those changes, which would not be=20
> expected.

You are completely missing the point. This is not a problem restricted
to PCI/MSI interrupts.

You have interrupts, work, queues and whatever in fully operational
state. Then you tell the firmware to reset the adapter and swap the
secondary adapter in. This reset operation brings the hardware temporary
into an undefined state as you have observed. How is any part of the
kernel, which can access and operate on this adapter, supposed to deal
with that correctly?=20

You are now focussing solely on papering over the symptom in PCI/MSI
because that's where you actually observed the fallout.

But as you know curing the symptom is not fixing anything because the
underlying root cause still persists and will roar its ugly head at some
other place sooner than later.

So no, instead of sprinkling horrible band-aids all over the place, you
have to sit down and think about a properly orchestrated mechanism for
this failover scenario.

I understand that you want to preserve the state of the secondary
adapter including interrupt numbers and related settings, but for that
you have to properly freeze _all_ related kernel resources first, then
let the firmware do the swap and once that's complete unfreeze
everything again.

That will need support in other subsystems, like the interrupt layer,
but that needs to be properly designed and integrated so that it works
with all possible PCI/MSI backend implementations and under all
circumstances. Setting affinity is not the only way to make this go
wrong, there are other operations which access the underlying hardware
and config space. You just haven't triggered them yet, but they exist.

And it's not a problem restricted to the pSeries MSI backend
implementation either. That's just one way to expose it.

Even if I put the secondary swap problem aside and just look at a single
instance, __ipr_remove() is already broken in itself. As I pointed out
to you before:

    __ipr_remove()
      ipr_initiate_ioa_bringdown()=20
	// resets device -> undefined state
	restore_config_space()
      ....
      ipr_free_all_resources()
	free_irqs()

Up to the point where interrupts are freed, they are fully operational
and exposed to user space. The related functionality can hit the
undefined state not only via set_affinity() independent of the swap
problem.

The adapter swap is just a worse variant of the above because it affects
the secondary side behind its back.

This needs quite some work to resolve properly, but that's the only way
to fix it once and forever. Proliferating the 'Plug and Pray' approach
with a lot of handwaving is just helping you to close your ticket, but
it's not a solution.

Thanks,

        tglx

