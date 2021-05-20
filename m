Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ED538B196
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 16:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhETOXk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbhETOXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 10:23:39 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D62AC061574
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 07:22:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h202so2429699ybg.8
        for <linux-pci@vger.kernel.org>; Thu, 20 May 2021 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BUF+bUXu+3PbBqBYEMg10fzwxqeeRDFvhSWinzEXuNM=;
        b=aJpu+5ZT+Bof0G+zhogeJUbRCBsJQ++NCESuHhroAG6J5f4qM7CzmAKaprQTnn3yKP
         bKt1yeWraD1ljlOKRvjZnaJQvOFyWQcfm4FZauTKgpFkCS5qgCk9SDDXGL7V1NPgvU/J
         wUNv842wd5aOdpjDJ4XeoMhN8WDqaNoQD5dOn0PNc/AFArYCjCyfuJSz4LfhxAERltft
         rmvItI/CjscBbV247lWIhMXPMxcrKJjuVdGhJBfPz5qSsfAJ5xq65OWZp4r9eHyHdOnC
         iKPPz+V/I2meCcDxs6YNVXleC7EHt9MT09iFd2jjyao1t53RYruroZtk/uZHKGxFru11
         EclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BUF+bUXu+3PbBqBYEMg10fzwxqeeRDFvhSWinzEXuNM=;
        b=MftYmL/1gUrcWr/EqKUWBrPWrMRcaVVEI5NmPN68L/nkOfLKoqG/qmIwCEBNT4aufP
         ahylE/oqN1rMMa6wfAjd6jaGW2uiSYSI94368cu4QJ5tkTaTYHTZi97uqETFRCPXqSwG
         6w4PCDYEmDFae1WbtP3k7NunqUgd5mmwn3wIL2AZfvTBpcFfJH/ZtYvvaE8co1L+k0Hf
         YotE7l8J0OQzFJHUL8h8I8pKFUrk5GqV9X7vIWgiDTRJ2bWJQNpMq6hWAPDEn3l9JavF
         kHWzO6WhXEy1mfL06HjGJx92wf5MHI8/okra1q++59EpupZw/rJ9wgxM+6CmCWWXXAz3
         43zA==
X-Gm-Message-State: AOAM532l9Xrdw+ci5zgSIsdFjSh5W69V60spqF/K8lJWY4KBakXFbRR+
        TZJtyFXCAaQ7ChiGkYy5Tr7ePkP1hMGJe49Vt2o=
X-Google-Smtp-Source: ABdhPJxmTDNnmKCVjGkUikqrjs+ASdv7JF9VwyoCpBk/3wyopU8C0a9D92ZUZkjuUteXM+tE1YBxd8Vx3Em/p9smlVA=
X-Received: by 2002:a25:3342:: with SMTP id z63mr7664251ybz.46.1621520537698;
 Thu, 20 May 2021 07:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali>
In-Reply-To: <20210520140529.rczoz3npjoadzfqc@pali>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Thu, 20 May 2021 16:22:06 +0200
Message-ID: <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 20, 2021 at 4:05 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Hello!
>
> On Thursday 20 May 2021 15:47:46 Sandor Bodo-Merle wrote:
> > Hi Pali,
> >
> > thanks for catching this - i dig up the followup fixup commit we have
> > for the iproc multi MSI (it was sent to Broadcom - but unfortunately
> > we missed upstreaming it).
> >
> > Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> > failed to reserve the proper number of bits from the inner domain.
> > We need to allocate the proper amount of bits otherwise the domains for
> > multiple PCIe endpoints may overlap and freeing one of them will result
> > in freeing unrelated MSI vectors.
> >
> > Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> > ---
> >  drivers/pci/host/pcie-iproc-msi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-ipro=
c-msi.c
> > index 708fdb1065f8..a00492dccb74 100644
> > --- drivers/pci/host/pcie-iproc-msi.c
> > +++ drivers/pci/host/pcie-iproc-msi.c
> > @@ -260,11 +260,11 @@ static int iproc_msi_irq_domain_alloc(struct
> > irq_domain *domain,
> >
> >         mutex_lock(&msi->bitmap_lock);
> >
> > -       /* Allocate 'nr_cpus' number of MSI vectors each time */
> > +       /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI
> > vectors each time */
> >         hwirq =3D bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi_v=
ecs, 0,
> > -                                          msi->nr_cpus, 0);
> > +                                          msi->nr_cpus * nr_irqs, 0);
>
> I'm not sure if this construction is correct. Multi-MSI interrupts needs
> to be aligned to number of requested interrupts. So if wifi driver asks
> for 32 Multi-MSI interrupts then first allocated interrupt number must
> be dividable by 32.
>

Ahh - i guess you are right. In our internal engineering we always
request 32 vectors.
IIRC the multiply by "nr_irqs" was added for iqr affinity to work correctly=
.

> >         if (hwirq < msi->nr_msi_vecs) {
> > -               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> > +               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
>
> And another issue is that only power of 2 interrupts for Multi-MSI can
> be allocated. Otherwise one number may be allocated to more devices.
>
> But I'm not sure how number of CPUs affects it as other PCIe controller
> drivers do not use number of CPUs.
>
> Other drivers are using bitmap_find_free_region() function with
> order_base_2(nr_irqs) as argument.
>
> I hope that somebody else more skilled with MSI interrupts look at these
> constructions if are correct or needs more rework.
>

I see the point - i'll ask also in our engineering department ...

> >         } else {
> >                 mutex_unlock(&msi->bitmap_lock);
> >                 return -ENOSPC;
> > @@ -292,7 +292,7 @@ static void iproc_msi_irq_domain_free(struct
> > irq_domain *domain,
> >         mutex_lock(&msi->bitmap_lock);
> >
> >         hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq);
> > -       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> > +       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
> >
> >         mutex_unlock(&msi->bitmap_lock);
> >
> >
> > On Thu, May 20, 2021 at 2:04 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> > >
> > > Hello!
> > >
> > > I think there is a bug in pcie-iproc-msi.c driver. It declares
> > > Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n174
> > >
> > > but its iproc_msi_irq_domain_alloc() function completely ignores nr_i=
rqs
> > > argument when allocating interrupt numbers from bitmap, see:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n246
> > >
> > > I think this this is incorrect as alloc callback should allocate nr_i=
rqs
> > > multi interrupts as caller requested. All other drivers with Multi MS=
I
> > > support are doing it.
> > >
> > > Could you look at it?
