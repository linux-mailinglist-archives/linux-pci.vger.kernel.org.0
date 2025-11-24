Return-Path: <linux-pci+bounces-41974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E60C81C49
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 18:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3656343652
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 17:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B320318136;
	Mon, 24 Nov 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho+Plmxn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FFB318121
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003719; cv=none; b=VuobKwzUCYaf2OnXDsOVumwvJLytu++R5lQQJqmGHlOXnfFncOunqenLB9eBpyee2Kpoz7FAMu05QKNR7slJUBc8DgdKkEdCBudfz2AOEBcygEUyEOinlMLO/PkQ0mDqkodnfgv4O2X9kKWM2XwloCvsdjEDYndZ1PC7Q90oDik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003719; c=relaxed/simple;
	bh=94qwcdvISJhCCZRqsIa3gf9UsdjE7+PgQuqqXXX1d/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AVeGM/kOZT01XDRXaSSDDoaiqS5TVPZSgl/6i29xeQz4E5Ohid+5Enm9yEKWEnVyOk0Pv4did7lroK8dcS/cNAuhheDJcnQkokQzoPC1nciZRQL//3WUUjjsXfIQ1WqtANwcmwvOvWEKnnTR/8+gndDxRlUT5C44E73STMAcSLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho+Plmxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F18C16AAE
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 17:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764003718;
	bh=94qwcdvISJhCCZRqsIa3gf9UsdjE7+PgQuqqXXX1d/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ho+Plmxnn3P+pnMYlBxGhObFUIhIv1nmt5vGVNYOaOiMqlI6qvZReFpUwxPflv6fi
	 9k+17jWbDsPhDsj09KouEkcKH6FdB2ThMFrqbQiy0jAx2I/qC4CF+aRsgaA11NQv7Y
	 owa480v3GZJC7Cok+f6Hrxa4aEfcUDUf/OOE5wacbstQIT23mkf5hBaEKNr9ojEv6H
	 k3sBSq5GG6+M69O2fNeW5hznx1mdKZjt8CUPaCW6RlsFw0tJkF4Kphw7I+c5HpXbYP
	 jU9zvwtwJjoh6ioZEg/r6Xhstgz5x2OKy8jwFb/TdT3sDPCGS8ixIfvGpQJGNnJ/aX
	 0vQ3kzmXveFeA==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b7291af7190so665822166b.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 09:01:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbeTC/gjtJAaV4+GFOWHssXig7xNa81Cj1u4PmutN3JXKkJfkW73rD6ZqBSkel7EO23X4BP8pAwyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVVXu3FfPjnyZ/jCaGcUeqNk43L/F+38p1g3HuKkyoWtQU9Bu
	7F3TVwGG/w2oUtSnIM1k75JhV9xUkHY48xMcjmxK5InneU7dNr13Iwa/Ac/RU49cUicaecOLo30
	abU4uJc7Nj8+9dPecpsrRYfuwcnw8SQ==
X-Google-Smtp-Source: AGHT+IFXf67K5MLIAp6akzlHdfYGJk0vOgsjBiRm9AVrjqIUmIUGdpSyKqEED/1RG1dv63/7cyPADsAtAzCIEsIc398=
X-Received: by 2002:a17:907:724c:b0:b71:cec2:d54 with SMTP id
 a640c23a62f3a-b767183f903mr1306003666b.57.1764003716998; Mon, 24 Nov 2025
 09:01:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com> <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com> <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
In-Reply-To: <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 24 Nov 2025 11:01:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmkdBVVKkq4S-uwQ2SqCH_pnOkbmYTHFkvDFxh_4sc4_x1p8K7UCt8Q0zg
Message-ID: <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT overlays"
To: Kalle Niemi <kaleposti@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Peter Rosin <peda@axentia.se>, 
	Arnd Bergmann <arnd@arndb.de>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Richard Fitzgerald <rf@opensource.cirrus.com>, David Rhodes <david.rhodes@cirrus.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Wolfram Sang <wsa@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, 
	patches@opensource.cirrus.com, linux-gpio@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Allan Nielsen <allan.nielsen@microchip.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, mazziesaccount@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:44=E2=80=AFAM Kalle Niemi <kaleposti@gmail.com> =
