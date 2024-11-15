Return-Path: <linux-pci+bounces-16947-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815D79CFACA
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 00:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F032816C7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E3419258E;
	Fri, 15 Nov 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtUXvgCI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C20718BBB0;
	Fri, 15 Nov 2024 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731711802; cv=none; b=MmAgF1D+EboZYcSPMmfcYJ0VDPzBJSBmDrURT+w1iVG1QePef7ZWTP53B8bICgG9OqWLnIgmJJdx3ravAxQzx5gg/ib6PWM/T0v8COiFkkhkJM0M7Lfrq81BO2aPrMN0Iv+/Gdadqbwk/BLlYoIb7wwjhIba4XEvkn3RQ3uivPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731711802; c=relaxed/simple;
	bh=1abEaMeNqs1nTcC6Bnle0nei4JVk7xvxjpBydnAXGF8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o2ypfMPSqYySLP4C/F5lf7BWTPjKZKDTkUCXNHujfy2vRriw8Ck5Us0i74BgoFnnfRAyxmwHY7zZsAQ6cIKZk831pfIZUJY3m4WuiEPmidef5ay9bzPPdIC44IJBG0Nes0TQoq6T0akg/Xf7TaKxF/F6pHMZDn0MEK755Dku1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtUXvgCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356A6C4CECF;
	Fri, 15 Nov 2024 23:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731711802;
	bh=1abEaMeNqs1nTcC6Bnle0nei4JVk7xvxjpBydnAXGF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gtUXvgCINF0mTjtnXygOjJEhez+Lbm0zTpv5BjzZQjI4GHmFz2+ArFQJPIBiPna5x
	 GYN9jHfNUZc9aeJUXvFZLjFOwoTkgIZb9XedMW/Jezgqjhi9H4g/YGe26PVls09/og
	 VzDJS/0t5pxFTc9qTxN95zEZddLbpfAaQJvdTBVXwTk1B+vwxRCX7l0vzsFXD0lHic
	 NVDHtrJmor+3AH8AggZvpRHEJCbrcHHosGhEx+PzPWETP2/xXGrYdYXkEsK5lI78pJ
	 g1l2/i6WcA+6VwQuSAMRTa2wqSCfFiobr3413WnwyY6sEqjtdJYw1yOCzKVTpjOoVu
	 Py32d5Ertc0MQ==
Date: Fri, 15 Nov 2024 17:03:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v5 12/14] PCI: rockchip-ep: Improve link training
Message-ID: <20241115230319.GA2065576@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017015849.190271-13-dlemoal@kernel.org>

On Thu, Oct 17, 2024 at 10:58:47AM +0900, Damien Le Moal wrote:
> The Rockchip RK3399 TRM V1.3 Part2, Section 17.5.8.1.2, step 7,
> describes the endpoint mode link training process clearly and states
> that:
>   Insure link training completion and success by observing link_st field
>   in PCIe Client BASIC_STATUS1 register change to 2'b11. If both side
>   support PCIe Gen2 speed, re-train can be Initiated by asserting the
>   Retrain Link field in Link Control and Status Register. The software
>   should insure the BASIC_STATUS0[negotiated_speed] changes to "1", that
>   indicates re-train to Gen2 successfully.

Since this only adds code and doesn't change existing code, I assume
this hardware doesn't automatically train to gen2 without this new
software assistance?

So the effect of this change is to use gen2 speed when supported by
both partners, when previously we only got gen1?

