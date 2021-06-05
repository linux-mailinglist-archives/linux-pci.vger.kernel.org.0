Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A363339C957
	for <lists+linux-pci@lfdr.de>; Sat,  5 Jun 2021 17:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhFEPIW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Jun 2021 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFEPIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Jun 2021 11:08:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116AC061766;
        Sat,  5 Jun 2021 08:06:18 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id c3so12949175oic.8;
        Sat, 05 Jun 2021 08:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pZGBUTcsC9wLwf22JBVKSKAB8z8I5XCkTelCimnUDxM=;
        b=j2/2j5z52zUCyAIzh+24r4ZQzgPlhlbp360qcvdjQyzoZuq3oEB3xqVKO5B0wUhZQp
         bAAyS6tBB6lNJy/CumNy3yjep/OB+YbZ1m0Q8Z9hPHlxLa5bu+/mPWoq7YSb/H8hDNtI
         YM5RUish+tmddCmUWZQ/aRFB3G1fTM2b2cK64luMnE89Tcj/+BNh5RdF7q5EFDtIEBin
         1SoMpWuVQQYr7d8wk7LjdUx+D3rmAkMastaWEI5NEiFIVQ8EBDurg8JRioTP7vEzEcIb
         6S/cj+3adUB+pEauEI5QVHc/6kA6Jz2Nb2BZbaojOSIQ9S5hNZ8M2eDxo8OTK4yk4+d8
         FR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZGBUTcsC9wLwf22JBVKSKAB8z8I5XCkTelCimnUDxM=;
        b=ErDtLvfSSGDZ9uJffYaYfVpdVFjwMCtQbZKe4GDyip+Ra2urBW4Govoq2X9/jFeRfx
         QO5ASxgu/M1rqRxLrMy64z1s4oJkHBF7lhiK1ZP/pnCN+0MhCt4++sAV5rQ9lMUE6kIn
         tn39m3O3Chp3Grx5pneeDOLOKOhcnE9Dkdhfkh0kN4feIFpvxXDnR9NYbk2gC4xPqgQ1
         qfrqFQukfWDaubb/FXQyK1w4hgB7OXY2p8b0OHQpoSiJsDimPmG5QfdVFcSHUbY0zkZm
         AzGrLO0WE7IiXSD8oFapTSeywOla2PSdu9nl45dReIbNmYJ7vlfPo6S3dBHBtRDMiUYB
         vh1Q==
X-Gm-Message-State: AOAM533oFvlJhHCsIaWYs11LeYtUMAV34BXuLJBd8voNkBrZAnyEPprl
        9RqFcJngBPB1mop7Sjpf4LxtDtveSzHfcVdaChM=
X-Google-Smtp-Source: ABdhPJyJwrkhnizoShzf9kfDu/xsTlC8+y7YCvIAdiYSB6wgIlc3p6eZGEoW1xcKxBkkbuFAmbQtyFS9Bv3LqGEdqMA=
X-Received: by 2002:aca:efc1:: with SMTP id n184mr14372406oih.23.1622905577676;
 Sat, 05 Jun 2021 08:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-2-sergio.paracuellos@gmail.com> <20210604193506.GC3695694@robh.at.kernel.org>
 <CAMhs-H8vkVoMaQr4Ky9xhzpwz-LjpBzd0kK=NTgO0Lo-m3pyng@mail.gmail.com>
In-Reply-To: <CAMhs-H8vkVoMaQr4Ky9xhzpwz-LjpBzd0kK=NTgO0Lo-m3pyng@mail.gmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 5 Jun 2021 17:06:06 +0200
Message-ID: <CAMhs-H9JCVS8ve8xLVdoSdexipPAtQLtEvDo8bKXZu4MABX78Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mt7621-pci: PCIe binding documentation
 for MT7621 SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:MIPS" <linux-mips@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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

