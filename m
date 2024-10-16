Return-Path: <linux-pci+bounces-14613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E49289A00CC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 07:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FA81C20E84
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 05:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF56521E3A4;
	Wed, 16 Oct 2024 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JgdP6SHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64E24879B;
	Wed, 16 Oct 2024 05:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729056873; cv=fail; b=jhh0TEeJiQEwp2JztsDSFkOcQajKIY4oomKFySieSHkk1kbYGKkahwjXYHq7ox6C3O2P+jK66L+kxjxMqBcHQjaDgwuKdxWAvC2D3g8llu1EKAELlwMSKfND+5hZ44WG/77+wmq+njLYNYDPZgvXCDSJktJk9QQeUF04aDCrcRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729056873; c=relaxed/simple;
	bh=Sg5kS/2YibllHSmWklLty3qaFwKbf6LOqcOs2FbstNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iQ8Q28dIs62jAMUV3cClVWpmpkeN9Mwa7yoT6Sn8ruPyzGkKleRp5bmUKQhnrnR0HoYzKRVEuAH/GmgxkCWE9GfrhNrl8D0N8MwMBKceYQvSmTPNatXxP8fE81URDbEoUxyj0nLZmiIvcxY5ZjnB3jl4SgwXbYM9YY0lzpEusXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JgdP6SHZ; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HB9CepNf7HmWx3MjBnRLvQb8LY5bO9fsGI/iXslpqkAstzqUp+Sw6+W26t3qvw8aIpUdGhQ7Y+X8lP1y4K2Zt8CVkmg+4Af1oOMXDMs15wMoHLEHcObSEWUSI/Go47L9RmP7+YoBFE4OXlFdNsitgT0pM5x+6/i+edAz7zQHlEfQ6QLVoJd1uZxe7Il6Rff3COcT5ZG9VayKTiXyG0dt6pke9AwxoP03U2fZ9goiSJNzvAYD6DdQEEV7axANBdLstyCYWNAgfvO5SVzEGAMeE0028dt8VrR1alcBpiDUSXcb/hxN3RC4FPQjNsF19P9lO0jCzT4MLKwQXNutq2Etgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4875Dcqburel4E8aa5VNeMYb7QiCQsvhEzEFTTjpYY=;
 b=alAKwXb5QQv/ZR5+Y8nLqx2cS1MGUBkrO7aerzYDgBl3+R/eHFiA6jFpAO+TVTfCr+x5my8K1LQfuIbJXac+SWzOWSoZDVvbkvo6FmlOYZptAef8tVS71pLEWVs+iYhJGpCfpFD2hWBtA0OxIN7gp8vDFn6Cgm82zfe8BGPRhmbAxvn+qpcXXKVtrr7mA/Y41I9dSCUOFj/UPcjb+HohmiGjwdnVvMUUlv9uL24ZNXyIFkrv8L58VX5nfjsq7yuXoBWLBxWKJHt3VOZZLm6D7RX0+RbR551jFHmVqL3Yy0tiS3862QqgsBvyAbSSfhHNCNvnDCjD+GBZrSTAd3DirQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4875Dcqburel4E8aa5VNeMYb7QiCQsvhEzEFTTjpYY=;
 b=JgdP6SHZ0MhT5Fxz1DS3OfqLtuZAp1xKUbFoP/H5N2/EHqq/oa/lRcafDSP2GpKgOIziVrxRXfjgUE+MKFv4/YjVRqaTv6i7TdWHGOllpbfCOLAcX+GW5b54EHvUfyG8Z1qujJRvbgfbPNg4EAmtPfdA1o/8zII4hdzYqDH2ehq1pYvW8uks2Y0kYy+r3V5ligKPPlgr0QoyK52F59gbmwOF3NT3CGFD7+J/gqaXajdHRd+mpeGA5q6PEbNbVMLmxV65HUH9GkpQ0uy+kYELWzWEjz+oYzzhCVRhQRE/Kqqvl8w2Awt40GUGaaPKBToaWrNpO+YRAMaG3dbd+84zTg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8649.eurprd04.prod.outlook.com (2603:10a6:20b:43c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 05:34:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 05:34:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank
 Li <frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Topic: [PATCH v2 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Index: AQHbHwQq4QKqZMQ9p0KkBhFIskuic7KIAf2AgADZjoA=
Date: Wed, 16 Oct 2024 05:34:27 +0000
Message-ID:
 <PAXPR04MB8510849CE992DD0F5F3E848488462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-11-wei.fang@nxp.com>
 <AS8PR04MB88494082BF14B480936F6DA996452@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB88494082BF14B480936F6DA996452@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8649:EE_
x-ms-office365-filtering-correlation-id: 5fab7c33-68de-4dc3-1fb6-08dceda433e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0SxoJcHvh1qRPSnrzFb2NlPnZGtelzvJnjxsRo2Z8ReoHlLZGKzJKnaOf1nZ?=
 =?us-ascii?Q?N9/Jn6oNgtNNwRv+SImWqLHCIykrG94bM8fbIpf/tDPbeDALptLF/BAoIHXp?=
 =?us-ascii?Q?w3SKEXu2YVUu1YSmCD3nzDz8zy37OB1QFyQEScFiV6XUypmxG+DUwWfuQgPG?=
 =?us-ascii?Q?0bRcSiIEtJG+XfICdUOcjGU5UakQFB/aE1JLCwyYcIGeoIL8vvsl+0OtzByh?=
 =?us-ascii?Q?Ql6ImK9ZKcJPFpDA/zmDEBzdBEA3L4QTwIRecXZc21yZetZ1IuYtaXRoqqSf?=
 =?us-ascii?Q?0CCr12g/q+YwWnbW2/Re0pdWrLpN8FtLBXFRYk9uywHLNqYF5/ZtbZVwwkXJ?=
 =?us-ascii?Q?7glUpnn5Ru0fAZIJgSmjg0xlNDRIu3iz9CQdVrZ5F5DhMceKsldankZf5BEv?=
 =?us-ascii?Q?vUE4sIGr5fc4JoBduMNJVygifSll0pLf68OLkje8Kp2KWF6PM0sdttw2aFqY?=
 =?us-ascii?Q?jsm3WObngCP36eFWQdA4ZNLUSThi2bykUGNF8ec4GqN90jmT8W5+xpgeH4Ds?=
 =?us-ascii?Q?WRgpf+mOqjg9BxOCj3kSTaXdy8bTI1fjiMDVJ10hKrtzuP++cZVwH1IV2mgp?=
 =?us-ascii?Q?hR2Ge5c9mx9IPZH8NzF3t68OeCaS1EyoLWnPoLLqEFhS9rprIQQ8RwE35GO6?=
 =?us-ascii?Q?/yAyzWI4kswhbjOrTg5zCQH9EBWq9cLB3mI1J//TA86iHMRhHvGxS1Ck/v4I?=
 =?us-ascii?Q?sK1exW7QMySkZf9y3fSHVm7P79nFPAU1FtXdHMo+zNWFe+y4DLHRL1P8TE84?=
 =?us-ascii?Q?BKucQSWskhN6nUMHBqrR6QDUVqnWb2a9aRQQ6ALMKzibpbThJHpysyyxFzrO?=
 =?us-ascii?Q?gN/RHwRqo1QytLyw+SzbFh1H5+mDSYY+GjEvL4D+D9k3rSRRbvgqrMRwlPVZ?=
 =?us-ascii?Q?MCjwcE4wN+4izgTN8kjbpFjPggrv1sCUFW9e+sySLyW1cgxp9XNx9JYSPD3D?=
 =?us-ascii?Q?v5AnXT8ICPtPOCpPbpTehszGZ7F+JNt3CbVinCLkmzhMEryzU9HNDojavH8d?=
 =?us-ascii?Q?kgwT2EqBGrJ+H6mOf8BDpBydaWo2vbRJp7ixn8956wDUZnFk4ZYidQQWZjIo?=
 =?us-ascii?Q?d9tLZ41JyZKX6EkEFJpAGyOXWUHpf62G7h1y0xtBt3GKSVkbHaSS/e4C8rqx?=
 =?us-ascii?Q?/zUJ85eaKPrMJUQefCYMkgpnbRX/wck3y7my0Gwom2mYUBphEVvdIvQ/clqs?=
 =?us-ascii?Q?1pW7f6onJH6Sj4/bw5VQQhga2L8SZPduZqZdhY+0N/V+qESG+3lH1Eew/kGJ?=
 =?us-ascii?Q?eCbzct2257YQq7+gMjmw8OSvTwdE30YWaZK5mIOKi1dMlIZuKdgfnuJL++Rf?=
 =?us-ascii?Q?bPiP1iAp1bKL6D0kBiXEWEYzRGSCod4vesw4P8tpTdi097fJ6KdboJWaPB3p?=
 =?us-ascii?Q?v8ngw4I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ywziS0OxcQ+ehnUr2KQeHRLw1fuXi1Kl9S7y+xFOrPu/sh3xbH59Vm0zx8S3?=
 =?us-ascii?Q?FwA7EKoDQVpCjws+NQ1LQvrWeULj/YxpGECduo4UBYYIB61sFaKlvD51/JpV?=
 =?us-ascii?Q?SPrNRN75TiRc3cDZjNUplAflScJEOL+iJCaOUhjce4/GuV0Z7pN9pezV3vxf?=
 =?us-ascii?Q?CRveZ1kjKnVmZ7JluwoGgQwkq36pbl5hLSxtPnFr44dIxuSP2FwZD02ReSsH?=
 =?us-ascii?Q?HRlO/IxURO65HU9jA+p+admLX+UYILxN42fP85dhPwj1bQLa9TvhBiIhh4E3?=
 =?us-ascii?Q?3pUSQKze2AtiNk9nKWdBf1YkyMtidq1KLkBWVdQzhdXaShomijZBRou0TsGX?=
 =?us-ascii?Q?foQNoXzupM2s+swdMCqM+OS6PGpOSgTemWUuMVqMO/oxIdGvF6wnuXAz2mus?=
 =?us-ascii?Q?cxGVfMACdWATXHtFAbpZmxzg6oAAVosA83EFyWaD78Xu9p3UXlLdR3/VGJRw?=
 =?us-ascii?Q?XDqpuNgUgrhGj7lmmeXaVCpO0V1k+T4ZUQOgQ3HVwb3pmJhP1CW/jzaS5M/V?=
 =?us-ascii?Q?0A79ut7fswtjxKUJ5doUj06tArvAVpcCrram6oN/OI16WbZfyQm6JM+HSE69?=
 =?us-ascii?Q?wbke311qdC7hb31oqmVToNacUNoafw7ynO4najlSjMkID30X5PQIOZ8FFHbB?=
 =?us-ascii?Q?/FdcDwIYBzJg+vCIbAEiSTLDoYOfueLUN0KmG68bFv+ek58gOQeY/G8rHz9P?=
 =?us-ascii?Q?9ViAT71M0XYmH+jmF52M3Pd/i5nZz+eze04kFQEYVrbfg8wk/9oBgVAViY6k?=
 =?us-ascii?Q?vgvpkCrrdkfMGgYHML40hUsG9pY0cKlfelblsntxtfHMl1YPEHfQR8DXzkTj?=
 =?us-ascii?Q?lbnwYiXUqTOs06CoOdWEaO6RIUksZ9kSdi4lL8ur+RmA6RjVG/x0dwQnqBcX?=
 =?us-ascii?Q?4DHHbKJgbBtCUiPMEvRTOSRDW/WM8EePUlHJAwaabRGGfYRa43gs0H/32XA+?=
 =?us-ascii?Q?FqsE4swbD2jYiD9FURwauXwVCqL34xXRoFWUfUvDL4Fk3q3U2gqXGaAHqzrr?=
 =?us-ascii?Q?rptTZHuUH4rfRC+Bk3UJnHVHgUR05j5KJ0s2nuU0duYJ87DULlk39Idgnmnj?=
 =?us-ascii?Q?8zCtbAWKFe4MvrvH/a7CDRofS+pYb/soQWiNIsuQ2cXQRYShpSblwpuZF1Ao?=
 =?us-ascii?Q?i5HcbGSisW+PpD1QBam3rNeMP4lQi14xcJLdbjZ3NOkIjLHNPiI/cXEJS8d7?=
 =?us-ascii?Q?D3C1mQl9FcBa1nw54kOIMHMpB3Q0oFePcEE1m6aELAb7ZCZUad+kKbD+42Ly?=
 =?us-ascii?Q?QwHlBqH6VhqjaQn5LWkxPrOr9V2l8KJ6gZeQhx5IvicqgIBU7V0+ufObkyi4?=
 =?us-ascii?Q?lQ/+dAxAtgYkcuX6n+Rbk33zy0wskCSNKiABmEB7G6h//Ln3QvgWMZLwp+2M?=
 =?us-ascii?Q?WL6ZLcKUf7zceF5Bx66rmC2C4WygO57KBMC5nq88yFgBFC36cgdDDvGJi9Ee?=
 =?us-ascii?Q?z4IKQgS6b9Vt7rV+Z7/c9xM28DxlsPO9/tlPH6b9qTvolwySm7kHTG2qFNDs?=
 =?us-ascii?Q?jpKWYoYGmu0/VvVU1RwZ8YFyFo/O5YAqzI/Lg4nwDmRhfYfKj7BqZOSZa5Hb?=
 =?us-ascii?Q?jCUbkAx5xGq5VVIo6yQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fab7c33-68de-4dc3-1fb6-08dceda433e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 05:34:28.0707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWYGrhDSvslhv9VzkN9GyVkdW8ikPpD5TNGSX9KEO6+aU1HinadUhqk0Swd12IhpfPJHASYaCclQuNd0nZjrbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8649

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
> > +
> > +	bdr =3D &v->rx_ring;
> > +	bdr->index =3D i;
> > +	bdr->ndev =3D priv->ndev;
> > +	bdr->dev =3D priv->dev;
> > +	bdr->bd_count =3D priv->rx_bd_count;
> > +	bdr->buffer_offset =3D ENETC_RXB_PAD;
> > +	priv->rx_ring[i] =3D bdr;
> > +
> > +	err =3D xdp_rxq_info_reg(&bdr->xdp.rxq, priv->ndev, i, 0);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D xdp_rxq_info_reg_mem_model(&bdr->xdp.rxq,
> > +					 MEM_TYPE_PAGE_SHARED, NULL);
> > +	if (err) {
> > +		xdp_rxq_info_unreg(&bdr->xdp.rxq);
> > +		return err;
> > +	}
> > +
> > +	/* init defaults for adaptive IC */
> > +	if (priv->ic_mode & ENETC_IC_RX_ADAPTIVE) {
> > +		v->rx_ictt =3D 0x1;
> > +		v->rx_dim_en =3D true;
> > +	}
> > +
> > +	INIT_WORK(&v->rx_dim.work, enetc_rx_dim_work);
> > +	netif_napi_add(priv->ndev, &v->napi, enetc_poll);
> > +	v->count_tx_rings =3D v_tx_rings;
> > +
> > +	for (j =3D 0; j < v_tx_rings; j++) {
> > +		int idx;
> > +
> > +		/* default tx ring mapping policy */
> > +		idx =3D priv->bdr_int_num * j + i;
> > +		__set_bit(idx, &v->tx_rings_map);
> > +		bdr =3D &v->tx_ring[j];
> > +		bdr->index =3D idx;
> > +		bdr->ndev =3D priv->ndev;
> > +		bdr->dev =3D priv->dev;
> > +		bdr->bd_count =3D priv->tx_bd_count;
> > +		priv->tx_ring[idx] =3D bdr;
> > +	}
> > +
> > +	priv->int_vector[i] =3D no_free_ptr(v);
>=20
> This is new, and looks like it's a fix on its own. It's fixing a dangling=
 reference in
> int_vectror[i],
> if I'm not wrong.

This is slightly different from the original code, using cleanup to manage
dynamically allocated memory resources.

>=20
> Other than that, like for the original patch:
> Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>


