Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266C11DD0ED
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 17:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgEUPQX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 11:16:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbgEUPQX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 11:16:23 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F64E204EA;
        Thu, 21 May 2020 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590074182;
        bh=j+ATZyTEUqzaa7C9cjX2VyqS6H/0GtWSC8aQQUq6YYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gNLoP7M3nC2UP2goc/ysaJwkL6GkbN6DWGIMDkWgKdq3+uYPqvVHNKIGKRyDGlFvv
         4oh6IciHAv02TqYvn1C3gTXnsQWpnu9y1djjHjVlbmORSpY0f9RZc9g0OX7qw6dKUK
         LqaWB6Sk/KL5NQSodyrBk8oXXOcrnd8AQTePYrrU=
Date:   Thu, 21 May 2020 10:16:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] [v2] PCI: tegra194: Fix runtime PM imbalance on error
Message-ID: <20200521151620.GA1135365@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521031355.7022-1-dinghao.liu@zju.edu.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, linux-pm]

On Thu, May 21, 2020 at 11:13:49AM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.

I didn't realize there were so many drivers with the exact same issue.
Can we just squash these all into a single patch so we can see them
all together?

Hmm.  There are over 1300 callers of pm_runtime_get_sync(), and it
looks like many of them have similar issues, i.e., they have a pattern
like this

  ret = pm_runtime_get_sync(dev);
  if (ret < 0)
    return;

  pm_runtime_put(dev);

where there is not a pm_runtime_put() to match every
pm_runtime_get_sync().  Random sample:

  nds32_pmu_reserve_hardware
  sata_rcar_probe
  exynos_trng_probe
  ks_sa_rng_probe
  omap_aes_probe
  sun8i_ss_probe
  omap_aes_probe
  zynq_gpio_probe
  amdgpu_hwmon_show_power_avg
  mtk_crtc_ddp_hw_init
  ...

Surely I'm missing something and these aren't all broken, right?

Maybe we could put together a coccinelle script to scan the tree for
this issue?

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index ae30a2fd3716..2c0d2ce16b47 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1623,7 +1623,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  	ret = pinctrl_pm_select_default_state(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to configure sideband pins: %d\n", ret);
> -		goto fail_pinctrl;
> +		goto fail_pm_get_sync;
>  	}
>  
>  	tegra_pcie_init_controller(pcie);
> @@ -1650,9 +1650,8 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
>  
>  fail_host_init:
>  	tegra_pcie_deinit_controller(pcie);
> -fail_pinctrl:
> -	pm_runtime_put_sync(dev);
>  fail_pm_get_sync:
> +	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	return ret;
>  }
> -- 
> 2.17.1
> 
