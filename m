Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4E910BA44
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2019 22:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfK0VBX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Nov 2019 16:01:23 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35332 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730867AbfK0VBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Nov 2019 16:01:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id 23so18597804otf.2;
        Wed, 27 Nov 2019 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ac89QnwXY1s2UQiWSXiKkMzWwZZELPTycnFpQTsI8k=;
        b=kvcHH3nnhTPYry+j463BIxgQ9Ii5HD9eMaJbuQd0OQtfseBeHWrGm+iBgVf46+0u+C
         Tc1N2LcLP/tpwdRodDCVa+57+u8Xg2FS5VVrpscrVh71OZCqvVsod3s/JFeIgTHCzwDn
         euFLQvQ5h7vzsk0i+3Hvh7RWWMwcR2JWjJA4/CZyStpzb3+87tBv9yBDzsTPqHiwQ7LB
         clZaaj5s70gJv8DNFLJ6toBOKPQa1iGYn1ZOqCPBK/MttFNhpehhGxAGJgOp+i1Ycj9N
         jYNDObQkN32HhWzV3OfHJZn6De8abVa/JW4gJYcw5MBXFGqYLSc/3QvMFvai3H93EXI7
         jFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ac89QnwXY1s2UQiWSXiKkMzWwZZELPTycnFpQTsI8k=;
        b=ZNS/2ou1HXTZXixT2lWDEzBsmjyJlB9VSQiGi6EaHo6870G9yNhM1MS44vQclWzSe0
         sVVIIuf3N0dK5xAnC1hMM48CDvSPb7Wbht2uNYKvCBGFeXeG/h+C0zH0/ieg9J0Rrk5s
         m9VWuqNT8tlUXom1FPN3LFhY5AeIsggujzy1EtOn0pV5EkfrwEA4JJDrLzr3LacrU2nn
         +Iyegx32Y79D3peZL4+KfJl88YgfLUedTJP9Ro9GF8mYZyrMGvKtRebQ3bHeLA9Jf2/k
         ZxpucNsu6z5UpEfcPZLfifljvLW8DJqGRaVRWd80YivMZz9oqpnfubvnEKPbNBKdwkM+
         r+kQ==
X-Gm-Message-State: APjAAAWzCiCFJSTvVgg4tPzhDgtPnQ3MpD4iZgn1VoZHZPoK7lCrpymb
        deMUvEcfpivsv1czyvXvNmd1LGRqhlfjbBhWyec=
X-Google-Smtp-Source: APXvYqzVAIMvmzOXzIjb8en0KWeCG4Yp6la02S+G7LSrtyaX1iBKqdgps6COS4Dy32ficJ3yWMXhqJdHmlcipenvR1c=
X-Received: by 2002:a05:6830:1089:: with SMTP id y9mr5269545oto.176.1574888481942;
 Wed, 27 Nov 2019 13:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20191106193609.19645-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVZwgVnq2kwjNJQHfvUH0sk6M7Hz-AJR82jMOsCNfW9wQ@mail.gmail.com>
 <CA+V-a8swtOUaxKnCdiTV5wvvxLEJ6XdODL=7bvQmFKY0zQTj2w@mail.gmail.com>
 <CAMuHMdXkbWkQgswMNL7Dw7_jucH+MsuAW+-CjoGVYsm=tjShRw@mail.gmail.com>
 <20191113040802.GA8269@bogus> <3b218f7f-78a8-c158-80ac-67a3b9f5970c@ti.com>
In-Reply-To: <3b218f7f-78a8-c158-80ac-67a3b9f5970c@ti.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 27 Nov 2019 21:00:55 +0000
Message-ID: <CA+V-a8u5B4CdQZw6dxKd2xfs56UsghMKMrRd=2g4yo8bmCgkXQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: rcar: Add R-Car PCIe endpoint device tree bindings
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

Hi Kishon,

