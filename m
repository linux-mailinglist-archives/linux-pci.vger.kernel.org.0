Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5118470219
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 14:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbhLJNz3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 08:55:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53480 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236890AbhLJNz3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Dec 2021 08:55:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639144313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gqvyjGQ2QSbWFtIFlHWRbYHP8q8+IM6QnY9owpZHaBA=;
        b=Ce0kiUQkQ0MCuskCQn+mZL/Vtczoe3hoM761W3NgRnkmUqVZZSsVm1GtcNGnvmgHYNbG7w
        em8dRBsdJnuR5B82FQ4ktDmXQ05rGepUTjrCk5iXwKK02swmDeHR78LiBm2zD9XW03BV12
        tv5N8rvTbBEx3z/a7UmVoDXImkYv0iM=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-feUGJoOSPKyXYDge-ddpKA-1; Fri, 10 Dec 2021 08:51:52 -0500
X-MC-Unique: feUGJoOSPKyXYDge-ddpKA-1
Received: by mail-lf1-f72.google.com with SMTP id t9-20020a056512068900b00417ba105469so4112569lfe.4
        for <linux-pci@vger.kernel.org>; Fri, 10 Dec 2021 05:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqvyjGQ2QSbWFtIFlHWRbYHP8q8+IM6QnY9owpZHaBA=;
        b=Y+eywmSmS+cJBGONzG+n7GSs2mADgJOPNQ2KHxt0YSIfVeHbovJZgD4zaQJ18jdRDN
         A/BbqJeuiSCbGGVpxc8/OzUia932T52BebHwKXm5UTURN/1g4uTFshXEwRBAEoh3ay0q
         XYL3u7D8U5/bOuR2DzSd7i6KzmM6eoWjU7hsamcC65hjolxGhZUbzKjH6wTJof1iHDmi
         NQ6uENQ801P4jKZQyy9l/9SxoH5Z5BLoMGvXefkXb+Rqse8PLtOiZUkLduo1OYAG8jEO
         /8ZxDgNwASpf0uuCaTJdXhXn1hNTWTAiZvk3P6MkhrDREhHgl6Mj3b9cd9IxTb8KPWa6
         VJdw==
X-Gm-Message-State: AOAM5308UAvZYvb8w2PK6ELDBDlINCXhFb4whj66xduhu1Yb44FbFefz
        da/FjwRpyzemq7A4b+qS67PVJ60iPDJC2x4lHkJ5gUCWNA4T7PjTRCaEUPKnnjXiblLCOE6Pncq
        sEUZNLI5z8rRATw7yXbwAAykeY0+iA23veq/k
X-Received: by 2002:a2e:141e:: with SMTP id u30mr12862202ljd.434.1639144311079;
        Fri, 10 Dec 2021 05:51:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUO/MrpzRbWn9dYPpab289atcuCRe9ccW1GgZxBAbufFTqh/0D7bN9PGcAdU9w0UtK4sR14DNLb2zrZaZr35U=
X-Received: by 2002:a2e:141e:: with SMTP id u30mr12862154ljd.434.1639144310849;
 Fri, 10 Dec 2021 05:51:50 -0800 (PST)
MIME-Version: 1.0
References: <20210903152430.244937-1-nitesh@redhat.com> <CAFki+L=9Hw-2EONFEX6b7k6iRX_yLx1zcS+NmWsDSuBWg8w-Qw@mail.gmail.com>
 <87bl29l5c6.ffs@tglx> <CAFki+Lmrv-UjZpuTQWr9c-Rymfm-tuCw9WpwmHgyfjVhJgp--g@mail.gmail.com>
In-Reply-To: <CAFki+Lmrv-UjZpuTQWr9c-Rymfm-tuCw9WpwmHgyfjVhJgp--g@mail.gmail.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 10 Dec 2021 08:51:39 -0500
Message-ID: <CAFki+L=5sLN+nU+YpSSrQN0zkAOKrJorevm0nQ+KdwCpnOzf3w@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-scsi@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        huangguangbin2@huawei.com, huangdaode@huawei.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Alex Belits <abelits@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rostedt@goodmis.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ingo Molnar <mingo@kernel.org>, jbrandeb@kernel.org,
        akpm@linuxfoundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, Marc Zyngier <maz@kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>, pjwaskiewicz@gmail.com,
        Stefan Assmann <sassmann@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, james.smart@broadcom.com,
        Ken Cox <jkc@redhat.com>, faisal.latif@intel.com,
        shiraz.saleem@intel.com, tariqt@nvidia.com,
        Alaa Hleihel <ahleihel@redhat.com>,
        Kamal Heib <kheib@redhat.com>, borisp@nvidia.com,
        saeedm@nvidia.com,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Al Stone <ahs3@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        bjorn.andersson@linaro.org, chunkuang.hu@kernel.org,
        yongqiang.niu@mediatek.com, baolin.wang7@gmail.com,
        Petr Oros <poros@redhat.com>, Ming Lei <minlei@redhat.com>,
        Ewan Milne <emilne@redhat.com>, jejb@linux.ibm.com,
        kabel@kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, kashyap.desai@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        suganath-prabu.subramani@broadcom.com, ley.foon.tan@intel.com,
        jbrunet@baylibre.com, johannes@sipsolutions.net,
        snelson@pensando.io, lewis.hanly@microchip.com, benve@cisco.com,
        _govind@gmx.com, jassisinghbrar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Martin,

On Wed, Nov 24, 2021 at 5:16 PM Nitesh Lal <nilal@redhat.com> wrote:
>
> On Wed, Nov 24, 2021 at 2:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Nitesh,
> >
> > On Mon, Sep 13 2021 at 10:34, Nitesh Lal wrote:
> > > On Fri, Sep 3, 2021 at 11:25 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> > >>
> > >> The drivers currently rely on irq_set_affinity_hint() to either set the
> > >> affinity_hint that is consumed by the userspace and/or to enforce a custom
> > >> affinity.
> > >>
> > >> irq_set_affinity_hint() as the name suggests is originally introduced to
> > >> only set the affinity_hint to help the userspace in guiding the interrupts
> > >> and not the affinity itself. However, since the commit
> > >>
> > >>         e2e64a932556 "genirq: Set initial affinity in irq_set_affinity_hint()"
> >
> > sorry for ignoring this. It fell through the cracks.
>
>
> No worries, thank you for reviewing.
>
> >
> >
> > >> Thomas Gleixner (1):
> > >>   genirq: Provide new interfaces for affinity hints
> >
> > Did I actually write this?
>
>
> Yeap, the idea and the initial patch came from you. :)
>
> >
> >
> > > Any suggestions on what should be the next steps here? Unfortunately, I haven't
> > > been able to get any reviews on the following two patches:
> > >   be2net: Use irq_update_affinity_hint
> > >   hinic: Use irq_set_affinity_and_hint
> > >
> > > One option would be to proceed with the remaining patches and I can try
> > > posting these two again when I post patches for the remaining drivers?
> >
> > The more general question is whether I should queue all the others or
> > whether some subsystem would prefer to pull in a tagged commit on top of
> > rc1. I'm happy to carry them all of course.
> >
>
> I am fine either way.
> In the past, while I was asking for more testing help I was asked if the
> SCSI changes are part of Martins's scsi-fixes tree as that's something
> Broadcom folks test to check for regression.
> So, maybe Martin can pull this up?
>

Gentle ping.
Any thoughts on the above query?

-- 
Thanks
Nitesh

