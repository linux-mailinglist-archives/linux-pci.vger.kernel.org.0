Return-Path: <linux-pci+bounces-4027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66F2867BDF
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1451F24694
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C112F581;
	Mon, 26 Feb 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VXC0FV7N"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2065.outbound.protection.outlook.com [40.107.249.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BF12DDA7;
	Mon, 26 Feb 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964789; cv=fail; b=ou4exuO8Sfr8oKOxVt0zU7IwATi2xfEVjy0dQxi4G8lr525mYy/PBhWNTzEMriitOvHf86xwlobFYQlNEgnFwTLwe6EYfp0CBacaRt+oSm5GH6aRM38+ZhA8uwMDQhtDT/8h52zfcrh3GUKhZfkdcsfD4ocyjuBIiKC6ZhoPeGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964789; c=relaxed/simple;
	bh=L4SFsoAj5O9Y2YBPsQ/fKEx7qJ6pRutH1lcRuMDjVTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nb6bXHJsHUizwPNNjN6bXgIT/UV+7iBWatVItVcmMxPVo1QuiApRbcnhUt7vszM/uRAzCblYWR1ngPP2++u3Vcbz4pShNazRu7hBKYqRXr4Vld7dV8AE+jKLmeKwTRXwaA6W4TnVqT82ZRP0lC6b6+0d0DDU3AXLxxm79EFsNc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VXC0FV7N; arc=fail smtp.client-ip=40.107.249.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObyIM5jL2qSI3eAbLCfLHdV1I2juEFlU3wqRJ9EjxdcRh5JoBa5mfKO/Vs1oebCggLJk0t9/X4zk/xd/K4vrQRI2ysQPqgymJfEgI61Q+wJREHg0Y2hMt2xGbwsHMXyC6yyxzVm5PmR9sEjSKdbKpd+tKKpqb5HSF8W9SIgnOpCL3m5nEs0TNDxNaX8dyxGAEaJr1hlmOAqYImluixGuiVxFLqtKmyZVj28p2e15rqdnr5HJe4dyX+533WiyH3Il0B7htajBIss/DjjUJ2cbrzui1Dd+xJgRIO/uSSY/onsCnF1RDBb5x3A/Q38eeYXtd/hwT9GOwvUkWVrDKO6PJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuD2DDvj9OmfAUTsowfX6IchD8NlDf7zOWs2Kbvci/Q=;
 b=jx3DWlAqHmCXIFwudvg8wHB6bOFdWlcSwUBpi+d0dwH2/bHpGHRrtZ9Zu7fOq3mD3ak5xpuWwvU4OZURNtSz8ZUS31eP0WGTREFSaZrCqWQgQ14ngVyT5Z9oIpkIZKvXN+QeiDbczN6UhoR2dRYX1MCcBV3/+5LsgITVN5ZDt5eaKnEQ92t993Fjd5RqtCQ0/+7I/yTJDqliKmKJklEADvR9/LSLuQI8P+CY43dqdj7sKg89Zy69lZJOJZRkmT6j0/iXXV51gbZax4qtpMKmL9z2FGLpaHELZBunG1kHaT4siOgjlxZTeRNIs1gAlLANsjXGjuSptStUVKptqqNDiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuD2DDvj9OmfAUTsowfX6IchD8NlDf7zOWs2Kbvci/Q=;
 b=VXC0FV7NUGL+nQNqjgjjbDUPowf+5rzkbIdQxz6z78pznjmNvFJ0XtKJHIQ732Nltb+RvoW6FE/+eC0aSvqwhxs0I8vHqOkRt1FWzriPxS9hzR9Sid/UvVFUlqBAtwNqxgxmE+t2SY52o8PAaDQ2S1AYrKxDy4Dec+lfcidkLco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 16:26:25 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 16:26:25 +0000
