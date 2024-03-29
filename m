Return-Path: <linux-pci+bounces-5418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B81892142
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 17:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EA7B22893
	for <lists+linux-pci@lfdr.de>; Fri, 29 Mar 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572CC17E;
	Fri, 29 Mar 2024 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvRp5GOV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2096.outbound.protection.outlook.com [40.107.247.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CCC1C06
	for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726351; cv=fail; b=upwiU9f1paFCpE4MEX+ZaeXkjnka+60yLEbwPydDGiXdAvRSQY2LhB7WrCLdrOFZIiuXxwrQ2bud6s6VXQ8OF2HgN3dbGmsCTzHcLn1hACMktaKK6SJ+zjK9eAvBAX5uluW8m2R7nMWlmWH48xzZFz4CTAr5rFlxoZxLSd9LXcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726351; c=relaxed/simple;
	bh=413JPsvDQ8tcEhZobtBsxeai+CirJpjJfvcz9lblyD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NpnibQBTG2B3cqB47L2Yx53y0qILU+utXY/jfjAAousoWb5HEM3Qb27sUfXwC0vWkoysskN5PvVU0awSnmu0+YDHadNXk+tFRTKjOwG/WlGyt18uSbFZpyAsCIIQbJ5EbdEgUNWsVmeeKuIP49577lpTzr+yQ1bA0Ef0P3rkj3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hvRp5GOV; arc=fail smtp.client-ip=40.107.247.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWsleGnvekRYSkSKS+W9f+KF+QosANamQXcm9Q09ixzAv1YwLvaQLYeGOeT2qt6MwY0Wcyl+5r8V5hTu+WAq2qp/cjMl+DCIrpASyNXK+8q8S7NtzkPeLb2IiGtRv8nar5s7C6Ndjp0VxCOpAbXDr2ReZcM21CeM8EVxIjsnot2ZxPjZ8SuANOl6r6PTjOErhn6uY5PE/zSUU/IEH5og7I4h2DbUNV35o6VNWyI21i3m5XiSgucQ2trHNyADX/UNGy5xHmnMnCBNITBb8/Y9jPfuW++KFa8aOyBfaEt95dWLrde6d8y/AplPxB3k9hh9tzG9xlhOnLVm2o/b0Kb0Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbdHFxCuVWgEmELCsEQd05dRdmXC9QCElIKsJTTlaeQ=;
 b=lEu6w2JdmZErZMbatXkNx7/Snhr6i+bQh/zIvsaUXr85fHM7nz2pl5i1AUlOgWE+fwQYbgMbhdUT1rqZtELpSDl3vxK586RbBWnb9mog0qoE/x6ZVq+RJ8EE60KSiKlHE6s0ShzpOv5qvaYWDmeayHcAcUagLsV9gaNdErYGfDDVG27qivztyvkXds68UpcVUZXjDry4JpDN6+ap6W4iTO8Z1oFq4zTBDKA1UrvxHlbRXyCC0aJ2EAXQx+vv0pA2+DWWXOyz69W8B+4EsjUKVR3SklKpgWBOCg7afd8AkgVI4zUQH7JXcjnsqbMB9rUZjj6aKWFIT6wlg+kZ2tGJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbdHFxCuVWgEmELCsEQd05dRdmXC9QCElIKsJTTlaeQ=;
 b=hvRp5GOVqOC4LQCE2CmMyiwfIv5XlEqmcz5gIzLKmoJLS1/gfj+mHSFW6rsEbj54AkGNytUeNTUQz6rs86DYk8neo6N04ojZ2elrJoiixfyRXyuiFGOUrQcLaMnY6YfB9Dd76hjNCWxSudvfpxPYNt6RhTOCfsazAoJPT8BN//I=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10309.eurprd04.prod.outlook.com (2603:10a6:102:41f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 15:32:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:32:26 +0000
Date: Fri, 29 Mar 2024 11:32:19 -0400
From: Frank Li <Frank.li@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 02/19] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Message-ID: <ZgbfA2BcVSsDX8t4@lizhi-Precision-Tower-5810>
References: <20240329090945.1097609-1-dlemoal@kernel.org>
 <20240329090945.1097609-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329090945.1097609-3-dlemoal@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10309:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aAIwvoQ+/MhiuwlqW5Lg/c4f82uawEATeIeCjD7VgG3ri2gPoqXeZNZNactkcLj0jhf+hlJ6b+UTyoZVbnSpcKtR8gscAjalsSvuCc9KDrqjkXfjJaxHRxm6jYKJjn9xGFll9PPExWLTz+df0A7yfZukEEuHfS1DbN1eEcVibzJo1o8XgCJ3IC+0jlfbl0zZBXYH8hhgHVdaUALJLhIcD2qdF7Y0z/OlnvPqciAP4nIySf4BTH/mAcwXk4SYvbxdPRg3SSjrVbYWG6qgWSaZ/PpYb3GA7UJJLuogGbzLT4i85aI++3P7R+dXVkbzDhRZPR4DtezCEeMPjTqtQDtCtcU/iOHbpLOXs57RdAA1NgDzKDnmJL1KHf5n4szSdIbeozdb2Jv2G1n4tUHgw81pA5tL5FXcaqgNcVKEPowCMhO5y9trnkvwBJOJ/j/z7M9N6ynM6qHaiVNzYTYmUi6l1nD+WF6AstHX75vzPrPV8InJhNCXFeYhib362tdCef+2yVllL8ZuovQv0L8VVYeJxTDH8pNF7Nh6mrswV87flBv1Wg8l+UOhxY8BDAKIe6c9g7IxWM4CJTNmIGbDXLUz+O1xqMksxIEQHIgpXEvOGJgmN1l1SRxu/CB7u/vyJbc5u3Lh5URpH44VwYjgNnwtsZH8DbosFd04CjBWdYnVDmE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mv70sQa/LwtYFt73rX6RT2st+s2+/ClOOO/Fm+LCbX+OTG+Cos/afCx+SamA?=
 =?us-ascii?Q?T0fQbdRhO5s2Xq8DE7befEsqzYcaFBsybcvQG8Wq6yGp8LxuVNihx4J9+uHn?=
 =?us-ascii?Q?i7n/bPOdgOSqbYFJpzf4zDrMW2rdqbDNEMwaQ98t+mZf6gW+iZT8uEifKNwm?=
 =?us-ascii?Q?yrK7RuJpdpbNfL/QHZZRuxWQrrk8H/121z3f2SqHbDDtGqzOth0t1O8TVkdR?=
 =?us-ascii?Q?pb6p3RWFX76tjiSmS1wRCbx8YsVVFRXip6j2EkZP7fPDrluNcDxBbRRow2cL?=
 =?us-ascii?Q?UZhS5otEsvWJ7Tq+uMYPMazAjJ5AHIHKr3d6kgMHhyJUDVgUfLF2pOSjX4kM?=
 =?us-ascii?Q?2vpEFT2koKuIsCtc2BcEZ/uVV80TKN7/AWytEeA8LeyZqKylB/WAMD7p799J?=
 =?us-ascii?Q?0WNiipDovqrYUq/Hb48Kis8ioLIb65BsXXbwngJLWEJJgx0JzK9jdAmVqusE?=
 =?us-ascii?Q?LnPNJ8KGzdbWHVUSg/4CRTLhwS8pfLInONiu+bTAIKOkhOi4Nrrehlt6ItrS?=
 =?us-ascii?Q?g4kPounOBWLxIveKNzSh91Ic6BEsEnqq56vwZ9g7jyx0hwRgvFhbOwRbE5iZ?=
 =?us-ascii?Q?SftuKLWEWYeeJEUD298cIKw6cP1VBUyuf/usbzdAOQrrifmr5O+ZU1xu3RW5?=
 =?us-ascii?Q?1mkQHcD9v+eR2BMG/gkitwBnwPiOur7iogsCssCMf1/Vh0NLRXkAcjFBwGxB?=
 =?us-ascii?Q?eeR8A5Det80MilZTsogVnur5ZbsA2KfFyT9faiggPoBQeFetcrP3jiXE38EJ?=
 =?us-ascii?Q?R4w5ZjWj1W0UeemO4QqX7O312jQvOaVpNfcFFa5wq1za0xbqglbsNjvd3Yug?=
 =?us-ascii?Q?kadnr9WJDwxrC8LheQeJIX+3fFeplEmhFkPHwUrP9xl0acV8rTnRbCSV7Qop?=
 =?us-ascii?Q?onZbUyyzQQAK5RHkHv1ykm3Teh7V8COYzTmDq8qW3R4zL9NtomS4lIZN6mcd?=
 =?us-ascii?Q?4iOfHeHfz9yxv7YU1mr2dj6LwJI7mJ5wKLAtZaF100OkN2IJ9XAKQNTtihh/?=
 =?us-ascii?Q?KzbmvJBqU6DH9vn/+jHV1d1FCk0U9Hsxb9mh6lxtdACTjUKI8XC3F1BuVx44?=
 =?us-ascii?Q?BIyymrX3cWJEGderNHVpgGa3U+kEPNOma8hQGTPpzw8qyY+bRoO0i/O/jt+r?=
 =?us-ascii?Q?mLM+OT1SuRZRluZVq31gFu8B/uKohgB8Mk4is0Rhpf96Bige+edIlGT9SjIQ?=
 =?us-ascii?Q?d1/RrJjBdqdKLn0ZiuCszjC5dOaJad0H/C9V4sKw4qwxof+gjnd7x45lJj+3?=
 =?us-ascii?Q?5DTl070VLe/mZ4g14ggngJLhAe0/L8/wITPc9zdDoXulb7WRGVtx2eRY2C2t?=
 =?us-ascii?Q?+Tl0inKKyB8mTZY6UTiF338wvgimntYd+1cIio9KpfdHbBbctSVnz2MiAT2s?=
 =?us-ascii?Q?Aa00Ncm4C1nSNBEAVZy0LXcSQzM8LHQXm5O1kQQ5SlFcSo28y96oBwkQy7yl?=
 =?us-ascii?Q?xhX9TjGgMiEaOGrPUOUcjnlKh7mkXH65xjrrml+Nu2wMLn8CwBl/SknIo9Rw?=
 =?us-ascii?Q?l0Ygn1h4DQa8g5jgb+WezSdaqkFszeV33b/1/1BMHDvXv7TgqZUpw58i6LXF?=
 =?us-ascii?Q?e3GeZiuAz67OSr88NirVY5SxNQc6qtWpFJfUzjJT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f50867-7957-447b-96e8-08dc50056fe4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:32:26.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kezIL4mGQY6KRGXFhUS3k7INs5yasp9fOmihQ4fsAiME3hdQBf6IpI6K+0sOeZ7pCk2FrPDhg+FmMbcfyXrebA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10309

