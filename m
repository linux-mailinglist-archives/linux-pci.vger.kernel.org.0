Return-Path: <linux-pci+bounces-14620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B3F9A02C5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 09:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872532891A2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 07:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54689192D9D;
	Wed, 16 Oct 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GAYnILYP"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D20C1BA89B;
	Wed, 16 Oct 2024 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064345; cv=fail; b=Cgl2mKyUiDqJ+Lnrt/cpmO7TUbaalPx02aoeUHuKhOAqDfUDyjrBrbIf+QVCV5XhVhSCDD29oqhkVet0ELirDjQgZ2MTCWGFCajFlXq4cct6Za9N8H1O8bwhZlaJdEX75O3eofpaoEkYG3lvwXx2fN4F5QDugB/ZoKiC0JW4qNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064345; c=relaxed/simple;
	bh=5Deuxt/VkOoRg1BF1rf0pHgR5RQvb9U1lsWDQqpSPkc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VRQegiUkt4eun+mw+nxIqIb/AIV6mwJYZGZ+VkCstTzjjFI2zP6zx0iTo0aVl5GK3HCzmGFWlr9ZTuRXQVuZnnCc7WMDV0oXf42fwrrw9gfKtv77a7dNXWXk/A5qV3qpBMYVUuz9kA46Vw/D206FJyAmEXO3nPF6uRVfRJhUIYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GAYnILYP; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcxyiMMAo8bAES7QRzXhAyJ4p+GZ5DarbGS3x/P1L+9F1jHivfUngMZsAiYnM79FQ2qNNMSZSnDPevAHGOwV5IUq8ofQryiEMmOLHbwQ67mmK9wktkhkraJkocMi59PjNoVgGicvnskn1csv9NM9kexvw+J2K0w3/hd0JSKrkqxxFQMALUvuSsQLaMvNVWnfbFHp1piJkP7aCXfzEHYUGGcUm31PI+0X4ZJJT0Ztp14Dqx4isSH0mqQopReOz64cwLSM/osiBppP5ezbg/x17gefxzVSyYZ9U/Kt+uPmS4FYdqwOGf/LAOokHqmnQHoQqOpNteRIsKLD7uDCapWOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIm4QckzCbMK6nds/4rD63cLypdMFKlTwTgSScW6tfc=;
 b=Drbcd410YyuLp0KXiVgFh5cM+yr9X2XF3Yn8OE69MHKTnq8MntshsKJCsFD+94Uo8WVe1I/9+YCazaf2oqBG+YEEoOPoITmQoHDxIfChZzVdUhzyx5e9HPejfj7R3IX9I1kQYHSJsRGbarcF7Yswv/gzceBJ7zbvIrg4Chi2/1bBqaDpA30wESNYiEbrz/8JUgdtIT9AgLo8rCIoWPOFogu80IJb9u0BOpuz8kGXCb8gZ+75RijTA5/mpf+q2hduKD1neLGzNbB5scJyUHfLSDJYdS9s9OVdFU7kHXF/pdAgXjP72jOW7aCOOQ2cCsHbj+LxTfLY7NpT7L9eyhNSqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIm4QckzCbMK6nds/4rD63cLypdMFKlTwTgSScW6tfc=;
 b=GAYnILYPvkmejDVIQ4aX8iHfcUFtzxeOo2mDNcWtxVJsxnbtJzYZa5YVmBp3obWImd1HufKFYIynPIIDqyabuOO0E1NUjwkYeyINQ3HPLPT//TO9llSWkL1cGmtNaMCyn6dCY8Su38FpFBn9h7AX4CT+IE7TuFm1YpjJbF81IyMioNowrpfyWS3XfTZWHOCYvUOnnvWrg4PfOMa2mCaB1Uu+Rf7sTuy6Vh7JtxdgyiMrunUtuc8UHIFHCNAAqv5sYuP4TWax8XGTCotypmrnOSeQRd2kiPHUaGDtn1Cs3lCeoLKbgpAMf83fTPJ7rzV/7LfsR6E02f86rtTywDf9pQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB9102.eurprd04.prod.outlook.com (2603:10a6:150:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Wed, 16 Oct
 2024 07:38:59 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 07:38:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Topic: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Index: AQHbHwQq4QKqZMQ9p0KkBhFIskuic7KI/D2AgAABGCA=
