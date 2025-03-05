Return-Path: <linux-pci+bounces-22959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF38A4FD82
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112337A417C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 11:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584A0221F27;
	Wed,  5 Mar 2025 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="reqEhmgk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742ED2E3377
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741173710; cv=none; b=SE2ZJ0ER3Oc0Sw+fBmBJrm79TEVX250tIrIO/+y2FOaWKYdyu2G70dY6SbvZkSv/69Y531pyjSgN7bmXJb1GeIQbGjTCvVqk3dCIBiCgDEiFvOkLQuqNo8DJqJC5C52+FBD+x/aNDOrrJiZWWp+fC8RzIxWLUcDEUCDkWdCEK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741173710; c=relaxed/simple;
	bh=vgYM/G984m2BWXqCa/TQZidOi3XOLL2rDeS0Z8QWpNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9pixyoZ/W2MFykvTnDx/rXu4YRRmoobcfv6XohA/V+URMYHBr9cPL+wyUw7QjmcQbQWtCtDmxvHcNJwI2KQvoZYzvoISAzUVkegNa2BMSN1Nw/fhQiXv/YxGmhaXF0Tk/wOJEijhkXeUrdHuDf0+ZtHipIk0Hn/fq2YcRovfeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=reqEhmgk; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46c8474d8daso58796321cf.3
        for <linux-pci@vger.kernel.org>; Wed, 05 Mar 2025 03:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741173707; x=1741778507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Upd1AM9RnmsMENNaYkv4Fw777JX+i9QYUqGfa9fv560=;
        b=reqEhmgkJnXBSyG/2n629SCVWEsl2utAOCNv9HoUJzvlfUJTeFdFUbUawhuNUw+jNs
         Sr0I16eAZitd+GWYZmVle5oYYGEg70N5Ku41J3tJlO7bHdKwaX2/VN8N2vibMIIdYoeQ
         IQvttaoVYxda+UuSFxuxNAp5gm7fXkNv3FyUb41pvcuo4kVYRt1H/sDecZ60g87TQBa/
         gjNc403Q6clnvYtDB501nm1WY8ejt5Les5T0kGKAzOdSQyM6WzArSiW/AKRGcC2/B7cH
         jOgKOU6pNBJVA7hTkklrTKmeFlyqdAcYYQNXhFcjP0oVx+d2/BS3CinzDUAnq/KEclpZ
         16QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741173707; x=1741778507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Upd1AM9RnmsMENNaYkv4Fw777JX+i9QYUqGfa9fv560=;
        b=OkSQFHaQ5EEleg6la3r7Z0AW0ICz42l0FH1DAy35YMDFp1jDa2Q+U8X828lbl3yGVI
         IJ65skBT1RvgcfaHYKI1TWnl/Rd/oFQbYh8RE7Chkd2lWBmAdCMPsiAbqJ+yGkSh1Eds
         yZTEGMWwEswIqNqmLeLYBqZWnQsS3r0LlBDPdYb9bKJxcowXVCm0lCZ2wQwEo586WNMq
         z3c52qfwsSZBz+JkROMhpDFPdCyy/h/Oz9UszGSJ7SgjaZIBIXn1FkH1yOx19mQ1TOHa
         oCBVIkH8BXnlPo6LgXr4HdQ8CZeKMJxocU3+3jMB6TwfAZLnsSLkpf4E/NtIdvsUQUsb
         zo4A==
X-Forwarded-Encrypted: i=1; AJvYcCVuDIEuiuMqJlLIUJbJ6am6yXLFy+1NfVHKosgiQIIUAMKuX1NDWN7YrP4pauoMb9fg2trr77CcaYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOlDkuFJhKMOKSsu0qGZyAGpDokZxjy3jXzl607e+7q3+I/IED
	PT0da4k2wtRFN6uf4Akb2A1nAegL9DToVF3aF9TslwdMW+22NrDM/tQj+giArRncv0K7uymJeHJ
	14cWNqt0qmeYA93hHCnZH9M++KXP9XMDJfMZm
