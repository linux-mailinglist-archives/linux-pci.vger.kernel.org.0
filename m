Return-Path: <linux-pci+bounces-4622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E52875992
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 22:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746AC1F21741
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 21:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B76013B79B;
	Thu,  7 Mar 2024 21:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpdBAuCn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACFB18B1B;
	Thu,  7 Mar 2024 21:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847811; cv=none; b=qH6BPWqTh9HvK7gyovzUCqdoHYs27tSwpJ8WWep9yNbbsi9ewwbFws4pgTQhcexf/tKfCQRQr0Bzipha4E+XY0frK9M36T4hqKM+hT8EEYJFPRGqMnFDsvQj3NBSexYQVs4/GWFGK99GfPNF7MLJdzNgnXc3vtm8wcItRguTj+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847811; c=relaxed/simple;
	bh=vU+8lR7+ImFBoMF2RNCtUGPZiZVDYC+eokbSchOhHxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZ9UMe2icXQu5ge7fc2NHbUxMJyhbdD/n62D3SI2P7ka5a4Zn8aNG7ME4YqMUqmqorjuawQTTj/W+C2TcDYaypzP1e7eQ9XZWGsyYtmzcniozZk4BNfAzceOKIQEIXGGTFXUyryI+U11ufL721SZlpis1oK4BlXEqsG2tPCxsPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpdBAuCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B14C433C7;
	Thu,  7 Mar 2024 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709847810;
	bh=vU+8lR7+ImFBoMF2RNCtUGPZiZVDYC+eokbSchOhHxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CpdBAuCnHEuX5dqOZmE914UXDbR1GFAvw9iSR04XvWUTZVsXUc7qKucuAPm/ZN9rZ
	 1xITN/T/tNhMU6Xi1y/hcfWowgvrWXYXBm4u/Tugs89Bujkw9P/j81qHX9HZqI/Z5R
	 zyLiDhResX89D3G3lVBrLo94yz4epDe5zJsAsGQErgmdjwHYB1Pa4hXwYRYNSmbCWb
	 i3gXxs1Sn0uHls1YhYWcbc641AXC2JlqA7NIN4MZ/5h/3KUuh17NnHlK9u2N+NxOQT
	 aWkVBswNRZ82LyzS1efl8QRASuilWoaMjceTqKqQRvwEacrDFvHAR61U8kD3liunMR
	 rv64PIpfSOwwQ==
Date: Thu, 7 Mar 2024 22:43:19 +0100
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
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v9 08/10] PCI: dwc: ep: Add a generic
 dw_pcie_ep_linkdown() API to handle LINK_DOWN event
Message-ID: <Zeo0996FscpDSnjL@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-8-29d433d99cda@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304-pci-dbi-rework-v9-8-29d433d99cda@linaro.org>

