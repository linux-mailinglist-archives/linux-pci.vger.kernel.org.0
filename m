Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8F53AE98D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 15:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhFUNCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 09:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51859 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229727AbhFUNCO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 09:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624280400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+YgUj6PMWgTlE2/zJGxRd3Re9nIIH1KzyMdqnBdCris=;
        b=fsGTr9YzjJ1JGq5aAa3cO+HsV8lnkCdwkFH2iyv5muJCYJ88Qx29M31Z3loVAKC5+s7HSR
        CSkc8sfToBXRo1oDXNu9yEi1wOWu/ofCnTou+zYLRpZOt8TqsIXYThwwQ0JVXLBXxjHlWy
        sUy4m1/21DWgioXzltRxRqNUPnLKWpc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-dHL7ZsV8PTeEW5javLpBRQ-1; Mon, 21 Jun 2021 08:59:58 -0400
X-MC-Unique: dHL7ZsV8PTeEW5javLpBRQ-1
Received: by mail-lj1-f198.google.com with SMTP id h6-20020a2e85c60000b029014fcff4ccdcso9108240ljj.11
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 05:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YgUj6PMWgTlE2/zJGxRd3Re9nIIH1KzyMdqnBdCris=;
        b=FSsSEUfoM3LpqzkhD7ZGx10OWLUAnYLFOuIbP6r5BCcNqazfvL/7nGqZ+XvsHlx4wf
         EKzuPDHkeDOFCBP0Ijc08uE9QCyG54URluuz2GnXv1aFEnk5UK99GM6GixAK4lqFKz+Y
         7h48rlkJYy6A8RmDPPpc9f2Wh7s/lNXufcmeJUdSCbE0pzxEAbiSAzudRST9vufY+jQ7
         8LG4NoGN4rsm4Ogvs6pjNfbtaiCENiv1K90Sa9slfuHhiPw0ZtYFj8Pe/jO+/fj2e57X
         UlVMZlElLOrPH9I14BzRAbGC2BaCLdsVVM3yPToW2AGG8j0Yum/9o4g75wPvp71fILqR
         Y30g==
X-Gm-Message-State: AOAM530gwx7JsiVk7Z6AFeyzfsuaJWyUWkhsuPgjAzH9wPP8lDullD/c
        Qx5bHQLV1clHkktZKaPHoUQwXxrovfENsKKFh5t2K6PYjDL0nQbYUzlW8VvCJMcz12vtrYHD8CN
        d8GhBBQVCqQDbp/hg6aLnugTdPirNsC9X5ibC
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr12543847ljq.14.1624280396491;
        Mon, 21 Jun 2021 05:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgIQ11ykk0gwSlBTwdhqnda7mKHULal69m5BhjOHqEt21B5fLii3Df/yGCCr/pjsOr3FghqA8GvR4oD/ugEpM=
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr12543807ljq.14.1624280396133;
 Mon, 21 Jun 2021 05:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210617182242.8637-1-nitesh@redhat.com> <20210617182242.8637-15-nitesh@redhat.com>
 <YNBHQvo1uDfBbr5c@unreal>
In-Reply-To: <YNBHQvo1uDfBbr5c@unreal>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 21 Jun 2021 08:59:44 -0400
Message-ID: <CAFki+LkVBjL_D24-DCFyctHFwFZuy4KhV0dGz=8jC0U16vZpFQ@mail.gmail.com>
Subject: Re: [PATCH v1 14/14] net/mlx4: Use irq_update_affinity_hint
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pci@vger.kernel.org,
        tglx@linutronix.de, jesse.brandeburg@intel.com,
        robin.murphy@arm.com, mtosatti@redhat.com, mingo@kernel.org,
        jbrandeb@kernel.org, frederic@kernel.org, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com, rostedt@goodmis.org,
        peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, maz@kernel.org, nhorman@tuxdriver.com,
        pjwaskiewicz@gmail.com, sassmann@redhat.com, thenzl@redhat.com,
        kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, james.smart@broadcom.com,
        dick.kennedy@broadcom.com, jkc@redhat.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com, ahleihel@redhat.com,
        kheib@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        benve@cisco.com, govind@gmx.com, jassisinghbrar@gmail.com,
        luobin9@huawei.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 4:02 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Thu, Jun 17, 2021 at 02:22:42PM -0400, Nitesh Narayan Lal wrote:
> > The driver uses irq_set_affinity_hint() to update the affinity_hint mask
> > that is consumed by the userspace to distribute the interrupts. However,
> > under the hood irq_set_affinity_hint() also applies the provided cpumask
> > (if not NULL) as the affinity for the given interrupt which is an
> > undocumented side effect.
> >
> > To remove this side effect irq_set_affinity_hint() has been marked
> > as deprecated and new interfaces have been introduced. Hence, replace the
> > irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
> > that only updates the affinity_hint pointer.
> >
> > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > ---
> >  drivers/net/ethernet/mellanox/mlx4/eq.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mellanox/mlx4/eq.c b/drivers/net/ethernet/mellanox/mlx4/eq.c
> > index 9e48509ed3b2..f549d697ca95 100644
> > --- a/drivers/net/ethernet/mellanox/mlx4/eq.c
> > +++ b/drivers/net/ethernet/mellanox/mlx4/eq.c
> > @@ -244,9 +244,9 @@ static void mlx4_set_eq_affinity_hint(struct mlx4_priv *priv, int vec)
> >           cpumask_empty(eq->affinity_mask))
> >               return;
> >
> > -     hint_err = irq_set_affinity_hint(eq->irq, eq->affinity_mask);
> > +     hint_err = irq_update_affinity_hint(eq->irq, eq->affinity_mask);
> >       if (hint_err)
> > -             mlx4_warn(dev, "irq_set_affinity_hint failed, err %d\n", hint_err);
> > +             mlx4_warn(dev, "irq_update_affinity_hint failed, err %d\n", hint_err);
> >  }
> >  #endif
> >
> > @@ -1124,7 +1124,7 @@ static void mlx4_free_irqs(struct mlx4_dev *dev)
> >               if (eq_table->eq[i].have_irq) {
> >                       free_cpumask_var(eq_table->eq[i].affinity_mask);
> >  #if defined(CONFIG_SMP)
> > -                     irq_set_affinity_hint(eq_table->eq[i].irq, NULL);
> > +                     irq_update_affinity_hint(eq_table->eq[i].irq, NULL);
> >  #endif
>
> This #if/endif can be deleted.
>

Ack will get rid of them in v2.

> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>


-- 
Thanks
Nitesh

