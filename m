Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757D645CFEE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 23:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245269AbhKXWTn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 17:19:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245144AbhKXWTl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 17:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637792191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EEVhKDq1EhBHdoS7pTs0RLbzDWey60atk3W5DA5v0B4=;
        b=WVhKmpKNWqFu8GFKPH+fJJlGpGYhmz2totx3u2hbZEqAesLdgxDFtisBzjIh2lpP+Oey3n
        UDILWvq/rhuB3E1WG3y7qihZ96TgZjS452ZJ5rODP+79bxfSoN11RKR+2MAf96orkIQ3Z+
        Gh0NWMxI5hDfpdslqFoCnSFblPnbHbY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-aG2z-7eYNNyEqJehBtzqtg-1; Wed, 24 Nov 2021 17:16:29 -0500
X-MC-Unique: aG2z-7eYNNyEqJehBtzqtg-1
Received: by mail-lf1-f70.google.com with SMTP id s18-20020ac25c52000000b004016bab6a12so2059698lfp.21
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEVhKDq1EhBHdoS7pTs0RLbzDWey60atk3W5DA5v0B4=;
        b=eXyoRBzxeg2Fx09D/68tq/tjIqgLW9X0YF+eReqKaSOT2NGoXvOhWDE1DcUMHwvTxP
         +Ram8V0W6vOBCJWezf1eOssBjVrGxW+6tP5/yJH2RSl+2s7HOehpYkwF9ijY1y1CuY8f
         fxyNrL0kx1ofiDTu2uiaBlQ17gvQFxkmngypNuBtM2rlskrS1Ke2tzzDnbgD5890MieY
         BMZB/W4BazkbUyXumyZt+eqLWL3F5xsu4PpWM8CepcEb+qsISMdcgRVvkNq1xKjJKaDh
         F2wYsfbsK8O8DWz34+RGamF+FhDQo5QdRE2Z+tXmuEvkJ9N0x7DOnKPTWo2XU9RvwJ7x
         QxUA==
X-Gm-Message-State: AOAM533UgYO03CYXMomNA5VlIZ3WJT+cn2rH8o7rhPHVFnAwd6CmEbBI
        ErNODG5pw7qYaK1t2+6WEvoiHPOs2OPIjGq7AIw7Xp3RRX/pzb4TZbiWf1Ncvdvhc8XPXuJtxFP
        Gzw+ivKywBV1D471nXZQmX0LxQvl7j33JPSBp
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr18777546lfd.124.1637792187774;
        Wed, 24 Nov 2021 14:16:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3HKmtNAafBBlI7bMVT3RazivdW2g2TUcEskctZmuEaRpOF7Jx2bvW50+8WUNSPiqnQC6nZn8f0zY2CSibUtA=
X-Received: by 2002:a05:6512:3096:: with SMTP id z22mr18777505lfd.124.1637792187488;
 Wed, 24 Nov 2021 14:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20210903152430.244937-1-nitesh@redhat.com> <CAFki+L=9Hw-2EONFEX6b7k6iRX_yLx1zcS+NmWsDSuBWg8w-Qw@mail.gmail.com>
 <87bl29l5c6.ffs@tglx>
In-Reply-To: <87bl29l5c6.ffs@tglx>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Wed, 24 Nov 2021 17:16:16 -0500
Message-ID: <CAFki+Lmrv-UjZpuTQWr9c-Rymfm-tuCw9WpwmHgyfjVhJgp--g@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
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

On Wed, Nov 24, 2021 at 2:30 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Nitesh,
>
> On Mon, Sep 13 2021 at 10:34, Nitesh Lal wrote:
> > On Fri, Sep 3, 2021 at 11:25 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
> >>
> >> The drivers currently rely on irq_set_affinity_hint() to either set the
> >> affinity_hint that is consumed by the userspace and/or to enforce a custom
> >> affinity.
> >>
> >> irq_set_affinity_hint() as the name suggests is originally introduced to
> >> only set the affinity_hint to help the userspace in guiding the interrupts
> >> and not the affinity itself. However, since the commit
> >>
> >>         e2e64a932556 "genirq: Set initial affinity in irq_set_affinity_hint()"
>
> sorry for ignoring this. It fell through the cracks.


No worries, thank you for reviewing.

>
>
> >> Thomas Gleixner (1):
> >>   genirq: Provide new interfaces for affinity hints
>
> Did I actually write this?


Yeap, the idea and the initial patch came from you. :)

>
>
> > Any suggestions on what should be the next steps here? Unfortunately, I haven't
> > been able to get any reviews on the following two patches:
> >   be2net: Use irq_update_affinity_hint
> >   hinic: Use irq_set_affinity_and_hint
> >
> > One option would be to proceed with the remaining patches and I can try
> > posting these two again when I post patches for the remaining drivers?
>
> The more general question is whether I should queue all the others or
> whether some subsystem would prefer to pull in a tagged commit on top of
> rc1. I'm happy to carry them all of course.
>

I am fine either way.
In the past, while I was asking for more testing help I was asked if the
SCSI changes are part of Martins's scsi-fixes tree as that's something
Broadcom folks test to check for regression.
So, maybe Martin can pull this up?

-- 
Thanks
Nitesh

