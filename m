Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17D753E5E15
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbhHJOfv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 10:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240648AbhHJOfv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Aug 2021 10:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628606128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QuleXyR+sNlj9g2DShREE6mi7Rwvdwecde57TVTjsGo=;
        b=KExDPK+fZ/3kXInO3c0EKrPxILG+EmN7J25PUAKgw52Zm2J6X21hIaQgIfX1kzawYc77SM
        Hev1++mbCds43sW/TKuc3F1rg4QBbRXuZfwhHXjTHmWwQyc7ZSWlZn+uLpSkz4Tj8w7FNM
        aMxk5mRtdqHU88Y/uV1CbgDNoLtB7qU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-KPD2u50-MH-QrL3AXyLweA-1; Tue, 10 Aug 2021 10:35:26 -0400
X-MC-Unique: KPD2u50-MH-QrL3AXyLweA-1
Received: by mail-lf1-f71.google.com with SMTP id c24-20020a0565123258b02903c025690adcso5578344lfr.22
        for <linux-pci@vger.kernel.org>; Tue, 10 Aug 2021 07:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuleXyR+sNlj9g2DShREE6mi7Rwvdwecde57TVTjsGo=;
        b=YIekVYh7kG+T69/L6GDKas2EQhGEGF0e7XKs+WPg/6C5R6gcp5Kuf2zyWkVLro0yGj
         8g6Lu4GTv8bQwfujaz0MTY2jMHaTV8U78lLmg9k96TNQ+y+wjp3n9gJu93yi3OGNA5FK
         N9rxuA2NwRBOyIMbHcENPgjK9r4FQanVw50Jm/0OAi3DeIs8BSJhpHQJEHodJ3OM2rzb
         M5Ux1mWjXsoNTTgEFO9CyOpTweke+ifauzaHeDzGXpBiZ6BUrHJAYvEq9jzdFsdknI39
         SWa7johThOEwkxwC7MV28quKKEQavbxorov5AKbJkRlRYOR8LaAMz0oai/UKxvWEPr5X
         0aaQ==
X-Gm-Message-State: AOAM530AoeEKQxjXoLrhufkc1yj9E9+EnlrdIjTpMqESsIDqJq2m6ui8
        8HKX3+QeFkS78Kllyg7CwwwfmceoLHxASehbceTwOGPK/DGW02OJqi+KtCcnBuj1hocY+j5/lbB
        1D3muJ7+SQW5l9+pndsJsAkVSv24kFMg4kNi6
X-Received: by 2002:ac2:4a8d:: with SMTP id l13mr22302486lfp.159.1628606125011;
        Tue, 10 Aug 2021 07:35:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoIK6TD5A73rHnQ3By+bHVTK4cm690K8FNj2ppWk8aIHf21ATwuNIwUvmEjJMo0DOrYajSveCWTS9mlG393l4=
X-Received: by 2002:ac2:4a8d:: with SMTP id l13mr22302468lfp.159.1628606124828;
 Tue, 10 Aug 2021 07:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <YL3LrgAzMNI2hp5i@syu-laptop> <874kbxs80q.ffs@tglx>
In-Reply-To: <874kbxs80q.ffs@tglx>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Tue, 10 Aug 2021 10:35:13 -0400
Message-ID: <CAFki+Lmve_AqiTY-Y_6Rv1aqegbVph2hOcODdE9JS5S2m=jpaw@mail.gmail.com>
Subject: Re: [RFC] genirq: Add effective CPU index retrieving interface
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 10, 2021 at 10:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Jun 07 2021 at 15:33, Shung-Hsi Yu wrote:
> > Most driver's IRQ spreading scheme is naive compared to the IRQ spreading
> > scheme introduced since IRQ subsystem rework, so it better to rely
> > request_irq() to spread IRQ out.
> >
> > However, drivers that care about performance enough also tends to try
> > allocating memory on the same NUMA node on which the IRQ handler will run.
> > For such driver to rely on request_irq() for IRQ spreading, we also need to
> > provide an interface to retrieve the CPU index after calling
> > request_irq().
>
> So if you are interested in the resulting NUMA node, then why exposing a
> random CPU out of the affinity mask instead of exposing a function to
> retrieve the NUMA node?

Agreed, probably it will make more sense for the drivers to pass either the
local NUMA node index or NULL (in case they don't care about it) as a
parameter then at the time of allocation, we only find the best-fit CPUs
from that NUMA?

or, maybe we should do this by default, and if the local NUMA CPUs run out
of available vectors then we go to the other NUMA node CPUs.

>
> > +/**
> > + * irq_get_effective_cpu - Retrieve the effective CPU index
> > + * @irq:     Target interrupt to retrieve effective CPU index
> > + *
> > + * When the effective affinity cpumask has multiple CPU toggled, it just
> > + * returns the first CPU in the cpumask.
> > + */
> > +int irq_get_effective_cpu(unsigned int irq)
> > +{
> > +     struct irq_data *data = irq_get_irq_data(irq);
>
> This can be NULL.
>
> > +     struct cpumask *m;
> > +
> > +     m = irq_data_get_effective_affinity_mask(data);
> > +     return cpumask_first(m);
> > +}
>
> Thanks,
>
>         tglx
>


-- 
Thanks
Nitesh

