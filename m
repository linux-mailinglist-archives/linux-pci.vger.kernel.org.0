Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2C338C8D6
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 16:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhEUOBx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 10:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbhEUOBw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 10:01:52 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C773C061574
        for <linux-pci@vger.kernel.org>; Fri, 21 May 2021 07:00:28 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n83so16743095ybg.0
        for <linux-pci@vger.kernel.org>; Fri, 21 May 2021 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YtKoblwXp8H4kWaQ+7rcWRRPvzi4BWdI1Stwj+sjrso=;
        b=r3kw/7Os29oKozSvkY90OWlphIWTEQU1gJuEnSuCDGgeDzfcW9hmhxG5GKMq/mrzkq
         b34xeLMuaSGjFuKyIj8tzzokyWKN/UGlTnevhK+7T5PJZmEFjxPsWDfiXD52uyGvldU4
         g2ysdAc6rGucqAkXPf7dKhFj2rVe5q+b/PZ66wrMeSEuji5tbNUPis89hYxVjfRMozkE
         ti9l0qQrIHaf324rKfr6lM2yKj+iysWPG+TnnakXGQyzqYkqcrqgOr4FKCHu0dzD3LI+
         mqA4L9QFvvAVAGMNLFuMwFfDegpd294ultzdT9JQNzbsHjjxXh7J2JouiPiEO8LJF1fr
         coRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YtKoblwXp8H4kWaQ+7rcWRRPvzi4BWdI1Stwj+sjrso=;
        b=TEFe0j/ZTTud1Z9mGo2elLhnZgYAxcPqzlnnHLNt5+9t6+XAlUc7UygYDVdNDeFN/b
         PjUZHLVvVKdxDC2Gd2ZCrvPMU0ZJdJ/+NzkOnayakdMcOemV2uCQsxyPOIvDGPzdPknT
         ps6hyGIzf6R7l4r9VepwtnmkQ985ozzrTjWEPp/1dhq75h5zq6Y0gM+ArMlFgZPGye3m
         n7LaFQWxUj8ksURh+DsQndnoAjOANo55RImMoONoVXoUt3ak0dqsLaEXvYzYX5UQZBl6
         qxm223i41MN25txR4qV5+vzYij2QcGoQHWnyGbyKQ9KZKJB4Mye5XohSyKu+4VGziBFJ
         10Xg==
X-Gm-Message-State: AOAM530qRzJAoL6zV35KEJe3eo/gz1+DEC/t9jusYHOp+FKIjmlEtd4H
        eEaiS61UIH/Z5tj6jql+IQzWugynBJ1NEHHxG9s3dyqAt4GVRQ==
X-Google-Smtp-Source: ABdhPJzb+REqCcRfp1xPlovOTcfQ3DQwdU4LJK0JFoiZHllWaxORHD14QiRf//icYYlGoYjwk55i2x/F0moTgBIToZE=
X-Received: by 2002:a25:b84f:: with SMTP id b15mr15820251ybm.319.1621605627551;
 Fri, 21 May 2021 07:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali> <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com> <CABLWAfQsspRJdqHJ1o5WGzDYne_uSk-8qdAzQ1LtzGtgM4Yhxg@mail.gmail.com>
In-Reply-To: <CABLWAfQsspRJdqHJ1o5WGzDYne_uSk-8qdAzQ1LtzGtgM4Yhxg@mail.gmail.com>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Fri, 21 May 2021 16:00:16 +0200
Message-ID: <CABLWAfSV1WhToV8VWVUyGOPPr4mPC_Md6pb=1RkO0y=eK+JW7w@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reading back the patches - and comparing them to the multi-MSI driver
versions that are using "order_base_2(nr_irqs)"
it seems that our engineering went on a different route.
We store the allocated hwirq in the MSI message data field (shifted by
5 - to leave room for the max 32 vectors).
So instead of using something like find_next_bit() - and i guess in
that case you really need properly aligned bitfields - we
use all the available data from the msi vector to be able to infer the
proper virq number.

btw - my interpretation can be totally bogus - since it was a while i
looked on the MSI code.

