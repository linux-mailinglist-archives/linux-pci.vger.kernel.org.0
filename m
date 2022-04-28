Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4153512FCC
	for <lists+linux-pci@lfdr.de>; Thu, 28 Apr 2022 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiD1Jtu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Apr 2022 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbiD1J00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2022 05:26:26 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2B77B548;
        Thu, 28 Apr 2022 02:23:09 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9A08BE000F;
        Thu, 28 Apr 2022 09:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651137787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FYRz/NDTDdoqmZUrm0uByCiRUWY9guhdRNlt4HmCM0=;
        b=mJOuZ1T9tUD92MO7DKvtNI5dLapxlMOfwd7x4IIOEHvO1p2pSSEfgESCe1miSaBT1AgaMJ
        5CsfIP5a+s3RTPwOw2+O+S5UiQxtIzAMf86SF1I/TFrEVBHzqrH1WKOi85bPLE86lBFoxE
        jbWa112E+vXYK9vbmptM/yRaFcw6MjONxHK4d/AvH0CTKpvTVPBSo1+2qc91CSfQwgZaT7
        qc8R0IvfKv6PFFUwaS6UdHsLKATrELdCMNdtEeZR6+aUgM4OGcdgWUhTcIcMi+rI7LlhET
        RjssszI3MTwi14aQ1drKj44O76GFOB8+ukLaYATaEmRHMuEaFSbr2D/vVvah1g==
Date:   Thu, 28 Apr 2022 11:23:02 +0200
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
Subject: Re: [PATCH v3 7/8] ARM: dts: r9a06g032: Add USB PHY DT support
Message-ID: <20220428112302.3e8d3a7f@bootlin.com>
In-Reply-To: <f7e76000-11ec-42d1-5767-7f270a3b025d@omp.ru>
References: <20220422120850.769480-1-herve.codina@bootlin.com>
        <20220422120850.769480-8-herve.codina@bootlin.com>
        <ed432ba2-6081-4d82-bdc9-cd88cb52ca1f@omp.ru>
        <f7e76000-11ec-42d1-5767-7f270a3b025d@omp.ru>
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

Hi Sergey,

On Sat, 23 Apr 2022 19:41:09 +0300
Sergey Shtylyov <s.shtylyov@omp.ru> wrote:

> On 4/23/22 12:09 PM, Sergey Shtylyov wrote:
>=20
> [...]
> >> Define the r9a06g032 generic part of the USB PHY device node.
> >>
> >> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >> ---
> >>  arch/arm/boot/dts/r9a06g032.dtsi | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/r9a06g032.dtsi b/arch/arm/boot/dts/r9a0=
6g032.dtsi
> >> index 33581f0c55c4..58af07eb75c9 100644
> >> --- a/arch/arm/boot/dts/r9a06g032.dtsi
> >> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> >> @@ -59,6 +59,12 @@ ext_rtc_clk: extrtcclk {
> >>  		clock-frequency =3D <0>;
> >>  	};
> >> =20
> >> +	usbphy: usbphy { =20
> >=20
> >    I think the node name should be "usb-phy"... =20
>=20
>    It's not my thinking alone, the DT spec documents "usb-phy" in section=
 2.2.2. :-)

Will be changed in v4.

Thanks for pointing this.

Regards,
Herv=C3=A9

--=20
Herv=C3=A9 Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
