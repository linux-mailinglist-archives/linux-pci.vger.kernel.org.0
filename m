Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F16731041B5
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 18:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbfKTRFh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 12:05:37 -0500
Received: from foss.arm.com ([217.140.110.172]:43088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbfKTRFg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 12:05:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6A3A1FB;
        Wed, 20 Nov 2019 09:05:35 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943FE3F703;
        Wed, 20 Nov 2019 09:05:34 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:05:32 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     shawn.lin@rock-chips.com, andrew.murray@arm.com,
        bhelgaas@google.com, heiko@sntech.de, lgirdwood@gmail.com,
        broonie@kernel.org, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] PCI: rockchip: Make some regulators non-optional
Message-ID: <20191120170532.GC3279@e121166-lin.cambridge.arm.com>
References: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eebc002101931012d337cda23d18f85b0326361.1573908530.git.robin.murphy@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 16, 2019 at 12:54:19PM +0000, Robin Murphy wrote:
> The 0V9 and 1V8 supplies power the PCIe block in the SoC itself, and
> are thus fundamental to PCIe being usable at all. As such, it makes
> sense to treat them as non-optional and rely on dummy regulators if
> not explicitly described.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 69 ++++++++-------------
>  1 file changed, 25 insertions(+), 44 deletions(-)

Applied to pci/rockchip, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index ef8e677ce9d1..68525f8ac4d9 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -620,19 +620,13 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
>  		dev_info(dev, "no vpcie3v3 regulator found\n");
>  	}
>  
> -	rockchip->vpcie1v8 = devm_regulator_get_optional(dev, "vpcie1v8");
> -	if (IS_ERR(rockchip->vpcie1v8)) {
> -		if (PTR_ERR(rockchip->vpcie1v8) != -ENODEV)
> -			return PTR_ERR(rockchip->vpcie1v8);
> -		dev_info(dev, "no vpcie1v8 regulator found\n");
> -	}
> +	rockchip->vpcie1v8 = devm_regulator_get(dev, "vpcie1v8");
> +	if (IS_ERR(rockchip->vpcie1v8))
> +		return PTR_ERR(rockchip->vpcie1v8);
>  
> -	rockchip->vpcie0v9 = devm_regulator_get_optional(dev, "vpcie0v9");
> -	if (IS_ERR(rockchip->vpcie0v9)) {
> -		if (PTR_ERR(rockchip->vpcie0v9) != -ENODEV)
> -			return PTR_ERR(rockchip->vpcie0v9);
> -		dev_info(dev, "no vpcie0v9 regulator found\n");
> -	}
> +	rockchip->vpcie0v9 = devm_regulator_get(dev, "vpcie0v9");
> +	if (IS_ERR(rockchip->vpcie0v9))
> +		return PTR_ERR(rockchip->vpcie0v9);
>  
>  	return 0;
>  }
> @@ -658,27 +652,22 @@ static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
>  		}
>  	}
>  
> -	if (!IS_ERR(rockchip->vpcie1v8)) {
> -		err = regulator_enable(rockchip->vpcie1v8);
> -		if (err) {
> -			dev_err(dev, "fail to enable vpcie1v8 regulator\n");
> -			goto err_disable_3v3;
> -		}
> +	err = regulator_enable(rockchip->vpcie1v8);
> +	if (err) {
> +		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
> +		goto err_disable_3v3;
>  	}
>  
> -	if (!IS_ERR(rockchip->vpcie0v9)) {
> -		err = regulator_enable(rockchip->vpcie0v9);
> -		if (err) {
> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> -			goto err_disable_1v8;
> -		}
> +	err = regulator_enable(rockchip->vpcie0v9);
> +	if (err) {
> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> +		goto err_disable_1v8;
>  	}
>  
>  	return 0;
>  
>  err_disable_1v8:
> -	if (!IS_ERR(rockchip->vpcie1v8))
> -		regulator_disable(rockchip->vpcie1v8);
> +	regulator_disable(rockchip->vpcie1v8);
>  err_disable_3v3:
>  	if (!IS_ERR(rockchip->vpcie3v3))
>  		regulator_disable(rockchip->vpcie3v3);
> @@ -897,8 +886,7 @@ static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
>  
>  	rockchip_pcie_disable_clocks(rockchip);
>  
> -	if (!IS_ERR(rockchip->vpcie0v9))
> -		regulator_disable(rockchip->vpcie0v9);
> +	regulator_disable(rockchip->vpcie0v9);
>  
>  	return ret;
>  }
> @@ -908,12 +896,10 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>  	int err;
>  
> -	if (!IS_ERR(rockchip->vpcie0v9)) {
> -		err = regulator_enable(rockchip->vpcie0v9);
> -		if (err) {
> -			dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> -			return err;
> -		}
> +	err = regulator_enable(rockchip->vpcie0v9);
> +	if (err) {
> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> +		return err;
>  	}
>  
>  	err = rockchip_pcie_enable_clocks(rockchip);
> @@ -939,8 +925,7 @@ static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
>  err_pcie_resume:
>  	rockchip_pcie_disable_clocks(rockchip);
>  err_disable_0v9:
> -	if (!IS_ERR(rockchip->vpcie0v9))
> -		regulator_disable(rockchip->vpcie0v9);
> +	regulator_disable(rockchip->vpcie0v9);
>  	return err;
>  }
>  
> @@ -1081,10 +1066,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		regulator_disable(rockchip->vpcie12v);
>  	if (!IS_ERR(rockchip->vpcie3v3))
>  		regulator_disable(rockchip->vpcie3v3);
> -	if (!IS_ERR(rockchip->vpcie1v8))
> -		regulator_disable(rockchip->vpcie1v8);
> -	if (!IS_ERR(rockchip->vpcie0v9))
> -		regulator_disable(rockchip->vpcie0v9);
> +	regulator_disable(rockchip->vpcie1v8);
> +	regulator_disable(rockchip->vpcie0v9);
>  err_set_vpcie:
>  	rockchip_pcie_disable_clocks(rockchip);
>  	return err;
> @@ -1108,10 +1091,8 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>  		regulator_disable(rockchip->vpcie12v);
>  	if (!IS_ERR(rockchip->vpcie3v3))
>  		regulator_disable(rockchip->vpcie3v3);
> -	if (!IS_ERR(rockchip->vpcie1v8))
> -		regulator_disable(rockchip->vpcie1v8);
> -	if (!IS_ERR(rockchip->vpcie0v9))
> -		regulator_disable(rockchip->vpcie0v9);
> +	regulator_disable(rockchip->vpcie1v8);
> +	regulator_disable(rockchip->vpcie0v9);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
