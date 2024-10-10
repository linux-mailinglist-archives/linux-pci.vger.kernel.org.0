Return-Path: <linux-pci+bounces-14200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A7998B54
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809C71C255E8
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91291CC15A;
	Thu, 10 Oct 2024 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CBCsoGGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784421CCB27;
	Thu, 10 Oct 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573754; cv=fail; b=XNaDEJy6/r+FOwDBCUF1467u7x4sP/10ve09zd6QKpUWeXII49Kd4ffWZLUSJt+Zm8nkECNATED763j3qwOlfrQVHozqOE9RSSqiLC3C/DYpOoDZlyl4DxAcuYqdUBQw7EWPwFrOPLmioc33/p3iXmuziqwHPyrhsktk9SXy3K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573754; c=relaxed/simple;
	bh=RUTL1EL+1djjC4ZRdNLt8ws2SQfiVYQkVLdRG3J4reg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uM0O9irpXj1J+dEwnKQ/vRZ2ekCM+zdDdxoIVAM6HOhK7eIZ/NRMCqNAjEU6xIJS8B3PBzZTX/Pd4Hi/dVOqWneL3Tbs9CutTyS3bIxKA18mv32MkJ5Celv5RVdUY5anS2BnIcm3rLygGxYTg+dY7yAUQE/wOHqnbaURUiqCpzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CBCsoGGf; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOaJIn3JRHiFc2bqiAM+9EL+obdjq8t55DuvTdCqGiJzn/9IjDKoWEEf2p3LIP+7OgXZUKfdTiIW3xlrEwVtuHwGgL3y7FI5edP+0fN4r4N9qmt5hUcNDFxLBRyTkd6Qz+8wiylVrHW6X0V4kJ9ljAe1uhTTChioStvF6MCyUmUrIBoHr/RFqWiA3EYnvWv1U2n1L/ebIm6sWG58spQlilE1S1aPEiYWhn1rBp0z8zdWsYp85zyXTKKxa/GUxNJjIu6K5QyU5cSCiGAcTM9tqNLaVe3YBX/lbj9uo/fBUFRj+sg/hUArtguxtk9BM9BP1QG51GSy9ZY9qwZPzIwtcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vkwaOlTzD16rflwpbeJamWsLdsFJsLomLFu1UFD7gI=;
 b=MvuFqaWii12acGf4BwK1CPhftlAD6aixjm+LLDafqss6208d57FYywUV0W+1Gs/Y858WSybBoF1+n3L+22BK5jF6HshapC8NxR3OT+ZkLAGfudihGCGg3dbYEeMBMrXbD/f9leRUet6fpxpWL6s450DgP1CrbC7GiYaauBOylisV/+ybHqcLUgC5RU/5Q2Gb28twiCwV5M1alCfxgn+y3funT84TA3aXFTxu6W1TA6dwS/XtlfSYegbhuI4sLUK488PcW8Pn9+3NQEFJMvD2L4K9L1OhRp/LzQkas51zp+vwBh6jOof4zTJyHjGWJDQchPv/YJmepk5BEkGFBNfbdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vkwaOlTzD16rflwpbeJamWsLdsFJsLomLFu1UFD7gI=;
 b=CBCsoGGfiSH1m8UsqCHn9DJAcgYkyvtn4SjKM8dZI5JijbVnBTu4GWbfQWL27/f2MEVSmp7nQDS1rni3Wk7LsZJE2NhqtWT0mbLhkG/9CxvMmXjJ4bG4IGe4qoNha+nJHwECoTeZtQ81H4XdMM1NwTyttkCE2tisx9z8BzC2cFOGIOLkg0dITfVqcrmMl1k12FhhIOV0q75eu2+AZIZfTtfMB0yHNYodDXsssgECzw2EXxK8Sf8Xw1XfAF2pCzHqACg/EUG1md7HNrf+UK6QrYw34A9ZRIbaX5riE3CagPOr3vmqWYshIz/XEmmCUqcNvzux+1b/RwJcSStcfZJHeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 10 Oct
 2024 15:22:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 15:22:29 +0000
