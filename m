Return-Path: <linux-pci+bounces-20918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFFBA2C9F3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B074164DAF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241622A1D8;
	Fri,  7 Feb 2025 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPCC7lXm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043633EC
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948677; cv=none; b=Yf4afycF+5GPs796NrjLqa11vIns4eHB9AK29OSCJTa5WOJtvMD5HDcv1kY6tsUP4diUMMBeHXfIIBtUo70xm0j1OJwqKTuSY4j5FY5lVKuEHheM9el7CWs49sGjwrGANbvo0pr/D3FjC8nLcmKWkzbLlXseGW2Gp7UEa2PYoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948677; c=relaxed/simple;
	bh=ab0uzGip+c2/1foqJYPYIMr8vzQovLugjpQVgHdxRMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGuGE4ij4L6xLf7UkWoZT/U6J4cKFzr2YgxzH3iu9hFDQdIRhFZ7S9tKgqw5GDkiCzO3l7bW8eZUKk6x3X7Wscgx5T6RRhiJcBPNmTeJ0d44PCdOxapGmEctoVanm3anhSlULGnjpdshW5E+t6nhB0Sv5ta1Opouis/pZ5wouAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPCC7lXm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f5268cf50so15000145ad.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738948674; x=1739553474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KMFbd/MG0SUP2ejMummc9ZUkx74XJreTyWTyiKDcD4E=;
        b=qPCC7lXmaAcJgf9lpQP4ezsecjb5+vY8sgeTJJxS3gBM6SBzy5ql8icXHB6FYUToHg
         h/QlwcAbbaD/3er9mwhW43J/RW8IwKUi/d61LTfjpCNo0803l6lkkJFWxvSU5rSqK5F/
         KkNhqoSxRAKnfswMZKGquUYUasTZA/SOvcaqWwGDjBnbTkyDpb1V3hG4Tt9Wu6IReLdF
         0OgfbyEHVVvCj8nnPQ4eo3M62TgeSwfeHqJHTLY6/i2o5Ua/Akwc+GNmnNIxvWFebt0c
         ePwXv04phHhDlE7M30k3bm4IlSH5lw8aE0da3LDRl7ek0/R79D33UJvtvZxNyRAyXVb7
         t86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738948674; x=1739553474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMFbd/MG0SUP2ejMummc9ZUkx74XJreTyWTyiKDcD4E=;
        b=KkAylhk+oPAYleknAqcE6F+j7Na2gugGGYka5S2B7v2S5cNB+3Q//QPCX2KeG1rU1H
         jmmSQzRY6it024QQGBByTzOkbBOy+sv5BVpLhipM7VAuyfPueAFaxiIvaOUI56zjJDc2
         Q0KY3VaMUtH9Do0vn/wLpNjoRfHUUPpQDK7JpHJ/GF21JH8cx0lxX3bT3PwaYb8a178g
         VQa+gab6IODpJevhfnt8cx2FGNTPdoqwTYVOtLOy2Pq85YKeouIpPYUNkvdDZVndq+I5
         tsVkp1cLwr090yrpZjVrjc6dkROiIj7XTMMmDE32vqcZDJ5Os+TjAOZIGusGAMEtU6Pk
         I6QA==
X-Forwarded-Encrypted: i=1; AJvYcCUkzI+a14tKxL4Ahzr/ZZ80mlt4KU+h9gNEqAVYR3ryVIUK7CzBUooV1x4PlsjRrEA6UJLFBYYxH88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFVEZuRU5I4pZRn6enANPKdgR/oYyoDA1x1mke4NIGzF2WjPv
	D0cVwY4UOP6Fa0kpPsNee6h+OyhDhW2mBI81LY4RLIYN9CJ0ayo8zj8OrHrKPg==
X-Gm-Gg: ASbGncsNflJK6K5iUNduKzV4ZBQ6eoH3SKzHKezbrCmnLUGty+YWFMmN5++MgXx/Jvh
	AhZGJVrQKAfrpn/YMoIg7EunmOmlR5+eNXJ6TAzozSiVWXfhq/kzY64SgqIFuZTlVuK3Er1O/TZ
	3ZMqHHcA2Fji80cUIaxVXSmi7JsgHMDFCjuzN1ksL0OnWLNYYvzezVAeePaITBVaT4DrNW+E8R1
	WpRIuOGGcWccINo6uK+trSP0uZLd2ukRNKLlUEvf9KegDGyUYqqlysaZ7Kgdu+E2TCg8dWNblot
	Eh8KdY3wOAXUHu5RKwt1d3BvTQ==
