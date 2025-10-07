Return-Path: <linux-pci+bounces-37690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A54EBC2E51
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 00:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9DC189924C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E621D618C;
	Tue,  7 Oct 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFZuvdfp"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0734BA37
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759877225; cv=none; b=SqND5XxjkWHn+VFRoYlPRyrh9fe4DNQY/dgsq/k7DnZ+UL87eI0vfFKxNNYea91tSeJtaBS/h9BjOSh7MPBiBkVJpjCLme2/M8YCOhQALcYimGK+f8ggrbryv3eCS21lW2rTNML1hg+OMY1dMAiTXIL46zXf+dEn6lwNVMfB5W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759877225; c=relaxed/simple;
	bh=y2rUAZo6AJmwPpgF6OOA0b4xm1fxFD7dX5bfe2GTvtk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EMH89edKGSca2E1u1hSvwkWUWwBZl7laAbQ2sYCkqOT7v+JRVQwrfMZyHrf0M5973ezFuCpLomO82aioyk1PZ9l6SLIG3HCIOvJNhWiSzgGuBFVeL/TwJGFDqP8gcjOC7Y0QvjOOyaXvrPP1vxJ533SlcqBtNQxhHUv0uW43aIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFZuvdfp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759877222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iXX3OW5I6MBbCO96hdWxk+d8zv3VdehPL4VTnFFUYfA=;
	b=bFZuvdfpJueJkk9enw9vtzuQrIQImDc7wBVQWNZQJbFn4YLv5V+HxzetDj+hYcR5TGV6wD
	eaHoOfNTOfAwsqzs9r6k/ajZwHwrpvioIAvtmCbe5PGA3xDU9ruVPdyi4/xB7eVC/K3gHY
	TVW5rv/jXNGsFG/KfqNnM2IdOLLhWjs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-DY37VR3BNreJFFwmVy31kQ-1; Tue, 07 Oct 2025 18:47:00 -0400
X-MC-Unique: DY37VR3BNreJFFwmVy31kQ-1
X-Mimecast-MFC-AGG-ID: DY37VR3BNreJFFwmVy31kQ_1759877220
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-818c83e607bso78086846d6.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 15:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759877220; x=1760482020;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iXX3OW5I6MBbCO96hdWxk+d8zv3VdehPL4VTnFFUYfA=;
        b=AnjCHJ72BCbKzuaj3+2VEl8SuZFIY9lTrshM05P4phMhvIOe4uQOlhkhwf+W6x61aB
         qmDChlpvGQJUkKbJLARqDAvIbRI+8wegBVQaZI6DduaYusBcUvDG1wjHUjCKBkhP/isV
         Ai+lJEHsnAq4Vvm7HxmkiiOdpyhhxtqGfH5jQtJ3iwBgipwNWQhyB336Xw9I867zws/7
         KE+E78SwkIHe9p9U3NoaxRzjj3J6sfp25LgnRyYe3VzXtelkOSdFLbpS9Z7GMMjzHTpf
         hCU0GyuTnU+32c4EicxAv6frJbosYZZiIMVFgDfDIJ2I5dpBIzJVKq+I3PVqZKIGxog/
         p4Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW1j0H0f7ZpqnWgHeXLiv8kxpjWbUc6nj2YH+JtlLYpTOH2LAO3uetXhQ6Gvctdvm7ydm/kYSqFVOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX93ksHD4lQ8+RT4VVmsI50AuqOkZUZ/j9612NDqEE0Z+TIpWt
	2iyBeOtgWHsClyOtdzcXA/y6LWYdsbFbTghYgik30UZE8Q6e3RRAeKvBt5fHbsu/otStsrR3Y7t
	TkXuiGJ6ZczkoeSB3AKF3S0gwE9xpIb3ZNiPG3wtwp20ybgcpRyXMWU7e9oK1bw==
X-Gm-Gg: ASbGncvGEqQnBEZdHz8BZmYJg/RZ5+6nvXfUXYh0Qxu4r17kwgTv4o04UQZ1tKDwmpn
	HjjYFWghVP62JjaMqA1oNdbJ/pfJMxwQmNs7mRvk8/rd6waHHQ+lBjgtXFP9PfkoS70m+KWd8xM
	C3k5VKy2LGDZY05N+GzETPl8tsMeJyHs/4iHsOO25dxOZG0mcNO+faWQOu1M9sKlUpU3YURkC/Q
	EWp+wkUMekhLZRGapBI63nKC0gjiU/9KKiR0FDTHfNuB/mu4vVbczlkXPwl7cjT7UDCro0isbjM
	DmBFo3ZMODZFKf+0dN5hylFQjv1t0gL1hOiDZk0K2F4xSH6yVJAJ5xz0hGEHTYcuQLNzO3Ru/Rq
	YkFvVTyRmv1sphOnEXvqV+UqUZZHXuHXGlGUD
