Return-Path: <linux-pci+bounces-25923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F9A89EFF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 15:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F9B93A7D5B
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 13:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F217E2973C8;
	Tue, 15 Apr 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7D3iiNH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2D9296D3D
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 13:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722573; cv=none; b=EK72ZUwE45kPMhHQYT14zJWrjzcdnAWFp6eVKeJ6C0OUvliOibgMuC/8uEbpZYeykaY4BtDYz8UKxYSjvjTgJ+b8cpemM7UoWx//JbPupXM4jhcMPCuIFTU39N+/MXA8bUekyP1fb+KTK8JYUo0xOBVeQ2/v6jArHC7rKPZBS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722573; c=relaxed/simple;
	bh=YSi755J7PiWgkfw4SkqXLJ4BA/122IdosGJRyTjkRzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHPBYFNMPGp5Hg9LCUlEcvkpQup6XVQ/SvjCLydALLxKwBR4MNuJDONnf5GRCMiWDtgZ2oG0mqYZk5RQpz7kYbdb0ERrPoQMAR+nYPNZf5taomxA9c2fwDdOcw9IkbMS17JBopPSzDKurJJOuOfz7b0iQ5z6/v3xESJPUc+KS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7D3iiNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC43C4CEDD;
	Tue, 15 Apr 2025 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744722573;
	bh=YSi755J7PiWgkfw4SkqXLJ4BA/122IdosGJRyTjkRzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p7D3iiNH/rcqSexgGBQftBmw5fscld3c12sIdYn1t3WfDRR7iqaQDVRgEtJWyrZcl
	 DWpXpyRtP8RQi/4uqn+duXoBpTUMIgoF3wfefdADRi3SgZGZXS6rEK1KhUnba44xrB
	 fs4ZSY/csDLBBp278f8N+QffUvY1DuQHVyjQqzp0ulvY+BfCA5e1kBuhwztGjzzhOd
	 0eU0wYn2XaWwQOZdApIwM71ULeI6tC0SSq7rzsYTWeadPRCuxF+N53EB5YPTZ+jacC
	 cAoRZOLmJfDc7XhpQrCz9E0IFB/BdRe8CcrzhviZ0osonRw1QXOK5Oxjjv5qIWAPkm
	 9UvEjeBMmy5hg==
Date: Tue, 15 Apr 2025 15:09:29 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
Message-ID: <Z_5aib0WGKfIANj_@ryzen>
References: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>