X-Gm-Gg: ASbGncsq40OGtk3qAbmHPrG9db+nLJOyvyVjv5YYagjKAHblb0UinUsM1TldULQvt/Z
	I5NtJtbvJb0mULRq/T0f8c2j15f5Kc3FQRn53I2HiqN6NodFd7Cmz+PH7NviZmlFuxWjqOyG9EY
	DGbfkbbkyeEzcnGKLGocpXHsa5hINRZAdBtLFfnn6XBxltxyK9wu9K8WG4
X-Google-Smtp-Source: AGHT+IEqQsuKupb9s1R3c2KxmcUEAV1XkN36/VR4Nqu6/DaNfCll0Q4SQR3x+nnbmujQQlnkeK7JRBuPMmX1r4KYX98=
X-Received: by 2002:a05:622a:52:b0:472:2021:b76a with SMTP id
 d75a77b69052e-4750b23c744mr43074751cf.11.1741173706925; Wed, 05 Mar 2025
 03:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303070501.2740392-1-danielsftsai@google.com>
 <87a5a2cwer.ffs@tglx> <CAK7fddD4Y5CJ3hKQvppGB2Bof4ibYDX4mBK3N1y8qt-NVoBb7w@mail.gmail.com>
 <87eczd6scg.ffs@tglx>
In-Reply-To: <87eczd6scg.ffs@tglx>
From: Tsai Sung-Fu <danielsftsai@google.com>
Date: Wed, 5 Mar 2025 19:21:36 +0800
X-Gm-Features: AQ5f1Jr3IP4TOG8eFM-qcQy0d0rB_UNy-xtMP7FquL3wzjxfVKpoUu3AZcI7WYY
Message-ID: <CAK7fddAqDPw1CuvBDUsQApbs1ZSE_ruyTAdsp+c4116C0ZjvVw@mail.gmail.com>
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

On Tue, Mar 4, 2025 at 5:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Mar 04 2025 at 13:48, Tsai Sung-Fu wrote:
> > On Mon, Mar 3, 2025 at 5:10=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> > +     hwirq =3D ctrl * MAX_MSI_IRQS_PER_CTRL;
> >> > +     end =3D hwirq + MAX_MSI_IRQS_PER_CTRL;
> >> > +     for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
> >> > +             if (hwirq =3D=3D hwirq_to_check)
> >> > +                     continue;
> >> > +             virq =3D irq_find_mapping(pp->irq_domain, hwirq);
> >> > +             if (!virq)
> >> > +                     continue;
> >> > +             mask =3D irq_get_affinity_mask(virq);
> >>
> >> What protects @mask against a concurrent modification?
> >
> > We hold the &pp->lock in the dw_pci_msi_set_affinity before calling
> > this function
> > so that should help to protect against concurrent modification ?
>
> So that's the same domain, right?
>

Yes, all from pp->irq_domain allocated by the driver by calling to
irq_domain_create_linear().

I will add the lockdep_assert_held() check.

> >> > +     /*
> >> > +      * Update all the irq_data's effective mask
> >> > +      * bind to this MSI controller, so the correct
> >> > +      * affinity would reflect on
> >> > +      * /proc/irq/XXX/effective_affinity
> >> > +      */
> >> > +     hwirq =3D ctrl * MAX_MSI_IRQS_PER_CTRL;
> >> > +     end =3D hwirq + MAX_MSI_IRQS_PER_CTRL;
> >> > +     for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
> >> > +             virq_downstream =3D irq_find_mapping(pp->irq_domain, h=
wirq);
> >> > +             if (!virq_downstream)
> >> > +                     continue;
> >> > +             desc_downstream =3D irq_to_desc(virq_downstream);
> >> > +             irq_data_update_effective_affinity(&desc_downstream->i=
rq_data,
> >> > +                                                effective_mask);
> >>
> >> Same here.
> >
> > We hold the &pp->lock in the dw_pci_msi_set_affinity before calling
> > here, so that could help I think ?
>
> A comment would be helpful for the casual reader.

Sure, will also add the lockdep_assert_held() check

