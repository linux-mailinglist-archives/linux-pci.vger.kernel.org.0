Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAD511E20D
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 11:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfLMKgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 05:36:07 -0500
Received: from foss.arm.com ([217.140.110.172]:54082 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfLMKgH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 05:36:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03CAB1FB;
        Fri, 13 Dec 2019 02:36:06 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3DC3F718;
        Fri, 13 Dec 2019 02:36:05 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:36:03 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH 1/1] PCI: dwc: intel: fix nitpicks
Message-ID: <20191213103602.GL24359@e119886-lin.cambridge.arm.com>
References: <457c714ba7a73075291778b3436fd96feca7c532.1576144419.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457c714ba7a73075291778b3436fd96feca7c532.1576144419.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 01:19:43PM +0800, Dilip Kota wrote:
> Fix the minor nits pointed in review of
> Intel PCIe driver and PCIe DesignWare core.
> No functional change expected.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c |  3 +--
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 30 ++++++++++++++--------------
>  2 files changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 479e250695a0..681548c88282 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -12,10 +12,9 @@
>  #include <linux/of.h>
>  #include <linux/types.h>
>  
> +#include "../../pci.h"
>  #include "pcie-designware.h"
>  
> -extern const unsigned char pcie_link_speed[];
> -
>  /*
>   * These interfaces resemble the pci_find_*capability() interfaces, but these
>   * are for configuring host controllers, which are bridges *to* PCI devices but
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 8eada8f027bb..fc2a12212dec 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -57,9 +57,9 @@
>  #define RESET_INTERVAL_MS		100
>  
>  struct intel_pcie_soc {
> -	unsigned int pcie_ver;
> -	unsigned int pcie_atu_offset;
> -	u32 num_viewport;
> +	unsigned int	pcie_ver;
> +	unsigned int	pcie_atu_offset;
> +	u32		num_viewport;
>  };
>  
>  struct intel_pcie_port {
> @@ -192,7 +192,7 @@ static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>  	if (IS_ERR(lpp->reset_gpio)) {
>  		ret = PTR_ERR(lpp->reset_gpio);
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
> +			dev_err(dev, "Failed to request PCIe GPIO: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -265,7 +265,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>  	if (IS_ERR(lpp->core_clk)) {
>  		ret = PTR_ERR(lpp->core_clk);
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get clks: %d\n", ret);
> +			dev_err(dev, "Failed to get clks: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -273,13 +273,13 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>  	if (IS_ERR(lpp->core_rst)) {
>  		ret = PTR_ERR(lpp->core_rst);
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get resets: %d\n", ret);
> +			dev_err(dev, "Failed to get resets: %d\n", ret);
>  		return ret;
>  	}
>  
>  	ret = device_property_match_string(dev, "device_type", "pci");
>  	if (ret) {
> -		dev_err(dev, "failed to find pci device type: %d\n", ret);
> +		dev_err(dev, "Failed to find pci device type: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -300,7 +300,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>  	if (IS_ERR(lpp->phy)) {
>  		ret = PTR_ERR(lpp->phy);
>  		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
> +			dev_err(dev, "Couldn't get pcie-phy: %d\n", ret);
>  		return ret;
>  	}
>  
> @@ -445,9 +445,11 @@ static int intel_pcie_rc_init(struct pcie_port *pp)
>  	return intel_pcie_host_setup(lpp);
>  }
>  
> -int intel_pcie_msi_init(struct pcie_port *pp)
> +/*
> + * Dummy function so that DW core doesn't configure MSI
> + */
> +static int intel_pcie_msi_init(struct pcie_port *pp)
>  {
> -	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
>  	return 0;
>  }
>  
> @@ -508,19 +510,17 @@ static int intel_pcie_probe(struct platform_device *pdev)
>  
>  	ret = dw_pcie_host_init(pp);
>  	if (ret) {
> -		dev_err(dev, "cannot initialize host\n");
> +		dev_err(dev, "Cannot initialize host\n");
>  		return ret;
>  	}
>  
>  	/*
>  	 * Intel PCIe doesn't configure IO region, so set viewport
> -	 * to not to perform IO region access.
> +	 * to not perform IO region access.
>  	 */
>  	pci->num_viewport = data->num_viewport;
>  
> -	dev_info(dev, "Intel PCIe Root Complex Port init done\n");
> -
> -	return ret;
> +	return 0;
>  }

I'll ask Lorenzo to squash this in when he returns.

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

Thanks,

Andrew Murray

>  
>  static const struct dev_pm_ops intel_pcie_pm_ops = {
> -- 
> 2.11.0
> 
