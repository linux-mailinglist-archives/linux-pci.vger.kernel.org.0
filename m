Return-Path: <linux-pci+bounces-7907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506508D20E0
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E767D1F214C2
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934A17166D;
	Tue, 28 May 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mAtHRuRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7565B171656
	for <linux-pci@vger.kernel.org>; Tue, 28 May 2024 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911736; cv=none; b=Em0nbZ6MPX+8NpLRbtcJ2GEwubx9Wm/FM3+f284Fsy8YidIIJTsAM6OqzEscc5IStRmwBlzm3ES6EGVHjn+0hcloZF2JsWz6gcC9gbYZzokNK5lTO/0+HpjK6UZ1PUANEtIBhyfUY+ouw+a3H5oUXv5sHSqcAdXy0iuypTfW9zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911736; c=relaxed/simple;
	bh=BlC/m/6GBSaDP1AWkkyy4l224exPE/TauRvRz2K1KQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sIJbk1fRQspSkbeGoZLhfnmVnUJWnAZN7LiyvF+kvqf4ueh0MZ4k+QtIkSWSRtznuh357lBJsupIw11rAg3O/6vS3PX2WOFYMdjKTa7ZzrVs9LDwhtbOrRd5rDIfgmc/Uf7wfZr5lySvwdQjqftFhLOrGfPYhfWtQmqIaZhN604=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mAtHRuRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3468C3277B;
	Tue, 28 May 2024 15:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716911736;
	bh=BlC/m/6GBSaDP1AWkkyy4l224exPE/TauRvRz2K1KQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mAtHRuRyUXSplryVNDJb2T23mWNYaC7zHn8z/Rm+onfbCxJI5f/W/HNqLQQnA2LjB
	 eRhiZNYOq5DcwTPHiiCRLeZ0m3SvNLfRuAbVEZe5cxn75UiJV2a2FIjYhwcfqeel7Q
	 LqmVI8lHCJe9TWPvArv043okmJtNBBPd0PcYvQURKEdJ2JgPQMz+REhHox1FpWY30D
	 Ei/XN1KodHKkJslAVKXvjptll0UHPJNmahJ70zlYIssuoLDNMBV08iTK3Xi29NgUXK
	 06jMJUXhccctOPYxUyIe5PSbaIrOx2N8KVR1fAP8cCGHZLbYG8NUcmTF1/swaJ8gIh
	 +Xvnmb+ZeMLjg==
Date: Tue, 28 May 2024 10:55:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: dwc: ep: Add dw_pcie_ep_deinit_notify()
Message-ID: <20240528155534.GA312623@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528130035.1472871-6-cassel@kernel.org>

On Tue, May 28, 2024 at 03:00:37PM +0200, Niklas Cassel wrote:
> Add a DWC specific wrapper function (dw_pcie_ep_deinit_notify()) around
> pci_epc_deinit_notify(), similar to how we have a wrapper function
> (dw_pcie_ep_init_notify()) around pci_epc_init_notify().
> 
> This will allow the DWC glue drivers to use the same API layer for init
> and deinit notification.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 13 +++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h    |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2063cf2049e5..3c9079651dff 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -39,6 +39,19 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
>  
> +/**
> + * dw_pcie_ep_deinit_notify - Notify EPF drivers about EPC deinitialization
> + *			      complete
> + * @ep: DWC EP device
> + */
> +void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
> +{
> +	struct pci_epc *epc = ep->epc;
> +
> +	pci_epc_deinit_notify(epc);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit_notify);

What is the value of this wrapper?  

I see that dw_pcie_ep_deinit_notify() would be parallel to
dw_pcie_ep_init_notify() and dw_pcie_ep_linkup(), but none of these
has any DWC-specific content other than the fact that
pcie-designware.h provides stubs for the non-CONFIG_PCIE_DW_EP case.

What if we added stubs to pci-epc.h pci_epc_init_notify(),
pci_epc_deinit_notify(), pci_epc_linkup(), and pci_epc_linkdown() for
the non-CONFIG_PCI_ENDPOINT case instead?  Then we might be able to
drop all these DWC-specific wrappers.

>  /**
>   * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
>   *				 the endpoint function
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f8e5431a207b..dc63f764b8ba 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -672,6 +672,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
> +void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -706,6 +707,10 @@ static inline void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
>  {
>  }
>  
> +static inline void dw_pcie_ep_deinit_notify(struct dw_pcie_ep *ep)
> +{
> +}
> +
>  static inline void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
>  {
>  }
> -- 
> 2.45.1
> 

