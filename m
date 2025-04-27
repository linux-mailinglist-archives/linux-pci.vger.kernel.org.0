Return-Path: <linux-pci+bounces-26854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F8CA9E24B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F43AE11D
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02F0248865;
	Sun, 27 Apr 2025 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/3OZLxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3433D3B8
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745747613; cv=none; b=MQoXP4x1lS853Wq5sPxTmGyl2oLIyCN4SxF1PJLaEwOVJqr0L3T9Ekk/lNXstLblRg/SKGzvHCqGSD6/aH0ktkR8WpuztKKXyDS3UIzbMvU9/JTuLgbEa9MzYTkf/Ha2DzQL13zyUxuHXEDQs3OGIDSt9ulyQ73K6L1nli1Nak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745747613; c=relaxed/simple;
	bh=XcZscnYnpKuncWhXTuv1ht2CYPZ+S6YVaZUtjW8RKL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3fg5mX6/Fc3M1ue3Hz30amYhHaKe7+riQq/4gCNxhVvH4ksvugXLRnIbYkoPoz2yOpaPJQUSfFTb2p852SBsjd+W54CbIncEoNg563TpNgPBUlQKgzkaiYsXC4Ba32ulISvs8vqsLP4VKF7odwxo1M+9vLwpFJ1jfZGR+XHkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/3OZLxI; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b0da25f5216so2338612a12.1
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745747611; x=1746352411; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GSMAKtZc0Q9fsgMsHTCy8i97nj4BrkLyrpZH400N2hA=;
        b=A/3OZLxIj9mh0ZlrFKL3z0BYFcAZPXg42B8NZpkKBXtFT00dw+0PqxouXQIZyVi/g7
         K6PrdsfYGb7waXKQGlYCiWRm+4OZngCog/rCbWA2LZldxM4ijjlQr8RxYFsjuEZkIqjb
         aNvmtuoRk6mTI2oLrYL7magUiFcKeWGCbv14hUz5v+2TveCKss7BPe4JM49DxUh7tazW
         l+EYlpgHTCeonchzZl0j7mRTY1+iILtD5kFpYMh7Mn9HswDSXQcNbCHqHJXDDRkncw6j
         YYeFj2bCINxZdMGqs3ZMDjoHXsSevGi9qqHe7Y2zN0f4bU1akSzTxT8NbjgJnzXwPB2Z
         GSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745747611; x=1746352411;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSMAKtZc0Q9fsgMsHTCy8i97nj4BrkLyrpZH400N2hA=;
        b=LbvWdWxwuth4liotoBOxFR2J6bLn2QSaqxAFJwqOwWh+9W555FYExr9spfHsPsVfS5
         K7rOtz8duoVsdSfDnLMLJaXzYTje4yz3Q3ruszsfPhFFZ0VdVe7KQ0wc9MILELEz/QTV
         fhAA3bpGdEZZY0eScNh8FCyxzL73bE83wfNBBQCG8C0eVpsgkiJKHnhn0a/xs+Xt+enF
         JAgQBqzI0Gdo3QhrXCDQiPcfehg0+5WCHpkB/LOZAK5qAO5pTEZbiNb9rTJQ4XKId0+s
         e1TQnUiQ8f+CBPfUWUT/Nu9MwYvRuFSkxH2uufU6db4H2j60wjLKyl8zU2zQLD5RNAM5
         jpfg==
X-Forwarded-Encrypted: i=1; AJvYcCXYFa9tZxKkrGCTE5pSFaldGUzuE/d+rN4+fzSWxA/gRzMFyg4bwro+aakhvqNpCkr9jBoNmOGraHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlqYzCmjAwSUgA+W3amV8bzbTyMrikEYrbGanD14LJGOFz+6O
	v63z5w2XPN+9OW80ta7/oc0DSGv8xcDjp9/fd9B7rgNbk6GfPWZW1+PmDn/04w==
X-Gm-Gg: ASbGncvtOr4C5weTcVAcByLws4pnFeSc1/aXYRppWE6xnjJ9LFWDc32PxDdePcz4Ekr
	Myu8ssBXZKsZw7m5zMcn8KkWNiWKX7VDK4TIJ0bMn7H29hfmnVOjsNn21RAs2CwIMa1JiVHhMuQ
	rOJkYfXwMma6Y8VPYYMczip04Pnx1CQYaVP83NWNK9KAHsHVPQW3G0JWcUDBryV3dgc0YVtoLiI
	RuKjgEIlVDbJzHS93q3YNo7pEmA3QDbhaBNX8W/T4HmlUpdGO2G9bEtYHQ6EjyjocPCiGLh/s7r
	RqFumpjf5oY3eIvwcnJ00OQJD0/McVkBwNu+zAPpLUmXRqv77HGP
