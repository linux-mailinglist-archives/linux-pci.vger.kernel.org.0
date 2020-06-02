Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224F1EC4AB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jun 2020 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgFBV4A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jun 2020 17:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBVz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jun 2020 17:55:59 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BFC08C5C0
        for <linux-pci@vger.kernel.org>; Tue,  2 Jun 2020 14:55:59 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g10so4346096wmh.4
        for <linux-pci@vger.kernel.org>; Tue, 02 Jun 2020 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pC4aWKB/tDCD8vk19vY98cQZrnpY1VLP07nYFKTadOU=;
        b=WhxoEIQrmXsVVkA1mZVZKHhKg98bXnh64aQouQ50aCjmPZ6Go6IUNqkNkmRLQtsbLz
         +8NZpw9RcHfUiShiva+naYN2YYMjHReQHnCpy4waamumHgcoQ/UijyjLt/TKis5pTg8i
         nb1O9KeHNB7EcwoVeXRMywsXvcUbbhlj84SoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pC4aWKB/tDCD8vk19vY98cQZrnpY1VLP07nYFKTadOU=;
        b=nFzDaK3B5pgZ/1W9hB3YjtXt2KIytBhYBTqop81EJnMZZ5AAKu++6aK7qQGodQYRRQ
         5kMXuao1ulWaQKlbvZKZjKqfV251srD1ZKfnvn+Q0Fu6ACxjeGwNsHNRau8qhmNn8ozS
         pz+ieiXoYpMOGgYNd3WWlevqHeaDI0/LL+hpjgRudtjYQKwIVRaghFSpohDxc7tejLxq
         PplMhkvykFt6U96b61VXK20dBpL+k+LIWkyz1PofDYN5sxNWh/31NBvLMSWWh5lQUVd6
         if5w2EASunaZXy2/zO0aBy6FJL6ybbDY5o7bY/ySC+Xs/VRBUH915Zejtd/ttREc8Ag0
         H1Bg==
X-Gm-Message-State: AOAM531fyP2+o/avhUB5fAjaKERS9ROJJj9TMonJKZtcB9F/FjrGlS/M
        +wTHFyliXCISvf183X87KRNEgt79ES/7L1R9m81/9j1U
X-Google-Smtp-Source: ABdhPJwV813+YIcH+IIsN44nF4R01Z3ZJCDnktHPUm8naM80EtbshruegyltyRNHVxPWX8Q2oaB7+zkMkg3Lra2ICo8=
X-Received: by 2002:a05:600c:280c:: with SMTP id m12mr6141691wmb.92.1591134957775;
 Tue, 02 Jun 2020 14:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-4-james.quinlan@broadcom.com> <20200529174634.GA2630216@bogus>
 <CA+-6iNwWBFYHVKiwwJ95DYQ5zmc5uBo1cgZzd6rpD++aQWgGpw@mail.gmail.com> <CAL_JsqKtASTzACSNn8BgmEBqf0eyR8RB_tjY7aUnvK+2GYXTbg@mail.gmail.com>
In-Reply-To: <CAL_JsqKtASTzACSNn8BgmEBqf0eyR8RB_tjY7aUnvK+2GYXTbg@mail.gmail.com>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 2 Jun 2020 17:55:44 -0400
Message-ID: <CA+-6iNxK7WaE2c_kwZDk3j7BiVkFdS-FaL5U1TP_DNvBNGgi3w@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] dt-bindings: PCI: Add bindings for more Brcmstb chips
To:     Rob Herring <robh@kernel.org>
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

On Tue, Jun 2, 2020 at 5:41 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jun 2, 2020 at 2:53 PM Jim Quinlan <james.quinlan@broadcom.com> wrote:
> >
> > On Fri, May 29, 2020 at 1:46 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Tue, May 26, 2020 at 03:12:42PM -0400, Jim Quinlan wrote:
> > > > From: Jim Quinlan <jquinlan@broadcom.com>
> > > >
> > > > - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
> > > >   7211 (STB version of RPi4).
> > > > - add new property 'brcm,scb-sizes'
> > > > - add new property 'resets'
> > > > - add new property 'reset-names'
> > > > - allow 'ranges' and 'dma-ranges' to have more than one item and update
> > > >   the example to show this.
> > > >
> > > > Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> > > > ---
> > > >  .../bindings/pci/brcm,stb-pcie.yaml           | 40 +++++++++++++++++--
> > > >  1 file changed, 36 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > index 8680a0f86c5a..66a7df45983d 100644
> > > > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > > > @@ -14,7 +14,13 @@ allOf:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> > > > +    items:
> > > > +      - enum:
> > >
> > > Don't need items here. Just change the const to enum.
> > >
> > > > +          - brcm,bcm2711-pcie # The Raspberry Pi 4
> > > > +          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> > > > +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> > > > +          - brcm,bcm7216-pcie # Broadcom 7216 Arm
> > > > +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > @@ -34,10 +40,12 @@ properties:
> > > >        - const: msi
> > > >
> > > >    ranges:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 4
> > > >
> > > >    dma-ranges:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 6
> > > >
> > > >    clocks:
> > > >      maxItems: 1
> > > > @@ -58,8 +66,30 @@ properties:
> > > >
> > > >    aspm-no-l0s: true
> > > >
> > > > +  resets:
> > > > +    description: for "brcm,bcm7216-pcie", must be a valid reset
> > > > +      phandle pointing to the RESCAL reset controller provider node.
> > > > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > > > +
> > > > +  reset-names:
> > > > +    items:
> > > > +      - const: rescal
> > >
> > > These are going to need to be an if/then schema if they only apply to
> > > certain compatible(s).
> >
> > Why is that -- the code is general enough to handle its presence or
> > not (it is an optional compatibility)>
>
> Because an if/then schema expresses in a parse-able form what your
> 'description' does in free form text.
>
> Presumably a 'resets' property for !brcm,bcm7216-pcie is invalid, so
> we should check that. The schema shouldn't be just what some driver
> happens to currently allow. Also, it's not a driver's job to validate
> DT, so it shouldn't check any of this.
Got it, will fix.
>
> > > > +  brcm,scb-sizes:
> > > > +    description: (u32, u32) tuple giving the 64bit PCIe memory
> > > > +      viewport size of a memory controller.  There may be up to
> > > > +      three controllers, and each size must be a power of two
> > > > +      with a size greater or equal to the amount of memory the
> > > > +      controller supports.
> > >
> > > This sounds like what dma-ranges should express?
> >
> > There is some overlap but this contains information that is not in the
> > dma-ranges.  Believe me I tried.
>
> I don't understand. If you had 3 dma-ranges entries, you'd have 3
> sizes. Can you expand or show me what you tried?
Here is a simple example: suppose you have two dma-ranges.  This could
be from one of two cases:

- Both dma-ranges are from the same memory controller (the second
range is the "extended" region).
- One dma-range can be from memc0 and the other can be from memc1; the
extensions are not used.

The driver has to determine (a)  how many memory controllers there are
and (b) what the size should be for each of them.  It is impossible to
do this with the case above.

>
> > > If not, we do have 64-bit size if that what you need.
> >
> > IIRC I tried the 64-bit size but the YAML validator did not like it;
> > it wanted numbers like  <0x1122334455667788> while dtc wanted <
> > 0x11223344 0x55667788>.  I gave up trying and switched to u32.
>
> You used the /bits/ annotation for dtc?:
>
> /bits/ 64 <0x1122334455667788>
>
> I also made a recent fix to dt-schema around handling of 64-bit sizes,
> so update if you have problems still.
I didn't try the /bits/ so I'll pursue this.

Thanks,
Jim

>
> Rob
