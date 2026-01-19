Return-Path: <linux-pci+bounces-45190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74245D3B03F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 17:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42DBE306026C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D752DAFD2;
	Mon, 19 Jan 2026 16:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SBBYpPKd"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E36285060;
	Mon, 19 Jan 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839316; cv=fail; b=ecL8AicHTpVSdlKORYKid+7OWSyv2exJcRBhTXc4RwPGjKUbgBTxNDP6Fr466ioSfkMbIKDKH8qxwb+JMDCK7C1ZEMcqih12Oo2Hmem6C/q2UUMKPyEANKuLPugDq55iV0s8ykwEEpGbdaV8T7XVhNS5gs28yV6jvZb5TAGczCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839316; c=relaxed/simple;
	bh=4x3QfSrM1aOqbGh5J40Q/mGKDxttylJ5jx0UMCeNlOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p68Ls+WPvuXm0s78+HGDh9LYnqYPtIrbQrtumL2Qz7fPS9DdkcaO2FTWDMYdCRDg3IXCX6kQvVJYKv/Fz9r+OugQ1yr2vgdL8q6zJ0dyry9I9zn8jovsCZvZ+yQXFkyBDrmBXdg/ozfdjH+qLntbY5DSL/bonnjNklh/8W98pc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SBBYpPKd; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7rOk53vIY54ex1dtDfPkehO/0g8uGGsamma85Miv84mxmWAufU773wYyzOR2ixE+t0sJTmzvYFACXNUPszSkHYhAoOPtWPCx3nl+Zdks/3wag8jedwYUnLfiQOWvgK0MgUZZdxs7mKTOcoM/A+EvjU+Bquhh1z+OGdt2kLJTaue844Gq5aCDNt9QfWmiwu4/fAZGdK7PQF1vjzjYxpjYP/Bz1BCMqYqTNfFBJUcSKKZK8+lMbP0XF4Gl7u+nRzXl9EPiVzECVm+9bF96tt4oIrg5DZCZksU0I8rvGRSstfB3fRCM10NehubPvbEqmfiVbUYhb7gwnpLErd2MckLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1z/TiPyzpgsI+rxYYcvYp1pdsm29rt1OfxChJ0tTGU=;
 b=hOqADQF+PSneGbeGm2w7Ez1FMky+uwutxedaK9eO+73Dk2UdCerpI4/hmd/DblL0vIO0KWCtRYiYCrnAKaaJ1GKhs89Xk/NRsRFZ5rXBMY6Nc9y5TVzAety1f+vWK2cmgaabLubKl5/NME7yfqcZLybbNd5O+1L5cjUwFe5HD3DmPdoZvuibynViRW4yUqZwWVjwEAej23e8l38An2bSI+9r9uUfPVf8axgfEnG+8zrHHjg/NJscDg2x/lIuwYQilfCAHFe9tZJFge0ySurXm1e+KuoZFYzY4+TuXogwIdM5DejTm5UcoY3GTxcyitbToYF8odf4D/8cRknlXORFnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1z/TiPyzpgsI+rxYYcvYp1pdsm29rt1OfxChJ0tTGU=;
 b=SBBYpPKdCelDsHmWkYvIa4TudqgyFd2i4wTrnntROEoVKPPnxvHMHZm+uCz2jKg4HjRuyq5RKJ9G4Lyq/p4ODaCovyLPgLi6xgTjYR/oXXcH/eVBsLKTNaXcDoA2MYDIhEl6AtK0KkhuaGeSDDsMX4Mzuko7Cf4UEtA7CEmwAZOjiEUpfMZ0pOvBk1V7kW4Fp6/Cgui9ZLXrj1KFXM249x3SOpCEItV9GLCohrbsLNJMg3H9g2odA9Ras5PPZLNiWJ0wWlA9Z0dhzzueOvZSniliP4JrI5Fnj+0ATr7+D+fEbExrEpf/tMb+6kTof4otzg4VfBxLeSKQ6J2ti5IEkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by AM7PR04MB6888.eurprd04.prod.outlook.com (2603:10a6:20b:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 16:15:12 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 16:15:12 +0000
Date: Mon, 19 Jan 2026 11:15:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: PCI: fsl,imx6q-pcie: Add reset GPIO
 in Root Port node
Message-ID: <aW5YhTaclPKB9s14@lizhi-Precision-Tower-5810>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-2-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119100235.1173839-2-sherry.sun@nxp.com>
X-ClientProxiedBy: BY3PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:254::18) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|AM7PR04MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7ff847-cf4a-44f5-8d6a-08de5775ec5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|19092799006|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rboAubay3V866KPlYFlkkvpkFhobdZK8PIsR6kOIAUr+mD2FN/vFQB0GCnr4?=
 =?us-ascii?Q?U5UTJdCN9K67sLzhWP9bxb5f8+0z8/tNy2GplTe3D9cFia+DtfazubGEOIij?=
 =?us-ascii?Q?9FI06Z7os7JOoc/krcdiGkg20kdw5/Z5PfRWu7kyvTewpzUQIcXTXac5V7jA?=
 =?us-ascii?Q?0dBJctN67c41QIcHQWbgA1ZUxud+hnZkcgR8R7eORZ2XAgQh6HANG09/Cd+K?=
 =?us-ascii?Q?RxaASZ6pYv+DVWfT7zqWID7aRjXykpwuGeTtFANZk/uLg4mPA2JD8KzV+Udl?=
 =?us-ascii?Q?SflBsm5gt7PY9H550KQQYcMjn1KOym6yOBNIAV9DjJCOBD5lWqHU2em1Jr5U?=
 =?us-ascii?Q?wJDIEXuZ8ZlW9xpDUAzMB6rxDvmptiZSFAXUKwofe3t12+t9ok9Ut06yZAF2?=
 =?us-ascii?Q?epIVUAX6j67jVRMEL6KsCY7mXhxbr6RoKUxt7kOYx/mawvKuH+2paPLuYxhW?=
 =?us-ascii?Q?D6ypYXaxhvIKuF681uIEq+NPV4d7shnGvFMetVy/KddRXVVM7p4U9XYupjfe?=
 =?us-ascii?Q?zkPm3rak8PiVdXf9OvEoptvKo/bIUcFAo/AYEH8K/jzPDaOWKEtgOxTOT8/m?=
 =?us-ascii?Q?Bu32SCgKQjd14ujBiDcmZ8azfoD5uNJ/Ig85kRGuKaTsurpF70e25UR/xpVw?=
 =?us-ascii?Q?PJqE79FFmrvx5+BTEq6PAV2gqFviSwK7Kcm/02XPSF3ej2aoESpalfwsFevg?=
 =?us-ascii?Q?MIF8/TbMVommGU1Ly3cKsQC66nYqO4ZG6SybaAt7WkF4GvEiZ3TLENE3LkgO?=
 =?us-ascii?Q?nvJeZYynoHZFkF1nyenAIt3l27tR61kDUWA1LTb898F6t+RxWjZ/YE1RFWPx?=
 =?us-ascii?Q?IrhYCEwy1TZ1HQl/KaNACFV4qtpgP7tOrLm0fwYEjc1H97rGWsrCr9iZoRv6?=
 =?us-ascii?Q?hpVrxlaWY4PZSYkO0xltHsqbiVbJKcrFe8G0tg7D8usUy7eiIaCAsL616GYP?=
 =?us-ascii?Q?DdJXvfat5mlsN8q++oaGI05fbuUBK7PzD2/Vl/lK32v2RPeGKDOx8RpJhmYe?=
 =?us-ascii?Q?AEaXv07sV33NSxdtE7l9ZAeiERpJY/rXHM7ho3jkR7bSOxS8V5hZNQDeN0gX?=
 =?us-ascii?Q?HLkM37qbbN8M0IIAGS0JxSws/u8wcC4q0Ks8WmA1cFPRTHcVinhi6LpXQt4N?=
 =?us-ascii?Q?E/6p4kHyryAqJDL2JBTmpHdDMdL1+i5P7pa9s6ukfyKhofFgPzdn1OnzukFu?=
 =?us-ascii?Q?XhS4pfFKVMoXEvoSculgHprS2YoGIfmJlctBqkUoBIf4xap3ov87LGt50KJR?=
 =?us-ascii?Q?kDHLUHh0TyjzMS/5SrtZqosmQMEHL31ZTizVvscnFz3Bk0zhwxSepSsOBQ/o?=
 =?us-ascii?Q?Dfz7Qp73hQnE41c3d9nVXVrIkqcqE/htrKYI3DHFkQwZ7I6yy7dcTnjlHTl8?=
 =?us-ascii?Q?4U3iFmza0mI1zsMQEInI7FBZHZ2NI4FAcgWOsYPSvqrW+f8I1QfKOqTHMvwE?=
 =?us-ascii?Q?2DgNS7FdlMuUnl0D1OffjnfzUKm2s+013zGoJ07z1Jg1iOpcupvXktrh0VED?=
 =?us-ascii?Q?Xc1oI5eFxtDug/GZgnPzJMDtSb7lnRSkSOMocMt5Yl5qL+de1coGtt1NOgFr?=
 =?us-ascii?Q?Eu12KTtME5FNlo3IJpVrgiuZxVrkmrn0LLpEDRCwCK9WNEbrh3xZPV77ZPX1?=
 =?us-ascii?Q?KLyabkixxmhgsjX6KZa+cHc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zYNPYUZCmPIuzcTE9PqseOjXG7FezB5l47WUm0OyeRT0u32lGpMD71/smNAO?=
 =?us-ascii?Q?CRgioCdWiVXWQdfOQGteyvAOOTAVrHm+cvA84uk+B19NsQr78tc4a5WhY6mw?=
 =?us-ascii?Q?jSYrVoQwDNHPMXCIT+jSzKi0gmh+Y7xxA6mtmRPXO+0LupKGJpUaDs4TSV4f?=
 =?us-ascii?Q?6s0kwoICrKuF6XgzK8VWUYquSBf6Kfkh9gKtwqcS8sf0kby0RI2lCaeChSJD?=
 =?us-ascii?Q?vdaFFnTWTt/xF8cUlzt2gCVyjw5Q2oT/K2rzVr5fZdeG7mePcbzNqJyNZ4y1?=
 =?us-ascii?Q?oxwkAfEBBjFkCwJhQ+sk9I1Ehq7s+0fNLgkESm3jMz6qbsimw7zX1KnUSfM3?=
 =?us-ascii?Q?zP4y1VoSnPSSSIRJi46QxDpCZpNIvODR5AJPoONWRI631gshMEn9Sf0Hxa1r?=
 =?us-ascii?Q?pGaKZjK9ZHdpzPuKPLcq9lSE/JWkZNi2hcr2rdly8i6WzFngRhHEs8p+gsXp?=
 =?us-ascii?Q?6TVemHh3EGOt8afvgw/0azInttsQUbu+rjOx6mFfg4OdC5ii2FlUwRxTXjUh?=
 =?us-ascii?Q?GmfdU3JMrQ4GUjLM5uhLVg+ntE1AWIx9ec7IVpMngvdyiaTsTFsQuXnPjcA7?=
 =?us-ascii?Q?Eb7JC482sPiNc5ZC2cg8ME7j1kZnfHqnYKtr5mbxIZjBK+V64KjmhQn6G1Sa?=
 =?us-ascii?Q?Pac2jdLMdpZra95Z0heQvTZlMRcR0cg0BtdyOqbQSjlR2dMR7hCVSB1kWlez?=
 =?us-ascii?Q?RwiqS9BYfhmrMXTRfwo30usyg84J3gaHwidvLoPjI38r1iaUjRJt12nIiWUJ?=
 =?us-ascii?Q?4vr7pRwGEeF0NBlHMrgFwGZaWe7CqNYCfmFvt7G6Sk/4CDXGeLXEodqJwhOw?=
 =?us-ascii?Q?MOhoal80OMfa8PIU/Z0haJ2uWnrMM8iypeuK/FYzPwLkBcKvSugC4EwLlDqM?=
 =?us-ascii?Q?OY+p8cUfuLPXp36fKdZ/vU8JVZNWNLplwG/RjNYJVmbiGJh8ArF9FnmTl2D5?=
 =?us-ascii?Q?yhrsGvn/YMGEfr8rFBL+TkYvGDeCHI0hAgbF9ScFrY8h3s6J3uuY4v7Zn73v?=
 =?us-ascii?Q?YwFP52ezgmY6bIluBRHpeY+Z70TOpqcQM92x8XU2c7YQdjp0AfzuAdT9LQpg?=
 =?us-ascii?Q?nGQucFoyTFxykjykWgdbEzqPi+L9sCuRtfFtSrMeP3MUmtDsEqH9EeS9HTRP?=
 =?us-ascii?Q?y/8otkdgAnbHnIADah10LRTMCG5WzAyIEEaqBHzJjqKSNx5bmkZpQvvcjRdZ?=
 =?us-ascii?Q?4Q43LrVm7RmUF9wE8/JrdF27tua8//LXw5Lft26+DZyltHzuhP4gHC+4qN6L?=
 =?us-ascii?Q?ztWByTniJjUJOqGRjxRLjR1lUlcHSlIGnDgZfm7mEJ3y9g9Z7CsjfMDYaoGb?=
 =?us-ascii?Q?EYfYVbZxFRiY935X5qf2WevJS+fA5URkiy1l8NV/nhLR3TtMtyfuO/KeFT44?=
 =?us-ascii?Q?qKcm/XP98nAtBN1Boh9nMrt6uyQYMAOg5d2IKQshexwhGTQbbA0xA/QsO+HQ?=
 =?us-ascii?Q?EmWiiYew1YcPMEwlgAIJk+Tr2O8owEWjSXaJoS55j3f6plnfKF5lUXwd4T94?=
 =?us-ascii?Q?AjQX6CouMhpRepm6MtZGdMrl2SAmWU0JgM6drekO7tV73T2uJxTbhDsFKCzE?=
 =?us-ascii?Q?eYXlYLYoatIY/nnbAHaRBqFfREprN+G/BzgvzWHLZJzXNeQirdZuUsQ6yKuX?=
 =?us-ascii?Q?sJLfHQugqe0llamzs7sbGn5NvkTZ64XC552DWS4+bQWACYReV3C62gkskiY3?=
 =?us-ascii?Q?xAa1IKH27fG+npHy1ACvf+96Mr8cl8DcFwcxh4YjDelzIEMm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7ff847-cf4a-44f5-8d6a-08de5775ec5a
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 16:15:12.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y15qCAbYzUWBPrBowSVxSIWHRF5kuEIXW3lrx9TH4UCNtLfefj98uLGicsSL5Z705BmkozTJdN2OiwZFxrWEgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6888

