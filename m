Return-Path: <linux-pci+bounces-39361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66414C0C3F6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 09:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B9A3BDD8D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E892E7631;
	Mon, 27 Oct 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qdaimokf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="07ExglPA"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FE1DF252;
	Mon, 27 Oct 2025 08:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552696; cv=none; b=b8HMmoJc4uPY25YjXuwQiYLeiCwe+T/yadoOeEL37CrPRDcxOWRPlvIFlOipXdn5xgTvTPgc5v6FV4PKLd0U/Bs1agvYsLV8OJyimeQhfKEuA8H8SX4xTglZE1B+zmcfDbOhrWF4MFpbtODrQKlfJd64JU99JUZ7DG6ZMk1rxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552696; c=relaxed/simple;
	bh=j3Hf9s88FyUwqsLCotvEtSj66nzDKdgrfy6oE7SYeN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEGiUa5j+1pp6vYW6uxuCqunb6pCnwP6ASc0RPbaso4voiqHOdlZianLs/3uEobI14YGingF8e8MK1455K5Usn8+frlPJZuDsLdkfbOpSUV3mZpyIvpaFMcK2sM9C25cyc990ifQow5QSdXXV501JpB2HSsUqcJz/X7T+EShX78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qdaimokf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=07ExglPA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 09:11:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761552686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maMMrIIqAJhvb2vjl/zIfeSMpvuAK3xULFTfUV/e83U=;
	b=Qdaimokf68Rnl4x47DRuMbm2ClQ9ZQeIirmNKi4qikdiAdVxXGjDxjL/eKw3396hZJpf47
	MmIF6p00vlfcD7EyNBMBeN+EhEJ05N4QaQA7Q1abwfEMlYOBf0cqJ+HY2kcvLx0vgI8k1K
	IPKssYtK5lB/p0+bj4KXRVrfXZTzPElb97g1danEIVSSYBRGQ2e2a34pVQG83zfJRbgcxA
	Uux2QJds5bUsCdgLqM49N/row+2iMeZZFKyrbR8n7Vau59eeZo2H/hDHYl9Ss3vHMPjZ0x
	489CjyF/5f0i02ELTdRsCfJy/wf///4SEBFhoTTxlF8uFk74mdRPee7DIhx9DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761552686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=maMMrIIqAJhvb2vjl/zIfeSMpvuAK3xULFTfUV/e83U=;
	b=07ExglPAirPbHUbV1v0Ozh2UMNDaF221i3WnN2ilO9NijX/mNAlIBo9K40QEfSqpecBQLh
	6wiJrwIc7e3l9/Ag==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Waiman Long <longman@redhat.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI/aer_inject: Convert inject_lock to
 raw_spinlock_t
Message-ID: <20251027081125.n7far5BO@linutronix.de>
References: <20251026044335.19049-2-jckeep.cuiguangbo@gmail.com>
 <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251026044335.19049-3-jckeep.cuiguangbo@gmail.com>

On 2025-10-26 04:43:34 [+0000], Guangbo Cui wrote:
> The AER injection path may run in forced-threaded interrupt context
> under PREEMPT_RT while holding the lock with IRQs disabled.

not IRQs but interrupts.=20

> On RT kernels, spinlocks are converted into rt_spinlocks, which may

rt_spinlocks is not a thing. An established term is sleeping spinlock.

> sleep. Sleeping is not permitted in IRQ-off sections, so this may
> trigger lockdep warnings such as "Invalid wait context" in [1].

Why that reference. You should be able to describe your change _here_.

>   raw_spin_lock_irqsave(&pci_lock);
>       =E2=86=93
>   rt_spin_lock(&inject_lock);  <-- not allowed

It is still a spin_lock() that happens. The problem is that a
raw_spinlock_t must not nest into a spinlock_t. See
	Documentation/locking/locktypes.rst

very bottom of that file.

> Switching inject_lock to raw_spinlock_t preserves non-sleeping locking
> semantics and avoids the warning when running with PREEMPT_RT enabled.
>=20
> The list protected by this lock is bounded and only used for debugging
> purposes, so using a raw spinlock will not cause unbounded latencies.

This is I like.

> [1] https://lore.kernel.org/all/20251009150651.93618-1-jckeep.cuiguangbo@=
gmail.com/
>=20
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Guangbo Cui <jckeep.cuiguangbo@gmail.com>
> ---
> @@ -445,7 +445,7 @@ static int aer_inject(struct aer_error_inj *einj)
>  		rperr->source_id &=3D 0x0000ffff;
>  		rperr->source_id |=3D PCI_DEVID(einj->bus, devfn) << 16;
>  	}
> -	spin_unlock_irqrestore(&inject_lock, flags);
> +	raw_spin_unlock_irqrestore(&inject_lock, flags);
> =20
>  	if (aer_mask_override) {
>  		pci_write_config_dword(dev, pos_cap_err + PCI_ERR_COR_MASK,

This is the last hunk. You miss the module exit part. This won't
compile on its own, as such it can't be applied. It might be chosen for
a backport. A change must always be self-contained.

Sebastian

