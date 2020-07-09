Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607EA219DAC
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgGIKZV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 06:25:21 -0400
Received: from foss.arm.com ([217.140.110.172]:48956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGIKZU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 06:25:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8FEB31B;
        Thu,  9 Jul 2020 03:25:19 -0700 (PDT)
Received: from red-moon.cambridge.arm.com (unknown [10.57.12.214])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14DEF3F887;
        Thu,  9 Jul 2020 03:25:17 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:25:12 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hien Dang <hien.dang.eb@renesas.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] PCI: rcar: Fix runtime PM imbalance on error
Message-ID: <20200709102512.GA19855@red-moon.cambridge.arm.com>
References: <20200709064356.8800-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709064356.8800-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 02:43:56PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a corresponding decrement is
> needed on the error handling path to keep the counter balanced.
> 
> Fixes: 0df6150e7ceb ("PCI: rcar: Use runtime PM to control controller
> clock")
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Applied to pci/runtime-pm but you forgot to carry over Yoshihiro's
reviewed-by, please do pay attention to these details.

Lorenzo

> ---
> 
> Changelog:
> 
> v2: - Remove unnecessary 'err_pm_put' label.
>       Refine commit message.
> 
> v3: - Add Fixes tag.
>       Rebase the patch on top of the latest kernel.
> ---
>  drivers/pci/controller/pcie-rcar-host.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index d210a36561be..060c24f5221e 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -986,7 +986,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	err = pm_runtime_get_sync(pcie->dev);
>  	if (err < 0) {
>  		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
> -		goto err_pm_disable;
> +		goto err_pm_put;
>  	}
>  
>  	err = rcar_pcie_get_resources(host);
> @@ -1057,8 +1057,6 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  
>  err_pm_put:
>  	pm_runtime_put(dev);
> -
> -err_pm_disable:
>  	pm_runtime_disable(dev);
>  	pci_free_resource_list(&host->resources);
>  
> -- 
> 2.17.1
> 
