Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA10C1203AB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 12:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLPLUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 06:20:46 -0500
Received: from foss.arm.com ([217.140.110.172]:50666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbfLPLUq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 06:20:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B9901FB;
        Mon, 16 Dec 2019 03:20:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 144D73F6CF;
        Mon, 16 Dec 2019 03:20:44 -0800 (PST)
Date:   Mon, 16 Dec 2019 11:20:43 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     David Engraf <david.engraf@sysgo.com>
Cc:     thierry.reding@gmail.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: tegra: Fix return value check of
 pm_runtime_get_sync
Message-ID: <20191216112043.GS24359@e119886-lin.cambridge.arm.com>
References: <20191216102208.GO24359@e119886-lin.cambridge.arm.com>
 <20191216111825.28136-1-david.engraf@sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216111825.28136-1-david.engraf@sysgo.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 16, 2019 at 12:18:25PM +0100, David Engraf wrote:
> pm_runtime_get_sync() returns the device's usage counter. This might
> be >0 if the device is already powered up or CONFIG_PM is disabled.
> 
> Abort probe function on real error only.
> 
> Fixes: da76ba50963b ("PCI: tegra: Add power management support")
> Signed-off-by: David Engraf <david.engraf@sysgo.com>

Thanks for this - apologies my feedback wasn't as quick as your respin.

Acked-by: Andrew Murray <andrew.murray@arm.com>

> ---
>  drivers/pci/controller/pci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 673a1725ef38..090b632965e2 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2798,7 +2798,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>  
>  	pm_runtime_enable(pcie->dev);
>  	err = pm_runtime_get_sync(pcie->dev);
> -	if (err) {
> +	if (err < 0) {
>  		dev_err(dev, "fail to enable pcie controller: %d\n", err);
>  		goto teardown_msi;
>  	}
> -- 
> 2.17.1
> 
