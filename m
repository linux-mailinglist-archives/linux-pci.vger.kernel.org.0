Return-Path: <linux-pci+bounces-23901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8BAA63C89
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 04:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153EB1883C70
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 03:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B81459F7;
	Mon, 17 Mar 2025 02:57:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2116.outbound.protection.partner.outlook.cn [139.219.146.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B91617A2EA;
	Mon, 17 Mar 2025 02:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180253; cv=fail; b=Tvv3chYwR2CwdhvL0oUtC/5KCYvV9sAJc/AvSW//yVbcuJsdZyFAVhj3Ng+lzTkiDq7X0GqylTQfpYKoZWnMs0mOw0XenRL/HJlbWdPudc8h6d1Q8kTWRnXmKuXor5SU3lxdzDmqwNDNDSkz5liLa6cuLu9xsOShNdXDpPpZXqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180253; c=relaxed/simple;
	bh=UKLePFuwcAYo8bHpGPEvkJojBkO6NnKaDSFWjGcYV5Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvliOB5tOa2f0759zle0AcT/HWjQ4SydSLUT/WGMK1sJMoGKpaNZ0x6DHeWux5cW17lzYSdLqg4BvoT2xTcEe6AHVqpUWg6Bq8CILV15+S+PriIbCN0LW6yuGBH0TksYRn/8dOZGfFNfRveMkIuD7EuDjTudnj14fWWiecloWWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsVPaocjGGbWbKy0HtZdXuJkp+8z1GXSpG8ZnB+lg9Qhywuxt1FOqOdQFo+KXfLtqiNKCTGXmB6DOEPdt37UOx9fDcjzouYgVHLVgk/O5N9ILACvsSVq0g1/12Or8lxlPAXxYFBDBMFxrwhYMM+SCWYzgqlhTfqO5OntPgqqUULp9lkkvmanmZfmfeJXRkBtIEoDt1t6IPOR2DhiN/3o0j+b8HTrtN8XeHnB2oeJ48QQwkZIaWkZIRvx2TCLAT4kpR7QaDsCvSE0XkAF4v+NlsXyYNAtxqCOTlyVvaJcmODz1Gj2HDM0Jept2veiMX8loL4CGFktgZq966109PjeqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2yALXYMOL6yC4QgtRrrdIjEJjtHQo1a+bnhH55RoT0=;
 b=FWUesbrfsyNVvbq8BQzNIHBAZ2TyAiZt9zFRaROJa2V+uRomApM7f8W7whqpqIlA5klOpfBzu56pvBIv80osgKc8Xq0+XYI23T8PQPFGK1aWAzkjTt59+VGnlAJGBc6bvwNpVHnUjEJ+uQ2Ks3y9AS9uH2w2UlACMzfqAwngJJ7vOTxbRMYTGI8RUaH1aHK34JJsH9vl74xq9oajx+fSHdi+7cRtRApR37QkENIUqQvcCL6/KhceU10JqbjAsWHi3t4ulDKDfG5GnxQN9HSXN+vmN3rj7hz9Sox/5OLD3vXKG4lujCerxLFrKlt4gsxGdvEgX9yScKWXHRRMPwMjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.33; Mon, 17 Mar
 2025 02:23:05 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::3f35:8db2:7fdf:9ffb]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::3f35:8db2:7fdf:9ffb%4])
 with mapi id 15.20.8377.007; Mon, 17 Mar 2025 02:23:05 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Anand Moon <linux.amoon@gmail.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Kevin Xie <kevin.xie@starfivetech.com>, Conor
 Dooley <conor.dooley@microchip.com>, Mason Huo <mason.huo@starfivetech.com>,
	"open list:PCI DRIVER FOR PLDA PCIE IP" <linux-pci@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] PCI: starfive: Simplify event doorbell bitmap
 initialization in pcie-starfive
Thread-Topic: [PATCH v2 2/2] PCI: starfive: Simplify event doorbell bitmap
 initialization in pcie-starfive
Thread-Index: AQHblpa2er1tAxC//ki5MhVtCgBi17N2mdkA
Date: Mon, 17 Mar 2025 02:23:05 +0000
Message-ID:
 <SHXPR01MB08630F70345E05F6124B54B8E6DF2@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20250316171250.5901-1-linux.amoon@gmail.com>
 <20250316171250.5901-2-linux.amoon@gmail.com>
