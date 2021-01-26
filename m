Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA0530430D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 16:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732105AbhAZPxE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 10:53:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391059AbhAZPuN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 10:50:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDF3C217BA;
        Tue, 26 Jan 2021 15:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611676172;
        bh=/qOarcR3puRm4ZERRBIze4MlNkoBXifiZ3qYK5UdTmM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rRLOf47pjRRlhbT0supOockTREKZvkPt+PJR12qzmQyKiuLqutQKRrodhtSM6RtRi
         G2uCg6Rof088MhHGy30FwBRCXTtKgtv+14B3U9CsqCd2poLqxgY6o1WsE0+qs4hQvy
         cR/VLSyySWDELsGENjgR3PgLcMnwgmOyWiM6Z/g/pv+hQGNM1dzOIqq/mOOr+5c3O1
         EtJeMqPsoZNJzt7H07VS0Io3U+1GJItXLeJTeTUrMK3SxdT4jMqNiG/mhWtt+zi7Zq
         T9DoCEX9Al888QjuEJ8yU6/8i0fnfMH307/EJY07JDjfzfqgY89AQ2bpQWABeGYuR6
         6Fmf96Yi772AQ==
Received: by mail-ed1-f46.google.com with SMTP id c6so20357533ede.0;
        Tue, 26 Jan 2021 07:49:31 -0800 (PST)
X-Gm-Message-State: AOAM531xd/tQkAHMWlklfNKK5++NPV1DpgiyiFWM715G8VKbnv1CwnYk
        OAVOMzkMjFogbTZcY2ElZ7lDO300HK1hE8aDuQ==
X-Google-Smtp-Source: ABdhPJxZ9g0m4dWI0Km5B8bq7UV0dXpv0lCREWIBsO2jYyBiTZc4nHCknvg29Uyq/GzzBSu2Nm7iCgn0IaGTV1wOAg0=
X-Received: by 2002:aa7:c895:: with SMTP id p21mr5057035eds.165.1611676170393;
 Tue, 26 Jan 2021 07:49:30 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611645945.git.mchehab+huawei@kernel.org> <30795b4a1cea54292d49881d5843e2bdbc496e4d.1611645945.git.mchehab+huawei@kernel.org>
In-Reply-To: <30795b4a1cea54292d49881d5843e2bdbc496e4d.1611645945.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 26 Jan 2021 09:49:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJrkvkBMzyAf_Wbv8tbEWbfTwjgwLYKf=Cr8S5mo_URfQ@mail.gmail.com>
Message-ID: <CAL_JsqJrkvkBMzyAf_Wbv8tbEWbfTwjgwLYKf=Cr8S5mo_URfQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] dt: pci: kirin-pcie.txt: convert it to yaml
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 26, 2021 at 1:35 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Convert the file into a JSON description at the yaml format.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 98 +++++++++++++++++++
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 50 ----------
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 99 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> new file mode 100644
> index 000000000000..8d8112b2aca0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/hisilicon,kirin-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin SoCs PCIe host DT description
> +
> +maintainers:
> +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> +
> +description: |
> +  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> +  It shares common functions with the PCIe DesignWare core driver and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/designware-pcie.yaml.

Drop this and move the $ref to here.

> +
> +properties:
> +  compatible:
> +    const: hisilicon,kirin960-pcie
> +
> +  reg:
> +    description: |
> +      Should contain rc_dbi, apb, phy, config registers location and length.
> +
> +  reg-names:
> +    description: |
> +      Must include the following entries:
> +      "dbi": controller configuration registers;
> +      "apb": apb Ctrl register defined by Kirin;
> +      "phy": apb PHY register defined by Kirin;
> +      "config": PCIe configuration space registers.

That needs to be a schema listing the entries.

> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Covered by pci-bus.yaml.

> +
> +  reset-gpios:
> +    description: The GPIO to generate PCIe PERST# assert and deassert signal.
> +    maxItems: 1
> +
> +allOf:
> +  - $ref: "designware,pcie.yaml#"
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - reset-gpios
> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - ranges
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map

pci-bus.yaml covers most of these.

> +
> +additionalProperties: false

This will cause the example to fail (some reason these didn't get
picked up by PW). You need to use 'unevaluatedProperties: false' here.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/hi3660-clock.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie@f4000000 {
> +        compatible = "hisilicon,kirin960-pcie";
> +        reg = <0x0 0xf4000000 0x0 0x1000>,
> +              <0x0 0xff3fe000 0x0 0x1000>,
> +              <0x0 0xf3f20000 0x0 0x40000>,
> +              <0x0 0xF4000000 0 0x2000>;
> +        reg-names = "dbi","apb","phy", "config";
> +        bus-range = <0x0  0x1>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
> +        num-lanes = <1>;
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0xf800 0 0 7>;
> +        interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
> +                        <0x0 0 0 2 &gic 0 0 0  283 4>,
> +                        <0x0 0 0 3 &gic 0 0 0  284 4>,
> +                        <0x0 0 0 4 &gic 0 0 0  285 4>;
> +        clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> +                 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> +                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> +                 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> +                 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> +        clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
> +                      "pcie_apb_sys", "pcie_aclk";
> +        reset-gpios = <&gpio11 1 0 >;
> +      };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> deleted file mode 100644
> index 8e4fe7fc50f9..000000000000
> --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -HiSilicon Kirin SoCs PCIe host DT description
> -
> -Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> -It shares common functions with the PCIe DesignWare core driver and
> -inherits common properties defined in
> -Documentation/devicetree/bindings/pci/designware,pcie.yaml.
> -
> -Additional properties are described here:
> -
> -Required properties
> -- compatible:
> -       "hisilicon,kirin960-pcie" for PCIe of Kirin960 SoC
> -- reg: Should contain rc_dbi, apb, phy, config registers location and length.
> -- reg-names: Must include the following entries:
> -  "dbi": controller configuration registers;
> -  "apb": apb Ctrl register defined by Kirin;
> -  "phy": apb PHY register defined by Kirin;
> -  "config": PCIe configuration space registers.
> -- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> -
> -Optional properties:
> -
> -Example based on kirin960:
> -
> -       pcie@f4000000 {
> -               compatible = "hisilicon,kirin-pcie";
> -               reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> -                     <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
> -               reg-names = "dbi","apb","phy", "config";
> -               bus-range = <0x0  0x1>;
> -               #address-cells = <3>;
> -               #size-cells = <2>;
> -               device_type = "pci";
> -               ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
> -               num-lanes = <1>;
> -               #interrupt-cells = <1>;
> -               interrupt-map-mask = <0xf800 0 0 7>;
> -               interrupt-map = <0x0 0 0 1 &gic 0 0 0  282 4>,
> -                               <0x0 0 0 2 &gic 0 0 0  283 4>,
> -                               <0x0 0 0 3 &gic 0 0 0  284 4>,
> -                               <0x0 0 0 4 &gic 0 0 0  285 4>;
> -               clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> -                        <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> -                        <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> -                        <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> -                        <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> -               clock-names = "pcie_phy_ref", "pcie_aux",
> -                             "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> -               reset-gpios = <&gpio11 1 0 >;
> -       };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3bb3233830ec..2b98a4763724 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13611,7 +13611,7 @@ M:      Xiaowei Song <songxiaowei@hisilicon.com>
>  M:     Binghui Wang <wangbinghui@hisilicon.com>
>  L:     linux-pci@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +F:     Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  F:     drivers/pci/controller/dwc/pcie-kirin.c
>
>  PCIE DRIVER FOR HISILICON STB
> --
> 2.29.2
>
