Return-Path: <linux-pci+bounces-10559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 956D7937E05
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jul 2024 01:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C73D28235C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jul 2024 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4605EE8D;
	Fri, 19 Jul 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kzhtJ0H5"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4E3A35;
	Fri, 19 Jul 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721431957; cv=fail; b=uFaLjo3GH5xibYB15AE47pJZpEAHY5g6qc5Q8tEP78+Za2Rsjkjb4JG9fB0QMRiGvLKQr7V3U94cWIMVumvYf+S/W1jFJzr3OauXLLPaBgwQtfQG0EAv/fy/3wWmvFvqvFaceot44PNnxXgek0FMAxC3dN1Pt3yc1G5PPSgNPt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721431957; c=relaxed/simple;
	bh=aLpBQoIFluB2nHU4BPafzJK47rq2AhreFnVX4qAmpxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iXtfIJQOnP7V+Y/xvunSafDmqAntZy4YaCin54MG5pWaSqWbPiSIorpYe9VpVLkeeYs1W7M/yZR3WDfwYbvxXfvScohv1OB5EvSUKEWtqB7EsZYKuRBYGRkZY4C3qib64pKaE7FZoi3dC8TTsoaCMebavtvcjEmdnjZLmBX2lsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kzhtJ0H5; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkLpaS5Mw+zRq9bXZOKmkKm3wp7YHvD0U7HmQtwIsC+MogbdhlfhE165JS8PGEtz+rKzpNs1PjoUB2JUoRyQTORIH44Q0hf6Jb1RQ0z2XkTdS3GhXQtSH0PRweaHqL2rIBrIdnZBvgPdSgeo73GaVBIF3qPgNZhMkPV2nLHYsCfyoD0csUtmHYkwBRqbDOO2g2s3eHyqAhZY5xjWeGAvywak8NHiQRvDtvohcgEGN/o138eJddR+ACiWqoZudw36MAeT6lzS+PwIrZvfSA4/mV1cHMIKYErUF3MSYv/RrXrQxcZj6cV0YW/Heb6E2M4fATdzTPvnAQZGy0cK3E/saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgvLn5QYFYdcWTL4b27zaBV8wuPlxSRosDot74zve0s=;
 b=hWqajsVog+B6eWEiLdYXZBUadFASQEd+Iie7bTt/QS4L1MtjNG01Y7ndG5bqWnigrOKbqoxO3++IKqTlBPkoUX4+buhzj88ojuc4NKrKu3YzgRbl57GmeoLa5+/V4fgcukqPpllOvEpRO7iT/EA5PzcSruvxXLsuISNpx2O7OvfsMw93QdDXYt+M8x9vbXrZ8TRU0ILlVELv1uyiaORDcueiz6S+zhMaEvGllsCP2mz/f2RHj00s3OKkoYDWhmaWMOJnvBYri5ClL6kqbiKgWPG3Oq2Lv/pt0F/02ifi/IR0bMDG/TmEmWrSn3wOKARHda0SVvUi9tJnlKGeYJyeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgvLn5QYFYdcWTL4b27zaBV8wuPlxSRosDot74zve0s=;
 b=kzhtJ0H5KA5oqSQx6lPr72/EfhnlONeWUIwef0dSCCd4n5tXRefjEbZkE7lXdrzh73H8kiOyVNiN9ku3GXSQAU73rrHVL2L2ToMh9QYAZX2Y7pOuQlYw6tZFg85KFogXnnjiD1pBfyE9B69/vDx2uzeQ78xmWFWnRKnNem6q47Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Fri, 19 Jul
 2024 23:32:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 23:32:32 +0000
Date: Fri, 19 Jul 2024 19:32:23 -0400
From: Frank Li <Frank.li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 12/13] PCI: qcom: Simulate PCIe hotplug using 'global'
 interrupt