> This procedure is very similar to what is done for the root-port mode
> in rockchip_pcie_host_init_port().
> 
> Implement this link training procedure for the endpoint mode as well.
> Given that the RK3399 SoC does not have an interrupt signaling link
> status changes, training is implemented as a delayed work which is
> rescheduled until the link training completes or the endpoint controller
> is stopped. The link training work is first scheduled in
> rockchip_pcie_ep_start() when the endpoint function is started. Link
> training completion is signaled to the function using pci_epc_linkup().
> Accordingly, the linkup_notifier field of the rockchip pci_epc_features
> structure is changed to true.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  drivers/pci/controller/pcie-rockchip-ep.c | 82 ++++++++++++++++++++++-
>  drivers/pci/controller/pcie-rockchip.h    | 11 +++
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 2f7709ba1cac..43480706b8f4 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -10,12 +10,14 @@
>  
>  #include <linux/configfs.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/pci-epc.h>
>  #include <linux/platform_device.h>
>  #include <linux/pci-epf.h>
>  #include <linux/sizes.h>
> +#include <linux/workqueue.h>
>  
>  #include "pcie-rockchip.h"
>  
> @@ -48,6 +50,7 @@ struct rockchip_pcie_ep {
>  	u64			irq_pci_addr;
>  	u8			irq_pci_fn;
>  	u8			irq_pending;
> +	struct delayed_work	link_training;
>  };
>  
>  static void rockchip_pcie_clear_ep_ob_atu(struct rockchip_pcie *rockchip,
> @@ -470,6 +473,8 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
>  			    PCIE_CLIENT_CONF_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> +	schedule_delayed_work(&ep->link_training, 0);
> +
>  	return 0;
>  }
>  
> @@ -478,6 +483,8 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
>  	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct rockchip_pcie *rockchip = &ep->rockchip;
>  
> +	cancel_delayed_work_sync(&ep->link_training);
> +
>  	/* Stop link training and disable configuration */
>  	rockchip_pcie_write(rockchip,
>  			    PCIE_CLIENT_CONF_DISABLE |
> @@ -485,8 +492,80 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
>  			    PCIE_CLIENT_CONFIG);
>  }
>  
> +static void rockchip_pcie_ep_retrain_link(struct rockchip_pcie *rockchip)
> +{
> +	u32 status;
> +
> +	status = rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_LCS);
> +	status |= PCI_EXP_LNKCTL_RL;
> +	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_LCS);
> +}
> +
> +static bool rockchip_pcie_ep_link_up(struct rockchip_pcie *rockchip)
> +{
> +	u32 val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS1);
> +
> +	return PCIE_LINK_UP(val);
> +}
> +
> +static void rockchip_pcie_ep_link_training(struct work_struct *work)
> +{
> +	struct rockchip_pcie_ep *ep =
> +		container_of(work, struct rockchip_pcie_ep, link_training.work);
> +	struct rockchip_pcie *rockchip = &ep->rockchip;
> +	struct device *dev = rockchip->dev;
> +	u32 val;
> +	int ret;
> +
> +	/* Enable Gen1 training and wait for its completion */
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
> +				 val, PCIE_LINK_TRAINING_DONE(val), 50,
> +				 LINK_TRAIN_TIMEOUT);
> +	if (ret)
> +		goto again;
> +
> +	/* Make sure that the link is up */
> +	ret = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> +				 val, PCIE_LINK_UP(val), 50,
> +				 LINK_TRAIN_TIMEOUT);
> +	if (ret)
> +		goto again;
> +
> +	/*
> +	 * Check the current speed: if gen2 speed was requested and we are not
> +	 * at gen2 speed yet, retrain again for gen2.
> +	 */
> +	val = rockchip_pcie_read(rockchip, PCIE_CORE_CTRL);
> +	if (!PCIE_LINK_IS_GEN2(val) && rockchip->link_gen == 2) {
> +		/* Enable retrain for gen2 */
> +		rockchip_pcie_ep_retrain_link(rockchip);
> +		readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
> +				   val, PCIE_LINK_IS_GEN2(val), 50,
> +				   LINK_TRAIN_TIMEOUT);
> +	}
> +
> +	/* Check again that the link is up */
> +	if (!rockchip_pcie_ep_link_up(rockchip))
> +		goto again;
> +
> +	val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS0);
> +	dev_info(dev,
> +		 "Link UP (Negotiated speed: %sGT/s, width: x%lu)\n",
> +		 (val & PCIE_CLIENT_NEG_LINK_SPEED) ? "5" : "2.5",
> +		 ((val & PCIE_CLIENT_NEG_LINK_WIDTH_MASK) >>
> +		  PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT) << 1);
> +
> +	/* Notify the function */
> +	pci_epc_linkup(ep->epc);
> +
> +	return;
> +
> +again:
> +	schedule_delayed_work(&ep->link_training, msecs_to_jiffies(5));
> +}
> +
>  static const struct pci_epc_features rockchip_pcie_epc_features = {
> -	.linkup_notifier = false,
> +	.linkup_notifier = true,
>  	.msi_capable = true,
>  	.msix_capable = false,
>  	.align = ROCKCHIP_PCIE_AT_SIZE_ALIGN,
> @@ -644,6 +723,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
>  	rockchip = &ep->rockchip;
>  	rockchip->is_rc = false;
>  	rockchip->dev = dev;
> +	INIT_DELAYED_WORK(&ep->link_training, rockchip_pcie_ep_link_training);
>  
>  	epc = devm_pci_epc_create(dev, &rockchip_pcie_epc_ops);
>  	if (IS_ERR(epc)) {
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 0263f158ee8d..24796176f658 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -26,6 +26,7 @@
>  #define MAX_LANE_NUM			4
>  #define MAX_REGION_LIMIT		32
>  #define MIN_EP_APERTURE			28
> +#define LINK_TRAIN_TIMEOUT		(500 * USEC_PER_MSEC)
>  
>  #define PCIE_CLIENT_BASE		0x0
>  #define PCIE_CLIENT_CONFIG		(PCIE_CLIENT_BASE + 0x00)
> @@ -50,6 +51,10 @@
>  #define   PCIE_CLIENT_DEBUG_LTSSM_MASK		GENMASK(5, 0)
>  #define   PCIE_CLIENT_DEBUG_LTSSM_L1		0x18
>  #define   PCIE_CLIENT_DEBUG_LTSSM_L2		0x19
> +#define PCIE_CLIENT_BASIC_STATUS0	(PCIE_CLIENT_BASE + 0x44)
> +#define   PCIE_CLIENT_NEG_LINK_WIDTH_MASK	GENMASK(7, 6)
> +#define   PCIE_CLIENT_NEG_LINK_WIDTH_SHIFT	6
> +#define   PCIE_CLIENT_NEG_LINK_SPEED		BIT(5)
>  #define PCIE_CLIENT_BASIC_STATUS1	(PCIE_CLIENT_BASE + 0x48)
>  #define   PCIE_CLIENT_LINK_STATUS_UP		0x00300000
>  #define   PCIE_CLIENT_LINK_STATUS_MASK		0x00300000
> @@ -87,6 +92,8 @@
>  
>  #define PCIE_CORE_CTRL_MGMT_BASE	0x900000
>  #define PCIE_CORE_CTRL			(PCIE_CORE_CTRL_MGMT_BASE + 0x000)
> +#define   PCIE_CORE_PL_CONF_LS_MASK		0x00000001
> +#define   PCIE_CORE_PL_CONF_LS_READY		0x00000001
>  #define   PCIE_CORE_PL_CONF_SPEED_5G		0x00000008
>  #define   PCIE_CORE_PL_CONF_SPEED_MASK		0x00000018
>  #define   PCIE_CORE_PL_CONF_LANE_MASK		0x00000006
> @@ -144,6 +151,7 @@
>  #define PCIE_RC_CONFIG_BASE		0xa00000
>  #define PCIE_EP_CONFIG_BASE		0xa00000
>  #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
> +#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
>  #define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
>  #define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> @@ -155,6 +163,7 @@
>  #define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
>  #define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
>  #define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> +#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
>  #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
>  #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
>  #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
> @@ -192,6 +201,8 @@
>  #define ROCKCHIP_VENDOR_ID			0x1d87
>  #define PCIE_LINK_IS_L2(x) \
>  	(((x) & PCIE_CLIENT_DEBUG_LTSSM_MASK) == PCIE_CLIENT_DEBUG_LTSSM_L2)
> +#define PCIE_LINK_TRAINING_DONE(x) \
> +	(((x) & PCIE_CORE_PL_CONF_LS_MASK) == PCIE_CORE_PL_CONF_LS_READY)
>  #define PCIE_LINK_UP(x) \
>  	(((x) & PCIE_CLIENT_LINK_STATUS_MASK) == PCIE_CLIENT_LINK_STATUS_UP)
>  #define PCIE_LINK_IS_GEN2(x) \
> -- 
> 2.47.0
> 

