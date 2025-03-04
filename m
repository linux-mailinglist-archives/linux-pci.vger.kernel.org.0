Return-Path: <linux-pci+bounces-22831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F368A4D912
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 10:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCEEF7AB26A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2EF1FCF72;
	Tue,  4 Mar 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fbqptPq7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HGXPWWFB"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A60E1F891D;
	Tue,  4 Mar 2025 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081604; cv=none; b=pWoqPx55SN5qq6S2jAQZNVH+0fJ/hpifVa/a1Srq0X9qXqzDlkyU6P94iGYwLfb/Zturmc+MTTsMZ4vdBp+QXww31X9dNXNfcgVUxxWxdWcH42WNhj4XRYCNZNfW7kxWZaU+dT/pji1jcm5D0yR8AoKV2JhLpZxDEceivBZ2BLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081604; c=relaxed/simple;
	bh=UMk00EuNH2lKjFtnpyml52S827F53RJjRAon7xO+YZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qnQkEBwu+56mR6wYi3yZAPdosfY2wzUTH/0oSsdXLq1B2z4RklPEkRohqmeqwCuj23crhbXZtGqr9TarKC8ZgJZZ8nqIcnfuAIA3IpqIBgkayJsGGY3RVtKPpldQDXtDd5fOxccY9chCM5wazdy7pk6b9UE7w35vdDfa3YPKWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fbqptPq7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HGXPWWFB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziAg5LrUy7XRPKEmFNKAy4hQ0wSkNtaRL4TH75GunHo=;
	b=fbqptPq7NfPpHDjQRxAA+lyFw6JoXVoUf7RO9sqERMvy4dFAl2+mu2gusD233hSSOisGtR
	uZBso9kF+aWkfoSL95VCMyCRVCu1WdUDMModUmbAK+pxBbTQ8m60Ccc8pkkRv/ki4z8aie
	8IecSBQsm5WCQA1FpDt4lw/KdjdaKEybdueisNt8don/3LhsA2oy50P6xnz6JtJCiEOvgU
	mRIgKvMU/xPKP5PD0lPWs0A7bdNCqW34Ai7iGaaNfD3brKcP+Ze+ihGeIZG03ICruQjCXG
	QKRoPRQUT5D6yhOCZtCgY1DSNmEj2R2jVHjuukwB9iPDFxx3DuwmLFoXGXRKVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziAg5LrUy7XRPKEmFNKAy4hQ0wSkNtaRL4TH75GunHo=;
	b=HGXPWWFBcymb7WxzSbHzq5D6wUa6+LyS9CV1UtdwMVJq3X1G3hJg7cvlnuNi2oTfbz5zl1
	p4E3dUrDP0toGXCA==
To: Tsai Sung-Fu <danielsftsai@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant
 <achant@google.com>, Brian Norris <briannorris@google.com>, Sajid Dalvi
 <sdalvi@google.com>, Mark Cheng <markcheng@google.com>, Ben Cheng
 <bccheng@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to
 the parent
In-Reply-To: <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx>
 <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
Date: Tue, 04 Mar 2025 10:46:39 +0100
Message-ID: <87eczd6scg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04 2025 at 13:48, Tsai Sung-Fu wrote:
> On Mon, Mar 3, 2025 at 5:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>> > +     hwirq =3D ctrl * MAX_MSI_IRQS_PER_CTRL;
>> > +     end =3D hwirq + MAX_MSI_IRQS_PER_CTRL;
>> > +     for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
>> > +             if (hwirq =3D=3D hwirq_to_check)
>> > +                     continue;
>> > +             virq =3D irq_find_mapping(pp->irq_domain, hwirq);
>> > +             if (!virq)
>> > +                     continue;
>> > +             mask =3D irq_get_affinity_mask(virq);
>>
>> What protects @mask against a concurrent modification?
>
> We hold the &pp->lock in the dw_pci_msi_set_affinity before calling
> this function
> so that should help to protect against concurrent modification ?

So that's the same domain, right?

