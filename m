Return-Path: <linux-pci+bounces-27032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7EEAA44B9
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A681C01854
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 08:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127421129C;
	Wed, 30 Apr 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBFir0Pu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8752C1EB19B;
	Wed, 30 Apr 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000213; cv=none; b=MWvaAUM+gtZ9zzEFqsPgHeBP+tp2NkGuMMoat4DZdJh8pd3EIiWdZ6Cl5vUGnFqvqDXiODjBF3atwXCIEeWJq9z5Ok7tQsl6QcaAs+8k9pghZ3f2WqH1CrHI0D8lTr1lI9IZeEdZYGW1wilDN4kMZ9c92FLNPYaWcAnWz2yzlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000213; c=relaxed/simple;
	bh=RlnABCF7WCe8RVLZReHP66Pa73bC8yt5d8eBUmJneKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMaKjwJVI0Cm6x3uyQUtQ14FM577qx61jMPmIqFW/ZLbN4GYq4ag1q7vmhofNr6ZzxthfY7Y2WJOebY249WmrPajIg+co/In+bYWqtILlcG77W+ytUyP1y1L+tkpsIVCa7VtKw9Bz4+UywVLfh08R0E0dT6DUS4jAkRVoDoGpnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBFir0Pu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA10CC4CEE9;
	Wed, 30 Apr 2025 08:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746000212;
	bh=RlnABCF7WCe8RVLZReHP66Pa73bC8yt5d8eBUmJneKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBFir0PumNtsyhRcyxswUYKkQFbxj4U9rU1ILc/gnLeWlVWvWv0AuFFR43w79q5nI
	 lC4XHCpPUuxLiQHZVitSfmKwA6wzrN51gkEOBiB68nyFedAw2890mXFFrv2N4plGkF
	 pgbSjCp3p7CloUXv9rEuHPCBg6Y3UTFTOvh5VIe67CAnVmKpZL94v1bv2zaoD/Ezy6
	 ITkdVoR9Ywz5gzKHONxvQ7XL+hLOnjuc4Kc8U3odszxuh2aAUl69V1msFUfo0iZZzJ
	 Xx7yB3KU9KZriVTBdH7We3SMz1tHsqQRzd6Y4QcIM81vRccWPu7/S7kMdzj46aRSHE
	 TNVSXGWOHcoyA==
Date: Wed, 30 Apr 2025 10:03:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH] PCI: dwc: Add support for slot reset on link down event
Message-ID: <aBHZT_mOruwH7HxJ@ryzen>
References: <20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430-b4-pci_dwc_reset_support-v1-1-f654abfa7925@wdc.com>

Hello Wilfred,

Nice to see this feature :)

