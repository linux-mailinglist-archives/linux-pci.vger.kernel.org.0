Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD083E2D06
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 16:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbhHFO4q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 10:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242200AbhHFO4m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Aug 2021 10:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628261785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gplto+9RiGLBeHt41MKFNCwZ4jJrvlaCOPaj0G5G4zY=;
        b=hxjkrEQvU1Wwpu2MQlNexil1atmHLu8i2fRIVZQna6SY0j16arm3Vzgwv7TKxj1TN6qgUs
        HU7puA6ZeHn0iIptw8GhPC/OIF6nBgi+5z56nikmu4X1YQnRcD1bNnCfKYQdiFwLapLfgb
        7l/M6071roFneViMYOlg8R97cA4TPks=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-xyxUHuaZMGqhfofydG2adw-1; Fri, 06 Aug 2021 10:56:24 -0400
X-MC-Unique: xyxUHuaZMGqhfofydG2adw-1
Received: by mail-lj1-f198.google.com with SMTP id s28-20020a2e151c0000b02901b39b1684fbso17079ljd.15
        for <linux-pci@vger.kernel.org>; Fri, 06 Aug 2021 07:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gplto+9RiGLBeHt41MKFNCwZ4jJrvlaCOPaj0G5G4zY=;
        b=HJ7tnyLkpEqleCWm9T4rpep7eTo3CNMkhjPeYzZiyMLBLtNVqb7JZpNt/4FOxtKULo
         eNw0D3Avs4ANbxBuSn27nw2bEDpfvjohjmLmlHbBc9F65tiJ5fmPCtNm1I8vtwFR01De
         HSbM0iWhZzwxUFtG0lAJZJxW4jdqzPuyTUB+XF01Sz/hcGKYAdxlm2XrS9iKY+GRrdQ2
         69renVuG2XRo3sLbx1XzRSNII7LSCSfHrArGlzqvf9KQjpY1v83x+9EihSzpykuA8E8m
         pg6Znwpsku6wDdojaKlR6cSyoNQ65gscwIZE0V9V2IKLtiwfWe7aItFSGfkx0PwpGo8Q
         z6LA==
X-Gm-Message-State: AOAM5336xcNklVLIQiKa/MUCdsqrAhm3ZHuL3nW38SZpLZgJIRkvcaET
        iEkie1dpeb3nm779mPKxtRwOS0LigIQljNWLaR4zpuuw//X5lHaFLz7CVGoNA5H6JBTKD+dkiJd
        NzIZJrVvOyryJH44mGg37iJdbWTnKq+qOtQRt
X-Received: by 2002:a2e:a5c5:: with SMTP id n5mr6964962ljp.197.1628261783010;
        Fri, 06 Aug 2021 07:56:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwC/7IBeDvUIpspKDafXFNaZJL39fA0LdoJUUoo9fxtc2w2X3B23dOmAeuPnaLpGXRV1mvPec3FVULqmmMy5+E=
X-Received: by 2002:a2e:a5c5:: with SMTP id n5mr6964936ljp.197.1628261782465;
 Fri, 06 Aug 2021 07:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210720232624.1493424-1-nitesh@redhat.com> <CAFki+LkNzk0ajUeuBnJZ6mp1kxB0+zZf60tw1Vfq+nPy-bvftQ@mail.gmail.com>
 <yq11r77gtq0.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq11r77gtq0.fsf@ca-mkp.ca.oracle.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Fri, 6 Aug 2021 10:56:11 -0400
Message-ID: <CAFki+LmgTDtbZEhJF6FMRUV_oSMPLWqvrcKvBXUfNhzodVh+aA@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, jassisinghbrar@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar.Khandelwal@arm.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lewis.hanly@microchip.com, ley.foon.tan@intel.com,
        kabel@kernel.org, huangguangbin2@huawei.com, davem@davemloft.net,
        benve@cisco.com, govind@gmx.com, kashyap.desai@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com, suganath-prabu.subramani@broadcom.com,
        ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
        somnath.kotur@broadcom.com, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
        Marc Zyngier <maz@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, jbrandeb@kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linuxfoundation.org, sfr@canb.auug.org.au,
        stephen@networkplumber.org, rppt@linux.vnet.ibm.com,
        chris.friesen@windriver.com, Neil Horman <nhorman@tuxdriver.com>,
        pjwaskiewicz@gmail.com, Stefan Assmann <sassmann@redhat.com>,
        Tomas Henzl <thenzl@redhat.com>, james.smart@broadcom.com,
        Dick Kennedy <dick.kennedy@broadcom.com>,
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
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 5, 2021 at 11:06 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Nitesh,
>
> > Gentle ping.
> > Any comments on the following patches:
> >
> >   scsi: megaraid_sas: Use irq_set_affinity_and_hint
> >   scsi: mpt3sas: Use irq_set_affinity_and_hint
>
> Sumit and Sreekanth: Please review.
>
> Thanks!
>
> --
> Martin K. Petersen      Oracle Linux Engineering
>

Thanks, Martin, Sumit & Sreekanth for the help.

--
Nitesh

