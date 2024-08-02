Return-Path: <linux-pci+bounces-11207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A9B94647D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844BB2828B8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 20:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D849634;
	Fri,  2 Aug 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IDe2Pz2c"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3E1482F6;
	Fri,  2 Aug 2024 20:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631212; cv=fail; b=XbFUGxB4JQ0oQ+Ln7cjxZxxtpy0M/CqV00qbRG1vuROnURKkmGZ/L1MJwyVu6Ob64+wcqQLr3QsfVZ5NgJYktKsOA5y4xJjQyiFp1qTXmgdFHG4xbg85HlWsq48XeEzJG+pBJsgI0/QYRDPgzTTaJh9LK4LVnPVkwVS5FCtv2rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631212; c=relaxed/simple;
	bh=jecSt/0AFMelTBWHVOhwSiZBkGFG2yfDDusH3V4/igk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C+SDD05pix4bK6m7NBW+T/g84QHOicDhhbtBLTLx9OA7FVkrLavpBWAh5y0Kxf95YL9mdyZuPWMVhPttm83IwPWGRiuTAzBrKmMx0OA2V+sE4r9dYR93+O5zK7U1Ai/0mWHn7/04M7QsjbTcttL3IG2eP/XcAb1mG0YHaGw5Fy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IDe2Pz2c; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM5g+WDr98T6foP3W/z+8zcqVYDTTEeWVkbl++XYMe/TkIKzcqwoTvA7I3+jcm9LpilqsZfNGEiUtd+6y6IkxYyinEHA/0xTws8PE8nxDwqhK9Ff42ehKmOF2oroRkv0fCDuFEzml6IIp/KLrqaLcGbrW0Jh1syDi/9VZtRLt4yn13Xp2yQGclrBi0afDTOSSNOsZla5XWKUibdRoKZRg5e1B/hVEJhvMOPrGK2wz7Z386pU0qDt8YutMIuJqnFzTqEwRLdYEUXp0Gm7YdRBx7CJXILI/a1v6AVKjm4SUAFi2PfXlkBzDh2x9kHMl+ZxSXsVK8Bx6NA35Xt4QmGNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoWOqfZNjvNGQIKcSEqJBjJWNzS9gDzTSxlTaxvwMRs=;
 b=xd54oi6I3/asBtbrqkL9kJ26m7zYUNhs5oUejkDNBoKpXxeKjKd0Rb5j0GT7bVM+To8hAUdTCpNWmWzpJAMzXfxkEiDFUevAypmjCO3bzzxK5G+DAQzFw47IfpdLJJPirgX9priNsvOZwAt5OeJ/DVZOheGVbECklDPkQQEBYrrUFRoVI0I79ek7Nk/vbfdqlA76RBdeYCB8tXEWCPWA8HfYA9oXgXt18w8lEvmg2/0KCwMe+2QJ/X0y2B7+Y4SssFtk+Q7CvwkXcrbPDgni9NQBGSTIkke2l3aDHacDdioGArJfE3yZCb5JtOhLMZRTvTHqHxe6b6UKPa5icFK6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoWOqfZNjvNGQIKcSEqJBjJWNzS9gDzTSxlTaxvwMRs=;
 b=IDe2Pz2c3c+F9vtFhVgIC0SNTy1ovlkEL5Phll7JRaCqkktEgmHxq23h4avTNOeQjZvDCjkDUJedfrzU9oY9OMfeKOn1OqEdV9xqVe+2PZpJkUfk0IcO+JWiuAMezgZYhn1VcpKnr7pVlm9mTNih73U3BLaLx7IUYffiJH8fFuO7ECj41v7pm01mCgitASk14c1WRyswNaBRktk+UUC2iob/WPPJJFvN4woFIIPa0byDPq4oeeaumoJu8z9NueHZfRcUnyeZ/aNnEDWm079rxEru241LShhnJeqyUPy1lPL5jVR9RIEF7LRUfqSyJaXfPo+uFtxKtLTg+P2hygW+TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10801.eurprd04.prod.outlook.com (2603:10a6:150:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 20:40:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:40:05 +0000
Date: Fri, 2 Aug 2024 16:39:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 1/5] dt-bindings: ata: Add i.MX8QM AHCI compatible
 string
