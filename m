Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DAD520EA4
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 09:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiEJHih (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 03:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiEJHYm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 03:24:42 -0400
X-Greylist: delayed 54674 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 May 2022 00:20:42 PDT
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B043F114B;
        Tue, 10 May 2022 00:20:41 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D47EC200006;
        Tue, 10 May 2022 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652167240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjBiSLomRv6igpU/Mg7hyx/ooaQxfzOs4t2cLH5GZqQ=;
        b=GZD+MUXvtDVmMeq9rB9ZWTd8LjsAooTVD8g2VaUvTXAtdU9p1bTGy9pLj7kaBuNkC4zC8O
        DcmPNlqqrJNEamDk19Mk++jhe0I+GvOM7QssuBd9z5OlJag/a8Phf0E2hfx2QZ5XE9MHrf
        LTGkccHPkYj9Ke/HNMl+UdP+alY5h17cd4GPjJbuc0EkbIqhxYyC3A6voiJsvSV6lpDILH
        jqLOq0ZRSJz++ooNH4aYGPTCETp9qA2BUzAib6hUCd/L5Sbmdfn7EhErjrFLatHH6kaLDK
        CXScBTWv690FfMbnUNZVdqOiCJ1GMZ81GziK5+KDeNVCEmBpiGc2ndCK/B+COQ==
Date:   Tue, 10 May 2022 09:20:35 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazonni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/3] add dynamic PCI device of_node creation for overlay
Message-ID: <20220510092035.79164930@xps-bootlin>
In-Reply-To: <e6828dce-3e10-779e-4d12-67e7bdfd0f73@gmail.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
        <20220509141634.16158c38@xps-bootlin>
        <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
        <20220509180917.0f0ae851@xps-bootlin>
        <e6828dce-3e10-779e-4d12-67e7bdfd0f73@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Mon, 9 May 2022 15:07:18 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> > Ok, that is actually possible on a system that is given a
> > device-tree by the bootloader. But on a system that is desrcibed
> > using ACPI (such as the x86), this is much more difficult (at least
> > to my knowledge)... We want this feature to be easy to use for the
> > end user. Adding such configuration which also differs between
> > various architecture is clearly not so easy to setup. =20
>=20
> Are you trying to make your card work on any ACPI based system (x86,
> x86-64, etc)?  Or do you have a specific model of computer that you
> want to make this work on for a specific customer or appliance?

There is no particular appliance/architecture targeted. This card should
work with any system that can support PCIe.

>=20
> If for many arbitrary systems, can you limit it to one architecture
> or sub-architecture?

Previous answer does rule out this one.

>=20
> >=20
> > Moreover, since the PCI is meant to be "Plug and Play", such
> > configuration would completely break that. If the user switches the
> > PCIe card from one slot to another, the bootloader configuration
> > will need to be modified. This seems a big no way for me (and for
> > the user). =20
>=20
> Yes.  I was envisioning the pre-bootloader, bootloader, or Linux
> pre-boot shim dynamically determining the slot containing the card,
> and applying the overlay devicetree to the base devicetree,
> retargeting the overlay to the proper location, before the Linux boot.

Ok, this is however not doable on many already existing platforms since
it would require to adapt this system for whatever bootloader is
present on the platform. Moreover, AFAIK some platforms bootchain (x86)
are hardly modifiable.

>=20
> The base devicetree would be for a specific type of machine or family
> of machines, just as is the case for all devicetree based systems.
>=20
> >  =20
> >>
> >> The other big issue is mixing ACPI and devicetree on a single
> >> system. Historically, the Linux devicetree community has not been
> >> receptive to the ides of that mixture.  Your example might be a
> >> specific case where the two can be isolated from each other, or
> >> maybe not.  (For disclosure, I am essentially ACPI ignorant.)  I
> >> suspect that mixing ACPI and devicetree is a recipe for disaster
> >> in the general case. =20
> >=20
> > Agreed, on that fact, it did raised some eyebrows, and it was for
> > that specific concern that initially, I proposed the fwnode
> > solution. Honestly, the fwnode conversion represent a lot of work
> > (hundreds of lines easily) + requires a conversion of all the
> > subsystem that are not fwnode ready (spoiler: almost all of them
> > are not ready).=20
> >=20
> > After implementing Rob's solution, the device-tree overlay really
> > seems the cleaner to me and requires much less modifications.
> >  =20
> >>
> >> More to come later as I finish reading through the various
> >> threads. =20
> >=20
> > Ok, thanks for your time ! =20
>=20
> Your welcome.  I'll keep looking deeper into the previous threads.
>=20
> -Frank
>=20
> >=20
> > Cl=C3=A9ment
> >  =20
> >>
> >> -Frank =20
> >=20
> > . =20
>=20

