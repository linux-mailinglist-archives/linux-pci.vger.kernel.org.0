Return-Path: <linux-pci+bounces-30815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE7AEA592
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09FF64E2472
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999F82EE60C;
	Thu, 26 Jun 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CVoyjjxb"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876912ED862;
	Thu, 26 Jun 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963401; cv=fail; b=pn/UGTtgebr8u0FQoVUPxo96N8uvN4O/mmUFYqMR2G25ROgvpAgWkr949xR2WUHpFUOpeufaDS87wAEtbpKkYEkyeVV0Ig8WgsAUC0JhvZ8xi1lwFeoWg2UjOlAfOfpaJIRDNf6hZJSEBv0DXnRTrPWKZq/sq408VBgndrz0Dv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963401; c=relaxed/simple;
	bh=PQCrxIbzecNEo691ofMmsKslQOg2gO0QUR47uu19KLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SyJnV7nztD1LpXOrkUZOQLC7/AuvAcuiw6tw3qC8SjvcLJe2AwfODq+AqRmcAgAxYvywvZg2jawhO1PJh32+JLrXvNLED139p7IIIh9qMRQ8hZO2BsYmf6Eoy5GOms40GFByONXhCBzHE79r9RzuoakrEfw+bC9s2+s/fgZbz1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CVoyjjxb; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBKzJbJYXtUhX0iB3Zn2Hy8Hb/F0eJQukODunnj7qxYWqOkE5lZotzMAcCQslAf7HFIALG3Vpz+QVo2QJQYaYWLfuW94Rr6SHz79Ch2ivIIDlJbM9XjMCwQzHZu6y/wU137f0+L6o02n+5yKrSxWKCxtTrAcczoMUzEyZow1U7rNp9i++OfQwL/i63Ojx8x7ZGCy+9rcE9CPVFSp4nZw8/veoecLnf53CW4B2uqprrRh0KUF4sKSAIpMTgBuWKADx88Gl1WVQCnEWF+rvdSfKX3cMyXmoUV7YDwhFSbZhsU5l0TFs51OZ27kVjKFqKxupb7DqcCdxtaX2LWGNcSRTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hzada31tPMOWJDriB3zmKzFR8XRLlEaw4O1//ZQZWw=;
 b=ENefD6f3HJutTBl4BEstbSj7Q2aa0ZTHFQuLbOfgfQrm2RcVoocu2XG9WE5utYrhTtu1tl8duPvptbQgxmRgijZ6UaLQ9V9CuGr1E8VuXuZRQVqK9wpamSEYVsSF3mdamZo/hDZiior1Tlyi2s/LengpKXd7ZuMZdGdMC3Ytxr1wLd3eBl8cYTpNBDXyCo/iTsD+hziRoiwb46jtPr6Sq3zcCsl5ScirrdNeXB8vfYV9efaUWJsHY+g+eGL8GNgqS+6tnyJ+JF5J/QBeZZlY853sXsaco/stn40GOb0GnbjlL9QjZDimJsZn3ZMhXWq3b6OB758pEociyUJg9HVCBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hzada31tPMOWJDriB3zmKzFR8XRLlEaw4O1//ZQZWw=;
 b=CVoyjjxbULO6d8FLeivpeFLY/dEuMzjpg1rTZPXx69udtjepoLQFej4rGxF2bI5jWHk8eS79AfiQryqXeKA8+4EMG3WecQasKAKRZuEE0VweAemJrf1YgEjKUvC7U3OW6JrGCv7gk2ag+msF8XMJ7/Zm8UfRE4PRT2ltFmwqRNWFnL8NCVNcy1LaHHKRTWiDpQCk8rglfSjlePjtskYWooDWr8D0hW4YOots1Zicy535K35huk+woBYBr5g1B2NdskT3dR9diZ2QCulglZs4QhVX5aM8CwVVQo8qvLtoETISs4PgF07aqI35IXVzN+oz+A3tnaQ3/rRgPXQtF7JWZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10095.eurprd04.prod.outlook.com (2603:10a6:800:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 26 Jun
 2025 18:43:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 18:43:15 +0000
Date: Thu, 26 Jun 2025 14:43:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, bhelgaas@google.com, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-binding: pci-imx6: Add external reference
 clock mode support
Message-ID: <aF2UvfjlViDI8BDq@lizhi-Precision-Tower-5810>
References: <20250626073804.3113757-1-hongxing.zhu@nxp.com>
 <20250626073804.3113757-3-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073804.3113757-3-hongxing.zhu@nxp.com>
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10095:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd802c9-794c-4844-3257-08ddb4e14f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?elN67yzZ/aTECL9a5CKa5v+sBot//5Galrue1wydauTnoSQCAZ108zdl/YNR?=
 =?us-ascii?Q?oKKbn1QwVJCyNT6k2N/Jtjb211RWO3pZrT2XG9H5rsRSqjv30ZfHzunh7II7?=
 =?us-ascii?Q?sp90fXR0s17UwNMq6s9UnzLoHFQd37Ne4ptULLoiIjsW/wKwmI6QnPqruEMO?=
 =?us-ascii?Q?mkykbhN27C6vjlIfaysSGNCcbDJuZ0j9vExYPbVV8eDMrem2jDo1wzp+HnDS?=
 =?us-ascii?Q?FuF6FK2+a6jBBu4170Xp/29iHbV8lbYX8/7w0/g0qaCvisD0YsECGMUB1CKq?=
 =?us-ascii?Q?8VLUcLVLLatNRAwTIfOnKnD8EDW/KaZSwu/rWRKecy1RDCDmpNBP0Kf0uKg4?=
 =?us-ascii?Q?OKLR/qxphwW5c9I1chw2YsJvZI3HyEMjflZUrPlFzmwtTMJQBEkOnjLUNf/H?=
 =?us-ascii?Q?IofOX5fxqXOvNMBkg+0w+GIT84JrKteXF9RZZvgigrJobN+uObbezstw1vye?=
 =?us-ascii?Q?ksxF1St272wY6fEofTfgkEjwJ1XTdW5qdWcCqo41LmaWVLlDcruFwoSB3ys8?=
 =?us-ascii?Q?7aepEDfD/Hyn64BEVLq/7hJDnVdgeq4UqFO99GEOvZ/+IXo8U84EIxStfcT9?=
 =?us-ascii?Q?G9srf4qLZfMjEEaDEpjyW3fDCMTQqMQv1RodeK9QhzgxLCNJbiAD4pihZXCV?=
 =?us-ascii?Q?NbPDnxtAHqQJw0hMH79kU6y5CfCRBP2KmZXVRW6Kt2yG1g06YmxQXqzDX5VY?=
 =?us-ascii?Q?ZKZyPsIqaLz4VRRckUn6zi1+14u5PxgOX8gVg5jySu2BSWMCOWMotUqRshYC?=
 =?us-ascii?Q?W5PMZMQa7ECOw5mwuWz/SwDlEzv5bhZSzsG+/lt192EEtPaiDxbhfNvScFFZ?=
 =?us-ascii?Q?7hlfcECpfxO1gS3t02+J5hToLBDkbemcgat0uuBmDVBh2pEi1AGiBGtaQGGR?=
 =?us-ascii?Q?u76S+pFrkcqwgYF4ti+VbHmdOVyMJZjrsQ/zAZf2bfy8s0Z+K9i3mGchUpUK?=
 =?us-ascii?Q?BYJ8ePka6Hkh2Sw/+TT/mz2JQT8ZaYbVE8/p2u3WNc4sytRVA5CHVNadM1Vz?=
 =?us-ascii?Q?UVBkV6o/lEe8bAH/YcTGieEzRT2DB+2FYY/qj+NYJkSdfNdmpLatEAV924Bs?=
 =?us-ascii?Q?3abO72j+0AmlgreZEK2247UtPd01Qu7Ybsn0Psv14hahaYjtzrvz9gD1gpSQ?=
 =?us-ascii?Q?DGqG3wR47k5g0a10eVgCp/rJ4bfeghbuYWZOs8m/xzaZBibDxly6crE9Z6NQ?=
 =?us-ascii?Q?vCLSdK2VxW2SUC9+w0Ds6872iv9j+FYBjaj3y5KsTFY6VBUPQ8LFLzS52VCi?=
 =?us-ascii?Q?I1WugJlnMjzCyVTrleRYjMXYHLw2WiCLAgF6dpWaKm6TsPI06idmDHQFbAdC?=
 =?us-ascii?Q?mcPFWGPGKaqOtlHMAMV5eqpU7UpLmygv8yDpVubzfYFpbv6QF4pl6PE0v+Qz?=
 =?us-ascii?Q?9I9OG1to4sGtQ9rUaN8Sp8LoGRviAureD7uFU1EegTz5ZX9KOci8+P4TsEMx?=
 =?us-ascii?Q?7hrCXS6KJsd64MRoqA0si7LSjuryJOO8aJcqHmvh+7KbRK+kfstfrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ElTicZDNq5xtYoE6Szxc67dtkFj+oYZy69vSJkMS9oQO+8wviz1/vdmp/8Yb?=
 =?us-ascii?Q?WKLUlNvLDpmwIiHqBWi2r2FiHs4QbsAtjaW/ngDwxUao6gxVqC0f3n8gytqV?=
 =?us-ascii?Q?TI2u+jQkPTAyZSA2Hcb6fGpL1/hLaoM2/qfe7waxuZoX6wOJ7dbqvteDQl9v?=
 =?us-ascii?Q?h4W4hoCfBZj+fzClWlBEPLmWwObmMyMtw/Of68mrFCrYpwkL0whrH5suvwuG?=
 =?us-ascii?Q?RglnASoPSLtPc3DVcAFotvaeL6iJQcEOBli8I91rB+JilbEAVeWLI0gNx5nY?=
 =?us-ascii?Q?BqOODsBTJuqDlksSkxvGqm9DFkqI31dN17DKnmdPXzY88MwNXxBTxF/BLPgc?=
 =?us-ascii?Q?D+/gHoUalF1YAdcFinSD1aj5dbVfti1G4KzZkghtAosndBfXbr2v30A3sgFw?=
 =?us-ascii?Q?dREineVANOV3UQbV3327RgVizweFYioLyPXiyEGDTu66lirJ8TYxb6J4uC6U?=
 =?us-ascii?Q?kCYHNsryJGm1C5ZUJponlhIriYHz+h0OukIBsdvFEtVdG2wVsfrfF1sQ0286?=
 =?us-ascii?Q?7gTkrX8LMu77AcxJUt2R36EScxiNJ/ddI00PhbMoYqwPnbqC+6Bftb1QBtT3?=
 =?us-ascii?Q?VSSB1h6SAQ1hOOh8GSttdN/5MVD+Dzt62ZigfOj2jymZ5R3YECo2rM49YEAz?=
 =?us-ascii?Q?0LaxwSAA+lMuA34Ry4NU+peiv06WJRfRYq4wwagwHqU2FOxQkcDm/27XL+cp?=
 =?us-ascii?Q?Wp2KIoBjh+E+k2dqyQ2P5312aHiMIk8CVSBJsP2BMB6cHLl8B9vJxD/fO/3D?=
 =?us-ascii?Q?nBkQOdVvEiOyM38JeS94nzAoCFLX2GaZA4vDuinfMTU7SSOa3gksz4QPFdd3?=
 =?us-ascii?Q?cE8tRZ6PDjOAAZTzFoohc3IK/XcbfvnSvoMVjKWUq4CbTPCQpc5ye1ieZFzZ?=
 =?us-ascii?Q?CihgpraDtSZV4Hbk6Wknghv8yt10HHWDa0q/bs2uJzvQZ5jyXnCjspBKolPC?=
 =?us-ascii?Q?MGdft6xp4YtU/xSCLncjLJtKi6fAEZcXPF+toItIPoeQAh8JnEQt/KUaC2pN?=
 =?us-ascii?Q?rI7dzbiuk6xmrUQybfFOk0mXe8uzhjnbjQTxilZF2r0V0L7VMAuFbnPH/sDl?=
 =?us-ascii?Q?CP++QLzgcQS+LcTMNv4OJRzU+y5kPMJZ9+xPcN5e+P7IgO4/DMYLcmmeK6U3?=
 =?us-ascii?Q?ZRVLYf1Hc1quFJvGuGxVTVmcD1F6OZfKUS8adNR0DLrtEgQJczEGHvgHcTyP?=
 =?us-ascii?Q?rqPTAXth5c+Hh5a6gvq6+pl1cOXNoNGKw7sTxW6eJ2DmYwK6lYcvh6ekUIxp?=
 =?us-ascii?Q?QYwOJvrvsx0S6dpyZUrmFoY9triYNB1opllazqhwJkozRn4YMnqKg8GeqI51?=
 =?us-ascii?Q?zglroONcTyBAxR2T1LnOdwMiJgf7mAAsCU9Rzp46xtuxtePZINjSEDGKG0r9?=
 =?us-ascii?Q?u/Z8Ud/wXP1IWD/CGXMVFc+agU1SJvCyRIql2lbSK7MFtnOIvIlBJ+OB+v56?=
 =?us-ascii?Q?IMhAFgS4mkvsaqSkSTwM/p3BqYQHDKv08aDnhsePS4+0dWlxytAguXgO9xjo?=
 =?us-ascii?Q?Skdt86G4FCiB3BJuzfkgCMnSvueYHW0xbtjzkBbezzGG8bgPdGX55RhAgzhD?=
 =?us-ascii?Q?7M7XA0BUX2HJNz8MwKnHbzwfinQN6aFYML/JLEeG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd802c9-794c-4844-3257-08ddb4e14f8b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 18:43:15.4012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5nMqpGejjjEUTbb3sUW6MJqPGCJWC+oSuZILomjc92Bclpf7DLF9pjYK3ODSMLgI1xvPLNHNnsIsmYCNEIB0sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10095

On Thu, Jun 26, 2025 at 03:38:03PM +0800, Richard Zhu wrote:
> On i.MX, the PCIe reference clock might come from either internal
> system PLL or external clock source.

On i.MX, PCIe has two reference clock inputs: one from the internal PLL and
one from an external clock source. Only one needs to be used, depending on
the board design.

> Add the external reference clock source for reference clock.
					  for external reference clock.

subject missed s, should be dt-bindings.

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index ca5f2970f217..a45876aba4da 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -219,7 +219,12 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> -            - const: ref
> +            - description: PCIe reference clock.
> +              oneOf:
> +                - description: The controller might be configured clocking
> +                    coming in from either an internal system PLL or an
> +                    external clock source.

description:
  The controller have two reference clock inputs: internal system PLL and
external clock cource. Only one need be used.

> +                  enum: [ref, extref]
>
>  unevaluatedProperties: false
>
> --
> 2.37.1
>