Message-ID: <Zq1EHGXx7yAK9TXS@lizhi-Precision-Tower-5810>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
 <1722581213-15221-2-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722581213-15221-2-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: BY3PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10801:EE_
X-MS-Office365-Filtering-Correlation-Id: 950575d7-3d6f-414a-6999-08dcb3334a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVWwQpWH1uip1AYry2H+crjo5Di5dB1+3/AEYuuqpMShTJSI5B4GhFERTHWD?=
 =?us-ascii?Q?Zy9+k8HjyWsDnEUFAD5aG/ENiF96+EwZi+4q0JH+SNX5npc1FPVrkcB+ltKX?=
 =?us-ascii?Q?d4KptVmayS4R2vBZitK+UTd/1F3IjIkfmLNcxWlSdKvflkKNH0piX8Ez6Uts?=
 =?us-ascii?Q?8T/6s7H3JzWA1HGX1OFxByz8CiVkXT4W8DTqNkPjAMLe1SRifg9xXo+FD80l?=
 =?us-ascii?Q?rhKuKJ2GvF47RmikARDXh9NLeo9rvq9i41TjxGNEd653V0uLHvbeqromytqF?=
 =?us-ascii?Q?i3SBNLRyIXUJNMzUoRNpxHDVvRMk5Mhdydtl9hXF+1rexKLYiga/oflvNIst?=
 =?us-ascii?Q?RonSGDn+aLrXV5pazYwvlj6vlYxem8/G6G7fylO31U/+R4zGT7SYAj70Y0w6?=
 =?us-ascii?Q?dys5k3UkZ/x7GtIBJ92qke3VdfyhNVDf5FW8NiCkNHuL+5stPLAJ6zWZGGf8?=
 =?us-ascii?Q?cAw5XTxGlBXPQX16K8AJc5YHv9NEiB6eHTchECEzxCWv/Yl6KalhZJ0m5EL5?=
 =?us-ascii?Q?HTPBNgCk+kGsAtSaXvWiz2NrPPKzgT0gkzp/S/d8E530Iu+RngcpFDkfDP2Q?=
 =?us-ascii?Q?yokFnWRSfNIUY3hLixATlyT2VNgSw+Ek7RDEat9wsv6mwca3CqgE0E0aROJ2?=
 =?us-ascii?Q?y92quokGc2e2UaFNPANR5r1gM6YrAm3VIlexCkFpt794rjpFw/gsnkNhVU9p?=
 =?us-ascii?Q?OB3zzhSehcx8rlLuLe4SOyo1VKmwHriK5Sk6v+S6qjNbJPKl6MJ+fxITBJMd?=
 =?us-ascii?Q?s6TsUqqCQzvydTX3Ywo4hS0QtbWGIfEB/TYQNRhlbrgIyzjefzYKHYz/nPDh?=
 =?us-ascii?Q?u2ntyvvq2XNXfkQLF0k52ru+xA1Kxt+aiN0i8achYQ6W3E/eM6hYW3mT8aqn?=
 =?us-ascii?Q?kZ2dG4N1mJV+GHrXc2JGBuVf5T6nI+8QV8DKf6v6mlnu3ISCZ8PyIb5tFc7D?=
 =?us-ascii?Q?dbrWsDLV06o8o2c3FerFK6XubcNqxXGkhOmZYjCai8St8uIZ8gfWqOSlmwtd?=
 =?us-ascii?Q?vMee7gDhSXErx87LfhBiG0juS37YyzMHYSnBfcYVOvki4hMr4+DE15RiAjjD?=
 =?us-ascii?Q?mThEeT+McnT86vBWbYEjBX1Ot6mkVaRKPReBFlzd7rBFTUmAEFu1+o8CUT3R?=
 =?us-ascii?Q?pA5sHg/4XL4CfVkdyVO55sN/Rr2kQ+daDKRV/0w+5a9N48RSQ2+Q2QIyLnVH?=
 =?us-ascii?Q?tq/Pgbpe5dlHNbtD3+rL+RQMYDfjq7cDv0MfHwR83KKApR/flmvO0VqwDYGp?=
 =?us-ascii?Q?UAL0rPf+rCYCnPFeL75kwbhR8VTPY++QIPwPRbEh9VSMdLIBJ74Vmikymdju?=
 =?us-ascii?Q?UeoxfDaALRDSlmgPmpw0vIx9yxcfwiO3kfIPTHM2eX+xBuBGID9DmG+jCeTS?=
 =?us-ascii?Q?0iN2TbSEWux88Hhwi0tufrHUb8MpVG6v+o18vMeWg8fFDbziPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MuO3+LhAgPHw4TS0mH8gCjFvQQ3mrfMhRFazqT03XAgcbwAGidsL0IDiO9lW?=
 =?us-ascii?Q?++b5TJPL71Od+QPfT/dHatQkh2oW1aJHE98YbYmvZPBM+we7Hc/aWeSAe98d?=
 =?us-ascii?Q?lMJ8TcFwb7dkZWfvSEalPxepA4w0yrCiuFlERaSAPOBDjArth4fLddOK7D0J?=
 =?us-ascii?Q?PFd3jmgEnFp0jdjAB1mgwBvY9e1q3ecyFxLmy3bNwAMQat6ggW82+GOKodNy?=
 =?us-ascii?Q?Dm6bzdFj4ulLI2Jq9rUlW+BTdID0KpstLwl+eHeIL3jrM5d1Nkof901wi0h5?=
 =?us-ascii?Q?pqYk/k5u6PY5Jz7Duo5WQPiD5DdejPIbReUfo5o/HTFCR/2C/mzmw7fl30Ms?=
 =?us-ascii?Q?61+gDuTp6Cu5CRsigjby8l+dCjQ1IAX72IODm5AG5nnjcGE1tFo5WOZmKDaG?=
 =?us-ascii?Q?0T3D+3awYR2mWKSN8Q/FED4Xs7ObEVGBXoGXTtwGsRd8Dv1DTF/QxSS5wVtg?=
 =?us-ascii?Q?iLqsMBFk2SWNzTWo7m2Ka7swFhsLrl4Ndxr/U9qhikGM4sKX1by6vC/doqu0?=
 =?us-ascii?Q?Yi22VPUpFBzDIBK2jainwsXPhhMjrEYj3i3lq1IIrGG3i3pBWYwSwv+86l1b?=
 =?us-ascii?Q?71bt7DfCHk+MbLMoVfSyMeMslwl8m5c8PVRdynb/fvShhzMQ2egDb4vw8P/e?=
 =?us-ascii?Q?bcn//ww2q7d8g+YIqX3PdbWL2Mss5uW/QicBOTD+j2A626Ajj/nv0N1cBtNG?=
 =?us-ascii?Q?+fE/w/LOnwMUzicyan3CxgLsDciFGdIPBAhYOLgLMt1sURpNiMizTQrmdsDv?=
 =?us-ascii?Q?3OxnXQE0iiYcZILOCI7Bwqo8Go8iCvvMYNqYPhNS36yGfoxxHh1GZ+NWwu40?=
 =?us-ascii?Q?rBjmfaNrrBengbECaxTKMsutfx4oiRYwkH2wdbr0NfhLTRwz1lWpYwmahy+k?=
 =?us-ascii?Q?XjFbb7SmxMXX1gNOuYFRdKPUg1yfDrAdBVbsbpb+R3t4zwksftq6FNm7Y+fv?=
 =?us-ascii?Q?vZpNXvf5oM+KXvdxDEkl7zwfv144PgKWuPh5NaIcjf457sc42U7Vc+6r2XkP?=
 =?us-ascii?Q?nHE0BTK8JGAtq7Rc5mKjyMduA7bAQDpRWpQjNyWrIsw0+ffRtQSWL7peMKW5?=
 =?us-ascii?Q?JUurOhqWufLYNQCO/pguakiOn45vlkx5F2janFn86GNL2xLXCC6n7RL3BbvM?=
 =?us-ascii?Q?81FofJoAbW56KOdIURlHl1UZZQrrjIheHtL7NrG1EGg20D5tHiPXCyBNLGBp?=
 =?us-ascii?Q?8J90qRINzgp+J8GZM9+VGiF3BLGprr8DQ+lDtSMplWowj5IAwTvbC+Il8CVr?=
 =?us-ascii?Q?T2bCUoFHLjRSc1KmzfjEMd9uHrB5ffMmOxzzTtmWnp1xNoVlqOou5EhuF5AO?=
 =?us-ascii?Q?0SVal2rtCRtXtAIGoC+yOMvwu1F3oIhhgTr3eETFs1aEXgUbbVO2+VjlRb1y?=
 =?us-ascii?Q?GJ5Eu9kS1j8jrP0ejWVPBn7ztthZGWxxKkdG86A8+CIoZijMlfedJsEyfiiC?=
 =?us-ascii?Q?n3fQLgircF7ACwTgsTKuqeMUyZJiqm/TBWRtgaMC/jVXegs3HNqFyPnbOVMm?=
 =?us-ascii?Q?mJrBPZr8TWM+wwqYz+tiWlyvv6/MpU9vSEAeFSCi/wMb+Yu4B1UtqqH0ePAs?=
 =?us-ascii?Q?xKe5nRMkPph4rhgB8wv998/oirYUuzZ1e4m35FHI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950575d7-3d6f-414a-6999-08dcb3334a42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:40:05.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kr1y3Z71C65ZOt0+VVSUU+vJafy3IYNlUNYKcifiXVVcO9kXwg6ZDkaQgoDnIgHW6hAagj6ghejcbt/NdOxTMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10801

