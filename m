Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151E939C27E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 23:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFDVey (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFDVex (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 17:34:53 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7770CC061766;
        Fri,  4 Jun 2021 14:32:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so10477907otg.2;
        Fri, 04 Jun 2021 14:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDGProiCSKfs97byvQlpAFHaI+zbUyvA+0ui68k/ZIw=;
        b=B6slvx5nXQ4jF+11r1IN0YERepRkouNhOYwa/rMFWXuecYQZ3UhiiqULPyoSx+lp1D
         oSDMiwPHOjJrSF9iCGqNOcpNWm/bdurP4nG308cbWIN1FY/5YWzVZzl7Pwu9qqF8nZAI
         bLEplhZmsmhtKM9iYgIK1WZ7+XZdb3ChrXgeyreT0ObTGb/PoT4SN8OW6Wp/OdAqoxM7
         GUb8oG4q4nYtNhPAWYh4LfPlGLjppgo9fkeimP5rx5OVfwEtM7V9mg7BoUXIViXMuhw9
         0dXzZ6sJ1egzqsRf5bF7zfbrGzRFT7G3fNTuEt5Us21hb7xi1euZb5l5ds3nuaVHwYH4
         Vr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDGProiCSKfs97byvQlpAFHaI+zbUyvA+0ui68k/ZIw=;
        b=l6wd/PPHvRPus9MJPto7myHVFmwwxZsoZsZx2XcJhCj6wfK9Hh95nt14xWjcUYqRlr
         qQtVkELzJN0g2W8pOmM2sRRkdQ8+jUNEOD9QEd6q6nP5n0qwnwDUXx8B/dT/pj0IXZMW
         69VZGaIiVjPdwYj+iXdrKJlOvCSvBTg4jVb9JfyfCe45BcsryfHIDL5D9ujMjUGfYkjf
         mBxOu0hdlfiBl6y4vdTzZ0PZ5cW5Y8r8JPvuXABzFAZE3Qaqcow0t7hTy4RwXvSH/c8Z
         GMvDxrPBcvDgrCr/797Vgf0VK/0vMErRUahf4C7C4SIl2maRqP6ZKZhljJnPlDtN7cgA
         9vwA==
X-Gm-Message-State: AOAM532fIACao2A45Sj7+jkAeTf+28Wrv6HURDarqCCSqPci54XMyw8Z
        hKS6iJRI2kuOjfDupW3W+gRYylS/WtYu/5uPlqU=
X-Google-Smtp-Source: ABdhPJy/duOW3zXXU0VCeFASVFByb0n9K5IFAmBE8iU7JFUnx0Wlqde41SBA6GIW37hsGt9pfIK/XxM2425Ls48SkxM=
X-Received: by 2002:a9d:4592:: with SMTP id x18mr5265041ote.74.1622842371840;
 Fri, 04 Jun 2021 14:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
 <20210515124055.22225-2-sergio.paracuellos@gmail.com> <20210604193506.GC3695694@robh.at.kernel.org>
In-Reply-To: <20210604193506.GC3695694@robh.at.kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Fri, 4 Jun 2021 23:32:40 +0200
Message-ID: <CAMhs-H8vkVoMaQr4Ky9xhzpwz-LjpBzd0kK=NTgO0Lo-m3pyng@mail.gmail.com>
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

Thanks for the review.

On Fri, Jun 4, 2021 at 9:35 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, May 15, 2021 at 02:40:52PM +0200, Sergio Paracuellos wrote:
> > Add device tree binding documentation for PCIe in MT7621 SoCs.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
> >  1 file changed, 149 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > new file mode 100644
> > index 000000000000..7f5f9d583032
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
> > @@ -0,0 +1,149 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT7621 PCIe controller
> > +
> > +maintainers:
> > +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > +
> > +description: |+
> > +  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
> > +  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: mediatek,mt7621-pci
> > +
> > +  reg:
> > +    items:
> > +      - description: host-pci bridge registers
> > +      - description: pcie port 0 RC control registers
> > +      - description: pcie port 1 RC control registers
> > +      - description: pcie port 2 RC control registers
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  resets:
> > +    items:
> > +      - description: pcie port 0 reset.
> > +      - description: pcie port 1 reset.
> > +      - description: pcie port 2 reset.
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pcie0
> > +      - const: pcie1
> > +      - const: pcie2
> > +
> > +  clocks:
> > +    items:
> > +      - description: pcie port 0 clock.
> > +      - description: pcie port 1 clock.
> > +      - description: pcie port 2 clock.
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pcie0
> > +      - const: pcie1
> > +      - const: pcie2
> > +
> > +  phys:
> > +    items:
> > +      - description: Dual-ported phy for pcie port 0 and 1.
> > +      - description: Phy for pcie port 2.
> > +
> > +  phy-names:
> > +    items:
> > +      - const: pcie-phy0
> > +      - const: pcie-phy2
>
> If you're going to keep the ports (and I think that's right because
> there's only a single PCI address space AFAICT), then I think you should
> move resets, clocks, and phys into each port node.
>
> So you'll need to define 'pcie@[0-2],0' node with those properties under
> it.

Ok I will move these stuff to each port node. So each port node will
be similar to:

pcie@0,0 {
    reg = <0x0000 0 0 0 0>;
    #address-cells = <3>;
    #size-cells = <2>;
    device_type = "pci";
    #interrupt-cells = <1>;
    clocks = <&clkctrl 24>;
    resets = <&rstctrl 24>;
    phys = <&pcie0_phy 1>;
    interrupt-map-mask = <0 0 0 0>;
    interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
    ranges;
};

How can I be sure by schema that the clocks, reset and phy properties
are in each port node if I move them from the parent? By now each port
node is just validating because of ' $ref:
/schemas/pci/pci-bus.yaml#'.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ranges
> > +  - "#interrupt-cells"
> > +  - interrupt-map-mask
> > +  - interrupt-map
> > +  - resets
> > +  - reset-names
> > +  - clocks
> > +  - clock-names
> > +  - phys
> > +  - phy-names
> > +  - reset-gpios
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/mips-gic.h>
> > +
> > +    pcie: pcie@1e140000 {
> > +        compatible = "mediatek,mt7621-pci";
> > +        reg = <0x1e140000 0x100>,
> > +              <0x1e142000 0x100>,
> > +              <0x1e143000 0x100>,
> > +              <0x1e144000 0x100>;
> > +
> > +        #address-cells = <3>;
> > +        #size-cells = <2>;
> > +        pinctrl-names = "default";
> > +        pinctrl-0 = <&pcie_pins>;
> > +        device_type = "pci";
> > +        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
> > +                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
> > +        #interrupt-cells = <1>;
> > +        interrupt-map-mask = <0xF800 0 0 0>;
> > +        interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0x0800 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
> > +                        <0x1000 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> > +        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
> > +        reset-names = "pcie0", "pcie1", "pcie2";
> > +        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
> > +        clock-names = "pcie0", "pcie1", "pcie2";
> > +        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
> > +        phy-names = "pcie-phy0", "pcie-phy2";
> > +        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
> > +
> > +        pcie@0,0 {
> > +            reg = <0x0000 0 0 0 0>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 0>;
> > +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
> > +            ranges;
> > +        };
> > +
> > +        pcie@1,0 {
> > +            reg = <0x0800 0 0 0 0>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 0>;
> > +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
> > +            ranges;
> > +        };
> > +
> > +        pcie@2,0 {
> > +            reg = <0x1000 0 0 0 0>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +            device_type = "pci";
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 0>;
> > +            interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
> > +            ranges;
> > +        };
> > +    };
> > +...
> > --
> > 2.25.1