On Fri, Apr 11, 2025 at 02:14:08PM +0800, Shawn Lin wrote:
> This patch adds system PM support for Rockchip platforms by adding .pme_turn_off
> and .get_ltssm hook and tries to reuse possible exist code.
> 
> It's tested on RK3576 EVB1 board with Some NVMes and PCIe-2-SATA/XHCI devices.
> And check the PCIe protocol analyzer to make sure the L2 process fits the spec.
> 
> [    1.541394] nvme nvme0: missing or invalid SUBNQN field.
> [    1.548755] nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
> [    1.562235] nvme nvme0: 8/0/0 default/read/poll queues
> [    1.563930] nvme nvme0: Ignoring bogus Namespace Identifiers
> 
> echo N > /sys/module/printk/parameters/console_suspend
> echo core > /sys/power/pm_test
> echo mem > /sys/power/state
> 
> [   58.443602] PM: suspend entry (deep)
> [   58.444005] Filesystems sync: 0.000 seconds
> [   58.445542] Freezing user space processes
> [   58.447096] Freezing user space processes completed (elapsed 0.001 seconds)
> [   58.447718] OOM killer disabled.
> [   58.448008] Freezing remaining freezable tasks
> [   58.449080] Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
> 
> ...
> 
> [   58.797070] rockchip-dw-pcie 22400000.pcie: PCIe Gen.2 x1 link up
> [   58.835953] OOM killer enabled.
> [   58.836262] Restarting tasks ... done.
> [   58.839241] random: crng reseeded on system resumption
> [   58.840679] PM: suspend exit
> [   59.500036] nvme nvme0: 8/0/0 default/read/poll queues
> [   59.500909] nvme nvme0: Ignoring bogus Namespace Identifiers
> 
> time dd if=/dev/nvme0n1 of=/dev/null bs=1M count=1000
> 1000+0 records in
> 1000+0 records out
> real    0m 5.51s
> user    0m 0.00s
> sys     0m 0.71s
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2:
> - Use NOIRQ_SYSTEM_SLEEP_PM_OPS
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 185 +++++++++++++++++++++++---
>  1 file changed, 169 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 56acfea..7246a49 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -21,6 +21,7 @@
>  #include <linux/regmap.h>
>  #include <linux/reset.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
>  /*
> @@ -37,8 +38,14 @@
>  #define PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
>  #define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
>  #define PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
> +#define PCIE_CLIENT_INTR_STATUS_MSG_RX	0x04
>  #define PCIE_CLIENT_INTR_STATUS_MISC	0x10
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> +#define PCIE_CLIENT_POWER		0x2c
> +#define PCIE_CLIENT_MSG_GEN		0x34
> +#define PME_READY_ENTER_L23		BIT(3)
> +#define PME_TURN_OFF			(BIT(4) | BIT(20))
> +#define PME_TO_ACK			(BIT(9) | BIT(25))
>  #define PCIE_SMLH_LINKUP		BIT(16)
>  #define PCIE_RDLH_LINKUP		BIT(17)
>  #define PCIE_LINKUP			(PCIE_SMLH_LINKUP | PCIE_RDLH_LINKUP)
> @@ -63,6 +70,7 @@ struct rockchip_pcie {
>  	struct gpio_desc *rst_gpio;
>  	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
> +	u32 intx;
>  	const struct rockchip_pcie_of_data *data;
>  };
>  
> @@ -159,6 +167,13 @@ static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
>  	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
>  }
>  
> +static u32 rockchip_pcie_get_pure_ltssm(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +	return rockchip_pcie_get_ltssm(rockchip) & PCIE_LTSSM_STATUS_MASK;
> +}
> +
>  static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>  {
>  	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> @@ -248,8 +263,46 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void rockchip_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	struct device *dev = rockchip->pci.dev;
> +	int ret;
> +	u32 status;
> +
> +	/* 1. Broadcast PME_Turn_Off Message, bit 4 self-clear once done */
> +	rockchip_pcie_writel_apb(rockchip, PME_TURN_OFF, PCIE_CLIENT_MSG_GEN);
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_MSG_GEN,
> +				 status, !(status & BIT(4)), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret) {
> +		dev_warn(dev, "Failed to send PME_Turn_Off\n");
> +		return;
> +	}
> +
> +	/* 2. Wait for PME_TO_Ack, bit 9 will be set once received */
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_INTR_STATUS_MSG_RX,
> +				 status, status & BIT(9), PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret) {
> +		dev_warn(dev, "Failed to receive PME_TO_Ack\n");
> +		return;
> +	}
> +
> +	/* 3. Clear PME_TO_Ack and Wait for ready to enter L23 message */
> +	rockchip_pcie_writel_apb(rockchip, PME_TO_ACK, PCIE_CLIENT_INTR_STATUS_MSG_RX);
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_POWER,
> +				 status, status & PME_READY_ENTER_L23,
> +				 PCIE_PME_TO_L2_TIMEOUT_US / 10,
> +				 PCIE_PME_TO_L2_TIMEOUT_US);
> +	if (ret)
> +		dev_err(dev, "Failed to get ready to enter L23 message\n");
> +}
> +
>  static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>  	.init = rockchip_pcie_host_init,
> +	.pme_turn_off = rockchip_pcie_pme_turn_off,
>  };
>  
>  /*
> @@ -430,6 +483,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = rockchip_pcie_link_up,
>  	.start_link = rockchip_pcie_start_link,
>  	.stop_link = rockchip_pcie_stop_link,
> +	.get_ltssm = rockchip_pcie_get_pure_ltssm,
>  };
>  
>  static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
> @@ -489,13 +543,32 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static void rockchip_pcie_ltssm_enable_control_mode(struct rockchip_pcie *rockchip, u32 mode)
> +{
> +	u32 val;
> +
> +	/* LTSSM enable control mode */
> +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +
> +	rockchip_pcie_writel_apb(rockchip, mode, PCIE_CLIENT_GENERAL_CONTROL);
> +}
> +
> +static void rockchip_pcie_unmask_dll_indicator(struct rockchip_pcie *rockchip)
> +{
> +	u32 val;
> +
> +	/* unmask DLL up/down indicator */
> +	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED, 0);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +}
> +
>  static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  				      struct rockchip_pcie *rockchip)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie_rp *pp;
>  	int irq, ret;
> -	u32 val;
>  
>  	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
>  		return -ENODEV;
> @@ -512,12 +585,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	/* LTSSM enable control mode */
> -	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> -
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
>  
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
> @@ -529,9 +597,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	/* unmask DLL up/down indicator */
> -	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED, 0);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);
>  
>  	return ret;
>  }
> @@ -558,12 +624,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	/* LTSSM enable control mode */
> -	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> -	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> -
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
> -				 PCIE_CLIENT_GENERAL_CONTROL);
> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_EP_MODE);
>  
>  	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
>  	rockchip->pci.ep.page_size = SZ_64K;
> @@ -677,6 +738,92 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	ret = dw_pcie_suspend_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "failed to suspend\n");
> +		return ret;
> +	}
> +
> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_resume(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	reset_control_assert(rockchip->rst);
> +
> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret) {
> +		dev_err(dev, "clock init failed\n");
> +		goto err_clk;
> +	}
> +
> +	if (rockchip->vpcie3v3) {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			goto err_power;
> +	}
> +
> +	ret = phy_init(rockchip->phy);
> +	if (ret) {
> +		dev_err(dev, "fail to init phy\n");
> +		goto err_phy_init;
> +	}
> +
> +	ret = phy_power_on(rockchip->phy);
> +	if (ret) {
> +		dev_err(dev, "fail to power on phy\n");
> +		goto err_phy_on;
> +	}
> +
> +	reset_control_deassert(rockchip->rst);
> +
> +	rockchip_pcie_writel_apb(rockchip, HIWORD_UPDATE(0xffff, rockchip->intx),
> +				 PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);

