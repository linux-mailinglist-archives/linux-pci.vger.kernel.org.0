Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C5E39B5BA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 11:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFDJTI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 05:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDJTI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 05:19:08 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87213C06174A
        for <linux-pci@vger.kernel.org>; Fri,  4 Jun 2021 02:17:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id m9so6290341ybo.5
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B1gp+Zd0oKR0HTc5iMyE1hLYFcY/54iV12+JAVMaL38=;
        b=MCAEK2NHYPoH9XK68nRp4cNxc6Vuyx9WmwIP2Cu8Ar8Jq5qY4XTnjRbCftLJSYiXxw
         cRpFMpUzYudgpakvJUTNNPe+vNwN1JqLYqoy+uRcgRl4VB7ll9iAvs9lSBu42ncNqb/G
         JlGrWT7EJ+bwozfnuf4vRpgeHCi7ECjlrGpuDZJ5AzRNlQoakpegBEzaTFpGzjbsETyU
         u5+UuIVCCNJ6teMmEGdAIc57BVrRzqYRRJT5d29NSsEd17VZ5ilAtaJVLrYwVDwEEgaG
         VEHiRIdY8kTJlFHyQxmy/GDbgwdvNlCUr7bZdWL5fPnN9SWWa+fDmu04IXtzuEzduBGW
         zsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B1gp+Zd0oKR0HTc5iMyE1hLYFcY/54iV12+JAVMaL38=;
        b=AbvG+5mmIYMLljx7Rr7txnNvQ0fciX7fyrQ3SfFiv+fcMaiiPW+r/yPKZ7XHs/wNap
         XerK4wI7GOfIoDOxHhSHs1cB8sdptdE8NnOc11X3zkdq29cDe6y4YHK84dKQQrpznEQ7
         otp0a+WOoP+8ZWMFQDePPdmbC0gyGQ0lFHsyykD4RR95+i9+S0ijIzJv5+s8CHEecTXG
         ZWE4YQJm2hdTvEd1QpHO7pLFVucAQNeActiI0BmS/BPNi9mx3o2YpoR6j5lmj0+0m9c1
         TI3P0Od5/by3+vegcFnCycqD+r4cjZalXv90lqorIVnIxt8I1WMOTjo1EaWuzL2QO7sG
         GjKw==
X-Gm-Message-State: AOAM531gvXwO2K5IG8l7d0HfeiUXLBKDrw/r5m/gO69HCcm+dD5/ympu
        XrjmEePbsTnVHsSkKtLfClBFEm45nzm68oHnpP0=
X-Google-Smtp-Source: ABdhPJwLQiUU7yaDO1CYElcU+iIjscRwMQ9r6AbUuze99QSshdaq7oVLEmOGMAeSuQRmN1vNS3Fb/+UpCw8PwBuzI3k=
X-Received: by 2002:a25:4f05:: with SMTP id d5mr3777736ybb.473.1622798237835;
 Fri, 04 Jun 2021 02:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali> <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com> <87pmxgwh7o.wl-maz@kernel.org>
 <13a7e409-646d-40a7-17a0-4e4be011efb2@broadcom.com> <874keqvsf2.wl-maz@kernel.org>
 <CABLWAfSAq50_WvFrqF0+wjqYx3btBrU1kgms3i9dy8GBm4FcdA@mail.gmail.com>
 <87bl8o1x8c.wl-maz@kernel.org> <92a918e6-37cc-8892-a665-4121b3200f00@broadcom.com>
In-Reply-To: <92a918e6-37cc-8892-a665-4121b3200f00@broadcom.com>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Fri, 4 Jun 2021 11:17:05 +0200
Message-ID: <CABLWAfS+yGHRc5Qo9FeSK-1JA_Xm8H6pY5wzEcHkyk491kAvvQ@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Would something like this work on top of the previous patch - or it
needs more checks,
like the "nr_irqs" iniproc_msi_irq_domain_alloc() ?

