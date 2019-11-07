Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBFDEF298C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 09:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbfKGIop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 03:44:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43333 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfKGIoo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Nov 2019 03:44:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id l14so1307207oti.10;
        Thu, 07 Nov 2019 00:44:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41NEiPopACB8w8/wi96XPwORusZtZyFOe+6fXdB5oWI=;
        b=NI65yWNHYzw3WUfYaSgg+0OwZsjJvaeLUXBcd1dVigp1vSRsHHiLLEihivro1QXy4j
         R9h0q5sfZFZniTzaTnfjF8lsPd52y7jPSA9jytSWou1mnDJVqCnpu77gb8zNI+qhomC1
         PZNVy8tOjSImByW2DAIHV+xCLFHeAyi2cg+D4/uV4QOhY8SwPsh+JWzqlX7z1HTj/ttF
         HNpmoV8geq5XlcmR5SZCNgGrhp0rPvlXvkJBfnaFYMJ/i1EEDx0dyT/bDrCC7BeUBp3U
         Oc2Os/EPiYAk+3VmFFkHKT8YzJPGzWRbwbeHVLzxH22NmRgFRaIcR4mMBnO6nLVprC1W
         p4hg==
X-Gm-Message-State: APjAAAWjy/fyBi5YNXpt8OmswGXfVzBFwssrW8MLuc9JavkMuPqKW4n/
        cFOukMWg49eHwIGwnZtlh1PnewQq8s+CfIQiTHk=
X-Google-Smtp-Source: APXvYqyLd+e060V3vapvpupJ//7p928pbjWfrqP8a74RfAwxyKf0nla2NjyjPYziuD+6o8scdy87CzLXM7S3IlcXjQw=
X-Received: by 2002:a05:6830:2363:: with SMTP id r3mr2078530oth.39.1573116282410;
 Thu, 07 Nov 2019 00:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 7 Nov 2019 09:44:31 +0100
Message-ID: <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
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
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This patch adds the bindings for the R-Car PCIe endpoint driver.
>
> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> @@ -0,0 +1,43 @@
> +* Renesas R-Car PCIe Endpoint Controller DT description
> +
> +Required properties:
> +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> +                                    RZ/G2 compatible device.

Unless I'm missing something, this is for the exact same hardware block as
Documentation/devicetree/bindings/pci/rcar-pci.txt?
So shouldn't you amend those bindings, instead of adding new compatible
values?
Please remember that DT describes hardware, not software policy.
So IMHO choosing between host and endpoint is purely a configuration
issue, and could be indicated by the presence or lack of some DT properties.
E.g. host mode requires both "bus-range" and "device_type" properties,
so their absence could indicate endpoint mode.

> +- reg: Five register ranges as listed in the reg-names property
> +- reg-names: Must include the following names
> +       - "apb-base"
> +       - "memory0"
> +       - "memory1"
> +       - "memory2"
> +       - "memory3"

What is the purpose of the last 4 regions?
Can they be chosen by the driver, at runtime?

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
> +               compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";

These compatible values do not match with the ones above
(but they match with what I'd like to see ;-)

> +               reg = <0 0xfe000000 0 0x80000>,
> +                       <0x0 0xfe100000 0 0x100000>,
> +                       <0x0 0xfe200000 0 0x200000>,
> +                       <0x0 0x30000000 0 0x8000000>,
> +                       <0x0 0x38000000 0 0x8000000>;
> +               reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
> +               clocks = <&cpg CPG_MOD 319>;
> +               clock-names = "pcie";
> +               power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
> +               resets = <&cpg 319>;
> +       };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
