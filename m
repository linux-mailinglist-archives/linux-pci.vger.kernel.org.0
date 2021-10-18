Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B294327D8
	for <lists+linux-pci@lfdr.de>; Mon, 18 Oct 2021 21:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhJRTob (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Oct 2021 15:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhJRTob (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Oct 2021 15:44:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9485E60F57;
        Mon, 18 Oct 2021 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634586139;
        bh=sL9bIISzFWXLmkxiyBctOfsH3HvP/CyNjDg9oXri6sw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=swOvq8MdtbJ0gdSpPW1iV1a4gLL6xWh1VP4h+WRTK3nC930K8SL2AVILnvOEAf8Sf
         5UrRJwwFlHUy3NdAHL7REtWQd6KiMW2RrZQ/QPbPCLOvJTE2tSLWppOHFa5XQrBWsh
         AqQeLuaUAFHIPFZWgIXEYIaLpV5VBC5PYU36O8wVqZOUzO4Yiz0HIh2FUpcKCT0Lxl
         0oXObKITDoEHU+rhJLhyX14BoOYFSEdbPcNVybr3UMNWvWRJi8cYUvtVT9gXmJzf5K
         RszevF2H7zHLyV9Q9ev7s+YPpIcxMvNV6o4P/dhXesLlngpGwgNcw83rRBLUynRMyv
         0i4jVj1xvDoqA==
Date:   Mon, 18 Oct 2021 14:42:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Parshuram Raju Thombare <pthombar@cadence.com>
Cc:     kishon@ti.com, tjoseph@cadence.com, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mparab@cadence.com
Subject: Re: [PATCH] PCI: cadence: Disable Function Level Reset support
Message-ID: <20211018194218.GA2248370@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634580445-89772-1-git-send-email-pthombar@cadence.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 18, 2021 at 11:07:25AM -0700, Parshuram Raju Thombare wrote:
> From: Parshuram Thombare <pthombar@cadence.com>
> 
> This patch disables FLR (Function Level Reset) support on all physical
> functions.
> During FLR, the Margining Lane Status and Margining Lane Control
> registers should not be reset, as per PCIe specification.
> However, the Controller incorrectly resets these registers upon FLR.
> This causes PCISIG compliance FLR test to fail. Hence disabling
> FLR on all functions using quirk flag.

Add blank lines between paragraphs.

Write the text in imperative mood, e.g.,

  Disable FLR (Function Level Reset) support on all functions.

It looks like this patch clears PCI_EXP_DEVCAP_FLR in the Device
Capabilities register.  From the point of view of Linux, that means
the device doesn't *advertise* FLR support.

That's different from actualy *disabling* FLR support, but maybe
there's internal logic in the device that ignores
PCI_EXP_DEVCTL_BCR_FLR when PCI_EXP_DEVCAP_FLR is cleared?

> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/pci/controller/cadence/pci-j721e.c       |  3 +++
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 18 +++++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h    |  3 +++
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index ffb176d..635e36c 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -70,6 +70,7 @@ struct j721e_pcie_data {
>  	enum j721e_pcie_mode	mode;
>  	unsigned int		quirk_retrain_flag:1;
>  	unsigned int		quirk_detect_quiet_flag:1;
> +	unsigned int		quirk_disable_flr:1;
>  	u32			linkdown_irq_regfield;
>  	unsigned int		byte_access_allowed:1;
>  };
> @@ -308,6 +309,7 @@ static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
>  static const struct j721e_pcie_data j7200_pcie_ep_data = {
>  	.mode = PCI_MODE_EP,
>  	.quirk_detect_quiet_flag = true,
> +	.quirk_disable_flr = true,
>  };
>  
>  static const struct j721e_pcie_data am64_pcie_rc_data = {
> @@ -510,6 +512,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  			goto err_get_sync;
>  		}
>  		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
> +		ep->quirk_disable_flr = data->quirk_disable_flr;
>  
>  		cdns_pcie = &ep->pcie;
>  		cdns_pcie->dev = dev;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 88e05b9..4b1c4bc 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct device *dev = pcie->dev;
> -	int ret;
> +	int max_epfs = sizeof(epc->function_num_map) * 8;
> +	int ret, value, epf;
>  
>  	/*
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
> @@ -573,6 +574,21 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	 */
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
>  
> +	if (ep->quirk_disable_flr) {
> +		for (epf = 0; epf < max_epfs; epf++) {
> +			if (!(epc->function_num_map & BIT(epf)))
> +				continue;
> +
> +			value = cdns_pcie_ep_fn_readl(pcie, epf,
> +					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
> +					PCI_EXP_DEVCAP);
> +			value &= ~PCI_EXP_DEVCAP_FLR;
> +			cdns_pcie_ep_fn_writel(pcie, epf,
> +					CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET +
> +					PCI_EXP_DEVCAP, value);
> +		}
> +	}
> +
>  	ret = cdns_pcie_start_link(pcie);
>  	if (ret) {
>  		dev_err(dev, "Failed to start link\n");
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 262421e..e978e7c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -123,6 +123,7 @@
>  
>  #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET	0x90
>  #define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET	0xb0
> +#define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
>  #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
>  
>  /*
> @@ -357,6 +358,7 @@ struct cdns_pcie_epf {
>   *        minimize time between read and write
>   * @epf: Structure to hold info about endpoint function
>   * @quirk_detect_quiet_flag: LTSSM Detect Quiet min delay set as quirk
> + * @quirk_disable_flr: Disable FLR (Function Level Reset) quirk flag
>   */
>  struct cdns_pcie_ep {
>  	struct cdns_pcie	pcie;
> @@ -372,6 +374,7 @@ struct cdns_pcie_ep {
>  	spinlock_t		lock;
>  	struct cdns_pcie_epf	*epf;
>  	unsigned int		quirk_detect_quiet_flag:1;
> +	unsigned int		quirk_disable_flr:1;
>  };
>  
>  
> -- 
> 1.9.1
> 
