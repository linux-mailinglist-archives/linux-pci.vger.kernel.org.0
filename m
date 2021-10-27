Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE843D355
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbhJ0U5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 16:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240812AbhJ0U5P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Oct 2021 16:57:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B45EC60720;
        Wed, 27 Oct 2021 20:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635368089;
        bh=XgfuZcgNeU1o4U066Dxlyrpi/I12+1zWGV5m7Pxr82o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OAbuJSfW5zjl/83ERQgTJgfEqJH2MF247qK72qSkpWBTuB8UEQaozQ0pWecCNQIof
         F3FXeEPLO9w032V5cxRglK2SL+lfHrzXp0pK9IGXZsScFgs0HWAgdX55DcLXE2rLok
         1/QbL1X46U8XQ1hMc2HjIkRoPAR7mzfx+oln2jKmf+D+SR1UtmKiTD9Uudb9bFSGhk
         8Iyi1Nuug5WA+ZKfaGAu0ragHv8Yaxkestd04NdJO9iOcvUwy8v7mPmQhyvUtE3Jeh
         Fuw4p+bS3s4j++kYt4eJ/OU9IrFeaB8mQzDPZHVuDvsbFzhLYT5jDwJShK4Ohm8Wuz
         iioEHUZjCr5Lw==
Received: by mail-ed1-f47.google.com with SMTP id 5so15159787edw.7;
        Wed, 27 Oct 2021 13:54:49 -0700 (PDT)
X-Gm-Message-State: AOAM5301dt+M1dtUD1uU4RdRYvXsbi/v5iVDBdgJeC0XBYdJk97iaM66
        8i+JXwFLWVyup+gKhRndE4dk42riT2E1+H1gWQ==
X-Google-Smtp-Source: ABdhPJziWywQQgYkEV9nIVhn4taCV9SnGHbldytyVbi1hcGiHMRYrSHL+de7NgTWJFbhsKP3lA23o5z0r7J4t3mLimY=
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr42058018ejc.84.1635368088211;
 Wed, 27 Oct 2021 13:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-2-jim2101024@gmail.com>
 <YXcup7d6ROmmPCuD@robh.at.kernel.org> <CA+-6iNyxYm4Sf6EsKjmedi8RF-CZKsXs9KXMjaTd_xqnyFL8ZA@mail.gmail.com>
In-Reply-To: <CA+-6iNyxYm4Sf6EsKjmedi8RF-CZKsXs9KXMjaTd_xqnyFL8ZA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Oct 2021 15:54:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLBqjEOB_rUJ-7KW7Pr4DH-VmxkDJpEZ_YNE4Vvz8kEsQ@mail.gmail.com>
Message-ID: <CAL_JsqLBqjEOB_rUJ-7KW7Pr4DH-VmxkDJpEZ_YNE4Vvz8kEsQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 26, 2021 at 4:27 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Mon, Oct 25, 2021 at 6:24 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Oct 22, 2021 at 10:06:54AM -0400, Jim Quinlan wrote:
> > > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > > allows optional regulators to be attached and controlled by the PCIe RC
> > > driver.  That being said, this driver searches in the DT subnode (the EP
> > > node, eg pci@0,0) for the regulator property.
> > >
> > > The use of a regulator property in the pcie EP subnode such as
> > > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > > file at
> > >
> > > https://github.com/devicetree-org/dt-schema/pull/54
> > >
> > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > ---
> > >  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
> > >  1 file changed, 23 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > index b9589a0daa5c..fec13e4f6eda 100644
> > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > @@ -154,5 +154,28 @@ examples:
> > >                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
> > >                      brcm,enable-ssc;
> > >                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> > > +
> > > +                    /* PCIe bridge */
> >
> > More specifically, the root port.
> >
> > > +                    pci@0,0 {
> > > +                            #address-cells = <3>;
> > > +                            #size-cells = <2>;
> > > +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +                            device_type = "pci";
> > > +                            ranges;
> > > +
> > > +                            /* PCIe endpoint */
> > > +                            pci@0,0 {
> > > +                                    device_type = "pci";
> >
> > This means this device is a PCI bridge which wouldn't typically be the
> > endpoint. Is that intended?
> Hi Rob,
>
> I'm not sure I understand what you are saying --  do you want the
> innermost node to be named something like ep-pci@0,0, and its
> containing node pci-bridge@0,0?   Or, more likely, I'm missing the
> point.  If my DT subtree is this

I'm confused as to how a bridge is the endpoint. If it is a bridge
(which 'device_type = "pci"' means it is), then there should be
another PCI device under it. That may or may not have a DT node.

> pcie@8b10000 {
>     compatible = "brcm,bcm7278-pcie";
>     ....
>     pci-bridge@0,0 {
>         reg = <0x0 0x0 0x0 0x0 0x0>; /* bus 0 */
>         .....
>         pci-ep@0,0,0 {
>             reg = <0x10000 0x0 0x0 0x0 0x0>;  /* bus 1 */
>             vpcie3v3-supply = <&vreg8>;
>             ...
>         }
>     }
> }
>
> then the of_nodes appear to align correctly with the devices:
>
> $ cd /sys/devices/platform/
> $ cat 8b10000.pcie/of_node/name
> pcie
> $ cat 8b10000.pcie/pci0000:00/0000:00:00.0/of_node
> pci-bridge
> $ cat 8b10000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node/name
> pci-ep

What does 'lspci -tv' show?

>
> and the EP device works of course.  I've even printed out the
> device_node structure in the EP driver's probe and it is as expected.
> I've noticed that examples such as
> "arch/arm64/boot/dts/nvidia/tegra186.dtsi" have the EP node (eg
> pci@1,0) directly under the
> host bridge DT node (pcie@10003000).  I did try doing that, but the EP
> device's probe is given a NUL device_node pointer.

If you want a complex example I know that's right, then see hikey970.

Rob
