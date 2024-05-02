Return-Path: <linux-pci+bounces-7004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0878B98D4
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FCA1F226A6
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 10:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB959154;
	Thu,  2 May 2024 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ptnzpBEE"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A0463C7;
	Thu,  2 May 2024 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645891; cv=none; b=FgHRbwGc6btYm95n5yFfMTjPPiVvQ/RIBe7HVLK/CTg38dOJbrJRSqck5abjHtaJQ+ZWs+A2KYHG0Bbk4CsfpJ5ZeaGEAMNEGtpK5glpmGPpsuDnJJ9lByhwqEhAeGoHoy2JLwt+zV1Q3I6Ccuj7dJrxKK3SM2Fd3kzAo/9R8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645891; c=relaxed/simple;
	bh=3dHMTEpx+RjhmY6hvsHHM+apJyEPXU7sJbM2hOdVHVs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFXzGVp9GI4V4WJlcD/KD522VoWu1C5VD9sEqtRAjsk5G7K+3VFigxa4pL8O8kC6YoC0eAl4c9kbSkwzMTfhbvVBzGUYGCC+AeGuvEmQ6C5/BHBzQ7BpLM9rGvoRig0O+HpU8J8WxXWBCvkacHcrVyFlJboVF1Du708wQR8ANrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ptnzpBEE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1714645889; x=1746181889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3dHMTEpx+RjhmY6hvsHHM+apJyEPXU7sJbM2hOdVHVs=;
  b=ptnzpBEE69P8Yzc+sD6xwsWOEIxSkYHpM4R7/C9rhTxuNr2VP5MHFNDo
   omeBtIRsDv8pnPQE9MZLyJMqO9YWfVO6oe5N/lQb5Z1wIlH3rH27ByIKP
   0GjQsIt/7cZZF0pGPlAKUwOfefSfDmenVlbdoJYB7r7XlKDMIDeJFI27K
   XG73aCaRwj/iMj8kEqS8FCvlfxab+eqXjLHTAh+Lpg29iU3KUQ91aVU61
   ehp4ACXrKunWHdaBZfBypZ0H0H8sHOz8Z9/w66pPYBroPwMhpRNqHwMVE
   zKTYDp5swaCA2t0vdN69xT749thwq7FDHoN5eYCDPFOWLa5BuP5M7JZZN
   w==;
X-CSE-ConnectionGUID: j7YMYpQzS2Gpi/aU2WdzxA==
X-CSE-MsgGUID: 9DOz9USjTpSELk8k6vmCKw==
X-IronPort-AV: E=Sophos;i="6.07,247,1708412400"; 
   d="asc'?scan'208";a="25515845"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2024 03:31:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 2 May 2024 03:31:22 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 2 May 2024 03:31:17 -0700
Date: Thu, 2 May 2024 11:31:00 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>
CC: Andrew Lunn <andrew@lunn.ch>, Thomas Gleixner <tglx@linutronix.de>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
	<arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Allan Nielsen
	<allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <20240502-petted-dork-20eb02e5a8e3@wendy>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-7-herve.codina@bootlin.com>
 <5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
 <20240430174023.4d15a8a4@bootlin.com>
 <2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
 <20240502115043.37a1a33a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oR2zK1enCDCWfwar"
Content-Disposition: inline
In-Reply-To: <20240502115043.37a1a33a@bootlin.com>

--oR2zK1enCDCWfwar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 11:50:43AM +0200, Herve Codina wrote:
> Hi Andrew,
>=20
> On Tue, 30 Apr 2024 18:31:46 +0200
> Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> > > We have the same construction with the pinctrl driver used in the LAN=
966x
> > >   Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> > >=20
> > > The reset name is 'switch' in the pinctrl binding.
> > > I can use the same description here as the one present in the pinctrl=
 binding:
> > >   description: Optional shared switch reset.
> > > and keep 'switch' as reset name here (consistent with pinctrl reset n=
ame).
> > >=20
> > > What do you think about that ? =20
> >=20
> > It would be good to document what it is shared with. So it seems to be
> > the switch itself, pinctl and MDIO? Anything else?
> >=20
>=20
> To be honest, I know that the GPIO controller (microchip,sparx5-sgpio) is
> impacted but I don't know if anything else is impacted by this reset.
> I can update the description with:
>   description:
>     Optional shared switch reset.
>     This reset is shared with at least pinctrl, GPIO, MDIO and the switch
>     itself.
>=20
> Does it sound better ?

$dayjob hat off, bindings hat on: If you don't know, can we get someone
=66rom Microchip (there's some and a list in CC) to figure it out?

Cheers,
Conor.

--oR2zK1enCDCWfwar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjNrYwAKCRB4tDGHoIJi
0pEQAQCt7WPpck+AFuGS12oVa1N8yGCSfuKXJm4Od9Da8tlaPgD/aFOJjFeQYVzV
6qqMPyJPVrPFYPKTQXVXJGXs/c3Crwg=
=iWhj
-----END PGP SIGNATURE-----

--oR2zK1enCDCWfwar--

