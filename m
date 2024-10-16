Return-Path: <linux-pci+bounces-14688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 586B29A1171
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0091F2387A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 18:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0E420FAA4;
	Wed, 16 Oct 2024 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJ4hvDE8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28120C03B
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103030; cv=none; b=N0y9QsKOXdlHzJAXGmhdXjRrI9PysFDgkaOS1jQ3gfCfapoJEvSzkDDsZPFV6hPcQe2a0/17qn3JSR6Z34Xyut7aPA2eacyRXc4Gr6x9ycVz0kvK/c8ERa+UAFWultrASX7nWwz1mSsJrFzf1Q/uiTH/NTK/rE3/7tnkduhq8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103030; c=relaxed/simple;
	bh=ThuyHEvrWkZX6LGCDk4ph3P4Tuetb+8x6zkB/MWk3ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lpg+X7g5C+K/lTatmN0kayqB3/Err5qmoJq13ZA/LEzpLGFZHL0aFffelkC9Ipx8pWsCIXB9i9Kyn3QpYpZoO+q5c6yXLHVTNpKQsFC2bRl6+/kIQxZwtwKK3r+UlbIkbH28plq1SGIjqTe8Vrs/RTr2miz9mW9MSGy5QthPA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oJ4hvDE8; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so85650a91.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 11:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729103028; x=1729707828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9FSXTunfauFqObdnMvOof9c58rDPSK2L/Ju+cwe2Vk=;
        b=oJ4hvDE8Qrfaw/JCVYGD9Agr6zqBt0yNxgRP3elbh7q3+fLR1N3R4xhg2DUf1Iv2Mz
         s/Mg0bS3LMM58Ce/3XP94HFjvy659J6ivXDeWATP856wZhQeP6x/gGagU9Rob40wjARX
         QRgI35fGlmUIV/8Nv0SRsu/KsM+V/esUUBpBCzUmfBQggfKRjubMvnKwYKpEJUTFH9MI
         +Tre+WU+NXf8xF4rGddsGKy0VHITZMDk66Jr2VpNHAIRkDwvIZzcF2m1aht4A2R4wK8x
         DZYFeDX/3Ijqxe0uCAsYErHUig83/6hAvFj3gIUalT2cCM42UtVIBzszVSpFFx05NVyx
         6T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103028; x=1729707828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9FSXTunfauFqObdnMvOof9c58rDPSK2L/Ju+cwe2Vk=;
        b=GRPB1ALGYM/r9BWDmBillVP3gN4KNgD9YcNf311oNbHP+PTBCOfhQB6xN0FClXBdxA
         4H6a/NsATBswSRsE9G/BIRHLjV50KJ3fODfcwHWbtVbr8/xtvfqIL9OUp7DRQnO9QWjO
         Q7vmscdW4vBOQ4KK+ST7rAjKIhL5L5n8sfC4SF9Nbhsgviu7iYY5rZnHI3MgYAJpfRoF
         6ck3D6aBgDstRxWmGq0vLNJkgGGojYQm3vD6c+Bz6FaWqOXq0ryPqwq1/DmCeCSzR1WC
         e5N/w7GevBdXoNJfEzCwIT+QQkOsaFUbILMwaPRLPUmnXgqc95AlsKwpZLlW7aZPSuMe
         SzVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxUYdJv4UGpFhrM66Uri+DJzzbbkC2PsKdhZanzKiABV+UXp8zEJcAuToQoJmIiScx4qmGAEvwEFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywst4FEayyswca9WrgqvLhv2G+K6KxSjKsn/rgDknWOChKOAASn
	z+LP0nVdEey8aAg4Vyli6sM9PIf6LUxb476vpH3xOb0nZ0gDGy49clpgY0+lDg==
X-Google-Smtp-Source: AGHT+IGWkJGRmyaIWX5Cu9E+GwiN+naRwsRghQOuN9ThDCYEoEGUFXmClqurTAtb8Zw8pyE0R0IJ3w==
X-Received: by 2002:a17:90a:f484:b0:2da:8edf:ddc with SMTP id 98e67ed59e1d1-2e3dc2b7374mr717752a91.19.1729103028443;
        Wed, 16 Oct 2024 11:23:48 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08d1d5asm91458a91.19.2024.10.16.11.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:23:47 -0700 (PDT)
Date: Wed, 16 Oct 2024 23:53:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20241016182343.vocxyi5ry33btw5o@thinkpad>
References: <20241016114915.2823-1-linux.amoon@gmail.com>
 <20241016114915.2823-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016114915.2823-3-linux.amoon@gmail.com>

