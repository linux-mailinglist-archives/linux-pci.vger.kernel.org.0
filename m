Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D906DB89AC
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 05:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406042AbfITDRd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Sep 2019 23:17:33 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2790 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405721AbfITDRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Sep 2019 23:17:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d8444d20000>; Thu, 19 Sep 2019 20:17:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 19 Sep 2019 20:17:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 19 Sep 2019 20:17:32 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Sep
 2019 03:17:32 +0000
Received: from [10.25.73.234] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Sep
 2019 03:17:28 +0000
Subject: Re: [PATCH -next] PCI: tegra: Add missing include file
To:     YueHaibing <yuehaibing@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <andrew.murray@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <treding@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190920014807.38288-1-yuehaibing@huawei.com>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <1c864f34-a2a2-0057-5768-ed992871e927@nvidia.com>
Date:   Fri, 20 Sep 2019 08:47:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920014807.38288-1-yuehaibing@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568949458; bh=8VvBMAhlupWkjElUkwb5koZLPZoxvhNO2s04Qy7oytM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=W6sz7fe2uDVN07YAbgnFgJb3HF358KpMHAQbbem2SPN6jA5NUEYJnoW/WHNOmQ4PS
         9fyoFu0ALAb+MznhImWLXoxxwnCDSXA4rId7LXJev0UoFIkcmz55Tfo6q7Ygomr2nX
         V0rEPqBllQuhQp81uijYKDezBK+/9s82+KWYnu3f9eBQP6p8PJQF0PlKjvi5YyJI5i
         +VP7yoyd1p4JN7aoXIymClSPm4zLSpK60gQq4W6xeuBuTTTCK7kwlGdltCLstkQebI
         EzHh4x6vdNIJIvpxaEsv9w1dImQJ0sVaqY9fqzE3jwyDR5z0oOPa2qim0zdf+IjgMd
         UO4SwdagAdu0Q==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/20/2019 7:18 AM, YueHaibing wrote:
> Fix build error without CONFIG_PINCTRL
> 
> drivers/pci/controller/dwc/pcie-tegra194.c: In function tegra_pcie_config_rp:
> drivers/pci/controller/dwc/pcie-tegra194.c:1394:8: error: implicit declaration of function pinctrl_pm_select_default_state;
>   did you mean prandom_seed_full_state? [-Werror=implicit-function-declaration]
>    ret = pinctrl_pm_select_default_state(dev);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          prandom_seed_full_state
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: ab2a50e7602b ("PCI: tegra: Add support to configure sideband pins")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/pci/controller/dwc/pcie-tegra194.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 09ed8e4..b219d3b2 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -28,6 +28,7 @@
>   #include <linux/reset.h>
>   #include <linux/resource.h>
>   #include <linux/types.h>
> +#include <linux/pinctrl/consumer.h>
>   #include "pcie-designware.h"
>   #include <soc/tegra/bpmp.h>
>   #include <soc/tegra/bpmp-abi.h>
> 

Thanks for pushing this change.

Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