X-Received: by 2002:a05:622a:14c6:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e6ead7688cmr19213731cf.66.1759877220038;
        Tue, 07 Oct 2025 15:47:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnuELwL5QI73B4WVO5TE/YGXJBcH4wmy0usuPdmUVIeA6W22PrCCo4miVqp00SkzQZGoYLog==
X-Received: by 2002:a05:622a:14c6:b0:4b7:b010:9398 with SMTP id d75a77b69052e-4e6ead7688cmr19213401cf.66.1759877219503;
        Tue, 07 Oct 2025 15:46:59 -0700 (PDT)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55cfd377asm153541471cf.34.2025.10.07.15.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:46:58 -0700 (PDT)
Message-ID: <d9b89d5342e4268ab908791b403b5eca61aabb5c.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] genirq: Add interrupt redirection infrastructure
From: Radu Rendec <rrendec@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, Manivannan Sadhasivam
	 <mani@kernel.org>
Cc: Daniel Tsai <danielsftsai@google.com>, Marek =?ISO-8859-1?Q?Beh=FAn?=	
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Jingoo Han	 <jingoohan1@gmail.com>,
 Brian Masney <bmasney@redhat.com>, Eric Chanudet	 <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas	
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 07 Oct 2025 18:46:57 -0400
In-Reply-To: <87ecre32dl.ffs@tglx>
References: <20251006223813.1688637-1-rrendec@redhat.com>
	 <20251006223813.1688637-2-rrendec@redhat.com> <87ecre32dl.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-07 at 22:04 +0200, Thomas Gleixner wrote:
> On Mon, Oct 06 2025 at 18:38, Radu Rendec wrote:
> > +
> > +static bool demux_redirect_remote(struct irq_desc *desc)
> > +{
> > +#ifdef CONFIG_SMP
>=20
> Please have a function and a stub for the !SMP case.

Will do.

> > +	const struct cpumask *m =3D irq_data_get_effective_affinity_mask(&des=
c->irq_data);
> > +	unsigned int target_cpu =3D READ_ONCE(desc->redirect.fallback_cpu);
>=20
> what means fallback_cpu in this context? That's confusing at best.

Please see below.

> > +	if (!cpumask_test_cpu(smp_processor_id(), m)) {
>=20
> Why cpumask_test?
>=20
> =C2=A0=C2=A0=C2=A0 if (target !=3D smp_processor_id()
>=20
> should be good enough and understandable :)

This is where I deviated from your initial implementation, and I tried
to explain it in the cover letter (text reproduced below).

  | Instead of keeping track of the parent interrupt's affinity setting (or
  | rather the first CPU in its affinity mask) and attempting to pick the
  | same CPU for the child (as the target CPU) if possible, I just check if
  | the child handler fires on a CPU that's part of its affinity mask (whic=
h
  | is already stored anyway). As an optimization for the case when the
  | current CPU is *not* part of the mask and the handler needs to be
  | redirected, I pre-calculate and store the first CPU in the mask, at the
  | time when the child affinity is set. In my opinion, this is simpler and
  | cleaner, at the expense of a cpumask_test_cpu() call on the fast path,
  | because:
  | - It no longer needs to keep track of the parent interrupt's affinity
  |   setting.
  | - If the parent interrupt can run on more than one CPU, the child can
  |   also run on any of those CPUs without being redirected (in case the
  |   child's affinity mask is the same as the parent's or a superset).

Let me provide an example.
- parent affinity is set to 0,1,2,3
- child affinity is set to 2,3
- parent (hardware) interrupt runs on cpu 3

In the original implementation, the child target would be pre-calculated=
=20
as cpu 2, and therefore in the scenario above, the child would be
redirected to cpu 2. But in reality there's no need to redirect because
cpu 3 is part of the child's affinity mask.

Now, to answer your previous question, "fallback_cpu" means the cpu
that we redirect to in case the current cpu is not part of the child's
affinity mask.

