Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239173C5E14
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGLOQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 10:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234615AbhGLOQn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 10:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626099235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=afUNjuJXnPmwCmF5+FQfjA8ufj+e69/ivLf91qDfwSM=;
        b=KcjDuQGo4y8asbZXV6GD/cYt9YPavUy4RUUlXN920oneXZPch3azjApA4ySHBaMGyMR5OC
        AFPScM+ZIZW0zt/O7tPbxnaZIWPXAMBXwMF0BzM0fjtU5qQcjCRvTGnno3OUXncY5PNAZB
        j25nLc2NxgnKT9SJ61FZ3geMhKwnnF8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-2KqNy_nYMxOaDzLti7yvBQ-1; Mon, 12 Jul 2021 10:13:53 -0400
X-MC-Unique: 2KqNy_nYMxOaDzLti7yvBQ-1
Received: by mail-lf1-f69.google.com with SMTP id bu14-20020a056512168eb029031226594940so6467693lfb.15
        for <linux-pci@vger.kernel.org>; Mon, 12 Jul 2021 07:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afUNjuJXnPmwCmF5+FQfjA8ufj+e69/ivLf91qDfwSM=;
        b=ibK/GYUKX6RYTELiDKQiR4TX1h2wQxks4L+ZoNDGMm4/9NsF3BATnLPzKpJgNZlpa0
         WHg9p014Ww3nTA2kC3L7OcCoWjVYt3dO8tYfoPXVTubgpJHP9YEeM3RUWQE81N6N66Uz
         x68x0sTbo4dmtn/D+cfqQnG2zcBXTTTnb8Lfg2w5ZevagwBLxz0rY+C3wPgu7GfKl978
         MQEXKUd12mjP7+OuDQz1M/hpcMJnTSEkCj4YU3duwKZARs9kVee4L+AODlgywtATwHJ1
         iFc/pXvhjOCPnW91EoBeoBsR8XuGACKyJZ5E7m9mGyPl3z14lOroz3bNNGIRWXwzf2AO
         3adw==
X-Gm-Message-State: AOAM531SqHu8DakLR2iS8ZqZJAZIIcqM/cckPnAKHBW68hnhkJrRsWLC
        uINRyM6PHAxr8RWi2lfmljKd9Z84Ut5REpi5PNBXCGrXzGpRAmzy7lDx6WZUNYO8ZWSSPXGchHf
        2dHzNzul7/Z8a2T0hQjMeNzIHjl0Mm7biTQg6
X-Received: by 2002:a05:6512:33d3:: with SMTP id d19mr16315944lfg.114.1626099231943;
        Mon, 12 Jul 2021 07:13:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbVotmura6ZuXfGUNMWJgcOo2t2QFX2iHzhetzzTWpDB1SmKe/MGcsinyZmILKUBXZAM4S3H2xTgXGvDKvNv8=
X-Received: by 2002:a05:6512:33d3:: with SMTP id d19mr16315896lfg.114.1626099231489;
 Mon, 12 Jul 2021 07:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210629152746.2953364-1-nitesh@redhat.com> <CAFki+LnUGiEE-7Uf-x8-TQZYZ+3Migrr=81gGLYszxaK-6A9WQ@mail.gmail.com>
 <YOrWqPYPkZp6nRLS@unreal>
In-Reply-To: <YOrWqPYPkZp6nRLS@unreal>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 12 Jul 2021 10:13:40 -0400
Message-ID: <CAFki+LnZnq2T9WjDn76wKR9=kk6Zf93zrWbGrnnhgRUiehQ-RA@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] genirq: Cleanup the usage of irq_set_affinity_hint
To:     Leon Romanovsky <leonro@nvidia.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        netdev@vger.kernel.org, linux-api@vger.kernel.org,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
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
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Al Stone <ahs3@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jul 11, 2021 at 7:32 AM Leon Romanovsky <leonro@nvidia.com> wrote:
>
> On Thu, Jul 08, 2021 at 03:24:20PM -0400, Nitesh Lal wrote:
> > On Tue, Jun 29, 2021 at 11:28 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> <...>
>
> > >
> > >  drivers/infiniband/hw/i40iw/i40iw_main.c      |  4 +-
> > >  drivers/mailbox/bcm-flexrm-mailbox.c          |  4 +-
> > >  drivers/net/ethernet/cisco/enic/enic_main.c   |  8 +--
> > >  drivers/net/ethernet/emulex/benet/be_main.c   |  4 +-
> > >  drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  4 +-
> > >  drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +--
> > >  drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
> > >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
> > >  drivers/net/ethernet/mellanox/mlx4/eq.c       |  8 ++-
> > >  .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  6 +--
> > >  drivers/scsi/lpfc/lpfc_init.c                 |  4 +-
> > >  drivers/scsi/megaraid/megaraid_sas_base.c     | 27 +++++-----
> > >  drivers/scsi/mpt3sas/mpt3sas_base.c           | 21 ++++----
> > >  include/linux/interrupt.h                     | 53 ++++++++++++++++++-
> > >  kernel/irq/manage.c                           |  8 +--
> > >  15 files changed, 113 insertions(+), 64 deletions(-)
> > >
> > > --
> > >
> > >
> >
> > Gentle ping.
> > Any comments or suggestions on any of the patches included in this series?
>
> Please wait for -rc1, rebase and resend.
> At least i40iw was deleted during merge window.
>

Right, will rebase on top of 5.14-rc1 and resend.

-- 
Thanks
Nitesh