diff --git drivers/pci/controller/pcie-iproc-msi.c
drivers/pci/controller/pcie-iproc-msi.c
index eede4e8f3f75..49e9d1a761ff 100644
--- drivers/pci/controller/pcie-iproc-msi.c
+++ drivers/pci/controller/pcie-iproc-msi.c
@@ -171,7 +171,7 @@ static struct irq_chip iproc_msi_irq_chip =3D {

 static struct msi_domain_info iproc_msi_domain_info =3D {
        .flags =3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-               MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
+              MSI_FLAG_PCI_MSIX,
        .chip =3D &iproc_msi_irq_chip,
 };

@@ -539,6 +539,9 @@ int iproc_msi_init(struct iproc_pcie *pcie, struct
device_node *node)
        mutex_init(&msi->bitmap_lock);
        msi->nr_cpus =3D num_possible_cpus();

+       if (msi->nr_cpus =3D=3D 1)
+               iproc_msi_domain_info.flags |=3D  MSI_FLAG_MULTI_PCI_MSI;
+
        msi->nr_irqs =3D of_irq_count(node);
        if (!msi->nr_irqs) {
                dev_err(pcie->dev, "found no MSI GIC interrupt\n");

On Thu, Jun 3, 2021 at 6:59 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 6/2/2021 1:34 AM, Marc Zyngier wrote:
> > On Wed, 26 May 2021 17:10:24 +0100,
> > Sandor Bodo-Merle <sbodomerle@gmail.com> wrote:
> >>
> >> [1  <text/plain; UTF-8 (7bit)>]
> >> The following patch addresses the allocation issue - but indeed - wont
> >> fix the atomicity of IRQ affinity in this driver (but the majority of
> >> our product relies on single core SOCs; we also use a dual-core SOC
> >> also - but we don't change the initial the IRQ affinity).
> >>
> >> On Wed, May 26, 2021 at 9:57 AM Marc Zyngier <maz@kernel.org> wrote:
> >>>
> >>> On Tue, 25 May 2021 18:27:54 +0100,
> >>> Ray Jui <ray.jui@broadcom.com> wrote:
> >>>>
> >>>> On 5/24/2021 3:37 AM, Marc Zyngier wrote:
> >>>>> On Thu, 20 May 2021 18:11:32 +0100,
> >>>>> Ray Jui <ray.jui@broadcom.com> wrote:
> >>>>>>
> >>>>>> On 5/20/2021 7:22 AM, Sandor Bodo-Merle wrote:
> >>>
> >>> [...]
> >>>
> >>>>>> I guess I'm not too clear on what you mean by "multi-MSI interrupt=
s
> >>>>>> needs to be aligned to number of requested interrupts.". Would you=
 be
> >>>>>> able to plug this into the above explanation so we can have a more=
 clear
> >>>>>> understanding of what you mean here?
> >>>>>
> >>>>> That's a generic PCI requirement: if you are providing a Multi-MSI
> >>>>> configuration, the base vector number has to be size-aligned
> >>>>> (2-aligned for 2 MSIs, 4 aligned for 4, up to 32), and the end-poin=
t
> >>>>> supplies up to 5 bits that are orr-ed into the base vector number,
> >>>>> with a *single* doorbell address. You effectively provide a single =
MSI
> >>>>> number and a single address, and the device knows how to drive 2^n =
MSIs.
> >>>>>
> >>>>> This is different from MSI-X, which defines multiple individual
> >>>>> vectors, each with their own doorbell address.
> >>>>>
> >>>>> The main problem you have here (other than the broken allocation
> >>>>> mechanism) is that moving an interrupt from one core to another
> >>>>> implies moving the doorbell address to that of another MSI
> >>>>> group. This isn't possible for Multi-MSI, as all the MSIs must have
> >>>>> the same doorbell address. As far as I can see, there is no way to
> >>>>> support Multi-MSI together with affinity change on this HW, and you
> >>>>> should stop advertising support for this feature.
> >>>>>
> >>>>
> >>>> I was not aware of the fact that multi-MSI needs to use the same
> >>>> doorbell address (aka MSI posted write address?). Thank you for help=
ing
> >>>> to point it out. In this case, yes, like you said, we cannot possibl=
y
> >>>> support both multi-MSI and affinity at the same time, since supporti=
ng
> >>>> affinity requires us to move from one to another event queue (and ir=
q)
> >>>> that will have different doorbell address.
> >>>>
> >>>> Do you think it makes sense to do the following by only advertising
> >>>> multi-MSI capability in the single CPU core case (detected runtime v=
ia
> >>>> 'num_possible_cpus')? This will at least allow multi-MSI to work in
> >>>> platforms with single CPU core that Sandor and Pali use?
> >>>
> >>> I don't think this makes much sense. Single-CPU machines are an oddit=
y
> >>> these days, and I'd rather you simplify this (already pretty
> >>> complicated) driver.
> >>>
> >>>>> There is also a more general problem here, which is the atomicity o=
f
> >>>>> the update on affinity change. If you are moving an interrupt from =
one
> >>>>> CPU to the other, it seems you change both the vector number and th=
e
> >>>>> target address. If that is the case, this isn't atomic, and you may
> >>>>> end-up with the device generating a message based on a half-applied
> >>>>> update.
> >>>>
> >>>> Are you referring to the callback in 'irq_set_addinity" and
> >>>> 'irq_compose_msi_msg'? In such case, can you help to recommend a
> >>>> solution for it (or there's no solution based on such architecture)?=
 It
> >>>> does not appear such atomy can be enforced from the irq framework le=
vel.
> >>>
> >>> irq_compose_msi_msg() is only one part of the problem. The core of th=
e
> >>> issue is that the programming of the end-point is not atomic (you nee=
d
> >>> to update a 32bit payload *and* a 64bit address).
> >>>
> >>> A solution to workaround it would be to rework the way you allocate
> >>> the vectors, making them constant across all CPUs so that only the
> >>> address changes when changing the affinity.
> >>>
> >>> Thanks,
> >>>
> >>>         M.
> >>>
> >>> --
> >>> Without deviation from the norm, progress is not possible.
> >> [2 0001-PCI-iproc-fix-the-base-vector-number-allocation-for-.patch <te=
xt/x-diff; UTF-8 (base64)>]
> >> From df31c9c0333ca4922b7978b30719348e368bea3c Mon Sep 17 00:00:00 2001
> >> From: Sandor Bodo-Merle <sbodomerle@gmail.com>
> >> Date: Wed, 26 May 2021 17:48:16 +0200
> >> Subject: [PATCH] PCI: iproc: fix the base vector number allocation for=
 Multi
> >>  MSI
> >> MIME-Version: 1.0
> >> Content-Type: text/plain; charset=3DUTF-8
> >> Content-Transfer-Encoding: 8bit
> >>
> >> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> >> failed to reserve the proper number of bits from the inner domain.
> >> Natural alignment of the base vector number was also not guaranteed.
> >>
> >> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> >> Reported-by: Pali Roh=C3=A1r <pali@kernel.org>
> >> Signed-off-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> >> ---
> >>  drivers/pci/controller/pcie-iproc-msi.c | 18 ++++++++----------
> >>  1 file changed, 8 insertions(+), 10 deletions(-)
> >>
> >> diff --git drivers/pci/controller/pcie-iproc-msi.c drivers/pci/control=
ler/pcie-iproc-msi.c
> >> index eede4e8f3f75..fa2734dd8482 100644
> >> --- drivers/pci/controller/pcie-iproc-msi.c
> >> +++ drivers/pci/controller/pcie-iproc-msi.c
> >> @@ -252,18 +252,15 @@ static int iproc_msi_irq_domain_alloc(struct irq=
_domain *domain,
> >>
> >>      mutex_lock(&msi->bitmap_lock);
> >>
> >> -    /* Allocate 'nr_cpus' number of MSI vectors each time */
> >> -    hwirq =3D bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_vec=
s, 0,
> >> -                                       msi->nr_cpus, 0);
> >> -    if (hwirq < msi->nr_msi_vecs) {
> >> -            bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> >> -    } else {
> >> -            mutex_unlock(&msi->bitmap_lock);
> >> -            return -ENOSPC;
> >> -    }
> >> +    /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI vecto=
rs each time */
> >> +    hwirq =3D bitmap_find_free_region(msi->bitmap, msi->nr_msi_vecs,
> >> +                                    order_base_2(msi->nr_cpus * nr_ir=
qs));
> >>
> >>      mutex_unlock(&msi->bitmap_lock);
> >>
> >> +    if (hwirq < 0)
> >> +            return -ENOSPC;
> >> +
> >>      for (i =3D 0; i < nr_irqs; i++) {
> >>              irq_domain_set_info(domain, virq + i, hwirq + i,
> >>                                  &iproc_msi_bottom_irq_chip,
> >> @@ -284,7 +281,8 @@ static void iproc_msi_irq_domain_free(struct irq_d=
omain *domain,
> >>      mutex_lock(&msi->bitmap_lock);
> >>
> >>      hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq);
> >> -    bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> >> +    bitmap_release_region(msi->bitmap, hwirq,
> >> +                          order_base_2(msi->nr_cpus * nr_irqs));
> >>
> >>      mutex_unlock(&msi->bitmap_lock);
> >>
> >
> > This looks reasonable. However, this doesn't change the issue that you
> > have with SMP systems and Multi-MSI. I'd like to see a more complete
> > patch (disabling Multi-MSI on SMP, at the very least).
> >
>
> Yeah, agree with you that we want to see this patch at least disables
> multi-msi when it detects 'num_possible_cpus' > 1.
>
>
> > Thanks,
> >
> >       M.
> >
