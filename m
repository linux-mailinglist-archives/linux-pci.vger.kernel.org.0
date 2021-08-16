Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B7F3EDD0F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 20:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhHPS1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 14:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhHPS1e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 14:27:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5279560F41;
        Mon, 16 Aug 2021 18:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629138422;
        bh=J5kTQ9jNl7GtseCHsR5QNLO97/SZNfu88It1yT0aXgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=soBU96Am8xpoYrCIDFq34hMvCNLtkV/saokQsws6vR5idXFHlIkTzhfhaFJUeaZTN
         7/rz7MbYA+vUxC39AAP//LRFFD+cx58LpziOIaR77NAittHTWUhLl6fGmgP0OsZYPm
         HNFZMz4UV5GyUK0NwhioXsRLNmZ3v4f1YM35kE9dkgpsohCI97iDQEvZRGpGVHlpem
         9ifcfx8E0t4/nXt4+GkWlFQWouvn0jiyEXs0UHSQoCVcquNZrZIww7I97AOZJRXqUX
         UEEBCsVs5tM172pAD+iUTyUDY1M0txYO0txd6Vlx8aqJSjkPu+sWCPTeRis8SipiK0
         EQnA0KFtephVw==
Received: by mail-ed1-f45.google.com with SMTP id cq23so10511771edb.12;
        Mon, 16 Aug 2021 11:27:02 -0700 (PDT)
X-Gm-Message-State: AOAM532GfXz/E7QYLNICPFEJnKPMAas4YX86IuUPLBojl73tDlpX2xeH
        rHU/D+dKNi7i8jui8dvcwl3djBaAAR4Vy6xEQQ==
X-Google-Smtp-Source: ABdhPJz6YhgNYjBk8iIsDDdHBbb7lpGhLb6RzR0UMxHzXXHppoWWDik/vzQWomeYCgfQTi6gAbFbYjX0iK/BvYvkAKc=
X-Received: by 2002:a05:6402:557:: with SMTP id i23mr21699802edx.373.1629138420901;
 Mon, 16 Aug 2021 11:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626855713.git.mchehab+huawei@kernel.org> <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
In-Reply-To: <e483ba44ed3d70e1f4ca899bb287fa38ee8a2876.1626855713.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Aug 2021 13:26:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLJkqr_UhDGa9duPxx5mXxcp2Ju4Xv2gH6vdru6zQY9OQ@mail.gmail.com>
Message-ID: <CAL_JsqLJkqr_UhDGa9duPxx5mXxcp2Ju4Xv2gH6vdru6zQY9OQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] arm64: dts: HiSilicon: Add support for HiKey 970
 PCIe controller hardware
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 3:39 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> Add DTS bindings for the HiKey 970 board's PCIe hardware.
>
> Co-developed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     | 71 +++++++++++++++++++
>  .../boot/dts/hisilicon/hikey970-pmic.dtsi     |  1 -
>  drivers/pci/controller/dwc/pcie-kirin.c       | 12 ----
>  3 files changed, 71 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 1f228612192c..6dfcfcfeedae 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -177,6 +177,12 @@ sctrl: sctrl@fff0a000 {
>                         #clock-cells = <1>;
>                 };
>
> +               pmctrl: pmctrl@fff31000 {
> +                       compatible = "hisilicon,hi3670-pmctrl", "syscon";
> +                       reg = <0x0 0xfff31000 0x0 0x1000>;
> +                       #clock-cells = <1>;
> +               };
> +
>                 iomcu: iomcu@ffd7e000 {
>                         compatible = "hisilicon,hi3670-iomcu", "syscon";
>                         reg = <0x0 0xffd7e000 0x0 0x1000>;
> @@ -660,6 +666,71 @@ gpio28: gpio@fff1d000 {
>                         clock-names = "apb_pclk";
>                 };
>
> +               its_pcie: interrupt-controller@f4000000 {
> +                       compatible = "arm,gic-v3-its";
> +                       msi-controller;
> +                       reg = <0x0 0xf5100000 0x0 0x100000>;

How does this h/w have a GIC-400 (which is GICv2) and then a GIC v3 ITS?

> +               };
> +
> +               pcie_phy: pcie-phy@fc000000 {
> +                       compatible = "hisilicon,hi970-pcie-phy";
> +                       reg = <0x0 0xfc000000 0x0 0x80000>;
> +
> +                       phy-supply = <&ldo33>;
> +
> +                       clocks = <&crg_ctrl HI3670_CLK_GATE_PCIEPHY_REF>,
> +                                <&crg_ctrl HI3670_CLK_GATE_PCIEAUX>,
> +                                <&crg_ctrl HI3670_PCLK_GATE_PCIE_PHY>,
> +                                <&crg_ctrl HI3670_PCLK_GATE_PCIE_SYS>,
> +                                <&crg_ctrl HI3670_ACLK_GATE_PCIE>;
> +                       clock-names = "phy_ref", "aux",
> +                                     "apb_phy", "apb_sys",
> +                                     "aclk";
> +
> +                       reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
> +                                     <&gpio3 1 0 >, <&gpio27 4 0 >;
> +
> +                       clkreq-gpios = <&gpio20 6 0 >, <&gpio27 3 0 >,
> +                                      <&gpio17 0 0 >;
> +
> +                       /* vboost iboost pre post main */
> +                       hisilicon,eye-diagram-param = <0xFFFFFFFF 0xFFFFFFFF
> +                                                      0xFFFFFFFF 0xFFFFFFFF
> +                                                      0xFFFFFFFF>;
> +
> +                       #phy-cells = <0>;
> +               };
> +
> +               pcie@f4000000 {
> +                       compatible = "hisilicon,kirin970-pcie";
> +                       reg = <0x0 0xf4000000 0x0 0x1000000>,
> +                             <0x0 0xfc180000 0x0 0x1000>,
> +                             <0x0 0xf5000000 0x0 0x2000>;
> +                       reg-names = "dbi", "apb", "config";
> +                       bus-range = <0x0  0x1>;
> +                       msi-parent = <&its_pcie>;

This means the PCI host doesn't have a MSI controller...

> +                       #address-cells = <3>;
> +                       #size-cells = <2>;
> +                       device_type = "pci";
> +                       phys = <&pcie_phy>;
> +                       ranges = <0x02000000 0x0 0x00000000
> +                                 0x0 0xf6000000
> +                                 0x0 0x02000000>;
> +                       num-lanes = <1>;
> +                       #interrupt-cells = <1>;
> +                       interrupts = <0 283 4>;
> +                       interrupt-names = "msi";

But then this says it does...
