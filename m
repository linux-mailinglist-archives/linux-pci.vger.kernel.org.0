Return-Path: <linux-pci+bounces-14362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F1C99B143
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 08:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2215EB22042
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 06:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920A713A25F;
	Sat, 12 Oct 2024 06:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ETky6zyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DCC4315F
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728713921; cv=none; b=VXUdRDebNeli8t/e/UGyJ2/1LtrFv26FzB1QAj35d5QQI4Jc/nFUunXhHiu4ERtuf58+gPTLlKjectQs6YbWYzru7LAsuQTYtAEvItw1HSNw7KGme+aomQkT8biBEF2K4/jNdnKMf5IItTIpvLlLUJIy6EmQ+Ca+DPp7UCNSEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728713921; c=relaxed/simple;
	bh=pxyq+AFphImbpqv0+95FVp9fxT4+lEWCQWcjFv1WM3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVUH18j+xaUXXmxyhKwrdAsclyfi9o038oHfrxT5K+9vsLHN9SY515AcL0/AEelKSIREG24GfA/ii6dLTjfbT87NG3VVJ2WqOb+OR+WoTf45OLSzyuGkFxADx8RY/eZdZrARrC5iPcHogls9KKf9MGzy5mn9FncvTAoMTO8IiBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ETky6zyT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e483c83dbso893455b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 23:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728713919; x=1729318719; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L0zqzAhZZVC6sbBIGKcvUCuXRGhVE6bE7pX/LBTwZjg=;
        b=ETky6zyTS4yhHq/ixU+4Fxu8eCpzCO9P7REj+It7SIkiremJ3qn68qoPYkNphaTzfd
         0MtDVgEir8Ma7xmOsw9X3WNWc+j3bDpb7gIvqUqrdmdMt2EFTqmBHEaVgVNj0CDmwRno
         haN2ifOrHeWXzR9v2bdIyUgZODM/bPAiNhRFwnDyuX1wzccjQ60KjYZSniEaFR6U2scR
         1tELVGMqnxzQhixi/+Z0QBkkB250NJVAZmbO9f8zNERTc0hMataAuUxc08yjw1rZLI86
         Y5ii4xPQCFk62g4l4107YNHHxksdpzfRzPGexx82h65DuPaCic0vAg7NO/vlBGgDg2ro
         ERqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728713919; x=1729318719;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L0zqzAhZZVC6sbBIGKcvUCuXRGhVE6bE7pX/LBTwZjg=;
        b=bdYE2Zm3t527+W9WI7UYdW7zwrocrhFpDFhTJDKU/k5Ml48PJ/W02jriKRUOaGA5rs
         7yIr6eU0Y1jsa6yS5wQFKIOZqBwT/UIlTLG3Qez8sXdRlHaAybHO6uPLoNPncL1qjcLC
         9olmGR/Eg04Z5rWGOzPhIzILUC4rauJFvArnl/FKrI9DKpUWnl7eked7AkXc4V9DyjIj
         yAFygSTi192FJRNqCEa0rjfhF9ZdLGtHjuyIph+2o28EcrCjmHUpxhYeZc6GtNyZEMbE
         /NIn6rfcbcwcQV+PvkziuhriqDP+wl2VtPJ8N03U7ag2P0FrU85aWLN8nogEb8NU0S4s
         i6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUqLHf7qB0x4DoFgYTFvjwdpnflBTlmAlrUWgRlybnklVCsCEQy0FjQq4PxXv6+0JpN5PysS7+Fzds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9d0trN9INvp4m8VsfWSzqKZU7lJeVCKiD7f+ZQ2m2f8TGVQzp
	vdiYAsoS3d3ygc8x8VS3wzFg+vrthJCrkVxDgu1O+FrvOMMob1MBhVKOdC/p2w==
X-Google-Smtp-Source: AGHT+IF27/xVzp5EIA//SfiQ9fpAegP+0cn68oU11c0gnNhVwSd+ux7I7X/VZZO+jOqHNNBZJ8cLLQ==
X-Received: by 2002:a05:6a21:2d89:b0:1cf:2a35:6d21 with SMTP id adf61e73a8af0-1d8bcfb3cf1mr8403778637.45.1728713919188;
        Fri, 11 Oct 2024 23:18:39 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2ab0b661sm3596531b3a.191.2024.10.11.23.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 23:18:38 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:48:34 +0530
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
Subject: Re: [PATCH v7 2/3] PCI: rockchip: Simplify reset control handling by
 using reset_control_bulk*() function
Message-ID: <20241012061834.ksbtcaw3c7iacnye@thinkpad>
References: <20241012050611.1908-1-linux.amoon@gmail.com>
 <20241012050611.1908-3-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012050611.1908-3-linux.amoon@gmail.com>

On Sat, Oct 12, 2024 at 10:36:04AM +0530, Anand Moon wrote:
> Refactor the reset control handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for assert and
> deassert reset controller using reset_control_bulk*() API. Using the
> reset_control_bulk APIs, the reset handling for the core clocks reset
> unit becomes much simpler.
> 

Same comments as previous patch.

> Spilt the reset controller in two groups as pre the RK3399 TRM.

*per

Also please state the TRM name and section for reference.

> After power up, the software driver should de-assert the reset of PCIe PHY,
> then wait the PLL locked by polling the status, if PLL
> has locked, then can de-assert the reset simultaneously
> driver need to De-assert the reset pins simultionaly.
> 
>   PIPE_RESET_N/MGMT_STICKY_RESET_N/MGMT_RESET_N/RESET_N.
> 
> - replace devm_reset_control_get_exclusive() with
> 	devm_reset_control_bulk_get_exclusive().
> - replace reset_control_assert with
> 	reset_control_bulk_assert().
> - replace reset_control_deassert with
> 	reset_control_bulk_deassert().
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
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
>  drivers/pci/controller/pcie-rockchip.c | 151 +++++--------------------
>  drivers/pci/controller/pcie-rockchip.h |  26 +++--
>  2 files changed, 49 insertions(+), 128 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 2777ef0cb599..9a118e2b8cbd 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)

[...]

> +	err = reset_control_bulk_assert(ROCKCHIP_NUM_PM_RSTS,
> +					rockchip->pm_rsts);
> +	if (err)
> +		return dev_err_probe(dev, err, "reset bulk assert pm reset\n");

'Couldn't assert PM resets'

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
> +		return dev_err_probe(dev, err, "reset bulk assert core reset\n");

'Couldn't assert Core resets'

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
> +		dev_err(dev, "reset bulk deassert pm err %d\n", err);

'Couldn't deassert PM resets'

>  		goto err_exit_phy;
>  	}
>  
> @@ -256,31 +181,15 @@ int rockchip_pcie_init_port(struct rockchip_pcie *rockchip)
>  	 * Please don't reorder the deassert sequence of the following
>  	 * four reset pins.

I don't think my earlier comment on this addressed. Why are you changing the
reset order? Why can't you have the resets in below (older) order?

static const char * const rockchip_pci_core_rsts[] = {
	mgmt-sticky",
	"core",
	"mgmt",
	"pipe",
};

Also, this comment should be removed now.

>  	 */
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

'Couldn't deassert Core resets'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

