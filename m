Return-Path: <linux-pci+bounces-30814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5D2AEA574
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00168564C6D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCC620D4F2;
	Thu, 26 Jun 2025 18:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qjr/j6aI"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011034.outbound.protection.outlook.com [52.101.65.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870172F1FCE;
	Thu, 26 Jun 2025 18:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962711; cv=fail; b=DQwYW8UMDEQMn65bWfJZLPyjC89fsLStl5tphhG6QyipgMCTiULHKEZI+d4JL5uIhodASUx1fOgL4mgRxQyNpeeCvQ4cibPR3Ow0TOJthPrer0YjwGaWoyTFEewCvlGfhu+NysoC4kX11MWB2U9njp9Z+4ZkNDI4CkCcUA7Fwas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962711; c=relaxed/simple;
	bh=JkM/xbZAatE41deXfCtzfHUQTkLTodtJLMDjyA+CzQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LXMRNH6CZLb3bJALISckFJI/JQIGhfwuj6vp1KF4CMADlKrzmpvIZCWVq2/QxNlTQTjKenlxZ3Fe3eqePu9ykMXa9qGulYfxbsDvBHugcr3Q2Uz9vOGniz65awZNIrt1v6dy+gglGoJ7qrYvb3a2AlRwihnXTg+UgqSucNsbQUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qjr/j6aI; arc=fail smtp.client-ip=52.101.65.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIz4uExgJCzY7bZ2SezQKG4Lee73hR9HkbZlW4toW4R5W6OpiSeYYHqpEh3xinnW5RJZIGlWiS26oj1B7gwqWWPp7u8K9vrTyun3hF7wcL65LwdFGxK+8N+KmHohINDxBCHy4xjyWzZvOnocvsnTXOoIFkvwIQ28OfuX27aegNl66Z6cPr8m7e9X/ixahm/hN9+En4SuFty03R8NoMaPts7J12oJlENe2uA8vB8fnXXPhkoMKLshbIFpC3kOUyGZLJqMU3EX+b2AJQ3L/NUGAvUqWWih+l3R3xh9oiOyCWE+kQfYqtgOEeTPK2AV94VJIV1nPm8jngr9wa3wqVBHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Vq9okYbpY4wuKmVVB5Jr6ywD/sCcKlIU9ZgIlhkc4=;
 b=jbqrtqS6DD3wwIeaYzpI5cn8I+CjwfeKNXj0mcXrxPauZh2P+oXinGyCq1bFxjKYW5gTvGXThdjJLf5HliGuXDsq4w0lhl18HYzrU2LaA1HU+2ZOi5ptWdPMyu2Y/GjLO4MwldVtk9VnkE1K/hlHje4NlhFfvKMJJsP/doqh5BahTKDFux/3KRDoH73lB5WjZXQHRRDfgS5CbgfNUBeorH4R2dfJXD7zXIcAQaqoRjdpdIu1+sFSCWzaussTzuVyMEZR3YUEATNuSgdf0Da9oIH1iTACzWu11lSCv/gUnBC1okqGLjDpOioDOmE1oVBU70HxGFbi6xZO7Gm4ugR+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Vq9okYbpY4wuKmVVB5Jr6ywD/sCcKlIU9ZgIlhkc4=;
 b=Qjr/j6aIwb2ozT0MVWKvjfVq2Gm1w117Ii8iThf+uohe68MbSioHKLIKHxz55Mqc85I8aH/IlEjlToMkOl4bK6tMvzd3afZCeRfUhXeacVlb9fzJG+uBi0vq7xeFJXgAb1Ushw/klHV2gHMGbgOmcLPChJRO0R9JQP+ihGZcCd3SJo+F1Sm3DRjAckbwIWg5VU+efyiGcZniNiSmFYMkWGE4GCTeNVZ0A8j7luYcienzMv8eqLpqLaE7DFa1+obwDMYRiGhwdrQs1aBZHfdixKzvNPX6iek0/2VTCRkcp31W8oh8zmCToYn6jEHNAi6FM4fhodEriiszFi0/HMA7Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Thu, 26 Jun
 2025 18:31:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 18:31:47 +0000
Date: Thu, 26 Jun 2025 14:31:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: dwc: Add one more reference
 clock