> > +		/* Protect against shutdown */
> > +		if (desc->action)
> > +			irq_work_queue_on(&desc->redirect.work, target_cpu);
>=20
> Can you please document why this is correct vs. CPU hotplug (especially u=
nplug)?
>=20
> I think it is, but I didn't look too carefully.

Sure. To be honest, left this unchanged from your original version and
didn't give it much thought. I'll look closer and document it in the
next version.

> > +/**
> > + * generic_handle_demux_domain_irq - Invoke the handler for a hardware=
 interrupt
> > + *				=C2=A0=C2=A0=C2=A0=C2=A0 of a demultiplexing domain.
> > + * @domain:	The domain where to perform the lookup
> > + * @hwirq:	The hardware interrupt number to convert to a logical one
> > + *
> > + * Returns:	True on success, or false if lookup has failed
> > + */
> > +bool generic_handle_demux_domain_irq(struct irq_domain *domain, unsign=
ed int hwirq)
> > +{
> > +	struct irq_desc *desc =3D irq_resolve_mapping(domain, hwirq);
> > +
> > +	if (unlikely(!desc))
> > +		return false;
> > +
> > +	scoped_guard(raw_spinlock, &desc->lock) {
> > +		if (desc->irq_data.chip->irq_pre_redirect)
> > +			desc->irq_data.chip->irq_pre_redirect(&desc->irq_data);
>=20
> I'd rather see that in the redirect function aboive.

What? The scoped_guard() and calling irq_pre_redirect()? Then, if
demux_redirect_remote() becomes a stub when CONFIG_SMP is not defined,
it means irq_pre_redirect() will not be called either, even if it's set
in struct irq_chip.

Now, I don't see any reason why irq_pre_redirect would be set for the
non-SMP case, and in fact it isn't if you look at (currently) the only
implementation, which is dwc PCI (patch 3). Redirection just doesn't
make sense if you have only one cpu.

Perhaps (struct irq_chip).irq_pre_redirect should not even exist (as a
field in the structure) unless CONFIG_SMP is defined?

> > +		if (demux_redirect_remote(desc))
> > +			return true;
> > +	}
> > +	return !handle_irq_desc(desc);
> > +}
> > +EXPORT_SYMBOL_GPL(generic_handle_demux_domain_irq);
> > +
> > =C2=A0#endif
> > =C2=A0
> > =C2=A0/* Dynamic interrupt handling */
> > diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> > index c94837382037e..ed8f8b2667b0b 100644
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -35,6 +35,16 @@ static int __init setup_forced_irqthreads(char *arg)
> > =C2=A0early_param("threadirqs", setup_forced_irqthreads);
> > =C2=A0#endif
> > =C2=A0
> > +#ifdef CONFIG_SMP
> > +static inline void synchronize_irqwork(struct irq_desc *desc)
> > +{
> > +	/* Synchronize pending or on the fly redirect work */
> > +	irq_work_sync(&desc->redirect.work);
> > +}
> > +#else
> > +static inline void synchronize_irqwork(struct irq_desc *desc) { }
> > +#endif
> > +
> > =C2=A0static int __irq_get_irqchip_state(struct irq_data *d, enum irqch=
ip_irq_state which, bool *state);
> > =C2=A0
> > =C2=A0static void __synchronize_hardirq(struct irq_desc *desc, bool syn=
c_chip)
> > @@ -43,6 +53,8 @@ static void __synchronize_hardirq(struct irq_desc *de=
sc, bool sync_chip)
> > =C2=A0	bool inprogress;
> > =C2=A0
> > =C2=A0	do {
> > +		synchronize_irqwork(desc);
>=20
> That can't work. irq_work_sync() requires interrupts and preemption
> enabled. But __synchronize_hardirq() can be invoked from interrupt or
> preemption disabled context.
>=20
> And it's not required at all beacuse that's not any different from a
> hardware device interrupt. Either it is already handled (IRQ_INPROGRESS)
> on some other CPU or not. That code can't anticipiate that there is a
> interrupt somewhere on the flight in the system and not yet raised and
> handled in a CPU.
>=20
> Though you want to invoke it in __synchronize_irq() _before_ invoking
> __synchronize_hardirq().

Same comment as before: I left this unchanged from your original
version and didn't give it much thought. This is definitely one of
those "back to the design board" cases. Thanks for the guidance, and I
will give it more thought and address it in the next version.

--=20

Thanks a lot for reviewing!

Best regards,
Radu


