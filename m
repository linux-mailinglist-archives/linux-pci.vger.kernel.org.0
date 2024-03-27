Return-Path: <linux-pci+bounces-5276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2303F88ED99
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 19:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAAC6282FED
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B605130AD4;
	Wed, 27 Mar 2024 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQmy7JUC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15785227;
	Wed, 27 Mar 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711562797; cv=none; b=Gh5/oAkHJzjFLiXXJYU0nDRzkhfxJiueaayFYfjMdtBSER87twIbKr4g/z4efGwAfMTL4BqNtgDRBd+fNGrhLI2qeFlrLQdLfwkg2/DWwN88RQ0MeNuaGwUCETNbdy/ua+rNq7vS3w+NazxHTSYhlcmJo7gWIF4TPXOJjoJBwOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711562797; c=relaxed/simple;
	bh=ELmyXwcV+FV9/p8zH/5M6gKnn4Kq8bGt1DVRV4LDDKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtG4u3LJXZJrB1Z9BZFShmUwnRWY6TQnHuy6oizg2Ji7P7NgHVM3sHtvIA/RjOzwS0JyPmDhxGuaa2YzOLlRbN/ENbIco1PeFZKaxCJNWtQDhihM/5y+mtMULljNfNRbgtre5CZ09E2Q3QyLW/IhGjDzp/cK9wgc4Vg5U3Zrqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQmy7JUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB0FC433C7;
	Wed, 27 Mar 2024 18:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711562796;
	bh=ELmyXwcV+FV9/p8zH/5M6gKnn4Kq8bGt1DVRV4LDDKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQmy7JUCEZ0RxIGKKgDxesVr/zBZBlOhbpw6BuiwYqInjUm2QolaDyoi93Z/1ZIDT
	 fXfeILsnH6JFGEkhARAkWC6/HiE8+5o5m9o69ef2b1DjI4qtlbtnt2G+4LIovO2GXr
	 g8N9dGuVaSpcBXK61RpiAK3G9bs75gKErf40XvBIqRcumFGtD5EzKfM+JNIORC1NhX
	 st47971wfU0D30xAqoe5lON13N9ktrWVS7ajto4z++ZpfmvSVkP6wOKqsLplbObd2/
	 JOpORRStz3LnZXXYI+T59a1Haaiihp6vUslg8pJvBAmv3w5p1XyLystGyO8RAqQvpU
	 XNZcGuAQYU0Pg==
Date: Wed, 27 Mar 2024 19:06:30 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 07/11] PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown()
 API to handle Link Down event
Message-ID: <ZgRgJsOT_bzXM1wK@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-7-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-7-6134e6c1d491@linaro.org>

Hello Mani,

On Thu, Mar 14, 2024 at 08:53:46PM +0530, Manivannan Sadhasivam wrote:
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
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 93 ++++++++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h    |  5 ++
>  2 files changed, 67 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 3893a8c1a11c..5451057ca74b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -14,18 +14,6 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  
> -/**
> - * dw_pcie_ep_linkup - Notify EPF drivers about link up event
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
>   * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization
>   *			    complete
> @@ -672,6 +660,29 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
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
> @@ -686,13 +697,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
> @@ -755,20 +764,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
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
> -		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
> -			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, 0x0);
> -	}
> -
>  	/*
>  	 * PTM responder capability can be disabled only after disabling
>  	 * PTM root capability.
> @@ -785,9 +782,6 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  		dw_pcie_dbi_ro_wr_dis(pci);
>  	}
>  
> -	dw_pcie_setup(pci);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> -

Your previous series had:

-       dw_pcie_setup(pci);
-       dw_pcie_dbi_ro_wr_dis(pci);
+       dw_pcie_ep_init_non_sticky_registers(pci);

Here.
I tested this series, but it did not work for me (the Resizable BARs did
not get resized) since you removed the call to
dw_pcie_ep_init_non_sticky_registers().

By readding the call to dw_pcie_ep_init_non_sticky_registers(),
the BARs get Resized again.


BTW do you have a git branch with both your series somewhere?
(Possibly even rebased on
https://lore.kernel.org/linux-pci/20240320113157.322695-1-cassel@kernel.org/T/#t
like you suggested in your other mail.)


Kind regards,
Niklas

