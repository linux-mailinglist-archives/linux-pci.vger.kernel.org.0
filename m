Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23E61E7A85
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgE2K1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 06:27:32 -0400
Received: from foss.arm.com ([217.140.110.172]:34686 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2K13 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 06:27:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C41E11063;
        Fri, 29 May 2020 03:27:28 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31BF23F52E;
        Fri, 29 May 2020 03:27:27 -0700 (PDT)
Date:   Fri, 29 May 2020 11:27:24 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] PCI: tegra194: Fix runtime PM imbalance on error
Message-ID: <20200529102724.GB12270@e121166-lin.cambridge.arm.com>
References: <20200521031355.7022-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521031355.7022-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 21, 2020 at 11:13:49AM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to pci/tegra, thanks.

Lorenzo

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
