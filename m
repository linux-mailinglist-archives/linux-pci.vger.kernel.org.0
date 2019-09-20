Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F978B93AA
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 17:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfITPHT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 11:07:19 -0400
Received: from foss.arm.com ([217.140.110.172]:46088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387614AbfITPHT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 11:07:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C27337;
        Fri, 20 Sep 2019 08:07:18 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 144D23F575;
        Fri, 20 Sep 2019 08:07:17 -0700 (PDT)
Date:   Fri, 20 Sep 2019 16:07:14 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, linux-pci@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: include linux/pinctrl/consumer.h
Message-ID: <20190920150714.GK9720@e119886-lin.cambridge.arm.com>
References: <20190920145518.1721180-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920145518.1721180-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 20, 2019 at 04:55:05PM +0200, Arnd Bergmann wrote:
> Without this, we can run into a build failure:
> 
> drivers/pci/controller/dwc/pcie-tegra194.c:1394:8: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror,-Wimplicit-function-declaration]
> 
> Fixes: ab2a50e7602b ("PCI: tegra: Add support to configure sideband pins")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for this. Another fix for this came in earlier today:

https://patchwork.ozlabs.org/patch/1165139/

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Thanks,

Andrew Murray

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09ed8e473cff..f89f5acee72d 100644
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
> 2.20.0
> 
