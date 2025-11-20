Return-Path: <linux-pci+bounces-41740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 537EEC72A16
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13DFB4E14FE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 07:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0383B280CC1;
	Thu, 20 Nov 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMrcTNFH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED73BA3D;
	Thu, 20 Nov 2025 07:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624482; cv=none; b=f0KFeECqDq5G76RU7bMDYfyAGzBK4oopO+S8RokoVRWJz2I8z/tkukrLy1Nh3dmDETgIBQywRRWOmSwE49uum6n3DDURhyGg0ugUXemvQiu+kL8kmlXJTCs4XC1Ipn3S1jCUNZEvZhFCKv5gx+bnqm1byvrPFlzxf+Eztio7Fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624482; c=relaxed/simple;
	bh=s9dFpDNhVJQOy00WDtmsNR9CXrYTRFP8sz932cIG1aY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6sbywCMAP8K4FxbIBiMATRkXCYuK/9fcmqiNflX92dsFlU4i/EOlsXwmCJ9uFtWRoEhb3XC3ROTuAShzGx24f9TRxRH/KqjB9MBf+eMDwkNgHlvTZcsfFqwNXH6IiYIvJbCr3qz/oMNuAhMG8+v1o/+BGyRU2BGEIOjvS+CG44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMrcTNFH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DDCC4CEF1;
	Thu, 20 Nov 2025 07:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763624482;
	bh=s9dFpDNhVJQOy00WDtmsNR9CXrYTRFP8sz932cIG1aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TMrcTNFHGZtRNuGiIozkxcwibujm3U9xXXg/AE+7gjTQaU+VKjF/wvqdadwJndSWO
	 jeW8GTYT7YWqWl/pyE9J4dYaXgnhYfzSOT7vsEO2q5jevy1Sls7k2UOW1lpdo+fzr5
	 FgNP/aDRO7yyfKgP6joo8TK3CnLsfUqzr0XXe8qoAJ65e6HOYokd+XjBY6kmwwTvKr
	 xNWqGc03UfyRkUoVoLAXWQS7WqBFyfVa7EE0Nimnmf8Dq6Mu+GEBBBno71bU5cwxcw
	 g0OXsebepCgPNL8ae8nrlhvbZbo+v6jc1Y3Nlm8OBRT6vCr2X0tR7JXiuqJg9kYdWe
	 k1/WLNivuXmqA==
Date: Thu, 20 Nov 2025 13:10:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, kernel@pengutronix.de, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <wja7vxtg7bqq2udepl5r3mvgg5swvuqtuzk6cnimgcbw2aegqs@hru6yzg4xx3o>
References: <20251118214312.2598220-1-helgaas@kernel.org>
 <20251118214312.2598220-2-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251118214312.2598220-2-helgaas@kernel.org>

On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> L1 PM Substates require the CLKREQ# signal and may also require
> device-specific support.  If CLKREQ# is not supported or driver support is
> lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> e.g.,
> 
>   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> 
> If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> enable L1.x via sysfs, users may trip over these errors even if L1
> Substates haven't been enabled by firmware or the driver.
> 
> To prevent such errors, disable advertising the L1 PM Substates unless the
> driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> present and any device-specific configuration has been done.
> 

Going by this reasoning, why can't we enable L1 PM Substates for these platforms
by default?

- Mani

> Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> "supports-clkreq' property) and qcom (for cfg_2_7_0, cfg_1_9_0, cfg_1_34_0,
> and cfg_sc8280xp controllers) so they can continue to use L1 Substates.
> 
> Based on Niklas's patch:
> https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
>  drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
>  6 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7f2112c2fb21..ad6c0fd67a65 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>  	if (ep->ops->init)
>  		ep->ops->init(ep);
>  
> +	dw_pcie_hide_unsupported_l1ss(pci);
> +
>  	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>  
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..7abeb771e32d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>  
> +	dw_pcie_hide_unsupported_l1ss(pci);
> +
>  	dw_pcie_config_presets(pp);
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f6..6e6a0dac5b53 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1081,6 +1081,30 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
>  	dw_edma_remove(&pci->edma);
>  }
>  
> +void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci)
> +{
> +	u16 l1ss;
> +	u32 l1ss_cap;
> +
> +	if (pci->l1ss_support)
> +		return;
> +
> +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	/*
> +	 * Unless the driver claims "l1ss_support", don't advertise L1 PM
> +	 * Substates because they require CLKREQ# and possibly other
> +	 * device-specific configuration.
> +	 */
> +	l1ss_cap = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +	l1ss_cap &= ~(PCI_L1SS_CAP_PCIPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_1 |
> +		      PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2 |
> +		      PCI_L1SS_CAP_L1_PM_SS);
> +	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
> +}
> +
>  void dw_pcie_setup(struct dw_pcie *pci)
>  {
>  	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..a68eea47d451 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -516,6 +516,7 @@ struct dw_pcie {
>  	int			max_link_speed;
>  	u8			n_fts[2];
>  	struct dw_edma_chip	edma;
> +	bool			l1ss_support;	/* L1 PM Substates support */
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
>  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> @@ -573,6 +574,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  				int type, u64 parent_bus_addr,
>  				u8 bar, size_t size);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> +void dw_pcie_hide_unsupported_l1ss(struct dw_pcie *pci);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eb..61c2f4e2f74d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1067,6 +1067,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  	val &= ~REQ_NOT_ENTR_L1;
>  	writel(val, pcie->parf + PARF_PM_CTRL);
>  
> +	pci->l1ss_support = true;
> +
>  	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>  	val |= EN;
>  	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 10e74458e667..3934757baa30 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -703,6 +703,9 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>  	val |= (pcie->aspm_pwr_on_t << 19);
>  	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
>  
> +	if (pcie->supports_clkreq)
> +		pci->l1ss_support = true;
> +
>  	/* Program L0s and L1 entrance latencies */
>  	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>  	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