X-Google-Smtp-Source: AGHT+IFePJRrkEd3IhufZ4xX3DpiJjbV/Uo3N/y3SYuZMByt6PPdL3s886Ozye1VcveBGqsArsjZVg==
X-Received: by 2002:a17:903:2291:b0:21f:3e2d:7d2e with SMTP id d9443c01a7336-21f4e6efc9bmr64914625ad.27.1738948674342;
        Fri, 07 Feb 2025 09:17:54 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653acfesm33110925ad.65.2025.02.07.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:17:53 -0800 (PST)
Date: Fri, 7 Feb 2025 22:47:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/7] PCI: dwc: endpoint: Allow EPF drivers to
 configure the size of Resizable BARs
Message-ID: <20250207171749.jfseutefidxyff5c@thinkpad>
References: <20250131182949.465530-9-cassel@kernel.org>
 <20250131182949.465530-13-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131182949.465530-13-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:53PM +0100, Niklas Cassel wrote:
> The DWC databook specifies three different BARn_SIZING_SCHEME_N
> - Fixed Mask (0)
> - Programmable Mask (1)
> - Resizable BAR (2)
> 
> Each of these sizing schemes have different instructions for how to
> initialize the BAR.
> 
> The DWC driver currently does not support resizable BARs.
> 
> Instead, in order to somewhat support resizable BARs, the DWC EP driver
> currently has an ugly hack that force sets a resizable BAR to 1 MB, if
> such a BAR is detected.
> 
> Additionally, this hack only works if the DWC glue driver also has lied
> in their EPC features, and claimed that the resizable BAR is a 1 MB fixed
> size BAR.
> 
> This is unintuitive (as you somehow need to know that you need to lie in
> your EPC features), but other than that it is overly restrictive, since a
> resizable BAR is capable of supporting sizes different than 1 MB.
> 
> Add proper support for resizable BARs in the DWC EP driver.
> 
> Note that the pci_epc_set_bar() API takes a struct pci_epf_bar which tells
> the EPC driver how it wants to configure the BAR.
> 
> struct pci_epf_bar only has a single size struct member.
> 
> This means that an EPC driver will only be able to set a single supported
> size. This is perfectly fine, as we do not need the complexity of allowing
> a host to change the size of the BAR. If someone ever wants to support
> resizing a resizable BAR, the pci_epc_set_bar() API can be extended in the
> future.
> 
> With these changes, we allow an EPF driver to configure the size of
> Resizable BARs, rather than forcing them to a 1 MB size.
> 
> This means that an EPC driver does not need to lie in EPC features, and an
> EPF driver will be able to set an arbitrary size (not be forced to a 1 MB
> size), just like BAR_PROGRAMMABLE.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 182 ++++++++++++++++--
>  1 file changed, 167 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 6b494781da42..72418160e658 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -223,6 +223,125 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	ep->bar_to_atu[bar] = 0;
>  }
>  
> +static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
> +						enum pci_barno bar)
> +{
> +	u32 reg, bar_index;
> +	unsigned int offset, nbars;
> +	int i;
> +
> +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	if (!offset)
> +		return offset;
> +
> +	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +	nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
> +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		bar_index = reg & PCI_REBAR_CTRL_BAR_IDX;
> +		if (bar_index == bar)
> +			return offset;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
> +					struct pci_epf_bar *epf_bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	size_t size = epf_bar->size;
> +	int flags = epf_bar->flags;
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +	unsigned int rebar_offset;
> +	u32 rebar_cap, rebar_ctrl;
> +	int ret;
> +
> +	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
> +	if (!rebar_offset)
> +		return -EINVAL;
> +
> +	ret = pci_epc_bar_size_to_rebar_cap(size, &rebar_cap);
> +	if (ret)
> +		return ret;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	/*
> +	 * A BAR mask should not be written for a resizable BAR. The BAR mask
> +	 * is automatically derived by the controller every time the "selected
> +	 * size" bits are updated, see "Figure 3-26 Resizable BAR Example for
> +	 * 32-bit Memory BAR0" in DWC EP databook 5.96a. We simply need to write
> +	 * BIT(0) to set the BAR enable bit.
> +	 */
> +	dw_pcie_ep_writel_dbi2(ep, func_no, reg, BIT(0));
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
> +
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, 0);
> +		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
> +	}
> +
> +	/*
> +	 * Bits 31:0 in PCI_REBAR_CAP define "supported sizes" bits for sizes
> +	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
> +	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
> +	 */
> +	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
> +	rebar_ctrl &= ~GENMASK(31, 16);
> +	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
> +
> +	/*
> +	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
> +	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
> +	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
> +	 */
> +	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}
> +
> +static int dw_pcie_ep_set_bar_programmable(struct dw_pcie_ep *ep, u8 func_no,
> +					   struct pci_epf_bar *epf_bar)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar = epf_bar->barno;
> +	size_t size = epf_bar->size;
> +	int flags = epf_bar->flags;
> +	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	dw_pcie_ep_writel_dbi2(ep, func_no, reg, lower_32_bits(size - 1));
> +	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
> +
> +	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, upper_32_bits(size - 1));
> +		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
> +	}
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	return 0;
> +}
> +
> +static enum pci_epc_bar_type dw_pcie_ep_get_bar_type(struct dw_pcie_ep *ep,
> +						     enum pci_barno bar)
> +{
> +	const struct pci_epc_features *epc_features;
> +
> +	if (!ep->ops->get_features)
> +		return BAR_PROGRAMMABLE;
> +
> +	epc_features = ep->ops->get_features(ep);
> +
> +	return epc_features->bar[bar].type;
> +}
> +
>  static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			      struct pci_epf_bar *epf_bar)
>  {
> @@ -230,9 +349,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar = epf_bar->barno;
>  	size_t size = epf_bar->size;
> +	enum pci_epc_bar_type bar_type;
>  	int flags = epf_bar->flags;
>  	int ret, type;
> -	u32 reg;
>  
>  	/*
>  	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
> @@ -264,19 +383,30 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		goto config_atu;
>  	}
>  
> -	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
> -
> -	dw_pcie_dbi_ro_wr_en(pci);
> -
> -	dw_pcie_ep_writel_dbi2(ep, func_no, reg, lower_32_bits(size - 1));
> -	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
> -
> -	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> -		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, upper_32_bits(size - 1));
> -		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
> +	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
> +	switch (bar_type) {
> +	case BAR_FIXED:
> +		/*
> +		 * There is no need to write a BAR mask for a fixed BAR (except
> +		 * to write 1 to the LSB of the BAR mask register, to enable the
> +		 * BAR). Write the BAR mask regardless. (The fixed bits in the
> +		 * BAR mask register will be read-only anyway.)
> +		 */
> +		fallthrough;
> +	case BAR_PROGRAMMABLE:
> +		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
> +		break;
> +	case BAR_RESIZABLE:
> +		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		dev_err(pci->dev, "Invalid BAR type\n");
> +		break;
>  	}
>  
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	if (ret)
> +		return ret;
>  
>  config_atu:
>  	if (!(flags & PCI_BASE_ADDRESS_SPACE))
> @@ -710,9 +840,11 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
>  
>  static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  {
> +	struct dw_pcie_ep *ep = &pci->ep;
>  	unsigned int offset;
>  	unsigned int nbars;
> -	u32 reg, i;
> +	enum pci_barno bar;
> +	u32 reg, i, val;
>  
>  	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  
> @@ -727,9 +859,29 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
>  		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
>  		 * size in the range from 1 MB to 512 GB. Advertise support
>  		 * for 1 MB BAR size only.
> +		 *
> +		 * For a BAR that has been configured via dw_pcie_ep_set_bar(),
> +		 * advertise support for only that size instead.
>  		 */
> -		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
> +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
> +			/*
> +			 * While the RESBAR_CAP_REG_* fields are sticky, the
> +			 * RESBAR_CTRL_REG_BAR_SIZE field is non-sticky (it is
> +			 * sticky in certain versions of DWC PCIe, but not all).
> +			 *
> +			 * RESBAR_CTRL_REG_BAR_SIZE is updated automatically by
> +			 * the controller when RESBAR_CAP_REG is written, which
> +			 * is why RESBAR_CAP_REG is written here.
> +			 */
> +			val = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +			bar = val & PCI_REBAR_CTRL_BAR_IDX;
> +			if (ep->epf_bar[bar])
> +				pci_epc_bar_size_to_rebar_cap(ep->epf_bar[bar]->size, &val);
> +			else
> +				val = BIT(4);
> +
> +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, val);
> +		}
>  	}
>  
>  	dw_pcie_setup(pci);
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