On Fri, Aug 02, 2024 at 02:46:49PM +0800, Richard Zhu wrote:
> Add i.MX8QM AHCI "fsl,imx8qm-ahci" compatible strings.
>
> i.MX8QM AHCI SATA doesn't require AHB clock rate to set the vendor
> specified TIMER1MS register. ahb clock is not required by i.MX8QM AHCI.
>
> Update the description of clocks in the dt-binding accordingly.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/ata/imx-sata.yaml     | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/ata/imx-sata.yaml b/Documentation/devicetree/bindings/ata/imx-sata.yaml
> index 68ffb97ddc9b2..f4eb3550a0960 100644
> --- a/Documentation/devicetree/bindings/ata/imx-sata.yaml
> +++ b/Documentation/devicetree/bindings/ata/imx-sata.yaml
> @@ -19,6 +19,7 @@ properties:
>        - fsl,imx53-ahci
>        - fsl,imx6q-ahci
>        - fsl,imx6qp-ahci
> +      - fsl,imx8qm-ahci
>
>    reg:
>      maxItems: 1
> @@ -27,12 +28,14 @@ properties:
>      maxItems: 1
>
>    clocks:
> +    minItems: 2
>      items:
>        - description: sata clock
>        - description: sata reference clock
>        - description: ahb clock
>
>    clock-names:
> +    minItems: 2
>      items:
>        - const: sata
>        - const: sata_ref
> @@ -58,6 +61,25 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description: if present, disable spread-spectrum clocking on the SATA link.
>
> +  phys:
> +    items:
> +      - description: phandle to SATA PHY.
> +          Since "REXT" pin is only present for first lane of i.MX8QM PHY, it's
> +          calibration result will be stored, passed through second lane, and
> +          shared with all three lanes PHY. The first two lanes PHY are used as
> +          calibration PHYs, although only the third lane PHY is used by SATA.
> +      - description: phandle to the first lane PHY of i.MX8QM.
> +      - description: phandle to the second lane PHY of i.MX8QM.
> +
> +  phy-names:
> +    items:
> +      - const: sata-phy
> +      - const: cali-phy0
> +      - const: cali-phy1
> +
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
> @@ -65,6 +87,31 @@ required:
>    - clocks
>    - clock-names
>
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx53-ahci
> +              - fsl,imx6q-ahci
> +              - fsl,imx6qp-ahci
> +    then:
> +      properties:
> +        clock-names:
> +          minItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qm-ahci
> +    then:
> +      properties:
> +        clock-names:
> +          minItems: 2
> +
>  additionalProperties: false
>
>  examples:
> --
> 2.37.1
>

