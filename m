Return-Path: <linux-pci+bounces-15259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E7F9AF7DB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 05:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B1D283011
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33B18B473;
	Fri, 25 Oct 2024 03:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBCVeHlg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD617C210;
	Fri, 25 Oct 2024 03:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825487; cv=fail; b=mdcXtYm4hS9hp+DwBWwQ90OILxEZY061nBNI9QsY8KKb5Vhxohonf4hciHymXKrSHqTcm+1rFRJJb6FFUtF0xEIpYpHhpKsogRUwmFE3LkH6Yk8VeVBJngm1SzVSI5PFQfrFVvfMBwcfoRf8awU1r5iv8DiLhgmw+8cQ5dRFsLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825487; c=relaxed/simple;
	bh=zaO3XbfAj9Qn/FOxbAbk2GC5GzRb+GUR5XzaU8b9np4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HdiljxhVYXk4IPi1G6S06ismTMaNwu0lOlZMCmNbGM2SQqiqdqvXgyNCmbRaxQ7WwhlIw6tm/TL8FVFSylILfA3vD2oCW4lqhZw0pahDM5YBJsrB5WApJRMhHiKNMoQ3/zr/VG+eP72r7dQyeMcsoKsday1jKYdmKu/v4Jys2x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CBCVeHlg; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTC6OcPMmAovIgagdI88KCuVLP2GGAnz8pxdymPGet5/CQSquTOwD0ZY/OqcLOnyjeJSHfiKZUc3gUCHbv6b/fgDrGoZ8qfE9V0gQ16lwNes09BVhAEXbioE26j/9L0vckn+o367b2WyQw7ed3voe0WwEkYnddXE3Q3Z2xXdl01Zv+8PFvC5CMdHPPFhMRfODx6xKnf+qjuu0E3ZPdkj1k85Vzto4Z0CR39ExIBzBZitGoPnoloEXgxvmfYxtzUxyt9onnq2DQSRyQlKtMGuJ8rln/diNYhYMrOb40kd0AgKdI8MNpRITTvQQJPd9uvAbIuDtMJIJKdXuqGNLoqT7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1UWQ2qcYY7pwU84bjvNwRLycJtX1+kmhQ9oUIF6Zbw=;
 b=KmArkoeXiiPfPsMJMhrl/9oHEmd+xgfrYFb3Awi/YZ2iXlcCuluO6Ek+JWATuLLoCoEUaLXK1S09L2NerPkq2IUFzOFh+N9cHl1OxRI9qYWHBfNCUs07fFanhASWhiZRi6+2sN5Ofx9mPngs+mQroJGzB+ut+rR6WVloIQxmVb6sH95VGaTikD3DvBVt/1m+4b/ar2T36imxP6zYSwxDwEYnAK27XJBW0BY7KbCz+IGnfx1eZfAQ4dFx7K6aFZI7inmk9zjA277UM2QR5elHM9B9NWtK8WAiBjq+mMGNfVLC/Nujo9uABEvF6Z+dmVQy0HT8BLLDtKCERC7iNrfoxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1UWQ2qcYY7pwU84bjvNwRLycJtX1+kmhQ9oUIF6Zbw=;
 b=CBCVeHlgCxs5NLqc25hl9vmQZYQK/Ut5yLa4Mt2gLEvhUZjlC/xtkwl6stN0zh4J3x9id5Mnlm+ghr9fsi+NRfe7t81L6a4rrqIMdqY31cusKQX2DF2uJNRtjR9Ed9sT3F+1iFcqO4Zu91JWtMLRk11BV+zOcwFH6h/68DTtnc11HVgwPr7Ji1r5YYwVi3gEzf1GwjBjg4kjDvtUYy/6AjrWjjElZDXfOS9lzRZRC/0Te3+13nVxI41bHl9j6wTuZ59hcuHc3dvFLuvWCg1JfpfoGr+kEcyvf8dph56wLg30g5hKgVNL90bwCclrfOzgJnGTPuD+O4aWWdrfkZDOFA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6813.eurprd04.prod.outlook.com (2603:10a6:803:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 03:04:41 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 03:04:41 +0000
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
Subject: RE: [PATCH v5 net-next 07/13] net: enetc: remove ERR050089 workaround
 for i.MX95
Thread-Topic: [PATCH v5 net-next 07/13] net: enetc: remove ERR050089
 workaround for i.MX95
Thread-Index: AQHbJeOmRwlBtQxjbEeI4tZF9GsDsrKWLvVsgACaSAA=
Date: Fri, 25 Oct 2024 03:04:41 +0000
Message-ID:
 <PAXPR04MB8510D12DF8886A5ACA865867884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-8-wei.fang@nxp.com>
 <20241024065328.521518-8-wei.fang@nxp.com>
 <20241024175128.7pdwpqr4mlok43cb@skbuf>
In-Reply-To: <20241024175128.7pdwpqr4mlok43cb@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB6813:EE_
x-ms-office365-filtering-correlation-id: c5c889bb-0bb9-497b-cf7d-08dcf4a1c4f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B4S0Yhm37bTbGEceUtyuUzq+vBPvRhzBxl6D7Kz6E63owdhok4egAS/z3d/s?=
 =?us-ascii?Q?KF8wgBQ4lbytg3f2BaCmgi4bTjSEuwgrfCti0A1OdGsyklamc6QhPCCD0D8Z?=
 =?us-ascii?Q?hd0tNkTXqhPljGyP8F14kZiXt9o/bdtn6im8DhVK5AIssptJXph0PhVCz4bP?=
 =?us-ascii?Q?Ho1l9t9MUWVY466tZZSaJ6gsQrBEhTR+NKIkwd0pJxx7c1bDxfp/J44Gn1di?=
 =?us-ascii?Q?Kj0FYeHWVh0lEAJY6I+hLlL1MfVlDMevyCUc7Kf3WlRjjW7Q+Y2PyNzmoq4m?=
 =?us-ascii?Q?j+opiaMaKN4lheOWGbUANFuJQax2eWRIsRFUrnI1wG4RwjzqDcim74TZe2z8?=
 =?us-ascii?Q?k/+wjA2HwEjPanj2CUdry6Xk//cMaKdp+TEFoIEJo9dm0hsixQzEGlsg8yJ0?=
 =?us-ascii?Q?n1cIFt2ylQhoWKXjVsD3Q3KRQXqQZTktwfqnKUTBB9H49SlBlKLlbjsuXEGF?=
 =?us-ascii?Q?StouOJTGXLAp5B88I7cjy2hLbdzbiVhacwM659rAnUw4je/nmufZtrAzvFYV?=
 =?us-ascii?Q?PthMlW13OnbwFhKV3N6cqbAfhk4JLwyR7KLB/4VjNdaQWmujb0T28O6osGDD?=
 =?us-ascii?Q?tbvU+iUO2K+HmNTPOc2gC3L/R+kiPr5fWO3RfLpwwNfJtmpfUvZRy+VujLO1?=
 =?us-ascii?Q?GB62yDnTjI6GkOSiEQG9O9mqeob8LPPzETG4orjgKPg81iIl29odtRVhdyfr?=
 =?us-ascii?Q?16jQc0Z+OEAzYjWcdhJw+pqBeoaYw92r51WBXVBu7qPK08VR3TZQNsziPeXD?=
 =?us-ascii?Q?nrty/2FWKzszddvY/CBAPW181kkn/+O1M9iUQw/7z6aAaHN+MxlQ9o8DM+aC?=
 =?us-ascii?Q?S0OClBYC0GLgD1OG3zfeXR+dSNg2tbRBv/nqwKoD55QQwHxeEsMDOLVmHhcO?=
 =?us-ascii?Q?Jm8SmEia00L2HgExhQg8MP8zwNh1ErngWDtZlNgE0/j2uKTmivCqpUsHTHYj?=
 =?us-ascii?Q?x35U+hzvr6HQ1gzsLdz86lf1BHPSx5mpfDi9xPlcXVodHWMFc/31xzQ3xWnv?=
 =?us-ascii?Q?YzpUAHHWiQTYIe/um0AItAKOAT8LF9Z06fjOBMDvjpqYrILh67U/gqByMhmM?=
 =?us-ascii?Q?DlzCTFgUuv6tNC/gLoqzF4JJEtpiScIsPTHovahHIaSkF3QG2vk4BsLVdVi6?=
 =?us-ascii?Q?LwSRG+P+achpBBBhPOQcML9nx3Yq0qKALaRjdL39pPBn873CdB9UN2SIe1ih?=
 =?us-ascii?Q?V/Sww62VgS+oqBa6YHQgiEag8nUGO8mh3iikhM+hDJAqsLKX2jhgx16WQvza?=
 =?us-ascii?Q?YFNlUvzXNGiDghEoM42mjvZ/NpsMUCWTjhgvF+zXcC69PL5U/cdaIIKY6wu4?=
 =?us-ascii?Q?1I8NxYtTvLGvMpAI/jFJfLniHXuYgFSM1JbhrHHPumpVGktzXI47Xt+Y4pgf?=
 =?us-ascii?Q?CgMSfJc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PU899h4KgnBKdYArIJY8NiYpw9Rk69Fk1mZ74RQizReu2MNtfz/PZL5imIhg?=
 =?us-ascii?Q?VCvRbRsNxtc7bfMpYgRJNNF2IyCmLIkHcFE89OQ/YtThHsJS5KMeEI0uF2iL?=
 =?us-ascii?Q?YWQriHIT60HvOUqiYmebWwAUSgXTMSSGY65p37rKo3S8JduD5Go54i2sHZHO?=
 =?us-ascii?Q?0xzL/N2cU6S9i5ja14FogBmsjcQqTZeUY1kJymi4gqD03FMRn8M9dCPFKURk?=
 =?us-ascii?Q?9C8YJQgtIaf6lQXtGdqBFCJ8ZFwtdnt4bJp30Hhl/KtSs6N3CJ71X0QX4JR8?=
 =?us-ascii?Q?B3Jmp7TbXzDjl6pZgAwgiduVJtqfuIckeACOWhQC3QMpkvZSIWGVrYwSn2M7?=
 =?us-ascii?Q?W1aGMIBLg9y7SWPz4i0oqzcSBbhZwUXEvANIhnfW13GVOPfyMiPdvno1z2zT?=
 =?us-ascii?Q?siupum2ZCvsUu25BnieV30dbjL+EGgX5oixwwUgRYLwAd5tjU+twOTEghmhD?=
 =?us-ascii?Q?p2NuDvdaaP8brDHws3PCpHxbZFG1hqo0DInWUBjaHdPilbb12EoLEki9sf58?=
 =?us-ascii?Q?vrRUI2s7O3+VWQHAo7Gn/2FeJvguETIsVS5wmPAIToYHC3xSVkix1l7EJIEE?=
 =?us-ascii?Q?iSVE/G7YY+O+/5YbbSQoi6qUFYkIkH5X+v/8dXsCcoRQK9rWERErkcTxJdvK?=
 =?us-ascii?Q?PYsayc2AmcAPSCsY7XJtsaPpWZ4jh+SHU24qhTj8v/oFx0pBQ+ayTsJYcSCC?=
 =?us-ascii?Q?SCMt4ksEZUuL291k2JkMxuHcWoXz5bZvORvL69bI0DfjMwN6jWJvxMaJ0Yg9?=
 =?us-ascii?Q?9ZFacDKI2i/XHkNLm0uiy7EzFSFKWZF5Il04b4681YqX97QbjiwjyHPvOKAK?=
 =?us-ascii?Q?mo6PqEUlWJnG0Znr+XCW05VASnI+6cUlsL/00Cl2rMrRIIkKy4JGCy6ltQ9G?=
 =?us-ascii?Q?/klkC7GlzdUK+P4vDxoEJFQe1OVB804LjKcCB6Mydn702k8N2PksGyLkAeW1?=
 =?us-ascii?Q?AkYNgO12tF3yJ6oq2Fuj2oVQ0DPq1Ja0WKdPWC/r8arF95FSbBvRb6ijowDq?=
 =?us-ascii?Q?37dSSmNBNo4PFI8XICxGmf2Bj8ufCqdWnrVweRG+8r5R2Lkak8bY5F3tDUA2?=
 =?us-ascii?Q?vCDaRBm1Y78kDo2afX+phsVCQW5oarhJGg/Tribk4PNjOHrb1bSc/GH7okqR?=
 =?us-ascii?Q?q0gTlG/omuyreongp7GY/SqsbpY13S4nxbsHFqSFyyrPF0+/pKRBJZYkNq6O?=
 =?us-ascii?Q?T0AA5WX1SCoRySqU8NgP+gH1uG5mZ0l7Yj1ggoHIXt7Eshe/zc1lx5oT+7QF?=
 =?us-ascii?Q?HcCL8OAL1PNMD0a0O14EEfeRSRdpp/bsoDS04AHtdNyYTp7lFM0ySGfqLw8C?=
 =?us-ascii?Q?4gQAqIhZcOsGjhbZJ3+qjzHW6paq6+HdZf+MjqAUWfTpMvTfCA+T4Wj0pWmu?=
 =?us-ascii?Q?1MnSrP7sbaASAIYvcjuvDIKJaZbpTR2aEKYnIMDkIcpKwRWSkCgmlVNK/Qfv?=
 =?us-ascii?Q?gCw/sxio4KfiFypvRZCTsKjJnuPdfhvAgwofyNIxWEWAX/iPacfw1+LwbU7A?=
 =?us-ascii?Q?fkcBBFgeO5jK0B8ovqp8mf9NdRKzAp4ta0nJEB0sJ7OznS9oAlbNP1Q8Kh/l?=
 =?us-ascii?Q?JGC0fwHxddbcB/n+7mc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c889bb-0bb9-497b-cf7d-08dcf4a1c4f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:04:41.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3vpGK/MDo3UBfijl0wVYVpfRsAmFz03QG0Ju3cuY/tTAIpTQroSSz1tzGrxcxOVqVY7nNi69msJdu0zAAA2dug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6813

> On Thu, Oct 24, 2024 at 02:53:22PM +0800, Wei Fang wrote:
> > @@ -62,6 +65,12 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev=
,
> >  		goto err_pci_mem_reg;
> >  	}
> >
> > +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_FREESCALE &&
> > +	    pdev->device =3D=3D ENETC_MDIO_DEV_ID) {
> > +		static_branch_inc(&enetc_has_err050089);
> > +		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
> > +	}
> > +
> >  	err =3D of_mdiobus_register(bus, dev->of_node);
> >  	if (err)
> >  		goto err_mdiobus_reg;
>=20
> If of_mdiobus_register() fails, we should disable the static key.

>=20
> Perhaps the snippets to enable and disable the static key should be in
> helper functions to more easily insert the error teardown logic.

Okay, I will refine it