On Wed, Nov 27, 2019 at 5:45 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 13/11/19 9:38 AM, Rob Herring wrote:
> > On Thu, Nov 07, 2019 at 09:08:35PM +0100, Geert Uytterhoeven wrote:
> >> Hi Prabhakar,
> >>
> >> On Thu, Nov 7, 2019 at 10:26 AM Lad, Prabhakar
> >> <prabhakar.csengg@gmail.com> wrote:
> >>> On Thu, Nov 7, 2019 at 8:44 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>> On Wed, Nov 6, 2019 at 8:36 PM Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >>>>> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>>
> >>>>> This patch adds the bindings for the R-Car PCIe endpoint driver.
> >>>>>
> >>>>> Signed-off-by: Lad, Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>
> >>>> Thanks for your patch!
> >>>>
> >>>>> --- /dev/null
> >>>>> +++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
> >>>>> @@ -0,0 +1,43 @@
> >>>>> +* Renesas R-Car PCIe Endpoint Controller DT description
> >>>>> +
> >>>>> +Required properties:
> >>>>> +           "renesas,pcie-ep-r8a774c0" for the R8A774C0 SoC;
> >>>>> +           "renesas,pcie-ep-rcar-gen3" for a generic R-Car Gen3 or
> >>>>> +                                    RZ/G2 compatible device.
> >>>>
> >>>> Unless I'm missing something, this is for the exact same hardware block as
> >>>> Documentation/devicetree/bindings/pci/rcar-pci.txt?
> >>>> So shouldn't you amend those bindings, instead of adding new compatible
> >>>> values?
> >>>> Please remember that DT describes hardware, not software policy.
> >>>> So IMHO choosing between host and endpoint is purely a configuration
> >>>> issue, and could be indicated by the presence or lack of some DT properties.
> >>>> E.g. host mode requires both "bus-range" and "device_type" properties,
> >>>> so their absence could indicate endpoint mode.
> >>>>
> >>> yes its the same hardware block as described in the rcar-pci.txt, I
> >>> did think about amending it
> >>> but  it might turn out to be bit messy,
> >>>
> >>> required properties host ======required properties Endpoint
> >>> ====================||==================
> >>> 1: reg                                || reg
> >>> 2:bus-range                      || reg names
> >>> 3: device_type                  || resets
> >>> 4: ranges                          || clocks
> >>> 5: dma-ranges                  || clock-names
> >>> 6: interrupts                      ||
> >>> 7: interrupt-cells               ||
> >>> 8: interrupt-map-mask     ||
> >>> 9: clocks                          ||
> >>> 10: clock-names             ||
> >>
> >> We have a similar situation with SPI, where a controller can operate in
> >> master or slave mode, based on the absence or presence of the
> >> "spi-slave" DT property.
> >>
> >>> and if I go ahead with the same compatible string that would mean to
> >>> add support for endpoint
> >>> mode in the host driver itself. I did follow the examples of
> >>
> >> You can still have two separate drivers, binding against the same
> >> compatible value.  Just let the .probe() function return -ENODEV if it
> >> discovers (by looking at DT properties) if the node is configured for
> >> the other mode.
> >> Which brings us to my next questions: is there any code that could be
> >> shared between the drivers for the two modes?
> >>
> >>> rockchip/cadence/designware where
> >>> its the same hardware block but has two different binding files one
> >>> for host mode and other for
> >>> endpoint mode.
> >>
> >> Having two separate DT binding documents sounds fine to me, if unifying
> >> them makes things too complex.
> >> However, I think they should use the same compatible value, because the
> >> hardware block is the same, but just used in a different mode.
> >>
> >> Rob/Mark: Any input from the DT maintainers?
> >
> > Separate files makes sense because different modes will want to
> > include different common schemas. We've generally been doing different
> > compatibles too which makes validating the node has the right set of
> > properties easier.
> >
> >>>>> +- reg: Five register ranges as listed in the reg-names property
> >>>>> +- reg-names: Must include the following names
> >>>>> +       - "apb-base"
> >>>>> +       - "memory0"
> >>>>> +       - "memory1"
> >>>>> +       - "memory2"
> >>>>> +       - "memory3"
> >>>>
> >>>> What is the purpose of the last 4 regions?
> >>>> Can they be chosen by the driver, at runtime?
> >>>>
> >>> no the driver cannot choose them at runtime, as these are the only
> >>> PCIE memory(0/1/2/3) ranges
> >>> in the AXI address space where host memory can be mapped.
> >>
> >> Are they fixed by the PCIe hardware, i.e. could they be looked up by the
> >> driver based on the compatible value?
> >
> > That would be strange for a memory range.
> >
> > Sounds like like 'ranges' though I'm not sure if 'ranges' for an EP
> > makes sense or what that should look like.
>
> These are similar to "memory node" with multiple address, size pairs. I'm
> thinking if these should be added as a subnode within PCIe EP controller device
> tree node?
>
+1

something similar like below ?

       pcie_ep: pcie_ep@fe000000 {
               compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
               reg = <0 0xfe000000 0 0x80000>;
               reg-names = "apb-base";
               clocks = <&cpg CPG_MOD 319>;
               clock-names = "pcie";
               power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
               resets = <&cpg 319>;
               mem-region {
                       base =  <0x0 0xfe100000 0 0x100000>,
                                    <0x0 0xfe200000 0 0x200000>,
                                    <0x0 0x30000000 0 0x8000000>,
                                    <0x0 0x38000000 0 0x8000000>;
                };
       };

Cheers,
--Prabhakar