Date: Wed, 16 Oct 2024 07:38:58 +0000
Message-ID:
 <PAXPR04MB8510FEE221C7B3B9FDB0801188462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-11-wei.fang@nxp.com>
 <20241016072929.GD2162@kernel.org>
In-Reply-To: <20241016072929.GD2162@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB9102:EE_
x-ms-office365-filtering-correlation-id: 6212c280-ba16-4978-00b9-08dcedb598e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xS+svd4jRK3RM81/P62/1/PR6+5D7XksA3yWjxBmLdsMmjb+Lv84uhBsY2lq?=
 =?us-ascii?Q?vQeCS1jdpZSWFTRt+wcaH9I0mPXQGadsgfh47guI1zQ3Y7ri43xont368XDs?=
 =?us-ascii?Q?C8Gx0woTRr3EUfNFplHxZWOgCVua4ocE4hgWkrc5I8hli2iDfoZCIi7Ynp7m?=
 =?us-ascii?Q?4E6/dnzrKD2abc1q9tISY5XnCFIe48NHpYIiQbjXQJqgEyej/4HPQTkQt89K?=
 =?us-ascii?Q?tpfzqhRYM1/rjaKcv11Aa8QEncg5W8TwzYGjp438AF33kkYHhJ3L8DGx19D4?=
 =?us-ascii?Q?KHTDTD26mdrH5dPZG7XM9Ll+9QZ7/EStHTDIpLWVYcV+Lj6EjqXS/MSFyXY/?=
 =?us-ascii?Q?lNdCh67Uc+KJGRfzliDujamY2iCAOqHOt2fSL13uGfYr9h3vKp4gt4YdFJ58?=
 =?us-ascii?Q?HIAgY2Pr/OAAicZ1XlczBeS6Dr7SdJ+hKku6sXz/wdTWOSySYhoqm0AH63jz?=
 =?us-ascii?Q?us/Z1cnP3TwDN35+1h/K+A5oig12N6ANrlYn9QYzTrompBxAHv+rKVXQUC7h?=
 =?us-ascii?Q?mXAVthhuLGISRaIpMNKEflZwA8zE09oHqWke5HGKJ58TBxI91KpT4ah8RFPl?=
 =?us-ascii?Q?p41VXeNWl6MiSBD/CKHDzTau1SmDJTlr76sOUMQvbjMXd0T/83qfHIKvntR0?=
 =?us-ascii?Q?x0oIR6QkzDynWKFuZYNT7YLeDKKXFCQYkSwkWTeNVoylb7xGGrB+9pJNyXWU?=
 =?us-ascii?Q?4kcaVvYn6ncqhBySRgk1t8cjqamIhKpPukOepRP7k/pQk2PZsukoeNa9rZ4e?=
 =?us-ascii?Q?gOMiNZQ0DLyD8+LqB7rV0I033xHvG7X3/KW6MncDhcvNN75ESAU1o3NbNxAe?=
 =?us-ascii?Q?5waC0ZC0HyQpGKBr6av9hEJsKCo3O1EY4BT69MCotAbqzjzk0FBTgOCyIiTt?=
 =?us-ascii?Q?lNn1gFu06VQEqUAmp2VZUuLn3nUrBmz7f2Qa4eoAypGAlG0+hjOuCyKxnnxA?=
 =?us-ascii?Q?HJ1y20cj9RAJt1CPWv8X1A1H8j5byvn64P8NDOkFmh+vCxrBjy7q23NwZl9n?=
 =?us-ascii?Q?6GELX/hwlMbqXXqPBz/idQ2Z0ywNtMaewrisiVb80MyhyZ3eFZ31wVm3aZVK?=
 =?us-ascii?Q?Dw9xxGe438lOoRLxuXVJareb7RxJsBfcogTRMGgTZvza/rSfqBIG3C2L68rk?=
 =?us-ascii?Q?JFL3DxdM4tCYCPU/gAisMEojH32BKLN2NNuO3iW3ACNW9k4uRtyT7Yhhivl3?=
 =?us-ascii?Q?Ly7+8bEnkRttfD5JzHMKXYuLpFi+28y1tc+xbBhlsK4KIUsossK+5XI6vcj9?=
 =?us-ascii?Q?4ZL2bGbP06cJ7nWHzL+hN/rOJvt795nh+INdqSY7DyJK2mwK/Hod9k2TB+0a?=
 =?us-ascii?Q?Un4Ul7B2Alv6VzGc1IJCi+YQsa6gI0QrQEXHWxoU5LCBGA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?79z5fp39BzhhaS8H012+fpF73a/sZxTTe3lG6g0dFZuayjtUyiWiScC/EGjB?=
 =?us-ascii?Q?WxeUW2eDMOQcGlyfgrzuhi1RgUrliIBaHGn0nyoqahyArslIOvdwMtgLI82e?=
 =?us-ascii?Q?nwZNV5dD0obPKlfAWPKgoBNFKnde9dMr9nyoLMmi3TE09UApfcPfQOnL/mB9?=
 =?us-ascii?Q?aufWQcKBYwOQlGsygrXvJkADSXzzy2nuGH8KTbCcUkuPOtniDc6WWdSDE6xe?=
 =?us-ascii?Q?C6yymVIUlhKfeHGFRpvoZZpVGYiVncya2PpkPusaXSHbBdxhT8/KBaGsOBkL?=
 =?us-ascii?Q?+H5rp3lsWLbzy6BrOdZukpx2HhNoP3pu86iIm1pP21SKe74j0Q8qsxCTWxLh?=
 =?us-ascii?Q?ddk17QpVQSACMAw2uSsqFMpsI52pNUMKWcVtb5I0djNftFN6QpUwRPL5XvIk?=
 =?us-ascii?Q?1UW2apY+74bOq72VfLVr67sDhe3sDuLyJ5DV5zcIBCdGA70mUmxb53Ae1gb4?=
 =?us-ascii?Q?j2rvRv9rzqmEx3MP9eGKooYZsoALG4h0KR8DNj/MOUWSwESbCfsn/9/tvXgC?=
 =?us-ascii?Q?ARmulYnjoVq2NDw+gyC4Hh2tl9CeYZ34B6W25y7mCg4W5RJWMGJN23ur90LL?=
 =?us-ascii?Q?IMRsoqPqmeLPD7ZS1OP6N1JFjp2Lcqo9EESovT+uPdpdTuEFp8NnJRXLDRvs?=
 =?us-ascii?Q?NJZ+Pq7mESi+HpS2W6HYd011r424e8dV0vdbGYqawepksr5S6q/gg32fYErP?=
 =?us-ascii?Q?Ay8tDzdhZMJBzAuvMoJ6c4cddQM0qnXy5clURm5mIPI1YD/0byQDg1evPvv6?=
 =?us-ascii?Q?aYSvUO/aUGO96p1wXgAuNS5jmDoWC1RB8NzGuyQ5cpWG0PdUHY9puoo3782G?=
 =?us-ascii?Q?VvFfcWWMVKVbNffm0hPbri8O+0r/xw+gYi7ZGW3amY7Q/2wRtipFyN26Nz7C?=
 =?us-ascii?Q?oYa+a0wVJFFgn7s773PhuVhlrLk/ng2cAwbHm2Xps7R51p7+fr9RwaQl4ZOM?=
 =?us-ascii?Q?oCmoeoGKv2BAE+Dqvqp2a9Vh3ZX5gu20OiN4aufL6JZsLJOPaHaCsGdTkx3t?=
 =?us-ascii?Q?2xRD8WuFW4qMVzmRmgi6H4Kd0wjmAJGO5wQEo+tbpgBTlQzyAbGsGA2SV1eL?=
 =?us-ascii?Q?TRSROju5SoIOhapMRJYdLQ/uncFGT+DLjgHA2Eb4dWDEWUwgZp7IWbV7yqsA?=
 =?us-ascii?Q?xvbZ7lsDV6X+l6GZbXcwjGxs0LvaT9P+17KJ8oJnazv9HnNO1o6sfiiT+tKv?=
 =?us-ascii?Q?53wmjMKLnZALpianZYF33MKF3xlK7+KYVE4jXXXQ9swYw0m4Ibv/e0FEix62?=
 =?us-ascii?Q?ZfkyGgtK09b3FVkEQ8r+WxJjQv4x3RMZnWI+JF4Ql8xJPbm256Hu6ttoOzDe?=
 =?us-ascii?Q?fqaiazwiU8/e4IxEIh8iPmxvRi4vV7D5TPEfmOfZEj42SM6YvYm+TYrx4WjA?=
 =?us-ascii?Q?57n96i3ehNJCeXexA54RnTT8owFN7gRoLaOksMIHcylWOXs2Y0lK4Nb6Iwt5?=
 =?us-ascii?Q?KXVW/OoTKz+mGVUghffagbvSyzMMgUa9b/na9bd5AjfqHJFAMU6w3Vk06MtM?=
 =?us-ascii?Q?GwL+kXbXBfrN7maEcehrXFSwXLAqFj99W7+GnduR9MKkqjd+et7olEr2U0jD?=
 =?us-ascii?Q?5OuFNYPP7n/uovO2nsI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6212c280-ba16-4978-00b9-08dcedb598e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 07:38:58.9234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utqoiHexh76q20d3M+ctrOgzwmE/oGFTSt1zCjVgkpn3qrugsAyUebJUV+ID6aE46hUs33zKKPaEURF/kiQYsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9102