On Mon, Jan 19, 2026 at 06:02:26PM +0800, Sherry Sun wrote:
> Update the fsl,imx6q-pcie.yaml to include the reset-gpios property in
> the Root Port node.
>
> There is already 'reset-gpios' property defined for PERST# in
> pci-bus-common.yaml, so use that property instead of 'reset-gpio' in
> this file, for backward compatibility, do not remove the existing
> property in the bridge node, but mark them as 'deprecated' instead.


Update fsl,imx6q-pcie.yaml to include the standard reset-gpios property
for the Root Port node.

The reset-gpios property is already defined in pci-bus-common.yaml for
PERST#, so use it instead of the local reset-gpio property. Keep the
existing reset-gpio property in the bridge node for backward
compatibility, but mark it as deprecated.


Frank
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 12a01f7a5744..74156b42e7a2 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -59,9 +59,12 @@ properties:
>        - const: dma
>
>    reset-gpio:
> +    deprecated: true
>      description: Should specify the GPIO for controlling the PCI bus device
>        reset signal. It's not polarity aware and defaults to active-low reset
>        sequence (L=reset state, H=operation state) (optional required).
> +      This property is deprecated, instead of referencing this property from the
> +      host bridge node, use the reset-gpios property from the root port node.
>
>    reset-gpio-active-high:
>      description: If present then the reset sequence using the GPIO
> @@ -69,6 +72,18 @@ properties:
>        L=operation state) (optional required).
>      type: boolean
>
> +  pcie@0:
> +    description:
> +      Describe the i.MX6 PCIe Root Port.
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    unevaluatedProperties: false
> +
>  required:
>    - compatible
>    - reg
> @@ -229,6 +244,7 @@ unevaluatedProperties: false
>  examples:
>    - |
>      #include <dt-bindings/clock/imx6qdl-clock.h>
> +    #include <dt-bindings/gpio/gpio.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>
>      pcie: pcie@1ffc000 {
> @@ -255,5 +271,18 @@ examples:
>                  <&clks IMX6QDL_CLK_LVDS1_GATE>,
>                  <&clks IMX6QDL_CLK_PCIE_REF_125M>;
>          clock-names = "pcie", "pcie_bus", "pcie_phy";
> +
> +        pcie_port0: pcie@0 {
> +            compatible = "pciclass,0604";
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +            bus-range = <0x01 0xff>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +
> +            reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +        };
>      };
>  ...
> --
> 2.37.1
>

