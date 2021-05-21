Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB10438C5D1
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhEULlJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbhEULlH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 May 2021 07:41:07 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FFC061574
        for <linux-pci@vger.kernel.org>; Fri, 21 May 2021 04:39:44 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d14so19111906ybe.3
        for <linux-pci@vger.kernel.org>; Fri, 21 May 2021 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=onYVCEocqRNp5oS3raZ0OM40cNdBRAbNCKRNV8o+g8s=;
        b=VbT/nGkaboIDGLXMP6LtfpPL+j3YvXH0R5dfqa/sBKvchBMkGwvaijqQTbq/9DaLVy
         ETUnLxPPkqqzQ6MbAviGnCuLopcvDDlnEicphvzabYzEzVaoc/d+W5G92EmA9VF0O7my
         bXh5iGPeXvU5pJe0zF3NWzR8pCreAVEz8s21vMyhnaoatdDrPIWBr/24eSgFq3HhJj4j
         8Q4UOOhIobav90nAMpQXOE7l+IWhnzPBf6Ez6YCvVmBTZzPL59/O+J+bh6FNOXEbzgIS
         hS+QGxHvyLUA3Gmj0gIJ8kyI1NrB7UMx8StyesQMwOW1k8maNCH1drUj2R/XratEOu/B
         YzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=onYVCEocqRNp5oS3raZ0OM40cNdBRAbNCKRNV8o+g8s=;
        b=WMfxWbXjHk/uxTcYisFGcGFwyBCBvYsYWfmOp3HoMWrwgk19PWqPsZ7fghTOAIHrKK
         +3xNPEZb8+x9XaG1AuagOYLwe93QpEghjrhVSCbVhN/AI5aLZzc5geRAJKuGclNV8Nce
         rpBHKn5Cu/KlR4s9zpzEWP+7H0d0DsTd9/WFp5Vk31+Bd37colY8Gg0513+mRRdzJ+Iq
         rRS1xUhr9jFvkfX6Yrw6n0gVYgM+b8d2GAyk0xJ3g3FhviBBvrK3RLWBUzoHpIg9fayy
         f6Vvd96T/ILC78ameCM1CbH5ljozw6t8vO2l7Rsaxe/wj9eOeLUoCbkOF/tp/wIs7KGI
         Jgng==
X-Gm-Message-State: AOAM530T8Ju+DmSuWeg6R4s7q4cdkqpjuKU1yguyHVrwIuVrLIsU7TfU
        1h9Vy6cMzSARlJLW8UjARA5/Oag1pYBE9jLSVkJGpTjAKSK9Yw==
X-Google-Smtp-Source: ABdhPJzeV38ocyu/eQInktaADkQIDtKS/Q3jkcEH9vmdJ0oyw/WWf/GBwjLH9/WE9X+GMI0Kwvi0JtfCbIj7RajRZyY=
X-Received: by 2002:a25:880f:: with SMTP id c15mr14644414ybl.373.1621597183809;
 Fri, 21 May 2021 04:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali> <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
In-Reply-To: <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Fri, 21 May 2021 13:39:32 +0200
Message-ID: <CABLWAfQsspRJdqHJ1o5WGzDYne_uSk-8qdAzQ1LtzGtgM4Yhxg@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Digging up our patch queue - i found another multi-MSI related fix:

    Unfortunately the reverse mapping of the hwirq - as made by
    irq_find_mapping() was not applied to the message data only, but
    also to the MSI vector, which was lost as a result.
    Make sure that the reverse mapping is applied to the proper hwirq,
    contained in the message data.
    Tested on Saber2 and Katana2.

    Fixes: fc54bae288182 ("PCI: iproc: Allow allocation of multiple MSIs")

diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-iproc-ms=
i.c
index 990fc906d73d..708fdb1065f8 100644
--- drivers/pci/host/pcie-iproc-msi.c
+++ drivers/pci/host/pcie-iproc-msi.c
@@ -237,7 +237,12 @@ static void iproc_msi_irq_compose_msi_msg(struct
irq_data *data,
        addr =3D msi->msi_addr + iproc_msi_addr_offset(msi, data->hwirq);
        msg->address_lo =3D lower_32_bits(addr);
        msg->address_hi =3D upper_32_bits(addr);
-       msg->data =3D data->hwirq << 5;
+       /*
+        * Since we have multiple hwirq mapped to a single MSI vector,
+        * now we need to derive the hwirq at CPU0.  It can then be used to
+        * mapped back to virq.
+        */
+       msg->data =3D hwirq_to_canonical_hwirq(msi, data->hwirq) << 5;
 }

 static struct irq_chip iproc_msi_bottom_irq_chip =3D {
@@ -307,14 +312,8 @@ static inline u32 decode_msi_hwirq(struct
iproc_msi *msi, u32 eq, u32 head)
        offs =3D iproc_msi_eq_offset(msi, eq) + head * sizeof(u32);
        msg =3D (u32 *)(msi->eq_cpu + offs);
        hwirq =3D readl(msg);
-       hwirq =3D (hwirq >> 5) + (hwirq & 0x1f);

-       /*
-        * Since we have multiple hwirq mapped to a single MSI vector,
-        * now we need to derive the hwirq at CPU0.  It can then be used to
-        * mapped back to virq.
-        */
-       return hwirq_to_canonical_hwirq(msi, hwirq);
+       return hwirq;
 }

 static void iproc_msi_handler(struct irq_desc *desc)
