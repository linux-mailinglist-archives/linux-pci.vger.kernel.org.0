Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9224E5C81
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 01:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346956AbiCXA54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Mar 2022 20:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346954AbiCXA5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Mar 2022 20:57:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD471559B
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 17:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DDBEB821DE
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 00:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184EAC340E8
        for <linux-pci@vger.kernel.org>; Thu, 24 Mar 2022 00:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083382;
        bh=XSMKqdpowKS4zMvCRW3XKEofmZJCPSV9ivTALsgmfX4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=An5CKLeHdf7/9txpAWBQT75PHUaIKJQiQDM8zT+fgY5K4IReMRFnxObbn9JKa/Wz6
         f9viVtTMjnGHQqWjJAB7r97fH4xLbWQvWhn6dccCycwkf397M6Xxi31dWPoLf1ZF+A
         h6mibZDOk1v3wpqfLIDXNcHRqYzj7iRxGoN8VyJeoY4880AnXqaBOM7hkWfDMkpUZ1
         szeTTek7iOlRUL6970y8jCuE1QUK6594PHU2P35v399eS6WvhhEbkTt5KJmVr8X+ej
         V/Gm2uN6smVXWsuFUiL194blH8yG1wYmtA/ohgj1j5mJc/fTalwLJVuhnARvdZV9IX
         JIEcnFUVCPCgA==
Received: by mail-ed1-f50.google.com with SMTP id x34so3832279ede.8
        for <linux-pci@vger.kernel.org>; Wed, 23 Mar 2022 17:56:22 -0700 (PDT)
X-Gm-Message-State: AOAM530bhTybndpoY6dsqN3qrbDWIUrfaAIRwuud6JhC5OTJMrNqnk43
        zBkICeiMZtuvRuYulZNacYsXTizb/l6lItpLIQ==
X-Google-Smtp-Source: ABdhPJxhys4zf4xJ/ElQl1YL++ni1FtQNwJ6wwUXDLE4HUeSgKvIp/cLZrb6m/ZE6iYoYVh73P3RMdX9df0/9o6w2Us=
X-Received: by 2002:a05:6402:2711:b0:419:5a50:75ef with SMTP id
 y17-20020a056402271100b004195a5075efmr3669523edd.280.1648083380394; Wed, 23
 Mar 2022 17:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
In-Reply-To: <65657c5370fa0161739ba094ea948afdfa711b8a.1647967875.git.robin.murphy@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Mar 2022 19:56:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+x5kOcr6J1w2v0Xc=5M+51f5Qy_zkm5yFP9c4ZitSMTQ@mail.gmail.com>
Message-ID: <CAL_Jsq+x5kOcr6J1w2v0Xc=5M+51f5Qy_zkm5yFP9c4ZitSMTQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/dma: Explicitly sort PCI DMA windows
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 22, 2022 at 12:27 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Originally, creating the dma_ranges resource list in pre-sorted fashion
> was the simplest and most efficient way to enforce the order required by
> iova_reserve_pci_windows(). However since then at least one PCI host
> driver is now re-sorting the list for its own probe-time processing,
> which doesn't seem entirely unreasonable, so that basic assumption no
> longer holds. Make iommu-dma robust and get the sort order it needs by
> explicitly sorting, which means we can also save the effort at creation
> time and just build the list in whatever natural order the DT had.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>
> Looking at this area off the back of the XGene thread[1] made me realise
> that we need to do it anyway, regardless of whether it might also happen
> to restore the previous XGene behaviour or not. Presumably nobody's
> tried to use pcie-cadence-host behind an IOMMU yet...
>
> Boot-tested on Juno to make sure I hadn't got the sort comparison
> backwards.
>
> Robin.
>
> [1] https://lore.kernel.org/linux-pci/20220321104843.949645-1-maz@kernel.org/
>
>  drivers/iommu/dma-iommu.c | 13 ++++++++++++-
>  drivers/pci/of.c          |  7 +------
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index b22034975301..91d134c0c9b1 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/iommu.h>
>  #include <linux/iova.h>
>  #include <linux/irq.h>
> +#include <linux/list_sort.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> @@ -414,6 +415,15 @@ static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
>         return 0;
>  }
>
> +static int iommu_dma_ranges_sort(void *priv, const struct list_head *a,
> +               const struct list_head *b)
> +{
> +       struct resource_entry *res_a = list_entry(a, typeof(*res_a), node);
> +       struct resource_entry *res_b = list_entry(b, typeof(*res_b), node);
> +
> +       return res_a->res->start > res_b->res->start;
> +}
> +
>  static int iova_reserve_pci_windows(struct pci_dev *dev,
>                 struct iova_domain *iovad)
>  {
> @@ -432,6 +442,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>         }
>
>         /* Get reserved DMA windows from host bridge */
> +       list_sort(NULL, &bridge->dma_ranges, iommu_dma_ranges_sort);
>         resource_list_for_each_entry(window, &bridge->dma_ranges) {
>                 end = window->res->start - window->offset;
>  resv_iova:
> @@ -440,7 +451,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>                         hi = iova_pfn(iovad, end);
>                         reserve_iova(iovad, lo, hi);
>                 } else if (end < start) {
> -                       /* dma_ranges list should be sorted */
> +                       /* DMA ranges should be non-overlapping */
>                         dev_err(&dev->dev,
>                                 "Failed to reserve IOVA [%pa-%pa]\n",
>                                 &start, &end);
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index cb2e8351c2cc..d176b4bc6193 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -393,12 +393,7 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>                         goto failed;
>                 }
>
> -               /* Keep the resource list sorted */
> -               resource_list_for_each_entry(entry, ib_resources)
> -                       if (entry->res->start > res->start)
> -                               break;
> -
> -               pci_add_resource_offset(&entry->node, res,

entry is now unused and causes a warning.

> +               pci_add_resource_offset(ib_resources, res,
>                                         res->start - range.pci_addr);
>         }
>
> --
> 2.28.0.dirty
>
