Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B43F6639A5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfGIQpH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jul 2019 12:45:07 -0400
Received: from foss.arm.com ([217.140.110.172]:47154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGIQpH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 12:45:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EAD2B;
        Tue,  9 Jul 2019 09:45:06 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C3C3F59C;
        Tue,  9 Jul 2019 09:45:05 -0700 (PDT)
Date:   Tue, 9 Jul 2019 17:45:03 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     kishon@ti.com, bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: pci-dra7xx: Add missing include file
Message-ID: <20190709164503.GB19709@e121166-lin.cambridge.arm.com>
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
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/dwc for v5.3, thanks.

Lorenzo

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