@@ -360,7 +359,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
                /* process all outstanding events */
                while (nr_events--) {
                        hwirq =3D decode_msi_hwirq(msi, eq, head);
-                       virq =3D irq_find_mapping(msi->inner_domain, hwirq)=
;
+                       virq =3D irq_find_mapping(msi->inner_domain,
hwirq >> 5) + (hwirq & 0x1f);
                        generic_handle_irq(virq);

                        head++;

On Thu, May 20, 2021 at 7:11 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
>
> On 5/20/2021 7:22 AM, Sandor Bodo-Merle wrote:
> > On Thu, May 20, 2021 at 4:05 PM Pali Roh=C3=A1r <pali@kernel.org> wrote=
:
> >>
> >> Hello!
> >>
> >> On Thursday 20 May 2021 15:47:46 Sandor Bodo-Merle wrote:
> >>> Hi Pali,
> >>>
> >>> thanks for catching this - i dig up the followup fixup commit we have
> >>> for the iproc multi MSI (it was sent to Broadcom - but unfortunately
> >>> we missed upstreaming it).
> >>>
> >>> Commit fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> >>> failed to reserve the proper number of bits from the inner domain.
> >>> We need to allocate the proper amount of bits otherwise the domains f=
or
> >>> multiple PCIe endpoints may overlap and freeing one of them will resu=
lt
> >>> in freeing unrelated MSI vectors.
> >>>
> >>> Fixes: fc54bae28818 ("PCI: iproc: Allow allocation of multiple MSIs")
> >>> ---
> >>>  drivers/pci/host/pcie-iproc-msi.c | 8 ++++----
> >>>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git drivers/pci/host/pcie-iproc-msi.c drivers/pci/host/pcie-ip=
roc-msi.c
> >>> index 708fdb1065f8..a00492dccb74 100644
> >>> --- drivers/pci/host/pcie-iproc-msi.c
> >>> +++ drivers/pci/host/pcie-iproc-msi.c
> >>> @@ -260,11 +260,11 @@ static int iproc_msi_irq_domain_alloc(struct
> >>> irq_domain *domain,
> >>>
> >>>         mutex_lock(&msi->bitmap_lock);
> >>>
> >>> -       /* Allocate 'nr_cpus' number of MSI vectors each time */
> >>> +       /* Allocate 'nr_irqs' multiplied by 'nr_cpus' number of MSI
> >>> vectors each time */
> >>>         hwirq =3D bitmap_find_next_zero_area(msi->bitmap, msi->nr_msi=
_vecs, 0,
> >>> -                                          msi->nr_cpus, 0);
> >>> +                                          msi->nr_cpus * nr_irqs, 0)=
;
> >>
> >> I'm not sure if this construction is correct. Multi-MSI interrupts nee=
ds
> >> to be aligned to number of requested interrupts. So if wifi driver ask=
s
> >> for 32 Multi-MSI interrupts then first allocated interrupt number must
> >> be dividable by 32.
> >>
> >
> > Ahh - i guess you are right. In our internal engineering we always
> > request 32 vectors.
> > IIRC the multiply by "nr_irqs" was added for iqr affinity to work corre=
ctly.
> >
>
> May I ask which platforms are you guys running this driver on? Cygnus or
> Northstar? Not that it matters, but just out of curiosity.
>
> Let me start by explaining how MSI support works in this driver, or more
> precisely, for all platforms that support this iProc based event queue
> MSI scheme:
>
> In iProc PCIe core, each MSI group is serviced by a GIC interrupt
> (hwirq) and a dedicated event queue (event queue is paired up with
> hwirq).  Each MSI group can support up to 64 MSI vectors. Note 64 is the
> depth of the event queue.
>
> The number of MSI groups varies between different iProc SoCs. The total
> number of CPU cores also varies. To support MSI IRQ affinity, we
> distribute GIC interrupts across all available CPUs.  MSI vector is
> moved from one GIC interrupt to another to steer to the target CPU.
>
> Assuming:
> The number of MSI groups (the number of total hwirq for this PCIe
> controller) is M
> The number of CPU cores is N
> M is always a multiple of N (we ensured that in the setup function)
>
> Therefore:
> Total number of raw MSI vectors =3D M * 64
> Total number of supported MSI vectors =3D (M * 64) / N
>
> I guess I'm not too clear on what you mean by "multi-MSI interrupts
> needs to be aligned to number of requested interrupts.". Would you be
> able to plug this into the above explanation so we can have a more clear
> understanding of what you mean here?
>
> In general, I don't see much issue of allocating 'msi->nr_cpus *
> nr_irqs' here as long as we can still meet the affinity distribution
> requirement as mentioned above.
>
> Example in the dw PCIe driver does the following for reserving in the
> bitmap:
>
> bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
> order_base_2(nr_irqs));
>
> >>>         if (hwirq < msi->nr_msi_vecs) {
> >>> -               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus);
> >>> +               bitmap_set(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs=
);
> >>
> >> And another issue is that only power of 2 interrupts for Multi-MSI can
> >> be allocated. Otherwise one number may be allocated to more devices.
> >>
> >> But I'm not sure how number of CPUs affects it as other PCIe controlle=
r
> >> drivers do not use number of CPUs.
>
> As I explained above, we definitely need to take nr_cpus into account,
> since we cannot move around the physical interrupt between CPUs.
> Instead, we dedicate each physical interrupt to the CPU and service the
> MSI across different event queues accordingly when user change irq affini=
ty.
>
> >>
> >> Other drivers are using bitmap_find_free_region() function with
> >> order_base_2(nr_irqs) as argument.
> >>
>
> Yes we should do that too.
>
> >> I hope that somebody else more skilled with MSI interrupts look at the=
se
> >> constructions if are correct or needs more rework.
> >>
> >
> > I see the point - i'll ask also in our engineering department ...
> >
> >>>         } else {
> >>>                 mutex_unlock(&msi->bitmap_lock);
> >>>                 return -ENOSPC;
> >>> @@ -292,7 +292,7 @@ static void iproc_msi_irq_domain_free(struct
> >>> irq_domain *domain,
> >>>         mutex_lock(&msi->bitmap_lock);
> >>>
> >>>         hwirq =3D hwirq_to_canonical_hwirq(msi, data->hwirq);
> >>> -       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus);
> >>> +       bitmap_clear(msi->bitmap, hwirq, msi->nr_cpus * nr_irqs);
> >>>
> >>>         mutex_unlock(&msi->bitmap_lock);
> >>>
> >>>
> >>> On Thu, May 20, 2021 at 2:04 PM Pali Roh=C3=A1r <pali@kernel.org> wro=
te:
> >>>>
> >>>> Hello!
> >>>>
> >>>> I think there is a bug in pcie-iproc-msi.c driver. It declares
> >>>> Multi MSI support via MSI_FLAG_MULTI_PCI_MSI flag, see:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n174
> >>>>
> >>>> but its iproc_msi_irq_domain_alloc() function completely ignores nr_=
irqs
> >>>> argument when allocating interrupt numbers from bitmap, see:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/pci/controller/pcie-iproc-msi.c?h=3Dv5.12#n246
> >>>>
> >>>> I think this this is incorrect as alloc callback should allocate nr_=
irqs
> >>>> multi interrupts as caller requested. All other drivers with Multi M=
SI
> >>>> support are doing it.
> >>>>
> >>>> Could you look at it?
