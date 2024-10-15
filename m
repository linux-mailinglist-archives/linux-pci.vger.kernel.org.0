Return-Path: <linux-pci+bounces-14510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309899DD66
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 07:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 674541C20E34
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 05:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43F0175562;
	Tue, 15 Oct 2024 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jkkw0air"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93416F907
	for <linux-pci@vger.kernel.org>; Tue, 15 Oct 2024 05:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728969110; cv=none; b=I2g6YRcCkadzspYxmMmgmpFMiztTnDxNnhKtKSGQ1Pan1SU0o+dEElF4clXDBbqfQZgwZbgqE97pE8ODeg3jQXD49TgwaivtCIaSuw95xgKDndpBS234SMZD+0lnu3bq7E8hQpgKXoWUTi+N1kDzS8EiWmaQkoLQf5RCHj6BWwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728969110; c=relaxed/simple;
	bh=DVTjuEMjHjJ2f0Y90QGBddcB1di19d4oyCbgmdK//CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ti99d0A8Qnr8WEx5dH3a6HUSqGkW4QhUYtK9eJPKWsKA6czJL1WktgKShrYauAsJIW5VX3/iHqgzQoQMYqUlY2hb0t/9LJK2p9gH1B1v7lW3G3CVR9cJTrwry9U3lDZhkBUm+B7s5/Z7gGv0j1Hf1gXUYuU4SZ1bvT9Ar4Ewzjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jkkw0air; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e579abb99so1602555b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 22:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728969108; x=1729573908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=itcSJsJotSK/jcaVaV5tcZpuhtgwm01gUAjTOqSUyQM=;
        b=jkkw0air61PO2aJMjzyv3zZRVLTFsgW3qTinIl8dxkgTI/oHG3D4qZ3jpHpCCC2/Lv
         2MgWiwWrtL822wNrcBqLGteTxlCtkuh1pSfEuAnFQwBQX5sC/E92ystvIz4p0TPHv710
         JT2WKOSrDUWzH/kaGVLNv4tfUY80lUG/Uj9WQnOifSfjn4y6/Be3eKrLvzoZmwG6nejQ
         LJ80Uffc3G9j7oCdgJIoOBF0MSalMZbJw+SlovgYgv1BERdM5W8PhdU8zJFSrS7efuzA
         p07zGc3i3Yw8XFOHDnmDmRnFXzawjNiqYIBBi0A3hRL3lktYTY54JkOOTjpfvMWORkh5
         hm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728969108; x=1729573908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itcSJsJotSK/jcaVaV5tcZpuhtgwm01gUAjTOqSUyQM=;
        b=aobrUCnpOuWn7sMKKKiShLY9HJQWU2Odi0wxeLgxiomfd990hLoKBz+RMLM7bHPGS2
         36B5LyeVQn1eZ+asX+xUifIUBC2qfcZc/RNypw2m0rygcjwTKyJsA08yXGvd8zdgwv9k
         f00+iMAubOukVaG/FyYLHAuoWeZI7rxoFiDFtTMjbEJYZlcRwTnl+ksO/GzKZbd/zvTE
         Bzy5UZ5ZTFb7K+LJd7iT+Ic/Q46PS4t4HHaaeGpmdE0JsJY9ps3L76Jb4opcLxakGQrO
         Xv68xz+9VWuLD6wd7iRvwW08CafIMKp45UWuJdUVhoHov5G/xe6oMhsJq80ecqiQn95H
         Cy+w==
X-Forwarded-Encrypted: i=1; AJvYcCUetTXvegdLDncbm1WH0Dt2VH8jBX2fbKJhFGZYp51m+QfHAzwvh7eZxGTZRhD1aMS7D9flh3oLpB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+Ch8ANQNtCAevNW+Hb6OwS4ghAqcRY5NgtpNoOk4A7tV1fi3
	iSi1W41NqZiUdwGe2AAoCFm0A3+Hcl35ZhhjQKXwb//izgV+AwUCtyFHVbrmHw==
X-Google-Smtp-Source: AGHT+IGcczmm+9wAnSEP6Av3fDiqgeLou2z+jC7AbNImoY9K8bKikbyOt8wINuH5deg1mPWGxTr0NQ==
X-Received: by 2002:a05:6a00:888:b0:71d:fd40:b484 with SMTP id d2e1a72fcca58-71e380c5033mr20946749b3a.24.1728969108206;
        Mon, 14 Oct 2024 22:11:48 -0700 (PDT)
Received: from thinkpad ([220.158.156.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e7737185dsm450968b3a.16.2024.10.14.22.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 22:11:47 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:41:41 +0530
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
Subject: Re: [PATCH v8 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20241015051141.g6fh222zrkvnn4l6@thinkpad>
References: <20241014135210.224913-1-linux.amoon@gmail.com>
 <20241014135210.224913-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014135210.224913-3-linux.amoon@gmail.com>

On Mon, Oct 14, 2024 at 07:22:03PM +0530, Anand Moon wrote:
> Refactor the reset control handling in the Rockchip PCIe driver,
> introduce a more robust and efficient method for assert and
> deassert reset controller using reset_control_bulk*() API. Using the
> reset_control_bulk APIs, the reset handling for the core clocks reset
> unit becomes much simpler.
> 
> Spilt the reset controller in two groups as per the
>  RK3399 TM  17.5.8.1 PCIe Initialization Sequence
>     17.5.8.1.1 PCIe as Root Complex.
> 
> 6. De-assert the PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N
>    simultaneously.
> 

I'd reword it slightly:

Following the recommendations in 'Rockchip RK3399 TRM v1.3 Part2':

1. Split the reset controls into two groups as per section '17.5.8.1.1 PCIe
as Root Complex'.

2. Deassert the 'Pipe, MGMT Sticky, MGMT, Core' resets in groups as per section
'17.5.8.1.1 PCIe as Root Complex'. This is accomplished using the
reset_control_bulk APIs.

> - devm_reset_control_bulk_get_exclusive(): Allows the driver to get all
>   resets defined in the DT thereby removing the hardcoded reset names
>   in the driver.
> - reset_control_bulk_assert(): Allows the driver to assert the resets
>   defined in the driver.
> - reset_control_bulk_deassert(): Allows the driver to deassert the resets
>   defined in the driver.
> 

No need to list out the APIs. Just add them to the first paragraph itself to
explain how they are used.

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Some nitpicks below. Rest looks good.

> ---
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
>  drivers/pci/controller/pcie-rockchip.c | 155 +++++--------------------
>  drivers/pci/controller/pcie-rockchip.h |  26 +++--
>  2 files changed, 49 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 2777ef0cb599..43d83c1f3196 100644
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
> +		return dev_err_probe(dev, err, "Cannot get the PM reset control\n");

"Couldn't get PM resets"

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
> +		return dev_err_probe(dev, err, "Cannot get the CORE reset control\n");

"Couldn't get Core resets"

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

"Couldn't assert Core resets\n"

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

"Couldn't deassert PM resets: %d\n"

>  		goto err_exit_phy;
>  	}
>  
> @@ -252,35 +177,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
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
> +		dev_err(dev, "Couldn't deassert CORE err %d\n", err);

"Couldn't deassert Core resets: %d\n"

>  		goto err_power_off_phy;
>  	}
>  
>  	return 0;
> +

Spurious change.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

