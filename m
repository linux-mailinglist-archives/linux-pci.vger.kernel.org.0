Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301A85201FD
	for <lists+linux-pci@lfdr.de>; Mon,  9 May 2022 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238958AbiEIQN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 May 2022 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238893AbiEIQN0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2022 12:13:26 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045B627B30B;
        Mon,  9 May 2022 09:09:29 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 629021BF203;
        Mon,  9 May 2022 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652112566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7GSStgwKryZEOP1Jjq0CJbbm9/kTv+zC1i/HUwHXXA=;
        b=Q3qHIfx01n4Z6VYb2ZeeD61UZj+SKoqZj/bmrMCXYMZbH02VhkUroQXvu6VEtLpX0el+ZZ
        /M1Hf1oLfxfe9fgJlQvh4HxcXjJu100FCXHWOl2cVEj4LLGy+jgjGjjt/k5WK/m/aTgf1t
        uTA5lv+FV/06uzWOikWHCPlpmAZULsl0Am9b8duDWm7Qhryo6xVgA+oCa3GVjKvQdHp27F
        tllENT/8s1aW+B5NzJU8CJ1BM9bDXHczllL5wztlYqAgSkzLVcIgFvk/OnaLxKYoYckZsp
        YQ3jgjHOjS9ZoR7jbWY+A/YAYi7zrnVVxqwwJF+Qq+1kkzVWdcpvwlsDDPZvVg==
Date:   Mon, 9 May 2022 18:09:17 +0200
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
Message-ID: <20220509180917.0f0ae851@xps-bootlin>
In-Reply-To: <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <96db62bb-18be-f44a-6f53-05b22319f23a@gmail.com>
        <20220509141634.16158c38@xps-bootlin>
        <f9b0cbf1-dde2-ff97-cca0-5d2895734f91@gmail.com>
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

Le Mon, 9 May 2022 10:56:36 -0500,
Frank Rowand <frowand.list@gmail.com> a =C3=A9crit :

> > Hi Frank,
> >=20
> > This work uses the kernel space interface (of_overlay_fdt_apply())
> > and the device tree overlay is builtin the driver. This interface
> > was used until recently by rcu-dcar driver. While the only user
> > (sic), this seems to work pretty well and I was able to use it
> > successfully. =20
>=20
> Yes, of_overlay_fdt_apply() was used by one driver.  But that driver
> was explicitly recognized as a grandfathered exception, and not an
> example for other users.  It was finally removed in 5.18-rc1.

I noticed that unfortunately.

>=20
> You may have used of_overlay_fdt_apply() in a specific use case at
> a specific kernel version, but if you read through the references
> I provided you will find that applying overlays after the kernel
> boots is a fragile endeavor, with expectations of bugs and problems
> being exposed as usage is changed (simple example is that my adding
> some overlay notifier unittests exposed yet another memory leak).
>=20
> The reference that I provided also shows how the overlay code is
> being improved over time.  Even with improvements, it will remain
> fragile.

Acked.

>=20
> >=20
> > Moreover, this support targets at using this with PCI devices. This
> > devices are really well contained and do not interfere with other
> > devices. This actually consists in adding a complete subtree into
> > the existing device-tree and thus it limits the interactions between
> > potentially platform provided devices and PCI ones. =20
>=20
> Yes, that it is very important that you have described this fact, both
> here and in other emails.  Thank you for that information, it does
> help understanding the alternatives.
>=20
> I've hesitated in recommending a specific solution before better
> understanding the architecture of your pcie board and drivers, but
> I've delayed too long, so I am going to go ahead and mention one
> possibility at the risk of not yet fully understanding the situation.
>=20
> On the surface, it appears that your need might be well met by having
> a base devicetree that describes all of the pcie nodes, but with each
> node having a status of "disabled" so that they will not be used.
> Have a devicetree overlay describing the pcie card (as you proposed),
> where the overlay also includes a status of "ok" for the pcie node.
> Applying the overlay, with a method of redirecting the target to a
> specific pcie node would change the status of the pcie node to enable
> its use.  (You have already proposed a patch to modify
> of_overlay_fdt_apply() to allow a modified target, so not a new
> concept from me.)  My suggestion is to apply the overlay devicetree
> to the base devicetree before the combined FDT devicetree is passed
> to the kernel at boot.  The overlay apply could be done by several
> different entities.  It could be before the bootloader executes, it
> could be done by the bootloader, it could be done by a shim between
> the bootloader and the kernel.  This method avoids all of the issues
> of applying an overlay to a running system that I find problematic.
> It is also a method used by the U-boot bootloader, as an example.

Ok, that is actually possible on a system that is given a device-tree
by the bootloader. But on a system that is desrcibed using ACPI (such
as the x86), this is much more difficult (at least to my knowledge)...
We want this feature to be easy to use for the end user. Adding such
configuration which also differs between various architecture is
clearly not so easy to setup.

Moreover, since the PCI is meant to be "Plug and Play", such
configuration would completely break that. If the user switches the
PCIe card from one slot to another, the bootloader configuration will
need to be modified. This seems a big no way for me (and for the user).

>=20
> The other big issue is mixing ACPI and devicetree on a single system.
> Historically, the Linux devicetree community has not been receptive
> to the ides of that mixture.  Your example might be a specific case
> where the two can be isolated from each other, or maybe not.  (For
> disclosure, I am essentially ACPI ignorant.)  I suspect that mixing
> ACPI and devicetree is a recipe for disaster in the general case.

Agreed, on that fact, it did raised some eyebrows, and it was for that
specific concern that initially, I proposed the fwnode solution.
Honestly, the fwnode conversion represent a lot of work (hundreds of
lines easily) + requires a conversion of all the subsystem that are not
fwnode ready (spoiler: almost all of them are not ready).=20

After implementing Rob's solution, the device-tree overlay really seems
the cleaner to me and requires much less modifications.

>=20
> More to come later as I finish reading through the various threads.

Ok, thanks for your time !

Cl=C3=A9ment

>=20
> -Frank

