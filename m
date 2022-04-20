Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9835088E8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbiDTNK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiDTNK5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:10:57 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0831A3A7;
        Wed, 20 Apr 2022 06:08:03 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 310E94000E;
        Wed, 20 Apr 2022 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650460081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yuk0DkDPEInPbO2/7/mEfOaFgM8OSF6LY257uIAIVYU=;
        b=gVZD0Yq66dGtbd3tNLTW39EtL5QZSEA+tJfDOou3z24FIgHn7EWKkxiriGZLXKFlhJabzM
        LYKitguMS9+J49ShBJNH4gDXPKjmRJ5e41XKskhTGH0hoDuZnWF9swiLtyZTVKj8IQKv1H
        0EWXxgla8Mrm/dHHaXQ70G65oCcNjSA3KFJLiH7jyAERAK8v1tnuHvEtL6Wyjv2X8PFVsy
        cQi88TkKlaTwTVHcot5kG/ti3/jJ2VvSB+j9BSKocIL43fubwY48Pn/WIhh2KS62dYpHNY
        zowk7iRgXtsIOv8ENuZm3bvAA4Y3tkJ3AvCh9gKD9u6fIh2AGxAR7zHFfnF9dw==
Date:   Wed, 20 Apr 2022 15:07:59 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 3/8] dt-bindings: PCI: renesas-pci-usb: Allow
 multiple clocks
Message-ID: <20220420150759.713fcd02@bootlin.com>
In-Reply-To: <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-4-herve.codina@bootlin.com>
        <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Geert, Rob,

On Thu, 14 Apr 2022 10:35:07 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > Define that multiple clocks can be present at clocks property.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > @@ -54,7 +54,8 @@ properties:
> >        Standard property that helps to define the interrupt mapping.
> >
> >    clocks:
> > -    description: The reference to the device clock.
> > +    description:
> > +      The references to the device clocks (several clocks can be refer=
enced). =20
>=20
> Please describe the clocks, and add the missing "clock-names" property.
>=20
> >
> >    bus-range:
> >      description: | =20
>=20
> I think it would be better to combine this with [PATCH v2 4/8], as the
> additional clocks are only present on RZ/N1.
>=20
> Then you can easily add json-schema logic to enforce the correct
> number of clocks, depending on the compatible value.

Sure.

Is there a way to have the clocks description depending on the compatible v=
alue.
I mean something like:
--- 8< ---
properties:
  clocks:
    maxItems: 1

if:
  properties:
    compatible:
      contains:
        enum:
          - renesas,pci-r9a06g032
          - renesas,pci-rzn1

then:
  properties:
    clocks:
      items:
        - description: Internal bus clock (AHB) for HOST
        - description: Internal bus clock (AHB) Power Management
        - description: PCI clock for USB subsystem
      minItems: 3
      maxItems: 3

else:
  properties:
    items:
       - description: Device clock
    clocks:
      minItems: 1
      maxItems: 1
--- 8< ---

In fact, I would like to describe the 3 clocks only for the r9a06g032 SOC
and the rzn1 family and have an other description for the other 'compatible=
'.

I cannot succeed to do it.

The only thing I can do is to leave the description of the 3 clocks out of =
the
conditional part. This leads to :

--- 8< ---
properties:
  clocks:
    items:
      - description: Internal bus clock (AHB) for HOST
      - description: Internal bus clock (AHB) Power Management
      - description: PCI clock for USB subsystem
    minItems: 1

if:
  properties:
    compatible:
      contains:
        enum:
          - renesas,pci-r9a06g032
          - renesas,pci-rzn1

then:
  properties:
    clocks:
      minItems: 3
      maxItems: 3

else:
  properties:
    clocks:
      minItems: 1
      maxItems: 1
--- 8< ---

Also the clock-names items can be different depending on the
compatible value.

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
