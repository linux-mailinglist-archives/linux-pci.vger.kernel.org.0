Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20ECB43BC5F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 23:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhJZVaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhJZVaK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 17:30:10 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9490AC061570
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 14:27:45 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 131-20020a1c0489000000b0032cca9883b5so3130517wme.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Oct 2021 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BSGmDT4IT0OUdG2TZ/MzDANj3hoY1OlScqOboO0Qhw=;
        b=WZRxOw049q3Fx2iR3QUGKrLSKHzSP2D+0fTkEtSQb7K42EgNzs3DXjXYToOYAahTK5
         M9o3wZh+Pgfpp19W+gvdt/bfxeG5B7zK88RbykUWlBte9FiaHf2GG2i2xY285bA4Nkv/
         Z7E4TmloJo80l2n6UaLf66Q5BMufYekR1xdjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BSGmDT4IT0OUdG2TZ/MzDANj3hoY1OlScqOboO0Qhw=;
        b=0oGd0RszmzDqGJnu5Ub5Ma+NWpk/cll6auCP0P/f+D4Qb1nTzMrsi28XqILQX03jUk
         g9zfbVEnO6AuHXW4pJUALm51D0xX2Yf9GHWWJFn+ARg6HwMQc/g3qrHWxmXjX26Ztgxl
         0w8+AXfWUJ/EB2P2jxAS4FCIrCqI80PHp40qXVVaYSPNodNVEWiT2kaUiN74/QketzqN
         XFBfNNBv4tIJN2q+dMdwllD4IhQjO/lLuSDKJEe2Fju7jH+vrs167ubHuA5oVaVsw6X+
         Ain43lvt9Z14K0ABBjTXqx9EedGgPIOAO5xeFhPZpsWlajl+kYlTXjwoXFWj18oKBlnU
         fnHw==
X-Gm-Message-State: AOAM533leH4U6Lm8xlc7zTMUk6/rp9ZdW3YlvCcxZAEf3npMcVzAhcRK
        TF3rdIsbPTYdURMDYxVIgjvAPjBntABeU1Cdvq5y2Q==
X-Google-Smtp-Source: ABdhPJzSeyu2KoXgWREowvWJB3JrbiTRS4JmQkoMKCywaoYbUrxgjdhV4pnrxU7UwlvIMMdCg+GOtPymbOmJcbiMnKk=
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr1358358wmh.122.1635283664104;
 Tue, 26 Oct 2021 14:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-2-jim2101024@gmail.com>
 <YXcup7d6ROmmPCuD@robh.at.kernel.org>
In-Reply-To: <YXcup7d6ROmmPCuD@robh.at.kernel.org>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 26 Oct 2021 17:27:32 -0400
Message-ID: <CA+-6iNyxYm4Sf6EsKjmedi8RF-CZKsXs9KXMjaTd_xqnyFL8ZA@mail.gmail.com>
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

On Mon, Oct 25, 2021 at 6:24 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Oct 22, 2021 at 10:06:54AM -0400, Jim Quinlan wrote:
> > Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> > allows optional regulators to be attached and controlled by the PCIe RC
> > driver.  That being said, this driver searches in the DT subnode (the EP
> > node, eg pci@0,0) for the regulator property.
> >
> > The use of a regulator property in the pcie EP subnode such as
> > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > file at
> >
> > https://github.com/devicetree-org/dt-schema/pull/54
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index b9589a0daa5c..fec13e4f6eda 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -154,5 +154,28 @@ examples:
> >                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
> >                      brcm,enable-ssc;
> >                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> > +
> > +                    /* PCIe bridge */
>
> More specifically, the root port.
>
> > +                    pci@0,0 {
> > +                            #address-cells = <3>;
> > +                            #size-cells = <2>;
> > +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> > +                            device_type = "pci";
> > +                            ranges;
> > +
> > +                            /* PCIe endpoint */
> > +                            pci@0,0 {
> > +                                    device_type = "pci";
>
> This means this device is a PCI bridge which wouldn't typically be the
> endpoint. Is that intended?
Hi Rob,

I'm not sure I understand what you are saying --  do you want the
innermost node to be named something like ep-pci@0,0, and its
containing node pci-bridge@0,0?   Or, more likely, I'm missing the
point.  If my DT subtree is this

pcie@8b10000 {
    compatible = "brcm,bcm7278-pcie";
    ....
    pci-bridge@0,0 {
        reg = <0x0 0x0 0x0 0x0 0x0>; /* bus 0 */
        .....
        pci-ep@0,0,0 {
            reg = <0x10000 0x0 0x0 0x0 0x0>;  /* bus 1 */
            vpcie3v3-supply = <&vreg8>;
            ...
        }
    }
}

then the of_nodes appear to align correctly with the devices:

$ cd /sys/devices/platform/
$ cat 8b10000.pcie/of_node/name
pcie
$ cat 8b10000.pcie/pci0000:00/0000:00:00.0/of_node
pci-bridge
$ cat 8b10000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node/name
pci-ep

and the EP device works of course.  I've even printed out the
device_node structure in the EP driver's probe and it is as expected.
I've noticed that examples such as
"arch/arm64/boot/dts/nvidia/tegra186.dtsi" have the EP node (eg
pci@1,0) directly under the
host bridge DT node (pcie@10003000).  I did try doing that, but the EP
device's probe is given a NUL device_node pointer.

I don't think it matters but our PCIe controllers only have a single root port.

Please advise,
Jim

>
> > +                                    assigned-addresses = <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> > +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> > +                                    compatible = "pci14e4,1688";
> > +                                    vpcie3v3-supply = <&vreg7>;
> > +
> > +                                    #address-cells = <3>;
> > +                                    #size-cells = <2>;
> > +
> > +                                    ranges;
> > +                            };
> > +                    };
> >              };
> >      };
> > --
> > 2.17.1
> >
> >