On Wed, Oct 16, 2024 at 05:19:07PM +0530, Anand Moon wrote:
> Currently, the driver acquires and asserts/deasserts the resets
> individually thereby making the driver complex to read. But this
> can be simplified by using the reset_control_bulk APIs.
> Use devm_reset_control_bulk_get_exclusive() API to acquire all
> the resets and use reset_control_bulk_{assert/deassert}() APIs to
> assert/deassert them in bulk.
> 
> Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':
> 
> 1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
> as Root Complex'.
> 
> 2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per
> section '17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
> reset_control_bulk APIs.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v9: Improved the commit message and try to fix few review comments.

You haven't fixed all of them... Please take a look at all of my comments.

- Mani

> v8: I tried to address reviews and comments from Mani.
>     Follow the sequence of De-assert as per the driver code.
>     Drop the comment in the driver.
>     Improve the commit message with the description of the TMP section.
>     Improve the reason for the core functional changes in the commit
>     description.
>     Improve the error handling messages of the code.
> v7: replace devm_reset_control_bulk_get_optional_exclusive()
>         with devm_reset_control_bulk_get_exclusive()
>     update the functional changes.
> V6: Add reason for the split of the RESET pins.
> v5: Fix the De-assert reset core as per the TRM
>     De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
>     simultaneously.
> v4: use dev_err_probe in error path.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot
>     fixed checkpatch warning.
> ---
>  drivers/pci/controller/pcie-rockchip.c | 154 +++++--------------------
>  drivers/pci/controller/pcie-rockchip.h |  26 +++--
>  2 files changed, 48 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 2777ef0cb599..adf11208cc82 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *node = dev->of_node;
>  	struct resource *regs;
> -	int err;
> +	int err, i;
>  
>  	if (rockchip->is_rc) {
>  		regs = platform_get_resource_byname(pdev,
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
> +	err = devm_reset_control_bulk_get_exclusive(dev,
> +						    ROCKCHIP_NUM_PM_RSTS,
> +						    rockchip->pm_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "Cannot get the PM reset\n");
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
> +	err = devm_reset_control_bulk_get_exclusive(dev,
> +						    ROCKCHIP_NUM_CORE_RSTS,
> +						    rockchip->core_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "Cannot get the CORE resets\n");
>  
>  	if (rockchip->is_rc) {
>  		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
> @@ -147,23 +115,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
> +		return dev_err_probe(dev, err, "Couldn't assert PM resets\n");
>  
>  	for (i = 0; i < MAX_LANE_NUM; i++) {
>  		err = phy_init(rockchip->phys[i]);
> @@ -173,47 +128,17 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
> +		return dev_err_probe(dev, err, "Couldn't assert Core resets\n");
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
> +	err = reset_control_bulk_deassert(ROCKCHIP_NUM_PM_RSTS,
> +					  rockchip->pm_rsts);
>  	if (err) {
> -		dev_err(dev, "deassert aclk_rst err %d\n", err);
> -		goto err_exit_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->pclk_rst);
> -	if (err) {
> -		dev_err(dev, "deassert pclk_rst err %d\n", err);
> +		dev_err(dev, "Couldn't deassert PM resets %d\n", err);
>  		goto err_exit_phy;
>  	}
>  
> @@ -252,31 +177,10 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  		goto err_power_off_phy;
>  	}
>  
> -	/*
> -	 * Please don't reorder the deassert sequence of the following
> -	 * four reset pins.
> -	 */
> -	err = reset_control_deassert(rockchip->mgmt_sticky_rst);
> -	if (err) {
> -		dev_err(dev, "deassert mgmt_sticky_rst err %d\n", err);
> -		goto err_power_off_phy;
> -	}
> -
> -	err = reset_control_deassert(rockchip->core_rst);
> -	if (err) {
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
> +	err = reset_control_bulk_deassert(ROCKCHIP_NUM_CORE_RSTS,
> +					  rockchip->core_rsts);
>  	if (err) {
> -		dev_err(dev, "deassert pipe_rst err %d\n", err);
> +		dev_err(dev, "Couldn't deassert CORE %d\n", err);
>  		goto err_power_off_phy;
>  	}
>  
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index bebab80c9553..cc667c73d42f 100644
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
> @@ -288,18 +289,29 @@
>  		(((c) << ((b) * 8 + 5)) & \
>  		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
>  
> +#define ROCKCHIP_NUM_PM_RSTS   ARRAY_SIZE(rockchip_pci_pm_rsts)
> +#define ROCKCHIP_NUM_CORE_RSTS ARRAY_SIZE(rockchip_pci_core_rsts)
> +
> +static const char * const rockchip_pci_pm_rsts[] = {
> +	"pm",
> +	"pclk",
> +	"aclk",
> +};
> +
> +static const char * const rockchip_pci_core_rsts[] = {
> +	"mgmt-sticky",
> +	"core",
> +	"mgmt",
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
>  	struct  clk_bulk_data *clks;
>  	int	num_clks;
>  	struct	regulator *vpcie12v; /* 12V power supply */
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

