Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D383DDC61
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 17:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234893AbhHBP1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 11:27:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23314 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234793AbhHBP1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Aug 2021 11:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627918013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZDhUhOE7wVvhlT6fRTts0o1L7ni+IAaP4sO+YA1/LPs=;
        b=JkMVuMMwf8wW3Szfi2Eq3lOa7og66x5Tgtp9ar0NOGPTRyN2ELz6Mtcj0C6clz6E8Tfm7B
        IGg0TtgeMiWc8+1+QBu6Ou2AMnhlEmdN/zHu8Z52SxQzgbx02tbBt8VYwNAIiYYs9rARt3
        /ccuYWUSXjFp6i1Xx17+ch9Gx4TlKA4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-DAg8g44dOoKeec-A01vzag-1; Mon, 02 Aug 2021 11:26:52 -0400
X-MC-Unique: DAg8g44dOoKeec-A01vzag-1
Received: by mail-lf1-f71.google.com with SMTP id e4-20020a1950040000b029034f05dc854aso6841268lfb.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Aug 2021 08:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZDhUhOE7wVvhlT6fRTts0o1L7ni+IAaP4sO+YA1/LPs=;
        b=lELtbqQ+N7MYuJZLpxG3WfpcvyRmKCenYR/uCG2zamF8HEpIYrlVvkvGjUO9/DATdm
         2GLYro5BsEucKF81Nj5guwFlShgL7qPwPvE3rdaczQXjgVTydB2c/ClQUfyDisH3VzAf
         nVfL+idXCGlLBLBttZf+VZJJm7DtQojcIA91iNwBEwBD5uabm5E/1XnZMVlLQtcHOpjs
         aW/zaW1k6RdL30pn7fraFgO+At0GcNHuDNYcVCX0jyVp+Nj7vN7moKd8P0hcB1OX3aWm
         gdU8kne6NjF5eK+xrRc3Z5A95J7I1QfEVdV2l33UOLibtqPVnscCFgul4JJ9uq0k7Ixj
         jXLQ==
X-Gm-Message-State: AOAM533IxcT5+Bw8tyc93uXvFd461W8Ye7KcT+UeXT3e21Onhw09AC4o
        pdfpDFGlx7BLMLmwI4BlSxU3OnFjr4GWsLsnIj+Ta4Y5au8AeexTbe7ENRecwLefoG8reYjEIMP
        qZlcHquMIB0YmX1fqNxqE5HMeBDyuf1KNTFCu
X-Received: by 2002:a05:6512:2189:: with SMTP id b9mr7974434lft.159.1627918010531;
        Mon, 02 Aug 2021 08:26:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxJTM6knPaot69WHjAFEXmr/LkoWJIS6PDNnEfEDimuXafoRs+es8u51ckxQOEF4QZT1655o4pRGDQ381sdSI=
X-Received: by 2002:a05:6512:2189:: with SMTP id b9mr7974367lft.159.1627918010313;
 Mon, 02 Aug 2021 08:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210720232624.1493424-1-nitesh@redhat.com>
In-Reply-To: <20210720232624.1493424-1-nitesh@redhat.com>
From:   Nitesh Lal <nilal@redhat.com>
Date:   Mon, 2 Aug 2021 11:26:39 -0400
Message-ID: <CAFki+LkNzk0ajUeuBnJZ6mp1kxB0+zZf60tw1Vfq+nPy-bvftQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] genirq: Cleanup the abuse of irq_set_affinity_hint()
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, jassisinghbrar@gmail.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tushar.Khandelwal@arm.com, manivannan.sadhasivam@linaro.org,
        lewis.hanly@microchip.com, ley.foon.tan@intel.com,
        kabel@kernel.org, huangguangbin2@huawei.com, davem@davemloft.net,
        benve@cisco.com, govind@gmx.com, kashyap.desai@broadcom.com,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        shivasharan.srikanteshwara@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        suganath-prabu.subramani@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        rostedt@goodmis.org, Marc Zyngier <maz@kernel.org>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
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
        saeedm@nvidia.com, Nitesh Lal <nilal@redhat.com>,
        "Nikolova, Tatyana E" <tatyana.e.nikolova@intel.com>,
        "Ismail, Mustafa" <mustafa.ismail@intel.com>,
        Al Stone <ahs3@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>,
        bjorn.andersson@linaro.org, chunkuang.hu@kernel.org,
        yongqiang.niu@mediatek.com, baolin.wang7@gmail.com,
        Petr Oros <poros@redhat.com>, Ming Lei <minlei@redhat.com>,
        Ewan Milne <emilne@redhat.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 20, 2021 at 7:26 PM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
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
>

[...]

>  drivers/infiniband/hw/irdma/hw.c              |  4 +-
>  drivers/mailbox/bcm-flexrm-mailbox.c          |  4 +-
>  drivers/net/ethernet/cisco/enic/enic_main.c   |  8 +--
>  drivers/net/ethernet/emulex/benet/be_main.c   |  4 +-
>  drivers/net/ethernet/huawei/hinic/hinic_rx.c  |  4 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +--
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++--
>  drivers/net/ethernet/mellanox/mlx4/eq.c       |  8 ++-
>  .../net/ethernet/mellanox/mlx5/core/pci_irq.c |  8 +--
>  drivers/scsi/lpfc/lpfc_init.c                 |  4 +-
>  drivers/scsi/megaraid/megaraid_sas_base.c     | 27 +++++-----
>  drivers/scsi/mpt3sas/mpt3sas_base.c           | 21 ++++----
>  include/linux/interrupt.h                     | 53 ++++++++++++++++++-
>  kernel/irq/manage.c                           |  8 +--
>  15 files changed, 114 insertions(+), 65 deletions(-)
>
> --
>
>

Gentle ping.
Any comments on the following patches:

  genirq: Provide new interfaces for affinity hints
  scsi: megaraid_sas: Use irq_set_affinity_and_hint
  scsi: mpt3sas: Use irq_set_affinity_and_hint
  enic: Use irq_update_affinity_hint
  be2net: Use irq_update_affinity_hint
  mailbox: Use irq_update_affinity_hint
  hinic: Use irq_set_affinity_and_hint

or any other patches?

-- 
Thanks
Nitesh