>> > +     /*
>> > +      * Update all the irq_data's effective mask
>> > +      * bind to this MSI controller, so the correct
>> > +      * affinity would reflect on
>> > +      * /proc/irq/XXX/effective_affinity
>> > +      */
>> > +     hwirq =3D ctrl * MAX_MSI_IRQS_PER_CTRL;
>> > +     end =3D hwirq + MAX_MSI_IRQS_PER_CTRL;
>> > +     for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
>> > +             virq_downstream =3D irq_find_mapping(pp->irq_domain, hwi=
rq);
>> > +             if (!virq_downstream)
>> > +                     continue;
>> > +             desc_downstream =3D irq_to_desc(virq_downstream);
>> > +             irq_data_update_effective_affinity(&desc_downstream->irq=
_data,
>> > +                                                effective_mask);
>>
>> Same here.
>
> We hold the &pp->lock in the dw_pci_msi_set_affinity before calling
> here, so that could help I think ?

A comment would be helpful for the casual reader.

>>
>> > +     }
>> > +}
>> > +
>> > +static int dw_pci_msi_set_affinity(struct irq_data *d,
>> > +                                const struct cpumask *mask, bool forc=
e)
>> > +{
>> > +     struct dw_pcie_rp *pp =3D irq_data_get_irq_chip_data(d);
>> > +     struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>> > +     int ret;
>> > +     int virq_parent;
>> > +     unsigned long hwirq =3D d->hwirq;
>> > +     unsigned long flags, ctrl;
>> > +     struct irq_desc *desc_parent;
>> > +     const struct cpumask *effective_mask;
>> > +     cpumask_var_t mask_result;
>> > +
>> > +     ctrl =3D hwirq / MAX_MSI_IRQS_PER_CTRL;
>> > +     if (!alloc_cpumask_var(&mask_result, GFP_ATOMIC))
>> > +             return -ENOMEM;
>>
>> This does not work on a RT enabled kernel. Allocations with a raw spin
>> lock held are not possible.
>>
>
> Even with the GFP_ATOMIC flag ? I thought that means it would be safe
> to do allocation in the atomic context ?
> Didn't work on the RT kernel before, so please enlighten me if I am
> wrong and if you don't mind.

https://www.kernel.org/doc/html/latest/locking/locktypes.html#preempt-rt-ca=
veats
https://www.kernel.org/doc/html/latest/locking/locktypes.html#raw-spinlock-=
t-on-rt

>> > +     /*
>> > +      * Loop through all possible MSI vector to check if the
>> > +      * requested one is compatible with all of them
>> > +      */
>> > +     raw_spin_lock_irqsave(&pp->lock, flags);
>> > +     cpumask_copy(mask_result, mask);
>> > +     ret =3D dw_pci_check_mask_compatibility(pp, ctrl, hwirq, mask_re=
sult);
>> > +     if (ret) {
>> > +             dev_dbg(pci->dev, "Incompatible mask, request %*pbl, irq=
 num %u\n",
>> > +                     cpumask_pr_args(mask), d->irq);
>> > +             goto unlock;
>> > +     }
>> > +
>> > +     dev_dbg(pci->dev, "Final mask, request %*pbl, irq num %u\n",
>> > +             cpumask_pr_args(mask_result), d->irq);
>> > +
>> > +     virq_parent =3D pp->msi_irq[ctrl];
>> > +     desc_parent =3D irq_to_desc(virq_parent);
>> > +     ret =3D desc_parent->irq_data.chip->irq_set_affinity(&desc_paren=
t->irq_data,
>> > +                                                        mask_result, =
force);
>>
>> Again. Completely unserialized.
>>
>
> The reason why we remove the desc_parent->lock protection is because
> the chained IRQ structure didn't export parent IRQ to the user space, so =
we
> think this call path should be the only caller. And since we have &pp->lo=
ck hold
> at the beginning, so that should help to protect against concurrent
> modification here ?

"Should be the only caller" is not really a technical argument. If you
make assumptions like this, then you have to come up with a proper
explanation why this is correct under all circumstances and with all
possible variants of parent interrupt chips.

Aside of that fiddling with the internals of interrupt descriptors is
not really justified here. What's wrong with using the existing
irq_set_affinity() mechanism?

Thanks,

        tglx


