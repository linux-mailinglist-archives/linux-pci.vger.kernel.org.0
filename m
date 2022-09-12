Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AED5B528B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 03:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiILBix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 21:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiILBiw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 21:38:52 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDF82717A;
        Sun, 11 Sep 2022 18:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662946715; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nmoULEJNVVyhcxfPz0c930xHqEoELXOWTgTMys221E+FNMQa501Y9cpnRq+f+5Gr+7wgE2wmRMpcDCnLCKbMmXo5N1826h0A61qjiC92cRA9HEWdiN2ZKd9pOQUeAbK5tUgDmfI0H8w3HPkHZHCKZs5VBT21Ih8cCEf8qjfCm1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1662946715; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=gITTsAelrgqAVvbvWxgmltU1PS5HhOC1zITbPK6fu0g=; 
        b=JSUDmJ8wL402368k3QCl7Lh5Q8iPxwJa+Tp7MJYCuhLe2qLXYvLXo3b4ORgnhbqxFYQrXaow0ppaxbAXwnwex+2IZGPqPuHltNelqtoqvVcxSAkIWOHI7XBkNuktBeM4iaSy98m+4pcEBMcieQicWqds/if57HOpV7RzcRl5060=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662946715;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=gITTsAelrgqAVvbvWxgmltU1PS5HhOC1zITbPK6fu0g=;
        b=Yke6a9TpB426+bzCB66za6yzYg0z/1k5luMmdoH2GxZkItv5RSdjc7qi5CDTIPHu
        3ELKnGqi/Ai9c3nL8LE5x0Q++vVtrTOd0gTW6YWZpzehkUIPx0Ih+z/G5sEFiD+YnTM
        ASkcB9jOo8JOu6IPZjai/gXwAu7Em+yNYccHeiQQ=
Received: from edelgard.icenowy.me (112.94.103.212 [112.94.103.212]) by mx.zohomail.com
        with SMTPS id 1662946713737839.7941793140751; Sun, 11 Sep 2022 18:38:33 -0700 (PDT)
Message-ID: <b1a3f887fd037fd18c45ac020c6142cedba58ca7.camel@icenowy.me>
Subject: Re: [PATCH] PCI: fu740: do not use clock name when requesting clock
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        greentime.hu@sifive.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Mon, 12 Sep 2022 09:38:28 +0800
In-Reply-To: <8d7b8514-efe0-d3e3-8458-f4f003f10154@microchip.com>
References: <20220907054020.745672-1-uwu@icenowy.me>
         <8d7b8514-efe0-d3e3-8458-f4f003f10154@microchip.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=E5=9C=A8 2022-09-08=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 18:14 +0000=EF=BC=
=8CConor.Dooley@microchip.com=E5=86=99=E9=81=93=EF=BC=9A
> On 07/09/2022 06:40, Icenowy Zheng wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >=20
> > The DT binding of FU740 PCIe does not enforce a clock-names property,
> > and there exist some device tree that has a clock name that does not
> > stick to the one used by Linux DT (e.g. the one shipped with current
> > U-Boot mainline).
>=20
> I recently added the missing enforcement:
> https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit=
/?h=3Dpci/dt&id=3Db408fad61d34c765c3e01895286332af2d50402a

Unfortunately binding w/o clock-names enforcement has already entered a
stable release (5.19), and the real clock name "pcie_aux" is never
enforced before (there's a DT in U-Boot that uses "pcieaux" instead),
should this be considered as breakage to stable DT binding?

Anyway, I had sent out a patch that synchorizes all FU740-related DT
files to U-Boot, see [1].

[1]
https://lore.kernel.org/all/20220825081119.1694007-2-uwu@icenowy.me/

>=20
> Since there's only one clock though, I'd imagine it makes little to no
> real difference if the check here is relaxed.
>=20
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> >=20
> > Drop the name in the clock request, instead just pass NULL (because
> > this device should have only a single clock).
> >=20
> > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > ---
> > =C2=A0drivers/pci/controller/dwc/pcie-fu740.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/controller/dwc/pcie-fu740.c
> > b/drivers/pci/controller/dwc/pcie-fu740.c
> > index 0c90583c078b..edb218a37a4f 100644
> > --- a/drivers/pci/controller/dwc/pcie-fu740.c
> > +++ b/drivers/pci/controller/dwc/pcie-fu740.c
> > @@ -315,7 +315,7 @@ static int fu740_pcie_probe(struct
> > platform_device *pdev)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, PTR_ERR(afp->pwren),
> > "unable to get pwren-gpios\n");
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Fetch clocks */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 afp->pcie_aux =3D devm_clk_get(de=
v, "pcie_aux");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 afp->pcie_aux =3D devm_clk_get(de=
v, NULL);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(afp->pcie_aux))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return dev_err_probe(dev, PTR_ERR(afp->pcie_aux),
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "pcie_aux clock source
> > missing or invalid\n");
> > --
> > 2.37.1
> >=20
>=20


