Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 118DCB93D3
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 17:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfITPRo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 11:17:44 -0400
Received: from foss.arm.com ([217.140.110.172]:46260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbfITPRo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 11:17:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE67E337;
        Fri, 20 Sep 2019 08:17:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693133F575;
        Fri, 20 Sep 2019 08:17:42 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:17:36 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     andrew.murray@arm.com, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] PCI: tegra: Add missing include file
Message-ID: <20190920151736.GA10172@e121166-lin.cambridge.arm.com>
References: <20190920014807.38288-1-yuehaibing@huawei.com>
 <20190920103925.34404-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920103925.34404-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 20, 2019 at 06:39:25PM +0800, YueHaibing wrote:
> Fix build error without CONFIG_PINCTRL
> 
> drivers/pci/controller/dwc/pcie-tegra194.c: In function tegra_pcie_config_rp:
> drivers/pci/controller/dwc/pcie-tegra194.c:1394:8: error: implicit declaration of function pinctrl_pm_select_default_state;
>  did you mean prandom_seed_full_state? [-Werror=implicit-function-declaration]
>   ret = pinctrl_pm_select_default_state(dev);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         prandom_seed_full_state
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ab2a50e7602b ("PCI: tegra: Add support to configure sideband pins")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> v2: keep alphabetical order
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)

Squashed in the original commit and pushed out pci/tegra
again.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09ed8e4..f89f5ac 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> -- 
> 2.7.4
> 
> 
