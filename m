Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63E491DB9F0
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgETQmd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 12:42:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETQmd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 12:42:33 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6742065F;
        Wed, 20 May 2020 16:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589992953;
        bh=vfHcESPMyMnkf0mO1OYp41Fy/VqVcbHA1pyxgiFsLz4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=psRBotRKueDUQI2gAuPDPSmpHPsLRbvtO4DLKfQ87/1cLSbBkWzvjQZVuubvI5Z1z
         oNwHeLjMKV1YUt8SF/j33jJ1FAciYKB8qzxAFs3L615nLDY7VrF+5oo+bYljE3hCC3
         WqHmVFc9D5YzrSGuhlY5QV9PJJ8CZc39jIAX9slI=
Date:   Wed, 20 May 2020 11:42:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: fix runtime pm imbalance on error
Message-ID: <20200520164230.GA1100990@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520084012.30190-1-dinghao.liu@zju.edu.cn>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 20, 2020 at 04:40:12PM +0800, Dinghao Liu wrote:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> it returns an error code. Thus a pairing decrement is needed on
> the error handling path to keep the counter balanced.
> 
> Also This driver forgets to call pm_runtime_disable() when
> pm_runtime_get_sync() returns an error code.

  Also, call pm_runtime_disable() when pm_runtime_get_sync() returns
  an error code.

> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/pci/controller/pci-tegra.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 3e64ba6a36a8..00236dd65b5b 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2712,7 +2712,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  	err = pm_runtime_get_sync(pcie->dev);
>  	if (err < 0) {
>  		dev_err(dev, "fail to enable pcie controller: %d\n", err);
> -		goto teardown_msi;
> +		goto pm_runtime_put;
>  	}
>  
>  	host->busnr = bus->start;
> @@ -2746,7 +2746,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  pm_runtime_put:
>  	pm_runtime_put_sync(pcie->dev);
>  	pm_runtime_disable(pcie->dev);
> -teardown_msi:
>  	tegra_pcie_msi_teardown(pcie);
>  put_resources:
>  	tegra_pcie_put_resources(pcie);
> -- 
> 2.17.1
> 
