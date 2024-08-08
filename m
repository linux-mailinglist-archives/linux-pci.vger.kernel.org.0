Return-Path: <linux-pci+bounces-11476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3AB94B8EB
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 10:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB471F20CAA
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 08:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2428188CB7;
	Thu,  8 Aug 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OU6xRf2s"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB11145336;
	Thu,  8 Aug 2024 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723105356; cv=none; b=QtsfFcwrsy0pLfFa2qmOZZcGcfQrZJdPWhaN9zGQ7cN+sHTw/FgCVAsdBM2wZ9GBc5T1B5kxuCyj6Ael2sAriqMH1IlFtxmtF9k54KtwcpZI2r+MT4T9lvduLwLlfplxYa7eIBSnM+idKf6HJ9Ne3ETkmNrmn/wf4mAN6XZMyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723105356; c=relaxed/simple;
	bh=2488M6qNYP0lwXNFrjsG9Nh3hWzY6hPo+i/FhLpDmgg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=set2lDYWFBV8y9DBPENfSINRGJ3OCYH+khOCWw0bVR4DLb8AzIuZsY1ftHFxMzjg09Bnt5XP/h4jZ5DStSuc6a19UenOD4lqYU5lvcl3mK0nlYCo1HNhGWGFaDvlCLwNbbD7AP9sV/latrdvTUM51MsdeBNl/H7KxTbRxuiheuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OU6xRf2s; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723105354; x=1754641354;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2488M6qNYP0lwXNFrjsG9Nh3hWzY6hPo+i/FhLpDmgg=;
  b=OU6xRf2sycuTHp1a+aRayHftlnknPA/eb/ouu3vicxCGyMLSPQCaDt0R
   H6wv2IDQx9Yzet5+gGrsrhIK8DSIavmmjNsfsEg9ZozUShAAjZ+EqRKeD
   OzJ0MbCa4U3UBX0/tbdekzduigczpDKLLFKdQlG1wt6HuIsigIRSF3/yN
   452pm4vXLgAzEyFBDlykEbehaVVL0t88xGCAI8MTkGYUMoY1sMJhsIIVI
   5O1O7Bk76eCxM0qkNnPwwiQnVsOQtZp2vk3VJtLN5Nvn9r5REoLoyIwFO
   Q/+gUO8BydMGJE1GXxhhqBU5mtCAkBPN2Wbefx8hgERncS1LWDqaIAvys
   A==;
X-CSE-ConnectionGUID: Je4g5QipTv6hZwyDxvIfog==
X-CSE-MsgGUID: ztRBfumgSjOF5Sno8g7hyw==
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="30208235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 01:22:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Aug 2024 01:22:28 -0700
Received: from DEN-DL-M31857.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 8 Aug 2024 01:22:23 -0700
Message-ID: <f97296c967211a6a8f6f40996e3ed74b76bad935.camel@microchip.com>
Subject: Re: [PATCH v4 8/8] reset: mchp: sparx5: set the dev member of the
 reset controller
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
Date: Thu, 8 Aug 2024 10:22:23 +0200
In-Reply-To: <20240805101725.93947-9-herve.codina@bootlin.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	 <20240805101725.93947-9-herve.codina@bootlin.com>
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
> In order to guarantee the device will not be deleted by the reset
> controller consumer, set the dev member of the reset controller.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> =C2=A0drivers/reset/reset-microchip-sparx5.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/reset/reset-microchip-sparx5.c
> b/drivers/reset/reset-microchip-sparx5.c
> index c4fe65291a43..1ef2aa1602e3 100644
> --- a/drivers/reset/reset-microchip-sparx5.c
> +++ b/drivers/reset/reset-microchip-sparx5.c
> @@ -117,6 +117,7 @@ static int mchp_sparx5_reset_probe(struct
> platform_device *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return err;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->rcdev.owner =3D THIS_MODU=
LE;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->rcdev.dev =3D &pdev->dev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->rcdev.nr_resets =3D 1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->rcdev.ops =3D &sparx5_res=
et_ops;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ctx->rcdev.of_node =3D dn;
> --
> 2.45.0
>=20

Looks good to me.

Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

BR
Steen