Date: Thu, 10 Oct 2024 11:22:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH net-next 10/11] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Message-ID: <ZwfxK+vm2HCXAKHG@lizhi-Precision-Tower-5810>
References: <20241009095116.147412-1-wei.fang@nxp.com>
 <20241009095116.147412-11-wei.fang@nxp.com>
 <ZwbANHg93hecW+7c@lizhi-Precision-Tower-5810>
 <PAXPR04MB85100EB2E98527FCC4BAF89B88782@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB85100EB2E98527FCC4BAF89B88782@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: BYAPR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:74::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 326f63bb-ce8a-4b5a-926b-08dce93f5a74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yVyAQnEjJbD8JDpx3HTOZLunXJPC55QuVJIV5Dyvi0iRE43TIn7T29hdinpQ?=
 =?us-ascii?Q?6o2sn2ByIge0CfLewlaL7uUoZFFbnOQRniVWgf90o0iOFUzZCygmeSEjmKyW?=
 =?us-ascii?Q?h1QSFUFZfePfD0enRCgHuuBwYfVcqSfiGoqHk4KwwNJwx6CyLqLAPe6f5TCD?=
 =?us-ascii?Q?dNYMd4jD9Vg4dnYLbJ1rn/sXeCyLAdgD+Ec1ZioiXh5W2KeWdYzorwNs687B?=
 =?us-ascii?Q?T+hDvr7WDZkpFhlKSHSUwE97Eg0P4bXiVWlVge4LO8hQGGHbTdRlSami+njm?=
 =?us-ascii?Q?ZZcvFU+HPT6wivockxFZu9oc30jsb2fWVPrG1a9OQUbwANAmOovZUHwyjdui?=
 =?us-ascii?Q?CwqD/I3WXqfus08/47OCb695DT8eQGqlv6giz04Twpku4AlIU2gmD4WG4wRk?=
 =?us-ascii?Q?O1KexcNeEWFPjE/3I4K2ybKc2R0Odi1zK8nl4U76SnS31t/bGVl4lNhoRO6z?=
 =?us-ascii?Q?XzjgL279WWSRqtj2Z4i8BOX6gOvlVk1l6K3W1SV2JTDu3nqzx5iWNUtjxwUS?=
 =?us-ascii?Q?lkjBfIEPXFv6gqAG+raP0hs5+5Z+YPg2AHEkIPoj/7VN7Tf9mszUrY9hXx1h?=
 =?us-ascii?Q?KhLqZaRs7GWTkOl/npa93EpXhSZUcSxh4hT7vqEv7HBlcRJBb6mBlzJXRFhz?=
 =?us-ascii?Q?azksC54qXugmb7hYJi3FCVfAHp9foWGTz28xaw/4ewLXf5t1D3Npr8ifWvzy?=
 =?us-ascii?Q?Ma+6rH2CpxPyYawDsUgrTr3Emn9sNXnA47DH++7OErIPx4khrtLCfIoxT5i9?=
 =?us-ascii?Q?MmB/5Hga9WBLqq1NxmjEj2REmVNuDGoDE8qwZN2NFbj9SROebTU46cW2lfPA?=
 =?us-ascii?Q?YqAtvMRAbzYjPTYFkuLRENsyOaaQVQToOxVXMQZeZU1WS4GzZ7SNQKwFqtSY?=
 =?us-ascii?Q?hPM3pjN6cTuIL3Nzf5BmV5p63D24d6Rsju6Rqt4BxWlWyV2pF2FFz3uscXZT?=
 =?us-ascii?Q?3VFKCI7BlXRDpmMTKvxAh+JrEWqs3ZtbaUUUfa0vjMKZgmqCqsVGX5Kukd7e?=
 =?us-ascii?Q?sYKLlOCYUZQLz2DJQf9foHAsbKn8eg9GJuVE+S/qHydbUhNhEU43lw0G5mFt?=
 =?us-ascii?Q?8pe6/sle60DnNGZJsiOtW8EkBg3uPwiKRLocOkrJ0YyUsBpCgFx6VVA/3JJy?=
 =?us-ascii?Q?+I8TFAxaPEkVHYpKb+NL4ZrxEjQTzWlDU08SZHBJMyn6zyrwX5Cd4vAxuj/g?=
 =?us-ascii?Q?IajNJOcE38C2cASX9mjN5SA79asiJynSGbBOm22qSstez2mtMMPAUulUk6gp?=
 =?us-ascii?Q?JpQcbWIYBuXi8gu9WWZCrZLdmfK1TRp2sXTUf1u/dIoJX96LtwdbDs5gnozR?=
 =?us-ascii?Q?2n8F4m22gkdfwaOGeGENlCY7z3c94iDQDC6cgm6MQckHqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Bji1Gzhhn3lTmMtHkKuZ2F0uO5IPT+CsKpsPdiuFjZlRBli3wIiS7jlrgH5?=
 =?us-ascii?Q?xAvyu4amn4NhEbLVC4Sdw3IOtExpiuNUqlU+oTclcLm6aqZ6cwNeDs5Cqw2a?=
 =?us-ascii?Q?362vnWAAkbNr0qjlAPyiRwUSDzpqG1z78P9D+BXOtV7Kz3/mbtyVSoDMOAKr?=
 =?us-ascii?Q?Dr+AoNxdd22NBDkqK/3TgeTwh07pZzmHbDohnpQDECL/+bjLAZvtDOdoZSz7?=
 =?us-ascii?Q?tkC0rcQttOHaqFwhCM1LRsvR5UA52R4mRtc1qAq3Skag8jPdrtk2Mbe7SlD3?=
 =?us-ascii?Q?Rzm7b7ELCe4m9ccNbSTNj+ECVC8nFkc7heVcpm/mKzBtmREDEssYm27uI0i9?=
 =?us-ascii?Q?ydwg8G7cH+w9zOVRCorSMqTUuAKnPv0nYd4TiVSOwLU4QNb1hjyKlwR+EmRC?=
 =?us-ascii?Q?6SCKI0G4mo9vpgooP9ngxbR98w7L5qS65Bk7TpQtBI3CUGInmwsAt7Iamjwn?=
 =?us-ascii?Q?oYXQqureHPWh9q3FzIwfCIQIm28DNjgIRk1UgeF+jYB35KFFE4C4bOwqa8Xd?=
 =?us-ascii?Q?uk8a850Zb1PWQ+U01EueWJxqQ+u4WVqxs74SF4felVP11T3J68O7kvseCBAi?=
 =?us-ascii?Q?xNcxgTwa4pVFGtygWbJzG8kmANL0Hf+QKuOou65/fnnaWXYF76SdLG9zYIxm?=
 =?us-ascii?Q?/HzMsEmCXh8ZD8tRtn63VV44J7D7R9qDADzN2DO8Wro5lKnOdUOMLJeY/KhW?=
 =?us-ascii?Q?2CvCDClmGzk316fQNaVEjbOfndh1SjG6KAgj3RalP11vaR1EwJuvILKahIwz?=
 =?us-ascii?Q?nSAah2O5gVBij9hj5Xfc0UnXauc14cpdsDUjDjirCDTDJJ3kSZhGko6C9LgG?=
 =?us-ascii?Q?HTQBtVx/4Kw5eudjeVuWwo6XR/P1qHPtbX/2+WhSp12EqAAmNRd/feOA2AYq?=
 =?us-ascii?Q?IY5pNWajZl4lE+i/kdMz8gukTliE9Yw9n0z3Q5RXwo3q0P7RUnbZl/9q6kk7?=
 =?us-ascii?Q?+vYIhMq7XN5sQ0aWjIRCkTNVfrmUqeDZ4OwiNuPnbZmSvmJTZSz6jKlO2aN+?=
 =?us-ascii?Q?KqFWKTdEY4qIH6HxEn8Um2mEUh+wkoOO8/xq+bB8pCoTzPE8Z49xJ7jV4rZz?=
 =?us-ascii?Q?83eaCinhJPTsfy5xjOPQ3sCaJDKDJfQZM30KhoBxgv5zcGHHmU9105APkVgC?=
 =?us-ascii?Q?uqE5TopOvsG3dsL4hKwEZZrIxbQubciRwMnTejR8x7b2Du+Kh6t0AYJvJIRR?=
 =?us-ascii?Q?B1iMGC6TH3HwdvTnN5v+eBFnKtb+YXPCkExAzHUuVmIGvo3adqedZ6hMUVON?=
 =?us-ascii?Q?CHudNiLsjEf2KHeVQtP5gzzfia5+DNAR2V6agnxM4SyZjyaKWwCgSh/T292u?=
 =?us-ascii?Q?D4fAh7cAGR+iWdc7J0Qloytr6UDHJOPeSjBviuPtDaRcgHj5dOVjW6GcsPyJ?=
 =?us-ascii?Q?jeID8XSEuGck22msQPgIH0LHbcB59SzPbNJdg53NjFXXQwEFOBx8O+WfPRHT?=
 =?us-ascii?Q?S2+822mWg+aB6eIsX/36DGTROL1e5O9woqFA0qo1X19nyZS0+RR+m2EME2cN?=
 =?us-ascii?Q?wQlA8vJoHN2wGR3p2rU0k5hhRCvetjoXLaMQQxWH3LFg4be34ysYItdElIL5?=
 =?us-ascii?Q?+mHTbur6+lkr0J+Sa96tjs8XgRBogrnYkfVkzwIx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326f63bb-ce8a-4b5a-926b-08dce93f5a74
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 15:22:29.0752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKetrxSTqPvrsIEKt8n0UatcuJcqSPVUkCB9kkGL4pzLy/EER0qvmDrPhSlwfIgaZg6r09V3joXHvpLQuCi4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489

