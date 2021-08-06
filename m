Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C502F3E2DF0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbhHFPw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 11:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238025AbhHFPw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Aug 2021 11:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628265132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ocgP4yowhB/EUlnSIxuQMOG6kjLjSAHTmb8OYmd4EOQ=;
        b=Kr6m1tpPchjzWu25UwcCdoz89ETW1+vRd7RRMfRNYX4nGIxHvllkR0L2F5v5mFFixMHvUc
        JVeauVsbuSHqa0uzlJC2AqY9UW8RYUadGgK6czeLNAlX6KJLtbiOUdtYD6YYzQW2FzzXX8
        dM9TF6Z098Bd+L/N5iDlu/5sscf8AAw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-a_9KXiuLPyqYgAA73mQGNA-1; Fri, 06 Aug 2021 11:52:11 -0400
X-MC-Unique: a_9KXiuLPyqYgAA73mQGNA-1
Received: by mail-lj1-f199.google.com with SMTP id k6-20020a2e92060000b0290199022fba24so2007291ljg.13
        for <linux-pci@vger.kernel.org>; Fri, 06 Aug 2021 08:52:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocgP4yowhB/EUlnSIxuQMOG6kjLjSAHTmb8OYmd4EOQ=;
        b=VKteX1+vyx1Z7zMiaAK9vlBYbNazm/cNO59r77igsHxwrEr2NzCwuA6IEgIMDUtsIC
         2imfZMD44K2LqOUOQfCu2dVfvyVpaX8iDj9ew0jpSA1pcDTM1/ouWpCacatcbDoMhnru
         JF21VrJaN2iHuRuurMoGjYdouFm8/935MwAm9EzGSR+pa9vKmhTC0+rckJepo6+bkidT
         bhMHUqaW2rdQ1funJxL8uUNCHjc0zQz+02FyffFoYwLMBcxxKoa48aEvYyKBCTsSZKq3
         ZOYKRwULyEQ3TYEBcxsw5Gr4CJMAdLcgR8DNVBw6yCLHI4L+JfRsge+XJ9MNiKlwVJsK
         bxRg==
X-Gm-Message-State: AOAM533tooFR6lm5OOjIZMVCdjxnJxP0/2JHNajBKJT/UItjIyHFlMpY
        g3CS6DQTG+GOYxy6qiXPpG34AcgAYR1MNMvKnLV5KJHMZYWRiC2py9rGthO8IunZedC0+LFuxAa
        ta9j54UF8mgoHtkDDuXYY1qJmSTUuDSzxNjML
X-Received: by 2002:ac2:446d:: with SMTP id y13mr8071808lfl.632.1628265129892;
        Fri, 06 Aug 2021 08:52:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9NmyUDGHNtqA5+JG3Fj8AovGBdtXdP/uo+X1AK+D5LYRCKOEMar1/c1smD31PF3dDW/0pEabI/MsAyUK/eQ0=
X-Received: by 2002:ac2:446d:: with SMTP id y13mr8071774lfl.632.1628265129728;
 Fri, 06 Aug 2021 08:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210720232624.1493424-1-nitesh@redhat.com> <20210720232624.1493424-2-nitesh@redhat.com>
In-Reply-To: <20210720232624.1493424-2-nitesh@redhat.com>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Fri, 6 Aug 2021 23:51:58 +0800
Message-ID: <CAFj5m9+9asdQOCRHb0tZ=XSD-sOj+RLEDVEAObN81Z9y1JcgQg@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] genirq: Provide new interfaces for affinity hints
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-pci@vger.kernel.org,
        tglx@linutronix.de, jesse.brandeburg@intel.com,
        Robin Murphy <robin.murphy@arm.com>, mtosatti@redhat.com,
        mingo@kernel.org, jbrandeb@kernel.org, frederic@kernel.org,
        juri.lelli@redhat.com, abelits@marvell.com, bhelgaas@google.com,
        rostedt@goodmis.org, peterz@infradead.org, davem@davemloft.net,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, maz@kernel.org, nhorman@tuxdriver.com,
        pjwaskiewicz@gmail.com, sassmann@redhat.com, thenzl@redhat.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        James Smart <james.smart@broadcom.com>,
        dick.kennedy@broadcom.com, jkc@redhat.com, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com, ahleihel@redhat.com,
        kheib@redhat.com, borisp@nvidia.com, saeedm@nvidia.com,
        benve@cisco.com, govind@gmx.com, jassisinghbrar@gmail.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, nilal@redhat.com,
        tatyana.e.nikolova@intel.com, mustafa.ismail@intel.com,
        ahs3@redhat.com, leonro@nvidia.com,
        chandrakanth.patil@broadcom.com, bjorn.andersson@linaro.org,
        chunkuang.hu@kernel.org, yongqiang.niu@mediatek.com,
        baolin.wang7@gmail.com, poros@redhat.com,
        Ewan Milne <emilne@redhat.com>, jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>, _govind@gmx.com,
        kabel@kernel.org, viresh.kumar@linaro.org,
        Tushar.Khandelwal@arm.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 7:26 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>

