Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9781EC475
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 23:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbgFBVld (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 17:41:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728226AbgFBVld (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jun 2020 17:41:33 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4884B20823;
        Tue,  2 Jun 2020 21:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591134092;
        bh=lE2qIKk7fGwpmdgOyUmGUSZcTgDTl1S+IeWtKVRZiB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MDcmsG4AsJa29AZLZyoyaLg1XXhJzFswAk0zW/njIgWzQbow0ZCLgSsLqd+gAeQXG
         C+8NWnC9t990cXc67f2TeU+s0cPjHcss27WIhpkpp9pNbZ/SHobhFO7ecDYXdWqccD
         84jHiAhyesNMy12lNigcDvQHG9hH+oyoyWjcyaQQ=
Received: by mail-oi1-f181.google.com with SMTP id z9so13394714oid.2;
        Tue, 02 Jun 2020 14:41:32 -0700 (PDT)
X-Gm-Message-State: AOAM533CA/eeis7UXDUuGs/awHAZB91FxuNFoRk/YixuRvacY6iI+fZu
        aLKfDBWeEFU7sR/OYZwamVcHv8UQaDaAjHNrdA==
X-Google-Smtp-Source: ABdhPJxGd1RDkZpLil39OM00IhmdJlV8U5qy7Nn3gSrgTh2gorz+2QOj5O8k4Aoo1zTVz6xs3rPGF8jvSLdSMIFh7Rs=
X-Received: by 2002:a05:6808:7cb:: with SMTP id f11mr4487019oij.152.1591134091638;
 Tue, 02 Jun 2020 14:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-4-james.quinlan@broadcom.com> <20200529174634.GA2630216@bogus>
 <CA+-6iNwWBFYHVKiwwJ95DYQ5zmc5uBo1cgZzd6rpD++aQWgGpw@mail.gmail.com>
In-Reply-To: <CA+-6iNwWBFYHVKiwwJ95DYQ5zmc5uBo1cgZzd6rpD++aQWgGpw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 2 Jun 2020 15:41:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKtASTzACSNn8BgmEBqf0eyR8RB_tjY7aUnvK+2GYXTbg@mail.gmail.com>
Message-ID: <CAL_JsqKtASTzACSNn8BgmEBqf0eyR8RB_tjY7aUnvK+2GYXTbg@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] dt-bindings: PCI: Add bindings for more Brcmstb chips
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 2, 2020 at 2:53 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
>
> On Fri, May 29, 2020 at 1:46 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, May 26, 2020 at 03:12:42PM -0400, Jim Quinlan wrote:
> > > From: Jim Quinlan <jquinlan@broadcom.com>
> > >
> > > - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
> > >   7211 (STB version of RPi4).
> > > - add new property 'brcm,scb-sizes'
> > > - add new property 'resets'
> > > - add new property 'reset-names'
> > > - allow 'ranges' and 'dma-ranges' to have more than one item and update
> > >   the example to show this.
> > >
> > > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > > ---
> > >  .../bindings/pci/brcm,stb-pcie.yaml           | 40 +++++++++++++++++--
> > >  1 file changed, 36 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > index 8680a0f86c5a..66a7df45983d 100644
> > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > @@ -14,7 +14,13 @@ allOf:
> > >
> > >  properties:
> > >    compatible:
> > > -    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> > > +    items:
> > > +      - enum:
> >
> > Don't need items here. Just change the const to enum.
> >
> > > +          - brcm,bcm2711-pcie # The Raspberry Pi 4
> > > +          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> > > +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> > > +          - brcm,bcm7216-pcie # Broadcom 7216 Arm
> > > +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -34,10 +40,12 @@ properties:
> > >        - const: msi
> > >
> > >    ranges:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 4
> > >
> > >    dma-ranges:
> > > -    maxItems: 1
> > > +    minItems: 1
> > > +    maxItems: 6
> > >
> > >    clocks:
> > >      maxItems: 1
> > > @@ -58,8 +66,30 @@ properties:
> > >
> > >    aspm-no-l0s: true
> > >
> > > +  resets:
> > > +    description: for "brcm,bcm7216-pcie", must be a valid reset
> > > +      phandle pointing to the RESCAL reset controller provider node.
> > > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > > +
> > > +  reset-names:
> > > +    items:
> > > +      - const: rescal
> >
> > These are going to need to be an if/then schema if they only apply to
> > certain compatible(s).
>
> Why is that -- the code is general enough to handle its presence or
> not (it is an optional compatibility)>

Because an if/then schema expresses in a parse-able form what your
'description' does in free form text.

Presumably a 'resets' property for !brcm,bcm7216-pcie is invalid, so
we should check that. The schema shouldn't be just what some driver
happens to currently allow. Also, it's not a driver's job to validate
DT, so it shouldn't check any of this.

> > > +  brcm,scb-sizes:
> > > +    description: (u32, u32) tuple giving the 64bit PCIe memory
> > > +      viewport size of a memory controller.  There may be up to
> > > +      three controllers, and each size must be a power of two
> > > +      with a size greater or equal to the amount of memory the
> > > +      controller supports.
> >
> > This sounds like what dma-ranges should express?
>
> There is some overlap but this contains information that is not in the
> dma-ranges.  Believe me I tried.

I don't understand. If you had 3 dma-ranges entries, you'd have 3
sizes. Can you expand or show me what you tried?

> > If not, we do have 64-bit size if that what you need.
>
> IIRC I tried the 64-bit size but the YAML validator did not like it;
> it wanted numbers like  <0x1122334455667788> while dtc wanted <
> 0x11223344 0x55667788>.  I gave up trying and switched to u32.

You used the /bits/ annotation for dtc?:

/bits/ 64 <0x1122334455667788>

I also made a recent fix to dt-schema around handling of 64-bit sizes,
so update if you have problems still.

Rob
