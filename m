Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38C3959DD
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhEaLr2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbhEaLr1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 07:47:27 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD21C061574;
        Mon, 31 May 2021 04:45:47 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w127so11995423oig.12;
        Mon, 31 May 2021 04:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mu+M1rCTrS0Vw3xkdvu1xXRgTWVrW2YWgKqFOsFE7JQ=;
        b=IetQb5cimgviLt6JnjBqTpAm8Y52f/FJ1QdmJEKsTmRUV57gSc29P1T4xhcWdT7JPM
         LwEkulGxmSvqAqmm9C/okW0F9WdpH7tkgo2rHofwaNZjhTwol+RptWuqrlRqHxtu0mKi
         +RxeFhHxmY1x8k3ImwhtgeL9Flocq4yVrQozIvTCgag4rSKjVPGFLpta4h4MIPIWBMAD
         EsC5eoDyjJ+a6HDCfeBhdI3QOdd7ucfOUknhXRZwEJy0xUDDmyq1vafoaMDgnEKLsDQO
         GrqNNug+eoUNwpzxJcP2aqOFq9/p/dM0Ir7F03SPtfyJ+K7Cgf0e9f/gWWWHoc+PCV2e
         4MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mu+M1rCTrS0Vw3xkdvu1xXRgTWVrW2YWgKqFOsFE7JQ=;
        b=VGbczrRJCf72MDqAfb8UkMfJXKn5VuhVnft8AqASo07Axtn6MB1KAR9p8fhxe84cue
         oWJgbb/J/HOIvf/VjsT/jOYc5LAKkDZ1mPRsPGfvdcUtdA9QgHqEzJarIAzKTufelutx
         ioMZar9nGGrSLWdBi8Z5B21alD8e24I2jxn2HI3fbQP1eP5PIndRAiWfSFVkwMH/Gkra
         1KM+HQAKhs6CPeG8l0rJOhNt2qJz5KkTehlbCi9cpYFvYC4ArDsnsSTrfWDEqybYDkWO
         Hn/2m6xJo15zNFAlLI48j+zEiUIBlwMAHDKv7pUrxDfjXxy2B1qB52RHDkJRlAtH3wJi
         oUFA==
X-Gm-Message-State: AOAM531S5q1WOfhP3HDEqfpYDgq1mOv+UAKOXViKhDx8k6kKNdM0xenF
        Z0d80xQQ5E1Vm5RqgzNXxM2hB7DbW2RMr0K6Y8lI6631mM4=
X-Google-Smtp-Source: ABdhPJyGHpJU/KnCRhU16Xda19FTK3v2cYq3sMbV5c9Pinif9g6xAWSp9NKHnxX4DothjfIIrDc6tdwmTSrwjQb40O4=
X-Received: by 2002:a54:400a:: with SMTP id x10mr17779739oie.158.1622461546407;
 Mon, 31 May 2021 04:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com> <20210515124055.22225-2-sergio.paracuellos@gmail.com>
In-Reply-To: <20210515124055.22225-2-sergio.paracuellos@gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 31 May 2021 13:45:35 +0200
Message-ID: <CAMhs-H82NwOnVYJ71Gh6jVyDo37cA3KavJw1OJRU5oH74YxUJQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mt7621-pci: PCIe binding documentation
 for MT7621 SoCs
To:     "open list:MIPS" <linux-mips@vger.kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-staging@lists.linux.dev,
        Greg KH <gregkh@linuxfoundation.org>,
        NeilBrown <neil@brown.name>,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Sat, May 15, 2021 at 2:40 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Add device tree binding documentation for PCIe in MT7621 SoCs.
>
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> new file mode 100644
> index 000000000000..7f5f9d583032
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7621 PCIe controller
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description: |+
> +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt7621-pci
> +
> +  reg:
> +    items:
> +      - description: host-pci bridge registers
> +      - description: pcie port 0 RC control registers
> +      - description: pcie port 1 RC control registers
> +      - description: pcie port 2 RC control registers
> +
> +  ranges:
> +    maxItems: 2
> +
> +  resets:
> +    items:
> +      - description: pcie port 0 reset.
> +      - description: pcie port 1 reset.
> +      - description: pcie port 2 reset.
> +
> +  reset-names:
> +    items:
> +      - const: pcie0
> +      - const: pcie1
> +      - const: pcie2
> +
> +  clocks:
> +    items:
> +      - description: pcie port 0 clock.
> +      - description: pcie port 1 clock.
> +      - description: pcie port 2 clock.
> +
> +  clock-names:
> +    items:
> +      - const: pcie0
> +      - const: pcie1
> +      - const: pcie2
> +
> +  phys:
> +    items:
> +      - description: Dual-ported phy for pcie port 0 and 1.
> +      - description: Phy for pcie port 2.
> +
> +  phy-names:
> +    items:
> +      - const: pcie-phy0
> +      - const: pcie-phy2
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - resets
> +  - reset-names
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> +
> +    pcie: pcie@1e140000 {
> +        compatible = "mediatek,mt7621-pci";
> +        reg = <0x1e140000 0x100>,
> +              <0x1e142000 0x100>,
> +              <0x1e143000 0x100>,
> +              <0x1e144000 0x100>;
> +
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&pcie_pins>;
> +        device_type = "pci";
> +        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
> +                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0xF800 0 0 0>;
> +        interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0800 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x1000 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> +        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
> +        reset-names = "pcie0", "pcie1", "pcie2";
> +        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
> +        clock-names = "pcie0", "pcie1", "pcie2";
> +        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
> +        phy-names = "pcie-phy0", "pcie-phy2";
> +        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
> +
> +        pcie@0,0 {
> +            reg = <0x0000 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0>;
> +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
> +            ranges;
> +        };
> +
> +        pcie@1,0 {
> +            reg = <0x0800 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0>;
> +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
> +            ranges;
> +        };
> +
> +        pcie@2,0 {
> +            reg = <0x1000 0 0 0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            device_type = "pci";
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0>;
> +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> +            ranges;
> +        };
> +    };
> +...
> --
> 2.25.1
>

Any comments on this binding? It's been a while in devicetree
patchwork review list without comments.

Thanks in advance for your time.

Best regards,
     Sergio Paracuellos