Date: Mon, 26 Feb 2024 11:26:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <Zdy7qLRuZbtE8wqz@lizhi-Precision-Tower-5810>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
X-ClientProxiedBy: BY3PR05CA0032.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf17bf1-11fe-4a18-ac16-08dc36e7ad25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AixcRg3vGdp1C1BIA2S+bFSFe5B2bW2j8B8bhUJjzS4vPzQ2wcihZnpLrnHxd9m9s2i7ZafiNqgvAPQgZXENsotxt6N/ZX52ja9utr5NfgosNoaKyO8DjV13KHFJKmzXrsUzfZ4sH+L59hra86DrDWWd+uD5bU1Sy+l/lnGhEw03AY74MmXJddZo73rSu1Lb6LrU9+Qv2dGtrIgGlA5e23mIcOMTcJrS5G6zp8wngIrhjqxBaOeOVaC3/j1rOJHe7sqGjWG/Z8hz9ne1wL4LbtElcCv1btJDMMiB433vxKPqb/IoU0TLPzVaKppM7kL5/vqqnB/5wtRk7ZhICielPshFJpfusKc8yGYefAWWR3zXsDGPxTVsRJjtmSSkIMvAwxZWB2hg7i3yoUNRFEHfwxXukPigO+mz9EE+ncRabMXedL751ie8Ta0twvJbkgCp8KQQy+iE5VnVPE9FtUF0MEIXCxm8HCkPH6y4+4CNWUPWkUtrZuri/1j6OkLDSod35eyY7O18a2WSYFNGiRFqrS9pV6JwaXkGmDKVILNCOaW+3XNRlL/0v+xuhwTD5lb/Mo54kjrwXl0vW/RK5XPA9MVMrzBMHgYkQkv7pEVEzz7g0bZQCHZ+/lYFJJWW1yBiu6FRgJeXlpFh2lgZVV72ylfl20CSOscaVpZ9ZgAUIVf65TGiBA10uwGB9rFWvRcihTaN6UuSGF7XgY6OPD4BNFNuCIdVv8uh30ogl1I1vvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+UpaIJpI0MPTb3jl8MBIOUWOcwFZ0ZC7n81CV22HFutax0F7F1sRiirFxB+Y?=
 =?us-ascii?Q?47eA9+TKTagCu3hks6aTlSrWVubzmnAfjwK+cv1mdbQdyfEhWdUslwWdltVH?=
 =?us-ascii?Q?nrDCKXxUxIVETZLYR8XZVpBh9e+mZbOR5WD5YDlYXoOl/iJK8MOJThONFlLc?=
 =?us-ascii?Q?XDvUWsCyI1PGNpl3p71AJO3se1gdCmuAmhSvS17mjpy2cz40I602Wwa5YaL3?=
 =?us-ascii?Q?9LWYbWwnJIILtbcQvYDTRQSU1LncuvR4eRL+FJ+DPgpUjqDZj/axyIAM5paC?=
 =?us-ascii?Q?wo2kEW91EGZh/hVUekFol+rswC//cAfKapKf0/LdWc4borU6XYjLY8iAIgTp?=
 =?us-ascii?Q?lWeiOzIOw1deoXXbvsk4Kr4hKsuYVHgphxgtBp3Nc9BaQdIkjUJdULLhoF/y?=
 =?us-ascii?Q?Z7llmJidnjMbms7ECmeP022y89oGpC6GM1ZmKfDnmzlLA0euel4GbBJmke7L?=
 =?us-ascii?Q?5i/xM57UzVAUZwviGmeUukDfwCFBdCOpXIJaBI6o79wTKSh7nUoqOt0w+uj2?=
 =?us-ascii?Q?vWYUhaw948JVBZ9cSuZM7nQTDJVA3XMd5ts//PaIvRhuMsWC2SdEQhvh6hBN?=
 =?us-ascii?Q?LJk4dD2UFHYtIkGtSgZ5SdWYQQSs/XGg6w1c0wgKSzZ3r9fC3F6gwn75eGeD?=
 =?us-ascii?Q?djkXX6ggMw3ZJXD4KLlbT3TIdnWKj4kNUo+VjxoR1nBVpoBgaaTWJUhM1RpV?=
 =?us-ascii?Q?hIF5p5v2f8aydxDKcC6Vm+UgU/8/gVIIcnMSdTLL9HYCOfSOccJKIfWsRMNe?=
 =?us-ascii?Q?pZ18pyIXH5a5sE1sql4MWtSindDJn7hcHhu0FrycojveADAuI3R+vKma5DaE?=
 =?us-ascii?Q?+wbnZaBMxrT6Ot/gUOM4XjdpbLatBujG18h1/+z3xH64QdNd7OXn6XMSbBIC?=
 =?us-ascii?Q?/0BjozbsV3cmvsw3jYdGgfN8FwPvZ9xrlx3zQWwYqbKV/VjxBgNFwRVESbc2?=
 =?us-ascii?Q?QQu5jYg20c+htgsJJCfvM4xBJ+qwKRJF1u8Rr4AUMRTiSjtKuFP1r2hbsWG1?=
 =?us-ascii?Q?vgkmNgOZxkbthjWR9Vi17CH62r+J+FRMS1Jx+GUaepVOAEOo7vyvZTHVnFPp?=
 =?us-ascii?Q?wB2JNVOIdYYPEd9jaKn1ewt3HQpzUgtp990LJfQZy+5GS+LOafodQHzXh8X3?=
 =?us-ascii?Q?6Ak0pycpIvcZOOhDT/Xev6O+Ckv4HHksSess9DxvPqAu/5u7E4T5k0YPK7rr?=
 =?us-ascii?Q?sJ2pKbOubnonVt3RGbM9MNNQFqSK39sWyFtTrx5JuR2yN9/OZvllNnuauKLY?=
 =?us-ascii?Q?YcLk11M9zNkeHFnpa43igcF7Kima7sDn+iSCPKMZ5VZizk+z+aLzNxb3v9WS?=
 =?us-ascii?Q?U5b/+/rk/7OEsHeJYdyTlDvnlDk5QbsL4CcYlhnivuTifzAWuxGfN0t1AFYG?=
 =?us-ascii?Q?T+4PNdLSKOQpCAApYzINts7+bH8n2xLvvM5snlEErf66CMvfLeLW+6rSy2GT?=
 =?us-ascii?Q?yyXgG+oLIIFb6Bj0m61NvNQN9OX4sE+HOC22nKAG+vZTXm3nNwgUCa/JzM3O?=
 =?us-ascii?Q?wMDo9+0vxX88jQj+04h16dQshvVWy3cbdnU4KF8PqPeg9o5VS9Ax0eCNyzWt?=
 =?us-ascii?Q?uoNqs1QmmGREktRsdvP5LA+kU43g0dBHUTN1KWtO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf17bf1-11fe-4a18-ac16-08dc36e7ad25
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:26:25.2586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRcDbFKX3QIquHQfq89Aomtk2roTxsw/6Wa5QHzDnDs7EOubwI8mEcUQDEfaqbmum6Vb6yV3J0SFK7cFRTsOlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347

On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> the drivers can auto detect the number of read/write channels as like its
> predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> have to pass the channels count during probe.
> 
> To accommodate that, let's skip finding the channels if the channels count
> were already passed by glue drivers. If the channels count passed were
> wrong in any form, then the existing sanity check will catch it.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 193fcd86cf93..ce273c3c5421 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> -	else
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> -
> -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {
> +		if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> +			val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> +		else
> +			val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> +
> +		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> +		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +	}
>  
>  	/* Sanity check the channels count if the mapping was incorrect */
>  	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> 
> -- 
> 2.25.1
> 

