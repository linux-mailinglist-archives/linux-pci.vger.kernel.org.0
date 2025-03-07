Return-Path: <linux-pci+bounces-23131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C90DAA56D1D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 17:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0029016A7CA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33C6221547;
	Fri,  7 Mar 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a6Ng7q67"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67321D58C;
	Fri,  7 Mar 2025 16:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363611; cv=fail; b=lPqYyZzsRaGpnrtQracWhAlNNXI/U/Gj6IVHRBsYlPxxWfGpJCTayUvyfNKJshMRCIRObcqdrxbSfhZxH8M6eHj2ub8Rh9Im4iws36VK2hdH3wMDjzooMhO2gBblZKOLZLVC4aK4MVCv5xMlqaD3LyQsg7qBjxJ/GnFYvtXXWhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363611; c=relaxed/simple;
	bh=YN0mo0avaugQW0bZ7icDm1MGOhJWlMxiTQOwVCCwCOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YJsXhMp0S8KwbNEt/C9PTu74nMOce8OSXp0XLEAVV91p3grBCwyLCZam02CGlrp/w1UoKRvLLpxfke9GEF7W3OILAIhy3mTdrqr9fHI0IY6mhkSYUhnssIc8WleUylX5hc/Y6RJOKWH1/Mj91m20PFVr4+lF/+RWUiBvDRmq6Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a6Ng7q67; arc=fail smtp.client-ip=40.107.249.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxCFOVg/qd2Fp3pyAJJp+2NJjmIHDag+Lff8sI4pSNXSKOvnorQCvXOdy61+vBe647ZFmdTlepg85RAA/DPz31J/EtlLELlpLOQIskrQK/9k/KsryqNS0KeTzIUS4kPDIfTir7AKM1AbPu/HpyxELDCY7atOxYA1fwnwZZd4yjoHK8DqGRO55r0vCX6uUvRQCxAKx0CwPsULxVOtcJchDqtfr+cpEsnEWAVUtDVWqjFNJOgOLF/dvY/OPIB6wcKxugkwnhNrwUR+1UQTh5F85ARisFcQ1Do8PhfojJUAw9vLLpwcYa1xDg6bcm4WXIbmEjhiD+zyIJ0ndSJWuEdSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYoPKTioCbxUCtrpQMWvilsx8lOfo1unztWmfzlKuDo=;
 b=pGdDpISc8cBaf0iF7VIPI6vAfRRM4UyKqppHI4sSy7vSF77GDx43R2GXfLwahGloXauWP44p4kbmlcl3yrOPPj8zydyIbyDErnMCTpu6+gtYsr3zyuQ10bA6LolaoUFPtza+19wai6nZkB6Jxv+rqa0VOluq/5ZtCfLDJ5e0Aj+KwL067Hd/bY8d1o0tZ5+HAFP53MxCkwB+gVhV+SP5RRX4ERlKzYErDGL+r5fnzxjK3qYRq64P3tsvRsYkAfdUIqKL9Pv+N0CBRCn2g4o9v4WaTaps1w0+JxDV9oKQXMR2xA2uZNz4fr5Igph+R+aFVPpKoG8TAIwqVOGJd+trog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYoPKTioCbxUCtrpQMWvilsx8lOfo1unztWmfzlKuDo=;
 b=a6Ng7q67P7M05ibHvRoRgn+jq2azf2dUfkmAruKukyNNgPK5HOi1Y75jpe2Og7DXtLIhRiD70E1cOk0Wt7UqSa45gT1MITWhi07u/dect4EZalYw5eyom1wKslVS16FtQlCv1akScClceYni+d8+Xccvgjr7bgOycYXLCn2LgPLgizgKvbNJAPdVruRqHAh4TZTewM9ifXRtBt7tH35mxyQ1p8ydBY8B+4Ri8mTFLcSaPKjWaemm3cEzUkCEVpW4FGkhXHsRbsyTkJOJoCrx1+SfwfqjwN/LQSqu3abma75aAoFK99ZmHJOxE3qGPvyztGJZrKa4Vx1jBG9/ZWDpyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7495.eurprd04.prod.outlook.com (2603:10a6:20b:295::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 16:06:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 16:06:46 +0000
Date: Fri, 7 Mar 2025 11:06:39 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop
 deprecated windows
Message-ID: <Z8sZj5/nS11YSn/m@lizhi-Precision-Tower-5810>
References: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebd379d-3206-46fd-333d-08dd5d920fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sLhoNcJJ1D0SVRtT+PnolquKXndy40XC5XQ+ww/pRorxKJ5NBy9nG1/7Eg9d?=
 =?us-ascii?Q?5V2x6DPcDs5+y8JuwV9ixYjeqk2FzMKz11sFMn9oEYLZuFuPi0/JM1cY+6lD?=
 =?us-ascii?Q?4/ZlhCjg1yvcqhzSWtDkR0z/hMzJ95nswb1trXzvdxcHIVK/3eKt9UWyKadO?=
 =?us-ascii?Q?FHD9nDnMYc2Y/roYOjPWYB5p/Gpcd5D3pDZmCqDbVbBs72+5teF+OVs1Ja/B?=
 =?us-ascii?Q?sAa7mg/hxsDbJZxwcFBbaiTejGkQPh0daWS+IaX48XmjBK/vCfwM6V2iR3Ga?=
 =?us-ascii?Q?7En2JlV7NzjuOsSfE5G33XSS91N0AHdNjwcCKFqhgE1BRXvpPdWHH4+LQJTl?=
 =?us-ascii?Q?m3yrnI32qq72iJoCc/OHbgZj7ZBN0mOYpsDKS07/PKSlJap3ln8pCa5990aS?=
 =?us-ascii?Q?AKIIN+cDYsPCjU4VmRp9a6rcG0e5qd7sYcJusKwByHR5DtL29gMjFiRO38bf?=
 =?us-ascii?Q?QJGnKMxESFpHQfS3O2pPwF/2J8bMhzYjtlVrgQY7AuZIc39u6fruEga06nCw?=
 =?us-ascii?Q?ijvFH4oRe9M9bAofXfVNhs7fJJ+H10kPmeNpPeUn5elLNl2j+M5xw50wyJKb?=
 =?us-ascii?Q?Pgwl/d8RmG4b5Fr/wjUibATlwHyzHEAi+VuIDok4sIz94m/XH8uNdeXwvm0c?=
 =?us-ascii?Q?/NGTVy3ojpo3X8Ma0tLdJt1bJ5TdM7YxyGJxe2suXKg5wvx2ostj22aXggHF?=
 =?us-ascii?Q?cgXrHdr9RfZIidqYmkrJ2UArm9TQZs4pi3M5qLPv9QFT7LUdIzdV7Mzlwl5N?=
 =?us-ascii?Q?B481+Tebz26pdy+HdThvWtnD55nO1GfWSkOlvxgAg85FS6c/4LtzyIX0K5nD?=
 =?us-ascii?Q?xWJMjDyRODPprJvUWl5Aa4sh8K/hK01lpUijZS+69fFJ/if1WCBJzExZQEeX?=
 =?us-ascii?Q?4rRFg5cbYvL3iiWe2Nm7efvZotZtGO7NmBBtuLMmigBqmU4+kzDmzg9bGLtv?=
 =?us-ascii?Q?/AflUoXUh9rkgDT4Sguf3tMAjLi2Y73eXnCqsyQZovLoIrqcpDRuU8vTKKyT?=
 =?us-ascii?Q?A6bVVgDLSjgFxTEjajeXfZxN6wGyxD2BkrVV7jczTypJY7HHLsriLArtgN6i?=
 =?us-ascii?Q?ylnGZn1IWOPwsCt4uUut9J/++vmxpz0AzXKJG2S6vHdFOWmCMaw4FU9XQAxD?=
 =?us-ascii?Q?UFO5+py6qIKN1ZJY32VP0o1BUP8wkjenNm83dQCLTD33aRgdR+N92IlXEgEN?=
 =?us-ascii?Q?kEqzOgKfeC84dFIFwnuA0D9CcVV7ogtvz2qptEbgDjr0m0TaIQoLTU/88W3s?=
 =?us-ascii?Q?EatRtP3Ah2SzHYgwm8t2bjWbfTcLwaVaBsITPul5LSfd4HvkpVYWt5AY6P4U?=
 =?us-ascii?Q?hWN3vSgkdDQXa3ldZhWfq86+j28AL+JNHWQwW4DXuwgPvcrm2SDUObxyE7H+?=
 =?us-ascii?Q?reNLltOYNpx9lqtWQ1G7Sbbt71jH+V7qKScBPUG+ilRF4qNo9YWqgft/dkqj?=
 =?us-ascii?Q?EYLgu1ocvfBCNMdCtI6Ui2Z5rdr6hHTm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXJhVJMQsCSZMhWB4XuO7dI+0qVXtl5h8F2sYxjlBaRfP/lQFBy0d0wdjYjz?=
 =?us-ascii?Q?l4f6snREBFOMsU5AdVHbQIRw7pdouSHXdDYntVcyniQ7ntawH1vjlyYq6SN8?=
 =?us-ascii?Q?U1Miqj+B3VQzszPV3VzgUvG1ziCJ1HJaLU0sWe6DhaeMW0XHp2bJIUpHqBhY?=
 =?us-ascii?Q?iC+lEOg1gMtBHahBj9u5rnURs0CeWwXovN29UPG1jVCIcADjN38nHsC0KFzr?=
 =?us-ascii?Q?8S0eQ0wr5CBE3LF8F9FTptrz4RWN3JzfHpZ4XaVQfbgVkTkNasP8CICLp9eh?=
 =?us-ascii?Q?EjAAVYKgVJd/SbFLNtxL8ersulO90UiPdxmvgOm9ALcyg1Zc1Uhs0DrrjnbG?=
 =?us-ascii?Q?ob5TW9y4+SqZqQY9NdavUKiN84MaKur6VG8eklPcFThNI0m0/1urrpdPTYh8?=
 =?us-ascii?Q?TUtKVtSokzlvjGW3Dc/TJYVaLGIAWYwjQOidcnlnBCAIkSKXTwWxpFSQeOQJ?=
 =?us-ascii?Q?IiqpymmzshIZD1GmBq2iODzVfVvJAJvUBf5Tk57zWnU8hD4in3/gcDMHXXu0?=
 =?us-ascii?Q?P8uMLc7GW0L/DGZtWyJqwRUhu2U4x+l7XLhb+1W8U+ry22/NWTsKGbPKRrhf?=
 =?us-ascii?Q?dX8s3ULj0S7dqJtlv99U/VOffaHZ0KpBgFe9zAFrC9OKit7X2UOGGZrb3DWZ?=
 =?us-ascii?Q?7hRyfYINRLzgSrvosYr1DDPSLlnVxORa7eFPMO8GW9RHS2y2aebgHBNhR6cu?=
 =?us-ascii?Q?lC6luflSfQk0Bbx6SRyTShbk15Eh4TFmI6UZFznzHgF66GYBBcDOcxHyip0F?=
 =?us-ascii?Q?jK9L9QXYYySU9puXKfjvHvWmIqjTz55slVIB70G7kvC+VIX7AzbExcpSIjdN?=
 =?us-ascii?Q?7s9cSvg8Zx6QmwINzpY7nWnNz17LNaLGKIQN9mj2i1IL8NWa119uqjK5+Shj?=
 =?us-ascii?Q?vQQvejvSulLrqHqNIJ4ckZ3EC2FEB7GrdA8UI8luz0DwlMxhAqoXyYFo2oK3?=
 =?us-ascii?Q?ywONMHGMDSvPkxUkq2RAsuAHIR1Ii0GyBHZ8DFF3gV3RwPqIiU0KfHQhQ6ip?=
 =?us-ascii?Q?HaYWar9/ehTrshm5t9DER74j6zLsN+ke1LDqs7PVzRYgpoy/fJrw7CdQljLa?=
 =?us-ascii?Q?fL+7+fAJMUchNwuZyhXYZpfeqogOO+MMoZdw/neCvLCR/qgEj55NtULDhckv?=
 =?us-ascii?Q?wed2JNc/pS9KX4H/3pyyxi797NFfhkgwWINcdxOqi3WOpuVeCgo8PUWtyUKR?=
 =?us-ascii?Q?Pg6mGBD0iCRWhvJvt6hfsF2cpjACcxPN6oCPB4Q4n22XM+P6eQpF8GV3ZIgb?=
 =?us-ascii?Q?sH/E1QQV5YgvR8/YmYX41vBrY9FuTokHEQnHkOLjDhzQfUH4SxPK/RW8I58U?=
 =?us-ascii?Q?1xHMYQf8V1fURm2XhJdGcXt+RQcMOaf66JYNCtc59LrJTW/KvlhQjTk8uv6M?=
 =?us-ascii?Q?yU7Bnifoq9r/HYD+z/CyPRkcQOpppqr+HAV3qyBrozg1OKdvT0zC/zU5ryof?=
 =?us-ascii?Q?N3HGa9mmAGYki/nJMBeUZnkCN6ddpQpJUOW1k5bWA59oghKeMfeKbAceXLHN?=
 =?us-ascii?Q?MB5iTQChw5apsp3egrfvnqsUzkx0Wygs5MgB9SxgmWQ8xbXCVjHJzSnaMhLF?=
 =?us-ascii?Q?vUNvG61s+f/2QjMau3CqPeqytVhK8wHBLfWu24cu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebd379d-3206-46fd-333d-08dd5d920fad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 16:06:46.7184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TV/K6mA+bBKXv9OvJZgpRPIVdlmCbpRuZKY+ewPmMW9+yv9PqfG8g2+8UJ//XbnBrxOEMokKIVfzLMuytqyqSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7495

On Fri, Mar 07, 2025 at 09:13:26AM +0100, Krzysztof Kozlowski wrote:
> The example DTS uses 'num-ib-windows' and 'num-ob-windows' properties
> but these are not defined in the binding.  Binding also does not
> reference snps,dw-pcie-common.yaml, probably because it is quite
> different even though the device is based on Synopsys controller.

The reg-names is difference with defined in snps,dw-pcie-common.yaml.
Driver and dts's upstream is quite early and change driver and dts's
reg-names will cause back compatible problem.

>
> The properties are actually deprecated, so simply drop them from the
> example.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml         | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> index 399efa7364c9..1fdc899e7292 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
> @@ -94,8 +94,6 @@ examples:
>          reg-names = "regs", "addr_space";
>          interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
>          interrupt-names = "pme";
> -        num-ib-windows = <6>;
> -        num-ob-windows = <8>;
>          status = "disabled";
>        };
>      };
> --
> 2.43.0
>

