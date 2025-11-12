Return-Path: <linux-pci+bounces-40947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D1C50520
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 03:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD8AE4E59EF
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 02:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBA63594A;
	Wed, 12 Nov 2025 02:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="DNa5Gs7k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m1973173.qiye.163.com (mail-m1973173.qiye.163.com [220.197.31.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCD3A944;
	Wed, 12 Nov 2025 02:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913969; cv=none; b=TnLk++38gxOS/Lzj0eKi94DMGcd7HgDJwAA+Pv/fqenPAeahznte+ePmcEsKH+7g2/e/jBHnSAH19TWV77g6lORuuEAKSxkJwegKqkh2+ELWAH8N4cN7UB1d/odxfPCjFtY67PLXTpakU88KqNyNBk2bHb9qJbrBBJ34BcLS/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913969; c=relaxed/simple;
	bh=zrv4BQuAkbeUDpzcVRThVXvibXJv+pWYHlspRCkMfOk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OVbvxen98DtEU8iJlEeckFE7oTKS7FoHlthO/mQKn8HaZz6AdWtmVVnePD+JReMrDWBMVUo3dm9fdMJPkvzh/ViJqDiN3T5zWpenV1LxSrqmxLVzHrf98vNZWHkg++MaoQIwBU6hfz78E0eFq+Y9RJMc6y8LSl+o1EQ0Nf+MPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=DNa5Gs7k; arc=none smtp.client-ip=220.197.31.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.61.151] (unknown [110.83.51.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 293fd660a;
	Wed, 12 Nov 2025 09:03:42 +0800 (GMT+08:00)
Message-ID: <79a8c3cc-2b60-4bce-b1ba-7ab5f033f924@rock-chips.com>
Date: Wed, 12 Nov 2025 09:03:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
 Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Hans Zhang <hans.zhang@cixtech.com>,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 kernel@pengutronix.de, Bjorn Helgaas <bhelgaas@google.com>,
 Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH 1/4] PCI: dwc: Advertise L1 PM Substates only if driver
 requests it
To: Bjorn Helgaas <helgaas@kernel.org>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-2-helgaas@kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251111221621.2208606-2-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a759702a009cckunm68f60faf90264
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUNNVkxJSRoZGR5KTRoaHlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSktVQ0hVTkpVSVlXWRYaDxIVHRRZQVlPS0hVSktISkpCTVVKS0tVSk
	JZBg++
DKIM-Signature: a=rsa-sha256;
	b=DNa5Gs7krwEhPUprrj/3XgxdSRjNLBnw+qN8B4C1vhJlTX/vfffYkqXOnhtb/6isIcgYPxadD7Z2X5DoSALMwp3BimgGwfur5wMUdCPUpgAhoDNn1bx0HLtK5uyLXSstW6gi7Ky7ThJ0IqZ6g1wO8KJqM501+F+nkx1fxrx3axo=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=X0Bnr2iJChPdZ80UCVLiI+51ilZQPsF7USzqD4IyGeA=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/12 星期三 6:16, Bjorn Helgaas 写道:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> L1 PM Substates require the CLKREF# signal and may also require
> device-specific support.  If CLKREF# is not supported or driver support is
> lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> e.g.,
> 
>    nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> 
> If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> enable L1.x via sysfs, users may trip over these errors even if L1
> Substates haven't been enabled by firmware or the driver.
> 
> To prevent such errors, disable advertising the L1 PM Substates unless the
> driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREF# is
> present and any device-specific configuration has been done.
> 
> Set "dw_pcie.l1ss_support" in tegra194 (if DT includes the
> "supports-clkreq' property) and qcom (for 2.7.0 controllers) so they can
> continue to use L1 Substates.
> 
> Based on Niklas's patch:
> https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org


Except the issue Fank pointed out, the commit msg says CLKREF# 3 times
which seems not a term from spec. Should it be CLKREQ# ?

Otherwise,
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   .../pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>   .../pci/controller/dwc/pcie-designware-host.c |  2 ++
>   drivers/pci/controller/dwc/pcie-designware.c  | 24 +++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-designware.h  |  2 ++
>   drivers/pci/controller/dwc/pcie-qcom.c        |  2 ++
>   drivers/pci/controller/dwc/pcie-tegra194.c    |  3 +++
>   6 files changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7f2112c2fb21..c94cff6eeb01 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -966,6 +966,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
>   	if (ep->ops->init)
>   		ep->ops->init(ep);
>   
> +	dw_pcie_config_l1ss(pci);
> +
>   	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>   
>   	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..f1d5b45a3214 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1060,6 +1060,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>   		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>   	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>   
> +	dw_pcie_config_l1ss(pci);
> +
>   	dw_pcie_config_presets(pp);
>   	/*
>   	 * If the platform provides its own child bus config accesses, it means
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c644216995f6..ede686623fad 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1081,6 +1081,30 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
>   	dw_edma_remove(&pci->edma);
>   }
>   
> +void dw_pcie_config_l1ss(struct dw_pcie *pci)
> +{
> +	u16 l1ss;
> +	u32 l1ss_cap;
> +
> +	if (!pci->l1ss_support)
> +		return;
> +
> +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	/*
> +	 * Unless the driver claims "l1ss_support", don't advertise L1 PM
> +	 * Substates because they require CLKREF# and possibly other
> +	 * device-specific configuration.
> +	 */
> +	l1ss_cap = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +	l1ss_cap &= ~(PCI_L1SS_CAP_PCIPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_1 |
> +		      PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2 |
> +		      PCI_L1SS_CAP_L1_PM_SS);
> +	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
> +}
> +
>   void dw_pcie_setup(struct dw_pcie *pci)
>   {
>   	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..8d14b1fe2280 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -516,6 +516,7 @@ struct dw_pcie {
>   	int			max_link_speed;
>   	u8			n_fts[2];
>   	struct dw_edma_chip	edma;
> +	bool			l1ss_support;	/* L1 PM Substates support */
>   	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>   	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
>   	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> @@ -573,6 +574,7 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>   				int type, u64 parent_bus_addr,
>   				u8 bar, size_t size);
>   void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
> +void dw_pcie_config_l1ss(struct dw_pcie *pci);
>   void dw_pcie_setup(struct dw_pcie *pci);
>   void dw_pcie_iatu_detect(struct dw_pcie *pci);
>   int dw_pcie_edma_detect(struct dw_pcie *pci);
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eb..61c2f4e2f74d 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1067,6 +1067,8 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>   	val &= ~REQ_NOT_ENTR_L1;
>   	writel(val, pcie->parf + PARF_PM_CTRL);
>   
> +	pci->l1ss_support = true;
> +
>   	val = readl(pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>   	val |= EN;
>   	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 10e74458e667..3934757baa30 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -703,6 +703,9 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
>   	val |= (pcie->aspm_pwr_on_t << 19);
>   	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
>   
> +	if (pcie->supports_clkreq)
> +		pci->l1ss_support = true;
> +
>   	/* Program L0s and L1 entrance latencies */
>   	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
>   	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;


