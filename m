Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F153702A5
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhD3VIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Apr 2021 17:08:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236031AbhD3VIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Apr 2021 17:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619816881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7bjSqgt4w42d2y2oUh6BGNJmeVzILv9yAjfoz9hqHZ8=;
        b=Tl7al7NV5S7ilgesGLruvMVpsvfYiQj/S8MbDe0dH5a9KnDznhZxAZm93vI2r9EGoiRwuF
        VDf4d+q3nwv3liXuLabwzBMPADPiJRmOK2WsTvBbNx4lTsExBTM837eGhbrkWUmvTk4xoZ
        nU2DsO5aXq59/GSqc6r06EmMQt8DI08=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-HdP-ijERMsGg7gUwNOGRdg-1; Fri, 30 Apr 2021 17:07:59 -0400
X-MC-Unique: HdP-ijERMsGg7gUwNOGRdg-1
Received: by mail-lf1-f71.google.com with SMTP id v23-20020a05651203b7b02901abd47176ffso20522625lfp.9
        for <linux-pci@vger.kernel.org>; Fri, 30 Apr 2021 14:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7bjSqgt4w42d2y2oUh6BGNJmeVzILv9yAjfoz9hqHZ8=;
        b=qJ2LlyciDbomb5emnCuzk1ovh+Jv6WNSOJaLLafdGd7u/gfWJdAwKGQFG4sYM9Mf3K
         CqTt0CcbOL7yj7lfUNBVVZjaIp1/G+YrrTWk5ABbyQm2Rh8A10tJbqQMru6r3IBQy7aJ
         Rxsl7lCTMAQKx5v0/rplcKtQ2LPow2Gsk7Bin6iQnNOa4ha2V8uL120BiK2Il/Pd/LAG
         SKlxCKNvPrKk6H2wymOCf6e/RBNa+So4dYaVVKnYxstmF3QNWWXK67TCJPb5wH5gPnXN
         28qU/XiGjX+6ERTNooKpN6sFKKwwlmXn5MQJsEYViXJeG87qdILU9CeHGFcGykczeEG8
         eJuQ==
X-Gm-Message-State: AOAM532csqIY3uuOlr1zQy90VG37cvUZcOPvn0iNFhnwVJTVh8qguQ1M
        V+LvlICl7D8F+NJ2Cr6cL71rxQMt3NsmYDNIYFrzj2HV36fRD2yUUl1POYdxOtczKclVntIUEcx
        jkqea+/6przvhDqixtqnIgRA4IOigOml5FXAr
X-Received: by 2002:a05:6512:2312:: with SMTP id o18mr3109203lfu.159.1619816878262;
        Fri, 30 Apr 2021 14:07:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBW+2eTpJ1b/0aVBVfHtEHUDBvWA8EKipw/hV7udwyS3zot1KXF8xLRaYzeqXtLDjqsJJZJTOxweH+MiRCp/U=
X-Received: by 2002:a05:6512:2312:: with SMTP id o18mr3109190lfu.159.1619816878110;
 Fri, 30 Apr 2021 14:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200625223443.2684-1-nitesh@redhat.com> <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet> <87r1m5can2.fsf@nanos.tec.linutronix.de>
 <20210128165903.GB38339@fuller.cnet> <87h7n0de5a.fsf@nanos.tec.linutronix.de>
 <20210204181546.GA30113@fuller.cnet> <cfa138e9-38e3-e566-8903-1d64024c917b@redhat.com>
 <20210204190647.GA32868@fuller.cnet> <d8884413-84b4-b204-85c5-810342807d21@redhat.com>
 <87y2g26tnt.fsf@nanos.tec.linutronix.de> <d0aed683-87ae-91a2-d093-de3f5d8a8251@redhat.com>
 <7780ae60-efbd-2902-caaa-0249a1f277d9@redhat.com> <07c04bc7-27f0-9c07-9f9e-2d1a450714ef@redhat.com>
 <20210406102207.0000485c@intel.com> <1a044a14-0884-eedb-5d30-28b4bec24b23@redhat.com>
 <20210414091100.000033cf@intel.com> <54ecc470-b205-ea86-1fc3-849c5b144b3b@redhat.com>
 <CAFki+Lm0W_brLu31epqD3gAV+WNKOJfVDfX2M8ZM__aj3nv9uA@mail.gmail.com>
 <87czucfdtf.ffs@nanos.tec.linutronix.de> <CAFki+LmmRyvOkWoNNLk5JCwtaTnabyaRUKxnS+wyAk_kj8wzyw@mail.gmail.com>
 <87sg37eiqa.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87sg37eiqa.ffs@nanos.tec.linutronix.de>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 30 Apr 2021 17:07:46 -0400
Message-ID: <CAFki+L=_dd+JgAR12_eBPX0kZO2_6=1dGdgkwHE=u=K6chMeLQ@mail.gmail.com>
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping CPUs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     "frederic@kernel.org" <frederic@kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, abelits@marvell.com,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        "rppt@linux.vnet.ibm.com" <rppt@linux.vnet.ibm.com>,
        "jinyuqi@huawei.com" <jinyuqi@huawei.com>,
        "zhangshaokun@hisilicon.com" <zhangshaokun@hisilicon.com>,
        netdev@vger.kernel.org, chris.friesen@windriver.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 30, 2021 at 2:21 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nitesh,
>
> On Fri, Apr 30 2021 at 12:14, Nitesh Lal wrote:
> > Based on this analysis and the fact that with your re-work the interrupts
> > seems to be naturally spread across the CPUs, will it be safe to revert
> > Jesse's patch
> >
> > e2e64a932 genirq: Set initial affinity in irq_set_affinity_hint()
> >
> > as it overwrites the previously set IRQ affinity mask for some of the
> > devices?
>
> That's a good question. My gut feeling says yes.
>

Jesse do you want to send the revert for the patch?

Also, I think it was you who suggested cc'ing
intel-wired-lan ml as that allows intel folks, to do some initial
testing?
If so, we can do that here (IMHO).

> > IMHO if we think that this patch is still solving some issue other than
> > what Jesse has mentioned then perhaps we should reproduce that and fix it
> > directly from the request_irq code path.
>
> Makes sense.
>
> Thanks,
>
>         tglx
>


-- 
Thanks
Nitesh

