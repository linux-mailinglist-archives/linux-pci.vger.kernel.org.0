Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF79513151
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbiD1Kdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiD1Kdm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:33:42 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5444256C31;
        Thu, 28 Apr 2022 03:30:23 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 77031E0011;
        Thu, 28 Apr 2022 10:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651141822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XvY8OOcprZelkc7qvA2buNfCCfNWJDnZiew6EWVnFa0=;
        b=pPcXOa7GQZjUQ1heIeDHrbr8vB4aD8YeZFWhXuiSNZn1klG/R6vUgnyRuQLaPAI9SzjcJF
        YWkbMJDGbIknCDy9Jbvem2KKwH/nyr7hhMghPNwMsCXsRp+3lxPVlKyq+/zJvYJwgYEIJd
        rJlgyPz8tFFYAuFPn7V7UYUgYR1UA6giuBCpvTCHqHZ9kd0Fa0jBBVDxY4yhJKQF2FwHxc
        +7eFMq29GU4A6mzc4qAd8zcOPfGitVvf0n7t52Mvr5HFt+rriH7GScC0WljdyVDdeoWr/G
        SqB9vom0+legpzZc+kL1FOZyFJbebv7rCy8Gn+/+mBWwgIGKL0g5y2qa6G7Cyw==
Date:   Thu, 28 Apr 2022 12:30:18 +0200
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
Subject: Re: [PATCH v3 7/8] ARM: dts: r9a06g032: Add USB PHY DT support
Message-ID: <20220428123018.11cd054f@bootlin.com>
In-Reply-To: <CAMuHMdXYpntR6QpJTRMPtE_RjNq+vwfCVRViXCc8DhNRMMjqJQ@mail.gmail.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
        <20220422120850.769480-8-herve.codina@bootlin.com>
        <CAMuHMdXYpntR6QpJTRMPtE_RjNq+vwfCVRViXCc8DhNRMMjqJQ@mail.gmail.com>
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

Hi Geert,
On Thu, 28 Apr 2022 11:51:44 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Fri, Apr 22, 2022 at 2:09 PM Herve Codina <herve.codina@bootlin.com> w=
rote:
> > Define the r9a06g032 generic part of the USB PHY device node.
> >
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > @@ -59,6 +59,12 @@ ext_rtc_clk: extrtcclk {
> >                 clock-frequency =3D <0>;
> >         };
> >
> > +       usbphy: usbphy { =20
>=20
> Please preserve sort order (by node name).

Ok, will be done.

>=20
> > +               #phy-cells =3D <0>;
> > +               compatible =3D "usb-nop-xceiv";
> > +               status =3D "disabled";
> > +       };
> > +
> >         soc {
> >                 compatible =3D "simple-bus";
> >                 #address-cells =3D <1>; =20
>=20
> The rest LGTM, so with the above fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
