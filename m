Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4F2D1381
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 15:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgLGOYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 09:24:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgLGOYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 09:24:40 -0500
X-Gm-Message-State: AOAM532vBmgLr02Cs4jrkuIiGiI+C0Oqpo1AKIEiqpJGXwguTvLcjYlc
        GFVznSy0DSYsnYqBkniDkqnDY07w3mFEwLlDiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607351039;
        bh=a7lRSAu8t586Y7OhUkO8LXnMc7m/RnNg6gX+ZTBRNrM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jb7WQMCFbP/dqWuZVhv88Al19PMduTFP5DqS7xlT4Ao02ezjg1Y6BJQ2W4HZ2ts7Z
         cV8A4aS6fDblr1fTZcSzLtdABqAtN+qxMWdlo5jHXlJS9fywD69hCTdmzcNooAHxBz
         PjYd6x96+Mdbe4l9L6qiIKgjJOzzMLeRFkR70JbladDdVm68ripimz87yPhMKl3M6E
         ZWb+8CHDmb7jzTN01xsxZSfdKjGe2jjz4Hokm37os57y0b+ddoTkJWbpVfr8rdSo33
         +2cHQyq6xOanr/IhBVPpvz/izHVwx2JMTXAjKZedW2i+xD2lTWoudCkfiZVihMFKkn
         13v0qtVUXD9vw==
X-Google-Smtp-Source: ABdhPJyCK+XPyYjI3rGvm9cg99s5jJTla3Nw8Zty8yN5frd+1OrtkBIrpss0IimDx7gT2okOUEQ743lh0FHKXgZNnWg=
X-Received: by 2002:a50:f404:: with SMTP id r4mr20217224edm.62.1607351037965;
 Mon, 07 Dec 2020 06:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20201204165841.3845589-1-arnd@kernel.org>
In-Reply-To: <20201204165841.3845589-1-arnd@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 7 Dec 2020 08:23:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLCWK99AXzCWXpPsRxA+X5OKsHEGZtBhAsaVFhXoeRb9g@mail.gmail.com>
Message-ID: <CAL_JsqLCWK99AXzCWXpPsRxA+X5OKsHEGZtBhAsaVFhXoeRb9g@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: exynos: add back MSI dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 4, 2020 at 10:58 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> While the exynos driver does not always need MSI, the generic
> deisgnware host code it uses fails to build without it:
>
> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>   Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>   Selected by [y]:
>   - PCI_EXYNOS [=y] && PCI [=y] && (ARCH_EXYNOS [=n] || COMPILE_TEST [=y])
> drivers/pci/controller/dwc/pcie-designware-host.c:247:19: error: implicit declaration of function 'pci_msi_create_irq_domain' [-Werror,-Wimplicit-function-declaration]
>         pp->msi_domain = pci_msi_create_irq_domain(fwnode,
>                          ^
>
> Add back the dependency that all other designware controllers have.
>
> Fixes: f0a6743028f9 ("PCI: dwc: exynos: Rework the driver to support Exynos5433 variant")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/controller/dwc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Seems like we should rework this to avoid select on options with
depends, but that's a separate change.

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 020101b58155..e403bb2eeb4c 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -85,6 +85,7 @@ config PCIE_DW_PLAT_EP
>  config PCI_EXYNOS
>         tristate "Samsung Exynos PCIe controller"
>         depends on ARCH_EXYNOS || COMPILE_TEST
> +       depends on PCI && PCI_MSI_IRQ_DOMAIN

PCI isn't needed here.

>         select PCIE_DW_HOST
>         help
>           Enables support for the PCIe controller in the Samsung Exynos SoCs
> --
> 2.27.0
>
