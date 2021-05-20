Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90BD38B0E3
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbhETOEy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 10:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243642AbhETOCg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 10:02:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B68D1613C7;
        Thu, 20 May 2021 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621519274;
        bh=Ge7XZxLDW+zMOSFfG3zNBpDQtYmYLTcf7b+kJArHktY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kcfbk3PTJlyH3WsFAtlj2mZ4X9aUQ3iCidACFlNhz/CMFskrQzHU0QjNbP+B6xoVA
         SVQiCf63t4AIf/BH4O9jahKeIwLF0M/e/RarR9tHFULAIuv+ICmhY4g9OR0cK6D65p
         RlorI0oyxNAEYM/8RsOiUiWhuMHLzBvTnj5krvHVOG+0GW9OGMhSYe1QojtsoQeZ+U
         lsMB7ojn0Xl0PnDFEpbOcRIMurodzyxQzbFj7TPdGfSOyITKfRIP0AgfP2KwVW6gTs
         3Y9HJIsB+NMPqv9OFSXW2uZRG8r1BkbwIROIckf2PQX6vYRSZm1MCLmFXkBNYBxOfY
         zTtv6qhw8Ve8w==
Received: by mail-ed1-f44.google.com with SMTP id g7so7357370edm.4;
        Thu, 20 May 2021 07:01:14 -0700 (PDT)
X-Gm-Message-State: AOAM531whB+v9QO20A3X61OkuMTYPsJbksqUEfq/dkymqOwttA6LrSGv
        YVUEtNrY+oL6tLUwEd+a2n/UweD+gBhQvYt1aA==
X-Google-Smtp-Source: ABdhPJygU39SIGejwYFMYlAUxTlCuIit4tLdWH8lb/SAqwmEiZrm2Uy7YrF+M/9NQti0/RvkcjX4BV5Aa30TfpucGfQ=
X-Received: by 2002:a05:6402:c7:: with SMTP id i7mr5293139edu.194.1621519273257;
 Thu, 20 May 2021 07:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <1621495708-40364-1-git-send-email-wangxingang5@huawei.com>
In-Reply-To: <1621495708-40364-1-git-send-email-wangxingang5@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 May 2021 09:00:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKUjUN2c8XzCoL7xepb5xZHLQktqTSekYva6bGEZ5Sx2g@mail.gmail.com>
Message-ID: <CAL_JsqKUjUN2c8XzCoL7xepb5xZHLQktqTSekYva6bGEZ5Sx2g@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/of: Fix pci_request_acs() before enumerating PCI devices
To:     Wang Xingang <wangxingang5@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        xieyingtai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 20, 2021 at 2:28 AM Wang Xingang <wangxingang5@huawei.com> wrote:
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
>  drivers/iommu/of_iommu.c                 |  1 -
>  drivers/pci/controller/pci-host-common.c | 17 +++++++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)
>
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
> diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
> index d3924a44db02..5904ad0bd9ae 100644
> --- a/drivers/pci/controller/pci-host-common.c
> +++ b/drivers/pci/controller/pci-host-common.c

This file is generally only for ECAM compliant hosts. Are those the
only hosts we need to support this? From the looks of dts files with
iommu-map, that would be dropping support in lots of cases.

Perhaps in devm_of_pci_bridge_init() or one of the functions it calls
is the better place.

> @@ -49,6 +49,21 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
>         return cfg;
>  }
>
> +static void pci_host_enable_acs(struct pci_host_bridge *bridge)
> +{
> +       struct device_node *np = bridge->dev.parent->of_node;
> +       static bool acs_enabled;
> +
> +       if (!np || acs_enabled)
> +               return;
> +
> +       /* Detect IOMMU and make sure ACS will be enabled */
> +       if (of_property_read_bool(np, "iommu-map")) {
> +               acs_enabled = true;
> +               pci_request_acs();

Given this function just sets a variable, I don't think you need the
static acs_enabled here.

> +       }
> +}
> +
>  int pci_host_common_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> @@ -81,6 +96,8 @@ int pci_host_common_probe(struct platform_device *pdev)
>         bridge->ops = (struct pci_ops *)&ops->pci_ops;
>         bridge->msi_domain = true;
>
> +       pci_host_enable_acs(bridge);
> +
>         return pci_host_probe(bridge);
>  }
>  EXPORT_SYMBOL_GPL(pci_host_common_probe);
> --
> 2.19.1
>
