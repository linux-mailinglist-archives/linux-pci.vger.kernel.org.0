Return-Path: <linux-pci+bounces-4989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF07886AEB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 12:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF0D282DAA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9DD3D3B3;
	Fri, 22 Mar 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4ckqewB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61675224F2;
	Fri, 22 Mar 2024 11:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105383; cv=none; b=d8su0AtwvaoFPERPXMKS9kXYGAjhYTi/9vN9Vc0vEXpVjmOrFYBbjp/4A/qGlfiUWXU/AwhK/xAFUUxWY69dNB72bw3n36oHPo8ALjmlYuoJB0UMWds2I4JImg0igUuoRdohdMKp7CdQaAHgBDg6yuUnK3DpCLKWKj8SaR0pQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105383; c=relaxed/simple;
	bh=WsbM9stLTz0gL0GOHFlF/YCyiZmnN4jgDBnbkyHIq0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwkpTSC9c0bM2B9SEMrUNhZoxezxhIhCJLe6EfFksqqZMSa3aX4nazwHkACAKXfbqVSjTlBDsaU3dFgxfAZETlUQymRAvA7hVZ08B1PIil1vmddQAcofYyLHuMXvPCHb1eUHpT/gIr3i1OrrRXuDkyErT/zXayggkd8xRh9k4to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4ckqewB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36BCDC433F1;
	Fri, 22 Mar 2024 11:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711105382;
	bh=WsbM9stLTz0gL0GOHFlF/YCyiZmnN4jgDBnbkyHIq0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4ckqewBH76V+0hrF68Z5sCm2Mh2IosC4lNTk1Bxs/eM15Y6uJMszItaB/jcXJeZq
	 M1k3DINp7ns5+lW1PQl0rnLOWNpcVW7vtLFNO/SKA7PS782wnzSIJpM7ZHmpYnu41X
	 CrDz4+TCxCJ9lrgb3XPDsUoiZjq1Bbvrn20BkyLDwwH7C+bLprZsciVDMQDdMT3Idk
	 Zny8Hrdgi7DxJIQDzHKbiU2v6wPPvRieSL7FgcFcI9jGWDblfwt0Jc32QArE5ldZKJ
	 rxF7DuOPZjMOXPWHmNIpA0ptxhRIJi2X+/iUZGZRTQEljYjaQgZAPBk1QwyX/ZRPMz
	 5P79cUjNOAbnA==
Date: Fri, 22 Mar 2024 12:02:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v10 2/8] PCI: dwc: ep: Add Kernel-doc comments for APIs
Message-ID: <Zf1lXBUPhJ3xkV-E@ryzen>
References: <20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org>
 <20240314-pci-dbi-rework-v10-2-14a45c5a938e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-dbi-rework-v10-2-14a45c5a938e@linaro.org>

On Thu, Mar 14, 2024 at 01:18:00PM +0530, Manivannan Sadhasivam wrote:
> All of the APIs are missing the Kernel-doc comments. Hence, add them.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 78 +++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index c05304eabb89..d7e8f2dda6ce 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -14,6 +14,10 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  
> +/**
> + * dw_pcie_ep_linkup - Notify EPF drivers about link up event
> + * @ep: DWC EP device
> + */
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc = ep->epc;
> @@ -22,6 +26,11 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
>  
> +/**
> + * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization
> + *			    complete

Nit: "complete" can be on previous line without exceeding 80 chars.


> + * @ep: DWC EP device
> + */
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc = ep->epc;
> @@ -30,6 +39,14 @@ void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
>  
> +/**
> + * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
> + *				 the endpoint function
> + * @ep: DWC EP device
> + * @func_no: Function number of the endpoint device
> + *
> + * Return: struct dw_pcie_ep_func if success, NULL otherwise.
> + */
>  struct dw_pcie_ep_func *
>  dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
>  {
> @@ -60,6 +77,11 @@ static void __dw_pcie_ep_reset_bar(struct dw_pcie *pci, u8 func_no,
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  }
>  
> +/**
> + * dw_pcie_ep_reset_bar - Reset endpoint BAR
> + * @pci: DWC PCI device
> + * @bar: BAR number of the endpoint
> + */
>  void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
>  {
>  	u8 func_no, funcs;
> @@ -439,6 +461,13 @@ static const struct pci_epc_ops epc_ops = {
>  	.get_features		= dw_pcie_ep_get_features,
>  };
>  
> +/**
> + * dw_pcie_ep_raise_intx_irq - Raise INTx IRQ to the host
> + * @ep: DWC EP device
> + * @func_no: Function number of the endpoint
> + *
> + * Return: 0 if success, errono otherwise.
> + */
>  int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -450,6 +479,14 @@ int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_intx_irq);
>  
> +/**
> + * dw_pcie_ep_raise_msi_irq - Raise MSI IRQ to the host
> + * @ep: DWC EP device
> + * @func_no: Function number of the endpoint
> + * @interrupt_num: Interrupt number to be raised
> + *
> + * Return: 0 if success, errono otherwise.
> + */
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			     u8 interrupt_num)
>  {
> @@ -498,6 +535,15 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msi_irq);
>  
> +/**
> + * dw_pcie_ep_raise_msix_irq_doorbell - Raise MSIX to the host using Doorbell

Nit: s/MSIX/MSI-X/


> + *					method
> + * @ep: DWC EP device
> + * @func_no: Function number of the endpoint device
> + * @interrupt_num: Interrupt number to be raised
> + *
> + * Return: 0 if success, errno otherwise.
> + */
>  int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
>  				       u16 interrupt_num)
>  {
> @@ -517,6 +563,14 @@ int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +/**
> + * dw_pcie_ep_raise_msix_irq - Raise MSIX to the host

Nit: s/MSIX/MSI-X/


> + * @ep: DWC EP device
> + * @func_no: Function number of the endpoint device
> + * @interrupt_num: Interrupt number to be raised
> + *
> + * Return: 0 if success, errno otherwise.
> + */
>  int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  			      u16 interrupt_num)
>  {
> @@ -564,6 +618,13 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	return 0;
>  }
>  
> +/**
> + * dw_pcie_ep_exit - Deinitialize the endpoint device
> + * @ep: DWC EP device
> + *
> + * Deinitialize the endpoint device. EPC device is not destroyed since that will
> + * taken care by Devres.

Nit: s/will/will be/


> + */
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -599,6 +660,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  	return 0;
>  }
>  
> +/**
> + * dw_pcie_ep_init_complete - Complete DWC EP initialization
> + * @ep: DWC EP device
> + *
> + * Complete the initialization of the registers (CSRs) specific to DWC EP. This
> + * API should be called only when the endpoint receives an active refclk (either
> + * from host or generated locally).
> + */
>  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -716,6 +785,15 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>  
> +/**
> + * dw_pcie_ep_init - Initialize the endpoint device
> + * @ep: DWC EP device
> + *
> + * Initialize the endpoint device. Allocate resources and create the EPC
> + * device with the endpoint framework.
> + *
> + * Return: 0 if success, errno otherwise.
> + */
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> 
> -- 
> 2.25.1
> 

With nits fixed:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

