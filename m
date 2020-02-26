Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F37D816FDBA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBZLbR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 06:31:17 -0500
Received: from foss.arm.com ([217.140.110.172]:34384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBZLbR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 06:31:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E99611FB;
        Wed, 26 Feb 2020 03:31:16 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D233FA00;
        Wed, 26 Feb 2020 03:31:16 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:31:05 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Jun Nie <jun.nie@linaro.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: histb: Correct PCIe reset operation
Message-ID: <20200226113105.GA16925@e121166-lin.cambridge.arm.com>
References: <20200109032851.13377-1-shawn.guo@linaro.org>
 <20200109032851.13377-3-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109032851.13377-3-shawn.guo@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 09, 2020 at 11:28:51AM +0800, Shawn Guo wrote:
> The PCIe reset via GPIO in the driver never worked as expected.  Per
> "Power Sequencing and Reset Signal Timings" table in
> PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, the PERST# should be
> deasserted after minimum of 100us once REFCLK is stable.
> 
> The assertion has been done when the GPIO is being requested, and
> deassertion should be done in host enabling rather than disabling. Also
> a bit wait is added to ensure device get ready after reset.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-histb.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

Shawn,

this looks like a fix, please tag it as such and let me know if
it has to be backported, in which case also the previous patch
should I assume.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 112254619ed0..67c27a8036c7 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -219,9 +219,6 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
>  	clk_disable_unprepare(hipcie->sys_clk);
>  	clk_disable_unprepare(hipcie->bus_clk);
>  
> -	if (hipcie->reset_gpio)
> -		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
> -
>  	if (hipcie->vpcie)
>  		regulator_disable(hipcie->vpcie);
>  }
> @@ -242,9 +239,6 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
>  		}
>  	}
>  
> -	if (hipcie->reset_gpio)
> -		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
> -
>  	ret = clk_prepare_enable(hipcie->bus_clk);
>  	if (ret) {
>  		dev_err(dev, "cannot prepare/enable bus clk\n");
> @@ -278,6 +272,20 @@ static int histb_pcie_host_enable(struct pcie_port *pp)
>  	reset_control_assert(hipcie->bus_reset);
>  	reset_control_deassert(hipcie->bus_reset);
>  
> +	if (hipcie->reset_gpio) {
> +		/*
> +		 * "Power Sequencing and Reset Signal Timings" table in
> +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, indicates
> +		 * PERST# should be deasserted after minimum of 100us
> +		 * once REFCLK is stable.
> +		 */
> +		usleep_range(100, 200);
> +		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
> +
> +		/* wait 1ms for device to be ready */
> +		usleep_range(1000, 2000);
> +	}
> +
>  	return 0;
>  
>  err_aux_clk:
> -- 
> 2.17.1
> 
