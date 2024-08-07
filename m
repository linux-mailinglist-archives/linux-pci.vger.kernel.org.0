Return-Path: <linux-pci+bounces-11423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315D394A4AF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5501C1C210E3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0A31CCB36;
	Wed,  7 Aug 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V2MnRUJ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A8801;
	Wed,  7 Aug 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024188; cv=none; b=eFmHbxriHlK4wNaX1QEY6LkGk34zhZYbv/ZL1dCNlOdhaTMgXSgBfFeDmX4YqS7wt0XT0QtkmhjWmbnW53ylX9j15tbVYVdaMhOFuMvo44hQBUJr21oeBbVRYF9j5BZiCfvmC+ElpoDVNOLhrgmh4YIF1NdwZ4mWeoDsgYP23W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024188; c=relaxed/simple;
	bh=p5E9zKddV2feWg3wZzHXjmOXnbNEA6sewjjyQImkQDw=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncTjm88tEZMPTZBvmbUuzypyv4Tf9XfaMz55Yn8/qOdcU66Tym9o4dn60XuX/lHJcalwWXPOYxmk90q10QqSoSMc8NmTIxT1Uo1hvX+Syc4F3Th5NqGxxdnUiEgCo6fhDG9hmbDQS3IhKLFd+W0YpcZRf8xm12B8WiwGX0TPESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V2MnRUJ0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723024186; x=1754560186;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=p5E9zKddV2feWg3wZzHXjmOXnbNEA6sewjjyQImkQDw=;
  b=V2MnRUJ0DxvB7WERxDMXSYZrFkPLDsvIMFu3ccF8wpepfRLmu/tDbZeC
   WkZWbiAaNZBzpAYJMGDW2vYCWpC2bDUrWCMZio1DCkSMjmKkqRQ1cUQRh
   EnOHzmV8OAcxfqXDDsRY0P5coBcn0HKFk3C0bcU4Rj+usXGWLjvhFZPk7
   16lxAdzARkk543VUZHmhJnPBcj3ap0egNF6TvmknVARKR30rtSSg7v/5u
   J+vFt1J0tl9yK91o0aR0XMJatb/fYc2BADpOqa9OW+74nRY+eIuarJ4sW
   w3xP9jlk/6C4DrHc9Gtm0ZaH+5NLnfm5xWJj1ReT8xERCFlWwaSZNCT6A
   Q==;
X-CSE-ConnectionGUID: 84YL2YxrTjaVTxV9Ds3KIA==
X-CSE-MsgGUID: dX1L9EdXR1qffcjUQ4NgVQ==
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="30861844"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2024 02:49:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Aug 2024 02:49:01 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Aug 2024 02:48:56 -0700
Message-ID: <33d1dabf26457f0a43c78a35ac1d8bcf35f15bc5.camel@microchip.com>
Subject: Re: [PATCH v4 6/8] reset: mchp: sparx5: Release syscon when not use
 anymore
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Simon
 Horman" <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
	<dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Saravana Kannan <saravanak@google.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Andrew
 Lunn" <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>, "Allan
 Nielsen" <allan.nielsen@microchip.com>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Date: Wed, 7 Aug 2024 11:48:56 +0200
In-Reply-To: <20240805101725.93947-7-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	 <20240805101725.93947-7-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Herve,

On Mon, 2024-08-05 at 12:17 +0200, Herve Codina wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
>=20
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>=20
> The sparx5 reset controller does not release syscon when it is not
> used
> anymore.
>=20
> This reset controller is used by the LAN966x PCI device driver.
> It can be removed from the system at runtime and needs to release its
> consumed syscon on removal.
>=20
> Use the newly introduced devm_syscon_regmap_lookup_by_phandle() in
> order
> to get the syscon and automatically release it on removal.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/reset/reset-microchip-sparx5.c | 8 ++------
> =C2=A01 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/reset/reset-microchip-sparx5.c
> b/drivers/reset/reset-microchip-sparx5.c
> index 69915c7b4941..c4fe65291a43 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -65,15 +65,11 @@ static const struct reset_control_ops
> sparx5_reset_ops =3D {
> =C2=A0static int mchp_sparx5_map_syscon(struct platform_device *pdev, cha=
r
> *name,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap **target)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device_node *syscon_np;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D &pdev->dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *regmap;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscon_np =3D of_parse_phandle(pdev=
->dev.of_node, name, 0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!syscon_np)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -ENODEV;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap =3D syscon_node_to_regmap(sy=
scon_np);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of_node_put(syscon_np);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap =3D devm_syscon_regmap_looku=
p_by_phandle(dev, dev-
> >of_node, name);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(regmap)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 err =3D PTR_ERR(regmap);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 dev_err(&pdev->dev, "No '%s' map: %d\n", name, err);
> --
> 2.45.0
>=20

Looks good to me.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen


