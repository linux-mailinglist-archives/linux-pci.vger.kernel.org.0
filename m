Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7469A5189C4
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 18:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbiECQ10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiECQ1W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 12:27:22 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119F33C48A
        for <linux-pci@vger.kernel.org>; Tue,  3 May 2022 09:23:48 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id BCCF2CD68D
        for <linux-pci@vger.kernel.org>; Tue,  3 May 2022 16:07:22 +0000 (UTC)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 11B8340005;
        Tue,  3 May 2022 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651594036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xthf4C7ur9zN4o/9f3kzfNM7G/i4L2TMAmLJ5bF8nnI=;
        b=PqfIbDa8O9C9Mq6unBJ/Ed+fd0gBO/cMham8ZD5lCisKxFdiERR8HF1CDaaHqFU76oYATY
        0manVcHlIdzbQRoJzyoV+HZwmuJaj6selVkqYbEXDAxPqf0I5irS+d9Eab65Ah3AyJYP8e
        8Fn7aDuieDU1zsRb8eRC0XK9T6GOn00MUZHE1T1RZCfnP1l71dwy9K+k0zZ4xrJgrAV/jN
        DPZo/LrlGC3z/Qh22NVtPPnH2MVyOcxvvO8MHO8Y3DqRKxI2i8CbXXb7s28go/rgcKmc5x
        nv4eTTqLZw1RuBQ0AJgr4LQ26mo5Ss+kR6RxbVxCeZMBm420yVBX0hBD1F/aWg==
Date:   Tue, 3 May 2022 18:05:58 +0200
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
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
Subject: Re: [PATCH 2/3] PCI: of: create DT nodes for PCI devices if they do
 not exists
Message-ID: <20220503180558.0ec2fd56@fixe.home>
In-Reply-To: <YnE4Ni+QUJT/CXV4@robh.at.kernel.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <20220427094502.456111-3-clement.leger@bootlin.com>
        <YnE4Ni+QUJT/CXV4@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Tue, 3 May 2022 09:12:06 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> On Wed, Apr 27, 2022 at 11:45:01AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > In order to apply overlays to PCI device nodes, the nodes must first
> > exist. This commit add support to populate a skeleton tree for PCI bus
> > and devices. These nodes can then be used by drivers to apply overlays.
> >  =20
>=20
> While I implemented this creating the nodes as the PCI devices are=20
> created, I think probably we're going to want to create the device node=20
> and any needed parent nodes on demand. Otherwise, just turning on=20
> CONFIG_OF could break platforms.

Ok, so this creation would potentially be done on request from some PCI
driver that want to apply it's overlay on the tree. Should I actually
add some function such as of_pci_apply_overlay() which would create the
PCI node tree if not present and apply the overlay to the of_node that
is associated to the PCIe device ?

>=20
> One potential issue is that fwnode assumes there is either a DT node or=20
> ACPI node. With this, we have the potential for both. I'm not sure how=20
> much that's going to be an issue.

Not sure either but that's better not to play with that.

>=20
> > Co-developed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >  drivers/pci/of.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 184 insertions(+)
> >=20
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index cb2e8351c2cc..f2325708726e 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -16,12 +16,194 @@
> >  #include "pci.h"
> > =20
> >  #ifdef CONFIG_PCI
> > +static int of_pci_add_property(struct of_changeset *ocs, struct device=
_node *np,
> > +			       const char *name, const void *value, int length) =20
>=20
> Nothing really PCI specific about this function.
>=20
> The kernel support for creating nodes and properties is pretty poor. We=20
> should improve it with functions like this (in drivers/of/). Maybe the=20
> changeset part should be separate though. We have some cases of creating=
=20
> properties or nodes already, and whatever new APIs we make those=20
> cases should be able to use them. And if they are converted, then it can=
=20
> be merged sooner rather than when all the PCI parts are ready.

Ok, so this will be done as a first separate series to add property
creation then.

> > +
> > +static int of_pci_add_cells_props(struct device_node *node,
> > +				  struct of_changeset *cs, int n_addr_cells,
> > +				  int n_size_cells)
> > +{
> > +	__be32 val;
> > +	int ret;
> > +
> > +	ret =3D of_pci_add_property(cs, node, "ranges", NULL, 0); =20
>=20
> The host bridge node is going to need to fill in 'ranges'. Empty ranges=20
> is not valid when there's a change in number of cells.

Ok, wasn't aware of that. If I understand, I'll need to obtain the
range of PCI addresses that are behind the bridge to fill in this
ranges property right ?

>=20
> The root node also will need "#address-cells" and "#size-cells".
> =20

Ok.


--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
