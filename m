Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A09C1443C6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2020 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAUR5n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jan 2020 12:57:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34796 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgAUR5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jan 2020 12:57:43 -0500
Received: by mail-oi1-f194.google.com with SMTP id l136so3437057oig.1;
        Tue, 21 Jan 2020 09:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mp6DdFVSXVePI6iSGCnPMxvllFc7taA3faXPCTrJyOk=;
        b=fvs0k64WTpLPoEYSU10yB4vhu1oKNCS3z851fAJBpMS31H71pFpdt95LE6mt0lodMh
         Jdqv99H4gGi4rcE1ufxinz/IjL1qBRzTshBYn4yImdugBHqsI/JvBDKbrLNnszNs8xDQ
         7CACHghR7TC+u1H1Yz57CoWfMmQiueT0PCEvJJHkVw72rFCT5yBklHSpu+SqGcn8vxNN
         8/lDvlGdM44tQFfDAWN260vjs6rXfoO5JpDNlqIuhvQJWCGbaCFHPIxVhRtMpVzJM3ye
         NPI62fQL1BoPCFs8rgxB6F9lcQFjMQlGgM4h7Y0zL2uDpQAFC7BdMYhoTEx8/xAwnt7p
         C3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mp6DdFVSXVePI6iSGCnPMxvllFc7taA3faXPCTrJyOk=;
        b=hfQGcjjWghvA35CTt3kKlehWLtCMqUhn7rxmgEig062Hd0y6yyO87TaC8hZxeDmnEL
         Ql+2l5/ny9wMgTZJzZtlfB16WhB3vV+5eybDi1ZKcuN5SjHLI+oQ1SJfrURq2Yp+ipE0
         bdtkPns61LsupGBIFp3RKknA4NcqPiIJ7R/AxC453b+0Bpu/uRwlUJ12evAFAzCY20J3
         0fzi2tf5SohtoUS4ckfwgLgC70a4ULFv0n1t6KE7GmVucFDv2a0zPjmv0TKy1MLAR5vE
         hq7U+fRbCCbnlZXjrSXI39KKpHs3s5LsnXL+BumfcxnmlUbpU+V6BmOuczUy+STzNbGt
         fdiQ==
X-Gm-Message-State: APjAAAV185nsAcdawaUq0BRvHnviOLKoeSDXrYqndt35QKN+GTV39YYb
        pe8E6BsGnv3kXQ4FUiimagx8mmY2VoJzfWS4cHw=
X-Google-Smtp-Source: APXvYqz8UqpqSR+lXSTxQDudfV5ATY6jfXYA7jHRsg0MIEWnG2M2frTp3v08cP9d/Qo4VBKw58GIa5lu+/MAx1m8ARs=
X-Received: by 2002:aca:4ad5:: with SMTP id x204mr3773363oia.162.1579629462726;
 Tue, 21 Jan 2020 09:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200108162211.22358-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 21 Jan 2020 17:57:18 +0000
Message-ID: <CA+V-a8s1Jx8uZiSr0uiryS492EbFRoFg9QTwkosZsuyfRYp-3g@mail.gmail.com>
Subject: Re: [v3 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
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

Hi Rob/Kishon,

On Wed, Jan 8, 2020 at 4:22 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> This patch adds the bindings for the R-Car PCIe endpoint driver.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-ep.yaml  | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> new file mode 100644
> index 000000000000..99c2a1174463
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 Renesas Electronics Europe GmbH - https://www.renesas.com/eu/en/
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rcar-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Renesas R-Car PCIe Endpoint
> +
> +maintainers:
> +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: renesas,r8a774c0-pcie-ep
> +      - const: renesas,rcar-gen3-pcie-ep
> +
> +  reg:
> +    maxItems: 5
> +
> +  reg-names:
> +    items:
> +      - const: apb-base
> +      - const: memory0
> +      - const: memory1
> +      - const: memory2
> +      - const: memory3
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: pcie
> +
> +  max-functions:
> +    minimum: 1
> +    maximum: 6
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - resets
> +  - power-domains
> +  - clocks
> +  - clock-names
> +  - max-functions
> +
apart from dt_binding_check error are we OK with dt bindings ?

Cheers,
--Prabhakar

> +examples:
> +  - |
> +    #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
> +    #include <dt-bindings/power/r8a774c0-sysc.h>
> +
> +     pcie0_ep: pcie-ep@fe000000 {
> +            compatible = "renesas,r8a774c0-pcie-ep",
> +                         "renesas,rcar-gen3-pcie-ep";
> +            reg = <0 0xfe000000 0 0x80000>,
> +                  <0x0 0xfe100000 0 0x100000>,
> +                  <0x0 0xfe200000 0 0x200000>,
> +                  <0x0 0x30000000 0 0x8000000>,
> +                  <0x0 0x38000000 0 0x8000000>;
> +            reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> +            resets = <&cpg 319>;
> +            power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> +            clocks = <&cpg CPG_MOD 319>;
> +            clock-names = "pcie";
> +            max-functions = /bits/ 8 <1>;
> +    };
> --
> 2.20.1
>
