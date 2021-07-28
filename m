Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12E3D9254
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbhG1Puk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 11:50:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237163AbhG1Puh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 11:50:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA21C6101B;
        Wed, 28 Jul 2021 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627487404;
        bh=Ay0Yvd7KQlvZfhdRdxA0T07GbvNQffMW7YmqzubhdxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MLdxG8zRMgtQdukhEjI9JeorYv5vj6yHNkFePINDNBwEIiYgg7IwpGCQ0IWbzefAl
         qvMB4w8q16p6QkiEJDO5y/UuLJhnHwIGdKVG63HZEkp96ACL2lnuigYdwETPrnxYoY
         bO7LhtLMfgJHP0SeiJ/VEh2i3iXD7+5Yw8gUlsPI+ZdphD/EEldilIr07R/HHSaC4O
         h5tznyEpDBC4C0q0EWH/w0iBzHA9NAypdNElE6pZFWMP6LFJL6y6Ci/l2M4bDMpiTM
         +9l5gUoQMnQ5l+X0AJMva2l+GHSL7hZ0xgC+/x74IBefidx+7kMs0Ftd+7adOBE+8I
         KvkbMesD6YdnQ==
Date:   Wed, 28 Jul 2021 10:50:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] PCI: keystone: Use device_get_match_data()
Message-ID: <20210728155002.GA822338@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210728105558.23871-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 01:55:58PM +0300, Andy Shevchenko wrote:
> Instead of manipulations with OF APIs, use device_get_match_data().
> 
> While at it, drop of_match_ptr() completely and make compiler happy,
> otherwise it complains:
> 
>   pci-keystone.c:1069:34: warning: ‘ks_pcie_of_match’ defined but not used [-Wunused-const-variable=]

These are two separate things and I'd prefer two separate patches.

I have a to-do item on my list to replace of_match_device(), as you
did here.  I originally suggested replacing with
device_get_match_data(), but I think Rob prefers
of_device_get_match_data() because there's really no benefit to the
extra indirection of device_get_match_data().  These are not drivers
that may potentially be used with either ACPI or OF; they're just OF.

Either way, I'd like to see a patch that does this for all drivers in
drivers/pci/controller/ at the same time so they get slightly more
consistent.

Same for the .of_match_table update; a good change that I'd like to
apply universally.  It looks like pcie-spear13xx.c, pcie-armada8k.c,
pci-ftpci100.c, pci-v3-semi.c, pci-xgene.c, pcie-iproc-platform.c also
have the same issue.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index bde3b2824e89..f36ea618a248 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -24,6 +24,7 @@
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/resource.h>
>  #include <linux/signal.h>
> @@ -1091,7 +1092,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	const struct ks_pcie_of_data *data;
> -	const struct of_device_id *match;
>  	enum dw_pcie_device_mode mode;
>  	struct dw_pcie *pci;
>  	struct keystone_pcie *ks_pcie;
> @@ -1108,8 +1108,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	int irq;
>  	int i;
>  
> -	match = of_match_device(of_match_ptr(ks_pcie_of_match), dev);
> -	data = (struct ks_pcie_of_data *)match->data;
> +	data = device_get_match_data(dev);
>  	if (!data)
>  		return -EINVAL;
>  
> @@ -1309,7 +1308,7 @@ static struct platform_driver ks_pcie_driver __refdata = {
>  	.remove = __exit_p(ks_pcie_remove),
>  	.driver = {
>  		.name	= "keystone-pcie",
> -		.of_match_table = of_match_ptr(ks_pcie_of_match),
> +		.of_match_table = ks_pcie_of_match,
>  	},
>  };
>  builtin_platform_driver(ks_pcie_driver);
> -- 
> 2.30.2
> 
