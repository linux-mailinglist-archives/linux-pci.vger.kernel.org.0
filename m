Return-Path: <linux-pci+bounces-41556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4811C6C26D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 01:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F07034FDC2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 00:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16E31C5D7D;
	Wed, 19 Nov 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fEPJbirU"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75C370305;
	Wed, 19 Nov 2025 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763513138; cv=fail; b=edH1p8+2EAOLaDyWgb+q2xKuuPAKI4Oyy2DV3C93op344nRsL00oafLYnafRcvF2JYTH9AbDmSu88XiuUXrr2+/m6wIzSwe23LE7Sbf3jmtN0qZU+c4sVHnYG5yCrHL3NJ6WUFqmnVuVRzzAUq5paJWQZAPUmkcSJ5BEuHlAn+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763513138; c=relaxed/simple;
	bh=M24++ijk44fxrdW9fBhN+5kJS/bWJVuAbSkCIqVP3oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bTdPO0RVRDfH04/Hz9JzfGBDp1oJcDtUsMwpbGq94LVXP2zPgOM1QL74Ky8RVy1njResexSeTL/Lvsid4XpjWqJot7f3pyAzZRPimeZTDGSBgEQaNCrZaVatSqV6Sy72T3iDoLBY5hgQz64jI6B1qE6oaPcG/1DzCeMF7StqlIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fEPJbirU; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD0huE4KqCVgwvFnrmn6ZDGguTGQpUmvbuQ0Ze1QAQMeY4l64MxaVyjCefylqEeLjFtcVB5tb2KkuJxIrj3ybp+iRK7Ek/CvDi47Osgtqr1WBVFRUl6dhqNUCAjvf0GTeGtb8M9WdFwtOBdY8ckUfgQCeHuCCOOOKkS0ra46khB5zv3Ft3Phdh7IiNGw3CGsezeZlMp3Z1wii8N798foGYpUyM/EVkgewtSFaGokelKR3dCUGcSxWMaFNa90nnHgwsIHNPKkdby93daUs/WIMP67MpQ28047Sa+4EtEKda9r2ZyB8yqQtOyNerXT8g3KNGH8wGKiyjBxZiZmEDJMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CdqHJZnuwrDUFxF1NksfCwLGDLF/9XYuEKg34H3ExVk=;
 b=j36ix0GT9n2YhzPuubC+5L0SMO+hbUeO8pizojuYa4nNXG8SvGxDp3SFJcwQMRy4JU77XJ57cTPb5cfppbpyuWXNua3dwy1qGe9RFdHbad2QcLajIW6yoTLpIvEbBVsAKX/Bdxb/xJo4Pa+fEZKTySDjGs55uR4LLC533WGlnY/rgXoHFEjyZZ353zh5Kup9Ub/5pphfzuH5KgjqQv1hP9lmzb/7kLZU5jHwq6VNPvl4L6AKc3xb5b/5xAX4Gq8jwtNEmxRuLfjTdULw84veKofcQONPaPGjgcQ9vCVBWkwIXirLUyqe6Cj7DgTkDGN6Czp5rPeAZPAi4bmD+X7jPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdqHJZnuwrDUFxF1NksfCwLGDLF/9XYuEKg34H3ExVk=;
 b=fEPJbirU67257BRLqvf9W9hadHwxsdAp1Fk5jlIlYpX5m0kZt5YzC9Sln6SSTUxOPTXAkvKNdncWnt6X9nG/GPbtvaCnV4JYhqefReqbbJ7aaRpDlGS0djqv2/buLck5o3ZPoW6rJWWwX2U/roACPLG06tn8XaMx+yuHXpDRRyhqh+MN5Fu2WzRWjCq7jI5ZQlinOkK2vpi2/BqSYaKQOUc4eWcY3+eMw3bzV5JHGYecQQ8CZV9zsS7kIu6rw8bVtTb2Mp/i4zkCKE7HxaATkrGe0+PVpEjjcjm8VIi6WMEHfxK1LWvE7GaPyg+h5LTLhvb/6bSqbzsmAHfaJ7eU4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AMDPR04MB11620.eurprd04.prod.outlook.com (2603:10a6:20b:717::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 00:45:33 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 00:45:32 +0000
Date: Tue, 18 Nov 2025 19:45:21 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <aR0TIeJ6CWeB4YmT@lizhi-Precision-Tower-5810>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
 <aRzxNMJ+byxZiF3i@lizhi-Precision-Tower-5810>
 <aRz3Gnw-0IRtUj9f@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRz3Gnw-0IRtUj9f@ryzen>
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AMDPR04MB11620:EE_
X-MS-Office365-Filtering-Correlation-Id: 075bf470-b960-46f6-f646-08de2704f19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYirQvx4hupJb9YfMnWWs0KKqz+nk+iNp14I2UMeNNBN04+o9c9o5lqss2i+?=
 =?us-ascii?Q?sJWHykQzf98sO7vrk0cuIxdPIiQltC8VeMXlG9QJsd6frlT0f8z7P+eFRhiT?=
 =?us-ascii?Q?c3NCmwHlsdR82GtedOQuvvbw0hpm/OOQnisD0cf7Woptbk+5hLvEIEdO1sl3?=
 =?us-ascii?Q?mga1Ivhgixl1JK7KnDUdwCZpfOUccPtI67+80/sMN06PsJm5zKJaJ1LEs1bY?=
 =?us-ascii?Q?e2OvWTIbHpaSZ70KSgRntqkq9Sv1LQiJYM/aDWUzzvls+L4Bun4nXxPniJh2?=
 =?us-ascii?Q?Vvmy4Z0xN5IKaTN8jwoM5e97q6s2R2w4qrx9wHCHCxXB25xamco1MBDHcKS+?=
 =?us-ascii?Q?EZ8gfMxg8m7XnIKP0Hx8qIo8m4JGiFVbv95OUz0m6fWIVuXh1tLKA+RXCeM2?=
 =?us-ascii?Q?kzygXjvCeNEU4HgfcDjpSBXDkceOPQJiQsBf3V05KIDP2b3AR7CzTnPEr+X5?=
 =?us-ascii?Q?pETqIwPzv2DvY0wrmOGuhizCCIYkVtuP5tqnGNynESKwhnkmwgw7WXhR0hgc?=
 =?us-ascii?Q?/5SVwb4tWBj3fejKv+sJU4v1+0I7TKkUUDa3dDscwgrW6wBkkjnSLTRWrNNB?=
 =?us-ascii?Q?xRj0g+K8Xmw2OsHpHUAPGqErD2ifzRXy5WB9RMFiURlA2mfANqoVQvmokLqL?=
 =?us-ascii?Q?ppxG3XOWI900S3ikh/kaGwRWOUlHsf9YUsoG1Ts3M6+/YkFpglHaAlbnmMXT?=
 =?us-ascii?Q?NklZI2D7XnYu0KK89EHwW6AA5LNeir+JGuY8ODYdmIZe68i5yeRZptiIOeEy?=
 =?us-ascii?Q?BX4oAasr27SiHq8BHEaAdw5xG4QwgYR/LOZcDtIsbVYT916nVdDLtG1cEYj6?=
 =?us-ascii?Q?ycE2S9F/Jzopdmdz2PeCO52j2EgYMXMlnRFNzSYejanMgMznEsAPiqkxRutc?=
 =?us-ascii?Q?BdG1scmONq1IZfeR0UZR2Uy2vXsKjdeeDdA6moji3h/DjkUq8aHU9DXV7pq1?=
 =?us-ascii?Q?7YTb2ZE4h6gyb8pRQxI2N7z06pm6cB49C6CrwFH/XnuIl5rdCYPEF7ZVyRbG?=
 =?us-ascii?Q?BuZa+84L0z4oR3YOLym40d/v4QV73q50UmXIC8D8gZNBjnUqiWwPo9Oa/LX+?=
 =?us-ascii?Q?Q8wXg4PRhe6S9hPTVLup1wzozCQKCAjEop2Bu0WDA2g9vsFVvEg+HKKom1N+?=
 =?us-ascii?Q?+tb/Y5JJLxzWw9VqRNz/PuEGBoNudSKLDrycTnejer90mCkwZUdxxIBstnLy?=
 =?us-ascii?Q?3QZSf5VNsYgUg4uIMYTGU0b1vfr4tUm6t49dsdcM9wcU4eL8mywK/dStC9pW?=
 =?us-ascii?Q?6Fc/L4R0yXXKwknHcj6/4KQVRwb9jBNCVc8vVLqed8oP8zbNW/7ZVD8+dbas?=
 =?us-ascii?Q?ji1RdDV37RRbekOY5n+6Ftcj02gpkqLPwVHBRtQnzKiQWDGR5A4pC+aVZ/6p?=
 =?us-ascii?Q?P8t1BT50UYB/AYB8v24DocmTcgdHNZ+8rpYMnfu6GTqYHcrz7OMfjZw7I/77?=
 =?us-ascii?Q?ID7dcsLw97/7MJloJnZasTGbKRGUSXoDZQV3XPh7DqaPOOQdlpev5g1bBm5V?=
 =?us-ascii?Q?8oxjyEJUOnPT4+dxxFuHceEETOeydREv5qaX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6H/eQT4kL+2fBg4Cvq8dL+VYIKnCT4l8C64PN3Ns+FvRS1VC05XD8Lwvf6Uo?=
 =?us-ascii?Q?Y4c2RiAHbLxlMf2l6FoRUay1poCxhDTPXBH8ZuY+G2pmf+2b95TmHeZWKyEd?=
 =?us-ascii?Q?w5mj4kEvsNiLKqtueT6/SjYaxCsd0eu3fK09Xo+BgCiQGgFUg7TR6+trHkaf?=
 =?us-ascii?Q?4RmmyBUG1/xhq+93iIsy5isCaQgjGRx4n1V9/O9vy468RnT8kPizcMDTlNTn?=
 =?us-ascii?Q?MkvrbkQLv77TCRRLX1L3UG4rxNnMVG/0A/dvB+3dQ5EaJ8P+o08HPKT0+AP2?=
 =?us-ascii?Q?7PL16lKAH5JNr/rP4ARAZkLRoXcSW1EzszBXa8LTXW0fKBinqCxKmnsoPNt0?=
 =?us-ascii?Q?TsTh3mn9i0uY+lVLBwS2QLzGTwgK/EcANJeKYNEpzqOtrAgezjFRvo0ByItK?=
 =?us-ascii?Q?3onUr6c5Aq2cX12mPGfY9l5D79AM75qI8YfqB5hBnjjiEW/SKyaQFgUvR2hk?=
 =?us-ascii?Q?lTi3J+4fgCZ136+r/0haLqeLPfjjKGdpUu81eGR+Wq29cevuwEL/g1Emz5Jj?=
 =?us-ascii?Q?sctk+hP555E5i1+33JXWcT6miZRq2zz6VUACS7xm0uSpKSlGFtQg6eKDZ5qo?=
 =?us-ascii?Q?Zd9iStBvKRy7c1LsCU5O5MYxHBQGn8Fi6MxXGqGcR1RiJ1HFNmrHKkTyoH+U?=
 =?us-ascii?Q?QVxs1ALnP6HG5+aYDSvssWSW1b1Xnuj2rnt2QnhJvKplA9RKpkecI3CtN0aM?=
 =?us-ascii?Q?UuYtNpUFutspDs615zwXJ7zh5bO9n/QI6EXgXMK3ZTeEWvRU4Vf/ZY3/WyWm?=
 =?us-ascii?Q?mIVTw/jRpDp/lFjuFKaTIlvjSTlEOAtNiefjpTRxIXy0qWuS4pC16vwOK98p?=
 =?us-ascii?Q?bmIOmivBzad5QDme4e0WK7jtZ+YQi9hk430Te27IuQBYfhdBZJ8k7xPySo/s?=
 =?us-ascii?Q?3EjH/O0SWohCQbJn6q6fvb1uEERNfvVafIOI2cgLMBhhj6ePHS+1H/oVJWaj?=
 =?us-ascii?Q?oy5JosP36j8dFT9x7JjJIF1nRmqoJz/K+vj++26PFUD3aMmAk2fRy8ywvBiY?=
 =?us-ascii?Q?C+cPxDXTvOhcLBGPXQrPHnPw38Ee/fMOoWH7coeHx6m7ZK1lHfJLmxT798ei?=
 =?us-ascii?Q?DWjB5K/zLDGF9FeCfdonGStPK5Z5IYbXTMLVHGJ3SWCUX4Ei/A+8jBjxcme7?=
 =?us-ascii?Q?NdeBIbiqw0T1GWkGSWE2uM9CxU3SMPMtH6t/K+8otcKfLnS1xl9LV2YCWAHW?=
 =?us-ascii?Q?K2w1/oaDsZJ2RoLurBuY5xbBc12pL+pLAW0VowCSu+wwut050kL92HU5B7RT?=
 =?us-ascii?Q?gey7RZmGaom8XtRdfvKjaGFyydXhVfp5kl1rhiDdE1LF8MUEFUOZZ+q8juqc?=
 =?us-ascii?Q?vCB3RcO+feeP7mgutzH5ey95GCIP60S/jongwPtDcTV5WxvXT0yADqDR9B5t?=
 =?us-ascii?Q?lFtknnrByWK7ZvAtwOcwY83gRniCK3Mt3TH8RfP2bXUTEczXOBAEHb35oYx2?=
 =?us-ascii?Q?japgLBlQjZdOg8yp4moQsO+jKFInZsqvYlBp/HEib7ufsRxPG87O0sjkiAaX?=
 =?us-ascii?Q?HDM9x9q1k8gQ8dyZBVnig7OnbAk1F7YBXU9+Myf+8o3RcHYK4CmBFVnZmiuU?=
 =?us-ascii?Q?kWFWSMM5UMIrmNkkbWfbEYmGOMD36HdwRRPCKSWC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 075bf470-b960-46f6-f646-08de2704f19e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 00:45:32.1873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr2tbWXai7pflyzmv84WvcwL3ttlymCzXccXN7yFj6tm8kByKpdkHcwlU1GjvIsda8riMTOBLd8xm26PCtZU8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11620

On Tue, Nov 18, 2025 at 11:45:46PM +0100, Niklas Cassel wrote:
> Hello Frank,
>
> On Tue, Nov 18, 2025 at 05:20:36PM -0500, Frank Li wrote:
> > >
> > > +	dw_pcie_hide_unsupported_l1ss(pci);
> > > +
> >
> > Need call dw_pcie_dbi_ro_wr_en(pci) to access PCI_L1SS_CAP.
>
> I disagree.
>
> At least when checking two different versions of the databook
> (one very old and one more recent), the register fields that we
> are touching are all marked as:
>
> Dbi: R/W (sticky)
>

Yes, you are right. Sorry for noise.

Frank

>
> There are some other register fields in PCI_L1SS_CAP, e.g.
> NEXT_OFFSET, CAP_VERSION, and EXTENDED_CAP_ID that are marked as:
>
> Dbi: if (DBI_RO_WR_EN == 1) then R/W(sticky) else R(sticky)
> Note: This register field is sticky.
>
>
> But since we are not touching any of those register fields,
> the current code should be good as is.
>
>
> Perhaps your version of the databook says differently than the
> two versions I have, but considering that they seem to have
> intentionally made these R/W without the need for DBI_RO_WR_EN,
> I don't see a reason why they would want to change it even in
> the absolute newest IP version.
>
>
> Kind regards,
> Niklas

