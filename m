Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C10212FA5D
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgACQ3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 11:29:49 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45933 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgACQ3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 11:29:45 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so61796322otp.12;
        Fri, 03 Jan 2020 08:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TP17Q6SBM8RfPS7JEf89IxBEEl+82WJKOot5C8K9N98=;
        b=qqjelQ0+Kba+Pvu7W6JzOzsWlxmU4Ap+PUQ1JAnf1w4z9lOX0l2NhJIYieVbWYkq+i
         tZnhI+JcVeUs9DSAbecaKFqKLjENQC/bJXsXocYpxG/SaqscK8CFG6Q3VMOkAPlGS+vG
         NXTkv9j3ucpnFzf2QRu0uiA74wdEuNrJJ6QSBTmxAcPD9TmNe9mnDfArKRMUVuVuQ3Ou
         fgGlmjc677XGKTIEGhvglgnnFTTlb2s+aE66EfKRY8Pqg2Hop+iVfDEArN2O7oDnkG69
         whfs/9FCtOBgZogqFllOd00fE8JMvYZwHR0GoFtWLyKVfcYf2bfe+Iok4a+DPiocc2+J
         udBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TP17Q6SBM8RfPS7JEf89IxBEEl+82WJKOot5C8K9N98=;
        b=n67tly/MuUa+QJzx6r6wRj3UjMjFGYsqhcaOF4/Jv0FdZRlWx2msUs+TU1ov+iVI09
         6WmvFUYa30E/27cV/iNJWbfSYJcwEEDu+kCjRfWGDi69zy1+mskFUuJy5g426Vgtw4op
         BZCuPUkxsG5j4Jt5/fvK72ppgrO8Q42zW6H+M8457ip7vrEavXDylZq+qwBtLkBsZL5C
         LIZLXDn8KwbYUyJXe7WYP8a8LlKxI8g6bGr72LyQoC6X5QFwbsMFCoXS8qkD32jLOPtZ
         mC+B/DH89buEEpOlWnlzY1nv3STrw/8SFvQVznHNsh5yGiRbbvKzCYuDAVUZQ5zu2pq+
         dwrw==
X-Gm-Message-State: APjAAAUYnGrofmNCPsXeS//AZLximddfqiySLWnLERM7JuK2/oVVkFv7
        Xcvs4oA51ZVoVKIS885+WI+ptCp+LrK43z1wXeM=
X-Google-Smtp-Source: APXvYqyx0qfOGlCgf+mbqVx1RA3NJa/iWXu/notHG2jRzI1XyQlklOpJtiW2znnOyK1gz/QnIOAs/YVhOvNs6/K2WcU=
X-Received: by 2002:a9d:5c02:: with SMTP id o2mr92142289otk.176.1578068984784;
 Fri, 03 Jan 2020 08:29:44 -0800 (PST)
MIME-Version: 1.0
References: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191213084748.11210-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20191213084748.11210-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 3 Jan 2020 16:29:18 +0000
Message-ID: <CA+V-a8uZqwfbYNec7bPWf5RuZP-zVkAyAz8SMueJic5wU0zyBw@mail.gmail.com>
Subject: Re: [v2 4/6] dt-bindings: PCI: rcar: Add bindings for R-Car PCIe
 endpoint controller
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon/Rob,

On Fri, Dec 13, 2019 at 8:48 AM Lad Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This patch adds the bindings for the R-Car PCIe endpoint driver.
>
> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/pci/rcar-pci-ep.txt        | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> new file mode 100644
> index 0000000..7f0a97e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> @@ -0,0 +1,37 @@
> +* Renesas R-Car PCIe Endpoint Controller DT description
> +
> +Required properties:
> +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> +                                    RZ/G2 compatible device.
> +
> +           When compatible with the generic version, nodes must list the
> +           SoC-specific version corresponding to the platform first
> +           followed by the generic version.
> +
> +- reg: base address and length of the PCIe controller registers.
> +- outbound-ranges: outbound windows base address and length including the flags.
> +- resets: Must contain phandles to PCIe-related reset lines exposed by IP block
> +- clocks: from common clock binding: clock specifiers for the PCIe controller
> +        clock.
> +- clock-names: from common clock binding: should be "pcie".
> +
> +Optional Property:
> +- max-functions: Maximum number of functions that can be configured (default 1).
> +
> +Example:
> +
> +SoC-specific DT Entry:
> +
> +       pcie_ep: pcie_ep@fe000000 {
> +               compatible = "renesas,pcie-ep-r8a774c0", "renesas,pcie-rcar-gen2";
> +               reg = <0 0xfe000000 0 0x80000>;
> +               outbound-ranges = <0xa 0x0 0xfe100000 0 0x000100000
> +                                  0xa 0x0 0xfe200000 0 0x000200000
> +                                  0x6 0x0 0x30000000 0 0x008000000
> +                                  0x6 0x0 0x38000000 0 0x008000000>;
> +               clocks = <&cpg CPG_MOD 319>;
> +               clock-names = "pcie";
> +               power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> +               resets = <&cpg 319>;
> +       };

Now that I have dropped "outbound-ranges", do the below bindings look good ?

- reg-names: Must include the following names
 - "apb-base" - Controller base
 - "memory0" - memory window 0 used by the host to map the pci address locally
 - "memory1" - memory window 1 used by the host to map the pci address locally
- "memory2" - memory window 2 used by the host to map the pci address locally
- "memory3" - memory window 3 used by the host to map the pci address locally

    pcie-ep: pcie_ep@fe000000 {
        compatible = "renesas,pcie-r8a774c0", "renesas,pcie-rcar-gen2";
        reg = <0 0xfe000000 0 0x80000>,
            <0x0 0xfe100000 0 0x100000>,
            <0x0 0xfe200000 0 0x200000>,
            <0x0 0x30000000 0 0x8000000>,
            <0x0 0x38000000 0 0x8000000>;
        reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
        clocks = <&cpg CPG_MOD 319>;
        clock-names = "pcie";
        power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
        resets = <&cpg 319>;
    };

Cheers,
--Prabhakar
