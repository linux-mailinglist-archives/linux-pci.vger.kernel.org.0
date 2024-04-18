Return-Path: <linux-pci+bounces-6395-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61068A9319
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 08:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15CAB1C20DBD
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 06:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA97225D9;
	Thu, 18 Apr 2024 06:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wScxRXYa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A823DE
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713421868; cv=none; b=Eb/mGl3GRNayfoaepezOwEFfE994R/MAZEWBRYKn+wzWTB+fPzRiJKFKetY2tlLNd62B8cDWYfdWtMMaLk5O3Pth5v/32Sy7PQgAB3pR2ZrlZWABjYxvgc+MOXtYIDV8tkRWgGy12+A6GfJeP2FbfWDJXRtaUYvisgLg0PHfUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713421868; c=relaxed/simple;
	bh=LrdjjpkgLeF0jdIA8AVj8K1IxOyKL2qV2D+llcvgDbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCvXzyBUmx80IZCb7hwhnAIc5RZoeqv6vx5bh5apoVJ42B3L0zZO9bRabMwpJpe63iTbnJfON+rFmmBkyh3tdnKgLmVoAsqFGiXzUEtDwkPe7v7xESyCvOlqbo+0sEwtJRyBa4YnI3QnMupFLo79MbP5H3WxYKdLdlwF/EThS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wScxRXYa; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ece8991654so516340b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 23:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713421865; x=1714026665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DqP++inW+493cGi/mRUROkxqqlY1ajss2gCH0VtYow8=;
        b=wScxRXYaUcc0QILXsonJaBgFuptPSFVLSK9dbuQ+qGGwxt2YnWHDHfSdfcnJDJUhwg
         Dzooy01Anq9LDWDC/WdywbxTnLZxR1/ioWu9r2h61zkEDkmPDTPrd5gvtl0OlkrNet4O
         gVQbstsO++daFin0SjJJEcgcd4SbAZDoAROuWgrQNGlzorLZyuw5OEf5lLDi5z0n+Jzx
         /X8Wk6fwmKvQFJUGhE8jPJJDtXdF50InTLTpsynXUDlfmOqrjM12mBYcZIzzKPMRg8p6
         9frwPMNR5qeHgY9gFyOHWQnaiA1/yvaXsRFI8CRrsbkxymL0jiN9X+dw/IXzOaPHpy4m
         lcWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713421865; x=1714026665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqP++inW+493cGi/mRUROkxqqlY1ajss2gCH0VtYow8=;
        b=s8Czckb9M+cxEFwID9gGrG6i2/TGVDqz+ibz8mV50ql5XRtz4mQ4W0AdvioeysXJzu
         Gzad/LNWYxfhTWz/1dXD0NNdx4EmI5Xtd983jIiG36mV/PZ2sWRTKRaansmf+2781zRR
         Bdoir0lV/3/bzm92DR3d7oZP7G+Sx1QLUKN6JTg7T5btRrDE+sAA34XtV7BG/Ov4yxJ5
         P2w0L5LEKPnVt4xy5eXKhLaw86SyIy99WLNjSOLUbuHQbLmTELRMctEET1DrrCjDE8Z2
         E+0V1JxmA4GsOx1VUakSe0PAvNN7Shr1bY/hSkeZKoY99dRJzbS89FuamDxIixi/770f
         4ppA==
X-Forwarded-Encrypted: i=1; AJvYcCUvCU1tGZidwI5A/Qh8JiAlw5FeEo7v7WVnA3iOwmHexxhfF26O79UHfh52lP+r4CtDLN6ORy3TIi0+duiFRmB4tnf/PTE88IGD
X-Gm-Message-State: AOJu0YweO2A+58W73MspOTv3I/14TxhR8I56AgIyTq/lVHnOO2t+j4pP
	pK8iV42XwHNZHwy13M6PHfhdle2dFhUakfw2OFVaL5lOA41CU7CugA1BL+Vfcw==
X-Google-Smtp-Source: AGHT+IHU2IZ95oWdl4Gw7bDq+Ljx6zIQbhqOlRJBQg/8BN9QEjiDfRMdMv1HRveIcGbjy2nMWY0z0Q==
X-Received: by 2002:a05:6a21:3a48:b0:1a7:88c3:85ed with SMTP id zu8-20020a056a213a4800b001a788c385edmr2823336pzb.1.1713421865380;
        Wed, 17 Apr 2024 23:31:05 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id g13-20020a62e30d000000b006ecfd2ad4ddsm743339pfh.146.2024.04.17.23.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 23:31:04 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:00:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Message-ID: <20240418063058.GE2861@thinkpad>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
 <20240417-pme_msg-v7-5-9c6208cda90f@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240417-pme_msg-v7-5-9c6208cda90f@nxp.com>

