Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F96094B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2019 17:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfGEP3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Jul 2019 11:29:12 -0400
Received: from foss.arm.com ([217.140.110.172]:42094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfGEP3M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Jul 2019 11:29:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 135C328;
        Fri,  5 Jul 2019 08:29:12 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9E33F246;
        Fri,  5 Jul 2019 08:29:11 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:29:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>, kishon@ti.com
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: pci-dra7xx: Add missing include file
Message-ID: <20190705152905.GA6284@e121166-lin.cambridge.arm.com>
References: <20190614154044.4972-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614154044.4972-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 11:40:44PM +0800, YueHaibing wrote:
> Fix build error:
> 
> drivers/pci/controller/dwc/pci-dra7xx.c:
>  In function dra7xx_pcie_probe:
> drivers/pci/controller/dwc/pci-dra7xx.c:777:10:
>  error: implicit declaration of function devm_gpiod_get_optional;
>  did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
> 
>   reset = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);

Adding the reason (in particular the config options) that triggers
this error would not hurt.

Kishon please let me know if I can merge it (ACK it if so).

Thanks,
Lorenzo

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)


> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 419451e..4234ddb 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -26,6 +26,7 @@
>  #include <linux/types.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "../../pci.h"
>  #include "pcie-designware.h"
> -- 
> 2.7.4
> 
> 
