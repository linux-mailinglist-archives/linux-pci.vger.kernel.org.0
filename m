Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E195B67E3
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 08:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiIMGZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiIMGZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 02:25:58 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606EDB2D;
        Mon, 12 Sep 2022 23:25:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1663050340; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=SBbsnTF0mmIk8XctndvQxJ7VHgdEbI/tPfEWU27bVoLBmXEQ1mcZSPkYJkflOKnOs31vXhEUr6i5qZ47HDr8uP6ygj26RFj9jZo7RK04Mse0w28rjApGEcGLQQfGu7hlpeMmsuUg6Euo69QCAWTJSnSckgyErhRfVVFvqfwAhz8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1663050340; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Kt9GG+vFMkvYqRZ8Ba6A24wrF5ruQ3PEeYC0nAL8AF0=; 
        b=fF8yhTQxmD8hswdcA9s4osNiN9x95LSBjBvmQRN3cKktd4Fzi/BvJr7Fw2zD/e/h6ITkJ8loTS3gq5Y12HuwrjYhdYiwTwJIA/pqZ/WBzWsIIT9DuIBwMWZSLuwMK2JkEcijDpPuIRGT+KArpPZz7acfEKYnBKZ4ovaq95tND0g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663050340;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Kt9GG+vFMkvYqRZ8Ba6A24wrF5ruQ3PEeYC0nAL8AF0=;
        b=XIbg26RYbDve31xqcdSLlTLc4fB04ecJeXlXhXk9jUKk++EA8Xc8DKwUGbXnXnww
        Pt37fhHgHsisEl8IDkm8amvQyAUiOjzbiT0xYvo9vfSuXyjWEWbMhG4QdWXTXi71ODx
        2ficgIY0Th29N3LbPZUC/RT/vkWFawX5FMpmS9l0=
Received: from edelgard.icenowy.me (112.94.103.212 [112.94.103.212]) by mx.zohomail.com
        with SMTPS id 1663050338560674.3690213218844; Mon, 12 Sep 2022 23:25:38 -0700 (PDT)
Message-ID: <ebc846c11b22d14805682ded6436a6a0ef9c512a.camel@icenowy.me>
Subject: Re: [PATCH] PCI: fu740: do not use clock name when requesting clock
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Tue, 13 Sep 2022 14:25:33 +0800
In-Reply-To: <752ea700-bdef-25ca-c922-fd79ea34c8af@microchip.com>
References: <20220907054020.745672-1-uwu@icenowy.me>
         <8d7b8514-efe0-d3e3-8458-f4f003f10154@microchip.com>
         <b1a3f887fd037fd18c45ac020c6142cedba58ca7.camel@icenowy.me>
         <752ea700-bdef-25ca-c922-fd79ea34c8af@microchip.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=E5=9C=A8 2022-09-12=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 10:13 +0000=EF=BC=
=8CConor.Dooley@microchip.com=E5=86=99=E9=81=93=EF=BC=9A
> On 12/09/2022 02:38, Icenowy Zheng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > =E5=9C=A8 2022-09-08=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 18:14 +0000=EF=
=BC=8CConor.Dooley@microchip.com=E5=86=99=E9=81=93=EF=BC=9A
> > > On 07/09/2022 06:40, Icenowy Zheng wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless
> > > > you
> > > > know the content is safe
> > > >=20
> > > > The DT binding of FU740 PCIe does not enforce a clock-names
> > > > property,
> > > > and there exist some device tree that has a clock name that
> > > > does not
> > > > stick to the one used by Linux DT (e.g. the one shipped with
> > > > current
> > > > U-Boot mainline).
> > >=20
> > > I recently added the missing enforcement:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/co=
mmit/?h=3Dpci/dt&id=3Db408fad61d34c765c3e01895286332af2d50402a
> >=20
> > Unfortunately binding w/o clock-names enforcement has already
> > entered a
> > stable release (5.19), and the real clock name "pcie_aux" is never
> > enforced before (there's a DT in U-Boot that uses "pcieaux"
> > instead),
> > should this be considered as breakage to stable DT binding?
>=20
> Does anything in U-Boot actually use that clock name? The clock name
> is
> currently being relied on by both Linux and BSD (although BSD does
> have
> a fallback to the U-Boot provided name. There's only one clock so it
> seems fine to me to stop using the name, but the DT in U-Boot should
> be
> fixed so that PCI works IMO.

In fact, none.

But the issue is that the clock name string is never enforced in DT
binding, so at least we may support unnamed clocks as fallback if we
are trying to allow a DT that sticks to previous 5.19 dt-bindings to
work.

>=20
> fwiw:
> >=20
> > Anyway, I had sent out a patch that synchorizes all FU740-related
> > DT
> > files to U-Boot, see [1].
> >=20
> > [1]
> > https://lore.kernel.org/all/20220825081119.1694007-2-uwu@icenowy.me/
>=20
> =C2=A0From that patch, should this be changed too?
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[PRCI_CLK_PCIEAUX] {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[FU740_PRCI_CLK_PCIE_AUX] {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "pcieaux",

This is an internal name of the driver, I think.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.parent_name =3D "",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.ops =3D &sifive_fu740_prci_pcieaux_clk_ops,
>=20
> >=20
> > >=20
> > > Since there's only one clock though, I'd imagine it makes little
> > > to no
> > > real difference if the check here is relaxed.
> > >=20
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > >=20
> > > >=20
> > > > Drop the name in the clock request, instead just pass NULL
> > > > (because
> > > > this device should have only a single clock).
> > > >=20
> > > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > > ---
> > > > =C2=A0 drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
> > > > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
> > > > b/drivers/pci/controller/dwc/pcie-fu740.c
> > > > index 0c90583c078b..edb218a37a4f 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-fu740.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> > > > @@ -315,7 +315,7 @@ static int fu740_pcie_probe(struct
> > > > platform_device *pdev)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, PTR_ERR(afp->pwren=
),
> > > > "unable to get pwren-gpios\n");
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fetch clocks */
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 afp->pcie_aux =3D devm_clk_ge=
t(dev, "pcie_aux");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 afp->pcie_aux =3D devm_clk_ge=
t(dev, NULL);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(afp->pc=
ie_aux))
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, PTR_ERR(afp-
> > > > >pcie_aux),
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pcie_aux clock
> > > > source
> > > > missing or invalid\n");
> > > > --
> > > > 2.37.1
> > > >=20
> > >=20
> >=20
> >=20
>=20