Message-ID: <Zpr3h7c3JRKqjtyb@lizhi-Precision-Tower-5810>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-12-71d304b817f8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-pci-qcom-hotplug-v2-12-71d304b817f8@linaro.org>
X-ClientProxiedBy: BY3PR10CA0029.namprd10.prod.outlook.com
 (2603:10b6:a03:255::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 410338a5-3821-4c24-b9be-08dca84b0fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dzV3NqYulWBlNfEJkwEHxQN24sOlJiyGA2KE9prHcyk9xiUvY3wl3eI67/Of?=
 =?us-ascii?Q?yGDe3Op0Bk/l04c2Slin0SEOxBk5KRmJNuu3XdemArvOGbH09uHkMoky3T/i?=
 =?us-ascii?Q?jPQ0h7MB/YlgWihs6zcA/2MRmvo0A0fpd0UQNXVgtgMP8kNauslkIiuNbd8O?=
 =?us-ascii?Q?sEnx9XUzX7CKpShEpmWkdyX3G6aZfJAhMcLhTFtSG/dmHYIUwDmAlEZhfsTf?=
 =?us-ascii?Q?xQSFRAGFEssbQpmkFr66eXuHqXREsMtyK7jKeytlwSGGd54HvNue21DIGsHE?=
 =?us-ascii?Q?okh6ICyhs3eC86c6uGe3faVh8MZ9SIoMikJAFQ6NuewnRMT13UT1I7jf0xbL?=
 =?us-ascii?Q?H4H2a++cixq/Etna5vjYkkKbSaFwXHwFegpqgfoUjV4p2prFJsvvkggei9ZQ?=
 =?us-ascii?Q?l6KbKKrLB2lmXnfgfegqt7XvMzvw4HAXBpGFv+B5+JTFVurKIABdbxl15qP5?=
 =?us-ascii?Q?PEx/TEWsQlZzlQ9RI5WoZ5vYdi7QtHSggtvDJGo9fBf0VGikCninvWhLpsJy?=
 =?us-ascii?Q?X++DNrczP6DsoRVVHoY2CCkPmdggPPiqqzk4iRTmHUlrgMxg0AvTxdtqa7S8?=
 =?us-ascii?Q?zZ4R1FzQugm+f9MkMUt07mM4SG+AKI1Yx26pLpL6Y8qp0KZtJxLKLpLpMYVi?=
 =?us-ascii?Q?PqvRZ8t8Ew9T7IgNt1XRVmBbujrbB9l56JW68RyRl+2lqrY2/7sydX/fdbEw?=
 =?us-ascii?Q?FB6q+czjyHvLgD7fowXOWCovkNWcA8nBtej0y7syo+jFzaxBvYb28pXLROUN?=
 =?us-ascii?Q?OZNOfrwccy50rGGsy2pOR130Ln6UWYjAhqpbA/RkJ7+AH/MVMYZP0PhcRKQ4?=
 =?us-ascii?Q?qBCFN69Ib1ip2ErcrC52+YCKvUIinrbkB9ZWQh8BHdpiBdcE2DnsiXu7fONw?=
 =?us-ascii?Q?ddTvLwakWGwC3zStHUMTX2ESmmpO7ODotkonhfwWlfJe0TKUmlAPgCSqcXI7?=
 =?us-ascii?Q?t9MytcJ1u5hfulkshJI8x/FmOdXbsavRc/R903IstxT5+TWdn5qTdCaRAaTK?=
 =?us-ascii?Q?YoU4fUCo5W5aYHY19AAQf0kI4xPifqp6a86nQCw6fSp2/NUMEa8B/0B9iH5C?=
 =?us-ascii?Q?D8ORXwctXGQCY6cWiwIiZWNAcpNTUemPAFDjbUXlnj63mPy2KnG8sWjDoPpE?=
 =?us-ascii?Q?9s0e7HrLqVWr/Ts8FBqku4ifJtpe08l0SNu3eLH5GS5aiwHvuXPYq9g3g4mH?=
 =?us-ascii?Q?ZAdDQN1Py7CHWKFfLagakWnhTvXNek0M5/t+gg2gKFkcw9Z+hk+LhNL6/4LC?=
 =?us-ascii?Q?I7Op2eqk3o4zKslBgVQ60scLGT6w4aXR1bm00GSzC4U32krmtPNcBcC/kc8e?=
 =?us-ascii?Q?cNgyB+3IAmDaezUsZmpdKRQG8R4vFbPEJW28sRBtuKSl0c3JIk6aP9MWDM2Y?=
 =?us-ascii?Q?1JUhN7LvENCv/pVrSkoWKJMerogmxFyMFJvp/yaYTik90Rs5+Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMiCsu6XQluHszg6qr/cXDBdG4cXFTZoGYWi4nbWOW4iZnea4RIe39Stu2PE?=
 =?us-ascii?Q?pNuK/f5fmiwTZboEcj75dBZDestTDoEPVxgvMaDt1yKDXCPhOATiu8ZemdW+?=
 =?us-ascii?Q?svg+h409c5Rp7U21SvBhPnUWmD+bEgjPJr1AYKyQhQ0cGca93XgQvOC1mMvo?=
 =?us-ascii?Q?ri/D8i7Y21Lyzh0X0Zu/OSQVksrqfsxg4mp1dHPLmFFBcsMKfOi2ZVLYqCg5?=
 =?us-ascii?Q?+cusPLzgbt9AGcXipBE5AwwhuKYvGUU0q3Vwx9jyh3ySsYqqVAQfZb0tPhpo?=
 =?us-ascii?Q?vZuvb4wfaNNMEYxxryB2gZ61294PTAmLdEl6V6FO4EIAR4XTaf3xvA3ecVzs?=
 =?us-ascii?Q?QkN7paEEXBT4L33WNBvMkde/UgFfg6Itog1ZsxwiKh3ZZPnu5J0PhE2QFViw?=
 =?us-ascii?Q?z3dwcX47AwNKVO0Ny8qe4ykJs9CoBMwiH20MA+LzBtFGBRojVkVtQclwPfw7?=
 =?us-ascii?Q?co6I2otu7hQMsyGoEylDKL8IaW/ZZDLBSeh2ybrPc6kMuMD6nn1CGNClQBfS?=
 =?us-ascii?Q?u3Mx+zlTNoXyDM4CATxQ8BvrzN8pTeKN5rT0J5zXSyHMfAyKLR8ma66bBl5Z?=
 =?us-ascii?Q?SmiO8fdTlJCuvUa6147hsYrAfremWtgl/Yiyu8bTvbw6zpHFznNiusVbuHHr?=
 =?us-ascii?Q?AoIhIO6mLwYDNFEggCtIGjLamCveCed3j4UsifQ/XRJhQ7QwgrDsnJ5vs3Ei?=
 =?us-ascii?Q?+NRg9aTGq3kmKCvhP23cxS0mU0FeuwoaLHL3VVuPNPlZDtthQyuw9WiPeYJe?=
 =?us-ascii?Q?TCeYo9N8m7GWLtVwftJ5ccEXuvsmrSKEqbz7Q8FOC09I7LQScwvFjcutV6ZJ?=
 =?us-ascii?Q?FFGLUEzKpjSiehRfPBivqQ86/zx1rt4P1vfVhApHM85RgkPV+UymS9SQxBx2?=
 =?us-ascii?Q?8ltZRC3aVNt2GTBjyZqKC0UrOtnFJpRXqE2nOE34To+R9LHjXEePfvGjmP86?=
 =?us-ascii?Q?UfDWBtwbiGYr/sioomda5m9Tn6EvjcpSrj6Mat4NcA+ZMyrHxevsCew9F6lK?=
 =?us-ascii?Q?/AtAI0w2GQAA/dcrEfhnknTvUkABr7ipY7y0GpfVWsHQcofwRF0OU7Otj7OL?=
 =?us-ascii?Q?oWl7SKTAXJGtR97qbebyyo4DNXfGU7lYBNHSq94HaouS5LRlgKcr1ng0rvoE?=
 =?us-ascii?Q?OeMf6GqmoY8IskhnUdDE8JfSGgvZPvlpfVxXnsB76PCiFsGWkI1jkro1SJbn?=
 =?us-ascii?Q?GF3LC1MjBjQCuV3ZQ5/CUWYjKRvT8JkJZ/iFBFaB7rPL8kkJi+bbcdUjUNrh?=
 =?us-ascii?Q?bXwadsqj3sSqeaW7/AVNZB5s/NQ9/22Zfo/4Bl3vVC459j106E2zgr7d9CCo?=
 =?us-ascii?Q?GKWy+4LyVvpmM/wUE1odxBxF83XAE4qigIQuBUyF4TVriI9m9Kij1KohSJfq?=
 =?us-ascii?Q?+GRQZQye0AY5o/w+GbpDqhxQSuYVFGX5qhS2M/qwLr6CbWBIDvKXutYKkNCf?=
 =?us-ascii?Q?0Ccs9g9JI0tOw9rBM7LlVLeVz0r19FK674R6n1i3SFmZWGzAv9UFkNGklsGh?=
 =?us-ascii?Q?VBBUtHz0bHMngCgs78xhYpI41JbYHsc3lmoClZpI420vREpssTwiVmzfYw5n?=
 =?us-ascii?Q?HGLCqrpqkhpYm658pHo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410338a5-3821-4c24-b9be-08dca84b0fe0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 23:32:32.3213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eYBXvebJLg4pT9FKB3JK7BmSSkGKpJu2ENZlJM4qVfi6R/Xf2dnSMF7v1IN/p0AvDS0g8Warn60BqiNYxfRMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610

On Wed, Jul 17, 2024 at 10:33:17PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Historically, Qcom PCIe RC controllers lack standard hotplug support. So
> when an endpoint is attached to the SoC, users have to rescan the bus
> manually to enumerate the device. But this can be avoided by simulating the
> PCIe hotplug using Qcom specific way.
> 
> Qcom PCIe RC controllers are capable of generating the 'global' SPI
> interrupt to the host CPUs. The device driver can use this event to
> identify events such as PCIe link specific events, safety events etc...
> 
> One such event is the PCIe Link up event generated when an endpoint is
> detected on the bus and the Link is 'up'. This event can be used to
> simulate the PCIe hotplug in the Qcom SoCs.

Does hardware auto send out training pattern when EP boot after RC scan pci
bus? Who trigger start link trainning?

Frank

> 
> So add support for capturing the PCIe Link up event using the 'global'
> interrupt in the driver. Once the Link up event is received, the bus
> underneath the host bridge is scanned to enumerate PCIe endpoint devices,
> thus simulating hotplug.
> 
> All of the Qcom SoCs have only one rootport per controller instance. So
> only a single 'Link up' event is generated for the PCIe controller.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 55 +++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..a1d678fe7fa5 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -50,6 +50,9 @@
>  #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
>  #define PARF_Q2A_FLUSH				0x1ac
>  #define PARF_LTSSM				0x1b0
> +#define PARF_INT_ALL_STATUS			0x224
> +#define PARF_INT_ALL_CLEAR			0x228
> +#define PARF_INT_ALL_MASK			0x22c
>  #define PARF_SID_OFFSET				0x234
>  #define PARF_BDF_TRANSLATE_CFG			0x24c
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
> @@ -121,6 +124,9 @@
>  /* PARF_LTSSM register fields */
>  #define LTSSM_EN				BIT(8)
>  
> +/* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> +#define PARF_INT_ALL_LINK_UP			BIT(13)
> +
>  /* PARF_NO_SNOOP_OVERIDE register fields */
>  #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
>  #define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
> @@ -1488,6 +1494,29 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  				    qcom_pcie_link_transition_count);
>  }
>  
> +static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
> +{
> +	struct qcom_pcie *pcie = data;
> +	struct dw_pcie_rp *pp = &pcie->pci->pp;
> +	struct device *dev = pcie->pci->dev;
> +	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
> +
> +	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
> +
> +	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
> +		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +		/* Rescan the bus to enumerate endpoint devices */
> +		pci_lock_rescan_remove();
> +		pci_rescan_bus(pp->bridge->bus);
> +		pci_unlock_rescan_remove();
> +	} else {
> +		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
> +			      status);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> @@ -1498,7 +1527,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie_rp *pp;
>  	struct resource *res;
>  	struct dw_pcie *pci;
> -	int ret;
> +	int ret, irq;
> +	char *name;
>  
>  	pcie_cfg = of_device_get_match_data(dev);
>  	if (!pcie_cfg || !pcie_cfg->ops) {
> @@ -1617,6 +1647,27 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> +	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
> +			      pci_domain_nr(pp->bridge->bus));
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto err_host_deinit;
> +	}
> +
> +	irq = platform_get_irq_byname_optional(pdev, "global");
> +	if (irq > 0) {
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						qcom_pcie_global_irq_thread,
> +						IRQF_ONESHOT, name, pcie);
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret,
> +				      "Failed to request Global IRQ\n");
> +			goto err_host_deinit;
> +		}
> +
> +		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
> +	}
> +
>  	qcom_pcie_icc_opp_update(pcie);
>  
>  	if (pcie->mhi)
> @@ -1624,6 +1675,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_host_deinit:
> +	dw_pcie_host_deinit(pp);
>  err_phy_exit:
>  	phy_exit(pcie->phy);
>  err_pm_runtime_put:
> 
> -- 
> 2.25.1
> 
> 

