Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD10B471E16
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 22:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhLLVfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 12 Dec 2021 16:35:13 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43676 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhLLVfM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 12 Dec 2021 16:35:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 21EA0CE0DAF;
        Sun, 12 Dec 2021 21:35:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E4C341CF;
        Sun, 12 Dec 2021 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639344909;
        bh=R64tI2obkn7D7ySHmCBqe8ERpEC1vgc5+gMcn2gXCyQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VCStpCbdtQLeBBXpPGGNddTVoIseGMsPCb5lmBU211PHB7CrkORpHBekoZXCatwc3
         2UHNMofHvhdwljSU/+n/NMLxG6fxpCoTTlcqNVan2hw4e6KlbJye4BBOEbF51hg0QC
         fsu8hCqsIo8tQAwBpstPQZ2ncdiedETu53QQ0kCtehQvB+5AhBPeS5iZwpiu2dzBI7
         BiDpijsVj+jCtqB7z2OFDCUzoZh1hSZnA+4Q9H2g40dII1U4t8oTDjVqX3cy64cfKf
         SUR1zQ5oSxW4Ex9Wa26gtS6TRewE5d6WY22dtfCP9C15YOZHdDYhaxIBdSjPQI/wft
         YHMU9T/XDXGvQ==
Received: by mail-ed1-f47.google.com with SMTP id o20so46662640eds.10;
        Sun, 12 Dec 2021 13:35:09 -0800 (PST)
X-Gm-Message-State: AOAM531Qwfb0f3eyEQSsmYfMu1ypnukMGVRw/vf5j8TBoBJQbLWmH5a6
        43FfHOmBzY4bRfBPKkhQSFbMmzl240yAY4k+fg==
X-Google-Smtp-Source: ABdhPJy8jBV8Z7Zm670HYzJ6GiPP9GdoIEKXiQCXJy+EoSSoHt9vu9UNSWi++JgvLz6Vozp0wbphEs/18l5vDT5cOMg=
X-Received: by 2002:a17:906:5e14:: with SMTP id n20mr39429708eju.466.1639344907565;
 Sun, 12 Dec 2021 13:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20211208171442.1327689-1-dmitry.baryshkov@linaro.org> <20211208171442.1327689-9-dmitry.baryshkov@linaro.org>
In-Reply-To: <20211208171442.1327689-9-dmitry.baryshkov@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 12 Dec 2021 15:34:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLiRPy7App3ooWKOeb87DXN2HpirO0-vEoAOfFx-4FbDw@mail.gmail.com>
Message-ID: <CAL_JsqLiRPy7App3ooWKOeb87DXN2HpirO0-vEoAOfFx-4FbDw@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] arm64: dts: qcom: sm8450: add PCIe0 RC device
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 8, 2021 at 11:15 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Add device tree node for the first PCIe host found on the Qualcomm
> SM8450 platform.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 101 +++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index a047d8a22897..09087a34a007 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -627,6 +627,84 @@ i2c14: i2c@a98000 {
>                                 #size-cells = <0>;
>                                 status = "disabled";
>                         };
> +               ];
> +
> +               pcie0: pci@1c00000 {
> +                       compatible = "qcom,pcie-sm8450";
> +                       reg = <0 0x01c00000 0 0x3000>,
> +                             <0 0x60000000 0 0xf1d>,
> +                             <0 0x60000f20 0 0xa8>,
> +                             <0 0x60001000 0 0x1000>,
> +                             <0 0x60100000 0 0x100000>;
> +                       reg-names = "parf", "dbi", "elbi", "atu", "config";
> +                       device_type = "pci";
> +                       linux,pci-domain = <0>;
> +                       bus-range = <0x00 0xff>;
> +                       num-lanes = <1>;
> +
> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +
> +                       ranges = <0x01000000 0x0 0x60200000 0 0x60200000 0x0 0x100000>,
> +                                <0x02000000 0x0 0x60300000 0 0x60300000 0x0 0x3d00000>;
> +
> +                       interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "msi";
> +                       #interrupt-cells = <1>;
> +                       interrupt-map-mask = <0 0 0 0x7>;
> +                       interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
> +                                       <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
> +                                       <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
> +                                       <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
> +
> +                       clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +                                <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
> +                                <&pcie0_lane>,
> +                                <&rpmhcc RPMH_CXO_CLK>,
> +                                <&gcc GCC_PCIE_0_AUX_CLK>,
> +                                <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +                                <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +                                <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +                                <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
> +                                <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
> +                                <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
> +                                <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
> +                       clock-names = "pipe",
> +                                     "pipe_mux",
> +                                     "phy_pipe",
> +                                     "ref",
> +                                     "aux",
> +                                     "cfg",
> +                                     "bus_master",
> +                                     "bus_slave",
> +                                     "slave_q2a",
> +                                     "ddrss_sf_tbu",
> +                                     "aggre0",
> +                                     "aggre1";
> +
> +                       iommus = <&apps_smmu 0x1c00 0x7f>;
> +                       iommu-map = <0x0   &apps_smmu 0x1c00 0x1>,
> +                                   <0x100 &apps_smmu 0x1c01 0x1>;
> +
> +                       resets = <&gcc GCC_PCIE_0_BCR>;
> +                       reset-names = "pci";
> +
> +                       power-domains = <&gcc PCIE_0_GDSC>;
> +                       power-domain-names = "gdsc";
> +
> +                       phys = <&pcie0_lane>;
> +                       phy-names = "pciephy";
> +
> +                       perst-gpio = <&tlmm 94 GPIO_ACTIVE_LOW>;
> +                       enable-gpio = <&tlmm 96 GPIO_ACTIVE_HIGH>;

-gpios is the preferred form.

And 'enable-gpios' is not documented.

Rob
