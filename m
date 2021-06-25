Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61353B487C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhFYRyp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Jun 2021 13:54:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229630AbhFYRyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Jun 2021 13:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624643541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Np0xO1RJa8Fe+o0fE+8kFFb6yFJ3EzhbKHebm61tvY8=;
        b=EMsy/twQiSuiWXxDvsqMXKElfFERbu+jKS+iBmRoj8bxzjJHtTjmc6r1n79zCy2lTZr6Xd
        Aol6V7D/3tLjzIACkY4zhFov46ZSfVA/FfUKahyBLPiaYZEb36i/OsSfQxE86xjLzYVEMG
        LW4+gHO1Ej/9EKoAmqeQDXMP5pi/NLA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-X5Q2yEmpPWuQy21dWNARtQ-1; Fri, 25 Jun 2021 13:52:20 -0400
X-MC-Unique: X5Q2yEmpPWuQy21dWNARtQ-1
Received: by mail-lj1-f197.google.com with SMTP id 1-20020a2e0d010000b029015d8fce4f1bso3557173ljn.17
        for <linux-pci@vger.kernel.org>; Fri, 25 Jun 2021 10:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Np0xO1RJa8Fe+o0fE+8kFFb6yFJ3EzhbKHebm61tvY8=;
        b=VRYjirI9ob55iLgjRcewem+jhYbzjjiYfvAcJgaVCAhEAq8uUh4N8IDZH30I8ycgJi
         1h9yIsFAe2R4kzOTYP6Lsyx94ToJ9dIKFWLqqvZLd7qVtSB9SGiWkKvXSgfobakh/55c
         0kDOD/Qh8xHI4g7z8icT6cpZtzZtBMKnIohsTqSYc3cxqF8CTEd9WBCV7dqoRitq8Uw3
         PJgDdMMFrlMneiJkhyE3/BZo1IlsFaFw0x7lM4t/yQJp3olSCICjeOqPNbekFbE+W9rM
         Bv3mb/mPKdptPJhuIxygfSG8UDRNz93/9uLRazqIj4Q8YoHAIIvaOaGGZkm7ktxP261T
         W0Jg==
X-Gm-Message-State: AOAM533N7PW6MHShNHy6b17/b7e9CwcSgy8RYNYVbRMLxPCJjPlA7pyh
        9mhP23CrENv5wA5y6EOMXOeyBeaW+h5SlqBEBQuI4jW2ETIxid3PTwhkwJtN4lIdzoIkdeJtYFd
        x1xNmc7XAj6sjkpe8MzkIeetO0z1PGNRYtWfT
X-Received: by 2002:a05:6512:1188:: with SMTP id g8mr9091321lfr.114.1624643538651;
        Fri, 25 Jun 2021 10:52:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv3ONlbYdOAJeKoocH2JT7i37U2k3Ba34lvXyyU9Xl8b/vh+ACiLOhDBLiq7MSlh/s914KOVChB9p0l3+RVAk=
X-Received: by 2002:a05:6512:1188:: with SMTP id g8mr9091276lfr.114.1624643538381;
 Fri, 25 Jun 2021 10:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210617182242.8637-1-nitesh@redhat.com> <20210617182242.8637-2-nitesh@redhat.com>
In-Reply-To: <20210617182242.8637-2-nitesh@redhat.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 25 Jun 2021 13:52:04 -0400
Message-ID: <CAFki+Ln=OS1unuybbD0MKmeJwZci66j6m5OjpNvKDN74E0qw2Q@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] genirq: Provide new interfaces for affinity hints
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     intel-wired-lan@lists.osuosl.org,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, jbrandeb@kernel.org,
        frederic@kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rostedt@goodmis.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com,
        Stefan Assmann <sassmann@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, kashyap.desai@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        suganath-prabu.subramani@broadcom.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, Ken Cox <jkc@redhat.com>,
        faisal.latif@intel.com, shiraz.saleem@intel.com, tariqt@nvidia.com,
        Alaa Hleihel <ahleihel@redhat.com>,
        Kamal Heib <kheib@redhat.com>, borisp@nvidia.com,
        saeedm@nvidia.com, benve@cisco.com, govind@gmx.com,
        jassisinghbrar@gmail.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 17, 2021 at 2:23 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The discussion about removing the side effect of irq_set_affinity_hint() of
> actually applying the cpumask (if not NULL) as affinity to the interrupt,
> unearthed a few unpleasantries:
>
>   1) The modular perf drivers rely on the current behaviour for the very
>      wrong reasons.
>
>   2) While none of the other drivers prevents user space from changing
>      the affinity, a cursorily inspection shows that there are at least
>      expectations in some drivers.
>
> #1 needs to be cleaned up anyway, so that's not a problem
>
> #2 might result in subtle regressions especially when irqbalanced (which
>    nowadays ignores the affinity hint) is disabled.
>
> Provide new interfaces:
>
>   irq_update_affinity_hint()  - Only sets the affinity hint pointer
>   irq_set_affinity_and_hint() - Set the pointer and apply the affinity to
>                                 the interrupt
>
> Make irq_set_affinity_hint() a wrapper around irq_apply_affinity_hint() and
> document it to be phased out.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> Link: https://lore.kernel.org/r/20210501021832.743094-1-jesse.brandeburg@intel.com
> ---
>  include/linux/interrupt.h | 41 ++++++++++++++++++++++++++++++++++++++-
>  kernel/irq/manage.c       |  8 ++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 2ed65b01c961..4ca491a76033 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -328,7 +328,46 @@ extern int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask);
>  extern int irq_can_set_affinity(unsigned int irq);
>  extern int irq_select_affinity(unsigned int irq);
>
> -extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
> +extern int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +                                    bool setaffinity);
> +
> +/**
> + * irq_update_affinity_hint - Update the affinity hint
> + * @irq:       Interrupt to update
> + * @cpumask:   cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint, but does not change the affinity of the interrupt.
> + */
> +static inline int
> +irq_update_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return __irq_apply_affinity_hint(irq, m, false);
> +}
> +
> +/**
> + * irq_set_affinity_and_hint - Update the affinity hint and apply the provided
> + *                          cpumask to the interrupt
> + * @irq:       Interrupt to update
> + * @cpumask:   cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint and if @cpumask is not NULL it applies it as
> + * the affinity of that interrupt.
> + */
> +static inline int
> +irq_set_affinity_and_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/*
> + * Deprecated. Use irq_update_affinity_hint() or irq_set_affinity_and_hint()
> + * instead.
> + */
> +static inline int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return irq_set_affinity_and_hint(irq, m);
> +}
> +
>  extern int irq_update_affinity_desc(unsigned int irq,
>                                     struct irq_affinity_desc *affinity);
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index ef30b4762947..837b63e63111 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -487,7 +487,8 @@ int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
>  }
>  EXPORT_SYMBOL_GPL(irq_force_affinity);
>
> -int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +                             bool setaffinity)
>  {
>         unsigned long flags;
>         struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> @@ -496,12 +497,11 @@ int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
>                 return -EINVAL;
>         desc->affinity_hint = m;
>         irq_put_desc_unlock(desc, flags);
> -       /* set the initial affinity to prevent every interrupt being on CPU0 */
> -       if (m)
> +       if (m && setaffinity)
>                 __irq_set_affinity(irq, m, false);
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(irq_set_affinity_hint);
> +EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
>
>  static void irq_affinity_notify(struct work_struct *work)
>  {
> --
> 2.27.0
>

It turns out that this patch has an issue. The new interfaces are not
added under the #ifdef (CONFIG_SMP)'s else section.
I will fix it and send a v2 with other changes.


--
Thanks

Nitesh

