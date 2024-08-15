Return-Path: <linux-pci+bounces-11704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB39953826
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 571BB2826AE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23351B8E9F;
	Thu, 15 Aug 2024 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qszw/P/8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DC91B5839
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738813; cv=none; b=L/MBc7nwJsmplc5oTkDizdcO7G/yM0M6JK0alcsQccaZyaMtoWPUM3kkmdFTn/qPTRe0GOl/dYNunwz5w6svF1pRhJeaDx1RQU4mNwOX9xQPp0ZrmYBpld7MESoXryVl8Fd1S37Yvxa+kZ44DeCM8wGNbXhynmNrkaBNgy+F96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738813; c=relaxed/simple;
	bh=TT6tmI8W1BjI0z0qjO8eTaJos37gam9EJLU4zprf/9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwDV5S67T8OHH5Cboda2PxA9GzbWAqCjReEGqO0IVt7U14WkNEvamV8i+uZ0dyHGyYXbmZwEca24wbH/aV2Tz6uM+ZrxWS8R6nO/1N9RlVNbt7ojmSFvecbbjEWBJlH7vZTRQCBGNqDJS2czPx8V3JvdNnrNKbUd31jxqVjCOL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qszw/P/8; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7bb75419123so917331a12.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 09:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723738811; x=1724343611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ik5jJmziSuK8GBVOaaeMajQRPRpyvl2v8hzurhsdC64=;
        b=qszw/P/8XneAtKNiaJlXYu9oJGESQvMd4kIQIK3SlQMQhzPspKdh49MJfC170onh2Q
         SW+d1+zlCVpM633kgXvNWvxeQfDceMOSnxupHhakl6+mnZJTxsqbP+F0gwvIJ6R/KoiK
         kP71nF8cC0u0hTKQBy35pr9KVKWOUVzMzzzcQnYq97OcxrhIWxwmKr9MPFzIbtZ46rGM
         B9TCq4W9uc7oX5lNj04AULAqN6hnQe4THP/3aVJ8fP7RUXWLSypJBoUQqd8+kLmXw95j
         br3VvTn+ps6QAONaAfbZ9DDmTpWQR11bh8bVvd3zVVy1sYsvvgn9T4Rb68ZmqxpjQLAz
         txjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738811; x=1724343611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ik5jJmziSuK8GBVOaaeMajQRPRpyvl2v8hzurhsdC64=;
        b=bvYyp+Sbp8KFRL7NxaUyZ4K7x6c6WAaANJ8df6ybOEogxvyeRSfu2iiQV1LwDvVlvW
         z2rNvUv3vWE8+lTyGhTngiL10CglGfDoLgvnHpqGuWFQFQ6aEKOGuCr9Qjke6zl61PU2
         85ejtYdk4OmwLz8ojb/+SZrpjIYIghQ75rk/J/WVdC9q9bk1JKkj2VWH4mmmaHhwB5pp
         ANia+cAoPu4ZCS29mQ9esWItvPD8OOKLD5wpIKPaxP7n1h6Xk8Gl+3O51KYoslx+xCOE
         GiZo98tgl/hkaTkjASm8k0xZtT/uPCCH1Q7m0ot+LtJccQtHU/or1gS7pam2/XpZwJ8Q
         1iOg==
X-Forwarded-Encrypted: i=1; AJvYcCXh5FxFeP6rhO1TU1Jz9arz1RlL+0NLSuaxHx+2oeXZrcl/AEzmhk99XFD8Sr4zBL82hDTgYPmOlaHFURH70LrfV++0tM3RXj/V
X-Gm-Message-State: AOJu0Yw6OueapBGvQdqrv0bjBWDUxOH7xGRT4Bj8+4iI01MPv2At2CLU
	jbfMc+zYc48UR4DsgPOJAhWg8H4egrCDzXKRNmE172ZHX9Ss3SAjU4MD+kPrwQ==
X-Google-Smtp-Source: AGHT+IHuOzAztyLkgbs6qAt/4J9NqgairvPE0eQNt56uNJdXaObqpsnNzVitDeMRYZDtF3El/Xf7yw==
X-Received: by 2002:a05:6a21:3401:b0:1c4:87b0:9157 with SMTP id adf61e73a8af0-1c904f91febmr249904637.22.1723738811113;
        Thu, 15 Aug 2024 09:20:11 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af188a4sm1166094b3a.164.2024.08.15.09.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:20:10 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:50:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20240815162004.GF2562@thinkpad>
References: <20240625104039.48311-1-linux.amoon@gmail.com>
 <20240625104039.48311-2-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625104039.48311-2-linux.amoon@gmail.com>

