Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBAAA122ACD
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 12:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLQL6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 06:58:31 -0500
Received: from foss.arm.com ([217.140.110.172]:34626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbfLQL6b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 06:58:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0946D328;
        Tue, 17 Dec 2019 03:58:30 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76AFA3F6CF;
        Tue, 17 Dec 2019 03:58:29 -0800 (PST)
Date:   Tue, 17 Dec 2019 11:58:27 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 04/13] PCI: cadence: Add support to start link and verify
 link status
Message-ID: <20191217115826.GA24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-5-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:38PM +0530, Kishon Vijay Abraham I wrote:
> Add cdns_pcie_ops to start link and verify link status. The registers
> to start link and to check link status is in Platform specific PCIe
> wrapper. Add support for platform specific drivers to add callback
> functions for the PCIe Cadence core to start link and verify link status.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  8 ++++++
>  .../controller/cadence/pcie-cadence-host.c    | 28 +++++++++++++++++++
>  drivers/pci/controller/cadence/pcie-cadence.h | 23 +++++++++++++++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 560f22b4d165..088394b6be04 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -355,8 +355,10 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  {
>  	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
>  	struct cdns_pcie *pcie = &ep->pcie;
> +	struct device *dev = pcie->dev;
>  	struct pci_epf *epf;
>  	u32 cfg;
> +	int ret;
>  
>  	/*
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
> @@ -367,6 +369,12 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  		cfg |= BIT(epf->func_no);
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
>  
> +	ret = cdns_pcie_start_link(pcie, true);
> +	if (ret) {
> +		dev_err(dev, "Failed to start link\n");
> +		return ret;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index ccf55e143e1d..0929554f5a81 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -3,6 +3,7 @@
>  // Cadence PCIe host controller driver.
>  // Author: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
>  
> +#include <linux/delay.h>
>  #include <linux/kernel.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> @@ -201,6 +202,23 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return err;
>  }
>  
> +static int cdns_pcie_host_wait_for_link(struct cdns_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	int retries;
> +
> +	/* Check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (cdns_pcie_is_link_up(pcie)) {
> +			dev_info(dev, "Link up\n");
> +			return 0;
> +		}
> +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +	}
> +
> +	return -ETIMEDOUT;
> +}

This patch looks fine, except this function (above) is identical to
dw_pcie_wait_for_link, advk_pcie_wait_for_link and nwl_wait_for_link. Even
the definitions of LINK_WAIT_USLEEP_xx are the same.

I don't see any justification to duplicating this again - can you consolidate
these functions to something that all controller drivers can use?

Thanks,

Andrew Murray

> +
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>  	struct device *dev = rc->pcie.dev;
> @@ -254,6 +272,16 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  
>  	pcie->mem_res = res;
>  
> +	ret = cdns_pcie_start_link(pcie, true);
> +	if (ret) {
> +		dev_err(dev, "Failed to start link\n");
> +		return ret;
> +	}
> +
> +	ret = cdns_pcie_host_wait_for_link(pcie);
> +	if (ret)
> +		dev_dbg(dev, "PCIe link never came up\n");
> +
>  	ret = cdns_pcie_host_init(dev, &resources, rc);
>  	if (ret)
>  		goto err_init;
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index d0d91c69fa1d..f0395eaf9df5 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -10,6 +10,11 @@
>  #include <linux/pci.h>
>  #include <linux/phy/phy.h>
>  
> +/* Parameters for the waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES	10
> +#define LINK_WAIT_USLEEP_MIN	90000
> +#define LINK_WAIT_USLEEP_MAX	100000
> +
>  /*
>   * Local Management Registers
>   */
> @@ -226,6 +231,8 @@ enum cdns_pcie_msg_routing {
>  struct cdns_pcie_ops {
>  	u32	(*read)(void __iomem *addr, int size);
>  	void	(*write)(void __iomem *addr, int size, u32 value);
> +	int	(*start_link)(struct cdns_pcie *pcie, bool start);
> +	bool	(*is_link_up)(struct cdns_pcie *pcie);
>  };
>  
>  /**
> @@ -447,6 +454,22 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  	return readl(addr);
>  }
>  
> +static inline int cdns_pcie_start_link(struct cdns_pcie *pcie, bool start)
> +{
> +	if (pcie->ops->start_link)
> +		return pcie->ops->start_link(pcie, start);
> +
> +	return 0;
> +}
> +
> +static inline bool cdns_pcie_is_link_up(struct cdns_pcie *pcie)
> +{
> +	if (pcie->ops->is_link_up)
> +		return pcie->ops->is_link_up(pcie);
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_PCIE_CADENCE_HOST
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
>  #else
> -- 
> 2.17.1
> 
