Return-Path: <linux-pci+bounces-25601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37DCA83402
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 00:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1483E8A6B32
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 22:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24539212FA3;
	Wed,  9 Apr 2025 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlhbJF72"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B61DFE0A;
	Wed,  9 Apr 2025 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236962; cv=none; b=Y1crXKtrASagP6wLel5M5i8omrmNnTBXUj0lumP0ie96UVzWpcnf9zUe1CEmUnXdqcC7dLQWTXo6elEqmywjPDEQZ++v46Us7M2sxE7tDLbMnVSpfioTW+quIBsM1N+ko6oj05a4y7iu6tr0O01NAiR7McdQ5TSRTF7inUFM+xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236962; c=relaxed/simple;
	bh=CTb05GpNEcbQ6n91ixI/8fsl6HYXEGqdFxMUfvdz68M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Ifsf+LcOpEq6LXQPPRdFgYQV3zuUExWw+xU1IjOOcqeW6nfDginY3aUxTL9icGgu/QcE/8LX2yyZEk9QxPBC9Ih6dWx+8KbsaRLrG3WOvZyzh68jhOPI4ZbmlX8RXZ7QriU3kdMy0TQ4tOIPnWkkj1xwwb/uP/i9+aUiP1HCGe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlhbJF72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADFCC4CEE2;
	Wed,  9 Apr 2025 22:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744236961;
	bh=CTb05GpNEcbQ6n91ixI/8fsl6HYXEGqdFxMUfvdz68M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QlhbJF72ErfhXrLT3ICgLmoshVKv85mqJMiW6uf7029MAQ/avfAJL+CGJRTK1IaBc
	 CIQD7Ayb7sSXiRDJQSg5g0ui9LE+EBEb5/kfSNucufDre+BjRCrC3wUeOZQq1OtEn2
	 CoTo0m3qPaFXTpt5dmPf0wRyehPFNmAeqVbsfVdGT2gV+AfQQiZMI7Et8IJ+PexeXH
	 hTvKepP18xlCSmFS2Xpg3GmecytDtuLGyY5J3FCJQaxJB+N6tMxIjuvqumasNkhBEp
	 PHlQdjzS6ft9X8KWfKpupBJtnZsTxLptcKhsUImWZmjwmLU6BeLA5ddffYzjwryO8E
	 +wiLyGgqaZ+dg==
Date: Wed, 9 Apr 2025 17:15:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan Karunakaran Pillai <mpillai@cadence.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] PCI: cadence: Add support for PCIe Endpoint HPA
 controllers
Message-ID: <20250409221559.GA299990@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PPF4D26F8E1C61F700C22A738FF8846DA2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>

On Thu, Mar 27, 2025 at 11:40:36AM +0000, Manikandan Karunakaran Pillai wrote:
> Add support for the second generation(HPA) Cadence PCIe endpoint
> controller by adding the required functions based on the HPA registers
> and register bit definitions

Add period.

> @@ -93,7 +93,10 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  	 * for 64bit values.
>  	 */
>  	sz = 1ULL << fls64(sz - 1);
> -	aperture = ilog2(sz) - 7; /* 128B -> 0, 256B -> 1, 512B -> 2, ... */
> +	/*
> +	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
> +	 */
> +	aperture = ilog2(sz) - 7;

Unclear exactly how this is related to HPA and whether it affects
non-HPA.

> @@ -121,7 +124,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>  	else
>  		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> -	b = (bar < BAR_4) ? bar : bar - BAR_4;
> +	b = (bar < BAR_3) ? bar : bar - BAR_3;

Unclear what's going on here because this doesn't look specific to
HPA.  Should this be a separate patch that fixes an existing defect?

>  	if (vfn == 0 || vfn == 1) {
>  		cfg = cdns_pcie_readl(pcie, reg);
> @@ -158,7 +161,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		reg = CDNS_PCIE_LM_EP_VFUNC_BAR_CFG(bar, fn);
>  	else
>  		reg = CDNS_PCIE_LM_EP_FUNC_BAR_CFG(bar, fn);
> -	b = (bar < BAR_4) ? bar : bar - BAR_4;
> +	b = (bar < BAR_3) ? bar : bar - BAR_3;

And here.

> @@ -569,7 +572,11 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
>  	 * and can't be disabled anyway.
>  	 */
> -	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
> +	if (pcie->is_hpa)
> +		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
> +				     CDNS_PCIE_HPA_LM_EP_FUNC_CFG, epc->function_num_map);
> +	else
> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);

Sprinkling tests of "is_hpa" around is not very extensible.  When the
next generation after HPA shows up, then it gets really messy.
Sometimes generation-specific function pointers can make this simpler.

> +static int cdns_pcie_hpa_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> +				    struct pci_epf_bar *epf_bar)
> +{
> +	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +	struct cdns_pcie_epf *epf = &ep->epf[fn];
> +	struct cdns_pcie *pcie = &ep->pcie;
> +	dma_addr_t bar_phys = epf_bar->phys_addr;
> +	enum pci_barno bar = epf_bar->barno;
> +	int flags = epf_bar->flags;
> +	u32 addr0, addr1, reg, cfg, b, aperture, ctrl;
> +	u64 sz;
> +
> +	/*
> +	 * BAR size is 2^(aperture + 7)
> +	 */
> +	sz = max_t(size_t, epf_bar->size, CDNS_PCIE_EP_MIN_APERTURE);
> +	/*

Add blank line between code and comment.

> +	 * roundup_pow_of_two() returns an unsigned long, which is not suited
> +	 * for 64bit values.
> +	 */
> +	sz = 1ULL << fls64(sz - 1);
> +	/*

Again.  Check for other places in this series.

> +	 * 128B -> 0, 256B -> 1, 512B -> 2, ...
> +	 */
> +	aperture = ilog2(sz) - 7;

