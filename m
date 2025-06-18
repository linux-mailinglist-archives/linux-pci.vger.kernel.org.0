Return-Path: <linux-pci+bounces-30090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA08ADF2C2
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B7D3B0E17
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243C92EF289;
	Wed, 18 Jun 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AWylq9+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D72EBB8F;
	Wed, 18 Jun 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264801; cv=fail; b=gDMmZMPWm83+aOH5UNCxeM4HMy6ZjdG9MxSS5Do54kQ9d/OBkI3KA3Yzo/P/eVWZUUS9om3QyUY7qQblzWR5uSY3mM06KNzAYU8VV/ncZmqZzOi0jn4INEn49ToegWuUIgQqj2nqZUwhHs2nZ8iNbBdsp949x1UE76XGQvWCSrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264801; c=relaxed/simple;
	bh=TcBjgbPfz/iWYyrFZMdZzF0lnTseV5lBNA1MIAvTA6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OEc27H8+Uj20MRps1gv4DimirBomtcGM9UCUS5o+5jahxu0L0vDriSVlY1MMPm91H5M7nC6B71Mpjrbs4eaYXrLS4f46AJhcK3bb+SVJpUhbFnC6CAdjn8hoj2m0d2zUvEzWW5r5zFHOd7G1ff7AA0jfsoIQ0wdBoWc5oPn914o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AWylq9+8; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHBTaMN8VWS8FIAg2iHCL5IrAgWLIetcJ9WlAQshRFTNRd0LjIbr6HVVCykFvv9DUeJu7EqTrsXXQqfDgRKd5thYcEbzyfP0qeaDf4GL5BJWmWt70R/EEblPHIB87V1sy/Gf+XP0NOQvzY0oOPRuRm0Jo5IMO42wCPds3yykQc02mExEqEnrH0n8h5lZR7/BiM2Fca08YEMF9iUfAODmD4gcnjuiHR+Te2e7pzyLtS1feVp5WdoTFl3yalQRWMZuYQfYUnJpyXVAqLZag6m5HkgKTk5V1kMpQlNCF/lV9bpFG7WC6+S3/ahOoveBaQHs4FAQJIqQQNlzPo4IKLG4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETjSJiybTgS6lZhuLduFy7PlYesKZX8NyYTDHzJMXfg=;
 b=EmPhzOwQ1Fq2oT2Wmzbk/zksMw53KTCXfRA3NXAz5Ln+GwcWCv9KpCr3KYUhSpgVuXsf4c95CoQ9zF7bdeCmEJ37TyYnXd/+ni31FywyBSEYC25F6r4Qb9J8rLi7MOAxRxf8AnO6i17xdo3a0iY641fMtN5UgyWcSW8IcmCYw92jacrtJjY0jeGgI6rLJqXdt9uuXCK5znxSfuqQtQvb4ED9N7gKgHOZv1/TmohqScZn3N/gSYmI2nmqsozIaawE2ipkcUpxEw51Z5bLoWo+XMfAq2FI13coyLARpEWb+tmc9ODMImFRBi3omTS22m1jv3np/XoGHEr21+Eq6ymuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETjSJiybTgS6lZhuLduFy7PlYesKZX8NyYTDHzJMXfg=;
 b=AWylq9+8GkZnjFS7rQSNwpeJ4cdKXufngEWp0smxaP85uSeaPkDTN3H3PntmxQPCdbbQ/hdXnreQNZ9H797Fsu5WykFc2s6my85qWqkqUkW7fMDc5VbjhDc+hLZwZtqMSLH4WKQ/PCLL7PL9n+I3OfwEhgSiz8CYWeZePS94n8/d58TuUjcinE1qMQ+j+gmw97YYXbJlCYBK5sbHNNRx2hYWlukxaF+q5XLUC4wzmcN+QANfGtJoS4Sh3cVG9ETrJR+RpWOVitUWVOpVvXRnGj7ge8DeQhwafkfoyPnmAT9D41vhLeqWUoAYZPfsO7hzDkRVMxDzQPhqEEWgJHfwIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Wed, 18 Jun
 2025 16:39:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:39:54 +0000