X-Google-Smtp-Source: AGHT+IF99AHNbOlhwhyTXq65AygaAtk/0skWNtN/jeNyuQVErRcs6n1kcnkh60M/EEN404EjaFghsw==
X-Received: by 2002:a17:90b:2e03:b0:2fa:1a23:c01d with SMTP id 98e67ed59e1d1-30a0132e771mr7992188a91.21.1745747610665;
        Sun, 27 Apr 2025 02:53:30 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f782d4b4sm4839000a91.33.2025.04.27.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 02:53:30 -0700 (PDT)
Date: Sun, 27 Apr 2025 15:23:25 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add system PM support
Message-ID: <u7y6nqtgapdleobd2w2jijoomkchjkx72yw5esivpckta54ywt@6x4sfq4zp2id>
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

On Fri, Apr 18, 2025 at 09:45:59AM +0800, Shawn Lin wrote:
> This patch adds system PM support for Rockchip platforms by adding

Both subject and commit message should mention that PM support is added only
for RC mode.

> .pme_turn_off and .get_ltssm hook and tries to reuse possible existing
> code.
> 
> It's tested on RK3576 EVB1 board with Some NVMes

Oh, really? How did they survive once you turn off the power during suspend()?
NVMe driver expects the device to be in D0 even during suspend to avoid resume
latency.

> and PCIe-2-SATA/XHCI
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

None of these logs are relevant to be mentioned in patch description.

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

Why two bitfields are combined? Is it possible to add definitions for each of
them?

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

What does 'pure_ltssm' mean? You are just masking out some bits from
LTSSM_STATUS. What do they correspond to?

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

Reverse Xmas order please (for possible variables).

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

To avoid this, could you please move both devm_phy_get() and
devm_clk_bulk_get_all() to rockchip_pcie_resource_get()? This ensures that all
resource get code are contained in a single function and that function gets
called only during probe().

You should do it in a separate patch before this one.

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
> @@ -512,12 +587,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
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
> @@ -529,9 +599,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
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
> @@ -558,12 +626,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
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
> @@ -677,6 +740,94 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static int rockchip_pcie_suspend(struct device *dev)
> +{
> +	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &rockchip->pci;
> +	int ret;
> +
> +	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "suspend is not supported in EP mode\n");
> +		return -EOPNOTSUPP;

One of the reasons why I hate clubbing both RC and EP in a single driver. But
fine for now.

> +	}
> +
> +	rockchip->intx = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	ret = dw_pcie_suspend_noirq(pci);
> +	if (ret) {
> +		dev_err(dev, "failed to suspend\n");

Please print the errno also. Or better drop the error message and rely on PM
core.

> +		return ret;
> +	}
> +
> +	rockchip_pcie_phy_deinit(rockchip);
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +	reset_control_assert(rockchip->rst);
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);

PERST# should be asserted in advance of power being switched off, not after.

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
> +	if (rockchip->data->mode == DW_PCIE_EP_TYPE) {
> +		dev_err(dev, "resume is not supported in EP mode\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	reset_control_assert(rockchip->rst);
> +

Why? reset is supposed to be asserted in suspend() itself.

> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret) {
> +		dev_err(dev, "clock init failed\n");

As said above, print the errno.

> +		goto err_clk;
> +	}
> +
> +	if (rockchip->vpcie3v3) {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			goto err_power;

Please name the goto labels as per their purpose, not per the point of failure.
Like, 'err_disablk_clk'.

> +	}
> +
> +	ret = rockchip_pcie_phy_init(rockchip);
> +	if (ret) {
> +		dev_err(dev, "phy init failed\n");
> +		goto err_phy_init;
> +	}
> +
> +	reset_control_deassert(rockchip->rst);
> +
> +	rockchip_pcie_writel_apb(rockchip, HIWORD_UPDATE(0xffff, rockchip->intx),
> +				 PCIE_CLIENT_INTR_MASK_LEGACY);
> +
> +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
> +	rockchip_pcie_unmask_dll_indicator(rockchip);
> +
> +	ret = dw_pcie_resume_noirq(pci);

I had to check the driver to see where PERST# is getting deasserted and it
happens in start_link() callback. Since you assert it in suspend(), you should
explicitly do it in resume() to maintain symmetry.

> +	if (ret) {
> +		dev_err(dev, "fail to resume\n");
> +		goto err_resume;
> +	}
> +
> +	return 0;
> +
> +err_resume:
> +	rockchip_pcie_phy_deinit(rockchip);
> +err_phy_init:
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +err_power:
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +err_clk:
> +	reset_control_deassert(rockchip->rst);

Why do you want to deassert the reset in the case of failure? If you get rid of
the assert at the start as I suggested, this label can be removed altogether.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

