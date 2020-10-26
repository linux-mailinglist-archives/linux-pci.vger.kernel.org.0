Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862902995B9
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 19:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790431AbgJZSu0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 14:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1790428AbgJZSu0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 14:50:26 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0994E21D7B;
        Mon, 26 Oct 2020 18:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603738225;
        bh=JEfVtUKlInYQ0fbZNP15BzK/44fyha6rG+E01FErsoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GyCJH3GnwmV0wipG6wOYC3nVU3PlrHTgpXU3b1JWRJp1l0FOE90L9xOBL8S61nXxZ
         iC4n7KkeAbHn/P+OGGWGwPkHWtmnJhSXbcknOrj2NQ4R//G+jzlOhvILBcSqkgRNsw
         rx+5USq7aLTZvH667Fw5CP+JEf564NYUn0kSAHLc=
Received: by mail-ot1-f50.google.com with SMTP id m22so8955228ots.4;
        Mon, 26 Oct 2020 11:50:25 -0700 (PDT)
X-Gm-Message-State: AOAM531tPk2RAsgXaavrS92v5QaO7bcJnV7MzwG5gYNyUVia1tWHBI1W
        7Mi+f2zJHqjtxfKESIdOd3ev/+rcRw+dlBGHkQ==
X-Google-Smtp-Source: ABdhPJyfr6yceNd2s4etvOsL23XkDwfTp8P2FO2SzBaZUDnJYThZWlzTsHVErNne3YqAOFIv7OY2MdlaqZZm6+aOALY=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr15766887otk.192.1603738224263;
 Mon, 26 Oct 2020 11:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f@eucas1p2.samsung.com>
 <20201023075744.26200-1-m.szyprowski@samsung.com> <20201023075744.26200-5-m.szyprowski@samsung.com>
In-Reply-To: <20201023075744.26200-5-m.szyprowski@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Oct 2020 13:50:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUT7aLnQsLvcCOHCaoVAao9VSmEhoscBxu3ARXX33zrA@mail.gmail.com>
Message-ID: <CAL_JsqLUT7aLnQsLvcCOHCaoVAao9VSmEhoscBxu3ARXX33zrA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 23, 2020 at 2:58 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
> variant found in the Exynos5433 SoCs.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> [mszyprow: reworked the driver to support only Exynos5433 variant, rebased
>            onto current kernel code, rewrote commit message]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/phy/samsung/phy-exynos-pcie.c | 304 ++++++++++----------------
>  1 file changed, 112 insertions(+), 192 deletions(-)
>
> diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
> index 7e28b1aea0d1..d91de323dd0e 100644
> --- a/drivers/phy/samsung/phy-exynos-pcie.c
> +++ b/drivers/phy/samsung/phy-exynos-pcie.c
> @@ -4,70 +4,41 @@
>   *
>   * Phy provider for PCIe controller on Exynos SoC series
>   *
> - * Copyright (C) 2017 Samsung Electronics Co., Ltd.
> + * Copyright (C) 2017-2020 Samsung Electronics Co., Ltd.
>   * Jaehoon Chung <jh80.chung@samsung.com>
>   */
>
> -#include <linux/delay.h>
>  #include <linux/io.h>
> -#include <linux/iopoll.h>
> -#include <linux/init.h>
>  #include <linux/mfd/syscon.h>
> -#include <linux/of.h>
> -#include <linux/of_address.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>
> -/* PCIe Purple registers */
> -#define PCIE_PHY_GLOBAL_RESET          0x000
> -#define PCIE_PHY_COMMON_RESET          0x004
> -#define PCIE_PHY_CMN_REG               0x008
> -#define PCIE_PHY_MAC_RESET             0x00c
> -#define PCIE_PHY_PLL_LOCKED            0x010
> -#define PCIE_PHY_TRSVREG_RESET         0x020
> -#define PCIE_PHY_TRSV_RESET            0x024
> -
> -/* PCIe PHY registers */
> -#define PCIE_PHY_IMPEDANCE             0x004
> -#define PCIE_PHY_PLL_DIV_0             0x008
> -#define PCIE_PHY_PLL_BIAS              0x00c
> -#define PCIE_PHY_DCC_FEEDBACK          0x014
> -#define PCIE_PHY_PLL_DIV_1             0x05c
> -#define PCIE_PHY_COMMON_POWER          0x064
> -#define PCIE_PHY_COMMON_PD_CMN         BIT(3)
> -#define PCIE_PHY_TRSV0_EMP_LVL         0x084
> -#define PCIE_PHY_TRSV0_DRV_LVL         0x088
> -#define PCIE_PHY_TRSV0_RXCDR           0x0ac
> -#define PCIE_PHY_TRSV0_POWER           0x0c4
> -#define PCIE_PHY_TRSV0_PD_TSV          BIT(7)
> -#define PCIE_PHY_TRSV0_LVCC            0x0dc
> -#define PCIE_PHY_TRSV1_EMP_LVL         0x144
> -#define PCIE_PHY_TRSV1_RXCDR           0x16c
> -#define PCIE_PHY_TRSV1_POWER           0x184
> -#define PCIE_PHY_TRSV1_PD_TSV          BIT(7)
> -#define PCIE_PHY_TRSV1_LVCC            0x19c
> -#define PCIE_PHY_TRSV2_EMP_LVL         0x204
> -#define PCIE_PHY_TRSV2_RXCDR           0x22c
> -#define PCIE_PHY_TRSV2_POWER           0x244
> -#define PCIE_PHY_TRSV2_PD_TSV          BIT(7)
> -#define PCIE_PHY_TRSV2_LVCC            0x25c
> -#define PCIE_PHY_TRSV3_EMP_LVL         0x2c4
> -#define PCIE_PHY_TRSV3_RXCDR           0x2ec
> -#define PCIE_PHY_TRSV3_POWER           0x304
> -#define PCIE_PHY_TRSV3_PD_TSV          BIT(7)
> -#define PCIE_PHY_TRSV3_LVCC            0x31c
> -
> -struct exynos_pcie_phy_data {
> -       const struct phy_ops    *ops;
> -};
> +#define PCIE_PHY_OFFSET(x)             ((x) * 0x4)
> +
> +/* Sysreg FSYS register offsets and bits for Exynos5433 */
> +#define PCIE_EXYNOS5433_PHY_MAC_RESET          0x0208
> +#define PCIE_MAC_RESET_MASK                    0xFF
> +#define PCIE_MAC_RESET                         BIT(4)
> +#define PCIE_EXYNOS5433_PHY_L1SUB_CM_CON       0x1010
> +#define PCIE_REFCLK_GATING_EN                  BIT(0)
> +#define PCIE_EXYNOS5433_PHY_COMMON_RESET       0x1020
> +#define PCIE_PHY_RESET                         BIT(0)
> +#define PCIE_EXYNOS5433_PHY_GLOBAL_RESET       0x1040
> +#define PCIE_GLOBAL_RESET                      BIT(0)

Resets, why is this block not a reset provider?

> +#define PCIE_REFCLK                            BIT(1)
> +#define PCIE_REFCLK_MASK                       0x16
> +#define PCIE_APP_REQ_EXIT_L1_MODE              BIT(5)