Here you are setting PCIE_CLIENT_RC_MODE unconditionally.

I really don't think that you have tested these callbacks with EP mode.

If we look at pcie-qcom.c and pcie-qcom-ep.c, dev_pm_ops is defined in
pcie-qcom.c, but not in pcie-qcom-ep.c.

Perhaps it is starting to be time to have two separate drivers also for
rockchip?


> +	rockchip_pcie_unmask_dll_indicator(rockchip);
> +
> +	ret = dw_pcie_resume_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "fail to resume\n");
> +		goto err_resume;
> +	}
> +
> +	return 0;
> +
> +err_resume:
> +	phy_power_off(rockchip->phy);
> +err_phy_on:
> +	phy_exit(rockchip->phy);
> +err_phy_init:
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +err_power:
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +err_clk:
> +	reset_control_deassert(rockchip->rst);
> +	return ret;
> +}
> +
>  static const struct rockchip_pcie_of_data rockchip_pcie_rc_of_data_rk3568 = {
>  	.mode = DW_PCIE_RC_TYPE,
>  };
> @@ -707,11 +854,17 @@ static const struct of_device_id rockchip_pcie_of_match[] = {
>  	{},
>  };
>  
> +static const struct dev_pm_ops rockchip_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(rockchip_pcie_suspend,
> +				  rockchip_pcie_resume)
> +};
> +
>  static struct platform_driver rockchip_pcie_driver = {
>  	.driver = {
>  		.name	= "rockchip-dw-pcie",
>  		.of_match_table = rockchip_pcie_of_match,
>  		.suppress_bind_attrs = true,
> +		.pm = &rockchip_pcie_pm_ops,
>  	},
>  	.probe = rockchip_pcie_probe,
>  };
> -- 
> 2.7.4
> 

