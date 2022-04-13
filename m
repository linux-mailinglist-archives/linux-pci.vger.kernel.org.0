Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126774FF993
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbiDMPBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 11:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiDMPBe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 11:01:34 -0400
X-Greylist: delayed 105489 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Apr 2022 07:59:12 PDT
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365C764703;
        Wed, 13 Apr 2022 07:59:11 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5685D6000E;
        Wed, 13 Apr 2022 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649861950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g7zAjg3ptZqqrWECXfvJR9zNVfSPbwQ7SWTZx29xlQw=;
        b=lLKO1tiYqkxNFatSDu3YABe8z+IJcYzcMFfiRBJyfwpjfsCMhg4tS0rdi16QpgPGc+zSow
        tzBio5kSuE/21Fu1qtgYez39H6SGGJKYc/21qQZPB4ruSEDotfseb8I+nyVHMewf/eANH8
        3zWc0lmIRpQcOnuqu0kwc1t1xc3vFFp6+jZrSDUKfdYoAMUjZqqB+2f4SFJJQATew93bTg
        +istpAtNWovwKwzWGYyZ5bJRy8y5tUj4k19/agTTQ5aydkY5IZaNq6EEDP1AvXPaXyZhgB
        NZ+w7sd+PYh7nty9BrCSvkFMwidgEE1LnNCJ2RhWg4xubwn1BjSya5gqdJc86Q==
Date:   Wed, 13 Apr 2022 16:59:07 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 3/6] PCI: rcar-gen2: Add R9A06G032 support
Message-ID: <20220413165907.183c39f5@bootlin.com>
In-Reply-To: <75be60ce-d9b2-b9a0-c897-3cc904889db6@omp.ru>
References: <20220412094029.287562-1-herve.codina@bootlin.com>
        <20220412094029.287562-4-herve.codina@bootlin.com>
        <75be60ce-d9b2-b9a0-c897-3cc904889db6@omp.ru>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Sergey,

On Wed, 13 Apr 2022 12:08:01 +0300
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> Hello!
>=20
> On 4/12/22 12:40 PM, Herve Codina wrote:
>=20
> > Add Renesas R9A06G032 SoC support to the Renesas R-Car gen2 PCI
> > bridge driver.
> > The Renesas RZ/N1D (R9A06G032) internal PCI bridge is compatible
> > with the one available in the R-Car Gen2 family.
> >=20
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/pci/controller/pci-rcar-gen2.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/pci/controller/pci-rcar-gen2.c b/drivers/pci/contr=
oller/pci-rcar-gen2.c
> > index 528bc3780e01..586e4785a57f 100644
> > --- a/drivers/pci/controller/pci-rcar-gen2.c
> > +++ b/drivers/pci/controller/pci-rcar-gen2.c
> > @@ -352,6 +352,8 @@ static const struct of_device_id rcar_pci_of_match[=
] =3D {
> >  	{ .compatible =3D "renesas,pci-r8a7791", },
> >  	{ .compatible =3D "renesas,pci-r8a7794", },
> >  	{ .compatible =3D "renesas,pci-rcar-gen2", },
> > +	{ .compatible =3D "renesas,pci-r9a06g032", }, =20
>=20
>    Do we really need this one here? Isn't it covered by the next item?

Yes, this one is not needed.
Miqu=C3=A8l did the same remark too.

I will remove '.compatible =3D "renesas,pci-r9a06g032"' in v2.

Regards,
Herve

>=20
> > +	{ .compatible =3D "renesas,pci-rzn1", },
> >  	{ },
> >  };
> >   =20
>=20