On Wed, Apr 17, 2024 at 12:59:43PM -0400, Frank Li wrote:
> Instead of relying on the vendor specific implementations to send the
> PME_Turn_Off message, let's introduce a generic way of sending the message
> using the MSG TLP.
> 
> This is achieved by reserving a region for MSG TLP of size
> 'pci->region_align', at the end of the first IORESOURCE_MEM window of the
> host bridge. And then sending the PME_Turn_Off message during system
> suspend with the help of iATU.
> 
> The reason for reserving the MSG TLP region at the end of the
> IORESOURCE_MEM is to avoid generating holes in between. Because, when the
> region is allocated using allocate_resource(), memory will be allocated
> from the start of the window. Later, if memory gets allocated for an
> endpoint of size bigger than 'region_align', there will be a hole between
> MSG TLP region and endpoint memory.
> 
> It should be noted that this generic implementation is optional for the
> glue drivers and can be overridden by a custom 'pme_turn_off' callback.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 102 ++++++++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h      |   3 +
>  2 files changed, 100 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3a9cb4be22ab2..f57805b21ef53 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -398,6 +398,34 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct resource_entry *win;
> +	struct resource *res;
> +
> +	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	if (win) {
> +		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
> +		if (!res)
> +			return;
> +
> +		/*
> +		 * Allocate MSG TLP region of size 'region_align' at the end of
> +		 * the host bridge window.
> +		 */
> +		res->start = win->res->end - pci->region_align + 1;
> +		res->end = win->res->end;
> +		res->name = "msg";
> +		res->flags = win->res->flags | IORESOURCE_BUSY;
> +
> +		if (!request_resource(win->res, res))
> +			pp->msg_res = res;
> +		else
> +			devm_kfree(pci->dev, res);

You still haven't resolved my earlier comment:

"You are explicitly freeing 'msg_res' everywhere. So either drop devm_ or rely
on devm to free the memory."

- Mani

> +	}
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -484,6 +512,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	/*
> +	 * Allocate the resource for MSG TLP before programming the iATU
> +	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> +	 * on the value of 'region_align', this has to be done after
> +	 * dw_pcie_iatu_detect().
> +	 *
> +	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
> +	 * make use of the generic MSG TLP implementation.
> +	 */
> +	if (pp->use_atu_msg)
> +		dw_pcie_host_request_msg_tlp_res(pp);
> +
>  	ret = dw_pcie_edma_detect(pci);
>  	if (ret)
>  		goto err_free_msi;
> @@ -541,6 +581,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_edma_remove(pci);
>  
> +	if (pp->msg_res) {
> +		release_resource(pp->msg_res);
> +		devm_kfree(pci->dev, pp->msg_res);
> +	}
> +
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
>  
> @@ -700,7 +745,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.type = PCIE_ATU_TYPE_MEM;
>  		atu.cpu_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
> -		atu.size = resource_size(entry->res);
> +
> +		/* Adjust iATU size if MSG TLP region was allocated before */
> +		if (pp->msg_res && pp->msg_res->parent == entry->res)
> +			atu.size = resource_size(entry->res) -
> +					resource_size(pp->msg_res);
> +		else
> +			atu.size = resource_size(entry->res);
>  
>  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret) {
> @@ -733,6 +784,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
>  			 pci->num_ob_windows);
>  
> +	pp->msg_atu_index = i;
> +
>  	i = 0;
>  	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
> @@ -838,11 +891,47 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
>  
> +static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> +{
> +	struct dw_pcie_ob_atu_cfg atu = { 0 };
> +	void __iomem *mem;
> +	int ret;
> +
> +	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
> +		return -ENOSPC;
> +
> +	if (!pci->pp.msg_res)
> +		return -ENOSPC;
> +
> +	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
> +	atu.routing = PCIE_MSG_TYPE_R_BC;
> +	atu.type = PCIE_ATU_TYPE_MSG;
> +	atu.size = resource_size(pci->pp.msg_res);
> +	atu.index = pci->pp.msg_atu_index;
> +
> +	atu.cpu_addr = pci->pp.msg_res->start;
> +
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	mem = ioremap(atu.cpu_addr, pci->region_align);
> +	if (!mem)
> +		return -ENOMEM;
> +
> +	/* A dummy write is converted to a Msg TLP */
> +	writel(0, mem);
> +
> +	iounmap(mem);
> +
> +	return 0;
> +}
> +
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> -	int ret;
> +	int ret = 0;
>  
>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
> @@ -854,10 +943,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
>  		return 0;
>  
> -	if (!pci->pp.ops->pme_turn_off)
> -		return 0;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
>  
> -	pci->pp.ops->pme_turn_off(&pci->pp);
> +	if (ret)
> +		return ret;
>  
>  	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
>  				PCIE_PME_TO_L2_TIMEOUT_US/10,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 703b50bc5e0f1..dca5de4c6e877 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -341,6 +341,9 @@ struct dw_pcie_rp {
>  	struct pci_host_bridge  *bridge;
>  	raw_spinlock_t		lock;
>  	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
> +	bool			use_atu_msg;
> +	int			msg_atu_index;
> +	struct resource		*msg_res;
>  };
>  
>  struct dw_pcie_ep_ops {
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

