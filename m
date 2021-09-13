Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589AE409517
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbhIMOhb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 10:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347856AbhIMOff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Sep 2021 10:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631543659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfryJxpK5ypx39qR3xTFVVXtpOzhn2v4T4s5MYbdHC0=;
        b=LNaGNVx924mDiBKN0oMqFYMfrvXASpMNSiW7p/8oGrnNMWTNYtU4ozUohuXyZrrOZIDmUt
        hKJO4DOeYEh8iFw1osbrldkH1quWeDRCL5V7+AqTC/bTS4+27l/e8qHQovoetRQkpsfTNz
        TKZsK4kdHeAvOt3R8zAe1rWfu7LD1AM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-iESQXJ5OOzmznZqiXN24yQ-1; Mon, 13 Sep 2021 10:34:18 -0400
X-MC-Unique: iESQXJ5OOzmznZqiXN24yQ-1
Received: by mail-lf1-f70.google.com with SMTP id s28-20020a056512203c00b003f42015e912so730422lfs.4
        for <linux-pci@vger.kernel.org>; Mon, 13 Sep 2021 07:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfryJxpK5ypx39qR3xTFVVXtpOzhn2v4T4s5MYbdHC0=;
        b=K47/DDhyy8E/RXSkf4jX/JkQJSS1qYkmyV3xWLcn4+AlyItXBA8gxAxzEG5C7m1iYZ
         z1lJR8oueuWDgGlRtx+csgEuYU1DoqGOrjJ6kHbiWUme8Qlr/FKxBYf1hH6HkJShK5k3
         C9a0WQIDSOkq7dEF3lgZxTSFIxTm8jcW3CwtGc4zN0yceKrWweRQUA5sRKQMXPnxtcin
         aHgjK6sWzHo163xG94Y1tJAM8K7ntfMkWhn3/NHJ1t08Ki/A/AawOIT78e04cd/luQN1
         GsH/aJytm31Y51skXKGy6pNCz478rvnrC47hoqUEJQCdNh8LY/kflbKU5bnihGpzX9/H
         Ae3Q==
X-Gm-Message-State: AOAM532vMasafHXQoP9My6UFXXs442BjaWnlnfHG1fW0BOPJC6LW6AeJ
        7i+q4QPTMICemc+CxvbyNpEtWjdb/ZHbpBKXBU4nNLhetHqIYH2Cb0sIQW2CX0/qYur8Y+fiH3r
        Gld5k6xBiabAdhPd/VYDkx5GvnZ4N7wJmWlr1
X-Received: by 2002:a2e:8496:: with SMTP id b22mr10580088ljh.496.1631543655368;
        Mon, 13 Sep 2021 07:34:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5SXCQw8y9VkHHfq5++HMmDEHwpKWfarOYoyKiBkbH/mHk7DKQN7bm1Klq5kHtrFKCMkY+wbutOm0v72aYRO0=
X-Received: by 2002:a2e:8496:: with SMTP id b22mr10580054ljh.496.1631543655145;
 Mon, 13 Sep 2021 07:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210903152430.244937-1-nitesh@redhat.com>
In-Reply-To: <20210903152430.244937-1-nitesh@redhat.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 13 Sep 2021 10:34:03 -0400
Message-ID: <CAFki+L=9Hw-2EONFEX6b7k6iRX_yLx1zcS+NmWsDSuBWg8w-Qw@mail.gmail.com>
Subject: Re: [PATCH v6 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
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
        "Martin K. Petersen" <martin.petersen@oracle.com>,
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

On Fri, Sep 3, 2021 at 11:25 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> The drivers currently rely on irq_set_affinity_hint() to either set the
> affinity_hint that is consumed by the userspace and/or to enforce a custom
> affinity.
>
> irq_set_affinity_hint() as the name suggests is originally introduced to
> only set the affinity_hint to help the userspace in guiding the interrupts
> and not the affinity itself. However, since the commit
>
>         e2e64a932556 "genirq: Set initial affinity in irq_set_affinity_hint()"

[...]

>
> Nitesh Narayan Lal (13):
>   iavf: Use irq_update_affinity_hint
>   i40e: Use irq_update_affinity_hint
>   scsi: megaraid_sas: Use irq_set_affinity_and_hint
>   scsi: mpt3sas: Use irq_set_affinity_and_hint
>   RDMA/irdma: Use irq_update_affinity_hint
>   enic: Use irq_update_affinity_hint
>   be2net: Use irq_update_affinity_hint
>   ixgbe: Use irq_update_affinity_hint
>   mailbox: Use irq_update_affinity_hint
>   scsi: lpfc: Use irq_set_affinity
>   hinic: Use irq_set_affinity_and_hint
>   net/mlx5: Use irq_set_affinity_and_hint
>   net/mlx4: Use irq_update_affinity_hint
>
> Thomas Gleixner (1):
>   genirq: Provide new interfaces for affinity hints
>

Any suggestions on what should be the next steps here? Unfortunately, I haven't
been able to get any reviews on the following two patches:
  be2net: Use irq_update_affinity_hint
  hinic: Use irq_set_affinity_and_hint

One option would be to proceed with the remaining patches and I can try
posting these two again when I post patches for the remaining drivers?

-- 
Thanks
Nitesh

