Return-Path: <linux-pci+bounces-45192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F90D3B11E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 17:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68B1430A859E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 16:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF4312837;
	Mon, 19 Jan 2026 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nBP+m2F7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73EF29AAEA;
	Mon, 19 Jan 2026 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768839868; cv=fail; b=QtDyY3d4S3N8KMvxhdpLjgy2apzfqXMjyhqqphj1+2THgZ9MuzanS6fhdNeQAJjghsZ8RZsSb/3LOYXBjzGTxkhxAzgtnfTBPHkpk7enZl1KSvMcqSbkRHC4vvh9IT8HEA43RBDDF8jCPSLktWmYvzOQwdppMHe/B9DGn5E/j3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768839868; c=relaxed/simple;
	bh=ZcN+ix0wfls2tEw7rRtFZ7wcZz327+iuN5+CB2d7qsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lQdm5Ww2Rhnt65y5xeRGUfJqAQkEknb9XGRcYdoQyzHBywuJnRN6OTG7Vdr25jKW1e0FgFrjuRv0bi+ays7sUgk18Gll8v7+llTXQIFlVNCzCwQL21BbskXfTU8mlsmm0FRHr76ux3x06M9MZdx9fhHT8gNtC74Qn6lm/oaywZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nBP+m2F7; arc=fail smtp.client-ip=52.101.69.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xywzHoLpJ+n3Xab/AEIn+d3v3API0Soc/QTtiBKVXBtznoj+rglA0qNvsdyUaW0ZxRAmuOMyzo/6HKOOexTjLEmE7hC2wAma/t8/XJOBEunRS7E3N2q0d2b2ewoxfd5UbAUeIUgN46vb0/8pckxF+KRsMtdRCyLp69QM3Z9Ue9wqX+RP1WKzuc328v0n5/RP82MWZ/dJ3ycCmd6xvsp00KWiNoZ/NGrV8v2GYtY/qkFlYyehwNpDJxZqyDhNKgSXDzhc2YqwSVYKkKmcgrSaf+vn8P0IlSQn4uFfdqsdF2DR7iPz5fRCRT/rIFUtq4nPgcjg7FVR10OoAuMFxFiQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2197TSPPilAJPujHDlZfcSsgqEqwzUAZfW6x7N0h3B0=;
 b=Qj6bZ0x/68ka02dP7GDROCm/AJmxUftidRqyOO8tNCGiHIiH7vHb0IxG/IzYgKMSk55ZTcJrQLfilFVtl4iQ19eBtcx5/AtAAJHeByOD04OD/ekpveNO85eGvkAbvb5NibDbG/2xb1Iq+4JYsaoi4sU9fHaLa20Qfq9FVeJU578PPb+LuGNA0oOI+qYpjbzAuWJ4KyPa0GVDcNyQ7gyUcHjWR5DujTZbH1W6fCVx+h8wOYo+/wdZsoAjbaUdDcZVVcPFbEZz45dXhnXIJXvT/ImC2nupJAoVzyBVTDyMC2n39wSMtRXNQ1goUrPId49u9jkDWRPBXotE9zNPBvw3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2197TSPPilAJPujHDlZfcSsgqEqwzUAZfW6x7N0h3B0=;
 b=nBP+m2F7iecGG1Z2jWkE0vDdCgEVfonAEe2dS4ZQVPKGaLkTKH6HAbEk6+9z0iWqUU47IezWbDLNmwmk7uIAb7hE5FWR/qVKfrk2ZXr7Ulv4RxBME8TO33hr77/zYmae8hHr9bv9uwO7TeHuMWXNDEm3mp3ZTlQkaAwcfT4PUMff9j/NW1B03o25uyil1YnH3mpxaQsl2n60Z/uNnNQ+9DOKZGPY32z/H2eAA8kvSFomIN/jHdVMZIyPQX2RSxN+/gD5rypBOnxnbY3wQmnRnXfFK/VggOVuNbSduKGVMFUTLrOuKPeWzJQhN451vNsszRKPE+1SaaxtCcnEANRh0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by GVXPR04MB10610.eurprd04.prod.outlook.com (2603:10a6:150:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 16:24:11 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 16:24:11 +0000
Date: Mon, 19 Jan 2026 11:24:01 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move
 PERST property to Root Port node
Message-ID: <aW5aodaPdjYwAE1V@lizhi-Precision-Tower-5810>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
 <20260119100235.1173839-4-sherry.sun@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119100235.1173839-4-sherry.sun@nxp.com>
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|GVXPR04MB10610:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ab0b7a-64f7-4bbe-8514-08de57772d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|19092799006|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9FjeSCOrqWp1DEXZ7jvxyMNaOUmXTS3Jl7Sk9lxJrzroA1bfv8TB16rHytbH?=
 =?us-ascii?Q?yT2IruThg/1pkEmLF/rRr99vwQCuKX31g0tegGL1Mzb4NrV3Js/Qv91/O0ab?=
 =?us-ascii?Q?ofJd23aCKrznC4qE9+lx6FIUBLckSivUqHkIEMo0OVVvp0hTfSWajXRwOaeo?=
 =?us-ascii?Q?MDF5pCWuOYX0zRr9zF/Ql2aBcpdGh7OSRyqN3NuPhy9o6vXQA4sPnExbjMrH?=
 =?us-ascii?Q?5sf0c6M3QUSzDM53JNYJQkQ3eqq10nfzPyM5F4MjTxLPlnTP9og6QLtoCaC5?=
 =?us-ascii?Q?QumnniNXZn7+8z/Ygeh/zGXk4KC0egX3F9ICr+FXRlHXAZbtpHS+5ad+Chps?=
 =?us-ascii?Q?lxC310U/yMaDDdhCQGRkmK0olYmDzldAKISiVWsut/QR+wAgQSnqJxm3wlhR?=
 =?us-ascii?Q?s92+9pSTvIRnTwfUw3QdYUXkxlYreMnighjZhCZ1bZErls58imsN1gmrcGbL?=
 =?us-ascii?Q?64UFuzxyS6mDpKqV9P1uiW4NJ7wvkULR2bpQ2ViR39lVwEZv7p3+X1Vd7AiY?=
 =?us-ascii?Q?Sf7DAfp6MS1VMFC8cvp79D4zsKdfuC11f+gnhvNwL86dNd0JOh//ElkTTDKr?=
 =?us-ascii?Q?Zt+g6WwBG6CZiIp9wZHmUJYj6iCtLlWXLttSYuf21tsZzjst8GQ4BhIWZ4rB?=
 =?us-ascii?Q?spxSwCKeAq4Yb5JpRMK2ADxeXOwPD6sJj1DyAHAbrt3fB7vYd5jkI//729AG?=
 =?us-ascii?Q?M82zbQ9xR1QwMjf2uUGi8qtcgxxBwziNmTbQBcBHCmRUkbXV6VT/RhjUUasD?=
 =?us-ascii?Q?LX6VvMKaTNrH9pajgsL8bPdKh/iK3rGzyn1Au6F5fFPYixlp3Rj6aemu3rkr?=
 =?us-ascii?Q?uoftGPpBRZ8JbNVBK6ZyuzRaxdFOq/eBWFkUIO+snQAAa76U71ZI0Wmk88s9?=
 =?us-ascii?Q?nHLKH8ymbF8Qy6VhZWE2jyPOEO3WzDA16W+lPhp3PeCiVlYU0EwnDI1+vYcr?=
 =?us-ascii?Q?qgMMKDgq5gLavW4eoQWGtesc6F+NF9puH8BFPXxe4P+xN7jL/tp3aVR5P9Pt?=
 =?us-ascii?Q?VlgQy9wyIpHYYOdToawGrZ/yaYG4HCiRqoHpyITTPplVV9wkeHNbM1N18kOI?=
 =?us-ascii?Q?xIKRQYp/YmiNKyb2uALd/cCvbGo9kuCSEq/aFrRTGcOGJZ6pPT2DiIB6rA9G?=
 =?us-ascii?Q?i0ausbtNJt4rSAkD4+AD0jvjyFUX/NCJdvNZdUlgWgvkbZa5nL8gIZd56HBP?=
 =?us-ascii?Q?/tGFhLp9abeI/HYK3HCtypLFVGN4c+FFdAKIVHyypOMr9j5r9PnVNju5ZSb9?=
 =?us-ascii?Q?tNc9IsdG71xX3OoAJuyPzyAxiKyONfjb4jtkvBw80txX7xHtBX+MVcM7uPFG?=
 =?us-ascii?Q?cOcDGKTx0Q6BysvxoD+lx+pf4K5jKp15xqw+4gK3CF6mm6eInen07xzONEPF?=
 =?us-ascii?Q?bpWjJfCNrAisPFlGFYQKOZRASGEZwSXvtavf0vhBUqiyvf40Yj4t1wgaj5Ha?=
 =?us-ascii?Q?UbaAC0Yu5FW4clD7X8kRZ0lgCiElod816/8Ot/4fXsrOhNyjlB/iiIA74C/G?=
 =?us-ascii?Q?+LuhPTcZF0fACFY8gMvbEMIzsJICx300ynljLh4e+J5t0UbTMt/6QL9hrchZ?=
 =?us-ascii?Q?HH1kq6bhMHkFqtmq37wLGUH6OTYporV6MGc0aoEX45p+8Ue7fc3tAl10y6Me?=
 =?us-ascii?Q?SKvPCP9czSg5ifpqTt1IDrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(19092799006)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kn7NUiP0uQuD9T33tlRQ+R5uDDY9eyggnpPesIktvlBf4x9/Pr6aRRZ6bG31?=
 =?us-ascii?Q?W3V5zcjp5l7oT2HkuYtGaipCJagnWLGAEzq1zSvhqimKHlFZdIP/yKQwx+3v?=
 =?us-ascii?Q?p58tjNMZPTYfByoFPqUHF1UGHUJQv66XuuHpuaHXCAcM3EI7b6ZdoZPa7DfP?=
 =?us-ascii?Q?+bIyLiivXZQxuxwm/XEa9+2VVF8/eaK301KT3WuXg0sVZXaK9+gm/OGNFRi9?=
 =?us-ascii?Q?Kidnxan8wHI3ctjLV9I0HLVA/qmbIs0bgKsKxX91n7ghPU24kCyKweaySnf5?=
 =?us-ascii?Q?zE/t/ZCLpYcZT4IDZYxpJy7gJmHiJ5fIt+N4tDu5DRbWF+PteJYd4kFUNX3W?=
 =?us-ascii?Q?yilTBltzruU1V+AIz/q25yhZ9t5cY2AKxLdwxeEgeLM4fZV5eKOZR1s6uQf+?=
 =?us-ascii?Q?2qcILxcqoZLw2dD7UJ4St5HFe74OD/8DMyLaL/d7bHphevSuR+ag9zcp232e?=
 =?us-ascii?Q?YFUfI0PypLnkAkdQdcjjzQhSPFkO9Nt3VkO+PuykMeAss7Xyv3wBYoeogvSQ?=
 =?us-ascii?Q?SScptdoAfgWY8rZ+veil8eJ+tYOlKrKm4fJW+DMxdmvDfSkEHXLaR5P2psGB?=
 =?us-ascii?Q?RUTmZFZRKN6G7CFDf36eDmHWUH0NGMiQSspbSbAfXWTyb/wtqYKNr+z9peBP?=
 =?us-ascii?Q?nGgYGRqx3aHQ8D7EhpCdSFA9nsqAP7hsCrMO0pBs6wFYY9IjyWJJNbedmse3?=
 =?us-ascii?Q?PTylzGo0RNz701n7DHHJR9kTD7Twk4T8BI/BeXZXMGchk/y9J55HUb0d37hC?=
 =?us-ascii?Q?Z/2lfwos+1M0Y/6eBrsw9+xjwORjZyIoLp35Mft0G1QwsCLGKk62DWARiDGR?=
 =?us-ascii?Q?EEsu6U7HMjytm1R/Hqk04r96jogtCRDugjZDn2fsQPyBhMdElmUbo6JGj1b/?=
 =?us-ascii?Q?bgw2t9vPPNb42l5iVMy26gv39mWElLDid56Emi4rF+g9pzobJPYZbgbiegHY?=
 =?us-ascii?Q?CrhkGYO9aO7P/PQ08pVYW3ZCEixyYvBov3AWOrh2d9ZsBLaxn/3ljuiGHCDw?=
 =?us-ascii?Q?oRAG80gnfNtQnzcEQ8Za6ZBVyLyXG3+/9fE11wwY31OI6s8c/CO1OS58lgeM?=
 =?us-ascii?Q?aPEqhtFsb5htTpTIElO4ruMD0nsUfB9gk8avVrBPUUvlmFC9Ei0hge6daLpF?=
 =?us-ascii?Q?ALzilhiev2EMqV26pP3bV5b0D7END4aUHZuRQYGr6C2aq7prqazPiUuGVOob?=
 =?us-ascii?Q?lZGA1EKR83bIRrWDxVd6wEnyT74yf1oOxj/7utcFRSQamgvUoA4BnztXbIHo?=
 =?us-ascii?Q?fSYkEHegM8B3qM9kQ6h6AS0wEaStQ0P72F9AlYU52phJFdUIMzIbJLg93OAt?=
 =?us-ascii?Q?whfdQ1DzIAmoONkAaSYfJgkg/a/pAnz/slK8bnoSZXX7B/BfQXoCu0FnhmKQ?=
 =?us-ascii?Q?8jCPXC7QXm4//v4TdUOrwcVo55xxttm7294lh8r3zSPBaHpDhaEFl4qz4Fdt?=
 =?us-ascii?Q?A/t6gjz5NuYdv+UiVgHtQdCtqriLhFfnZhdnwoYC6mig/NaUGm8LpFx4+wbQ?=
 =?us-ascii?Q?f4nyO7xl2Z9u4iE3gl0TirXpGghBW4XLr+8HAMozSTqKD+WopMOuQ8rxyzrQ?=
 =?us-ascii?Q?c+0guHmgAsPjEym0a1hmAWPaU0iKIzITBL2lluvO0Db6ktoD3NNgsM4vweXv?=
 =?us-ascii?Q?IViLS9rcH+zqqPpVj5Wue1hHW/OMV1B7kTpCUf+5nAt3INGLJkgW+fNcZFJB?=
 =?us-ascii?Q?BrBZQLQP4ydQe2wWzu7O5XKExy2NBb5NYEfbhJfzcp80LK8kKcQ1Imx0zMnx?=
 =?us-ascii?Q?4oIwKcJboQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ab0b7a-64f7-4bbe-8514-08de57772d7a
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 16:24:11.1112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWblaCdv6eviG7M8XSLJqjZ6+aOkzg+k0qUzUCrE+iQ8YOD7m7R389HXrVYdAjPG7djGWPeKnOUOvYfbpsgX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10610

On Mon, Jan 19, 2026 at 06:02:28PM +0800, Sherry Sun wrote:
> Since describing the PCIe PERST# property under Host Bridge node is now
> deprecated, it is recommended to add it to the Root Port node, so
> creating the Root Port node and move the reset-gpios property.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++++-
>  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
>  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++++-
>  3 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> index ba29720e3f72..c64c8cbd0038 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> @@ -754,11 +754,14 @@ lvds0_out: endpoint {
>  &pcie {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pcie>;
> -	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;

Generally, don't remove old property to keep back comaptiblity. You can
add comments here if you want.

Frank

>  	vpcie-supply = <&reg_pcie>;
>  	status = "okay";
>  };
>
> +&pcie_port0 {
> +	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
> +};
> +
>  &pwm1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pwm1>;
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> index 9793feee6394..c03deb2cdfab 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> @@ -287,6 +287,17 @@ pcie: pcie@1ffc000 {
>  				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
>  			clock-names = "pcie", "pcie_bus", "pcie_phy";
>  			status = "disabled";
> +
> +			pcie_port0: pcie@0 {
> +				compatible = "pciclass,0604";
> +				device_type = "pci";
> +				reg = <0x0 0x0 0x0 0x0 0x0>;
> +				bus-range = <0x01 0xff>;
> +
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				ranges;
> +			};
>  		};
>
>  		aips1: bus@2000000 { /* AIPS1 */
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> index c5b220aeaefd..c35c24623d36 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> @@ -45,10 +45,13 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
>  };
>
>  &pcie {
> -	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
>
> +&pcie_port0 {
> +	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
> +};
> +
>  &sata {
>  	status = "okay";
>  };
> --
> 2.37.1
>