wrote:
>
>
> On 11/24/25 16:53, Rob Herring wrote:
> > On Mon, Nov 24, 2025 at 8:48=E2=80=AFAM Kalle Niemi <kaleposti@gmail.co=
m> wrote:
> >> On 10/15/25 10:13, Herve Codina wrote:
> >>> From: Saravana Kannan <saravanak@google.com>
> >>>
> >>> This reverts commit 1a50d9403fb90cbe4dea0ec9fd0351d2ecbd8924.
> >>>
> >>> While the commit fixed fw_devlink overlay handling for one case, it
> >>> broke it for another case. So revert it and redo the fix in a separat=
e
> >>> patch.
> >>>
> >>> Fixes: 1a50d9403fb9 ("treewide: Fix probing of devices in DT overlays=
")
> >>> Reported-by: Herve Codina <herve.codina@bootlin.com>
> >>> Closes: https://lore.kernel.org/lkml/CAMuHMdXEnSD4rRJ-o90x4OprUacN_rJ=
gyo8x6=3D9F9rZ+-KzjOg@mail.gmail.com/
> >>> Closes: https://lore.kernel.org/all/20240221095137.616d2aaa@bootlin.c=
om/
> >>> Closes: https://lore.kernel.org/lkml/20240312151835.29ef62a0@bootlin.=
com/
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>> Link: https://lore.kernel.org/lkml/20240411235623.1260061-2-saravanak=
@google.com/
> >>> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> >>> Acked-by: Mark Brown <broonie@kernel.org>
> >>> ---
> >>>    drivers/bus/imx-weim.c    | 6 ------
> >>>    drivers/i2c/i2c-core-of.c | 5 -----
> >>>    drivers/of/dynamic.c      | 1 -
> >>>    drivers/of/platform.c     | 5 -----
> >>>    drivers/spi/spi.c         | 5 -----
> >>>    5 files changed, 22 deletions(-)
> >>>
> >>> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> >>> index 83d623d97f5f..87070155b057 100644
> >>> --- a/drivers/bus/imx-weim.c
> >>> +++ b/drivers/bus/imx-weim.c
> >>> @@ -327,12 +327,6 @@ static int of_weim_notify(struct notifier_block =
*nb, unsigned long action,
> >>>                                 "Failed to setup timing for '%pOF'\n"=
, rd->dn);
> >>>
> >>>                if (!of_node_check_flag(rd->dn, OF_POPULATED)) {
> >>> -                     /*
> >>> -                      * Clear the flag before adding the device so t=
hat
> >>> -                      * fw_devlink doesn't skip adding consumers to =
this
> >>> -                      * device.
> >>> -                      */
> >>> -                     rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVI=
CE;
> >>>                        if (!of_platform_device_create(rd->dn, NULL, &=
pdev->dev)) {
> >>>                                dev_err(&pdev->dev,
> >>>                                        "Failed to create child device=
 '%pOF'\n",
> >>> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> >>> index eb7fb202355f..30b48a428c0b 100644
> >>> --- a/drivers/i2c/i2c-core-of.c
> >>> +++ b/drivers/i2c/i2c-core-of.c
> >>> @@ -176,11 +176,6 @@ static int of_i2c_notify(struct notifier_block *=
nb, unsigned long action,
> >>>                        return NOTIFY_OK;
> >>>                }
> >>>
> >>> -             /*
> >>> -              * Clear the flag before adding the device so that fw_d=
evlink
> >>> -              * doesn't skip adding consumers to this device.
> >>> -              */
> >>> -             rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> >>>                client =3D of_i2c_register_device(adap, rd->dn);
> >>>                if (IS_ERR(client)) {
> >>>                        dev_err(&adap->dev, "failed to create client f=
or '%pOF'\n",
> >>> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> >>> index 2eaaddcb0ec4..b5be7484fb36 100644
> >>> --- a/drivers/of/dynamic.c
> >>> +++ b/drivers/of/dynamic.c
> >>> @@ -225,7 +225,6 @@ static void __of_attach_node(struct device_node *=
np)
> >>>        np->sibling =3D np->parent->child;
> >>>        np->parent->child =3D np;
> >>>        of_node_clear_flag(np, OF_DETACHED);
> >>> -     np->fwnode.flags |=3D FWNODE_FLAG_NOT_DEVICE;
> >>>
> >>>        raw_spin_unlock_irqrestore(&devtree_lock, flags);
> >>>
> >>> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> >>> index f77cb19973a5..ef9445ba168b 100644
> >>> --- a/drivers/of/platform.c
> >>> +++ b/drivers/of/platform.c
> >>> @@ -739,11 +739,6 @@ static int of_platform_notify(struct notifier_bl=
ock *nb,
> >>>                if (of_node_check_flag(rd->dn, OF_POPULATED))
> >>>                        return NOTIFY_OK;
> >>>
> >>> -             /*
> >>> -              * Clear the flag before adding the device so that fw_d=
evlink
> >>> -              * doesn't skip adding consumers to this device.
> >>> -              */
> >>> -             rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> >>>                /* pdev_parent may be NULL when no bus platform device=
 */
> >>>                pdev_parent =3D of_find_device_by_node(parent);
> >>>                pdev =3D of_platform_device_create(rd->dn, NULL,
> >>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> >>> index 2e0647a06890..b22944a207c9 100644
> >>> --- a/drivers/spi/spi.c
> >>> +++ b/drivers/spi/spi.c
> >>> @@ -4791,11 +4791,6 @@ static int of_spi_notify(struct notifier_block=
 *nb, unsigned long action,
> >>>                        return NOTIFY_OK;
> >>>                }
> >>>
> >>> -             /*
> >>> -              * Clear the flag before adding the device so that fw_d=
evlink
> >>> -              * doesn't skip adding consumers to this device.
> >>> -              */
> >>> -             rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> >>>                spi =3D of_register_spi_device(ctlr, rd->dn);
> >>>                put_device(&ctlr->dev);
> >>>
> >> Sorry, some of you will receive this message now for second time. Firs=
t
> >> message was sent to older series of patches.
> >> -
> >>
> >> Hello,
> >>
> >> Test system testing drivers for ROHM ICs bisected this commit to cause
> >> BD71847 drivers probe to not be called.
> > This driver (and overlay support) is in linux-next or something out of
> > tree on top of linux-next?
> >
> > Rob
>
> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c

I don't see any support to apply overlays in that driver.

Rob