On Fri, Mar 29, 2024 at 06:09:28PM +0900, Damien Le Moal wrote:
> There is no point in attempting to allocate memory from an endpoint
> controller memory window if the requested size is larger than the window
> size. Add a check to skip bitmap_find_free_region() calls for such case.
> Also change the final return to return NULL to simplify the code.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a9c028f58da1..218a60e945db 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -178,7 +178,7 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)

Mani is working to change alloc to genalloc:

https://lore.kernel.org/linux-pci/20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org/

Could you please wait it?

Frank

>  {
> -	void __iomem *virt_addr = NULL;
> +	void __iomem *virt_addr;
>  	struct pci_epc_mem *mem;
>  	unsigned int page_shift;
>  	size_t align_size;
> @@ -188,10 +188,13 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  
>  	for (i = 0; i < epc->num_windows; i++) {
>  		mem = epc->windows[i];
> -		mutex_lock(&mem->lock);
> +		if (size > mem->window.size)
> +			continue;
> +
>  		align_size = ALIGN(size, mem->window.page_size);
>  		order = pci_epc_mem_get_order(mem, align_size);
>  
> +		mutex_lock(&mem->lock);
>  		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
>  						 order);
>  		if (pageno >= 0) {
> @@ -211,7 +214,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  		mutex_unlock(&mem->lock);
>  	}
>  
> -	return virt_addr;
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> -- 
> 2.44.0
> 

