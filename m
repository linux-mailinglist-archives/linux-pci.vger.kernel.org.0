Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203493DA652
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 16:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbhG2OZy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 10:25:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235324AbhG2OZx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 10:25:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7396B60F5C;
        Thu, 29 Jul 2021 14:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627568750;
        bh=1n3HhEfauZt5FKf05BMYCG8hKiwb7EL7iH6VP7Sc8u4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j8Sh62rpYVFl2q7hbHLUtyJSiU02IfPrYsE0dCsY4xp3crOiTX0ehTsc9wYtHAEBt
         wj/aUK47l/vczGBMdFCrfYB/Upbp8t73nDwjBo1zMkChuuID182/QzvuFLc/4C2vbp
         P3xCUnxtUFUhxktdcDv80R34EpOnZX8rtL2BA+ja2Ig0BFIXZatFx3cZhBMi73U8SR
         XWQAAAY8fUhp+JBjHtsOOT+OGFPH44rczUvkja2w5wcU86QxEwVM7CGe+Nbd7c27qc
         4afHl0ESQhm3jrjGt/BdoNnc1KQnI9hChGes+uS0GteTMXGxMIVR8ghoxL9Qd7SnUm
         zJyIBTNjgpHDw==
Received: by mail-ej1-f50.google.com with SMTP id gn26so11069367ejc.3;
        Thu, 29 Jul 2021 07:25:50 -0700 (PDT)
X-Gm-Message-State: AOAM533yQ8jBS1KiTX9M5+sxAqfMapA2Fo5HRLkIXiy07EpTzG/sVuO0
        IgR57xSn+QcgYhRpxdHmz5MZlowClgISsFXzCg==
X-Google-Smtp-Source: ABdhPJyzDjzGgrXrZgY8Null2IDZJ+lozmnd0yxT+x0p6Frv32x52pr7Tmk6byDOmklSglnW/4amm7MA1p5nmvMR62I=
X-Received: by 2002:a17:906:af7c:: with SMTP id os28mr4823130ejb.341.1627568749031;
 Thu, 29 Jul 2021 07:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210723204958.7186-1-tharvey@gateworks.com> <20210723204958.7186-6-tharvey@gateworks.com>
In-Reply-To: <20210723204958.7186-6-tharvey@gateworks.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Jul 2021 08:25:37 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+krVLH1rZp2R27=PA_pRTNmfvELLyfdUvd-iC1iTy2jA@mail.gmail.com>
Message-ID: <CAL_Jsq+krVLH1rZp2R27=PA_pRTNmfvELLyfdUvd-iC1iTy2jA@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: imx8mm: add PCIe support
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 23, 2021 at 2:50 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> Add PCIe node for PCIe support.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 3bec6b8d52a0..45017f50a11b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -1134,6 +1134,10 @@
>                                 reg = <0x32e50200 0x200>;
>                         };
>
> +                       pcie_phy: pcie-phy@32f00000 {
> +                                 compatible = "fsl,imx7d-pcie-phy";
> +                                 reg = <0x32f00000 0x10000>;

The phy really has 64KB worth of registers? This wastes virtual space
too, but I guess that's 'free' on 64-bit.

> +                       };
>                 };
>
>                 dma_apbh: dma-controller@33000000 {
> @@ -1233,5 +1237,37 @@
>                         reg = <0x3d800000 0x400000>;
>                         interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>                 };
> +
> +               pcie0: pcie@33800000 {
> +                       compatible = "fsl,imx8mm-pcie";
> +                       reg = <0x33800000 0x400000>,
> +                             <0x1ff00000 0x80000>;
> +                       reg-names = "dbi", "config";

I don't think the DBI space ever has 4MB of registers. And IIRC, only
4KB is used for config space unless ECAM is used.

> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       bus-range = <0x00 0xff>;
> +                       ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
> +                                0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
> +                       num-lanes = <1>;
> +                       num-viewport = <4>;

This is deprecated and ignored. The driver has gotten smarter and detects this.

> +                       interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi";
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &gic GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0 0 0 2 &gic GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0 0 0 3 &gic GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <0 0 0 4 &gic GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> +                       fsl,max-link-speed = <2>;

There's a standard property for this.

> +                       power-domains = <&pgc_pcie>;
> +                       resets = <&src IMX8MQ_RESET_PCIEPHY>,
> +                                <&src IMX8MQ_RESET_PCIE_CTRL_APPS_EN>,
> +                                <&src IMX8MQ_RESET_PCIE_CTRL_APPS_CLK_REQ>,
> +                                <&src IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF>;
> +                       reset-names = "pciephy", "apps", "clkreq", "turnoff";

The phy reset belongs in the phy node.

> +                       fsl,imx7d-pcie-phy = <&pcie_phy>;

Didn't we deprecate this? Either way, use the phy binding.

> +                       status = "disabled";
> +               };
>         };
>  };
> --
> 2.17.1
>
