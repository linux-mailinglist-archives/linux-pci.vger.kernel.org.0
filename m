Return-Path: <linux-pci+bounces-22804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A604A4D321
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 06:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59148166B2E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 05:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41551EDA1E;
	Tue,  4 Mar 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AW6Vflss"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41687156F3C
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741067340; cv=none; b=jS4x2YhSEew2gq7TJc9VWeB2SroeqwIRSsYCmLSRNWG3M30pNgA8t9V6UYyOEV4bbFhWGXF1be3LiZljd2fuTl08hb3R3KqFMNZatVHuXPBAwf7UG3vMi3ZgoWq3mAyyN0IZevtyuYoCJ7mWrvEzxnzIvQ8v6am2LwMtL6/arIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741067340; c=relaxed/simple;
	bh=i8pLZi+5HRo8PRoBRhDlUuE/aOqMyDjrmWFHZbyaMRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFN0LhTQKAgx0hWQXwW7lLqL+a6qUPR7X0nsB8dYHRgNhPWyrxCcHV8Sn2XSm9d+tJGJ7qcvsaWFG/IpkGJgbidVICdZHFF5YZPnCvzgjydIis3FgserD3RZf4wYDaIjgssVVCRqrJcbQT+EW/HJiVj5zHLQlt4bCD5+l3fM58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AW6Vflss; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474f15a2087so7172741cf.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Mar 2025 21:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741067338; x=1741672138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLQmW9gJfmAdRyRpGoDitlnD+ozdb0nSWTFPd64frvs=;
        b=AW6VflssjaP4Ui6yBHM8mC8qSbcBzYwP1vRYj5cCHix9JOvSWYDRN9GprJ/RgcQDMZ
         nSfGOxC16o+ACMlTejwQw4FpYBzv9VW1gcGL80S0pQPYo7HOAJpCPTsunJ31sP6hLr+A
         lbIwNhnZVH6ljkYpSnVJjJYaZx1QGpGxR+46ogBV2tqjzcrizOAh36TVsNfa3KFCeKIz
         Xviz6RNSyW3r5YhTezhArZFPEkTDaIBgJMskHX0H2zl8HnsWDWF3LCvCfWkCDCljR5vZ
         EzaOs4g6BvFbugcoD6xGPRub3fnZPqQkiUqDquu6B6RFWaobAUFtBj242x8BaeHsBiw8
         a/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741067338; x=1741672138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLQmW9gJfmAdRyRpGoDitlnD+ozdb0nSWTFPd64frvs=;
        b=UsmvjCGIVpNAGk1TbaJ0Kibzup1baeIST8zdoZW0eZNuKqEE1s8VdUhQCOm311F5No
         llqI2ON7YVa+Hx+MEhTKVwglr626RrWEdLIeGtarqjyZLZykpO859EA6zATUthgeSk0x
         7nsJqhjGOSyV6wytKbzEyJe6z0u+a7/VB38AVxS9phtnXb/afpMpqw3Lcy6LYNTNduhL
         BneKbkVnQd1L4sf85Jsh9apOo08Oc/vLOe/M7pHqWMnYdsJ2DRw+TyyeKRL6h1WvadQ+
         esGhMwJLbyoZhV8lsyhpxU/+CocHWB+C2AcTuRq/VUhT2fMhuvvGtO7TuZHNKKHvXICq
         ZF7w==
X-Forwarded-Encrypted: i=1; AJvYcCU7Befsr1JXUEih/HJsmTH+LBnkYfaGW6kBz/6+pr3R6tVtwhN7sBYopJ6pNvllH2Jkvex7jYWLIRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSY7GR3FpCmety/7r84/DK6AlycG8fiMk6toZEvv3gGnEzuUXU
	JIqWrEvSQSBhAFKrhWJFyvl2nUzf6bX2cEHBbKAzkXJONR+cLk85z8xonChclWX7s5lDGoJNTZp
	AxcbV3KFxwKEE2HUySDnSRty/HL23HdJuM9+p
X-Gm-Gg: ASbGncvQQdWrcxGcBOjaZyvWE/+IUOy+Ix7wBKHL4pWADKLaxg3kt8rRCfqWJwlHXXW
	LOLxHeLanApaxTbDgNefNjHmB+DGPR0Xozmet3n4WPUAq0SczCeXSkPtrLBnDoxfPMY8G+JztDz
	UorBOwK6vs59IXfRzrjEUhACHFh1MkfKJH5nrw7QV7Q+l8KqV1weRiW/8=
X-Google-Smtp-Source: AGHT+IHIX17v2faHonFbjv2nSVgY1AnFbcCVwrAAsJBFo8iQfxTxg33sUHVgoCLxEiuuMoEoXJ4IiutISGzUq8ei3Es=
X-Received: by 2002:a05:622a:507:b0:471:f754:db41 with SMTP id
 d75a77b69052e-474bc0f42b9mr251411311cf.34.1741067337818; Mon, 03 Mar 2025
 21:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303070501.2740392-1-danielsftsai@google.com> <87a5a2cwer.ffs@tglx>
In-Reply-To: <87a5a2cwer.ffs@tglx>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Tue, 4 Mar 2025 13:48:45 +0800
X-Gm-Features: AQ5f1JrVllMma2lBhD5bLJdP1zK-LBpZv3sWJ-8dv1_-WrEkEAgiHvkMpRFDCO4
Message-ID: <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Chant <achant@google.com>, 
	Brian Norris <briannorris@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	Mark Cheng <markcheng@google.com>, Ben Cheng <bccheng@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 5:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Mar 03 2025 at 07:05, Daniel Tsai wrote:
> > +/*
> > + * The algo here honor if there is any intersection of mask of
> > + * the existing MSI vectors and the requesting MSI vector. So we
> > + * could handle both narrow (1 bit set mask) and wide (0xffff...)
> > + * cases, return -EINVAL and reject the request if the result of
> > + * cpumask is empty, otherwise return 0 and have the calculated
> > + * result on the mask_to_check to pass down to the irq_chip.
> > + */
> > +static int dw_pci_check_mask_compatibility(struct dw_pcie_rp *pp,
> > +                                        unsigned long ctrl,
> > +                                        unsigned long hwirq_to_check,
> > +                                        struct cpumask *mask_to_check)
> > +{
> > +     unsigned long end, hwirq;
> > +     const struct cpumask *mask;
> > +     unsigned int virq;
> > +
> > +     hwirq =3D ctrl * MAX_MSI_IRQS_PER_CTRL;
> > +     end =3D hwirq + MAX_MSI_IRQS_PER_CTRL;
> > +     for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
> > +             if (hwirq =3D=3D hwirq_to_check)
> > +                     continue;
> > +             virq =3D irq_find_mapping(pp->irq_domain, hwirq);
> > +             if (!virq)
> > +                     continue;
> > +             mask =3D irq_get_affinity_mask(virq);
>
> What protects @mask against a concurrent modification?

We hold the &pp->lock in the dw_pci_msi_set_affinity before calling
this function
so that should help to protect against concurrent modification ?

>
> > +             if (!cpumask_and(mask_to_check, mask, mask_to_check))
> > +                     return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static void dw_pci_update_effective_affinity(struct dw_pcie_rp *pp,
> > +                                          unsigned long ctrl,
> > +                                          const struct cpumask *effect=
ive_mask,
> > +                                          unsigned long hwirq_to_check=
)
> > +{
> > +     struct irq_desc *desc_downstream;
> > +     unsigned int virq_downstream;
> > +     unsigned long end, hwirq;
> > +
> > +     /*
> > +      * Update all the irq_data's effective mask
> > +      * bind to this MSI controller, so the correct
> > +      * affinity would reflect on
> > +      * /proc/irq/XXX/effective_affinity
> > +      */
> > +     hwirq =3D ctrl * MAX_MSI_IRQS_PER_CTRL;
> > +     end =3D hwirq + MAX_MSI_IRQS_PER_CTRL;
> > +     for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
> > +             virq_downstream =3D irq_find_mapping(pp->irq_domain, hwir=
q);
> > +             if (!virq_downstream)
> > +                     continue;
> > +             desc_downstream =3D irq_to_desc(virq_downstream);
> > +             irq_data_update_effective_affinity(&desc_downstream->irq_=
data,
> > +                                                effective_mask);
>
> Same here.

We hold the &pp->lock in the dw_pci_msi_set_affinity before calling
here, so that could help I think ?

>
> > +     }
> > +}
> > +
> > +static int dw_pci_msi_set_affinity(struct irq_data *d,
> > +                                const struct cpumask *mask, bool force=
)
> > +{
> > +     struct dw_pcie_rp *pp =3D irq_data_get_irq_chip_data(d);
> > +     struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> > +     int ret;
> > +     int virq_parent;
> > +     unsigned long hwirq =3D d->hwirq;
> > +     unsigned long flags, ctrl;
> > +     struct irq_desc *desc_parent;
> > +     const struct cpumask *effective_mask;
> > +     cpumask_var_t mask_result;
> > +
> > +     ctrl =3D hwirq / MAX_MSI_IRQS_PER_CTRL;
> > +     if (!alloc_cpumask_var(&mask_result, GFP_ATOMIC))
> > +             return -ENOMEM;
>
> This does not work on a RT enabled kernel. Allocations with a raw spin
> lock held are not possible.
>

Even with the GFP_ATOMIC flag ? I thought that means it would be safe
to do allocation in the atomic context ?
Didn't work on the RT kernel before, so please enlighten me if I am
wrong and if you don't mind.

> > +     /*
> > +      * Loop through all possible MSI vector to check if the
> > +      * requested one is compatible with all of them
> > +      */
> > +     raw_spin_lock_irqsave(&pp->lock, flags);
> > +     cpumask_copy(mask_result, mask);
> > +     ret =3D dw_pci_check_mask_compatibility(pp, ctrl, hwirq, mask_res=
ult);
> > +     if (ret) {
> > +             dev_dbg(pci->dev, "Incompatible mask, request %*pbl, irq =
num %u\n",
> > +                     cpumask_pr_args(mask), d->irq);
> > +             goto unlock;
> > +     }
> > +
> > +     dev_dbg(pci->dev, "Final mask, request %*pbl, irq num %u\n",
> > +             cpumask_pr_args(mask_result), d->irq);
> > +
> > +     virq_parent =3D pp->msi_irq[ctrl];
> > +     desc_parent =3D irq_to_desc(virq_parent);
> > +     ret =3D desc_parent->irq_data.chip->irq_set_affinity(&desc_parent=
->irq_data,
> > +                                                        mask_result, f=
orce);
>
> Again. Completely unserialized.
>

The reason why we remove the desc_parent->lock protection is because
the chained IRQ structure didn't export parent IRQ to the user space, so we
think this call path should be the only caller. And since we have &pp->lock=
 hold
at the beginning, so that should help to protect against concurrent
modification here ?


> Thanks,
>
>         tglx

Sorry for the test build error, I will fix it and re-send a new patch.

Thanks