>=20
> On Tue, Oct 15, 2024 at 08:58:38PM +0800, Wei Fang wrote:
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 174 +++++++++----------
> >  1 file changed, 87 insertions(+), 87 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 032d8eadd003..d36af3f8ba31 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct
> ifreq *rq, int cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_ioctl);
> >
> > +static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
> > +				 int v_tx_rings)
> > +{
> > +	struct enetc_int_vector *v __free(kfree);
> > +	struct enetc_bdr *bdr;
> > +	int j, err;
> > +
> > +	v =3D kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> > +	if (!v)
> > +		return -ENOMEM;
>=20
> ...
>=20
> >  int enetc_alloc_msix(struct enetc_ndev_priv *priv)
> >  {
> >  	struct pci_dev *pdev =3D priv->si->pdev;
>=20
> ...
>=20
> > @@ -2986,64 +3067,9 @@ int enetc_alloc_msix(struct enetc_ndev_priv
> *priv)
> >  	/* # of tx rings per int vector */
> >  	v_tx_rings =3D priv->num_tx_rings / priv->bdr_int_num;
> >
> > -	for (i =3D 0; i < priv->bdr_int_num; i++) {
> > -		struct enetc_int_vector *v;
> > -		struct enetc_bdr *bdr;
> > -		int j;
> > -
> > -		v =3D kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
> > -		if (!v) {
> > -			err =3D -ENOMEM;
> > +	for (i =3D 0; i < priv->bdr_int_num; i++)
> > +		if (enetc_int_vector_init(priv, i, v_tx_rings))
> >  			goto fail;
>=20
> Hi Wei Fang,
>=20
> It looks like, if we reach this error handling during the first iteration
> of the for loop then err, which will be return value returned by the func=
tion,
> is ininitialised. Perhaps this would be better expressed as follows?
> (Completely untested!)
>=20
> 		err =3D enetc_int_vector_init(priv, i, v_tx_rings);
> 		if (err)
> 			goto fail;
>=20
> Flagged by Smatch.
>=20

Thanks, you are correct, I will fix it.


