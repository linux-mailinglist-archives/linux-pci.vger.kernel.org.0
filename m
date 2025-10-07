Return-Path: <linux-pci+bounces-37685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FD7BC294A
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 22:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBFB43E0136
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABBA21C9FD;
	Tue,  7 Oct 2025 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MvFd2X0l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dKkZ20EN"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441671A8401;
	Tue,  7 Oct 2025 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867450; cv=none; b=uokFUIIps4Y3pk3b+fb4pn4lt/UpppUIFMF1Dko10w4y0CJBVwcxH5OCXoGHGVLZrSJGaJ96cGZbwg4+h4svA5OoNO+wsfWoRTCn9TWSG99RH+BkcnBRFFVfS46k00VAZdA2vx5nkbzF/6QV/WXcbe2tUGJ4brIy1ITrhbZjZrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867450; c=relaxed/simple;
	bh=Ao0oFQv2y4aYgEuVjDDMfEvqJ+5113AHOjSDjJ20tl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TF+6dPYjg+JNeihzdoLIzTWSompmnj+KPWwxJfxURKKM0m+KV/pSn+eODOEawuxoEHwYvaQwV7mraWDK9nXXY8ltwh1vMdvHeP4sCq4KeGjKYlPfQLfIjHVcuzYC9G/ksmm2FqMZTYJlGhMSjs7Hh+xz7QBkkcXGz5MsMB/7o2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MvFd2X0l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dKkZ20EN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759867447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJN7WODhJCcyXL+7dMpUrrDyUSaBfGqfWaA9cwuzZ8I=;
	b=MvFd2X0lkTiYCtBDvPJEm3W0+s46+t+Ol7YIjuN6KH0jfiwAIWMkvoTLFgZAWSEefmQ/hf
	b6vNZkYenwuZ+I9zNFJORbrowBKEEf9S8Omvxn47FmWl5hKW1m11PUSR8aHvPg9ToyJ4lW
	7hCz/DL1CrPXdDwf5mUQRieFXxGyJkD3h0NZtrUahSuoUX5x+TIzWYud/EkgjISCJ60rYO
	rbUHkz6lwqSSFUSj94bxK0RQWIejPnSRRdWIbkpjBnJvBsk86G5UjW3pGRTCN1+Jh/+oe+
	HK+jPX9Kb3JqfT54EIU/nRT7QSbmfREme5X7banDkNiqtdO7uDCNtCBBgFSzvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759867447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJN7WODhJCcyXL+7dMpUrrDyUSaBfGqfWaA9cwuzZ8I=;
	b=dKkZ20ENC4hYLqxxuC0WtQeZpbwJuPQaXe+1W1xqtZhlQK+AEJYrz7sw2P8g3egzza8lwA
	hRbrrwW/xUSbCbAw==
To: Radu Rendec <rrendec@redhat.com>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?utf-8?Q?Beh=C3=BAn?=
 <kabel@kernel.org>,
 Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>, Eric
 Chanudet <echanude@redhat.com>, Alessandro Carminati
 <acarmina@redhat.com>, Jared Kangas <jkangas@redhat.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] genirq: Add interrupt redirection infrastructure
In-Reply-To: <20251006223813.1688637-2-rrendec@redhat.com>
References: <20251006223813.1688637-1-rrendec@redhat.com>
 <20251006223813.1688637-2-rrendec@redhat.com>
Date: Tue, 07 Oct 2025 22:04:06 +0200
Message-ID: <87ecre32dl.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 06 2025 at 18:38, Radu Rendec wrote:
> +
> +static bool demux_redirect_remote(struct irq_desc *desc)
> +{
> +#ifdef CONFIG_SMP

Please have a function and a stub for the !SMP case.

> +	const struct cpumask *m = irq_data_get_effective_affinity_mask(&desc->irq_data);
> +	unsigned int target_cpu = READ_ONCE(desc->redirect.fallback_cpu);

what means fallback_cpu in this context? That's confusing at best. 

> +	if (!cpumask_test_cpu(smp_processor_id(), m)) {

Why cpumask_test?

    if (target != smp_processor_id()

should be good enough and understandable :)

> +		/* Protect against shutdown */
> +		if (desc->action)
> +			irq_work_queue_on(&desc->redirect.work, target_cpu);

Can you please document why this is correct vs. CPU hotplug (especially unplug)?

I think it is, but I didn't look too carefully.

> +/**
> + * generic_handle_demux_domain_irq - Invoke the handler for a hardware interrupt
> + *				     of a demultiplexing domain.
> + * @domain:	The domain where to perform the lookup
> + * @hwirq:	The hardware interrupt number to convert to a logical one
> + *
> + * Returns:	True on success, or false if lookup has failed
> + */
> +bool generic_handle_demux_domain_irq(struct irq_domain *domain, unsigned int hwirq)
> +{
> +	struct irq_desc *desc = irq_resolve_mapping(domain, hwirq);
> +
> +	if (unlikely(!desc))
> +		return false;
> +
> +	scoped_guard(raw_spinlock, &desc->lock) {
> +		if (desc->irq_data.chip->irq_pre_redirect)
> +			desc->irq_data.chip->irq_pre_redirect(&desc->irq_data);

I'd rather see that in the redirect function aboive.

> +		if (demux_redirect_remote(desc))
> +			return true;
> +	}
> +	return !handle_irq_desc(desc);
> +}
> +EXPORT_SYMBOL_GPL(generic_handle_demux_domain_irq);
> +
>  #endif
>  
>  /* Dynamic interrupt handling */
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index c94837382037e..ed8f8b2667b0b 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -35,6 +35,16 @@ static int __init setup_forced_irqthreads(char *arg)
>  early_param("threadirqs", setup_forced_irqthreads);
>  #endif
>  
> +#ifdef CONFIG_SMP
> +static inline void synchronize_irqwork(struct irq_desc *desc)
> +{
> +	/* Synchronize pending or on the fly redirect work */
> +	irq_work_sync(&desc->redirect.work);
> +}
> +#else
> +static inline void synchronize_irqwork(struct irq_desc *desc) { }
> +#endif
> +
>  static int __irq_get_irqchip_state(struct irq_data *d, enum irqchip_irq_state which, bool *state);
>  
>  static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
> @@ -43,6 +53,8 @@ static void __synchronize_hardirq(struct irq_desc *desc, bool sync_chip)
>  	bool inprogress;
>  
>  	do {
> +		synchronize_irqwork(desc);

That can't work. irq_work_sync() requires interrupts and preemption
enabled. But __synchronize_hardirq() can be invoked from interrupt or
preemption disabled context.

And it's not required at all beacuse that's not any different from a
hardware device interrupt. Either it is already handled (IRQ_INPROGRESS)
on some other CPU or not. That code can't anticipiate that there is a
interrupt somewhere on the flight in the system and not yet raised and
handled in a CPU.

Though you want to invoke it in __synchronize_irq() _before_ invoking
__synchronize_hardirq().

Thanks,

        tglx





