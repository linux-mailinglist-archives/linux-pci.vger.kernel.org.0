Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35E652B77D
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiERKE7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiERKE7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 06:04:59 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11A8663E6;
        Wed, 18 May 2022 03:04:56 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6F3FBFF817;
        Wed, 18 May 2022 10:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652868295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7m8azLqYxqw7exPiKwgRaIReLLbq6ltOL8jkRp0nlI=;
        b=nL+GqAVXrAO7B3g8JVROmVVyCKbDKBByNZl/NoWgXswcrfz+/eW1k7H9Obk2ZeASUbEREJ
        0o8xljT9DvNrAzupsqYy+CFEMAz0Ec3LndbkgMGD1IDg0qW8qVMP5pIs0EdXj+jCVc3KFq
        xVTTjXnQH5xmn9xR4TZ/zlUMVty4mGq8DZ5HjaTgLH0sVr0N3bGYNG+aPcop/sdP8SIQzc
        Q8fPXaAvm/+72BBhaua5YhhEjc2C06es7bgGCt1pDfZNsgeqXNLL3x3iyzIJ/uxHpIWAiq
        1KVWtuKbYHpw9H5dcXyeRgTT4mqi0qUAiaIlY6UOIahlLFwAw5kspTSZuizoHw==
Date:   Wed, 18 May 2022 12:03:40 +0200
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
Message-ID: <20220518120340.61e8e11a@fixe.home>
In-Reply-To: <30bb7968-06fb-308c-a5f0-df316dfb240e@gmail.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <20220427094502.456111-2-clement.leger@bootlin.com>
        <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
        <d356acbe-daff-1c66-6511-aab97a171c82@gmail.com>
        <20220517093729.214c33a3@fixe.home>
        <30bb7968-06fb-308c-a5f0-df316dfb240e@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

Le Tue, 17 May 2022 11:03:41 -0400,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> On 5/17/22 02:37, Cl=C3=A9ment L=C3=A9ger wrote:
> > Le Mon, 16 May 2022 23:11:03 -0400,
> > Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :
> >  =20
> >> On 5/3/22 08:45, Rob Herring wrote: =20
> >>> On Wed, Apr 27, 2022 at 11:45:00AM +0200, Cl=C3=A9ment L=C3=A9ger wro=
te:   =20
> >>>> When enabling CONFIG_OF on a platform where of_root is not populated=
 by
> >>>> firmware, we end up without a root node. In order to apply overlays =
and
> >>>> create subnodes of the root node, we need one. This commit creates an
> >>>> empty root node if not present.   =20
> >>>
> >>> The existing unittest essentially does the same thing for running the=
=20
> >>> tests on non-DT systems. It should be modified to use this support=20
> >>> instead. Maybe that's just removing the unittest code that set of_roo=
t.
> >>>
> >>> I expect Frank will have some comments.   =20
> >>
> >> My preference would be for unflatten_and_copy_device_tree() to
> >> use a compiled in FDT that only contains a root node, in the
> >> case that no valid device tree is found (in other words,
> >> "if (!initial_boot_params)". =20
> >=20
> > Ok, so basically, instead of creating the root node manually, you
> > expect a device-tree which contains the following to be builtin the
> > kernel and unflattened if needed:
> >=20
> > / {
> >=20
> > }; =20
>=20
> Yes.  If you agree with this I can create a patch to implement it.  I thi=
nk
> it is useful even stand alone from the rest of the series.

If you want to implement this, feel free to do so, I'll (at least) be
able to test it.

>=20
> >=20
> > Maybe "chosen" and "aliases" nodes should also be provided as empty
> > nodes since the unittest are creating them anyway and the core DT code
> > also uses them. =20
>=20
> No. Unittest does not create both of them (I'm pretty sure, but I'm not
> going to double check).  If I recall correctly, unittest adds a property
> in one of those two nodes, and thus implicitly creates the node if not
> already present.  Unittest does populate internal pointers to those two
> nodes if the nodes are present (otherwise the pointers will have the
> value of null).  There is no need for the nodes to be present if empty.

Acked, makes sense.

Cl=C3=A9ment

>=20
> -Frank
>=20
> >=20
> > Thanks,
> >=20
> > Cl=C3=A9ment
> >  =20
> >>
> >> unflatten_and_copy_device_tree() calls unittest_unflatten_overlay_base=
()
> >> after unflattening the device tree passed into the booting kernel.  Th=
is
> >> step is needed for a specific portion of the unittests.
> >>
> >> I'm still looking at the bigger picture of using overlays for the PCIe
> >> card, so more comments will be coming about that bigger picture.
> >>
> >> -Frank
> >> =20
> >=20
> >  =20
>=20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
