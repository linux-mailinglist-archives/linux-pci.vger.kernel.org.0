Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B16A114E450
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2020 21:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgA3Uyl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 15:54:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41789 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3Uyl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2020 15:54:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so4441039otc.8;
        Thu, 30 Jan 2020 12:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gywvdJG4S8zg1F0N8TnRS+h5mKkXnwAKlRZJYdtt1ZA=;
        b=fqfQnsIOmo8FmmJdsz2QjZwzZa6CYUyDAHwdulBh0jkPnMA2cImjHHcOxHjDXmQxpK
         T6gAsbqbhlv3FqXjp2FtLtncpIuSJcy8c0KH8OQQJTA88lgBhyNTywMuTRS39yqoLn9e
         otCeRvbEC+QbtcPgCrRsBKdFutoKjpNJThPflcqDwcA6dn9elZQwW4cAmhwrC0l8nrWf
         yuiA5qOtgXUUsuFXmYRkCEKFgLvGn+d6kknn2KBw3Y513xLJzFWTdVL5+bfddX62jeJc
         U1SjOTbI/s0t/d877OkaPGV10zeH/1DLghuVq4hmhPkuDAIUTiTWYoPaMvWgvAXhqAx7
         aSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gywvdJG4S8zg1F0N8TnRS+h5mKkXnwAKlRZJYdtt1ZA=;
        b=pWllvH+ILYwfam+MHPZVQGaJiv36prPhp+dE+KE+rSrPtO+pSm58VRTJjvUQcarLjT
         1dj1deJXrxttvQu+S5mL9iaV8aagllfLnS1e6nSa2r2QxCJrQ2gjK4H08okZrEgtxduO
         ei60I99wYdyDWAA8w/UkMfEmb5vl15hAIaY2K9xDpI23xUbTbj8eNOWiPDZQnHpzTlgj
         w5RxOBWj5AFpb68rmFz/5CW0+jijjP9tOSj/+tOypT4qIdAorwwRiCyCcxmRIIBAQvh0
         HbotAMx4tnxfA2i+PuLsf8iQG/3n6IcaKmn3m9csBGh7YRrNw68riiKYrxMCAVIV/D8V
         MHWw==
X-Gm-Message-State: APjAAAVnbSIxueJ6bvHDDxDSiVKDh8SpQDSIXdr0ZclZzOj0XVEEMwMD
        v+ngJcI6DyNfIg1HDPvIGrkOf6SBNUL/Irrnkuk=
X-Google-Smtp-Source: APXvYqwBCKF8eCODlztMB8ORP0u3uiwR5t2s2nCfZgKiHWS07FIMyZ3kn6caD7U18ugZfY2NZqr0ejOUQrOc2egVDVs=
X-Received: by 2002:a9d:64ca:: with SMTP id n10mr5023218otl.325.1580417680064;
 Thu, 30 Jan 2020 12:54:40 -0800 (PST)
MIME-Version: 1.0
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CA+V-a8s1Jx8uZiSr0uiryS492EbFRoFg9QTwkosZsuyfRYp-3g@mail.gmail.com> <9c65eb7a-539b-1fa3-f988-40c32aa8dfe3@ti.com>
In-Reply-To: <9c65eb7a-539b-1fa3-f988-40c32aa8dfe3@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 30 Jan 2020 20:54:13 +0000
Message-ID: <CA+V-a8th3eysn0s2q9EEAqQb7vfd3bNcL=ow_z8tSWAC6K=iJw@mail.gmail.com>
Subject: Re: [v3 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Wed, Jan 22, 2020 at 8:13 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Prabhakar,
>
> On 21/01/20 11:27 PM, Lad, Prabhakar wrote:
> > Hi Rob/Kishon,
> >
> > On Wed, Jan 8, 2020 at 4:22 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >>
> >> This patch adds the bindings for the R-Car PCIe endpoint driver.
> >>
> >> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> ---
> >>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 76 +++++++++++++++++++
> >>  1 file changed, 76 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> >> new file mode 100644
> >> index 000000000000..99c2a1174463
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> >> @@ -0,0 +1,76 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/pci/rcar-pcie-ep.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Renesas R-Car PCIe Endpoint
> >> +
> >> +maintainers:
> >> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    items:
> >> +      - const: renesas,r8a774c0-pcie-ep
> >> +      - const: renesas,rcar-gen3-pcie-ep
> >> +
> >> +  reg:
> >> +    maxItems: 5
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: apb-base
> >> +      - const: memory0
> >> +      - const: memory1
> >> +      - const: memory2
> >> +      - const: memory3
>
> As I had mentioned in the other patch, I'd prefer if we can create
> standard binding for representing the memory regions. IMHO we should
> create subnode for memory regions Each sub-node itself may or may not
> have more than one memory region.
>
> In your platform, since there can be only one allocation in a memory
> region, there should be 4 sub-nodes for each of the memory region and
> each node should have page_size (or some equivalent property) property
> to indicate page_size (= region_size).
>
> For a platform that doesn't have the restriction, there can be a single
> sub-node containing all the memory region.
>
> Let's wait for Rob's comment though.
>
Gentle ping.on the suggestions above.

Cheers,
--Prabhakar

> Thanks
> Kishon
> >> +
> >> +  power-domains:
> >> +    maxItems: 1
> >> +
> >> +  resets:
> >> +    maxItems: 1
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  clock-names:
> >> +    items:
> >> +      - const: pcie
> >> +
> >> +  max-functions:
> >> +    minimum: 1
> >> +    maximum: 6
> >> +
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - reg-names
> >> +  - resets
> >> +  - power-domains
> >> +  - clocks
> >> +  - clock-names
> >> +  - max-functions
> >> +
> > apart from dt_binding_check error are we OK with dt bindings ?
> >
> > Cheers,
> > --Prabhakar
> >
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> >> +    #include <dt-bindings/power/r8a774c0-sysc.h>
> >> +
> >> +     pcie0_ep: pcie-ep@fe000000 {
> >> +            compatible = "renesas,r8a774c0-pcie-ep",
> >> +                         "renesas,rcar-gen3-pcie-ep";
> >> +            reg = <0 0xfe000000 0 0x80000>,
> >> +                  <0x0 0xfe100000 0 0x100000>,
> >> +                  <0x0 0xfe200000 0 0x200000>,
> >> +                  <0x0 0x30000000 0 0x8000000>,
> >> +                  <0x0 0x38000000 0 0x8000000>;
> >> +            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> >> +            resets = <&cpg 319>;
> >> +            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> >> +            clocks = <&cpg CPG_MOD 319>;
> >> +            clock-names = "pcie";
> >> +            max-functions = /bits/ 8 <1>;
> >> +    };
> >> --
> >> 2.20.1
> >>
