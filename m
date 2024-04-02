Return-Path: <linux-pci+bounces-5531-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA818950EE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 12:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4976F1F25694
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E35FDD3;
	Tue,  2 Apr 2024 10:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFuMHxPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE9259B4B;
	Tue,  2 Apr 2024 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055157; cv=none; b=l6+5qg08F6XjRddufl5IEcaNh95Q0y2QWdJZ8lVOhYdo7Haks74gKu5u6XmW9nSAzf4rT2dA4wXi64BpD1I48i3GvtdItSgfbFEtb9ieGsPWGPGPAWiUSpwoxNI1pKpjpgXSgxbaqzx7gMRReT0h5hEm/mJJfWOptBpEj+S2riQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055157; c=relaxed/simple;
	bh=Rb+hNv5+Ci1pY2u0k8EeFRCGNtH1Uphv2LjDF2WhGqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB+F913hulAGmPTIdChkuulM+CQBCnBwC4Jt4J8H+XdQnBztYnMwzB3+AkH6XtCtpMRb0aipKmNb1TbkO1HzbzjAzUzVhNKkH6xJ0NQ+5vWHuzk04p1TeXjsYdIkXAYkzdO/5Laoq10WQ0nR5/bSj4DtNLVq6zMsVhP/CovLoNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFuMHxPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92BB7C433C7;
	Tue,  2 Apr 2024 10:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712055156;
	bh=Rb+hNv5+Ci1pY2u0k8EeFRCGNtH1Uphv2LjDF2WhGqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFuMHxPXdZEw+2X92ofgaFNQe9XdX5NFSeGZ1D2yRcE4DEFEMLxzTcQVdhDMOa3om
	 mvR9XunA1a5fMefvqQkzkCXerWs2P13DQ1RznNz0heTsHp4h53btYix9lh8IKJkSeD
	 +jPFkBaSYci05eU1yf6IICQ3fqCo1FTDrPXlvcLBswadTsCDtFMBXg7yaaoSVj/89i
	 DfwV3LM3viBxnHUHMeBaEpu3h5zJc30pHi7em+jIKCifiRU+dpZLSG0xgVGzlvbH/2
	 zos19Bv6bvC1laMAOa1zpQn2z8nHpH4YCS9XE0cuAYi9ah0n9Hy3UlvKPXW8QmSQcn
	 zSUcEdPIEA2oQ==
Date: Tue, 2 Apr 2024 12:52:30 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 07/10] PCI: dwc: ep: Add a generic
 dw_pcie_ep_linkdown() API to handle Link Down event
Message-ID: <Zgvjbig89Wuw2bX-@ryzen>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-7-970dbe90b99d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401-pci-epf-rework-v2-7-970dbe90b99d@linaro.org>

On Mon, Apr 01, 2024 at 09:20:33PM +0530, Manivannan Sadhasivam wrote:
> As per the PCIe base spec r5.0, section 5.2, Link Down event can happen
> under any of the following circumstances:
> 
> 1. Fundamental/Hot reset
> 2. Link disable transmission by upstream component
> 3. Moving from L2/L3 to L0
> 
> In those cases, Link Down causes some non-sticky DWC registers to loose the
> state (like REBAR, etc...). So the drivers need to reinitialize them to
> function properly once the link comes back again.
> 
> This is not a problem for drivers supporting PERST# IRQ, since they can
> reinitialize the registers in the PERST# IRQ callback. But for the drivers
> not supporting PERST#, there is no way they can reinitialize the registers
> other than relying on Link Down IRQ received when the link goes down. So
> let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> non-sticky registers and also notifies the EPF drivers about link going
> down.
> 
> This API can also be used by the drivers supporting PERST# to handle the
> scenario (2) mentioned above.
> 
> NOTE: For the sake of code organization, move the dw_pcie_ep_linkup()
> definition just above dw_pcie_ep_linkdown().
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 98 ++++++++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h    |  5 ++
>  2 files changed, 68 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2063cf2049e5..56b34267850e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -15,18 +15,6 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  
> -/**
> - * dw_pcie_ep_linkup - Notify EPF drivers about Link Up event
> - * @ep: DWC EP device
> - */
> -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> -{
> -	struct pci_epc *epc = ep->epc;
> -
> -	pci_epc_linkup(epc);
> -}
> -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> -
>  /**
>   * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization complete
>   * @ep: DWC EP device
> @@ -673,6 +661,29 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  	return 0;
>  }
>  
> +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> +{
> +	unsigned int offset;
> +	unsigned int nbars;
> +	u32 reg, i;
> +
> +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	if (offset) {
> +		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> +		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> +			PCI_REBAR_CTRL_NBAR_SHIFT;
> +
> +		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> +			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> +	}
> +
> +	dw_pcie_setup(pci);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  /**
>   * dw_pcie_ep_init_registers - Initialize DWC EP specific registers
>   * @ep: DWC EP device
> @@ -687,13 +698,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	struct dw_pcie_ep_func *ep_func;
>  	struct device *dev = pci->dev;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int offset, ptm_cap_base;
> -	unsigned int nbars;
> +	u32 ptm_cap_base, reg;
>  	u8 hdr_type;
>  	u8 func_no;
> -	int i, ret;
>  	void *addr;
> -	u32 reg;
> +	int ret;
>  
>  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
>  		   PCI_HEADER_TYPE_MASK;
> @@ -756,25 +765,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>  
> -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>  
> -	dw_pcie_dbi_ro_wr_en(pci);
> -
> -	if (offset) {
> -		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
> -		nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >>
> -			PCI_REBAR_CTRL_NBAR_SHIFT;
> -
> -		/*
> -		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
> -		 * size in the range from 1 MB to 512 GB. Advertise support
> -		 * for 1 MB BAR size only.
> -		 */

Here you remove the above comment, but you don't seem to (re-)add the comment
when moving this code to dw_pcie_ep_init_non_sticky_registers().
(I assume that this is a simple rebase mistake.)


Kind regards,
Niklas

> -		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
> -	}
> -
>  	/*
>  	 * PTM responder capability can be disabled only after disabling
>  	 * PTM root capability.

