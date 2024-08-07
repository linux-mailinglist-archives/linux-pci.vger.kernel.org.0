Return-Path: <linux-pci+bounces-11415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8194A231
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 09:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FF72818C7
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 07:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2404F1C9DC4;
	Wed,  7 Aug 2024 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j0CEZs2d"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4D51C4612;
	Wed,  7 Aug 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017441; cv=none; b=CjYmA7AdwodxJlbnkVMCnXecuZTZY7T+6uR0rt8DUTMOKzbDsIQNV7ZmNNt/n3yR79rfDlrmWYKVdXIqooOZGAlmaCB24W5/LdC5NMMsid3rjiK/2+bgMr9vWBfCGgKfyfwbK8l7+cD35w5my0+TvLPgWg5yPpBfqiO6H98UPnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017441; c=relaxed/simple;
	bh=/7N5Tz0sKSwu2LMtRaCxEH9+r1pKfsmhpHHKOWcdgUY=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A0752oikjt0ckT3sHcRd94wSYSXLazTbBp1Ip3mB56cYwtS2eXdvtQRRbmozFPWxKMQSOnZgRdPOnd32fmXnMmpfMdK/Ij1tThDmWE6nOF8fu9WLc+mYHXO3Ao7YsvSWvIiRXdf7aytxQOaKOHDeBXBLdUj0sGCb2BHOcmKw49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j0CEZs2d; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723017438; x=1754553438;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/7N5Tz0sKSwu2LMtRaCxEH9+r1pKfsmhpHHKOWcdgUY=;
  b=j0CEZs2d+WLipY1Cmyr8RnMHbqVG56JCEa/or9XUFcsVS85XvtveoIfQ
   1HfjouYb0CSY4OVNd/dLuz7tYzVbwM77gkyvr3uC2ZQgztrd+03r8CqYg
   2HtJLfJc56TWwSxsnDdr/8Yja1O5QL5ChJGkuJnvWbEUYTek+Uykogw49
   1txNgx1i//B+nWPFL3JfJWtEx15F5RAwPhtJP5UUb48u7ZTKdBOgqKOf/
   ylVHk7Hu6YBzouVB1dUdGXje2lSYr2EMOWnUerefXrTBbAqjZH7u9Ikd0
   kFoFynO/ZPJDFhp66vhGurc93UrypS/cw1GIuG9/eH7GavTSvWMXqTO6u
   w==;
X-CSE-ConnectionGUID: unfEUC1JS0q1rSj3dRuITA==
X-CSE-MsgGUID: 0PR5oX/8QSOGT9IPxT48bg==
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="33069002"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2024 00:57:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Aug 2024 00:57:10 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Aug 2024 00:57:07 -0700
Message-ID: <34471ead9073e0d424bb815cdc833d3ca9b94d3d.camel@microchip.com>
Subject: Re: [PATCH v4 4/8] reset: mchp: sparx5: Add MCHP_LAN966X_PCI
 dependency
From: Steen Hegelund <steen.hegelund@microchip.com>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Simon
 Horman" <horms@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Andrew
 Lunn" <andrew@lunn.ch>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>, "Allan
 Nielsen" <allan.nielsen@microchip.com>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 7 Aug 2024 09:57:06 +0200
In-Reply-To: <20240805101725.93947-5-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	 <20240805101725.93947-5-herve.codina@bootlin.com>
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
> The sparx5 reset controller depends on the SPARX5 architecture or the
> LAN966x SoC.
>=20
> This reset controller can be used by the LAN966x PCI device and so it
> needs to be available when the LAN966x PCI device is enabled.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/reset/Kconfig | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 67bce340a87e..5b5a4d99616e 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -134,7 +134,7 @@ config RESET_LPC18XX
>=20
> =C2=A0config RESET_MCHP_SPARX5
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Microchip Sparx5 reset d=
river"
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_SPARX5 || SOC_LAN96=
6 || COMPILE_TEST
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_SPARX5 || SOC_LAN96=
6 || MCHP_LAN966X_PCI ||
> COMPILE_TEST
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if SPARX5_SWITCH
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select MFD_SYSCON
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> --
> 2.45.0
>=20

Looks good to me.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen

