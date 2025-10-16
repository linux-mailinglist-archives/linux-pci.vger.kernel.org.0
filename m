Return-Path: <linux-pci+bounces-38364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91940BE4576
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1C4719A8155
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8069634DCC5;
	Thu, 16 Oct 2025 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WMyya1km"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160431C84B2;
	Thu, 16 Oct 2025 15:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629761; cv=fail; b=N9uQ9dD4j+is6ozqcUtCKz0VT9T+U8c2lJQzNvcQO9mVyu3vyb5VC0yW0xscOTcp4/2QTPqNw1KQxVIhwJCTC3D+ELfLq43DEVTidz3YiYDxwgd1JpgOe2+dGeZ0r3qEwjVK9TDh8kYpRezOgrlIvsCdbgMaYfev5xUGnWKV2ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629761; c=relaxed/simple;
	bh=Xrh3KohVrGEHdpVWdnSHasHdIOi/pLFZR++d6JcIwk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s+5w4b1UC8ZR5BoCJfj80TiL70f3FIMd1XCMv1ShpzEU7FnMJAhDiJDoXdpNmA1Nk4FTAG+P7zt1V+A95KguBuEyk+KfiQtB/c9TrVKjcREZbru0pNW1zUsmWvDqPLCqmHsL2b7gjMYACnEfE3lIGrBlnA1+bbsfSIy8iLH51d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WMyya1km; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMDsQF5MuFctqTLZNtJrsV3UvEfJHkfRSBTY2xxZpFxJTlBui6QeVQUAIFbHld+N8G33jBcl1bOYOT84czMPyOUXIe8ILsBhZpmbtdTn2exRhHGgGxfzHE/203c6XAC5KIivDUb9HzScZ95VuACKLSppBknplbYW2p4DOLNkLBJ1cLfLybNiHpk7KTE6OkPPgrSHEyAJLuu6PFZ4BKWKYg5yx2c6AgKt7brGcslBslIfpHi4m6/jItAXRnNpAW4Y24WcE+Tjk7YjP1juOfZpAzGi7GAIAK29x8qNg8CYdfhn47XE6H+DXDOXwadzk0ByLtuESBgHJrFZbeHQbheAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Fa1GuV/+5Udx01EzQpUFnoIe5xLMPhM8xGVKBW/qs0=;
 b=rrk6JZf1CcLzlYTtqB30aMtTRGGl3YgFwvtCNhVXgA6xx5M4ud60QDZJXyaLbdd+fzOhLmVwrO4Bc7VV2IyFkFiK46mihvN4bnLeJzqEI5SoRyt38Kzqw3aC/XIR0S5Bq4UaJanXtXzDtuupVsQIQOm3kwyy8ZEbE62ad4NSRraLgswijyST1tz1xKlOAQ+M33VDojfzB9n83FuwFoefol8e0JsCQR30W2WDH0iCju+ezCFBFpkyjlMDtmX8EC1CgH+NbKIx3G1DMqVnFhf6fhtaP9cg2UJb5bwaE6Ky/smbGuDoSOadDAMozSGCnIpSwMnDP/+n+XrFnxwt/+LHQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Fa1GuV/+5Udx01EzQpUFnoIe5xLMPhM8xGVKBW/qs0=;
 b=WMyya1kmCU8w5ozqxnVT0MhVtjDx6v2BwMQbGnOQAIiVPkWW+jxaruZyHmCCIpI1/HOrFMPLx/ER0bKgUQNgEFrmcTyb2Xbn+GAFebx5Ml/Qzg0wsJLm/RNfvARtL+JRiBHoX4D9tpYAK69jXwepG/zDVxVhSrOWr7u2JS4Pp89HaYLPcfFWyBsE7dJE4j18gDRG1EauC+aRKAuSkPpZ9zGLpyaxbPAOPjRs2WdKEosTuj2dYQMdpG/P0/TLuPFJPYQb5/+JcmknOS/at2kfXhjTnk5oIPT+4eMSboH3zU0rDGFNRLTd9gGLE2ZvwIpFIujmvFtHKZFEySdDfbgLwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:49:15 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 15:49:15 +0000
Date: Thu, 16 Oct 2025 11:49:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use multiple ATU regions for large bridge
 windows
Message-ID: <aPET9G2NQslWt+dD@lizhi-Precision-Tower-5810>
References: <20251015231707.3862179-1-samuel.holland@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015231707.3862179-1-samuel.holland@sifive.com>
X-ClientProxiedBy: PH8PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b381f3-9118-4976-1cff-08de0ccb8f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1NcUp0JfJiQER+rUBX7rvz2KGLp0+x/VEN2W3tTp5+V1JfG/sISUvssTNCz1?=
 =?us-ascii?Q?T4y9NzHzf7bpgOcenkdhR2DG1GYs6itcr4sz5M4OeAyDEPpnAAUKdyypkNzw?=
 =?us-ascii?Q?q041rpUtP9gP8D0gDLKY78p7qtxEcWI41147RWPYwy3QXnU0vmqDF0DOj/84?=
 =?us-ascii?Q?+hzHh/N4YIOxphwKEO0kYYRtERQCnrHQTzWXVnjg16sxjbGfLlgdpr9cnKM9?=
 =?us-ascii?Q?Kz/RS1VQXcchgctRelwqVhGI4s7ORGVB798mglYXyM2cge6vXQ3fF9K5gSBw?=
 =?us-ascii?Q?H9/UDKf8od43KBq+VEVfCnsGmQyTlCgCGiFjHU/foBSwvc6F/S0ktZjCFhav?=
 =?us-ascii?Q?Dt9mk0e2KLxIC0ukL71zUthlmgNYZJIUawiuojVleD4B0nisFCk8YyQZJY+Q?=
 =?us-ascii?Q?QD4FZLM/sRRisTuIHmjVKmDLHovaz+4whDrMrsjjwo1NHy/ld1BI9LXcnuZ5?=
 =?us-ascii?Q?8+XEzX90p5bZQQ+iXSuDaMVHNbrVSKndZiT92TUOXYt6WiPyWXqqA2XiDBOw?=
 =?us-ascii?Q?Q1m4/19hNg56GzE76LrHLiTYmwLscq7quGtm2WPfFpQlPgouHWeP0Tjwag2Q?=
 =?us-ascii?Q?5pm+UKwCwRWTpZtak6uLO6tmn/TXmgKoCfumvyvBBtryGkh8+h9oelglYhn7?=
 =?us-ascii?Q?dIYr1jTG6w08phlx6UZAYw/tSvxJgYyp8FAnLXfe8eduLBYS8b4zSg8HoU0n?=
 =?us-ascii?Q?zYcBnBB9Vw4QmXO2sweFsAE9t10R9Ln91DOzPT00aCEDiVYP4SGoLP+F8YvD?=
 =?us-ascii?Q?l6s4FAkqWzj6gwL9YIYgWn7W0Wl10/Z6f9Sc+GUxFLZZbK+EQSyoCoR3hA06?=
 =?us-ascii?Q?y6W7Dp93JcaxkCLlrNR3kiD2LmqO4ttHqP4kAO/jZzq9Rrnwxi0+SMjMIVZo?=
 =?us-ascii?Q?WkyTNzGYIeqBYBpKegK9cRz+qPaxrY5tdIkGaijYjB1X7I1th0V8H3JklGER?=
 =?us-ascii?Q?ZEt/dm03kdyLhUQVIFzNPQbUhZFsyUxdiDFE9Or6biKRV9iONG6g3yxpaKCi?=
 =?us-ascii?Q?FGoqip1iXCCbjPcA1jWiBJT86l0Zp96EwSOYVZnmiliXnTS+uxGR80/xKFTy?=
 =?us-ascii?Q?aJaIJ2CxFvQKp/x37G8y9Oxs2Zgq4LGAl0LVId6x3YWYChM+c4a8Rv9cT96y?=
 =?us-ascii?Q?9mBp4EWNLNG0JxzgmgYc0h4aEP6Nwb0qsNQCO3QQaiYvdDk2OrSe4cAhGKsL?=
 =?us-ascii?Q?dMa8RmhwSoUbGrg8cnGiz2/0NOf2e0/QfQTeFerM+9xOL1eEGaIsUnQE/VqS?=
 =?us-ascii?Q?Y8o86CYUjl14vKd80BF0m+7zkHmzzNA8J8WN2Y2jg1kT93wBrNfqd8iINYYU?=
 =?us-ascii?Q?As9bE0GTTh2SFWHmk39Fo/tg9PCrUzYZk/+u4kvClU71FpETU074iClKuf5l?=
 =?us-ascii?Q?cxiulh33kKjcvCo4sib31D6+OkSuHpAExxd1nLThBmLi4cq9VEpcrJIB2AGf?=
 =?us-ascii?Q?GAv0jYgmUkLQkEuaAQkEhGKSEDw47lO2me/o9pOGvXIC+1BtNvEmkdXHNdCh?=
 =?us-ascii?Q?v3TfIQFzNqPzPdkk9yvb2bblH1HD/6kK4nbv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sa/t5/B17VVWVdEe0IPl75xwumPsc1aJb/Zs9IQkxr5Dxgf/FzC3t3La1H13?=
 =?us-ascii?Q?ltgHVLLhgTyJrY1SwQmdMpEzJPcNLtyYWj88DwjBS/JZ/SVnF6vc0bjUUJF6?=
 =?us-ascii?Q?x2blFKLXOusWA0xstSKyNMeQn2KY2gFEQi2dLRJXe8ExnBHQTtNvrxGnWWGu?=
 =?us-ascii?Q?z690R9XRUpqGJwcgygPvR/JFwUUhHLLTtPvbbUvwEihNt5dFPPTmMT3RBjxJ?=
 =?us-ascii?Q?hKETWizOeHm3Hd9o8ngqzLHoX3Ag0qV2lo4djwn1Oj0ZK9beUUQ0rDRpAnwr?=
 =?us-ascii?Q?be8pyO7DHqERduiX3lf9cFAU3AprEZyZ5xeRTq07+Sv5JN9lLPHDIm731Wdr?=
 =?us-ascii?Q?yUulFfUF9l13p+yd31qMPLVhZRVkasAUl58B5q69YjaPSYM1jvL68H2SahjT?=
 =?us-ascii?Q?MBPtVqibh4dLll7OlMFA3utUKS04kimUpqCnI8lkgb1LC78mY2Yc15AxK86R?=
 =?us-ascii?Q?cQpHyLL9aq31b/Z80MOiUhN9pcUknvC84Mk3Rk5HupNo8wmXHeFO0Sp82JYa?=
 =?us-ascii?Q?IHBwYG0qpCiDJhwSOBE3OJJKCQjFforAXjq5kGg9ujMKRAaovaBlCUVR7ixg?=
 =?us-ascii?Q?zw4DsvDp2IoeuoqS16n9uBcDnV7UPSYWqW5h0k6fhdhAooDBOWRFdg7z8H4t?=
 =?us-ascii?Q?2ERL7rkkFb9ccG8l1Td3CXVKc/ckOpAqENpt38B5WP3QaQoojW/Ei9TYxwoX?=
 =?us-ascii?Q?80wn/GqnDfAiQOhA6LiPzdu51SKV90t+tNKJXSr3rJwUyIlU22AM5LIXjMeY?=
 =?us-ascii?Q?wtvfzhpkub8dHcs0M4DaAPlNKFuFrFdrukhAWMErUa75oWrh6+pkmoQZf0ma?=
 =?us-ascii?Q?aOPEReFTz3BMARXUF9xKy4aFk/cbd8mDOiT7ryk+qyxrlT9wbvutgjRoUVUR?=
 =?us-ascii?Q?vRrIPGBERGxNhiTqQSq8Ipfa+AbAqLHfkYqVK1QoWmyHXQT0box+qIl/wOuw?=
 =?us-ascii?Q?VgiTebG2rf6+DVyOMvCWM7meEkw93JGeyB+MG+uHgVEyhucnYYPNajmQYKUq?=
 =?us-ascii?Q?zJjyJzIHe/364jYmT9IDtBkMaHvWg7C2k9uP7qrTaOmmleSIJKnHQFda28WF?=
 =?us-ascii?Q?upVduVlDMJijR2gYwCiUen4uOIB+K1fGHFc8Fx7Mk3ZVOyMwnKJpI0OqtexH?=
 =?us-ascii?Q?KzBwLbQhaW7L+rTB9WZqlO51JL73YGo0n+eAqoe2cYZd5SZpSWsEDzBNRVxa?=
 =?us-ascii?Q?7vXGHmDTGWEtZLqQVLuKs6AxDo1T0Ye9Ynoxk9miWe3ZWDDjuTyuvbPi9YIG?=
 =?us-ascii?Q?PHgaqCeZn3iTIznqEEPy1nigOa6K+9kk/OtBKn8qI5rtfwE3Ux2fPD218ktN?=
 =?us-ascii?Q?8TbQMwVmhYRbBemmhLT9opR3RZ3jmiWiu0X+KZTUFX85DEX3AEQTiH7cVb5U?=
 =?us-ascii?Q?9/DYjWssepOdHzFz60d1B5kcIsrEJTEObfngSUe9PZQ5P5g8+kTN1CAIZ5Na?=
 =?us-ascii?Q?rIyKIRJoJvVLaOJPPeFp4Pff3YwQl8fPAZHLq0jQi8TXV4pvEqMnC/Glf+xx?=
 =?us-ascii?Q?KHXOCmzAhEL6vUgyTUuwcqTTxmHMrCUwrzo8MlWONHhVrXPoKJUx8Y2H0b4h?=
 =?us-ascii?Q?a07T8MrfuahaxAMwOxM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b381f3-9118-4976-1cff-08de0ccb8f44
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:49:15.6265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDmzj1daxlZBoRhhWSOgTr/5VDXpFKnSTqJWUOT7zqUlONmO/6hVDbAAO9FCGpQyL31AtwEdOld9hxGpvNXXCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

On Wed, Oct 15, 2025 at 04:15:01PM -0700, Samuel Holland wrote:
> Some SoCs may allocate more address space for a bridge window than can
> be covered by a single ATU region. Allow using a larger bridge window
> by allocating multiple adjacent ATU regions.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---

Nice feature.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> An example of where this is needed is the ESWIN EIC7700 SoC[1]. The SoC
> decodes 128 GiB of address space to the PCIe controller. Without this
> change, only 8 GiB is usable; after this change 48 GiB (6 ATU regions)
> is usable, which allows using PCIe cards with >8 GiB BARs:
>
> eic7700-pcie 54000000.pcie: host bridge /soc/pcie@54000000 ranges:
> eic7700-pcie 54000000.pcie:       IO 0x0040800000..0x0040ffffff -> 0x0040800000
> eic7700-pcie 54000000.pcie:      MEM 0x0041000000..0x004fffffff -> 0x0041000000
> eic7700-pcie 54000000.pcie:      MEM 0x8000000000..0x89ffffffff -> 0x8000000000
> eic7700-pcie 54000000.pcie: iATU: unroll T, 8 ob, 4 ib, align 4K, limit 8G
> eic7700-pcie 54000000.pcie: PCIe Gen.2 x1 link up
> eic7700-pcie 54000000.pcie: PCI host bridge to bus 0000:00
>
> [1]: https://lore.kernel.org/linux-pci/20250923120946.1218-1-zhangsenchuan@eswincomputing.com/
>
>  .../pci/controller/dwc/pcie-designware-host.c | 34 ++++++++++++-------
>  1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..148076331d7b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -873,30 +873,40 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		u64 total_size;
> +
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>
> -		if (pci->num_ob_windows <= ++i)
> -			break;
> -
> -		atu.index = i;
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
>
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
> -			atu.size = resource_size(entry->res) -
> +			total_size = resource_size(entry->res) -
>  					resource_size(pp->msg_res);
>  		else
> -			atu.size = resource_size(entry->res);
> +			total_size = resource_size(entry->res);
>
> -		ret = dw_pcie_prog_outbound_atu(pci, &atu);
> -		if (ret) {
> -			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> -				entry->res);
> -			return ret;
> -		}
> +		do {
> +			if (pci->num_ob_windows <= ++i)
> +				break;
> +
> +			atu.index = i;
> +			atu.size = min(total_size, pci->region_limit + 1);
> +
> +			ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +			if (ret) {
> +				dev_err(pci->dev, "Failed to set MEM range %pr\n",
> +					entry->res);
> +				return ret;
> +			}
> +
> +			atu.parent_bus_addr += atu.size;
> +			atu.pci_addr += atu.size;
> +			total_size -= atu.size;
> +		} while (total_size);
>  	}
>
>  	if (pp->io_size) {
> --
> 2.47.2
>
> base-commit: 5a6f65d1502551f84c158789e5d89299c78907c7
> branch: up/pci-bridge-window

