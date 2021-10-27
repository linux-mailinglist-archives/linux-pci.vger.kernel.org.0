Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99FB43D5CC
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhJ0VeS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 17:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbhJ0Vdl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 17:33:41 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296EC061570
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 14:31:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m22so6534989wrb.0
        for <linux-pci@vger.kernel.org>; Wed, 27 Oct 2021 14:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D4Mhjd5SK9cIfjKibwbF4FuCWgAGy9+y27fhN/eSzIE=;
        b=SS9ik34dzGOmlT5pJQ6n/A0gLlqH6axzhvPLj1asy5cXMi/Pztt8zYq3QIwGh3z6v8
         FIOoeDlTNaZEkCLnc0Rq5rDItgCA414QF1a4QrclIrISKwqur2SpZktfkrVSuCK3BtfI
         w0mk1uFX5tOYpTKs05FpMMqydPRfQGVjUtCnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D4Mhjd5SK9cIfjKibwbF4FuCWgAGy9+y27fhN/eSzIE=;
        b=BfnNudF1uY3nSEomPzBN9EiRK8f8rWFXWvUCvh825UhfSRvcwSdfIpylP9CKRz49gJ
         BIL7bsQXqi0ES7BkFjD16kCoT6tF0QbLv3mYkEY1FZgR/V8bBltZ0zkgqCfl7wDS+Uk0
         eH1X//472yk5Hb6BKPyRlbCFXYFyRaC56v7mqiPcvD35p1ib4O+7DotLkjIBb/XsTrG6
         rQ8cQqcLI4bpB9SJ1thz11+MztKRhsc6OfBpDj6QECTICCS4yf0MKBtrvxey/wPOmrLB
         VwbiJzrgdeWmUCDCSzupUMtiaLzGANwhjRd7R0uRWexrsoALvtGr0y5+TIUUyV3Ky00U
         TVvg==
X-Gm-Message-State: AOAM531cT704J4iD0tPNNytHnckW2a3OUogqoa1REXqVHklenUpmhmGC
        kZ+qQJSn1jUSTk/jQlCAKPn2wWw8wAP1Dv0RpHkysA==
X-Google-Smtp-Source: ABdhPJxXkldBkDzzdkZpRximVZKSzZmCnAo9wrt206WQfFa1PrMjvgA0pu5wUjqH5GAQgQf47hBcHAlLMX6nKsXK5D0=
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr157022wrx.433.1635370272200;
 Wed, 27 Oct 2021 14:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-2-jim2101024@gmail.com>
 <YXcup7d6ROmmPCuD@robh.at.kernel.org> <CA+-6iNyxYm4Sf6EsKjmedi8RF-CZKsXs9KXMjaTd_xqnyFL8ZA@mail.gmail.com>
 <CAL_JsqLBqjEOB_rUJ-7KW7Pr4DH-VmxkDJpEZ_YNE4Vvz8kEsQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLBqjEOB_rUJ-7KW7Pr4DH-VmxkDJpEZ_YNE4Vvz8kEsQ@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Wed, 27 Oct 2021 17:31:01 -0400
Message-ID: <CA+-6iNyjD1sTYwOLGH8rj7q+VkKFg4eiK_C_n2X+6Js5AeHDsA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Rob Herring <robh@kernel.org>
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

On Wed, Oct 27, 2021 at 4:54 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Oct 26, 2021 at 4:27 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > On Mon, Oct 25, 2021 at 6:24 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Fri, Oct 22, 2021 at 10:06:54AM -0400, Jim Quinlan wrote:
> > > > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > > > allows optional regulators to be attached and controlled by the PCIe RC
> > > > driver.  That being said, this driver searches in the DT subnode (the EP
> > > > node, eg pci@0,0) for the regulator property.
> > > >
> > > > The use of a regulator property in the pcie EP subnode such as
> > > > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > > > file at
> > > >
> > > > https://github.com/devicetree-org/dt-schema/pull/54
> > > >
> > > > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > > > ---
> > > >  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > index b9589a0daa5c..fec13e4f6eda 100644
> > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > @@ -154,5 +154,28 @@ examples:
> > > >                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
> > > >                      brcm,enable-ssc;
> > > >                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> > > > +
> > > > +                    /* PCIe bridge */
> > >
> > > More specifically, the root port.
> > >
> > > > +                    pci@0,0 {
> > > > +                            #address-cells = <3>;
> > > > +                            #size-cells = <2>;
> > > > +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> > > > +                            device_type = "pci";
> > > > +                            ranges;
> > > > +
> > > > +                            /* PCIe endpoint */
> > > > +                            pci@0,0 {
> > > > +                                    device_type = "pci";
> > >
> > > This means this device is a PCI bridge which wouldn't typically be the
> > > endpoint. Is that intended?
> > Hi Rob,
> >
> > I'm not sure I understand what you are saying --  do you want the
> > innermost node to be named something like ep-pci@0,0, and its
> > containing node pci-bridge@0,0?   Or, more likely, I'm missing the
> > point.  If my DT subtree is this
>
> I'm confused as to how a bridge is the endpoint. If it is a bridge
> (which 'device_type = "pci"' means it is), then there should be
> another PCI device under it. That may or may not have a DT node.

I did not know that device_type="pci" implies that it must be a
bridge;  [1] says "device_type" is deprecated  for PCI and [2] defers
to Open Firmware EEE 1275, which is not free AFAICT. Do you have
better URLs that describe this?  At any rate, I will remove the
device_type="pci" from the innermost DT node, and resubmit.

>
> > pcie@8b10000 {
> >     compatible = "brcm,bcm7278-pcie";
> >     ....
> >     pci-bridge@0,0 {
> >         reg = <0x0 0x0 0x0 0x0 0x0>; /* bus 0 */
> >         .....
> >         pci-ep@0,0,0 {
> >             reg = <0x10000 0x0 0x0 0x0 0x0>;  /* bus 1 */
> >             vpcie3v3-supply = <&vreg8>;
> >             ...
> >         }
> >     }
> > }
> >
> > then the of_nodes appear to align correctly with the devices:
> >
> > $ cd /sys/devices/platform/
> > $ cat 8b10000.pcie/of_node/name
> > pcie
> > $ cat 8b10000.pcie/pci0000:00/0000:00:00.0/of_node
> > pci-bridge
> > $ cat 8b10000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node/name
> > pci-ep
>
> What does 'lspci -tv' show?

$ lspci -tv
-+-[0000:01]---00.0  Intel Corporation Wireless 7260
  \-[0000:00]---00.0  Broadcom Inc. and subsidiaries Device 7278


>
> >
> > and the EP device works of course.  I've even printed out the
> > device_node structure in the EP driver's probe and it is as expected.
> > I've noticed that examples such as
> > "arch/arm64/boot/dts/nvidia/tegra186.dtsi" have the EP node (eg
> > pci@1,0) directly under the
> > host bridge DT node (pcie@10003000).  I did try doing that, but the EP
> > device's probe is given a NUL device_node pointer.
>
> If you want a complex example I know that's right, then see hikey970.

Thanks, will look.

Jim

[1] https://buildmedia.readthedocs.org/media/pdf/devicetree-specification/latest/devicetree-specification.pdf
[2] https://www.openfirmware.info/data/docs/bus.pci.pdf
>
> Rob