On Fri, Jun 4, 2021 at 11:32 PM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> Hi Rob,
>
> Thanks for the review.
>
> On Fri, Jun 4, 2021 at 9:35 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, May 15, 2021 at 02:40:52PM +0200, Sergio Paracuellos wrote:
> > > Add device tree binding documentation for PCIe in MT7621 SoCs.
> > >
> > > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > ---
> > >  .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
> > >  1 file changed, 149 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > new file mode 100644
> > > index 000000000000..7f5f9d583032
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > > @@ -0,0 +1,149 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek MT7621 PCIe controller
> > > +
> > > +maintainers:
> > > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > > +
> > > +description: |+
> > > +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > > +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: mediatek,mt7621-pci
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: host-pci bridge registers
> > > +      - description: pcie port 0 RC control registers
> > > +      - description: pcie port 1 RC control registers
> > > +      - description: pcie port 2 RC control registers
> > > +
> > > +  ranges:
> > > +    maxItems: 2
> > > +
> > > +  resets:
> > > +    items:
> > > +      - description: pcie port 0 reset.
> > > +      - description: pcie port 1 reset.
> > > +      - description: pcie port 2 reset.
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: pcie0
> > > +      - const: pcie1
> > > +      - const: pcie2
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: pcie port 0 clock.
> > > +      - description: pcie port 1 clock.
> > > +      - description: pcie port 2 clock.
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: pcie0
> > > +      - const: pcie1
> > > +      - const: pcie2
> > > +
> > > +  phys:
> > > +    items:
> > > +      - description: Dual-ported phy for pcie port 0 and 1.
> > > +      - description: Phy for pcie port 2.
> > > +
> > > +  phy-names:
> > > +    items:
> > > +      - const: pcie-phy0
> > > +      - const: pcie-phy2
> >
> > If you're going to keep the ports (and I think that's right because
> > there's only a single PCI address space AFAICT), then I think you should
> > move resets, clocks, and phys into each port node.
> >
> > So you'll need to define 'pcie@[0-2],0' node with those properties under
> > it.
>
> Ok I will move these stuff to each port node. So each port node will
> be similar to:
>
> pcie@0,0 {
>     reg = <0x0000 0 0 0 0>;
>     #address-cells = <3>;
>     #size-cells = <2>;
>     device_type = "pci";
>     #interrupt-cells = <1>;
>     clocks = <&clkctrl 24>;
>     resets = <&rstctrl 24>;
>     phys = <&pcie0_phy 1>;
>     interrupt-map-mask = <0 0 0 0>;
>     interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
>     ranges;
> };
>
> How can I be sure by schema that the clocks, reset and phy properties
> are in each port node if I move them from the parent? By now each port
> node is just validating because of ' $ref:
> /schemas/pci/pci-bus.yaml#'.
>
> Thanks in advance for your time.
>

So I think, this should be enough:

%YAML 1.2
---
$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
$schema: http://devicetree.org/meta-schemas/core.yaml#

title: MediaTek MT7621 PCIe controller

maintainers:
  - Sergio Paracuellos <sergio.paracuellos@gmail.com>

description: |+
  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link

allOf:
  - $ref: /schemas/pci/pci-bus.yaml#

properties:
  compatible:
    const: mediatek,mt7621-pci

  reg:
    items:
      - description: host-pci bridge registers
      - description: pcie port 0 RC control registers
      - description: pcie port 1 RC control registers
      - description: pcie port 2 RC control registers

  ranges:
    maxItems: 2

patternProperties:
  'pcie@[0-2],0':
    type: object
    $ref: /schemas/pci/pci-bus.yaml#

    properties:
      resets:
        maxItems: 1

      clocks:
        maxItems: 1

      phys:
        maxItems: 1

    required:
      - "#interrupt-cells"
      - interrupt-map-mask
      - interrupt-map
      - resets
      - clocks
      - phys
      - phy-names
      - ranges

    unevaluatedProperties: false

required:
  - compatible
  - reg
  - ranges
  - "#interrupt-cells"
  - interrupt-map-mask
  - interrupt-map
  - reset-gpios

unevaluatedProperties: false

examples:
  - |
    #include <dt-bindings/gpio/gpio.h>
    #include <dt-bindings/interrupt-controller/mips-gic.h>

    pcie: pcie@1e140000 {
        compatible = "mediatek,mt7621-pci";
        reg = <0x1e140000 0x100>,
              <0x1e142000 0x100>,
              <0x1e143000 0x100>,
              <0x1e144000 0x100>;

        #address-cells = <3>;
        #size-cells = <2>;
        pinctrl-names = "default";
        pinctrl-0 = <&pcie_pins>;
        device_type = "pci";
        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,
/* pci memory */
                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;
/* io space */
        #interrupt-cells = <1>;
        interrupt-map-mask = <0xF800 0 0 0>;
        interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
                        <0x0800 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
                        <0x1000 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;

        pcie@0,0 {
            reg = <0x0000 0 0 0 0>;
            #address-cells = <3>;
            #size-cells = <2>;
            device_type = "pci";
            #interrupt-cells = <1>;
            interrupt-map-mask = <0 0 0 0>;
            interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
            resets = <&rstctrl 24>;
            clocks = <&clkctrl 24>;
            phys = <&pcie0_phy 1>;
            phy-names = "pcie-phy0";
            ranges;
        };

        pcie@1,0 {
            reg = <0x0800 0 0 0 0>;
            #address-cells = <3>;
            #size-cells = <2>;
            device_type = "pci";
            #interrupt-cells = <1>;
            interrupt-map-mask = <0 0 0 0>;
            interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
            resets = <&rstctrl 25>;
            clocks = <&clkctrl 25>;
            phys = <&pcie0_phy 1>;
            phy-names = "pcie-phy1";
            ranges;
        };

        pcie@2,0 {
            reg = <0x1000 0 0 0 0>;
            #address-cells = <3>;
            #size-cells = <2>;
            device_type = "pci";
            #interrupt-cells = <1>;
            interrupt-map-mask = <0 0 0 0>;
            interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
            resets = <&rstctrl 26>;
            clocks = <&clkctrl 26>;
            phys = <&pcie2_phy 0>;
            phy-names = "pcie-phy2";
            ranges;
        };
    };
...

I will send these bindings for v2 if you are ok with them.

Thanks,
     Sergio Paracuellos

> Best regards,
>     Sergio Paracuellos
>
> >
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - ranges
> > > +  - "#interrupt-cells"
> > > +  - interrupt-map-mask
> > > +  - interrupt-map
> > > +  - resets
> > > +  - reset-names
> > > +  - clocks
> > > +  - clock-names
> > > +  - phys
> > > +  - phy-names
> > > +  - reset-gpios
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> > > +
> > > +    pcie: pcie@1e140000 {
> > > +        compatible = "mediatek,mt7621-pci";
> > > +        reg = <0x1e140000 0x100>,
> > > +              <0x1e142000 0x100>,
> > > +              <0x1e143000 0x100>,
> > > +              <0x1e144000 0x100>;
> > > +
> > > +        #address-cells = <3>;
> > > +        #size-cells = <2>;
> > > +        pinctrl-names = "default";
> > > +        pinctrl-0 = <&pcie_pins>;
> > > +        device_type = "pci";
> > > +        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
> > > +                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
> > > +        #interrupt-cells = <1>;
> > > +        interrupt-map-mask = <0xF800 0 0 0>;
> > > +        interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> > > +                        <0x0800 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> > > +                        <0x1000 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> > > +        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
> > > +        reset-names = "pcie0", "pcie1", "pcie2";
> > > +        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
> > > +        clock-names = "pcie0", "pcie1", "pcie2";
> > > +        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
> > > +        phy-names = "pcie-phy0", "pcie-phy2";
> > > +        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
> > > +
> > > +        pcie@0,0 {
> > > +            reg = <0x0000 0 0 0 0>;
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +            device_type = "pci";
> > > +            #interrupt-cells = <1>;
> > > +            interrupt-map-mask = <0 0 0 0>;
> > > +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
> > > +            ranges;
> > > +        };
> > > +
> > > +        pcie@1,0 {
> > > +            reg = <0x0800 0 0 0 0>;
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +            device_type = "pci";
> > > +            #interrupt-cells = <1>;
> > > +            interrupt-map-mask = <0 0 0 0>;
> > > +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
> > > +            ranges;
> > > +        };
> > > +
> > > +        pcie@2,0 {
> > > +            reg = <0x1000 0 0 0 0>;
> > > +            #address-cells = <3>;
> > > +            #size-cells = <2>;
> > > +            device_type = "pci";
> > > +            #interrupt-cells = <1>;
> > > +            interrupt-map-mask = <0 0 0 0>;
> > > +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> > > +            ranges;
> > > +        };
> > > +    };
> > > +...
> > > --
> > > 2.25.1