On Thu, Oct 10, 2024 at 04:59:45AM +0000, Wei Fang wrote:
> > On Wed, Oct 09, 2024 at 05:51:15PM +0800, Wei Fang wrote:
> > > The i.MX95 ENETC has been upgraded to revision 4.1, which is very
> > > different from the LS1028A ENETC (revision 1.0) except for the SI
> > > part. Therefore, the fsl-enetc driver is incompatible with i.MX95
> > > ENETC PF. So we developed the nxp-enetc4 driver for i.MX95 ENETC
> >             So add new nxp-enetc4 driver for i.MX95 ENETC PF with
> > major revision 4.
> >
> > > PF, and this driver will be used to support the ENETC PF with major
> > > revision 4 in the future.
> > >
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h
> > b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > index 97524dfa234c..7f1ea11c33a0 100644
> > > --- a/drivers/net/ethernet/freescale/enetc/enetc.h
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc.h
> > > @@ -14,6 +14,7 @@
> > >  #include <net/xdp.h>
> > >
> > >  #include "enetc_hw.h"
> > > +#include "enetc4_hw.h"
> > >
> > >  #define ENETC_SI_ALIGN	32
> > >
> > > +static inline bool is_enetc_rev1(struct enetc_si *si)
> > > +{
> > > +	return si->pdev->revision == ENETC_REV1;
> > > +}
> > > +
> > > +static inline bool is_enetc_rev4(struct enetc_si *si)
> > > +{
> > > +	return si->pdev->revision == ENETC_REV4;
> > > +}
> > > +
> >
> > Actually, I suggest you check features, instead of check version number.
> >
> This is mainly used to distinguish between ENETC v1 and ENETC v4 in the
> general interfaces. See enetc_ethtool.c.

