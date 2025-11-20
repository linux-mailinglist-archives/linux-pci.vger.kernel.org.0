Return-Path: <linux-pci+bounces-41782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFBBC74087
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 586994E7A3F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30254334C1A;
	Thu, 20 Nov 2025 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tkq1XzBh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDC1E766E;
	Thu, 20 Nov 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642767; cv=none; b=hMTjTghLVkCuW5iOHwFKYi9/gHSaRYmt4MgfgYfnRS0udhKgOLRKjV+8w1mBqPKiLZOppeR2JRjAXabLiTlxERYOzLZv5bBpvFJ7LLTJOlQ41a6qiyappIqE+G8+hATAMsd0klGBURVuStEtxAoZoVQEGg5BB2qnC78+vhtsVjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642767; c=relaxed/simple;
	bh=qnW1EKhk7A6lX88Bv/cYsAs1SCDxGXnPh7rfyh5s+Mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gReG3F0d2w6BXc3l2m4z984s5RCvU/9h6tXtV9qwWb5hze5zzQZc1h7MckFqCDmlnGyllogks4OiPkpq6Mar6ISLj0jQji+mr/Qm2mIZsNC2krGdfpu4QUiKHD6JxEKQxj0EqclZl8E99w0U6qHsJR/I3nCWS0kasWcOq0YpvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tkq1XzBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F157C4CEF1;
	Thu, 20 Nov 2025 12:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763642763;
	bh=qnW1EKhk7A6lX88Bv/cYsAs1SCDxGXnPh7rfyh5s+Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkq1XzBhJv1lojHjI38jQghnjjATRed6db9L6JcdDE5jCdr57e8ZuxAmxJNd3dfn1
	 rwiKmB7BKNzjLNvlBt1XsdnOrKSTmrQ/er7aN2k8dfPqrCGRS6EQ/P/7YTSiMdKcMF
	 aknpvy0oUS5fZMrLMl9c503qjHD0Q6st/TrbQ9oFNSaEugkRlnUdridKrjeIJJjuYa
	 Hbu8vkRlmKHwxf3dphjzFyrD1dJq1IMWjqOJNrjEOW7R3kcdzMMfu6pq2ckNkzB8Gl
	 sQMx51DnY00X63AbiZrLMSfeih4LVYGLNseYqTykILLq5rFGNx9wl4cf5N1XFYKTPV
	 GflgJhXdPb3+w==
Date: Thu, 20 Nov 2025 18:15:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, 
	Frank.li@nxp.com
Subject: Re: [PATCH v6 3/3] PCI: dwc: Add no_suspport_L2 flag and skip
 PME_Turn_Off broadcast
Message-ID: <dux47crrf6ranvexkpzw667hzmkgfguqadseco52svgvglalye@alxqq4ybu672>
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
 <20251120101236.1538-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120101236.1538-1-zhangsenchuan@eswincomputing.com>

On Thu, Nov 20, 2025 at 06:12:35PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> The ESWIN EIC7700 soc does not support enter L2 link state. Therefore add
> no_suspport_L2 flag skip PME_Turn_Off broadcast and link state check code,
> other driver can reuse this flag if meet the similar situation.
> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>

Does this patch work for you?
https://lore.kernel.org/linux-pci/20251119-pci-dwc-suspend-rework-v1-1-aad104828562@oss.qualcomm.com/

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda5..a203577606e5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1156,6 +1156,9 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
> 
> +	if (pci->no_suspport_L2)
> +		goto stop_link;
> +
>  	if (pci->pp.ops->pme_turn_off) {
>  		pci->pp.ops->pme_turn_off(&pci->pp);
>  	} else {
> @@ -1182,6 +1185,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	 */
>  	udelay(1);
> 
> +stop_link:
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..170a73299ce5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -539,6 +539,7 @@ struct dw_pcie {
>  	 * use_parent_dt_ranges to true to avoid this warning.
>  	 */
>  	bool			use_parent_dt_ranges;
> +	bool			no_suspport_L2;
>  };
> 
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> --
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

