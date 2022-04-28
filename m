Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8999B51311D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbiD1KSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 06:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiD1KRi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 06:17:38 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288F9A1454;
        Thu, 28 Apr 2022 03:08:35 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F561240004;
        Thu, 28 Apr 2022 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651140514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FVu5gA7Z4WlGAv2Pb4YDkp22KxyYWyPGrSxniKUiP8=;
        b=QhNuHYISF2nJVQmA0NAHP+AC2T8VDQYh5K3ouAUClwhIcMNzx7nUegC5ao1GovDvFzQp73
        2M7KDd7tPNUKOQFwx0jtsycMxYMAzA5RqlwvOuGjriyckMp1HFV2Cu2qbR7ihNRPj/9+MU
        TkNbuAeNqGiPbcPepiQJ/WmphHXpEYb2AL8BHKW5+9qB6xcENwaYOc7SQGG6n4nb4fz6a4
        w2lTonu0Hy19LptRbrfplic07K+UJfxRuSqM0a0uzg0kim/dUrO4S3/pU9VjnrZ4ELortw
        iu4rmSPE99yhIzLRJ2CNGFx4WzDhweMVq10X30Pof1/kOH6OZeEJxLRFaHkyrw==
Date:   Thu, 28 Apr 2022 12:08:30 +0200
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
Message-ID: <20220428120830.7eaa42ec@bootlin.com>
In-Reply-To: <CAMuHMdX_CwsmzOHBi0TVBR7KOSqW0tY5=94betF_B40gkHoYxQ@mail.gmail.com>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
        <20220422120850.769480-7-herve.codina@bootlin.com>
        <CAMuHMdWfbbQ64CipqoVPEOGhE08HYckhyOaeSi+V7ar+F45PMw@mail.gmail.com>
        <CAMuHMdX_CwsmzOHBi0TVBR7KOSqW0tY5=94betF_B40gkHoYxQ@mail.gmail.com>
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
On Thu, 28 Apr 2022 11:50:21 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Herv=C3=A9,
>=20
> On Thu, Apr 28, 2022 at 11:49 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > > --- a/arch/arm/boot/dts/r9a06g032.dtsi
> > > +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> > > @@ -212,6 +212,35 @@ gic: interrupt-controller@44101000 {
> > >                         interrupts =3D
> > >                                 <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) | =
IRQ_TYPE_LEVEL_HIGH)>;
> > >                 };
> > > +
> > > +               pci_usb: pci@40030000 { =20
>=20
> Please preserve sort order (by unit address).

Ok, will be done in v4.

Thanks,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
