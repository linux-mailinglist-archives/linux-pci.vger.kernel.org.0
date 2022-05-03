Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AC5188D3
	for <lists+linux-pci@lfdr.de>; Tue,  3 May 2022 17:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238671AbiECPn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 May 2022 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238668AbiECPn1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 May 2022 11:43:27 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF0730F53
        for <linux-pci@vger.kernel.org>; Tue,  3 May 2022 08:39:53 -0700 (PDT)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1D34F240006;
        Tue,  3 May 2022 15:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1651592387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xz1Onj7oTzb7D6aAvbG4r11OnN521cFiAkj6GER4WiE=;
        b=LxgLUU7r+6dNTNlLCt/mvNOBNzYV0wZpnTA5aEZnxmn43lh7u2e2fy0yGqmGJSTwCK0kGU
        TBszHcN6rHiu9l9LY2Loq7WXRWU50xR6XgdXPtZlZV22kJajQFKE0rXSHoAHnxUUrAt/Sx
        AMNemus8fnSqLQfRaZCtT4ZahNNyIaDq3944Pyhx0Ps9/4vgg/w8IXbWkZJsAqt2dt+Bb+
        bEJnv41x2928cW9SrKenfh32Yvw32Wy66wQY/31QIBJiBGUdlEirVXcXePGvleupp0tcN5
        uOcWXCbNQc50Kjh5yy3X1/8MkeIWNT7Nwukih1ocMlyqSBTJe6IO4w1CWr0uww==
Date:   Tue, 3 May 2022 17:38:29 +0200
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
Subject: Re: [PATCH 1/3] of: always populate a root node
Message-ID: <20220503173829.7ef7418d@fixe.home>
In-Reply-To: <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
References: <20220427094502.456111-1-clement.leger@bootlin.com>
        <20220427094502.456111-2-clement.leger@bootlin.com>
        <YnEx5/ni1ddIFCj9@robh.at.kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Tue, 3 May 2022 08:45:11 -0500,
Rob Herring <robh@kernel.org> a =C3=A9crit :

> On Wed, Apr 27, 2022 at 11:45:00AM +0200, Cl=C3=A9ment L=C3=A9ger wrote:
> > When enabling CONFIG_OF on a platform where of_root is not populated by
> > firmware, we end up without a root node. In order to apply overlays and
> > create subnodes of the root node, we need one. This commit creates an
> > empty root node if not present. =20
>=20
> The existing unittest essentially does the same thing for running the=20
> tests on non-DT systems. It should be modified to use this support=20
> instead. Maybe that's just removing the unittest code that set of_root.

Acked, I'll try the unit test on my system.

>=20
> I expect Frank will have some comments.
>=20
> > Co-developed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> > ---
> >  drivers/of/base.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/of/base.c b/drivers/of/base.c
> > index e7d92b67cb8a..6b8584c39f73 100644
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
> > @@ -177,6 +177,19 @@ void __init of_core_init(void)
> >  		pr_err("failed to register existing nodes\n");
> >  		return;
> >  	}
> > +
> > +	if (!of_root) {
> > +		of_root =3D kzalloc(sizeof(*of_root), GFP_KERNEL);
> > +		if (!of_root) {
> > +			mutex_unlock(&of_mutex);
> > +			pr_err("failed to create root node\n");
> > +			return;
> > +		}
> > +
> > +		of_root->full_name =3D "/";
> > +		of_node_init(of_root);
> > +	}
> > +
> >  	for_each_of_allnodes(np) {
> >  		__of_attach_node_sysfs(np);
> >  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)=
])
> > @@ -185,8 +198,7 @@ void __init of_core_init(void)
> >  	mutex_unlock(&of_mutex);
> > =20
> >  	/* Symlink in /proc as required by userspace ABI */
> > -	if (of_root)
> > -		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
> > +	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
> >  }
> > =20
> >  static struct property *__of_find_property(const struct device_node *n=
p,
> > --=20
> > 2.34.1
> >=20
> >  =20



--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
