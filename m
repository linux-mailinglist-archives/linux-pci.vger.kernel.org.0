Return-Path: <linux-pci+bounces-14805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009CE9A2733
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B00B2AE27
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D91DEFD3;
	Thu, 17 Oct 2024 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i20hkSLu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E71DEFD2
	for <linux-pci@vger.kernel.org>; Thu, 17 Oct 2024 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179426; cv=fail; b=WgkbczYGiF7p3VA68qid4CjR3HFPeFN0T/OR5MUFW8u6vyGES8QxoOrLQCpuifMsgqey77JWTvoYdP96qQhb608VDuBwxuFEgfRss357BbZ1PQNNWljQrf9PlYsd0VLul06+q7t0LPQHPAHrROFuACjwwCiwcvHxq+x+75J9n3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179426; c=relaxed/simple;
	bh=j1uHQrSGC3YIDuGe2q4zqmOAMG9+EQ194CNwgvvhkYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m+67NEjYI8WyRtbhYta8OCtDuZ+B3G39aA2jdN6Qbe84ljG+K7s480oIVKkSFdh+oOk458sMGuSy2TzD6wYsyGfEzS8/c6vv3bq2sw18VpFYQaJnuwsbYNbNxzIzkGBmmnOjNvkr7ONTpopTLE9WY9foeWWCSGOJamzQHqTf7Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i20hkSLu; arc=fail smtp.client-ip=40.107.21.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOT4pMN9ETUSp857fPNTyjoRuVsyyEceKJv+4uhT95vT4bjg8E3WINgeTenK2vjhlPp7CSIqlIza8S8Uf7KiEys3zLB8nMrc+lPBeJec90uXBUM+byf0eYmwnUpf0yRpsQuxqC3nCKNxdiMlUSdqEVrIbzxJxFe8Us63lm5/CGJwwi8ERmSOf0TAexEqPH0+vazmrcno0gMZxlQiLkBq0jSHEHlPc/iXOnRHCFVNvWHFkflxLu9MdQ2BtvpPw99daYOlXjCDCC03iok9/3TVuaV19JjOQbklofY7GW7LHu03ajJygh1aQSWQQL+Kcuh/uUpKMJc+q+P6b1liWDPwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKyTWsPnD5UAK/3qjOtNnBE7CC6k6HmXNcSw8PGzZHM=;
 b=H1fTlTYcy+i0OOQ3CVbcu91VLvktJg+b6t/QNOdLYwNQft1WcfFSyPOiP6D2qD0NwUNk1x0mejWrSoiGLzV773XrjQIFDpYQ9dfAjk36duw1TO9Wp9iCluaFmMgEFVA0whTjo2n9gXN1R5wv2D/jdRD8bUpnoR68Iry+9nKly+OvzKCYwvHMnMHvnakvGYF2V4ULW5jcgUj5yn2Z02p+W0+gFHAyOvqrsOX44lyUNPsDs9BJI29u+zRpu1oUWYhBGY54xbOX35t5WpeXqXvNuVIM3FfFAZRPLGbdujKcKCCqqui7Uc/28kCUR3hwt1Ftb1Vxxyt2ZEeKZLInpo/ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKyTWsPnD5UAK/3qjOtNnBE7CC6k6HmXNcSw8PGzZHM=;
 b=i20hkSLu2WVNBcSIYDxj/SezcTwFYyVbe/32njuM6JlaFGakzvvfDg5zc5SBi3jYpby8ofuqSwzO6c0D+Vs/Qwu8TQ+vZz0i5DQ6sCvHw3SHmfLGn/vgC7ewG0mt8o36EXHHP9RFdZJqdoTinT7LUjkiIZfnIfVcw15dTxsui0whWLl1wufwOe0YWbqh7q87DbO4STipT1C01qAZVbdrWvDBjcG+xREQure+O2EpnrEvgWlFe/SkcMRPivJ6hm/7wxQBZq3GycaGY2bCa5TZjm5lW0VNludQqdPhxdW2PhyAp0YAK/TAcxrg3j/gid0oFnukc/dIlAKeYQspJ7KEoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7746.eurprd04.prod.outlook.com (2603:10a6:20b:235::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 15:37:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 15:37:01 +0000
Date: Thu, 17 Oct 2024 11:36:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <ZxEvFT4+X35/NxWn@lizhi-Precision-Tower-5810>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-6-cassel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017132052.4014605-6-cassel@kernel.org>
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7746:EE_
X-MS-Office365-Filtering-Correlation-Id: c5cfa860-2187-40d6-81bc-08dceec18b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IDrrFY/nhUhIR2BB/rVd8UobpxGaydZbxF9oUlguZaQjRLsWzm1AVOWjHgnM?=
 =?us-ascii?Q?mtoPxfajb3o2DD7wK2FGWmRlL6iAR+TQ47Ak6ESMEt7IDhAJzxswpEi04LfP?=
 =?us-ascii?Q?joVxCU+C+owV7SgydRX5Y5cWDe3BCbsMPI0eG+MLVki65Pr509yTJ372gkDR?=
 =?us-ascii?Q?3+65dVdsRcHhjc1vazp4iVQwla7IwRi1lXzHGrGZjYn4X/XLEvdR6vG0Rhsf?=
 =?us-ascii?Q?/vOvz6I2rsNgSG4iX3CFX/A6DhR/D9NU4LELmbxJxm7ZnylXdLXytB5tTkBQ?=
 =?us-ascii?Q?uq7pd6eIgsS9UY+FAJDChLlN30bw9TWW7p2QZZo5m3ucbXo+0FejM/RA6nu8?=
 =?us-ascii?Q?clqIFKSkC9Yi5bpCsU16MUEytdwOzxhU7ZAapRUTLHveOZh3AQvEqppTU8jc?=
 =?us-ascii?Q?dYtGEQL24wg1yXNptxiQE956WAJaCm/F1ojUTfRdtTvlhZzypPDUQuU4kiEE?=
 =?us-ascii?Q?dDGSHIdX5NHsr8Zr8ryFe+EeCWsF38a7zC8djRpEDNZik86saSvummdMQ7J1?=
 =?us-ascii?Q?6vAeSkmF4XFyNKEm3LNtgZF0/t07Jpl40HNZItmhbOFBJZPHu++guJ1V7cTf?=
 =?us-ascii?Q?qoBLnWl+8MbFmi5KgB9E4WQPuUrC/zON6YTLRA6ICOAS6mw7W9N4q/NYJQGI?=
 =?us-ascii?Q?i2D8+6pPFbvJlb2v0ybXd1zx+Iud6LIC1AYyMLZBRTdu21F8PyH7VHE/OmOV?=
 =?us-ascii?Q?CVH8WR7xgHo2wma8EPh9dIELkrrYULww4xetLZjaKULT+yLFJypIVg9N8d4N?=
 =?us-ascii?Q?rWDpQdWIRkp+sI+AH/QIEAMfEroghEc+wYeWoMgfR6T7aTTGpIqqsHuzc/8Q?=
 =?us-ascii?Q?QjzKFUWes6KYNneYRsWD4v+vaYUus4y8WDGuSFrq1/1jrKKVyoB0dnpDX87c?=
 =?us-ascii?Q?gwD5kWYPgnPgFoBwkcODfRfZL9rYEXzFp3HZe2LuWZUT5qh4ft8hl2GzbIfK?=
 =?us-ascii?Q?rh+zFeGpdM5CPbtMG/B/9K168yYB1Drnd811pINY7W/kjUzjZ6N93bSpoud9?=
 =?us-ascii?Q?PLrgu8mA4rHSqUqwNx50s1LiHrHPjpdRYFEkzARTaCjn63di95EiZDzBKYvP?=
 =?us-ascii?Q?g8EHE6+T1YW56WmaHIHgUZQ83aBouSklZMxw1ln/DddSirEKfKAHGtvQDj/1?=
 =?us-ascii?Q?UBqJg+Bhg+dwGyX3A5iPEKQf76eVmvwccBA1LqRRJblyxZse73sEdeJHUDC6?=
 =?us-ascii?Q?jbpU1pMskezwUVV46aqknLkBVwZDuYlGR+Db9hoevQbNlnl+G3ZHpZKlZlka?=
 =?us-ascii?Q?DuUASQjpwg7e2H1LvWWKZ3Cl17a3Q9LoES69WFmJgySk8PQ/ZniOhhU9FQdh?=
 =?us-ascii?Q?SkewuHa9AByrNZ/xJ06rNMq7yGbj38F4z3B0sN2VMM4wrwtx3RuUniogsEj6?=
 =?us-ascii?Q?XqGlBZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4wYYZWFhJU0kyI6VPF48hCjIIMAP/+PzS1FPY2qgEFEzwLXP+vuxykXffm/?=
 =?us-ascii?Q?5oO+yWPbZrHzliparzu+vPPgqtCpQpRf9Iu2xcHNgzoAItrfkvkKdI4vlOvW?=
 =?us-ascii?Q?0s6GBRpYUP3dZRRs17tVtsA5olegB9FfPP8iOnqnwOZ5U6SP4j2z+1gWsGjl?=
 =?us-ascii?Q?HoZ7ecYy3vg80D1RTRKs9ZYIbrry0spSnZ5fL/yM9vwBg8VNsQ3cGQHkU7jY?=
 =?us-ascii?Q?ZZNYa1s6WrqTjDNd40YFvBC2YOXzNMt9Vn507ICTPcyC5XXvAKlWRiUe7gUU?=
 =?us-ascii?Q?/aVWTgikLRb8+0v9foKPFJiyEkU7ueDTfb4xmCRPz42HtSGmKfb5sO/O6Z51?=
 =?us-ascii?Q?NRxLZk+4n0J65VDhPAhQjt99IyV7isjsr01QNmxQP53L2vIEC1ivEMpUCOq0?=
 =?us-ascii?Q?NBvXdch/WI+6rSVXT9rPYYxFbxYDTpYwUZ7DU/19UrJRVvWPOQrMWMaBAyFx?=
 =?us-ascii?Q?mSD0mEE7Ijy9G7rPsqyGAov36frmA0x2clryAZrTtAiZ1yniLbZBn5kzdz7r?=
 =?us-ascii?Q?rPL1UbXm1rvwH2ui9CPKZWSEwT6+d1rIf/1aAwUN/OHzsgkhgNs5o38AtXoo?=
 =?us-ascii?Q?iX6B8JercZSS3oIkhWYwugsZsQbwzmTwD3uWapRa0gELbBF2debdvCTFq6Dm?=
 =?us-ascii?Q?NCLqMnW230QLSFGDChOJgfqVFZmKvujdJqAxPGiMeRHOHKOJlJukshFN7YyN?=
 =?us-ascii?Q?T1ICa3pP8CXxa6vQJb6NJ572tIw7oJpebhEYKaZNd8gncsSWod6G/X/PtlWa?=
 =?us-ascii?Q?lXvwyssVyf7uq0H4L4J8y3/lCpSdqsH29oIdkvc2JdySco2A//3MDqQG1IsS?=
 =?us-ascii?Q?/MkAOHbgtTDfCwZdg29VQ9pgHB7fuSeoxh1GSX1faWjEcHSMui0RFQVAM10N?=
 =?us-ascii?Q?AoHEo4tYMTOVP//W6goy1VuuBbHQn4MIWg7axUSqxkFibgXjeSRSkvmRjeHS?=
 =?us-ascii?Q?v3a8rC2WmVR0aJt4eSVnb6EXJItof/YPapkgNN7yZZHJIO7JD8ue/f4uKbYz?=
 =?us-ascii?Q?Wesyq1fedFzxMjTUJ37XXPUYzT9jrQVJhY2EW7F7yuCMJ9K7eRhTg7P26rgy?=
 =?us-ascii?Q?19LyCTrjCWcfRnM3+CGoE4uwfVBbNEUgqVdzbMBgYgppaS3XYrIUuXCyQjg6?=
 =?us-ascii?Q?dt2wvfNDbMgmopeMLH37ZWE/O/ZMQQhZIG28iEr9dSVVstwaXxsMr+9HNHVI?=
 =?us-ascii?Q?DzYuZoxKSX9c8Gap+/PzQOGbZsNw7i9zCVYfS9jul+YDvAkK1r8NgxzjYHd0?=
 =?us-ascii?Q?qRhvwHVWrJA4PzD4I/5fehcsC8w1ha2FZmvxk2Qr6Ze+g6YesUOjAl+Sx4Za?=
 =?us-ascii?Q?JWi/3xguFiCIzI3BzL6ZSxz9g1G8pl2BDrvmNDNB+hYKtlHKOe1kq/uqB1fz?=
 =?us-ascii?Q?8C1nV1/EBgXSPCpV9zfzQdhCKs8v/hx05Ghx6GiG+nnOO3iBS7rvn1ZsehKm?=
 =?us-ascii?Q?LfxSaacvNklUlaX3i2d+bgoZkiYgSjbZ6YPhQ3gNJ56Pp4EaIGvubJ+Mt/dr?=
 =?us-ascii?Q?eP/mIBFJXvqXMNfgakURuZ2fK3tGQIQ7wMnCmX84XwpdR3KQW/nzuQzCJzxE?=
 =?us-ascii?Q?ep/Qo6uKIjZoU/mdDogiKm1BfenA4v3ddAXNoWuu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cfa860-2187-40d6-81bc-08dceec18b33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 15:37:01.2267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PBB4m0iHs2SU5vip3LK03ZoPkJaLA8BptWuulSkyQ9sY942Ku3+SoMZqtSZkm4ezK8ml8IN+jBpwffgzxOppQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7746

On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
> Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 20f67fd85e83..9bafa62bed1d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 msg_addr_lower, msg_addr_upper, reg;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int aligned_offset;
> +	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t offset;
>  	u16 msg_ctrl, msg_data;
>  	bool has_upper;
>  	u64 msg_addr;
> @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->window.page_size);
> +				  msi_mem_size);
>  	if (ret)
>  		return ret;
>
> -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
>
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>
> @@ -589,8 +589,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct pci_epf_msix_tbl *msix_tbl;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> +	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t offset;
>  	u32 reg, msg_data, vec_ctrl;
> -	unsigned int aligned_offset;

why not direct use 'aligned_offset' ? just change  to size_t.

>  	u32 tbl_offset;
>  	u64 msg_addr;
>  	int ret;
> @@ -615,14 +616,13 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EPERM;
>  	}
>
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
>  		return ret;
>
> -	writel(msg_data, ep->msi_mem + aligned_offset);
> +	writel(msg_data, ep->msi_mem + offset);
>
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>
> --
> 2.47.0
>

