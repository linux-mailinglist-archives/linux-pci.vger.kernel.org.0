Return-Path: <linux-pci+bounces-11422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2004D94A408
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 11:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 871D3B27702
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03EA1CCB28;
	Wed,  7 Aug 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xeEtXVae"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5A1CCB27;
	Wed,  7 Aug 2024 09:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022210; cv=none; b=isL1Kzen5b4diIT6AO3KcqGjZ9lkbZ2HIj33wblmTVCjZrmrO0rFRVJknwTcLA7Pdw/JyW57KQsO7+aY/ApyAjJjNgsO6hWyMdi/VdolfR8uUoOjADMjztZ08G6J0//NN4p8K+ObyAYIzcYezeWU9M+fZ0/qBL4BS/FNs7w8Kn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022210; c=relaxed/simple;
	bh=c/slf/jw/OchoUyvGIOG9Xcv1iNRWWO2Xh+P4JpQCLQ=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nKu2UFLhwfJ1629D/ApKGvGAWAKQkp5Jm5Ew1DmUc5C+44l/p1dSAQ6PGgetzQe1/Wy7evEaCSImEpbXbwc9ZkUB89iIhdotMBinTW6Q9O6/d8BrTroDa4EBJOEojuBxsNOM3sXSVXUBy4Eq74tbxOxBTDzd5zxmhRwTwzcI0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xeEtXVae; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723022209; x=1754558209;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c/slf/jw/OchoUyvGIOG9Xcv1iNRWWO2Xh+P4JpQCLQ=;
  b=xeEtXVaeeytfiZvrmFuN4PO3/ey0/FREfZUd0lKl6/KC0VHOp9Qynu1e
   YEXl3ylFeISMeMUdQbuwqpVl4nJLkeInp/+GuCvXVFyZxq5/PMGMH1T1x
   6vxJYAf7gVp2u5FyK7yXKRSIt3qRHqzh0SFUDjA5khKtmHtoHK9PwoVsW
   1rfa2U8+k3d1hBaa59V4GLJu+G0FnoqHlKMb9Ds964+byUy+jIQ9jgauG
   k2gCRENhpsNTeHsAnzyj1eUSO3k64MnBtiEU3vTOeN24oDQcrkEL8c9A/
   Du4Xq0isQmKuC4CoA2fib2qaJSfKxmd+OEg0ADttqCMqdFDIo30Ft+x/l
   A==;
X-CSE-ConnectionGUID: eofU3f1ZQCKrHjE+RvmBAQ==
X-CSE-MsgGUID: sAfpxfwFR/Khxbw6o7ocXw==
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="30199139"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2024 02:15:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 7 Aug 2024 02:15:04 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 7 Aug 2024 02:14:59 -0700
Message-ID: <442332f001bf81a1cd8733d5c2ae94d344e5a286.camel@microchip.com>
Subject: Re: [PATCH v4 5/8] reset: mchp: sparx5: Allow building as a module
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
Date: Wed, 7 Aug 2024 11:14:58 +0200
In-Reply-To: <20240805101725.93947-6-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	 <20240805101725.93947-6-herve.codina@bootlin.com>
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
> This reset controller can be used by the LAN966x PCI device.
>=20
> The LAN966x PCI device driver can be built as a module and this reset
> controller driver has no reason to be a builtin driver in that case.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/reset/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0drivers/reset/reset-microchip-sparx5.c | 2 ++
> =C2=A02 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 5b5a4d99616e..88350aa8a51c 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -133,7 +133,7 @@ config RESET_LPC18XX
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables the r=
eset controller driver for NXP
> LPC18xx/43xx SoCs.
>=20
> =C2=A0config RESET_MCHP_SPARX5
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Microchip Sparx5 reset driver=
"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Microchip Sparx5 reset dr=
iver"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ARCH_SPARX5 || SOC_=
LAN966 || MCHP_LAN966X_PCI ||
> COMPILE_TEST
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default y if SPARX5_SWITCH
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select MFD_SYSCON
> diff --git a/drivers/reset/reset-microchip-sparx5.c
> b/drivers/reset/reset-microchip-sparx5.c
> index 636e85c388b0..69915c7b4941 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -158,6 +158,7 @@ static const struct of_device_id
> mchp_sparx5_reset_of_match[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
> =C2=A0};
> +MODULE_DEVICE_TABLE(of, mchp_sparx5_reset_of_match);
>=20
> =C2=A0static struct platform_driver mchp_sparx5_reset_driver =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .probe =3D mchp_sparx5_reset_p=
robe,
> @@ -180,3 +181,4 @@ postcore_initcall(mchp_sparx5_reset_init);
>=20
> =C2=A0MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
> =C2=A0MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.45.0
>=20

Looks good to me.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen

