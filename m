Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4008F13A292
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgANILk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 03:11:40 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41253 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANILk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 03:11:40 -0500
Received: by mail-oi1-f193.google.com with SMTP id i1so10981062oie.8;
        Tue, 14 Jan 2020 00:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESgbHWyyXZkUE+Zt5y6qd3pCusxZlx2vlVaiZEg9MHY=;
        b=qs1x37BdbYn5t6+23mL0IE+dw5g0PGcS5ldK99AKnwJhurHow1kPcdhAGd29oDAm8D
         vZBnicg0mFy4ulUyWo0e8COjmB12/uPF+VtzOLHMl3i2Y1CA3Ok+t56Iw7roc0KjzqaL
         oP5L7jiNCAM4qY4BkmOi/LHpeFyDNKziaX5S1OHwT9HS2QKe7wriSs4oHZJxZyRmwF+I
         yVc/UuBYs6IkcHdWcknqLstN1X15uGDB/JZ1R29VlAT0nx8/An6hzNW9Qbqclaec5XYC
         4dh6dw3o/hl+Q22PdhB8rlk0cLlApYHShdgEnK3Tts+cco5LAo1nulGT+ZpVyzFZBbHQ
         SF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESgbHWyyXZkUE+Zt5y6qd3pCusxZlx2vlVaiZEg9MHY=;
        b=hyt0rq1GHGTpBD4aQRVnRIb10a4gkwUUka8PA8E6Ng/QPEDDQ22jWaJCgWv0kiE1il
         UJUuSx3hJUleB6cML8FwaUFPWu1nkrSieKhZNfdWCCC5OoeYLp4W+huJJiQ3Io34X23s
         iiETB2VDpP5dWcxvaIDM60YrGgdY5m4odwmZFI0QIwJ/ex4RkKFCQ/2K4Y2wgfZOc+Rm
         Aea6wmhX6bBqVqFI67vznSW/hOg8KyaJM6WQUH1KTFXkeOwJlCzqtx5meuzqeCmC7+6n
         3fkh3vnyARTCRjgvWUtDX6ONX3mUqyCW/o9BMts6FIqMgm44lGWpvBNuNU+P7IPdL8DC
         y8GA==
X-Gm-Message-State: APjAAAUiRhjjXpR/JuRljBkoUTb6KipAR6tlphhJtkP8v84iAvTmSnp2
        68ulTo52vke09lUCk6oa+x3XBILWGQZfLsW/zqk=
X-Google-Smtp-Source: APXvYqzCDP1HlSPkjT+Ko+pskg045pRBOTrM+W3f2eEy7IcfuScVnML1cmr+MHU+++hW/8MQQKSTseULh6yeUpc2qVo=
X-Received: by 2002:aca:1309:: with SMTP id e9mr15897662oii.7.1578989498871;
 Tue, 14 Jan 2020 00:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200113212252.GA3120@bogus>
In-Reply-To: <20200113212252.GA3120@bogus>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 14 Jan 2020 08:11:12 +0000
Message-ID: <CA+V-a8sP=zTU1UAbXBWCpAn0uduNnUg+JEK0-y8G-4dV4AVVGQ@mail.gmail.com>
Subject: Re: [v3 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-pci <linux-pci@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

thank you for the review.

On Mon, Jan 13, 2020 at 9:23 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 08, 2020 at 04:22:09PM +0000, Lad Prabhakar wrote:
> > This patch adds the bindings for the R-Car PCIe endpoint driver.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>
> Fails 'make dt_binding_check':
>
> Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml: $id:
> path/filename 'pci/rcar-pcie-ep.yaml' doesn't match actual filename
>
my bad fill that and post a v4.

Cheers,
--Prabhakar Lad
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> > new file mode 100644
> > index 000000000000..99c2a1174463
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/rcar-pcie-ep.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas R-Car PCIe Endpoint
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: renesas,r8a774c0-pcie-ep
> > +      - const: renesas,rcar-gen3-pcie-ep
> > +
> > +  reg:
> > +    maxItems: 5
> > +
> > +  reg-names:
> > +    items:
> > +      - const: apb-base
> > +      - const: memory0
> > +      - const: memory1
> > +      - const: memory2
> > +      - const: memory3
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pcie
> > +
> > +  max-functions:
> > +    minimum: 1
> > +    maximum: 6
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - resets
> > +  - power-domains
> > +  - clocks
> > +  - clock-names
> > +  - max-functions
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> > +    #include <dt-bindings/power/r8a774c0-sysc.h>
> > +
> > +     pcie0_ep: pcie-ep@fe000000 {
> > +            compatible = "renesas,r8a774c0-pcie-ep",
> > +                         "renesas,rcar-gen3-pcie-ep";
> > +            reg = <0 0xfe000000 0 0x80000>,
> > +                  <0x0 0xfe100000 0 0x100000>,
> > +                  <0x0 0xfe200000 0 0x200000>,
> > +                  <0x0 0x30000000 0 0x8000000>,
> > +                  <0x0 0x38000000 0 0x8000000>;
> > +            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> > +            resets = <&cpg 319>;
> > +            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> > +            clocks = <&cpg CPG_MOD 319>;
> > +            clock-names = "pcie";
> > +            max-functions = /bits/ 8 <1>;
> > +    };
> > --
> > 2.20.1
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
