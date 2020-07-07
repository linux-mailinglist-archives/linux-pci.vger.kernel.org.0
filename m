Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A59216B3E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 13:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgGGLQ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 07:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:41104 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgGGLQ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 07:16:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FB7611B3;
        Tue,  7 Jul 2020 04:16:29 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ADDF3F71E;
        Tue,  7 Jul 2020 04:16:27 -0700 (PDT)
Date:   Tue, 7 Jul 2020 12:16:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] PCI: rcar: Fix runtime PM imbalance on error
Message-ID: <20200707111622.GA14935@e121166-lin.cambridge.arm.com>
References: <20200607093134.6393-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607093134.6393-1-dinghao.liu@zju.edu.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 07, 2020 at 05:31:33PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> the call returns an error code. Thus a corresponding decrement is
> needed on the error handling path to keep the counter balanced.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
> 
> Changelog:
> 
> v2: - Remove unnecessary 'err_pm_put' label.
>       Refine commit message.
> ---
>  drivers/pci/controller/pcie-rcar.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Can you rebase it on top of v5.8-rc1 and resend it with Yoshihiro's tags
please ?

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> index 759c6542c5c8..f9595ab54bc4 100644
> --- a/drivers/pci/controller/pcie-rcar.c
> +++ b/drivers/pci/controller/pcie-rcar.c
> @@ -1143,7 +1143,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	err = rcar_pcie_get_resources(pcie);
>  	if (err < 0) {
>  		dev_err(dev, "failed to request resources: %d\n", err);
> -		goto err_pm_put;
> +		goto err_pm_disable;
>  	}
>  
>  	err = clk_prepare_enable(pcie->bus_clk);
> @@ -1206,10 +1206,8 @@ static int rcar_pcie_probe(struct platform_device *pdev)
>  	irq_dispose_mapping(pcie->msi.irq2);
>  	irq_dispose_mapping(pcie->msi.irq1);
>  
> -err_pm_put:
> -	pm_runtime_put(dev);
> -
>  err_pm_disable:
> +	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);
>  	pci_free_resource_list(&pcie->resources);
>  
> -- 
> 2.17.1
> 
