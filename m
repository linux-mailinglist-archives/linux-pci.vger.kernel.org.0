Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD24F529B1C
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 09:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiEQHkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242507AbiEQHkF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 03:40:05 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2D4B1D9;
        Tue, 17 May 2022 00:38:42 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B45F920002;
        Tue, 17 May 2022 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652773121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGUPuIBqdoAwF6CrSgCGhpb2rO2ZYTzLfr84zCXtbUA=;
        b=ovXm/FsHnSnly3cug8E/YvUa+9uFuM/kadH6jEa5sy7xnlB4fzjbw0lWqNydOR96WeNOSc
        YaTpt0thgcY2ZVX5qZuyXZ/sOpC5fGAZqGO0Vj/vvIWmxu+k16Koe4sq/V87m5dTWIQvfD
        ejw3EQX4is5LVegbHsgC7yry9tluxAcJjwaKllYLWRYUiQEm0StXG+Z4O6Hagv6tiqSBro
        erZMqa2a6696y6yUJZ8BO4yw2buJrYO9C6I17kjrCdmJHPHeUypAE48cnhCA+gqMMS1vkz
        BMemUOTmiNwe8reMRoEhGECPonU6/WR5ilgDapGdwj1aPnDsaUFqZrgQHbKv0Q==
Date:   Tue, 17 May 2022 09:37:29 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH 1/3] of: always populate a root node
Message-ID: <20220517093729.214c33a3@fixe.home>
In-Reply-To: <d356acbe-daff-1c66-6511-aab97a171c82@gmail.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <20220427094502.456111-2-clement.leger@bootlin.com>
        <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
        <d356acbe-daff-1c66-6511-aab97a171c82@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

Le Mon, 16 May 2022 23:11:03 -0400,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 5/3/22 08:45, Rob Herring wrote:
> > On Wed, Apr 27, 2022 at 11:45:00AM +0200, Cl=C3=A9ment L=C3=A9ger wrote=
: =20
> >> When enabling CONFIG_OF on a platform where of_root is not populated by
> >> firmware, we end up without a root node. In order to apply overlays and
> >> create subnodes of the root node, we need one. This commit creates an
> >> empty root node if not present. =20
> >=20
> > The existing unittest essentially does the same thing for running the=20
> > tests on non-DT systems. It should be modified to use this support=20
> > instead. Maybe that's just removing the unittest code that set of_root.
> >=20
> > I expect Frank will have some comments. =20
>=20
> My preference would be for unflatten_and_copy_device_tree() to
> use a compiled in FDT that only contains a root node, in the
> case that no valid device tree is found (in other words,
> "if (!initial_boot_params)".

Ok, so basically, instead of creating the root node manually, you
expect a device-tree which contains the following to be builtin the
kernel and unflattened if needed:

/ {

};

Maybe "chosen" and "aliases" nodes should also be provided as empty
nodes since the unittest are creating them anyway and the core DT code
also uses them.

Thanks,

Cl=C3=A9ment

>=20
> unflatten_and_copy_device_tree() calls unittest_unflatten_overlay_base()
> after unflattening the device tree passed into the booting kernel.  This
> step is needed for a specific portion of the unittests.
>=20
> I'm still looking at the bigger picture of using overlays for the PCIe
> card, so more comments will be coming about that bigger picture.
>=20
> -Frank
>=20


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
