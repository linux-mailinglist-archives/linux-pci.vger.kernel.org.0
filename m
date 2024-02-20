Return-Path: <linux-pci+bounces-3761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7DB85BBA9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E091F221BC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C657D67E65;
	Tue, 20 Feb 2024 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yk/5uJXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCCD67A0F;
	Tue, 20 Feb 2024 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431425; cv=none; b=INOxaw0zDLwvdGdvKvKEPSrwrdUrD5mMWsxFSdXyGzRs2pWGkgFyCM2ALH3e130XFV5syr0g2CsbK+m2A/ZnIlqbYm+bx/WsQIVsANcVIFQH8WVQJH6p7z3M3aMEW+BqmpCX5ISeiq9NQ5cfyAe8vLMzJJ76z0vyyU7s59tEps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431425; c=relaxed/simple;
	bh=gLdMUU/DtoOkFhFk5vOIoxTOqsoaoZsnPHQ0hzOm94I=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e57Ccoqmcmdl76sIDdePcQSOr297r4ytGx8DINrFes2Sa0Tm8knAKW2o3SSUM4BnzwQ1ZaEnJ88UPFnKLZqkt64jtbbCQIWP6XTsHFuRe6xA6B3F0CHdj7MraS0xoXYDX8MCa9Il1tDV7cCV8lnf5OeNX8HFRt8fnLitzh42Tgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yk/5uJXi; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KCGlLa107974;
	Tue, 20 Feb 2024 06:16:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708431407;
	bh=f49BhYgJyLuE/o45+NLSNDNwUWoJs76kpw5ZamvBdI8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yk/5uJXixC9+KE/eyWkJlF4kPqmkLCGLICmkyQZdKUYY/30Aj0nxd5cd9NIqT++fl
	 y5RRr9scvM1rv16BDsNwD4zoq/5LkMdFfeTh/qv+3tvdDZmXSMAq7eOsPHafTuUfSt
	 1Q3n1DWuZu9I/K15mCo014kiCsbT+fzDnYxqnKc0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KCGllf033330
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 06:16:47 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 06:16:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 06:16:46 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KCGk1i082096;
	Tue, 20 Feb 2024 06:16:46 -0600
Date: Tue, 20 Feb 2024 17:46:45 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut
	<marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <mhi@lists.linux.dev>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <e612ecb3-31f4-4527-9ca1-5110ce33859f@ti.com>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
 <20240216-dw-hdma-v2-2-b42329003f43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216-dw-hdma-v2-2-b42329003f43@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 24/02/16 11:04PM, Manivannan Sadhasivam wrote:
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
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3a26dfc5368f..d07747b75947 100644
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
> 

