Return-Path: <linux-pci+bounces-26398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75603A96CFC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C3E401085
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C47C28C5CF;
	Tue, 22 Apr 2025 13:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+be2En9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7928C5CD
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328740; cv=none; b=s3eCxf6yY//ti1+fnlKw7r4hv7ztGIkYU9haQnHJxtbZw+7SE8beZ6kyer4mSJ+XbDjpXKzM36CdLAAiZZ7lOimUO9KYNvrv3gG7Eu65NjkBGZ7QCn0PMgqeAXkAVIS2WHMuOiP3lKzQJc/3Yad+KdkHhcl2/KnxgOSxWkZliJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328740; c=relaxed/simple;
	bh=yb0bAORIiJV71zHJh5Astf8trLHOdf6SdioMB+y2Z44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8KqMdX4WslGw0CiJ5ceP/g0ULUieooBBy8krrP/Z6Hh0b2cc2eut6HyYStelbQ1i1nXzim/PJZlRprYaKfZVqfvlzz1s4Q2kZQHZWOvO6SoG/ESnVtFe5iRHA9oMg71NYsE2w2pH5RMXkM9rwbFH7vBWm25TWSDVaILcCkc5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+be2En9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73D4C4AF0C;
	Tue, 22 Apr 2025 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745328740;
	bh=yb0bAORIiJV71zHJh5Astf8trLHOdf6SdioMB+y2Z44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+be2En9uZtGGwAE/3/GvDniOktIAwv5IBDddIokOKYRePLNoAUt+nCB8JjYf52Le
	 oqATAiP7UkyweYT6+Zki9SGjz8kJ217QsKOIpCJULfh+7+94QbD2wkkzen7jA76M+W
	 AiX3HRu4mhtF9+oXpM/ue9/IoUu4ErLV+YQi47PkqhzuWpIM6vQh0HHbmB1tw3If4P
	 w2TFQIf1oI8QiS34fb/sliddYuY9RtVFXEbJnMegP6D8AclNfK3YfRkvwW+SPBQld3
	 ifF90vkJ6twHLWkAppbYFaFXGgII4bTyHFndmAbtQFHRC00E+Kk6WdIX9ZU3jagKj/
	 KgnjqJI3P5iaA==
Date: Tue, 22 Apr 2025 15:32:16 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add system PM support
Message-ID: <aAeaYDJzatvbVC2Q@ryzen>
References: <1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1744940759-23823-1-git-send-email-shawn.lin@rock-chips.com>

Hello Shawn,

On Fri, Apr 18, 2025 at 09:45:59AM +0800, Shawn Lin wrote:
> This patch adds system PM support for Rockchip platforms by adding
> .pme_turn_off and .get_ltssm hook and tries to reuse possible existing
> code.
> 
> It's tested on RK3576 EVB1 board with Some NVMes and PCIe-2-SATA/XHCI
> devices. And check the PCIe protocol analyzer to make sure the L2 process
> fits the spec.
> 
>   nvme nvme0: missing or invalid SUBNQN field.
>   nvme nvme0: allocated 64 MiB host memory buffer (16 segments).
>   nvme nvme0: 8/0/0 default/read/poll queues
>   nvme nvme0: Ignoring bogus Namespace Identifiers
> 
>   echo N > /sys/module/printk/parameters/console_suspend
>   echo core > /sys/power/pm_test
>   echo mem > /sys/power/state
> 
>   PM: suspend entry (deep)
>   Filesystems sync: 0.000 seconds
>   Freezing user space processes
>   Freezing user space processes completed (elapsed 0.001 seconds)
>   OOM killer disabled.
>   Freezing remaining freezable tasks
>   Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
> 
>   ...
> 
>   rockchip-dw-pcie 22400000.pcie: PCIe Gen.2 x1 link up
>   OOM killer enabled.
>   Restarting tasks ... done.
>   random: crng reseeded on system resumption
>   PM: suspend exit
>   nvme nvme0: 8/0/0 default/read/poll queues
>   nvme nvme0: Ignoring bogus Namespace Identifiers
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3:
> - amend the commit msg suggested by Bjorn
> - reuse more code suggested by Diederik
> - bail out EP case suggested by Niklas
> 
> Changes in v2:
> - Use NOIRQ_SYSTEM_SLEEP_PM_OPS
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 197 +++++++++++++++++++++++---
>  1 file changed, 177 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 56acfea..4bcd4006 100644
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

The name rockchip_pcie_get_pure_ltssm() is quite confusing.

I think what makes most sense is that:

The current rockchip_pcie_get_ltssm() function is renamed to something like:
rockchip_pcie_get_ltssm_status_reg()
or
rockchip_pcie_get_ltssm_status_reg_raw()

Since some of the users of this function want the some other bits in the
ltssm_status register, that is not the LTSSM state itself.

(This can be done in patch 1/4.)


The new callback / function pointer, .get_ltssm(), is initialized to a
function called:
rockchip_pcie_get_ltssm()
or
rockchip_pcie_get_ltssm_state()

(This can be done in the patch that adds suspend/resume itself (patch 4/4).)


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
> @@ -404,10 +457,12 @@ static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>  	struct device *dev = rockchip->pci.dev;
>  	int ret;
>  
> -	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> -	if (IS_ERR(rockchip->phy))
> -		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> -				     "missing PHY\n");
> +	if (!rockchip->phy) {
> +		rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +		if (IS_ERR(rockchip->phy))
> +			return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> +					     "missing PHY\n");
> +	}
>  
>  	ret = phy_init(rockchip->phy);
>  	if (ret < 0)
> @@ -430,6 +485,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = rockchip_pcie_link_up,
>  	.start_link = rockchip_pcie_start_link,
>  	.stop_link = rockchip_pcie_stop_link,
> +	.get_ltssm = rockchip_pcie_get_pure_ltssm,
>  };
>  
>  static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
> @@ -489,13 +545,32 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
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

I think that the name of this function is misleading.

The comment:
/* LTSSM enable control mode */

represents:
the field app_ltssm_enable_enhance

i.e. step 9) in the TRM:
"Set the app_ltssm_enable_enhance to enable enhance control mode of
app_ltssm_enable"

See also:
"app_ltssm_enable_enhance is a new way to control the glue behavior of the
app_ltssm_enable. It’s advised set app_ltssm_enable_enhance to “1” when the
version >= 0x50600. The mechanisms of delaying the Hot reset are available
only in app_ltssm_enable_enhance mode."


So I think it is a bit confusing that this new function: rockchip_pcie_ltssm_enable_control_mode()
is doing that _and_ setting the mode to RC mode / EP mode.

Perhaps:

Add a function that adds:
rockchip_pcie_enable_enhanced_ltssm_control_mode()

which does:
+     /* Enable the enhanced control mode of signal app_ltssm_enable */
+     val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+     rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);

(This can be done in patch 2/4.)


Then add a that adds:
rockchip_pcie_set_controller_mode()

which does:
rockchip_pcie_writel_apb(rockchip, mode, PCIE_CLIENT_GENERAL_CONTROL);

(This can be done in patch 3/4.)


Kind regards,
Niklas