Suggest use flags, such as, IS_SUPPORT_ETHTOOL.

otherwise, your check may become complex in future.

If use flags, you just change id table in future.

{ PCI_DEVICE(PCI_VENDOR_ID_NXP2, PCI_DEVICE_ID_NXP2_ENETC_PF),
  .driver_data = IS_SUPPORT_ETHTOOL | .... },

Frank
>
> > > diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > new file mode 100644
> > > index 000000000000..e38ade76260b
> > > --- /dev/null
> > > +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> > > @@ -0,0 +1,761 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > > +/* Copyright 2024 NXP */
> > > +#include <linux/unaligned.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_net.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/pinctrl/consumer.h>
> > > +#include <linux/fsl/netc_global.h>
> >
> > sort headers.
> >
>
> Sure
>
> > > +static int enetc4_pf_probe(struct pci_dev *pdev,
> > > +			   const struct pci_device_id *ent)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct enetc_si *si;
> > > +	struct enetc_pf *pf;
> > > +	int err;
> > > +
> > > +	err = enetc_pci_probe(pdev, KBUILD_MODNAME, sizeof(*pf));
> > > +	if (err) {
> > > +		dev_err(dev, "PCIe probing failed\n");
> > > +		return err;
> >
> > use dev_err_probe()
> >
>
> Okay
>
> > > +	}
> > > +
> > > +	/* si is the private data. */
> > > +	si = pci_get_drvdata(pdev);
> > > +	if (!si->hw.port || !si->hw.global) {
> > > +		err = -ENODEV;
> > > +		dev_err(dev, "Couldn't map PF only space!\n");
> > > +		goto err_enetc_pci_probe;
> > > +	}
> > > +
> > > +	err = enetc4_pf_struct_init(si);
> > > +	if (err)
> > > +		goto err_pf_struct_init;
> > > +
> > > +	pf = enetc_si_priv(si);
> > > +	err = enetc4_pf_init(pf);
> > > +	if (err)
> > > +		goto err_pf_init;
> > > +
> > > +	pinctrl_pm_select_default_state(dev);
> > > +	enetc_get_si_caps(si);
> > > +	err = enetc4_pf_netdev_create(si);
> > > +	if (err)
> > > +		goto err_netdev_create;
> > > +
> > > +	return 0;
> > > +
> > > +err_netdev_create:
> > > +err_pf_init:
> > > +err_pf_struct_init:
> > > +err_enetc_pci_probe:
> > > +	enetc_pci_remove(pdev);
> >
> > you can use devm_add_action_or_reset() to remove these goto labels.
> >
> Subsequent patches will have corresponding processing for these labels,
> so I don't want to add too many devm_add_action_or_reset ().