In-Reply-To: <20250316171250.5901-2-linux.amoon@gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0670:EE_
x-ms-office365-filtering-correlation-id: 77ecc8d3-8173-4710-fce6-08dd64faa6c6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 CAWZ9YEZLn3SiQLNQwh5oTbBG0UKEkpiOFMhZVFN2pGz5fguXtACiCiqU1o2QC3ZB/3HUa/uUzgWNgWaxgLYWLas2UYMK67zCHd2NanczsDDo64b+mOPLRON0pl0HeG5vUgc7DItTvebJu5BArSiG7PnHJUQEb1zwgyJ9R43+bCmjiO0A/R14EUf+0Afr97Hkj2FCzoAnHocFouXfP+OqG1BTw+Z0CVodf+cvFSrv1n10iDcD7+97/hmz/PZBsP8KstYS3w7a+efcWymIzw8JkNIRZsa8nUjL3OlHw3ykvP/owz0Q+j2jhP52CZ0zD6IeaHtXY6agdITVnRdGZ49ml2R5IDk2V52C5mO4fjxbCoKnwrWDSvUMAlKyoTz9XMXG3p94vtDd1SCUkFj8FmWhDNd3DFK0Lw54VVuxaPWzaa5yyMavXrWPx+2cmwdXtZPTG8892h2LPLFSZ2hPTeJinw+d6pyr6G5fYdShdoJwm2WrLa/wPX59AEf/2AbquYH433JzR8XhOZQluf6M3MyegofhJbX34lniTkct2Ld1afUZG3Zu5zwjp3W0dp/Dhib7nsKyWGMv/8GeM6lsKKJf+2dU1dvyQ1eXCBqT+NeHcc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?7J3LKRqyVc2p0ko6jty4icTLCLYam27JhaIcypENFiMcEcmX8fEDXj6Vn6?=
 =?iso-8859-2?Q?tlMRudQmqPubRIw2trF4ox/LSsEezxsSNw+p3h2iuQXHZaB0WTPbUeYuM3?=
 =?iso-8859-2?Q?vRrzrgREqyQnFozdDDNc+XJcV+njYa93QOkCirLeDeTWQ3PWhIsUKv70JA?=
 =?iso-8859-2?Q?k/Fml/Nt0dOI9c44oZDYW/IIi8Mz+HeTKODxnVKowpVIH4sos0/AXq2W0I?=
 =?iso-8859-2?Q?J1EJRPfLN2ISurho5ulF+J3hMWszCJuKSFI0Jria+eglUZxnPub24KZ7sM?=
 =?iso-8859-2?Q?hZa3FAGj/q6780o12hK63G5DLbs0llcHe8Ex4X4RPwInKO7Poov11jV1FJ?=
 =?iso-8859-2?Q?ZwJN0oXhn0h7aiJcXW7JwvEbjOBRe/qdXxMOD/dBTN0BjJBmONStxpN2zL?=
 =?iso-8859-2?Q?e7VJrJxcbbiX2YzJ39Oq0b4h2Dgf0Hmz0uW1htfssmEcohdL0nXkaT+bsi?=
 =?iso-8859-2?Q?vWVLvQy4J9wvXsQWNLkw/3o0l8IwnKq2Xk+0VIQx5U8710/8LmyR475MNH?=
 =?iso-8859-2?Q?Z56jx81fI/QQdJYrGlxDmWOay3QeSvXc5GRXo7p8L3UN/M5f8vs/wx0xm1?=
 =?iso-8859-2?Q?h17DLWJjJN+4xFuBXlEOlpKKEEiAFgXOCrzEoD2LIFoBOrapjCQe+4N4Mw?=
 =?iso-8859-2?Q?GmgojXDDebIbqn2UZld3IsMtnwYSpOEmAhjaSLuIbCtu4ceLHkqjYxFVaT?=
 =?iso-8859-2?Q?0mSCrczqdY4Hv72DVZGnqYOZdvkXr+wc6uaqWfn894wIbVYRvDn1rMnV6D?=
 =?iso-8859-2?Q?Dg87EE+5WAoFkW3hfwhVRbPpwwoFauzbkW2xxj/O9LWXJzKMCZ5CSLzvYj?=
 =?iso-8859-2?Q?b6MOMpQ6ME9lUGeu6t6dXWUjaX9bFVeJhcGGtGbfRM5epIXjt54VT6IeuC?=
 =?iso-8859-2?Q?rKpUeEEquNP7Dn1qGYR9Y9qSoKTR09upfDMwYL7b1ZsJkfMWVoXLWufKB2?=
 =?iso-8859-2?Q?gZGLXTHlQLy3je4MDAJg8XYZ4Ht4JNIUa8BEVfWajp1wkjW1MwVISGXz4i?=
 =?iso-8859-2?Q?AoIZCApBx803RZzdlOyhdG7iLOSCcDOUXX3pIzVf21xAiGP/Yybo5kyhQT?=
 =?iso-8859-2?Q?CSA9yZuXX97tq79ewazB+ZhWlo6SYAoUcQn4ByoDJpjb0safTq7oKOmFLo?=
 =?iso-8859-2?Q?3xagvwmedeS1M/HX6E5hO3SLkk3MDv1ndrIl0j3X59GSsIPlVlk0UD5/rP?=
 =?iso-8859-2?Q?ILdtXlnxem1ruWt3DIJzKX4CJ3cBsyWTZ2hqIVUq9YTi2/WI26VJpTUPcq?=
 =?iso-8859-2?Q?ReErbPHC1qzw6CO0Z+aYUW+a0Og837sAMxHkW6xkOlpqVONqxx5w8eznlo?=
 =?iso-8859-2?Q?4KsNetfSHk4M3Kj3wq00wDlThlaY8Wc/Vy7KhB/8U/AlrDfFnwy7fn+K1u?=
 =?iso-8859-2?Q?O4GFelFaaFDkZvrk75a5+wvxbLPr8XIUZHBhKUb3WhDLj6iVZaVMZqSirK?=
 =?iso-8859-2?Q?hQ8+9r69Oua11wF8GiWRNebSVx1f29RR3ZmMQqpypDZEvrPaEjMXB44Gqv?=
 =?iso-8859-2?Q?UmIYJRPjTKJhrkLFDB4y24aEGriMGiQsKzPnI902NSwv1yWxu4q5ae/tcu?=
 =?iso-8859-2?Q?O0tvb87tmUWSqHEWkYNowgLWof0HGhiUCjTfz0rKhA6G43xonLDqx9Yvp2?=
 =?iso-8859-2?Q?dYx6aPDx3knjfDizcdPVjU3C62dpYdUzir?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ecc8d3-8173-4710-fce6-08dd64faa6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 02:23:05.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC6LMjSH+/0fmIqAYrUuxmZAN3KGiKH0tK/kszMbkQ2l1eEUic9S8z0BhuX9NyorXFZsMjbPOTS7NrNWP0tUUR0EG0Ak6ukHKi3rEy7oojg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0670