Date: Wed, 18 Jun 2025 12:39:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <aFLrz19yA/EcF9jZ@lizhi-Precision-Tower-5810>
References: <20250618074848.3898532-1-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618074848.3898532-1-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0PR13CA0094.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: eb45a021-3427-446c-049c-08ddae86c118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n9K6GJnLFCTfcqc3XL1Ih9airC2gUiAbUtbR35PMuiLr5YS8fzq9jI1Zr8hf?=
 =?us-ascii?Q?rRJUMb4ZC4tr8/lkkr+izDD+26nB9mFHm64lw4tjY6VErmLbQBeWeN1Zbkdx?=
 =?us-ascii?Q?A66A34/OXhUHav84FIUSKln8a3hCw5c7i/uojz5ZvuNde1DI0SK9XiD07e9n?=
 =?us-ascii?Q?50ohX4GzOy2pXheSDkpNER2GIqM+ms21X30qwNUA4i22WiFlijeKuDy0LlV+?=
 =?us-ascii?Q?RaLfgaS/iiihemtgpxqcQ5121i+S4Myq7CB+lTdUAy+b06hZchaz00+SRbx8?=
 =?us-ascii?Q?h8ukDx1wfWAb+i5eu96xFrXvi0aPkCdA3S5x4UA6HjAns5CzQ5Y9cAVI2aGo?=
 =?us-ascii?Q?2Naqqc3bSAi/WyVKspPToyQT/1tFT094yZEx1Je/wrLZofq5xH2inu2/3TBu?=
 =?us-ascii?Q?TfnVKhsKTzSzgTdEw+C0k+50gND3obmQk+23jZasA268TdPGPa32LrQ0nNN+?=
 =?us-ascii?Q?EX8xnRga/bX1iQO3WJhodkQUu15QJvui3cQ91Hfp6pii+SSvUKGKrYDcxZlA?=
 =?us-ascii?Q?WyrgoNA0PGoT9+P0yv4mG3Jl27qJMNJq6WUh7WKZFvuZiyVC41T2Kogp/VYN?=
 =?us-ascii?Q?KcIoATXeJAXkM/L71ubpCkaMn8zDiR4HXUMFCREW3Axca2KY4/Qb4P6lHz+L?=
 =?us-ascii?Q?2doPsm83YiVgZsB1VsjHMUlnxzGtT2NMZZXfPTbR4ON5D+PdHi3ajyr9M9xf?=
 =?us-ascii?Q?u61mLFPV88vwy6fadaIgxqDhBR1IefKEBpGtEvKfUISa2h7umZTCFNvyFQ3Z?=
 =?us-ascii?Q?l9gBWVKxjgv+8Uexjyd7gvLmf37wlS1b4iGjPZbSUy78kY4giM3A06BQvCli?=
 =?us-ascii?Q?hHyAMqo4C8vNdgXeVO6j+0iF2SLWYVscLnBq2ZGLMac1qNgIJBdHpVHBqEYy?=
 =?us-ascii?Q?SEzw8fvkOo4PwVtwLj+ZDLYxE5Z7V0Ql4T9ohXz9KQ8PYjWmjBwkfKc3Z7Lk?=
 =?us-ascii?Q?c7W+/tobKbQg8L2H/wFnEyN+Dg4tHThQaY5ajMpbVkJFXR5F94STPX7Dnxbb?=
 =?us-ascii?Q?k6DVCYBSG8QqAbbBNg3FM3m640Xh7meYhZboj8CEpEOnmUyv0XeJ4Zsp2nLD?=
 =?us-ascii?Q?QK4Q5NEIi01bnTgGI/TyMU8dKS4KksJUIlUc/SiYXOkMZ/XqRhEflD6okqj4?=
 =?us-ascii?Q?wJD5VddZcE/1XOJnzKSoZrwM0HPQIfYuZoGFXm8rhPqBHUEe2bNz26J/TXN7?=
 =?us-ascii?Q?ZefuAKful37UdrhrexijJAD5ScV+5wS5D6uvjyF9d7FhZL4X9qOLt0mPEqZU?=
 =?us-ascii?Q?p51HnsJrhue2q0hMhP4DZ0SYAhHicNBXZ0J5WIu1LoMp7zCp9MSFmBY+FlmO?=
 =?us-ascii?Q?GnJMFk95IJyOQ+HbTjG6TIespVyLQ1pILq9C2NzV03lCSs9TUWNd7BQ/U8o5?=
 =?us-ascii?Q?/BMO430wCG5RLIncmEN1BCr19qyqJn9a/ySmMOY60Ba8b8l1xFT7pmETFuoe?=
 =?us-ascii?Q?CF0CdUlJo3eDNQ+9+kE4osLPFEu06U/LejJKJ/f8QPVnBQ3Q+xVh1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QgixS9kHEBfSZXxg0lnv1n6kTMPscUdLym4ce2UMxk9b0BoUVMM25gZMP8IH?=
 =?us-ascii?Q?PWZwJlQrmePpxA4KuDuiG/wOc0MEBW9+q6JtF0L+eIMDojDHgghVj/rLtN/w?=
 =?us-ascii?Q?55GYIKAIa9cNwrz9J9k9fM2FGKQKteX9A5+CNeRLJblb0i0RXguHWJ6sYE1X?=
 =?us-ascii?Q?Bt7vo8x5AElJ4lTYYWFDCp+38IopJWdBagz2l5Qw8yswupnWzhsS0SVXl7ZB?=
 =?us-ascii?Q?VIkx6R6QoAwghAxIUb0Omdabwee5+iwGR/4qh6CVIFWlr+cYpLHxGylgms4y?=
 =?us-ascii?Q?Wh5Q2jkC7IbVvGPDN+1EENtS0ifrSZC1v38SNiyYVUTtQz6qvT+n+2Tt2ts9?=
 =?us-ascii?Q?H+aJrw+iDAmrtjJ/9J9sxobEQP+ukdbeHjDLOIida8xpLlj8ldvToaBKzXU+?=
 =?us-ascii?Q?KkObJL3JvTS3AeEMOIs0n+P/nG2TxOOcahluqreMA7FmfoMg6um6Kdsqu6VF?=
 =?us-ascii?Q?/iWxf9B8Fo6QDjJpaoqqrmK+K+worqSH4fgmmw9vuzPm7+iJPheHQBQ586+p?=
 =?us-ascii?Q?dmrJVnCmeuaw8IV5Uk1NBbIMDNPBDdBk64OBqszYzPRM6d0TP8uh2SpHBaG0?=
 =?us-ascii?Q?gFSEu3jDGTAiUPgkqzRjq7PXDomLRsSv7olNvFpYiC08x7uBcjb+3J32BRuM?=
 =?us-ascii?Q?a3nE8PSRzvUzvlr43Q0Liuid3+xlS+uUOA5KMqVvc4WRduwv25jsxC6SIA23?=
 =?us-ascii?Q?txYUNtkFUux/IyHiLzN5jOwgo7ckgsReTfYoAuJzs9Cz/5avue6u/zRvve1c?=
 =?us-ascii?Q?HtR3jOaJlXejOniy+D0Ukme/jps25ECf3CQDmjNOAv1EnvAmZCd29/XoElv4?=
 =?us-ascii?Q?0cqlYSzJ02SrDmEtnTCAGkIzOSay/96VRPRqWh6+TpAf+cdoo8pHe25WhNhl?=
 =?us-ascii?Q?6lHViWfJGaht8aeZH5bv2YkFyqATytzpRwTMevBES+JoL08wIVUwx9uhhity?=
 =?us-ascii?Q?6HnIKdPGWXHSebwgCVJ7eXp1F1JQfOf4ISe0yRnk7XCKJXE8EzH5MfFhG/2H?=
 =?us-ascii?Q?gbIEzJXjm0N4KrPMNvWg7iflnreVXgDqTeGfU82AVvPYs1tpZVxw7O/y6xyO?=
 =?us-ascii?Q?5lm2g/4gFbpMQ5gzfeH/FWXkiZ80QyXb8SkbxstGETaeAdw+/pA55UI/tfI8?=
 =?us-ascii?Q?QdD2oWIRe75xfznNoEycu9Y/mRuIYi6ynQVVpFLShHl4vGL8IhdZ32buhZ8b?=
 =?us-ascii?Q?szOJklV0+o0Ky1FAGGGDr7ZUIyb+SNNY3+0wm71BaQfMW9+Ir0klchnMr+B6?=
 =?us-ascii?Q?65kMPdTkZTMj4dzkn6mibeGBWx6wA3k/Id5mnIDsaOQ9700vfHuOB9M2URE5?=
 =?us-ascii?Q?i/cxR9aI3lm7RURDZNINbc8yE6070AFM+82ucJpMARqPV3yKnCucqXnkZM36?=
 =?us-ascii?Q?nMnpmhZ4qdGog9qhseVz9Os4FM030OQgPUiXVBacZ9D1kti3iYi3EaYX621Z?=
 =?us-ascii?Q?MkPoSIxiYEQDgwg4emlvysOtxVaHuB4JbJVZLNeTFJOuz7MhKXTo2BUtz50I?=
 =?us-ascii?Q?Z6X2pH52PnnRsrlNeARymUt/eVaXtuViks9widUdeOT98zzeg62FTmSFY+Ng?=
 =?us-ascii?Q?ZrYJ7LMEW+UMfSQWrnE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb45a021-3427-446c-049c-08ddae86c118
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 16:39:54.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n/4kfY4OaZvCqvoaPhIlPGHdvJRVNAJZWLYB+rivY9s4GJLUp0K/04G3pvoywOZrVirx3SrpP98z05cj3u70g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9398

On Wed, Jun 18, 2025 at 03:48:47PM +0800, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.
> Add the external reference clock source for reference clock.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217..4b99fa8e7a25 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -219,7 +219,12 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> -            - const: ref
> +            - description: PCIe reference clock.
> +              oneOf:
> +              - description: The controller might be configured clocking
> +                  coming in from either an internal system PLL or an
> +                  external clock source.

start from new line

description:
  The controller's reference clock can come from one of two clock sources,
  internal system PLL or external OSC clock source.

> +              enum: [ref, gio]

gio? maybe 'ext' is better.

Suggest use b4 to avoid missed device tree mail list

Frank
>
>  unevaluatedProperties: false
>
> --
> 2.37.1
>