On Tue, Jun 25, 2024 at 04:10:33PM +0530, Anand Moon wrote:
> Refactor the reset control handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for assert and
> deassert reset controller using reset_control_bulk*() API. Using the
> reset_control_bulk APIs, the reset handling for the core clocks reset
> unit becomes much simpler.
> 
> As per rockchip rk3399 TRM SOFTRST_CON8 soft reset controller
> have clock reset unit value set to 0x1 for example "pcie_pipe",
> "pcie_mgmt_sticky", "pcie_mgmt" and "pci_core", hence group then under
> one reset bulk controller.
> 
> Where as "pcie_pm", "presetn_pcie", "aresetn_pcie" have reset value
> set to 0x0, hence group them under reset control bulk controller.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v4: use dev_err_probe in error path.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot
>     fixed checkpatch warning
> ---
>  drivers/pci/controller/pcie-rockchip.c | 149 +++++--------------------
>  drivers/pci/controller/pcie-rockchip.h |  25 +++--
>  2 files changed, 47 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 804135511528..024308bb6ac8 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -69,55 +69,23 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	if (rockchip->link_gen < 0 || rockchip->link_gen > 2)
>  		rockchip->link_gen = 2;
>  
> -	rockchip->core_rst = devm_reset_control_get_exclusive(dev, "core");
> -	if (IS_ERR(rockchip->core_rst)) {
> -		if (PTR_ERR(rockchip->core_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing core reset property in node\n");
> -		return PTR_ERR(rockchip->core_rst);
> -	}
> -
> -	rockchip->mgmt_rst = devm_reset_control_get_exclusive(dev, "mgmt");
> -	if (IS_ERR(rockchip->mgmt_rst)) {
> -		if (PTR_ERR(rockchip->mgmt_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing mgmt reset property in node\n");
> -		return PTR_ERR(rockchip->mgmt_rst);
> -	}
> -
> -	rockchip->mgmt_sticky_rst = devm_reset_control_get_exclusive(dev,
> -								"mgmt-sticky");
> -	if (IS_ERR(rockchip->mgmt_sticky_rst)) {
> -		if (PTR_ERR(rockchip->mgmt_sticky_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing mgmt-sticky reset property in node\n");
> -		return PTR_ERR(rockchip->mgmt_sticky_rst);
> -	}
> -
> -	rockchip->pipe_rst = devm_reset_control_get_exclusive(dev, "pipe");
> -	if (IS_ERR(rockchip->pipe_rst)) {
> -		if (PTR_ERR(rockchip->pipe_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing pipe reset property in node\n");
> -		return PTR_ERR(rockchip->pipe_rst);
> -	}
> +	for (i = 0; i < ROCKCHIP_NUM_PM_RSTS; i++)
> +		rockchip->pm_rsts[i].id = rockchip_pci_pm_rsts[i];
>  
> -	rockchip->pm_rst = devm_reset_control_get_exclusive(dev, "pm");
> -	if (IS_ERR(rockchip->pm_rst)) {
> -		if (PTR_ERR(rockchip->pm_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing pm reset property in node\n");
> -		return PTR_ERR(rockchip->pm_rst);
> -	}
> +	err = devm_reset_control_bulk_get_optional_exclusive(dev,
> +							     ROCKCHIP_NUM_PM_RSTS,
> +							     rockchip->pm_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot get the reset control\n");
>  
> -	rockchip->pclk_rst = devm_reset_control_get_exclusive(dev, "pclk");
> -	if (IS_ERR(rockchip->pclk_rst)) {
> -		if (PTR_ERR(rockchip->pclk_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing pclk reset property in node\n");
> -		return PTR_ERR(rockchip->pclk_rst);
> -	}
> +	for (i = 0; i < ROCKCHIP_NUM_CORE_RSTS; i++)
> +		rockchip->core_rsts[i].id = rockchip_pci_core_rsts[i];
>  
> -	rockchip->aclk_rst = devm_reset_control_get_exclusive(dev, "aclk");
> -	if (IS_ERR(rockchip->aclk_rst)) {
> -		if (PTR_ERR(rockchip->aclk_rst) != -EPROBE_DEFER)
> -			dev_err(dev, "missing aclk reset property in node\n");
> -		return PTR_ERR(rockchip->aclk_rst);
> -	}
> +	err = devm_reset_control_bulk_get_optional_exclusive(dev,
> +							     ROCKCHIP_NUM_CORE_RSTS,
> +							     rockchip->core_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot get the reset control\n");
>  
>  	if (rockchip->is_rc) {
>  		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
> @@ -150,23 +118,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	int err, i;
>  	u32 regs;
>  
> -	err = reset_control_assert(rockchip->aclk_rst);
> -	if (err) {
> -		dev_err(dev, "assert aclk_rst err %d\n", err);
> -		return err;
> -	}
> -
> -	err = reset_control_assert(rockchip->pclk_rst);
> -	if (err) {
> -		dev_err(dev, "assert pclk_rst err %d\n", err);
> -		return err;
> -	}
> -
> -	err = reset_control_assert(rockchip->pm_rst);
> -	if (err) {
> -		dev_err(dev, "assert pm_rst err %d\n", err);
> -		return err;
> -	}
> +	err = reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
> +					rockchip->pm_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "reset bulk assert pm reset\n");
>  
>  	for (i = 0; i < MAX_LANE_NUM; i++) {
>  		err = phy_init(rockchip->phys[i]);
> @@ -176,47 +131,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		}
>  	}
>  
> -	err = reset_control_assert(rockchip->core_rst);
> -	if (err) {
> -		dev_err(dev, "assert core_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_assert(rockchip->mgmt_rst);
> -	if (err) {
> -		dev_err(dev, "assert mgmt_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_assert(rockchip->mgmt_sticky_rst);
> -	if (err) {
> -		dev_err(dev, "assert mgmt_sticky_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_assert(rockchip->pipe_rst);
> -	if (err) {
> -		dev_err(dev, "assert pipe_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> +	err = reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS,
> +					rockchip->core_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "reset bulk assert core reset\n");
>  
>  	udelay(10);
>  
> -	err = reset_control_deassert(rockchip->pm_rst);
> -	if (err) {
> -		dev_err(dev, "deassert pm_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->aclk_rst);
> -	if (err) {
> -		dev_err(dev, "deassert aclk_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->pclk_rst);
> +	err = reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> +					  rockchip->pm_rsts);
>  	if (err) {
> -		dev_err(dev, "deassert pclk_rst err %d\n", err);
> +		dev_err(dev, "reset bulk deassert pm err %d\n", err);
>  		goto err_exit_phy;
>  	}
>  
> @@ -259,31 +184,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	 * Please don't reorder the deassert sequence of the following
>  	 * four reset pins.
>  	 */

The comment above says that the resets should not be reordered. But you have
reordered the resets.

- Mani

> -	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->core_rst);
> +	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> +					  rockchip->core_rsts);
>  	if (err) {
> -		dev_err(dev, "deassert core_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->mgmt_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->pipe_rst);
> -	if (err) {
> -		dev_err(dev, "deassert pipe_rst err %d\n", err);
> +		dev_err(dev, "reset bulk deassert core err %d\n", err);
>  		goto err_power_off_phy;
>  	}
>  
>  	return 0;
> +
>  err_power_off_phy:
>  	while (i--)
>  		phy_power_off(rockchip->phys[i]);
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 72346e17e45e..27e951b41b80 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
> +#include <linux/reset.h>
>  
>  /*
>   * The upper 16 bits of PCIE_CLIENT_CONFIG are a write mask for the lower 16
> @@ -289,6 +290,8 @@
>  		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
>  
>  #define ROCKCHIP_NUM_CLKS	ARRAY_SIZE(rockchip_pci_clks)
> +#define ROCKCHIP_NUM_PM_RSTS	ARRAY_SIZE(rockchip_pci_pm_rsts)
> +#define ROCKCHIP_NUM_CORE_RSTS	ARRAY_SIZE(rockchip_pci_core_rsts)
>  
>  static const char * const rockchip_pci_clks[] = {
>  	"aclk",
> @@ -297,18 +300,26 @@ static const char * const rockchip_pci_clks[] = {
>  	"pm",
>  };
>  
> +static const char * const rockchip_pci_pm_rsts[] = {
> +	"pm",
> +	"pclk",
> +	"aclk",
> +};
> +
> +static const char * const rockchip_pci_core_rsts[] = {
> +	"core",
> +	"mgmt",
> +	"mgmt-sticky",
> +	"pipe",
> +};
> +
>  struct rockchip_pcie {
>  	void	__iomem *reg_base;		/* DT axi-base */
>  	void	__iomem *apb_base;		/* DT apb-base */
>  	bool    legacy_phy;
>  	struct  phy *phys[MAX_LANE_NUM];
> -	struct	reset_control *core_rst;
> -	struct	reset_control *mgmt_rst;
> -	struct	reset_control *mgmt_sticky_rst;
> -	struct	reset_control *pipe_rst;
> -	struct	reset_control *pm_rst;
> -	struct	reset_control *aclk_rst;
> -	struct	reset_control *pclk_rst;
> +	struct  reset_control_bulk_data pm_rsts[ROCKCHIP_NUM_PM_RSTS];
> +	struct  reset_control_bulk_data core_rsts[ROCKCHIP_NUM_CORE_RSTS];
>  	struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
>  	struct	regulator *vpcie12v; /* 12V power supply */
>  	struct	regulator *vpcie3v3; /* 3.3V power supply */
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

