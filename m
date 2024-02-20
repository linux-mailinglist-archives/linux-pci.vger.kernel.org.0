Return-Path: <linux-pci+bounces-3762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B401F85BC0C
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436361F23223
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC3D67E63;
	Tue, 20 Feb 2024 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AFSbsmDV"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771CB664A6;
	Tue, 20 Feb 2024 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708432029; cv=none; b=i2WLgu5VJV5xIm3GeI3j4dYoi16IYd0JFqUsDyT048mKEr121GFjOctLw6q5o4kC2DsoohnDQabzqPg5fnzDrOw8/YbBCRkgPy5hD5bJQzK5RZRafjFAs3OwVIWUzCWAyhnEeQzsJugrDfG6vUkC7dIoQusH/rRWm1nQO63WgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708432029; c=relaxed/simple;
	bh=RuY9w5Dr/1wdetSAqH5kT8zGrdXUySxdTGovYYxNZG4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy4wUzuf4XwqO/hKMlhvJOJT+rn21rasxmeQYQtmSl1BuexP3OZfP5gh0SnI1XATCPsmb6Z/3d+JhE4OwBbniA5G3xmYEuEWuBQ+mcp3wiWykt/L4h7dyBh63Q5MJcubkgDky09PCfEnAcSc8YuE9lwYm4iESs3Sw5c6lyDMpXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AFSbsmDV; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KCQo64093480;
	Tue, 20 Feb 2024 06:26:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708432010;
	bh=x8mUODGtFNg84s5n14xg7n/kJUQBebR7lCHh9t+k4lA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=AFSbsmDVoNp1NzAKbPe/H3eoYR74xIERVx73jf70QUFR9HxJCBNtiXfkJEIRXJ5QY
	 tMRMw8x063Ssd2tqjdk6jbm9/F1QUdiZmHdghpyO6YuUvzGkOXo7TyQway1E+NZESb
	 Qa+u5mT+tJ83RBkx01bWKiSIxuuqnMTpqNHpME0Y=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KCQorb116256
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Feb 2024 06:26:50 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 06:26:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 06:26:49 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KCQmMl092870;
	Tue, 20 Feb 2024 06:26:48 -0600
Date: Tue, 20 Feb 2024 17:56:48 +0530
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
Subject: Re: [PATCH v2 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Message-ID: <17ef7cf1-62d8-41f8-9e52-3ce972708a72@ti.com>
References: <20240216-dw-hdma-v2-0-b42329003f43@linaro.org>
 <20240216-dw-hdma-v2-3-b42329003f43@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240216-dw-hdma-v2-3-b42329003f43@linaro.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 24/02/16 11:04PM, Manivannan Sadhasivam wrote:
> Instead of maintaining a separate capability for glue drivers that cannot
> support auto detection of the eDMA mapping format, let's pass the mapping
> format directly from them.
> 
> This will simplify the code and also allow adding HDMA support that also
> doesn't support auto detection of mapping format.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
>  3 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index d07747b75947..54ecd536756d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> +	/*
> +	 * Bail out finding the mapping format if it is already set by the glue
> +	 * driver. Also ensure that the edma.reg_base is pointing to a valid
> +	 * memory region.
> +	 */
> +	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
> +		return pci->edma.reg_base ? 0 : -ENODEV;
> +
>  	/*
>  	 * Indirect eDMA CSRs access has been completely removed since v5.40a
>  	 * thus no space is now reserved for the eDMA channels viewport and
>  	 * former DMA CTRL register is no longer fixed to FFs.
> -	 *
> -	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
> -	 * have zeros in the eDMA CTRL register even though the HW-manual
> -	 * explicitly states there must FFs if the unrolled mapping is enabled.
> -	 * For such cases the low-level drivers are supposed to manually
> -	 * activate the unrolled mapping to bypass the auto-detection procedure.
>  	 */
> -	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
> +	if (dw_pcie_ver_is_ge(pci, 540A))
>  		val = 0xFFFFFFFF;
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..995805279021 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -51,9 +51,8 @@
>  
>  /* DWC PCIe controller capabilities */
>  #define DW_PCIE_CAP_REQ_RES		0
> -#define DW_PCIE_CAP_EDMA_UNROLL		1
> -#define DW_PCIE_CAP_IATU_UNROLL		2
> -#define DW_PCIE_CAP_CDM_CHECK		3
> +#define DW_PCIE_CAP_IATU_UNROLL		1
> +#define DW_PCIE_CAP_CDM_CHECK		2
>  
>  #define dw_pcie_cap_is(_pci, _cap) \
>  	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index e9166619b1f9..3c535ef5ea91 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
>  	rcar->dw.ops = &dw_pcie_ops;
>  	rcar->dw.dev = dev;
>  	rcar->pdev = pdev;
> -	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
> +	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
>  	dw_pcie_cap_set(&rcar->dw, REQ_RES);
>  	platform_set_drvdata(pdev, rcar);
>  
> 
> -- 
> 2.25.1
> 
> 

