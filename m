Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9D24315E0
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhJRKXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 06:23:52 -0400
Received: from foss.arm.com ([217.140.110.172]:35108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232132AbhJRKXm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 06:23:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C6FED1;
        Mon, 18 Oct 2021 03:21:31 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7E173F70D;
        Mon, 18 Oct 2021 03:21:29 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:21:27 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Songxiaowei <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 09/10] PCI: kirin: fix poweroff sequence
Message-ID: <20211018102127.GD17152@lpieralisi>
References: <cover.1634539769.git.mchehab+huawei@kernel.org>
 <8116a4ddaaeda8dd056e80fa0ee506c5c6f42ca7.1634539769.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8116a4ddaaeda8dd056e80fa0ee506c5c6f42ca7.1634539769.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 18, 2021 at 08:07:34AM +0100, Mauro Carvalho Chehab wrote:
> This driver currently doesn't call dw_pcie_host_deinit()
> at the .remove() callback. This can cause an OOPS if the driver
> is unbound.

This looks like a fix, it has to be marked as such.

> While here, add a poweroff function, in order to abstract
> between the internal and external PHY logic.
> 
> Acked-by: Xiaowei Song <songxiaowei@hisilicon.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> See [PATCH v13 00/10] at: https://lore.kernel.org/all/cover.1634539769.git.mchehab+huawei@kernel.org/
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 30 ++++++++++++++++---------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index b17a194cf78d..ffc63d12f8ed 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -680,6 +680,23 @@ static const struct dw_pcie_host_ops kirin_pcie_host_ops = {
>  	.host_init = kirin_pcie_host_init,
>  };
>  
> +static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
> +{
> +	int i;
> +
> +	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
> +		return hi3660_pcie_phy_power_off(kirin_pcie);
> +
> +	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
> +		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
> +	}

It looks like you are adding functionality here (ie gpio), not
just wrapping common code in a function.

Also, remove the braces, they aren't needed.

Lorenzo

> +
> +	phy_power_off(kirin_pcie->phy);
> +	phy_exit(kirin_pcie->phy);
> +
> +	return 0;
> +}
> +
>  static int kirin_pcie_power_on(struct platform_device *pdev,
>  			       struct kirin_pcie *kirin_pcie)
>  {
> @@ -725,12 +742,7 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
>  
>  	return 0;
>  err:
> -	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY) {
> -		hi3660_pcie_phy_power_off(kirin_pcie);
> -	} else {
> -		phy_power_off(kirin_pcie->phy);
> -		phy_exit(kirin_pcie->phy);
> -	}
> +	kirin_pcie_power_off(kirin_pcie);
>  
>  	return ret;
>  }
> @@ -739,11 +751,9 @@ static int __exit kirin_pcie_remove(struct platform_device *pdev)
>  {
>  	struct kirin_pcie *kirin_pcie = platform_get_drvdata(pdev);
>  
> -	if (kirin_pcie->type == PCIE_KIRIN_INTERNAL_PHY)
> -		return hi3660_pcie_phy_power_off(kirin_pcie);
> +	dw_pcie_host_deinit(&kirin_pcie->pci->pp);
>  
> -	phy_power_off(kirin_pcie->phy);
> -	phy_exit(kirin_pcie->phy);
> +	kirin_pcie_power_off(kirin_pcie);
>  
>  	return 0;
>  }
> -- 
> 2.31.1
> 
