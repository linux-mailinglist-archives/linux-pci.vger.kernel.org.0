Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC8272234
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 13:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIULWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 07:22:17 -0400
Received: from foss.arm.com ([217.140.110.172]:41396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgIULWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Sep 2020 07:22:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9875DD6E;
        Mon, 21 Sep 2020 04:22:16 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9889B3F73B;
        Mon, 21 Sep 2020 04:22:15 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:22:09 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bean Huo <huobean@gmail.com>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, beanhuo@micron.com
Subject: Re: [PATCH] PCI: kirin: Return -EPROBE_DEFER in case the gpio isn't
 ready
Message-ID: <20200921112209.GA2220@e121166-lin.cambridge.arm.com>
References: <20200918123800.19983-1-huobean@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918123800.19983-1-huobean@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 18, 2020 at 02:38:00PM +0200, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> PCI driver might be probed before the gpiochip, so, of_get_named_gpio()
> can return -EPROBE_DEFER. And let kirin_pcie_probe() directly return
> -ENODEV, which will result in the PCIe probe failure and the PCIe
> will not be probed again after the gpiochip driver is loaded.
> 
> Fix the above issue by letting kirin_pcie_probe() return -EPROBE_DEFER in
> such a case.
> 
> Fixes: 6e0832fa432e ("PCI: Collect all native drivers under drivers/pci/controller")

This is certainly not the commit that triggered the issue so I would
remove it. Kirin maintainers are CC'ed, waiting for their ACK.

Lorenzo

> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index e496f51e0152..74b88d158072 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -507,8 +507,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  
>  	kirin_pcie->gpio_id_reset = of_get_named_gpio(dev->of_node,
>  						      "reset-gpios", 0);
> -	if (kirin_pcie->gpio_id_reset < 0)
> +	if (kirin_pcie->gpio_id_reset == -EPROBE_DEFER) {
> +		return -EPROBE_DEFER;
> +	} else if (!gpio_is_valid(kirin_pcie->gpio_id_reset)) {
> +		dev_err(dev, "unable to get a valid gpio pin\n");
>  		return -ENODEV;
> +	}
>  
>  	ret = kirin_pcie_power_on(kirin_pcie);
>  	if (ret)
> -- 
> 2.17.1
> 