On Wed, Apr 30, 2025 at 05:43:51PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> The PCIe link may go down in cases like firmware crashes or unstable
> connections. When this occurs, the PCIe slot must be reset to restore
> functionality. However, the current driver lacks link down handling,
> forcing users to reboot the system to recover.
> 
> This patch implements the `reset_slot` callback for link down handling
> for DWC PCIe host controller. In which, the RC is reset, reconfigured
> and link training initiated to recover from the link down event.
> 
> This patch by extension fixes issues with sysfs initiated bus resets.
> In that, currently, when a sysfs initiated bus reset is issued, the
> endpoint device is non-functional after (may link up with downgraded link
> status). With this patch adding support for link down recovery, a sysfs
> initiated bus reset works as intended. Testing conducted on a ROCK5B board
> with an M.2 NVMe drive.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---
> Hey all,
> 
> This patch builds ontop of [1] to extend the reset slot support for the
> DWC PCIe host controller. Which implements link down recovery support
> for the DesignWare PCIe host controller by adding a `reset_slot` callback.
> This allows the system to recover from PCIe link failures without requiring a reboot.
> 
> This patch by extension improves the behavior of sysfs-initiated bus resets.
> Previously, a `reset` issued via sysfs could leave the endpoint in a
> non-functional state or with downgraded link parameters. With the added
> link down recovery logic, sysfs resets now result in a properly reinitialized
> and fully functional endpoint device. This issue was discovered on a
> Rock5B board, and thus testing was also conducted on the same platform
> with a known good M.2 NVMe drive.
> 
> Thanks!
> 
> [1] https://lore.kernel.org/all/20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org/
> ---
>  drivers/pci/controller/dwc/Kconfig            |  1 +
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 89 ++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..878c52de0842e32ca50dfcc4b66231a73ef436c4 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -347,6 +347,7 @@ config PCIE_ROCKCHIP_DW_HOST
>  	depends on OF
>  	select PCIE_DW_HOST
>  	select PCIE_ROCKCHIP_DW
> +	select PCI_HOST_COMMON
>  	help
>  	  Enables support for the DesignWare PCIe controller in the
>  	  Rockchip SoC (except RK3399) to work in host mode.
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3c6ab71c996ec1246954f52a9454c8ae67956a54..4c2c683d170f19266e1dfe0efde76d6feb23bf7a 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -23,6 +23,8 @@
>  #include <linux/reset.h>
>  
>  #include "pcie-designware.h"
> +#include "../../pci.h"
> +#include "../pci-host-common.h"
>  
>  /*
>   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> @@ -83,6 +85,9 @@ struct rockchip_pcie_of_data {
>  	const struct pci_epc_features *epc_features;
>  };
>  
> +static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
> +				       struct pci_dev *pdev);
> +
>  static int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip, u32 reg)
>  {
>  	return readl_relaxed(rockchip->apb_base + reg);
> @@ -256,6 +261,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  					 rockchip);
>  
>  	rockchip_pcie_enable_l0s(pci);
> +	pp->bridge->reset_slot = rockchip_pcie_rc_reset_slot;
>  
>  	return 0;
>  }
> @@ -455,6 +461,11 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
>  	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
>  	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
>  
> +	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> +		dev_dbg(dev, "hot reset or link-down reset\n");
> +		pci_host_handle_link_down(pp->bridge);
> +	}
> +
>  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
>  		if (rockchip_pcie_link_up(pci)) {
>  			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> @@ -536,8 +547,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	/* unmask DLL up/down indicator */
> -	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED, 0);
> +	/* unmask DLL up/down indicator and hot reset/link-down reset irq */
> +	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
>  
>  	return ret;
> @@ -688,6 +699,80 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int rockchip_pcie_rc_reset_slot(struct pci_host_bridge *bridge,
> +				  struct pci_dev *pdev)
> +{
> +	struct pci_bus *bus = bridge->bus;
> +	struct dw_pcie_rp *pp = bus->sysdata;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	struct device *dev = rockchip->pci.dev;
> +	u32 val;
> +	int ret;
> +
> +	dw_pcie_stop_link(pci);
> +	rockchip_pcie_phy_deinit(rockchip);
> +
> +	ret = reset_control_assert(rockchip->rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = rockchip_pcie_phy_init(rockchip);
> +	if (ret)
> +		goto disable_regulator;
> +
> +	ret = reset_control_deassert(rockchip->rst);
> +	if (ret)
> +		goto deinit_phy;
> +
> +	ret = rockchip_pcie_clk_init(rockchip);
> +	if (ret)
> +		goto deinit_phy;

Here you call rockchip_pcie_clk_init(), but I don't see that we ever called
clk_bulk_disable_unprepare() after stopping the link. I would have expected
the clk framework to have given us a warning about enabling clocks that are
already enabled.


> +
> +	ret = pp->ops->init(pp);
> +	if (ret) {
> +		dev_err(dev, "Host init failed: %d\n", ret);
> +		goto deinit_clk;
> +	}
> +
> +	/* LTSSM enable control mode */
> +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE, PCIE_CLIENT_GENERAL_CON);
> +
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to setup RC: %d\n", ret);
> +		goto deinit_clk;
> +	}
> +
> +	/* unmask DLL up/down indicator and hot reset/link-down reset irq */
> +	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +
> +	ret = dw_pcie_start_link(pci);
> +	if (ret)
> +		return ret;

Here you are simply returning ret in case of error,
should we perhaps goto error if this function fails?


> +
> +	ret = dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		return ret;

Here, I think that we should simply call dw_pcie_wait_for_link()
without checking for error.

1) That is what Mani does in the qcom patch that implements the
reset_slot() callback.
2) That is what we do in:
https://github.com/torvalds/linux/blob/master/drivers/pci/controller/dwc/pcie-designware-host.c#L558-L559

(Ignore errors, the link may come up later)


Kind regards,
Niklas

