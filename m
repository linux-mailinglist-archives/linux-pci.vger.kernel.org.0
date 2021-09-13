Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75D3409EAA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbhIMU53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240811AbhIMU52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 16:57:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BD306112D;
        Mon, 13 Sep 2021 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631566572;
        bh=u21F0Qc3W5xKzemF6XyCuLp0711VZEltghW2Zp/TzdM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f5xip+4uLk4XmoJ0loYaWM3ZvFn8qidx0SGsGoeSetL276JRq6TWW4RSS4ylDNa/H
         127uDkDzo6f2g2G7YWaOdkcuYvzcSMGhN38cMucRjA2Gu0HOtJ4yXzAEQdzh1jU9NA
         vPGXIsmgwc6sEdsAHfeLEtldgQSLsveFCpwj2fFKUqO+sjQfGsceSFwi00W8zHv7oY
         yH98jkHuqlcEHEkVsHWsETBH0Lk3UArcgVCgsiDHsI60cdbIRZRoL3gX+6ibaT7T0k
         c45bzI8nsM1TaIDb9YWaUiBdAwOpasglWftnXginlQJWZ9DmZ05v4Cjigjlq4Sy/RA
         bTTNxUDF56vmw==
Received: by mail-ej1-f41.google.com with SMTP id t19so23834034ejr.8;
        Mon, 13 Sep 2021 13:56:12 -0700 (PDT)
X-Gm-Message-State: AOAM530vKFStB8757H7UJl3FY1pH5dlE3cpjLz0HPPo/avnw8G1KWrME
        PsZqzkfbC9D9LVk3c4MJ0tKEzqjkYY1NEd0ERg==
X-Google-Smtp-Source: ABdhPJxFNgqvcHf/mkvu2z/C3ttLRf+0xoy1kOg9AJ9EbIy/9D7CdlQfST9RTtZNOyeiSK7GBLZzjvJXBt2b2tTdmuM=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr14644054ejk.147.1631566570779;
 Mon, 13 Sep 2021 13:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-4-mark.kettenis@xs4all.nl> <YS6dWI4wwg7XkuNA@robh.at.kernel.org>
 <561431b178447575@bloch.sibelius.xs4all.nl> <8735q9d02q.wl-maz@kernel.org>
In-Reply-To: <8735q9d02q.wl-maz@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 13 Sep 2021 15:55:59 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJYhrJxGCdUM8Fz50KN-AEARYzvfi3CcmyCVTkr8VCkjQ@mail.gmail.com>
Message-ID: <CAL_JsqJYhrJxGCdUM8Fz50KN-AEARYzvfi3CcmyCVTkr8VCkjQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mark Kettenis <mark.kettenis@xs4all.nl>,
        devicetree@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

msi-On Sun, Sep 12, 2021 at 3:13 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 01 Sep 2021 12:29:22 +0100,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Tue, 31 Aug 2021 16:21:28 -0500
> > > From: Rob Herring <robh@kernel.org>
> > >
> > > On Fri, Aug 27, 2021 at 07:15:28PM +0200, Mark Kettenis wrote:
> > > > From: Mark Kettenis <kettenis@openbsd.org>
> > > >
> > > > The Apple PCIe host controller is a PCIe host controller with
> > > > multiple root ports present in Apple ARM SoC platforms, including
> > > > various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > >
> > > > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > > > ---
> > > >  .../devicetree/bindings/pci/apple,pcie.yaml   | 165 ++++++++++++++++++
> > > >  MAINTAINERS                                   |   1 +
> > > >  2 files changed, 166 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > new file mode 100644
> > > > index 000000000000..97a126db935a
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> > > > @@ -0,0 +1,165 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Apple PCIe host controller
> > > > +
> > > > +maintainers:
> > > > +  - Mark Kettenis <kettenis@openbsd.org>
> > > > +
> > > > +description: |
> > > > +  The Apple PCIe host controller is a PCIe host controller with
> > > > +  multiple root ports present in Apple ARM SoC platforms, including
> > > > +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> > > > +  The controller incorporates Synopsys DesigWare PCIe logic to
> > > > +  implements its root ports.  But the ATU found on most DesignWare
> > > > +  PCIe host bridges is absent.
> > > > +
> > > > +  All root ports share a single ECAM space, but separate GPIOs are
> > > > +  used to take the PCI devices on those ports out of reset.  Therefore
> > > > +  the standard "reset-gpios" and "max-link-speed" properties appear on
> > > > +  the child nodes that represent the PCI bridges that correspond to
> > > > +  the individual root ports.
> > > > +
> > > > +  MSIs are handled by the PCIe controller and translated into regular
> > > > +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> > > > +  distributed over the root ports as the OS sees fit by programming
> > > > +  the PCIe controller's port registers.
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > > +  - $ref: ../interrupt-controller/msi-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - const: apple,t8103-pcie
> > > > +      - const: apple,pcie
> > > > +
> > > > +  reg:
> > > > +    minItems: 3
> > > > +    maxItems: 5
> > > > +
> > > > +  reg-names:
> > > > +    minItems: 3
> > > > +    maxItems: 5
> > > > +    items:
> > > > +      - const: config
> > > > +      - const: rc
> > > > +      - const: port0
> > > > +      - const: port1
> > > > +      - const: port2
> > > > +
> > > > +  ranges:
> > > > +    minItems: 2
> > > > +    maxItems: 2
> > > > +
> > > > +  interrupts:
> > > > +    description:
> > > > +      Interrupt specifiers, one for each root port.
> > > > +    minItems: 1
> > > > +    maxItems: 3
> > > > +
> > > > +  msi-parent: true
> > >
> > > I still think this should be dropped as it is meaningless with
> > > 'msi-controller' present.
> >
> > Hmm.  As far as I can tell all current arm64 device trees that
> > describe hardware with an MSI controller integrated on the PCI host
> > bridge have both the 'msi-controller' and 'msi-parent' properties.
> > See arch/arm64/boot/dts/marvell/aramada-37xx.dtsi and
> > arch/arm64/boot/dts/xilinx/zynqmp.dtsi.

Humm, maybe it is the DWC based bindings and driver that are wrong
here. All the ones with an 'msi' interrupt (i.e. the DWC built-in MSI
controller) have neither 'msi-parent' nor 'msi-controller' property.

> > The current OpenBSD code will fail to map the MSIs if 'msi-parent'
> > isn't there, although Linux seems to fall back on an MSI domain that's
> > directly attached to the host bridge if the 'msi-parent' property is
> > missing.  I think it makes sense to be explicit here, but if both you
> > and Marc think it shouldn't be there, I probably can change the
> > OpenBSD to do a similar fallback.
>
> I think this matches the behaviour we have for interrupt-controller vs
> interrupt-parent. I fail to see why msi-controller/msi-parent should
> behave differently. And since there is an established OS that actually
> requires this, I don't see how we can today make it illegal.

Which behavior exactly? An interrupt-controller node with
interrupt-parent pointing to itself? That makes little sense. As far
as finding the parent, the behavior for interrupts is if
'interrupt-controller' is found in a parent node, then that is the
interrupt parent unless 'interrupt-parent' is found. That is the same
behavior I'm suggesting here.

But yes, if this is already needed, then we need to keep it. However,
then my concern is other platforms working on OpenBSD if Linux allows
something that OpenBSD does not.

Rob