On Fri, May 21, 2021 at 1:39 PM Sandor Bodo-Merle <sbodomerle@gmail.com> wr=
ote:
>
> Digging up our patch queue - i found another multi-MSI related fix:
>
>     Unfortunately the reverse mapping of the hwirq - as made by
>     irq_find_mapping() was not applied to the message data only, but
>     also to the MSI vector, which was lost as a result.
>     Make sure that the reverse mapping is applied to the proper hwirq,
>     contained in the message data.
>     Tested on Saber2 and Katana2.
>
>     Fixes: fc54bae288182 ("PCI: iproc: Allow allocation of multiple MSIs"=
)
>
> diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-iproc-=
msi.c
> index 990fc906d73d..708fdb1065f8 100644
> --- drivers/pci/host/pcie-iproc-msi.c
> +++ drivers/pci/host/pcie-iproc-msi.c
> @@ -237,7 +237,12 @@ static void iproc_msi_irq_compose_msi_msg(struct
> irq_data *data,
>         addr =3D msi->msi_addr + iproc_msi_addr_offset(msi, data->hwirq);
>         msg->address_lo =3D lower_32_bits(addr);
>         msg->address_hi =3D upper_32_bits(addr);
> -       msg->data =3D data->hwirq << 5;
> +       /*
> +        * Since we have multiple hwirq mapped to a single MSI vector,
> +        * now we need to derive the hwirq at CPU0.  It can then be used =
to
> +        * mapped back to virq.
> +        */
> +       msg->data =3D hwirq_to_canonical_hwirq(msi, data->hwirq) << 5;
>  }
>
>  static struct irq_chip iproc_msi_bottom_irq_chip =3D {
> @@ -307,14 +312,8 @@ static inline u32 decode_msi_hwirq(struct
> iproc_msi *msi, u32 eq, u32 head)
>         offs =3D iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
>         msg =3D (u32 *)(msi->eq_cpu + offs);
>         hwirq =3D readl(msg);
> -       hwirq =3D (hwirq >> 5) + (hwirq & 0x1f);
>
> -       /*
> -        * Since we have multiple hwirq mapped to a single MSI vector,
> -        * now we need to derive the hwirq at CPU0.  It can then be used =
to
> -        * mapped back to virq.
> -        */
> -       return hwirq_to_canonical_hwirq(msi, hwirq);
> +       return hwirq;
>  }
>
>  static void iproc_msi_handler(struct irq_desc *desc)
> @@ -360,7 +359,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
>                 /* process all outstanding events */
>                 while (nr_events--) {
>                         hwirq =3D decode_msi_hwirq(msi, eq, head);
> -                       virq =3D irq_find_mapping(msi->inner_domain, hwir=
q);
> +                       virq =3D irq_find_mapping(msi->inner_domain,
> hwirq >> 5) + (hwirq & 0x1f);
>                         generic_handle_irq(virq);
>
>                         head++;
>
> On Thu, May 20, 2021 at 7:11 PM Ray Jui <ray.jui@broadcom.com> wrote:
> >
> >
> >
> > On 5/20/2021 7:22 AM, Sandor Bodo-Merle wrote:
> > > On Thu, May 20, 2021 at 4:05 PM Pali Roh=C3=A1r <pali@kernel.org> wro=
te:
> > >>
> > >> Hello!
> > >>
> > >> On Thursday 20 May 2021 15:47:46 Sandor Bodo-Merle wrote:
> > >>> Hi Pali,
> > >>>
> > >>> thanks for catching this - i dig up the followup fixup commit we ha=
ve
> > >>> for the iproc multi MSI (it was sent to Broadcom - but unfortunatel=
y
> > >>> we missed upstreaming it).
> > >>>
> > >>> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs=
")
> > >>> failed to reserve the proper number of bits from the inner domain.
> > >>> We need to allocate the proper amount of bits otherwise the domains=
 for
> > >>> multiple PCIe endpoints may overlap and freeing one of them will re=
sult
> > >>> in freeing unrelated MSI vectors.
> > >>>
> > >>> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs=
")
> > >>> ---
> > >>>  drivers/pci/host/pcie-iproc-msi.c | 8 ++++----
> > >>>  1 file changed, 4 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-=
iproc-msi.c
> > >>> index 708fdb1065f8..a00492dccb74 100644
> > >>> --- drivers/pci/host/pcie-iproc-msi.c
> > >>> +++ drivers/pci/host/pcie-iproc-msi.c
> > >>> @@ -260,11 +260,11 @@ static int iproc_msi_irq_domain_alloc(struct
> > >>> irq_domain *domain,
> > >>>
> > >>>         mutex_lock(&msi->bitmap_lock);
> > >>>
> > >>> -       /* Allocate 'nr_cpus' number of MSI vectors each time */
> > >>> +       /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI
> > >>> vectors each time */
> > >>>         hwirq =3D bitmap_find_next_zero_area(msi->bitmap, msi->nr_m=
si_vecs, 0,
> > >>> -                                          msi->nr_cpus, 0);
> > >>> +                                          msi->nr_cpus * nr_irqs, =
0);
> > >>
> > >> I'm not sure if this construction is correct. Multi-MSI interrupts n=
eeds
> > >> to be aligned to number of requested interrupts. So if wifi driver a=
sks
> > >> for 32 Multi-MSI interrupts then first allocated interrupt number mu=
st
> > >> be dividable by 32.
> > >>
> > >
> > > Ahh - i guess you are right. In our internal engineering we always
> > > request 32 vectors.
> > > IIRC the multiply by "nr_irqs" was added for iqr affinity to work cor=
rectly.
> > >
> >
> > May I ask which platforms are you guys running this driver on? Cygnus o=
r
> > Northstar? Not that it matters, but just out of curiosity.
> >
> > Let me start by explaining how MSI support works in this driver, or mor=
e
> > precisely, for all platforms that support this iProc based event queue
> > MSI scheme:
> >
> > In iProc PCIe core, each MSI group is serviced by a GIC interrupt
> > (hwirq) and a dedicated event queue (event queue is paired up with
> > hwirq).  Each MSI group can support up to 64 MSI vectors. Note 64 is th=
e
> > depth of the event queue.
> >
> > The number of MSI groups varies between different iProc SoCs. The total
> > number of CPU cores also varies. To support MSI IRQ affinity, we
> > distribute GIC interrupts across all available CPUs.  MSI vector is
> > moved from one GIC interrupt to another to steer to the target CPU.
> >
> > Assuming:
> > The number of MSI groups (the number of total hwirq for this PCIe
> > controller) is M
> > The number of CPU cores is N
> > M is always a multiple of N (we ensured that in the setup function)
> >
> > Therefore:
> > Total number of raw MSI vectors =3D M * 64
> > Total number of supported MSI vectors =3D (M * 64) / N
> >
> > I guess I'm not too clear on what you mean by "multi-MSI interrupts
> > needs to be aligned to number of requested interrupts.". Would you be
> > able to plug this into the above explanation so we can have a more clea=
r
> > understanding of what you mean here?
> >
> > In general, I don't see much issue of allocating 'msi->nr_cpus *
> > nr_irqs' here as long as we can still meet the affinity distribution
> > requirement as mentioned above.
> >
> > Example in the dw PCIe driver does the following for reserving in the
> > bitmap:
> >
> > bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
> > order_base_2(nr_irqs));
> >
> > >>>         if (hwirq < msi->nr_msi_vecs) {
> > >>> -               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> > >>> +               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus * nr_ir=
qs);
> > >>
> > >> And another issue is that only power of 2 interrupts for Multi-MSI c=
an
> > >> be allocated. Otherwise one number may be allocated to more devices.
> > >>
> > >> But I'm not sure how number of CPUs affects it as other PCIe control=
ler
> > >> drivers do not use number of CPUs.
> >
> > As I explained above, we definitely need to take nr_cpus into account,
> > since we cannot move around the physical interrupt between CPUs.
> > Instead, we dedicate each physical interrupt to the CPU and service the
> > MSI across different event queues accordingly when user change irq affi=
nity.
> >
> > >>
> > >> Other drivers are using bitmap_find_free_region() function with
> > >> order_base_2(nr_irqs) as argument.
> > >>
> >
> > Yes we should do that too.
> >
> > >> I hope that somebody else more skilled with MSI interrupts look at t=
hese
> > >> constructions if are correct or needs more rework.
> > >>
> > >
> > > I see the point - i'll ask also in our engineering department ...
> > >
> > >>>         } else {
> > >>>                 mutex_unlock(&msi->bitmap_lock);
> > >>>                 return -ENOSPC;
> > >>> @@ -292,7 +292,7 @@ static void iproc_msi_irq_domain_free(struct
> > >>> irq_domain *domain,
> > >>>         mutex_lock(&msi->bitmap_lock);
> > >>>
> > >>>         hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq);
> > >>> -       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> > >>> +       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
> > >>>
> > >>>         mutex_unlock(&msi->bitmap_lock);
> > >>>
> > >>>
> > >>> On Thu, May 20, 2021 at 2:04 PM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
> > >>>>
> > >>>> Hello!
> > >>>>
> > >>>> I think there is a bug in pcie-iproc-msi.c driver. It declares
> > >>>> Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:
> > >>>>
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n174
> > >>>>
> > >>>> but its iproc_msi_irq_domain_alloc() function completely ignores n=
r_irqs
> > >>>> argument when allocating interrupt numbers from bitmap, see:
> > >>>>
> > >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/drivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n246
> > >>>>
> > >>>> I think this this is incorrect as alloc callback should allocate n=
r_irqs
> > >>>> multi interrupts as caller requested. All other drivers with Multi=
 MSI
> > >>>> support are doing it.
> > >>>>
> > >>>> Could you look at it?
