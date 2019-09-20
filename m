Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E349BB97C6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 21:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfITT26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 15:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfITT26 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 15:28:58 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA4E208C0;
        Fri, 20 Sep 2019 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569007738;
        bh=74r8ZJjQIvij0Kl/ZCXuYb2a9V0vrC6gFXaeoFbOTiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H3bcivo4sx/VZkeUBMAfpPoONS2tWRHP8Jw5KVhHP0tQjDJ7esoRgizBDQYCAghgi
         JGHiHuNrQ7ZEPkbf1SwKY1hqVRf2RnBWQ+jAJNPrNI3Bruxf71MicC+/65s0LvkqXn
         p+QKnNYX3+iU3kLKFy/NGad4bisMMzg9fSf5utPQ=
Date:   Fri, 20 Sep 2019 14:28:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        treding@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] PCI: tegra: Add missing include file
Message-ID: <20190920192855.GA226906@google.com>
References: <20190920014807.38288-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920014807.38288-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 20, 2019 at 09:48:07AM +0800, YueHaibing wrote:
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

Thanks, I folded this into ab2a50e7602b (with the include in alpha
order) and updated my "next" branch.

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09ed8e4..b219d3b2 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -28,6 +28,7 @@
>  #include <linux/reset.h>
>  #include <linux/resource.h>
>  #include <linux/types.h>
> +#include <linux/pinctrl/consumer.h>
>  #include "pcie-designware.h"
>  #include <soc/tegra/bpmp.h>
>  #include <soc/tegra/bpmp-abi.h>
> -- 
> 2.7.4
> 
> 