Message-ID: <aF2SDX94hce6+AQD@lizhi-Precision-Tower-5810>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-2-hongxing.zhu@nxp.com>
X-ClientProxiedBy: AM0PR08CA0023.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 59107f15-20bd-4ddf-0339-08ddb4dfb548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G2QYm/N4uw3yykYJCj0E/Npoh8uXDQnBe9cetHCEbRrUG31EtiSf+I/8EWYQ?=
 =?us-ascii?Q?+AoI2UB+NtvS/nkS0E6P350MREbcjWshE5OlrSYWCGq1teYYVNbuvqVQUvMF?=
 =?us-ascii?Q?REfJKswdHy5aGPriWdtR9Oy9P6ap7PNBGMRrgxmT8ugSZi1lY1frdhC1xZlX?=
 =?us-ascii?Q?HJYxMa+wdSCb0JgbpDu8aKoFeonlD/YDq4oW+KOyQlXgpWtxpbY2itShlmZt?=
 =?us-ascii?Q?h/Vuu2kV7QtyqEnK3u/+/6QLUa1Cs4vkmbikSYI1Mo2HKO5xGa5EBzqpVZ3D?=
 =?us-ascii?Q?hJzTLogXMF8YodvQDNOPqZt6aKmcBcA0YMiw45iQNRdisvVWj05nzt1UcNmm?=
 =?us-ascii?Q?WpaGbCbp8UW7v2LtfvzL20K0LpWsxd6k0yC5YDMW1uOmJwyltlVgS34jetSI?=
 =?us-ascii?Q?o6SO0POlHTMi8aZ6ySHWt8YmTis6+8HzK75HC7fwJNHWz857OSy2UfaCQP6o?=
 =?us-ascii?Q?YSVJ2LcJy0fUlx6B5/RBKugt6Bc1taJ6CGQ3OebjODzR+8b8K/PWTuKcdvin?=
 =?us-ascii?Q?xa17yJyYKxpHESeqHK3gCkgcPLGm4N2msQmjW378JARcofBpiDxXLoCmQj06?=
 =?us-ascii?Q?tT4GrBEbSStm68r/KT4BbZlVkm/oqrERQwUfIlu0r/rOuUaouWg0EhvGDmZd?=
 =?us-ascii?Q?8158O4vPnJ5+s4ecbjT+C9DWnNRSfV0ShJzD+aMWhrIRZThSxPkwMa2+I1Qo?=
 =?us-ascii?Q?JCs9Wy4EKgVeN6kHUyQflddUy9uCk/kKMBQIdZjxiQBNwnbwXE5Wf4YqKhjX?=
 =?us-ascii?Q?adfYcSq4aua77QLeZ6HJi95Ew1jvoGL97pIzDwLNQPGVVYJGT+FriPExK45H?=
 =?us-ascii?Q?U6yq4Ybc7SLzWNi2uz8reEoYJTof9jPgcTG+gGwTr5u2MxoCdyYsnUmJ62Gu?=
 =?us-ascii?Q?LRetbCAmdGeK4fEIdfGMZek9KdO7tIG2KYAjzjBUX7XnKX7X7yYsgNrzq0Kr?=
 =?us-ascii?Q?gSxA/vkerIL9fpYdIsHvnI9PlnJeQJ/jkTtT1C4L8OvJJ9mgpWd384Im2EkA?=
 =?us-ascii?Q?dU1Lze7mRQy/PZiMgXym79kYXf1ow5fk52ydN/uneajV5bRY1gzDvdTUkhko?=
 =?us-ascii?Q?PSH5Zflp4DRQvhcZ/T/zF3pHu1h2ms+SPVLY+CO1XfVvlJBAr6/Elvm+skSW?=
 =?us-ascii?Q?iUFoHYpM9eyA8g9RB1Ig7Hr4gD8/y4f/tsutGpos8RVvlS1UYRZxDAec9pUj?=
 =?us-ascii?Q?XLJpDj+BxCOwVubTmMXeVUdo5siJeUqobsP5NKvE0p/EdbNyzwP3VgViOcaB?=
 =?us-ascii?Q?Lp2I/Uem+4UHYD4tjIhz+Cu/mYYvzcZAZWHz64bIqVPwPIo40ceu41MUh7RI?=
 =?us-ascii?Q?f9VgMuS4HBkZgm47CFXFS7iLWACmjleIepENNg5KMV6aIexFpl0STaOJwJ09?=
 =?us-ascii?Q?CeeWEDx6HubZ7GyPbzHaUX8dogXUu/qyhql3O4Q7GwjA/aH6AfHJgg5vGgnT?=
 =?us-ascii?Q?43n0cTObYH6lgEzx5EdAWbpU0tQuhVbqyMaAd6crcepi3irBiU/M1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHObugFOdB3IGZcWdS/FSckGPUJBUHKr3YYuhpNFD/pND71N7qlxJyT75Vq7?=
 =?us-ascii?Q?jyd7jVaGnmjoWqsnagu53jUfXVSgumoWqPvbo+jHOy9N6Vlq3A1a2q86QYTh?=
 =?us-ascii?Q?kXq1OU/yAIVmiVn/ZCA2DJCJdXDGqKH9uQ5K2ip9bct9XyGgG6t15PUDEjoD?=
 =?us-ascii?Q?/hJHzPaPrJX6brXXxhAZiO8OYUR6Ya9wsoDtb67vOs2Z4hCiLHVCIuCDAw6h?=
 =?us-ascii?Q?s/vwcPRZKDMT4rXOG/SAxXsZI8WbMHWp166irTYvxNClzcciRwy+F0VSt+ZE?=
 =?us-ascii?Q?Y/Y4IazqAsdcDnaXjQsTKOi47uLCuM8sVYXqZgfdos5l6zGOoJ4bJd485pzS?=
 =?us-ascii?Q?AAzdE9977txrPSidfDSyvBPp4OcMh7jbXYhsnO8SLSJbvElXLrY5g4hseqpe?=
 =?us-ascii?Q?T0ySmE62yTKFlUMhv7i0IWNdm3s1elMguglvp5OcXE27jjPp6cLFWfLp34Cb?=
 =?us-ascii?Q?9vzimj8L6POSfA28MFYTdHJBmw1OXSLDEs28TZZaShnScSSIQZjNIFZIfMiQ?=
 =?us-ascii?Q?LESBFyC/tYLTvu6dClAOAoR3GVUQ7LF1OZ69M3IVIxkoY0JO1g5dVtmXCr7r?=
 =?us-ascii?Q?bvI3b7OL9QTjK7ZRtEO6q22cQQh5zoiBhC2KKZ8IXJDrcD3e9Tjc4Pn1i9ls?=
 =?us-ascii?Q?XWrDyznHePerLPbCY0uuLwPlkmmg/2frn7ddqA742YEyO02tNHx8Z0NtDCK6?=
 =?us-ascii?Q?vovIbYjuT3XPnX+wy23eyUAYb33yDGDyuOQLXSszRYWpkeoD1y6TjAa1YiZ+?=
 =?us-ascii?Q?hdURJdR7NrX5eR9MNM8qhjA8Th4wfP+pr2dWkU729EWaVVT/rM5WPwCvcZyt?=
 =?us-ascii?Q?E2kSS2MclpY2eldVesdnvRyltmlPRMol18wndVPaKfUbIXn2mUZzl4CPAP11?=
 =?us-ascii?Q?udgu5QfK0C+3Y3StcRl2aFKu+6l9X7ogKQ28McJW9LlK0k2uHBIlkY3/+m95?=
 =?us-ascii?Q?hiff8cetYI8/Ce13kQiVwYB9mA4RU1CPxwMuoJgm2Xx5v4oIjWMylZiN2UYk?=
 =?us-ascii?Q?5GRQfr5q7lV3qVEVsBWS8q6Hx2RupUSs8xwdTDHAOTZ//52EEF6A3zrDV5wL?=
 =?us-ascii?Q?fel7WhnyJ/9YF1JpUFRlwnKd+QrMS3qVgM6OKPQfbQyvyworCszHMCbfPdHX?=
 =?us-ascii?Q?8jkM4MPr26DsaA7BHoRZpbOeXFkMnxTROlEQ6WJOg6n+V7rDmU3mPa6EUuBC?=
 =?us-ascii?Q?El9skrkxQ4c5pJ8TqI2wUQ9PpY8PfQs+fDHBxEDDYv6JHk7zqKqcnTJ7hHXC?=
 =?us-ascii?Q?3xhHLEFhkVL4LG8eEecxctUCIdQW85JcfUC0LDRzcqlia2mfnGYTonuuW3l0?=
 =?us-ascii?Q?+dx7dW7I8BVSGWuRtf4sGEuXP4EOCghhOwASL2MAvtHz86Dbqnrik13dmHpz?=
 =?us-ascii?Q?BW1vK6gMlgBKqIbmpIirG7uIhQHGuqzju/BkRYyE9OXSXlFpTWImQfzFxLJa?=
 =?us-ascii?Q?5iOSW5DiFkuoQ3TnGfyBMGwmbXvRt5/0PiofL3EyVNnujULhoLboNpgAzVWX?=
 =?us-ascii?Q?xVZpbjeXZKr221ULxoLpZXgYp0Sqpx8ifYDK99RrbSzlhLZnZT+TCZWh8NPQ?=
 =?us-ascii?Q?eJah88mJwQm0fBN/RhJCk2GrarILDehss6mFt2GW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59107f15-20bd-4ddf-0339-08ddb4dfb548
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 18:31:47.0508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Krmrusoptd/AIL3smW2X1CHfb/6Yxbef1nBmsHymtQmJ8CUL0+gM42KjLNET2yF4lIHq7uY+i+9cJDJeNZQgWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

On Thu, Jun 26, 2025 at 03:38:02PM +0800, Richard Zhu wrote:
> Add one more reference clock "extref" to be onhalf the reference clock
> that comes from external crystal oscillator.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..ee09e0d3bbab 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -105,6 +105,12 @@ properties:
>              define it with this name (for instance pipe, core and aux can
>              be connected to a single source of the periodic signal).
>            const: ref
> +        - description:
> +            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
> +            inputs, one from internal PLL, the other from off chip crystal
> +            oscillator. Use extref clock name to be onhalf of the reference
> +            clock comes form external crystal oscillator.

typo form, should be 'from'

Frank

> +          const: extref
>          - description:
>              Clock for the PHY registers interface. Originally this is
>              a PHY-viewport-based interface, but some platform may have
> --
> 2.37.1
>