>=20
> The events_bitmap initialization in starfive_pcie_probe() previously mask=
ed out
> the PLDA_AXI_DOORBELL and PLDA_PCIE_DOORBELL events.
>=20
> These masking has been removed, allowing these events to be included in t=
he
> bitmap. With this change ensures that all interrupt events are properly
> accounted for and may be necessary for handling doorbell events in certai=
n use
> cases.
>=20
> PCIe Doorbell Events: These are typically used to notify a device about a=
n event
> or to trigger an action. For example, a host system can write to a doorbe=
ll
> register on a PCIe device to signal that new data is available or that an
> operation should start12.
>=20
> AXI-PCIe Bridge: This bridge acts as a protocol converter between AXI
> (Advanced eXtensible Interface) and PCIe (Peripheral Component Interconne=
ct
> Express) domains. It allows transactions to be converted and communicated
> between these two different protocols3.
>=20
> Fixes: 39b91eb40c6a ("PCI: starfive: Add JH7110 PCIe controller")
> Cc: Minda Chen <minda.chen@starfivetech.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: new patch
> ---
>  drivers/pci/controller/plda/pcie-starfive.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c
> b/drivers/pci/controller/plda/pcie-starfive.c
> index e73c1b7bc8efc..d2c2a8e039e10 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -410,9 +410,7 @@ static int starfive_pcie_probe(struct platform_device
> *pdev)
>  	plda->host_ops =3D &sf_host_ops;
>  	plda->num_events =3D PLDA_MAX_EVENT_NUM;
>  	/* mask doorbell event */
> -	plda->events_bitmap =3D GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
> -			     & ~BIT(PLDA_AXI_DOORBELL)
> -			     & ~BIT(PLDA_PCIE_DOORBELL);
> +	plda->events_bitmap =3D GENMASK(PLDA_INT_EVENT_NUM - 1, 0);
>  	plda->events_bitmap <<=3D PLDA_NUM_DMA_EVENTS;
>  	ret =3D plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
>  				  &stf_pcie_event);
> --
> 2.48.1

Hi Anand
   Mask the door bell interrupt is required. In some case, ( eg :NVMe read/=
write mass data) found error.

