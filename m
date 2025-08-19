Return-Path: <linux-pci+bounces-34304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A08B2C6C9
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 16:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA7C723191
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 14:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E112253EC;
	Tue, 19 Aug 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVk6gJ0P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE631DF74F;
	Tue, 19 Aug 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612899; cv=none; b=QgayCtKIWiBvTozQyGijG4fw6rotca3325AKagrgFrfIb8VYGLP8O3M20mHpvw/ty6KuoqXUvBwIsDPXJsfe1XNuKV4ExhPFqWXTtlsRaSSktoa1fi4R9PMSshViA6KcMlNB+uVnev5CyARa7uC7i/j46PDTrTsjhjm93fHq2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612899; c=relaxed/simple;
	bh=mJLUmjH8bs9v1NolTC7GC/CjWIWsHL9aaoo5lsud3rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU/88fgPFMKOki7ytMTYs1FzSVuvj2QgtY2aLhv8idI/xSImNbeKdlR3980v/PAq4JhMkZq9zmrNmsfQcrGinxF0TXvSKJGPuldv+UvvlG+szuzZ5OZaIUvwFVyUY59tfuIIB6FB8doD9H3W43UB6O0yXjgmeM7YnJ8X0MK1Sjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVk6gJ0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4546C4CEF1;
	Tue, 19 Aug 2025 14:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755612898;
	bh=mJLUmjH8bs9v1NolTC7GC/CjWIWsHL9aaoo5lsud3rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eVk6gJ0PrfXMYDhQ8FedcweuXQZtLRStZUkM1ST+SO/z3UpTwApN/uF6Xa0ZnO0fi
	 4jCrnyeKEPPCPAbpAy17souoT/AcETfn7mbOrLJkg5o8gXdMbfBvKo+oJAhX7RkLtH
	 2NDGleGMbIPyzA8BwSZEJxWP7bNStGeqLVpgdGAjp2M31ukRxke/dcdb82DIZGVIx4
	 5P9fZobU9PPXNWSxC9h9SmaNQsAGOyRkYHBlG1UpZo5e/Xo7KTfNSR09zaQB/qgUZx
	 ExJ6BSoIepUjot9yU/OtVdMsDRNP3OylNwFYHMRBQiaakdY4JV4idNnqgKFSs70Byk
	 Bh+u8GziLCIPw==
Date: Tue, 19 Aug 2025 19:44:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	jingoohan1@gmail.com, robh@kernel.org, ilpo.jarvinen@linux.intel.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Use common PCI host bridge APIs for
 finding the capabilities
Message-ID: <767tx2yce7ohfowz5vtec3a5fkcdo7qjmrfpklmy5g6y5yqwao@fxacvqh2zrhb>
References: <20250616152515.966480-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616152515.966480-1-18255117159@163.com>

On Mon, Jun 16, 2025 at 11:25:15PM GMT, Hans Zhang wrote:
> Use the PCI core is now exposing generic macros for the host bridges to
> search for the PCIe capabilities, make use of them in the DWC EP driver.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Please send it together with the dependent series.

- Mani

> ---
> - Submissions based on the following patches:
> https://patchwork.kernel.org/project/linux-pci/patch/20250607161405.808585-1-18255117159@163.com/
> 
> Recently, I checked the code and found that there are still some areas that can be further optimized.
> The above series of patches has been around for a long time, so I'm sending this one out for review
> as a separate patch.
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 39 +++++++------------
>  1 file changed, 14 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0ae54a94809b..9f1880cc1925 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -69,37 +69,26 @@ void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_reset_bar);
>  
> -static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie_ep *ep, u8 func_no,
> -				     u8 cap_ptr, u8 cap)
> +static int dw_pcie_ep_read_cfg(void *priv, u8 func_no, int where, int size, u32 *val)
>  {
> -	u8 cap_id, next_cap_ptr;
> -	u16 reg;
> -
> -	if (!cap_ptr)
> -		return 0;
> -
> -	reg = dw_pcie_ep_readw_dbi(ep, func_no, cap_ptr);
> -	cap_id = (reg & 0x00ff);
> -
> -	if (cap_id > PCI_CAP_ID_MAX)
> -		return 0;
> -
> -	if (cap_id == cap)
> -		return cap_ptr;
> +	struct dw_pcie_ep *ep = priv;
> +
> +	if (size == 4)
> +		*val = dw_pcie_ep_readl_dbi(ep, func_no, where);
> +	else if (size == 2)
> +		*val = dw_pcie_ep_readw_dbi(ep, func_no, where);
> +	else if (size == 1)
> +		*val = dw_pcie_ep_readb_dbi(ep, func_no, where);
> +	else
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
>  
> -	next_cap_ptr = (reg & 0xff00) >> 8;
> -	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
> +	return PCIBIOS_SUCCESSFUL;
>  }
>  
>  static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
>  {
> -	u8 next_cap_ptr;
> -	u16 reg;
> -
> -	reg = dw_pcie_ep_readw_dbi(ep, func_no, PCI_CAPABILITY_LIST);
> -	next_cap_ptr = (reg & 0x00ff);
> -
> -	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
> +	return PCI_FIND_NEXT_CAP_TTL(dw_pcie_ep_read_cfg, PCI_CAPABILITY_LIST,
> +				     cap, ep, func_no);
>  }
>  
>  /**
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

