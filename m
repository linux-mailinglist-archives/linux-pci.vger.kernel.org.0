Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F6039E4A5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFGRCN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 13:02:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230331AbhFGRCM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 13:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623085221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TImFWC0HTGVlVbnQIUSZh0jMNDwAtpjYOcXi7DdGfsg=;
        b=X7sfctUwdMPNbRiufy7u2seFoEnlyG9jVK2ZgjV2ZXR8a59QWt9qCxrsBbYwjyFlHZHVdU
        yMxZ64f1hdHAN08sfBHAmno6n9085gBeqmAl9sRTRdmzkd/X7fF/WnWu+UXEPlgav6perf
        l+ncxP85m8agAxHeWqglehQUb598UOo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-nB-yQHLRPPugIs-NtQwwxw-1; Mon, 07 Jun 2021 13:00:18 -0400
X-MC-Unique: nB-yQHLRPPugIs-NtQwwxw-1
Received: by mail-lf1-f71.google.com with SMTP id u7-20020a0565120407b02902ff43b1e7f4so1414107lfk.5
        for <linux-pci@vger.kernel.org>; Mon, 07 Jun 2021 10:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TImFWC0HTGVlVbnQIUSZh0jMNDwAtpjYOcXi7DdGfsg=;
        b=bn6WeTP4QJl4WZ8cAkO5cAbg0x+1dYl6LPVggxX7Z2/KrE2BbSzbKd9bh5e216RcLH
         qa77i4KLrEYw+rbrJ7pUpheFGvDvrjMwRRHfbZ0+CGe0wY1GMm7u2/ZPC5ieC0e73ffQ
         mSV2Y4AKGe41auz9gQMYFlGCQrZEYP6Ic/xKpxSn7gSJ+7IwvHsj/V2+tBsoFaXY/tu2
         sIOQfzRx6wMg+LiP4uvBhRDrzmiVCqrPA2WXARyYpZB6xATnEdGQdp/hLPYWFuSUhYRG
         mbELHKAuzRU40Et+ILWaeteXOVhksQ4QWlRCqUBNba9q+hckHSFvk4wn//TIjPeaaSUi
         lZPw==
X-Gm-Message-State: AOAM531Rko3sBVc2JYHEdkYUGTIm+E7dFm80khs5LZI8TiJYSU3FLN9+
        j53nXfneW4it/XZwV4cSC3qani3EI7udC9lC4NKjpIH9deoNv1fONqnxVxy1eb31+UIvFgTRzWn
        RjaJaGSJdT7jwOy49uUwag1iZwtqCd9eYkZ6O
X-Received: by 2002:a2e:580e:: with SMTP id m14mr7269766ljb.197.1623085217194;
        Mon, 07 Jun 2021 10:00:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTkhzmxCJi6PS7y4jmDE+BJDdiD5YSK4954D2dCrGy7KysHZPt6B2LiTHdtA/lDYEXA8GWz+cruQBsawKJZwc=
X-Received: by 2002:a2e:580e:: with SMTP id m14mr7269730ljb.197.1623085216890;
 Mon, 07 Jun 2021 10:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210504092340.00006c61@intel.com> <87pmxpdr32.ffs@nanos.tec.linutronix.de>
 <CAFki+Lkjn2VCBcLSAfQZ2PEkx-TR0Ts_jPnK9b-5ne3PUX37TQ@mail.gmail.com>
 <87im3gewlu.ffs@nanos.tec.linutronix.de> <CAFki+L=gp10W1ygv7zdsee=BUGpx9yPAckKr7pyo=tkFJPciEg@mail.gmail.com>
 <CAFki+L=eQoMq+mWhw_jVT-biyuDXpxbXY5nO+F6HvCtpbG9V2w@mail.gmail.com>
 <CAFki+LkB1sk3mOv4dd1D-SoPWHOs28ZwN-PqL_6xBk=Qkm40Lw@mail.gmail.com>
 <87zgwo9u79.ffs@nanos.tec.linutronix.de> <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87wnrs9tvp.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 7 Jun 2021 13:00:05 -0400
Message-ID: <CAFki+L=QTOu_O=1uNobVMi2s9mbcxXgSdTLADCpeBWBoPAikgQ@mail.gmail.com>
Subject: Re: [PATCH] genirq: Provide new interfaces for affinity hints
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, jbrandeb@kernel.org,
        "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com,
        Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 21, 2021 at 8:03 AM Thomas Gleixner <tglx@linutronix.de> wrote:
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
>   irq_update_affinity_hint() - Only sets the affinity hint pointer
>   irq_apply_affinity_hint()  - Set the pointer and apply the affinity to
>                                the interrupt
>
> Make irq_set_affinity_hint() a wrapper around irq_apply_affinity_hint() and
> document it to be phased out.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/r/20210501021832.743094-1-jesse.brandeburg@intel.com
> ---
> Applies on:
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> ---
>  include/linux/interrupt.h |   41 ++++++++++++++++++++++++++++++++++++++++-
>  kernel/irq/manage.c       |    8 ++++----
>  2 files changed, 44 insertions(+), 5 deletions(-)
>
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -328,7 +328,46 @@ extern int irq_force_affinity(unsigned i
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
> +       return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/**
> + * irq_apply_affinity_hint - Update the affinity hint and apply the provided
> + *                          cpumask to the interrupt
> + * @irq:       Interrupt to update
> + * @cpumask:   cpumask pointer (NULL to clear the hint)
> + *
> + * Updates the affinity hint and if @cpumask is not NULL it applies it as
> + * the affinity of that interrupt.
> + */
> +static inline int
> +irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return __irq_apply_affinity_hint(irq, m, true);
> +}
> +
> +/*
> + * Deprecated. Use irq_update_affinity_hint() or irq_apply_affinity_hint()
> + * instead.
> + */
> +static inline int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +{
> +       return irq_apply_affinity_hint(irq, cpumask);

Another change required here, the above should be 'm' instead of 'cpumask'.

> +}
> +
>  extern int irq_update_affinity_desc(unsigned int irq,
>                                     struct irq_affinity_desc *affinity);
>
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -487,7 +487,8 @@ int irq_force_affinity(unsigned int irq,
>  }
>  EXPORT_SYMBOL_GPL(irq_force_affinity);
>
> -int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
> +int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
> +                             bool setaffinity)
>  {
>         unsigned long flags;
>         struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
> @@ -496,12 +497,11 @@ int irq_set_affinity_hint(unsigned int i
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
>


-- 
Thanks
Nitesh

