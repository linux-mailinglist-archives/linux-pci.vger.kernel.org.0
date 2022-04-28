Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7109151310E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiD1KRQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 06:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbiD1KQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:16:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9AF2125E;
        Thu, 28 Apr 2022 03:07:52 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E5901E0002;
        Thu, 28 Apr 2022 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651140471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p0pbW3Qe/fcOPwkZ542X36a6CjEmTTKa8MqcLRRPmgg=;
        b=BTdo1ob7J24vsgk6I9B0sOpiH7EbVXJiU6W5zbSoMATqriqZIbKOQM5koHbpT7USP7/syO
        qxt8JA4NPKMNM/piiYw9v+sJnu9ulhBwtSJWKE1K2TvMGHSanied5YtYwB/g6FDA8kG1qm
        4UCrHysak4lqYJRdP7G0TgpujxEM80ykSHg7UvailxyMoVqcjxC/66ku+RMYnZ1cYgZOjg
        e0+ZwBNsky/h+aRcsx+3Hrw7Kfzzi7LKYJdiG///FaWnF79goV8uf3dqbAJxd5y24nmSFS
        WT5a2pSVWv5Mx72ceml+RQ+8jkYSSh125304egivnCt7VB6URIOtbp6iB55p1w==
Date:   Thu, 28 Apr 2022 12:07:48 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Subject: Re: [PATCH v3 6/8] ARM: dts: r9a06g032: Add internal PCI bridge
 node
Message-ID: <20220428120748.69fdc087@bootlin.com>
In-Reply-To: <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
        <20220422120850.769480-7-herve.codina@bootlin.com>
        <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
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

Hi Geert,
On Thu, 28 Apr 2022 11:49:28 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9
>=20
> On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > Add the device node for the r9a06g032 internal PCI bridge device.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -212,6 +212,35 @@ gic: interrupt-controller@44101000 {
> >                         interrupts =3D
> >                                 <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | IR=
Q_TYPE_LEVEL_HIGH)>;
> >                 };
> > +
> > +               pci_usb: pci@40030000 {
> > +                       compatible =3D "renesas,pci-r9a06g032", "renesa=
s,pci-rzn1";
> > +                       device_type =3D "pci";
> > +                       clocks =3D <&sysctrl R9A06G032_HCLK_USBH>,
> > +                                <&sysctrl R9A06G032_HCLK_USBPM>,
> > +                                <&sysctrl R9A06G032_CLK_PCI_USB>;
> > +                       clock-names =3D "hclk_usbh", "hclk_usbpm", "clk=
_pci_usb"; =20
>=20
> The clock names need an update, cfr. my comment on the bindings.

Sure.

>=20
> The rest LGTM, so with the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20

Thanks for the review.

Regards,
Herv=C3=A9
--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
