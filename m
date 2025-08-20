Return-Path: <linux-pci+bounces-34415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E2CB2E716
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 23:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5638F1CC10DE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 21:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE0E27B34D;
	Wed, 20 Aug 2025 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IcyzlPSh"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547C156C40;
	Wed, 20 Aug 2025 21:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723762; cv=fail; b=owOVQ4UqGJ/S3IlrOD4+H8w13CZi9M7dWFcugmV7N0iorzObfkWtIpLaMx1Uzdu6aVwK90gxD8PdVGNr2RUkYFlLSRN9OM8POPzX8kTbk773+gKQYn2KYn40eEVtQmIh/mMg/MCGi8mc/cAyGjf8Z+1QD4IGZVBiYTl+4s41Ugg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723762; c=relaxed/simple;
	bh=EzYeFkARaUvdcc8nZsQAqt68miJ3JrP4pBBtLner+Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QasE7ZtMVuHnVsoiN5bLrblzmJ3gL5HS8V4LPLAyPpHQD521brzmgT97qVMLqoWT2iS9pLp4U0++1SBXbSo284VMmVX7utKdgOhEO3PdGfJz/AD/pzV1heNu2umM2MheestCRvvn88TjqE5Yq1znNNZ2pyY0I3L7gBUn5J+tNU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IcyzlPSh; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f6O9DUhUfS/wKEn5mD/OPfv7rMOZQJi8x0NYUG7eyNL+idnEiv9N7uSXHiVe1c88Op7/QI3gSYmxkrN+gy5CMEalVS9JC+HlBDBOlfRjptLbU8nV9IKYEkFn5UXHnvwVNxVurduQsExj6KpegglpzYhQMKwe5iY1HroaFMgUI069gUtYbwovfg7ny57s3HYS505aj3rMs/4jIRXia+TLcdAZfNQw5cDJKglsfhKIDMq2IONX3Hw0GjfjC6bYxGL9GQF0K3EjrTydDMYQpjkXRTP4fz62H1vsb/EA7LZfzYTPspPIyFzwc9SiNpzhffG3kQLpPn8NRJ0n8IeNEQU24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bb8/debUH+V4d1rjNwfD5gl7QZA249oWJTtoZlOc94U=;
 b=MpM9k0geMpzFWllgE98uMhFRT4Rb1JPbYJFdiFZ4fg1asUHgHi4fkgL32sjsTgVwWKB7TTEjXLdZo0l2XDp5s5oAMSauKCvU+QY2dQZ71rx9P6AM7XZ/+d1Ciy6e2L5EFiAtZEjtxQsppqtSo18j2WumNIXyztpVhTr2jjdc5EB3YzxWWHOL6gziAAOUWVBP9VIzb/EMLPdSLPp4IILG3isXt9fAvFiRrrwZ9KaPOWgQ6PhvzXehW3erDz7poLYGipyrYppNgSQmKW1o0ZDpEidsmc5i3ms5YJi3IbzV9em7Pdsc4vd2a1kZ0GewVdfdlZIJM03moNvaoW02eEhh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bb8/debUH+V4d1rjNwfD5gl7QZA249oWJTtoZlOc94U=;
 b=IcyzlPShfNZUDbVBRELePTmpxF+aPgy+wG+FTRpRvc3Ggr6EeStTD9sNJV4TbDLlMfgQPENNko72WGfO+KmYmS7U65+bWtP1L7Y8/3dyO159JU5Bij74feueg574ttLCaHJkoqPJT3beo2C2xFseaJyBLlZG2UH4gZ3tDx2kSTabxDvkZiVTKY8pWRmrjQBaXzllG3PHyfgXh8d/u53E77QD1sYa9befHA5dLcKHQZM8LsN7c/a4gXHAjUyaPjPulx/aDgIhlFNOtuF9Jd1s1z6396AbvH6Tvx0/sZc+ZJoqrrvpVbxBvLAxxkF5noAkn46S/CnlPQCG3CoMsDi6jQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8486.eurprd04.prod.outlook.com (2603:10a6:20b:419::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 21:02:37 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Wed, 20 Aug 2025
 21:02:36 +0000
Date: Wed, 20 Aug 2025 17:02:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, l.stach@pengutronix.de,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ#
 override active low
Message-ID: <aKY35MOg7reH1Fhh@lizhi-Precision-Tower-5810>
References: <20250820081048.2279057-3-hongxing.zhu@nxp.com>
 <20250820203536.GA639059@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820203536.GA639059@bhelgaas>
X-ClientProxiedBy: SJ0PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c0263d8-1c27-4ca4-9095-08dde02ce3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jP91gORz7MoJbAZ2MftAu5RRdEMkwrtQBrJCR4OiXlmZyKZUgy3QbwXhyheG?=
 =?us-ascii?Q?aQwrTfYLrvvudJoqFmGO5dwLOe89VzyZ1Ja/i191GeZfqmBIDM0SxjeBur/J?=
 =?us-ascii?Q?6SJr7i9Kq+4+VybhIAEhHiWVBMy5U53nDwl7jC6wrj7wrfwpUa0wC2JcBpYa?=
 =?us-ascii?Q?E3MSWIsOskdxV9nzK5a0Yd4IdJJPGIrRvtmuCvCquYc9QXmJM7y4LZ5/W244?=
 =?us-ascii?Q?xXpv4HQTif/zupmGnypiggBDYbkBlm3xJWaDvAoMIHUFWQHaCjMf2hKCCSbC?=
 =?us-ascii?Q?g4pE/KGxd5uR1QNDyCZrUZOZ40YMgk+TBMUEoZtm7SBvEnSiqyHEjXI1xCjD?=
 =?us-ascii?Q?AkdtYzu6LmI1BLG9zM/vtiEHGxZhraA/B9FhEfjgiPkxZ7IBP0FKdhlIawQj?=
 =?us-ascii?Q?AakOG9FpHx7/fHMfh4A0boOS/UXsh0+w38iVNVFZkcnM8eu6czRS2OwSDTK7?=
 =?us-ascii?Q?Ak0KGwypZkx2sTpd4EUUyK/r1GXf5Qn2EUH09/5/14j37lKHMJEfuQ+LqrBG?=
 =?us-ascii?Q?njenJwfSHeBRW6JnqI5X2z14UZduzhXwXyjAgzrcQsZVQL4AjEMdFdVn0rJ1?=
 =?us-ascii?Q?hUfOTbiFOGeBqV0xEUZ+Q4mTGEj6DAFmabJ+MBsyQlC2pApKFtCBGvVMSocE?=
 =?us-ascii?Q?D0jR8xjbzld5FnhBEp9o+i6gu/tXv3l7WexeQhmUDs3/3+o1f9OtNfHRymg/?=
 =?us-ascii?Q?fduoFuaprESLJaoF7xCt5OFWyTEwUXE15juvHzweM93RWRYtPP1cl6X6vgZ7?=
 =?us-ascii?Q?GtR5+NQ6Ed9HXHIC5VxHj+SvffBVDzxYHt9I4HFoMYpdjz4fIAcNbg9RwP6S?=
 =?us-ascii?Q?DjcHrCP3uBUoiS2QWWmAraa66vuDFSr/RzU2IXqZnIT+rcRlMLioT5dw822k?=
 =?us-ascii?Q?zAHBJlu3KUg4sQ8kEpW5hhBzCqQ8zPwWstUu6CmYTwbTfYtg+nxfN15eqZkb?=
 =?us-ascii?Q?uDpNffClhDZiCH0a5qucg0PDDQh9DN8eP+/x/FhqbklaOUha5YfIqi4wDwNz?=
 =?us-ascii?Q?CGsWt5n5FOxSdBLH7Brz2gkBCy2mMyerxqLbooTgFFLOJGIKC0Ei+ZRgYkLD?=
 =?us-ascii?Q?VmohLRkjEWKDYJOnHVAnBl7K8cExDKfLiHh0IeZ3NdMKmYxsMo6I60BiBnad?=
 =?us-ascii?Q?gwOlikWAHx/j1KYFwhn0IvO3VVplrfxJ48o9sLqiuOTtBsDMoZ1q2IouTZ5G?=
 =?us-ascii?Q?15yZ36lizZSI0Whx81PwSGKrGQgCJuqTiI4N8146bWoqIShttzRKruz4gQl7?=
 =?us-ascii?Q?lEnCGtOsdveoTmp8P0w6r1iDfWDcWVFxgqKzne3UCywedkB37zWua5bCGeMU?=
 =?us-ascii?Q?rvGnGoP8e2NeZ4x4UTzfC+5CDizFIyawv4fyzflKumw2SsItR1I7R8SJLfGH?=
 =?us-ascii?Q?7GbUbNtJ2hZn5fYK1OSckXP//pCHq+JuGsrs3KDRlQy6+yj0PleS7i+nD/WP?=
 =?us-ascii?Q?XYa6vJc46KOjjkALxOZ5s10SyIOJ8PmBl8D1WG5hGIqJZ4k7PPD50A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0rhI09u+bcaF1nNaqaIgoSQTaLsPTe0FzWp0+cxOkmKKQixVDFhPE21/E+n?=
 =?us-ascii?Q?Y+dFtPj4xO04AO5+B6iS42QodTSFK4yXUT92UibjOj/wyO2CjN6pGMpg2ud3?=
 =?us-ascii?Q?a6w9ugxjeRCE39BnOBjNc5Tc0QAFP4iliDdkI0LH0/N91PzFhf/cYhwBwjuf?=
 =?us-ascii?Q?IQc26glgftifOembrcf5kqBU6NIv7Bk0ZVTijQ4mfAyklVvKQsbyBq2tNcsd?=
 =?us-ascii?Q?YYLPrEh8zbEOmfVu0YFHLpMHwtNOCqlhNCEa8Ui/ndSSB6u2rMdAoBeqbS28?=
 =?us-ascii?Q?rTboO4QqPVCragG0DtRWTGeBJkdrlT7BX9VXcoVNgJJK0Olfs184Kf9zvBqF?=
 =?us-ascii?Q?A6EPNllWqNn+iM/1//HDbfVeuExNydnkvowq6yyb2RV0fqbLPzBU1dc2BkJr?=
 =?us-ascii?Q?VfasNQXP+DJtwUNkxhroS1hpP2yRFi9UXhSZVFDJCmtNJifH95pJ+U2yFAD3?=
 =?us-ascii?Q?uDN3wGm+R41EAFnFhaUW+lUcdEsVo94MG7oVUsldMUROnp3MoIA/qKdyCPWH?=
 =?us-ascii?Q?MLN9I0mwo5/G8VHyHm26l1v0W0oIOpUqqH5JjjrgvseMIQWneGGwIV0ncX9b?=
 =?us-ascii?Q?DGlhOJId/3ED70AdLQSuG0wdQ2Xq7wK3smpXkX/d5LUZbOGFXDj3LcqsVtmx?=
 =?us-ascii?Q?eQXQ3iXCkEoa38GOTgl9Zxt4IPYvpXT4VDBmB6Cqha2h8h3PZjsL3G+4Aak2?=
 =?us-ascii?Q?7C2HIf6V7ERgreDu8Fau/VbZJ7CdIgKVMeJEfM4/NcUCVo2ODWiOlmeTiWE6?=
 =?us-ascii?Q?mJ6yc7LLndKGwNJfkXx5QF0eu3UEV8JXSsnvlPPTmxJ7uvff5o9eh4xHpt6m?=
 =?us-ascii?Q?vdGR9Hc4ghFAGoD4uGD2YZdFOqoBW9XZzWuice5qxgAl4hRiOlaicwq0d2lO?=
 =?us-ascii?Q?MIWEwwYbTaWRR4Xead8Q6s2H+puZN1zUeEZdt4bAnxYdsVt3egEPatZxv0Qy?=
 =?us-ascii?Q?MpJCI+MzvbhnKWm3ABZxoV1df0km1e5D5WfmewCouiNidwv8j/CX+5bjj32O?=
 =?us-ascii?Q?N1qvqytFjDb7WaY0uM5HEMhEGzQjK19BEBc265rlhcky3z08y/RWe8R4hgrh?=
 =?us-ascii?Q?Syq3NG2xPlvhc0v2frKcpnfDDSew4vkAKCBmGbvZ/aGBAiQMgoubeUmafiKJ?=
 =?us-ascii?Q?SsQa4ovP+FeFoQh3Lce0j3B7IK2cTB7csqevVBJCDBe8FG6/CkEyLz7xtlKQ?=
 =?us-ascii?Q?h0VC+/Xvg56Jb4WB2k2y6BivRdazIc0mjPo1AKgR05hFDp2pSysQiH/sUkxv?=
 =?us-ascii?Q?BVTQKBLgZiK8yn/sRwtHcxH21vG7D3S0ZrqsqarnFThczx7VcbNBq2xuIc99?=
 =?us-ascii?Q?rBRDGlCms5ptpjYPtuh3x9P4kvPtFHxkexYgE80T/NYQ9SoIeMfSP7RX3EwF?=
 =?us-ascii?Q?KfIeoDz6UAvKp1QG30MIpCITV6n4NY+GzoJl9AaGYRRy2c4UC8Jjp8I8VR+n?=
 =?us-ascii?Q?S4NN8lFft5CZYp64/0VVzYJvFpAp7t5sw7tgADnFi5fNVpsCoiUwDKrzSwAv?=
 =?us-ascii?Q?caM+mXr0ESwlAQjDF+6bz/t23t0qUr9LjFW72T6+4cA7CWMsahFUlbEaLoXm?=
 =?us-ascii?Q?aiHLHhy9R/QKMgt8q6YPyzzQOfOxaqMVP6CoOXcu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c0263d8-1c27-4ca4-9095-08dde02ce3e4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 21:02:36.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zp6HTNBTvmRutorgWmOWTjnCHayslu6m4lExtyDw/9oFtKA25FYMKsl73i0e/qvotw/0PtFP9SzXFOCxj7J/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8486

On Wed, Aug 20, 2025 at 03:35:36PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 20, 2025 at 04:10:48PM +0800, Richard Zhu wrote:
> > The CLKREQ# is an open drain, active low signal that is driven low by
> > the card to request reference clock.
> >
> > Since the reference clock may be required by i.MX PCIe host too. To make
> > sure this clock is available even when the CLKREQ# isn't driven low by
> > the card(e.x no card connected), force CLKREQ# override active low for
> > i.MX PCIe host during initialization.
> >
> > The CLKREQ# override can be cleared safely when supports-clkreq is
> > present and PCIe link is up later. Because the CLKREQ# would be driven
> > low by the card in this case.
> >
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index 80e48746bbaf6..a73632b47e2d3 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -52,6 +52,8 @@
> >  #define IMX95_PCIE_REF_CLKEN			BIT(23)
> >  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> >  #define IMX95_PCIE_SS_RW_REG_1			0xf4
> > +#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
> > +#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
> >  #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
> >
> >  #define IMX95_PE0_GEN_CTRL_1			0x1050
> > @@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
> >  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
> >  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> >  	int (*wait_pll_lock)(struct imx_pcie *pcie);
> > +	void (*clr_clkreq_override)(struct imx_pcie *pcie);
> >  	const struct dw_pcie_host_ops *ops;
> >  };
> >
> > @@ -149,6 +152,7 @@ struct imx_pcie {
> >  	struct gpio_desc	*reset_gpiod;
> >  	struct clk_bulk_data	*clks;
> >  	int			num_clks;
> > +	bool			supports_clkreq;
> >  	struct regmap		*iomuxc_gpr;
> >  	u16			msi_ctrl;
> >  	u32			controller_id;
> > @@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
> >  			   IMX95_PCIE_REF_CLKEN,
> >  			   IMX95_PCIE_REF_CLKEN);
> >
> > +	/* Force CLKREQ# low by override */
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr,
> > +			   IMX95_PCIE_SS_RW_REG_1,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
> >  	return 0;
> >  }
> >
> > @@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
> >  		regulator_disable(imx_pcie->vpcie);
> >  }
> >
> > +static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > +{
> > +	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
> > +}
> > +
> > +static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
> > +{
> > +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
> > +			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
> > +}
> > +
> >  static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> >  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> >  		dw_pcie_dbi_ro_wr_dis(pci);
> >  	}
> > +
> > +	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
> > +	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
> > +		if (imx_pcie->drvdata->clr_clkreq_override)
> > +			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
>
> It seems racy to clear the override when the link is up.
>
> Since it sounds like the i.MX host requires refclock all the time, why
> not keep the override permanently?

It will Lost l1ss support if enable override permanetly. I think other
platform have similar issues (at least dwc controller). Most platform use
m.2 socket, which pull down clk_req by EP side devices.

Only standard PCIe slots,  which clkreq have not connect by EP devices
because stardard PCIe slots add #clkreq signal happen recent years (maybe
after miniPCIe slot spec). Some old PCIe devices have not connect it.

Even latest PCIe devices, I saw have jumper in PCIe card to controller
#clkreq.

>
> Obviously it must be ok to keep the override for a while, because
> there is some interval between the link coming up and the call of
> .clr_clkreq_override().
>
> Would something bad happen if we *never* called
> .clr_clkreq_override()?

clock will always running, lost L1SS power save feature.

Frank
>
> Bjorn

