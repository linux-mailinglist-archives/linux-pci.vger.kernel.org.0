Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A938318A
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 16:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbhEQOhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 May 2021 10:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240855AbhEQOfU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 May 2021 10:35:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB6A26192E;
        Mon, 17 May 2021 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621261023;
        bh=/Fke8gIzwbqA8x/UokWi0atigFQr973AI+PeWKSYjRU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=txRW5cq5TjoJfqLcL/h1JgCdmDTnx2hI7zmshAZiXPlCKzJyT+wfq3NZX15wBMKTT
         hXD6WWxOjx5bVMEw0UJXAz0gi1z0AZGsczmjtKzoUyyxTL9Qd774vglKgAm93krL8E
         zxQ0xqLy1b5gVJTSqLDQtb4u+EW/hDGQhB23MsnNz6mu7T728FxBXrVAnxVEsY95bD
         3bQThlTsuFQyKart6GcSHucSBDCrFhL+lFUZCe9+M39PdjKV5k9muXGRVK3onrBaFC
         kU9hCSPZbKu8jlSfabX6b9xdcfhx46kn+bXbwe44zptKsbe+Qxw8GwguA8gFF4LPcZ
         YTj2QK12Oxvhw==
Received: by mail-ed1-f52.google.com with SMTP id df21so7115603edb.3;
        Mon, 17 May 2021 07:17:02 -0700 (PDT)
X-Gm-Message-State: AOAM531Z9DxFCHzYj9higWkjANLuPDUr8PBzMiqhZJcxHmkal5WWOhBV
        nWVmemsE0zeXlWIMxfPdSnksD8baCRK9NpHihA==
X-Google-Smtp-Source: ABdhPJxDHyxbIZt279+m6/FlAXXLWN1Rl7kcX6dLAQjtZ8ouXZ0JBZhiFEebN8nnhBCaqIyvmA4grUT0xvv4rmv4zHI=
X-Received: by 2002:aa7:d893:: with SMTP id u19mr301411edq.258.1621261021464;
 Mon, 17 May 2021 07:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl> <20210516211851.74921-2-mark.kettenis@xs4all.nl>
In-Reply-To: <20210516211851.74921-2-mark.kettenis@xs4all.nl>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 17 May 2021 09:16:49 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+k5Bp6_BY2UD6HbKVXv=mzcqg9f_H4w=GWMm2rThxJbQ@mail.gmail.com>
Message-ID: <CAL_Jsq+k5Bp6_BY2UD6HbKVXv=mzcqg9f_H4w=GWMm2rThxJbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, May 16, 2021 at 4:19 PM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> From: Mark Kettenis <kettenis@openbsd.org>
>
> The Apple PCIe host controller is a PCIe host controller with
> multiple root ports present in Apple ARM SoC platforms, including
> various iPhone and iPad devices and the "Apple Silicon" Macs.

All the cover letter will be lost in the git history. Please mention
some details like this is a DWC controller here. I disagree that you
can't use the DWC binding. You can use it and extend it with what's
needed here. And that way, we could move from generic ECAM to an
actual driver in the OS if needed (hopefully not). More below.

> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> new file mode 100644
> index 000000000000..af3c9f64e380
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple PCIe host controller
> +
> +maintainers:
> +  - Mark Kettenis <kettenis@openbsd.org>
> +
> +description: |
> +  The Apple PCIe host controller is a PCIe host controller with
> +  multiple root ports present in Apple ARM SoC platforms, including
> +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: apple,t8103-pcie
> +      - const: apple,pcie
> +
> +  reg:
> +    minItems: 4
> +    maxItems: 6

6 or...

> +  reg-names:
> +    minItems: 4
> +    maxItems: 7

7?

> +    items:
> +      - const: ecam

'config'

The difference between ECAM or not in existing devices is really just
the size. If you look at the addresses on other DWC bindings, the
config region is just an iATU window within the host's PCI address
range.

> +      - const: rc

This would be 'dbi'?

Also check if we need 'atu' (only if it's not at the default offset)?

> +      - const: phy

Should there be a separate phy node?

> +      - const: port0
> +      - const: port1
> +      - const: port2

What's in these registers?

> +
> +  ranges:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts:
> +    minItems: 3
> +    maxItems: 3

Need to define what each one is.

> +
> +  msi-ranges:
> +    description:
> +      A list of pairs <intid span>, where "intid" is the first
> +      interrupt number that can be used as an MSI, and "span" the size
> +      of that range.

Hopefully, Marc Z will comment on the MSI bits. msi-map doesn't work
here? If we need something else, then it should be added to
pci-msi.txt.

One problem with this is it assumes 'intid' is one cell. It's really 2
for the AIC if we ignore flags (which would be another assumption that
we can ignore the last cell). Or maybe this belongs in the AIC
binding?

> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      minItems: 2
> +      maxItems: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - bus-range
> +  - interrupts
> +  - msi-controller
> +  - msi-parent
> +  - msi-ranges
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +    #include <dt-bindings/pinctrl/apple.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie0: pcie@690000000 {
> +        compatible = "apple,t8103-pcie", "apple,pcie";
> +        device_type = "pci";
> +
> +        reg = <0x6 0x90000000 0x0 0x1000000>,
> +              <0x6 0x80000000 0x0 0x4000>,
> +              <0x6 0x8c000000 0x0 0x4000>,
> +              <0x6 0x81000000 0x0 0x8000>,
> +              <0x6 0x82000000 0x0 0x8000>,
> +              <0x6 0x83000000 0x0 0x8000>;
> +        reg-names = "ecam", "rc", "phy", "port0", "port1", "port2";
> +
> +        interrupt-parent = <&aic>;
> +        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        msi-controller;
> +        msi-parent = <&pcie0>;
> +        msi-ranges = <704 32>;
> +
> +        iommu-map = <0x0 &dart0 0x8000 0x100>,
> +                    <0x100 &dart0 0x100 0x100>,
> +                    <0x200 &dart1 0x200 0x100>,
> +                    <0x300 &dart2 0x300 0x100>;
> +        iommu-map-mask = <0xff00>;

These need to be documented. You can assume they have a type already,
so just 'true' or any constraints.

> +
> +        bus-range = <0 7>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> +                 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> +
> +        clocks = <&pcie_core_clk>, <&pcie_aux_clk>, <&pcie_ref_clk>;
> +        pinctrl-0 = <&pcie_pins>;
> +        pinctrl-names = "default";
> +
> +        pci@0,0 {
> +          device_type = "pci";
> +          reg = <0x0 0x0 0x0 0x0 0x0>;
> +          reset-gpios = <&pinctrl_ap 152 0>;
> +          max-link-speed = <2>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +
> +        pci@1,0 {
> +          device_type = "pci";
> +          reg = <0x800 0x0 0x0 0x0 0x0>;
> +          reset-gpios = <&pinctrl_ap 153 0>;
> +          max-link-speed = <2>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +
> +        pci@2,0 {
> +          device_type = "pci";
> +          reg = <0x1000 0x0 0x0 0x0 0x0>;
> +          reset-gpios = <&pinctrl_ap 33 0>;
> +          max-link-speed = <1>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7327c9b778f1..789d79315485 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1654,6 +1654,7 @@ C:        irc://chat.freenode.net/asahi-dev
>  T:     git https://github.com/AsahiLinux/linux.git
>  F:     Documentation/devicetree/bindings/arm/apple.yaml
>  F:     Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +F:     Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:     Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:     arch/arm64/boot/dts/apple/
>  F:     drivers/irqchip/irq-apple-aic.c
> --
> 2.31.1
>