>
> >>
> >> > +     }
> >> > +}
> >> > +
> >> > +static int dw_pci_msi_set_affinity(struct irq_data *d,
> >> > +                                const struct cpumask *mask, bool fo=
rce)
> >> > +{
> >> > +     struct dw_pcie_rp *pp =3D irq_data_get_irq_chip_data(d);
> >> > +     struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
> >> > +     int ret;
> >> > +     int virq_parent;
> >> > +     unsigned long hwirq =3D d->hwirq;
> >> > +     unsigned long flags, ctrl;
> >> > +     struct irq_desc *desc_parent;
> >> > +     const struct cpumask *effective_mask;
> >> > +     cpumask_var_t mask_result;
> >> > +
> >> > +     ctrl =3D hwirq / MAX_MSI_IRQS_PER_CTRL;
> >> > +     if (!alloc_cpumask_var(&mask_result, GFP_ATOMIC))
> >> > +             return -ENOMEM;
> >>
> >> This does not work on a RT enabled kernel. Allocations with a raw spin
> >> lock held are not possible.
> >>
> >
> > Even with the GFP_ATOMIC flag ? I thought that means it would be safe
> > to do allocation in the atomic context ?
> > Didn't work on the RT kernel before, so please enlighten me if I am
> > wrong and if you don't mind.
>
> https://www.kernel.org/doc/html/latest/locking/locktypes.html#preempt-rt-=
caveats
> https://www.kernel.org/doc/html/latest/locking/locktypes.html#raw-spinloc=
k-t-on-rt
>

I will remove the Allocation and move the cpumask to the device structure.
Thanks for the doc.

> >> > +     /*
> >> > +      * Loop through all possible MSI vector to check if the
> >> > +      * requested one is compatible with all of them
> >> > +      */
> >> > +     raw_spin_lock_irqsave(&pp->lock, flags);
> >> > +     cpumask_copy(mask_result, mask);
> >> > +     ret =3D dw_pci_check_mask_compatibility(pp, ctrl, hwirq, mask_=
result);
> >> > +     if (ret) {
> >> > +             dev_dbg(pci->dev, "Incompatible mask, request %*pbl, i=
rq num %u\n",
> >> > +                     cpumask_pr_args(mask), d->irq);
> >> > +             goto unlock;
> >> > +     }
> >> > +
> >> > +     dev_dbg(pci->dev, "Final mask, request %*pbl, irq num %u\n",
> >> > +             cpumask_pr_args(mask_result), d->irq);
> >> > +
> >> > +     virq_parent =3D pp->msi_irq[ctrl];
> >> > +     desc_parent =3D irq_to_desc(virq_parent);
> >> > +     ret =3D desc_parent->irq_data.chip->irq_set_affinity(&desc_par=
ent->irq_data,
> >> > +                                                        mask_result=
, force);
> >>
> >> Again. Completely unserialized.
> >>
> >
> > The reason why we remove the desc_parent->lock protection is because
> > the chained IRQ structure didn't export parent IRQ to the user space, s=
o we
> > think this call path should be the only caller. And since we have &pp->=
lock hold
> > at the beginning, so that should help to protect against concurrent
> > modification here ?
>
> "Should be the only caller" is not really a technical argument. If you
> make assumptions like this, then you have to come up with a proper
> explanation why this is correct under all circumstances and with all
> possible variants of parent interrupt chips.
>
> Aside of that fiddling with the internals of interrupt descriptors is
> not really justified here. What's wrong with using the existing
> irq_set_affinity() mechanism?
>
> Thanks,
>
>         tglx
>

Using irq_set_affinity() would give us some circular deadlock warning
at the probe stage.
irq_startup() flow would hold the global lock from irq_setup_affinity(), so
deadlock scenario like this below might happen. The irq_set_affinity()
would try to acquire &irq_desc_lock_class
while the dw_pci_msi_set_affinity() already hold the &pp->lock. To
resolve that we would like to reuse the idea to
replace the global lock in irq_set_affinity() with PERCPU structure
from this patch ->
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D64b6d1d7a84538de34c22a6fc92a7dcc2b196b64
Just would like to know if this looks feasible to you ?

  Chain exists of:
  &irq_desc_lock_class --> mask_lock --> &pp->lock
  Possible unsafe locking scenario:
        CPU0                            CPU1
        ----                                   ----
   lock(&pp->lock);
                                               lock(mask_lock);
                                               lock(&pp->lock);
   lock(&irq_desc_lock_class);

  *** DEADLOCK ***

Thanks

