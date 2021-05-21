Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AB38CDDA
	for <lists+linux-pci@lfdr.de>; Fri, 21 May 2021 21:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhEUTE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 May 2021 15:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231354AbhEUTE6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 May 2021 15:04:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84F89613AD;
        Fri, 21 May 2021 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621623815;
        bh=Lb4zWukxynJKdO2B6fwy3BzW7bBXcRFkXw0A4mCRUHQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G1VmxBiFqfMxKCZgUxm5/dufKpsN8UooefbIEeO+qjKy8iJR9nZ5AyV6zhRALRsXR
         80XmULrvhGK4sQmdheZYFU2czJEzljEQZqEFOZdA0nq0/OeBbwhaEHkM7EpLq8WYsR
         L54ePSUyOqlooWI2ug0A+/Lv+6cZw8YAhpRY4zZzzfRwTEJG+ocKZC10rZtv/V1kOX
         KpK4q29X3FCc5i3zZ5l2tDdpnxEbk+YREHCkQdzrNQYjPwiNd4ovuKHSaAnq9+PtcR
         2v9HI0MZQ0uOQOyST+x61zP9qjTNaQQC5YDsZOJshzsn78twFLYVYga2dEjwUFMMVm
         15TWWEw8mCQ4w==
Received: by mail-ej1-f46.google.com with SMTP id l1so31968800ejb.6;
        Fri, 21 May 2021 12:03:35 -0700 (PDT)
X-Gm-Message-State: AOAM5325Puhpvisc6Tsd6MkvyarV5X490DdccACmc41EPGbdAfdhgEgn
        SUO9bmWJgKe4IDaQdijDWI1g4mWnjCmhNzEuHg==
X-Google-Smtp-Source: ABdhPJzTd/Izr3P8oRUa1vk5tbtMeKhoGatTazTM5IQhKTJl5fJ+reQP7EFsCN74T8NNpYBMngBLD9DRlthlOPfJv7s=
X-Received: by 2002:a17:907:76b8:: with SMTP id jw24mr11708266ejc.359.1621623814193;
 Fri, 21 May 2021 12:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
In-Reply-To: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 21 May 2021 14:03:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJep2rpPN8r8PzT5fv32mmjMvg+k-=jzLp4S1QzC+LcLg@mail.gmail.com>
Message-ID: <CAL_JsqJep2rpPN8r8PzT5fv32mmjMvg+k-=jzLp4S1QzC+LcLg@mail.gmail.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating PCI devices
To:     Wang Xingang <wangxingang5@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, xieyingtai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 20, 2021 at 10:03 PM Wang Xingang <wangxingang5@huawei.com> wrote:
>
> From: Xingang Wang <wangxingang5@huawei.com>
>
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
>
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>                         .np = master_np,
>                 };
>
> -               pci_request_acs();
>                 err = pci_for_each_dma_alias(to_pci_dev(dev),
>                                              of_pci_iommu_init, &info);
>         } else {
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..2313c3f848b0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  {
> -       if (!dev->of_node)
> +       struct device_node *node = dev->of_node;
> +
> +       if (!node)
>                 return 0;
>
> +       /* Detect IOMMU and make sure ACS will be enabled */
> +       if (of_property_read_bool(node, "iommu-map"))
> +               pci_request_acs();
> +
>         bridge->swizzle_irq = pci_common_swizzle;
>         bridge->map_irq = of_irq_parse_and_map_pci;
>
> --
> 2.19.1
>
