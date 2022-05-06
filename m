Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9D251D7F7
	for <lists+linux-pci@lfdr.de>; Fri,  6 May 2022 14:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346958AbiEFMjb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 May 2022 08:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392080AbiEFMjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 May 2022 08:39:11 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C48011C1E;
        Fri,  6 May 2022 05:35:24 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 574461C000E;
        Fri,  6 May 2022 12:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651840523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2Bk3mQ20dGxFwnkKyvshpUua/wpum6W/dZbHZ7rm1Y=;
        b=g9gnkmhIb6svEygm5WDSRv6YcrjnfsEQPpH8RsytHfDx0bynTua6C23Cnk+Qa3teGWjU8b
        vc4shpPdG5xxiUh8mTSQNueJ3Iqi6V2/TfITKAk5ligg0xv2CAFTjFx659sM/X5RhVE/Ml
        5122xb2Ph32OvMZNpRTT3rXOm0IqUUbwKqy0IuB+rvWgg/+4bJA3DGAkdnWhVj7rlJkhgx
        XeoEfu/kz4i0FCSAtkLEkcIFgw9X+zXEQO9fnhpeZr/D1YU/sBLwKOFmNxmQKx9lAwwxX+
        F5K5Qd0bi/nWcT10WT97TqyRu958m79YPralpcevRha3m+IYMMkygwUBDzfQpQ==
Date:   Fri, 6 May 2022 14:35:18 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Message-ID: <20220506143518.3ed9765b@bootlin.com>
In-Reply-To: <CAMuHMdVv-qCTyMQzr8ALCP-UmojZe9=NOrExPieJNV2300yzbQ@mail.gmail.com>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
        <20220429134143.628428-4-herve.codina@bootlin.com>
        <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
        <CAMuHMdWN_ni_V+e3QipWH2qKXeNPkEcVpHpb5iBYw1YQSAnCDA@mail.gmail.com>
        <YnA0id1rXlNHNz+N@robh.at.kernel.org>
        <CAMuHMdWktaRAw8Y6TR93_rH8v4mPR2yt3wGqeXeTA2p_Dh--wA@mail.gmail.com>
        <5a89e9bf-1004-500a-75e1-995732629937@linaro.org>
        <CAMuHMdVv-qCTyMQzr8ALCP-UmojZe9=NOrExPieJNV2300yzbQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

On Tue, 3 May 2022 11:37:31 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Krzysztof,
>=20
> On Tue, May 3, 2022 at 11:29 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 03/05/2022 08:51, Geert Uytterhoeven wrote: =20
> > >>>> This should not be a reason why a property is or is not required. =
Either
> > >>>> this is required for device operation or not. If it is required, s=
hould
> > >>>> be in the bindings. Otherwise what are you going to do in the futu=
re?
> > >>>> Add a required property breaking the ABI? =20
> > >>>
> > >>> The problem is that there are no bindings for the reset controller
> > >>> (actually the reset controller feature of the system-controller) ye=
t.
> > >>> Yeah, we can just add #reset-cells =3D <1> to the system-controller
> > >>> device node, but we cannot add the actual resets properties to the
> > >>> consumers, until the actual cell values are defined. =20
> > >>
> > >> Sounds like you should implement providers first. Or just live with =
the
> > >> warning as a reminder to implement the reset provider? =20
> > >
> > > I'd go for the latter. The upstream r9a06g032.dtsi is still under act=
ive
> > > development. Until very recently, the only device supported was the
> > > serial console. =20
> >
> > For clocks we use in such cases fixed-clock placeholders or empty
> > phandles. Maybe something like that would work here as well? =20
>=20
> I don't think that works for resets.
> Besides, the driver doesn't need or use the reset anyway.
>=20

Finally, related to the "resets" property, what should I do ?
 (a) Keep the property as not required an change the commit log
 (b) Set the property as required and live with a warning (Rob's suggestion)

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
