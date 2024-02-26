Return-Path: <linux-pci+bounces-4026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C9867C11
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613731F2E8AE
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15F12D75E;
	Mon, 26 Feb 2024 16:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LomV6Oc+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A0E12C814;
	Mon, 26 Feb 2024 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708964686; cv=fail; b=OSrn+uSlGyK73Ytt2NZGQZgbYg05eyXiYklz47gUm8pCJwGTwYH/IS2HESFuS5Rb+xMwmePKOdmeWbXhGrDglDEUjP6BNsZX0811L0/42G1cInCIV2BsnNS5erABNb78zuRYgXxE3Trms1z1DcyL3KM3aEx9/imsDfCAdgBJZgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708964686; c=relaxed/simple;
	bh=SVhZXmQHJ0A6n5mHBw7I63zBrfaBOGPtz/gJKkBwJ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uNdQOCks6TraLDxSPW2gdSp3ZRH7k/HX9CgXWQ3AXirjbfOhKkgEmk3ilR5EM3JxXqntd19CQ/00n3L+LXgQc0Yy8zlzQa2in8Ntf+KEqHigN3e3DSXO1yshOAnkSl5CVNTAJZmygQlcMKATDQFsVFzlH2xDblpYjtzk9et83Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LomV6Oc+; arc=fail smtp.client-ip=40.107.247.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvoRxvN4pHQW7+5aIDCthd1DE9KXKA6G4caVyoX5qMT6gGfrPguQ/xGLGx6LHZ9cfocryS73aGgoerm2OGir6lTarQl37zEWvkEEOehU2meOCrbbhyh3K9FYdXMAqLfalWdgrbgmvitxZ86T1xh1RNyt1EtJa3sysxuR6ZHQLPI9h+FM+4O/VSdmh8zhKhfUBtn2KnzB13nTI6Ai0zjjxUtGiSiMQ0fSizvdakbvXhVfmhGV4iRl37un+fWoSIV97lwkb5c7u//ZZKVoQyKaPlu4Bp+dsDrqc9HGTzBYDMv9OR9ndumNJNnz/FjL6oshgR/N+aMpgk6GHMtuHppgYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVmpDvJZetSr2KLfB9OMWey29guyLBOI/SueWA0eRB0=;
 b=WXtiD4iUA25ySV8pUof14HZ+isCHVG7ExvBfhmFVZOeZ84gOvWzmx0yumr81LZM1+9d2Zh/+3wVi9HZ7nQhgMHVRdwJgTYpFwaZIfTx0atW+RqgmKCRQULJEbsX81yPf6zuRPkZRnaSVzSzK+iWDfTxS2ZncBg27VkxFyMYmgP4EgHIXpMxNFoJ+ODRgKr58IMECR2/YpEUpuNRRuFoxdyXgO+CwCcv9DsxTK0BVnaTce4hEfA21M4KHJDTdDYV3lCv4VObpfQ2jsYZxEirpvR0HliK7SnkUm/u6V0Sdd+m4YFg5oV4kC48iEa2SVDxBkPidOHrwnh3t7Fq8ltlgKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVmpDvJZetSr2KLfB9OMWey29guyLBOI/SueWA0eRB0=;
 b=LomV6Oc+bc5amA3XqiJ2zTXSIFvvvSXV2L6xrCBuwfVGUUS86Nk3D3A8SjUQElkyq01AO1pFUHDcFJ+HrB9ezRfjCSdhMGdo4RffvqCbB5Ouci7Gj2x8jv4wkhyIu5pdEmomod7vVA7BcJjytOcAJ9FowOhFl9zJEkPf6myYC70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9866.eurprd04.prod.outlook.com (2603:10a6:10:4ef::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 16:24:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.032; Mon, 26 Feb 2024
 16:24:41 +0000
Date: Mon, 26 Feb 2024 11:24:31 -0500
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
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v3 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <Zdy7PxDO7d8YIKG2@lizhi-Precision-Tower-5810>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-1-cfcb8171fc24@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-1-cfcb8171fc24@linaro.org>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9866:EE_
X-MS-Office365-Filtering-Correlation-Id: d5661e94-98c7-4ba0-0b1a-08dc36e76f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DoUNNKXKmI0KKvm8rCQBI711A+WK3FYYj8KWxwojTOjg/JXbcIWqaOLuPB5ouzzvPVe+uv5yNQhDi3XvWDcHuQdF3JlBgKUT2MHLo9iAw0JrKKz6mfhdC/hhbjVi6FIkF5uiat7SXvUDLgX34HnX84x8esZCbayZpctY9bYaIeu54gpoX+KMrEZdemzdFioewuof5d43Zj6g3IOSiQdoH4qVSHfUWWEyjt0Lc9XdXR+PpHKa9ex13sBN1kONg2czG2gWQ+n4+hJCvOaXPs+tOldClXtzKCcFwjIwl7ceKbuCiylzG+l1KQjdPiundwGmn1nkrGwx41IpqcNYUFAWDAScvb2eHK3v149iGYj2jMah0Wt/v+KFYLulP+C9QLMiYdkUhp7Hz8WwMsIec3I2Pja7weAX9hNlM/XNI2pXQqJ657QObsV+fjiOZrRkbVZ5N4PEvfOifeRGVSs7vdidr5PD9OAYibiQrJs0GsF68Ejg6Cy0rxhoAge5+tVFXNlyKy88aHaWlIBfuzr37Rs1zfeQNIyf0agoR3WjQD+DGAgVh2aJtwmhmkWF9AoLGoL2xicnp2zdzRgLmUxDVdnRrUS6UQtX/RwwWvep5MYQbNkJbBLzqbGtyvC02AD1HM/0lLAES1rJdewkO9aVrMs5sZnRIqEaABJ7p+JVWfLlorrM2LYHhz+AG72aSRajn4jKuupNdkeqDlqJm8N0ePKBSMuL3Q2l16klDZZASVcKaYI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qinck6f5h/1eJeDar/X32IMyzHgib+2FYBd85rQaQNW0olUVstVh5XmYg6ym?=
 =?us-ascii?Q?xet0TMU0ep/d281sPJLQv1BQIywJCJMtjWUVB1Fskpl2H03lDilJghGQcDso?=
 =?us-ascii?Q?orvrB8dNKoR8rsf9s3/xHIAjFYCETloDi2/CsizY05EMBcVq2Mq20G+h31G8?=
 =?us-ascii?Q?GGKsONYnqveuGimxaS/QrusP8d20oGPjb5W+YPEqIHw0BCtVHRkvawCIdOxY?=
 =?us-ascii?Q?1C6T+oVRxqQcYjHawqv1HIBE98U03F75y/jIReTutLl62n1xeui3hla78G5/?=
 =?us-ascii?Q?KxrDQZ8SdHpPgVG3WKGor1yaA3+C91hAzw02Ia2rUZDekKGiPeXY+ZJeBHr6?=
 =?us-ascii?Q?/TjYOFGmSrWvigTXqjkkGOc8DF0dy4w5YdUkEY14OS2gQSISv/hP2rYy0nYN?=
 =?us-ascii?Q?1VS+a0r3Ovmcgvx+l59hb3jAJDruyS2SWaajP+1PNvcAZZrXiq9iLuK9fPui?=
 =?us-ascii?Q?89kqIxMa6NuFlBJFpHNnzFykPzY++BI0WhbqLZduTZtyuJ5E3zwBi6OfQpvo?=
 =?us-ascii?Q?6V4+EgIjdBc+R3hM9kUi7FMcpZxqgrgkkwMbs48OJO4TmIXJ193zNEEdaQk+?=
 =?us-ascii?Q?pcf1hYc7XL98q3AVgTSPq8IoJjZwcEaRTZjfI7DlQwuYmWae/nB4tunaWDrg?=
 =?us-ascii?Q?FB86r/h9uoegt/jVtVs/FWAWpwVfracs2fLa3IdL2dinMdzMXvzJOrH2J1KC?=
 =?us-ascii?Q?mKSH4nfj1zsQblDQYeLzesWngVCR0piBMcOvr6WMyiKA4ReqIv/ipSU8N6gm?=
 =?us-ascii?Q?180ESLBLOlFEekWPnycSjpGK3dK6HLzUJSy88tRMcLd2UPpycAmUVoNhAbZ5?=
 =?us-ascii?Q?bznH4VoeRwTr7BnXI+gZ9ku9Vx5RqP7uW2TNcYI6WuYkMwDJx+lRcd81S1QM?=
 =?us-ascii?Q?/hZcIx2vr6EkLXFvEYiO2wv+JRR4m0QVVlxdNr6aWC6LktI5yg/bBQpqcGkm?=
 =?us-ascii?Q?AOafnUj4proPKsQ6x24n+AR/RAFkuZswdk64UNkNX94Qxs4TpfvDsxREV2ar?=
 =?us-ascii?Q?6WnX/p0qbR9bpCz0z2YKnNdKTcW30Y/18IQghByG4JjnMfWJphvpXSZegAn1?=
 =?us-ascii?Q?QYphz596uZuVbTj3cuP+HIGc4mRRM2+eEhyP7LYYayLEeLBR2Hy8SD/kVPgY?=
 =?us-ascii?Q?om+z3s+LAqMXEhE6CzQgS3ACZEOr9IOgim5sSFtJUguDyFsDRIlv7DSMHg65?=
 =?us-ascii?Q?Er3IjbyCz7nu7jSe8rJTiVB6cF+kclq4fnAmByq3OqJO+Luf0NuJJifAETny?=
 =?us-ascii?Q?4efBaHu5r9nSJsW+8PqsvEweQUvg9/cVO6o4lenvdbKuOBW/aWuBqPHiA/z2?=
 =?us-ascii?Q?i2LhC8k4+6VieHQAvBuYZ8aQil4Kf5tShZ4RhkTCjBNUjdKnwciXvKfl8RBI?=
 =?us-ascii?Q?66TcBL2/2QyCza4ueTnPcOUGp+esz2bzcMyzn/5ibsBze8u15jSA4KXHvuPR?=
 =?us-ascii?Q?mo3qaPDHZXeoNd0/5cV1qKCB7oXADhQZ9iN0bmBTFPpReubkgv1QaqeU4pqF?=
 =?us-ascii?Q?KoVL8cdnU8sCKUP7OJI/6LXvvbpw3AVUGmz1qLwjtMZdKJuIfRx37O5bQH9t?=
 =?us-ascii?Q?3qNrHazTdZbKfiAlJdv/Mj+944U8oT9Tufb961s6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5661e94-98c7-4ba0-0b1a-08dc36e76f4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:24:41.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UKRAIeI++ncYlDtYxm/4Iz7qR8R8VbmQQM111sk6XzX7VA0+W+cHsRVLeeOLYQdajpGVp9W3fPc8gbyPHSTnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9866

On Mon, Feb 26, 2024 at 05:07:26PM +0530, Manivannan Sadhasivam wrote:
> In order to add support for Hyper DMA (HDMA), let's refactor the existing
> dw_pcie_edma_find_chip() API by moving the common code to separate
> functions.
> 
> No functional change.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 52 +++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..193fcd86cf93 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> +{
> +	pci->edma.dev = pci->dev;
> +
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +}
> +
> +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> @@ -900,24 +910,27 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
>  
> -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> -		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> -	} else if (val != 0xFFFFFFFF) {
> -		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> +	/* Set default mapping format here and update it below if needed */
> +	pci->edma.mf = EDMA_MF_EDMA_LEGACY;
>  
> +	if (val == 0xFFFFFFFF && pci->edma.reg_base)
> +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> +	else if (val != 0xFFFFFFFF)
>  		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> -	} else {
> +	else
>  		return -ENODEV;
> -	}
>  
> -	pci->edma.dev = pci->dev;
> +	return 0;
> +}
>  
> -	if (!pci->edma.ops)
> -		pci->edma.ops = &dw_pcie_edma_ops;
> +static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> +{
> +	u32 val;
>  
> -	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> +	else
> +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  
>  	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
>  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> @@ -930,6 +943,19 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +{
> +	int ret;
> +
> +	dw_pcie_edma_init_data(pci);
> +
> +	ret = dw_pcie_edma_find_mf(pci);
> +	if (ret)
> +		return ret;
> +
> +	return dw_pcie_edma_find_channels(pci);
> +}
> +
>  static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  {
>  	struct platform_device *pdev = to_platform_device(pci->dev);
> 
> -- 
> 2.25.1
> 

