Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A142508B47
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379831AbiDTO6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 10:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbiDTO6T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 10:58:19 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7116B39BA5;
        Wed, 20 Apr 2022 07:55:31 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A175960003;
        Wed, 20 Apr 2022 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1650466529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVgjPq5JZ4rcIJX3ynCVhQsKPdWqJ0HNcrFRR2wNvvk=;
        b=HsoSB+ten91/hASrq8lR1vSpTAxXN6F4pVHyx+SiQjVrYcRbi6BwDOwy9uj1yE20k6A563
        vczW119JS8rBNb7uHViCRzQ43kXst8p8e/hGtAjJoUzURIghd/3cMHWXOA+Q5xsmImOSSV
        UCFMyUsEnX0DhSMGqLHn8NNrWI8Cq/YS1rdTT/cA+OA+ZEGXeYa2MxLBIpPPtxO+Vtlkrw
        AzhmDwgQW5ViWLiIVg0caMR0k6i8FCy2SmZzzrhgKm0rJG5+6rZiZgTKKqOAl3iWmiBDa0
        dislRePaa44xQh7BZGJs9agNWPfww/Q7V0k0jmdzGa9DE7jOg9Ad73KePgu6/Q==
Date:   Wed, 20 Apr 2022 16:55:26 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRz?= =?UTF-8?B?a2k=?= 
        <kw@linux.com>, linux-pci <linux-pci@vger.kernel.org>,
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
Message-ID: <20220420165526.2ee3704d@bootlin.com>
In-Reply-To: <YmAJq+qUF34IvfiZ@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
        <20220414074011.500533-4-herve.codina@bootlin.com>
        <CAMuHMdWZyuNQJhxkhzs5H8+8DFGDS95nvptrO-s9RC4QL5kibA@mail.gmail.com>
        <20220420150759.713fcd02@bootlin.com>
        <YmAJq+qUF34IvfiZ@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob, Geert,

On Wed, 20 Apr 2022 08:24:59 -0500
Rob Herring <robh@kernel.org> wrote:

...
> > Is there a way to have the clocks description depending on the compatib=
le value.
> > I mean something like:
> > --- 8< ---
> > properties:
> >   clocks:
> >     maxItems: 1 =20
>=20
> This would need to cover both cases:
>=20
> minItems: 1
> maxItems: 3
>=20
> >=20
> > if:
> >   properties:
> >     compatible:
> >       contains:
> >         enum:
> >           - renesas,pci-r9a06g032
> >           - renesas,pci-rzn1
> >=20
> > then:
> >   properties:
> >     clocks:
> >       items:
> >         - description: Internal bus clock (AHB) for HOST
> >         - description: Internal bus clock (AHB) Power Management
> >         - description: PCI clock for USB subsystem
> >       minItems: 3
> >       maxItems: 3 =20
>=20
> Don't need minItems or maxItems here. 3 is the default size based on=20
> 'items' length.
>=20
> >=20
> > else:
> >   properties:
> >     items: =20
>=20
> I think you meant for this to be under 'clocks'.
>=20
> >        - description: Device clock
> >     clocks:
> >       minItems: 1
> >       maxItems: 1 =20
>=20
> Just 'maxItems' is enough.
>=20
> > --- 8< ---
> >=20

Thanks to your details and Geert's binding examples,

I have the clocks description and clock-names set depending
on compatible value.

This will be present in v3 series.

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