On Mon, Mar 04, 2024 at 02:52:20PM +0530, Manivannan Sadhasivam wrote:
> The PCIe link can go to LINK_DOWN state in one of the following scenarios:
> 
> 1. Fundamental (PERST#)/hot/warm reset
> 2. Link transition from L2/L3 to L0
> 
> In those cases, LINK_DOWN causes some non-sticky DWC registers to loose the
> state (like REBAR, PTM_CAP etc...). So the drivers need to reinitialize
> them to function properly once the link comes back again.
> 
> This is not a problem for drivers supporting PERST# IRQ, since they can
> reinitialize the registers in the PERST# IRQ callback. But for the drivers
> not supporting PERST#, there is no way they can reinitialize the registers
> other than relying on LINK_DOWN IRQ received when the link goes down. So
> let's add a DWC generic API dw_pcie_ep_linkdown() that reinitializes the
> non-sticky registers and also notifies the EPF drivers about link going
> down.
> 
> This API can also be used by the drivers supporting PERST# to handle the
> scenario (2) mentioned above.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 111 ++++++++++++++----------
>  drivers/pci/controller/dwc/pcie-designware.h    |   5 ++
>  2 files changed, 72 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 278bdc9b2269..fed4c2936c78 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -14,14 +14,6 @@
>  #include <linux/pci-epc.h>
>  #include <linux/pci-epf.h>
>  
> -void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> -{
> -	struct pci_epc *epc = ep->epc;
> -
> -	pci_epc_linkup(epc);
> -}
> -EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> -
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  {
>  	struct pci_epc *epc = ep->epc;
> @@ -603,19 +595,56 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  	return 0;
>  }
>  
> +static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
> +{
> +	unsigned int offset, ptm_cap_base;
> +	unsigned int nbars;
> +	u32 reg, i;
> +
> +	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> +	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
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

If you look at PCI_REBAR_CAP, you will see that it is sticky,
but you have to actually read the databook to see that:

"The RESBAR_CTRL_REG_BAR_SIZE field is automatically updated
when you write to RESBAR_CAP_REG_0_REG through the DBI."

So the reason why we need to write this register, even though
it is sticky, is to update the RESBAR_CTRL_REG_BAR_SIZE register,
which is not sticky :)

(Perhaps we should add that as a comment?)


> +	}
> +
> +	/*
> +	 * PTM responder capability can be disabled only after disabling
> +	 * PTM root capability.
> +	 */
> +	if (ptm_cap_base) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		reg &= ~PCI_PTM_CAP_ROOT;
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +
> +		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> +		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> +		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> +		dw_pcie_dbi_ro_wr_dis(pci);

From looking at the databook:
PCI_PTM_CAP_ROOT:
Note: This register field is sticky.

PCI_PTM_CAP_RES:
Note: This register field is sticky.

PCI_PTM_GRANULARITY_MASK:
Dbi: if (DBI_RO_WR_EN == 1) then R/W(sticky) else
R(sticky)

So all these register fields appear to be sticky to me.
So I would assume that the PTM related writes could be
done in dw_pcie_ep_init_registers().


> +	}
> +
> +	dw_pcie_setup(pci);
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct dw_pcie_ep_func *ep_func;
>  	struct device *dev = pci->dev;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int offset, ptm_cap_base;
> -	unsigned int nbars;
>  	u8 hdr_type;
>  	u8 func_no;
> -	int i, ret;
>  	void *addr;
> -	u32 reg;
> +	int ret;
>  
>  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
>  		   PCI_HEADER_TYPE_MASK;
> @@ -678,38 +707,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>  
> -	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
> -	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
> -
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
> -	/*
> -	 * PTM responder capability can be disabled only after disabling
> -	 * PTM root capability.
> -	 */
> -	if (ptm_cap_base) {
> -		dw_pcie_dbi_ro_wr_en(pci);
> -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> -		reg &= ~PCI_PTM_CAP_ROOT;
> -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> -
> -		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
> -		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
> -		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
> -		dw_pcie_dbi_ro_wr_dis(pci);
> -	}
> -
> -	dw_pcie_setup(pci);
> -	dw_pcie_dbi_ro_wr_dis(pci);
> +	dw_pcie_ep_init_non_sticky_registers(pci);
>  
>  	return 0;
>  
> @@ -720,6 +718,31 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
>  
> +void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
> +{
> +	struct pci_epc *epc = ep->epc;
> +
> +	pci_epc_linkup(epc);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
> +
> +void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct pci_epc *epc = ep->epc;
> +
> +	/*
> +	 * Initialize the non-sticky DWC registers as they would've reset post
> +	 * LINK_DOWN. This is specifically needed for drivers not supporting
> +	 * PERST# as they have no way to reinitialize the registers before the
> +	 * link comes back again.
> +	 */
> +	dw_pcie_ep_init_non_sticky_registers(pci);
> +
> +	pci_epc_linkdown(epc);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_linkdown);
> +
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f8e5431a207b..152969545b0a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -668,6 +668,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
>  
>  #ifdef CONFIG_PCIE_DW_EP
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
> +void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
> @@ -688,6 +689,10 @@ static inline void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  {
>  }
>  
> +static inline void dw_pcie_ep_linkdown(struct dw_pcie_ep *ep)
> +{
> +}
> +
>  static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	return 0;
> 
> -- 
> 2.25.1
> 

