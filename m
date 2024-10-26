Return-Path: <linux-pci+bounces-15384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F3C9B1434
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 04:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550BD1F22825
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 02:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3B113B29B;
	Sat, 26 Oct 2024 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MpC/iZMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7468BEE;
	Sat, 26 Oct 2024 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729910239; cv=fail; b=bcBCKnj1Yk1AGzbi3nVaMWotcvORLHFHShOham6ktcwa9hO8mxiyF2FySH9aZRhB7qpglYm1rzHS2Zf2uztlJr4wFDVKZ+h6M2bYTi7XFU6QY0drgJpxfJ2zPfLK/3mQ19efexuyQ3hLdQtW6MlrHdjIFA8fsnHNdKI9nKQlqOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729910239; c=relaxed/simple;
	bh=tfAtoI2bPDuSasfyAMoFzo9YwDB4rkN+fBoQ8TgmbAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cORZrzzd6ygcBIIy+FGLSUvcaLczrHauM7ss9K/0wGGO0YYn2HbS0eiAh9jLv7PZyFjt7luxVhlpozUvd5mHjLP7acDYQKBz0q+2mzh4ypCY3nXVLlwK09uHomxv5aGncPagriawyNtRWGGJ+qiJp8gflwWKaMY6Mx9DWZ7XdyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MpC/iZMR; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMGdyJS5TyICqobKkYTYO+A50Clvgz0gd2ibuBWkPinRHX4avuCQBCf678RuwijEZis9rcuw1AJYRdPCcOGXv9yBsrgVfiVnNzzzv/oQY+V0rtaK+hkzemN0qDdINCanTegHAq/h+6Q+uLlNJYPQgs58iOJgB9OsdUNgsvzz6GjfgeGfT2yCUS81OrQmdGnmMMwg9oCztRR932BNzgoZ6jVl/u9L8X1kmJ2O0VhXYRzLqxMoTAR602JioSYEosM9xvjs6JY5QBct4wBJynZOaiTkcU8cBYvIkyzcDhIW2qGCzmUCODsTEQUDxLg6Ts6RKy6kutPKVgyETzkVhh89Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivrgg77Dh1XuNjig3lFgryt34y8sdQ1ctiJumOr+BRg=;
 b=eJ8PaOgbRdTk5fvfD/4osX3FqUumXWBGLhbQWzy74FLIdOkI6+HtqN6lZClpcshPi2oeqOfU4dCf2UsdIiWaohjc8cWe0oyAyGi26YEmMvWsIzAiPBagpTm+x47miY8dI1uMP4LD0A2preG2SGOKaL0hSAOcZTjAJHleCAAIE/hcJ87i3cqomlAJ37T3Qj3HeFSwq7h5Ds3dOUCedrhpWZCTVwOAdtnN0wUSuV9k/z1PuRw822z4hIKayCz/uUTgqOjyoykmMriZpIHO3OVUcEGNZZdXJahFAsRLdIez6QmYjETVulctDwjv/7jTBvFCI16UGpJVT5rbVQGXHhh3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivrgg77Dh1XuNjig3lFgryt34y8sdQ1ctiJumOr+BRg=;
 b=MpC/iZMR5tSBLusdAG3yEfB8sIAkHVKoC3BTEUY3L7J8qFqqS+/GcfSO7bJ/dddcvBesehvLv4QKW8178peNfffD7FoYZUzYfoG3sF1PAe8jreXVUxYp31zRpvgLfAp06+wMmTC0XB0KiAiG0e6YyK2VgMGl8baNmw7jRARQQet15dzcmCDp7t3GJI6eWw0sa+tWbKcsE/oRm/n7fhLKqIB5ZsxHjWuyDBfoZeqojmmZNI7GgQd/9PB6ZfpHwjcmyaJc2J//0KtHAn/R+66sIfNOOw4m1vjt6JV/mITheYCgMdmmIzo7Lo9vUHJlBPktYxIBn5x/CLVQXrsYLzYHVQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7418.eurprd04.prod.outlook.com (2603:10a6:102:8b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Sat, 26 Oct
 2024 02:37:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Sat, 26 Oct 2024
 02:37:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Thread-Topic: [PATCH v5 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Thread-Index: AQHbJeO2tXEnxtLkY0+lfmVV8KleR7KXOzQAgAEYEvA=
Date: Sat, 26 Oct 2024 02:37:11 +0000
Message-ID:
 <PAXPR04MB85108D88299951702116B92388482@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-12-wei.fang@nxp.com>
 <20241024065328.521518-12-wei.fang@nxp.com>
 <20241025095136.dlft7ixliiixejkv@skbuf>
In-Reply-To: <20241025095136.dlft7ixliiixejkv@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7418:EE_
x-ms-office365-filtering-correlation-id: 36c6407f-3ee9-4ce5-309a-08dcf5671863
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zUgVs3Q8uZc5Tsh+Zv1OfDrLYfHqL1Q7oGI0a5kYS6jLPwwqHUetcH8uWSZ7?=
 =?us-ascii?Q?1uwIMnZs3zgOPAckyT3+OKG9wJxWMqRcZdB6P8RZxHc92fpWlY7VGm2VkEwI?=
 =?us-ascii?Q?lbNr5s7mivwoBExdpFx7WFrGXA6MDwXULb4H5znTWulAWGlD8dWIz8vk3ZoT?=
 =?us-ascii?Q?tbfk5o7d+/HEPYY0tV8v6rbyMIY/NC1t7HOAv4TrNY2zI8vioNrjmUhAgInp?=
 =?us-ascii?Q?YcvBo3y3PqFBiPIm5H7K8RmWoM0Vv/EMml15IqUSg/pYMZxI36ol/bDGWCNN?=
 =?us-ascii?Q?YXx03NXebhxTQD1VlLbxm/r0DEhZK0pXtmm5ITKQDHoNmjATZdCSbmkNVAj/?=
 =?us-ascii?Q?lLPjCoUPkOBaMhFEbchve5KfCY6F+pmPaf3fVLiD0bXKurqx4+p1EeLedGQf?=
 =?us-ascii?Q?ypYIZEsrEXQctFoUKEid78eYDXtq7Dl+O/wyqI8Bm+n2W9wtgg18jDw6MP5k?=
 =?us-ascii?Q?LWOwf1kZuSCRApwzZeU85eMnzdasdDgnqmp3wwQ4Az4ZHPD/UqB7z/0EkOtn?=
 =?us-ascii?Q?9Qy9uY7VdVORmV/Oymi4XT5zcGZbnD+FOcBMlBES6SN6wVfyKmzxdLrm3M1r?=
 =?us-ascii?Q?4BggO4gVnZ/9dkyKGZr+6xaLRDPuEEnuwdpahD5i7lj6/KRw90s3MZoUrU1g?=
 =?us-ascii?Q?LyZDUBwy+2oWzWwlfROPBP44ZnMXjebINRCqvMOkouC60FVDOoDV+322xHjk?=
 =?us-ascii?Q?rHxzMInw0zeSsc1sziuAtmBff5W66pxSUcKD6LkiQpw3fL523VXL3qduphMq?=
 =?us-ascii?Q?MoNxnbis4lvaXo43SdKEc1gIw1Yw/JzYVnPHzuGNT6N7Gga561mnQnKBIl0h?=
 =?us-ascii?Q?SurCa8wn/0OdZr3qLZGYPmjpRAjmEzyO0BG9J48DfbmBzl+ERsX0R0pm8HPt?=
 =?us-ascii?Q?QCTfPqzKjdxF3Bkaf0FnqflaelYLVJtCk8OA7Uog53DuPF0Ge/Hj02fzP00S?=
 =?us-ascii?Q?NZwYCZSpGV9hpht6hiVhMSO+YpYh3g9yvpDYFNpWLUvOJODFvLVhmDHw09VD?=
 =?us-ascii?Q?ItmA1v0LN5qrBxOOLyC2LgeNX6aCeMgh2Ondw0vQIs4MYixu1M9sxyDEWkVG?=
 =?us-ascii?Q?GBiruxNWJ/O3NWbvrZMMzVjq4wMJjE3ryswr74NE2oAJwLufyUlLcInVvRPu?=
 =?us-ascii?Q?Fnqm9uHHhACcLpND5OvqFS9MAHPISfUS5gUPdjAQSOd1EDsMaRxVZLJ6hiG9?=
 =?us-ascii?Q?d+x5PDJtTNbVXi0ZTBnOMC9RZay7kj1csLe+d6QoMHA5QC7Q9W8o2DBOfwvF?=
 =?us-ascii?Q?k9loykIdZjr+5v3RWJQYH6LFvZdE0ZC2lmGKtAiM2EWnNV/B06TB4uN6r5is?=
 =?us-ascii?Q?8/juRD+xX1BIwZBbG8yFK5OsBGEWXSaMew+sRgGgB9hzmMuyh7QrCsjt+6Rv?=
 =?us-ascii?Q?CGygECQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r1Fq7Dy4VNGB+AaOJxIu4U/HIb/K9KoV50HKMvJbfJOd6IHRTn5wp0egLMcv?=
 =?us-ascii?Q?wQ1R+o3EWyBo+FDfjx/6dlTR0+VjMKI9R6ToPQMuu3abydS+mG5ZiG+8EE/O?=
 =?us-ascii?Q?azEWsxmfmHRZWVo/bJQ2u/ZREE36ODiX9aXMHpprwT3TwTRrEy3ubDu7kn+s?=
 =?us-ascii?Q?/G9sj0xik+YEM5tuXQvOA5QLWZRMnK/x+TOESsA8VpA22/O9wDNforzVP9tx?=
 =?us-ascii?Q?AQhq09g2RL68AyGps2K7Wz5CJqKtlxoepiS2NWSHSGLCxH4k5BmtC5HRajKX?=
 =?us-ascii?Q?6zL9C4frZZLxYBNFz1HcExKLi6CNHafi7DGmivGnp//pWUkZDviJ5e1EsHMP?=
 =?us-ascii?Q?X5Wvc1NcTYhI0RR2wwXFazxNJ1nu6itTGuYGem7l18QjhYY99EWshcKAZNOt?=
 =?us-ascii?Q?hXCu4HpvXHzIw0pAo2uEbw3tfxHMxCEXekDdBy5RIoFgffMgEB+QLLb6vbS9?=
 =?us-ascii?Q?fx33HB6MbeZk2LRq1CMXjsnb35FuFCF/rsA6Xz1vytmLcdCD3dCGfpOd+6YG?=
 =?us-ascii?Q?zUgwOxu1MM5dkjoWqRruY9I99QjzH3hXvsfWihLZzspoYoQYcbBCkQqEpqzb?=
 =?us-ascii?Q?5oiaZMIcAzF+tyvkjY8ft324IQ7p4TiQn2IWqRqTTwIGrKD3DJ0GMF9fo0em?=
 =?us-ascii?Q?u3KW6HbSIn9i9V5N7e12CAhTCBiOprabpunsM1YWgO5mWnGGlqPje5LgoGtc?=
 =?us-ascii?Q?PtbnX+mK6xrn1vLHETok3EJEACxupt9EAKiAX1x7/FM22vZdkrS9vUWwWIAj?=
 =?us-ascii?Q?zDh4HrgOusqOprGuJNy+WZyiw5BjiBNCIVPcrE2LCP1BWZKORJUfsR9VP41o?=
 =?us-ascii?Q?G8aDkaFdgZcLmfTF8jiVGKm9n6C0140ofqGXXA5aVtBS42/M49b5ZgdOJO1t?=
 =?us-ascii?Q?W5lbhxWE7A8SbZV+zXLKa1Ipcs4mXu/9RgmeE+JXfGazHPQrfIymNiuLzOsu?=
 =?us-ascii?Q?CdXWQ4Io9aR3kRjjHgC2hax6R53asd0OjU6mUNLu0fUHOmtbln4fd0t+xGCF?=
 =?us-ascii?Q?kxEKMDPsAAaXbI9Q8jb/+ZfX2aI9ZXN5pPXqvWdlDEHi29uOXQN6q2r2qSdC?=
 =?us-ascii?Q?p2dGLw7cSNZvvvv9cCCaAsIJP8ZfdHwDJ0PqWMcpJUVy4L27zRPlvWe34qD3?=
 =?us-ascii?Q?nKhrkXbtnCpDxfyhzfoRiUxpgupOxefLwpwfNm0Zaa9K6dmIvVs14dHZX1qp?=
 =?us-ascii?Q?tCZGaRn6W4QuM2pnQSqMhjRG+/TcDj4l/faI+aDGrwqLufq2bL1tug6DPUax?=
 =?us-ascii?Q?kNYZp89sb6VP3dK46G0ZYdY2w4dqtYDKs117J/XRALbIUYfxXXcGAC4ze2JS?=
 =?us-ascii?Q?pTlPnaFIRqcWfe9k3/Wi71gwgAXoy0W0epeO0quA4eIqCsvMmnular3HG3VR?=
 =?us-ascii?Q?1H1U3T3lm+3SZWocqjjRRph9DXAxD5rfcWq65jH88lweQbzGd5715pPyogcs?=
 =?us-ascii?Q?IIQsTzc2loxhzK5syrS9gf75nQxeRs5kzxW8swVVN6iA62I9zNRPrfVws9cy?=
 =?us-ascii?Q?l1dPAMP0vIfy3n0htdcPX7ra9odCKgxqzwzCvSbMzID4cjJAb8uncFTwq3gx?=
 =?us-ascii?Q?ulZl0hysqsXcXWBbOlI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c6407f-3ee9-4ce5-309a-08dcf5671863
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 02:37:11.8890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9pYEJvL3ys8Sx7fmEvVzJ70q6CWMz+gEH3AZbN7uu2TKAD83hlNAKGsM6rtn2U3ECWEF6cq6f8D4iRSd/FLmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7418

> On Thu, Oct 24, 2024 at 02:53:26PM +0800, Wei Fang wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> >
> > There is a situation where num_tx_rings cannot be divided by bdr_int_nu=
m.
> > For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
> > previous logic, this results in two tx_bdr corresponding memories not
> > being allocated, so when sending packets to tx ring 6 or 7, wild pointe=
rs
> > will be accessed. Of course, this issue doesn't exist on LS1028A, becau=
se
> > its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
> > is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
> > that each tx_bdr can be allocated to the corresponding memory.
> >
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > v5: no changes
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index bd725561b8a2..bccbeb1f355c 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -3049,10 +3049,10 @@ static void enetc_int_vector_destroy(struct
> enetc_ndev_priv *priv, int i)
> >  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
> >  {
> >  	struct pci_dev *pdev =3D priv->si->pdev;
> > +	int v_tx_rings, v_remainder;
> >  	int num_stack_tx_queues;
> >  	int first_xdp_tx_ring;
> >  	int i, n, err, nvec;
> > -	int v_tx_rings;
> >
> >  	nvec =3D ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
> >  	/* allocate MSIX for both messaging and Rx/Tx interrupts */
> > @@ -3066,9 +3066,12 @@ int enetc_alloc_msix(struct enetc_ndev_priv
> *priv)
> >
> >  	/* # of tx rings per int vector */
> >  	v_tx_rings =3D priv->num_tx_rings / priv->bdr_int_num;
> > +	v_remainder =3D priv->num_tx_rings % priv->bdr_int_num;
> >
> >  	for (i =3D 0; i < priv->bdr_int_num; i++) {
> > -		err =3D enetc_int_vector_init(priv, i, v_tx_rings);
> > +		int num_tx_rings =3D i < v_remainder ? v_tx_rings + 1 : v_tx_rings;
>=20
> It took me a moment to understand the mechanism through which this
> works, even though I read the intention in the commit message.
>=20
> Do you think this additional comment would help?

Yeah, it does help users understand quickly. I will add this comment.
>=20
> 		/* Distribute the remaining TX rings to the first
> 		 * v_tx_rings interrupt vectors
> 		 */
>=20
> > +
> > +		err =3D enetc_int_vector_init(priv, i, num_tx_rings);
> >  		if (err)
> >  			goto fail;
> >  	}
> > --
> > 2.34.1
> >

