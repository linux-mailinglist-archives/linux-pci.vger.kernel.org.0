Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF70A0C2C
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 23:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfH1VI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 17:08:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfH1VI6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Aug 2019 17:08:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 122A9337;
        Wed, 28 Aug 2019 14:08:58 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8496A3F718;
        Wed, 28 Aug 2019 14:08:56 -0700 (PDT)
Date:   Wed, 28 Aug 2019 22:08:55 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/5] PCI: exynos: Properly handle optional PHYs
Message-ID: <20190828210854.GC14582@e119886-lin.cambridge.arm.com>
References: <20190828163636.12967-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828163636.12967-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 06:36:32PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> devm_of_phy_get() can fail for a number of resides besides probe
> deferral. It can for example return -ENOMEM if it runs out of memory as
> it tries to allocate devres structures. Propagating only -EPROBE_DEFER
> is problematic because it results in these legitimately fatal errors
> being treated as "PHY not specified in DT".
> 
> What we really want is to ignore the optional PHYs only if they have not
> been specified in DT. devm_of_phy_get() returns -ENODEV in this case, so
> that's the special case that we need to handle. So we propagate all
> errors, except -ENODEV, so that real failures will still cause the
> driver to fail probe.
> 
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index cee5f2f590e2..14a6ba4067fb 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -465,7 +465,7 @@ static int __init exynos_pcie_probe(struct platform_device *pdev)
>  
>  	ep->phy = devm_of_phy_get(dev, np, NULL);
>  	if (IS_ERR(ep->phy)) {
> -		if (PTR_ERR(ep->phy) == -EPROBE_DEFER)
> +		if (PTR_ERR(ep->phy) != -ENODEV)
>  			return PTR_ERR(ep->phy);
>  
>  		ep->phy = NULL;

Once you've applied Bjorn's feedback you can add:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> -- 
> 2.22.0
> 
