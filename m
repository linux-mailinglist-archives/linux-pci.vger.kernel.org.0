Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C18598B9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfF1Kql (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 06:46:41 -0400
Received: from foss.arm.com ([217.140.110.172]:44966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbfF1Kql (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 Jun 2019 06:46:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5694728;
        Fri, 28 Jun 2019 03:46:40 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 030B13F718;
        Fri, 28 Jun 2019 03:46:38 -0700 (PDT)
Date:   Fri, 28 Jun 2019 11:46:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: tegra: use correct gpio/consumer.h header
Message-ID: <20190628104630.GA19883@e121166-lin.cambridge.arm.com>
References: <20190628102953.2369879-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628102953.2369879-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 28, 2019 at 12:29:45PM +0200, Arnd Bergmann wrote:
> linux/gpio.h is not the correct header for modern interfaces and
> causes a build failure without CONFIG_GPIOLIB:
> 
> drivers/pci/controller/pci-tegra.c: In function 'tegra_pcie_port_reset':
> drivers/pci/controller/pci-tegra.c:551:3: error: implicit declaration of function 'gpiod_set_value'; did you mean 'gpio_set_value'? [-Werror=implicit-function-declaration]
>    gpiod_set_value(port->reset_gpio, 1);
>    ^~~~~~~~~~~~~~~
> 
> Use linux/gpio/consumer.h instead.
> 
> Fixes: 5e5e9c23f82a ("PCI: tegra: Add support for GPIO based PERST#")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Squashed in the respective commit in pci/tegra, thanks for the fix
Arnd.

Lorenzo

> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 9cc03a2549c0..1775b88c0aec 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -17,7 +17,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/export.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
>  #include <linux/irq.h>
> -- 
> 2.20.0
> 
