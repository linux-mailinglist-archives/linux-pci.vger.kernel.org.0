Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1425A344E25
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 19:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCVSLG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 14:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230290AbhCVSKl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Mar 2021 14:10:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D38A86146D;
        Mon, 22 Mar 2021 18:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616436635;
        bh=TgnCFVsKpOMGjLBJ+pPDTr3uNsWz+q9pH2GREjZP+wE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jWW47/zAPGuqha4hqpoNci5AmceZnx/M6hTEICsrSpAQI/1KLi7KlXfpJUa/Gkqlf
         7gSXbTRNmyGUqrB/9YLSteUiC9Ku8qPQl42IqxRa/0Ma1BBl2cEfkJabvbEJNnjSwy
         XGHgGSr1XalPVNc5fvS663wYJQhFY8VWrKOTmp2OWfH+qQMB0hBfGaaeprwApqRysX
         O1yOLjvaNHFDikVQNBRpHKJfVttH/AclHT7X5OXHJaCFY1eikxJ2oPSa0fYv/6uGDM
         xICMKV3xcHR5cnNpgrzjeJ/yuxTefRdWHmG3TmzkIzpQJpBEVzAT8pXGRlUlVBzxgB
         uBgK+337iXpAA==
Date:   Mon, 22 Mar 2021 13:10:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
Message-ID: <20210322181033.GA492224@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 25, 2021 at 12:48:03PM +0800, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> In the dw_pcie_ep_init(), it depends on the detected iATU region
> numbers to allocate the in/outbound window management bit map.
> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
> of iATU windows").
> 
> So this patch move the iATU region detection into a new function,
> move forward the detection to the very beginning of functions
> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
> from the dw_pcie_setup(), since it's more like a software
> perspective initialization step than hardware setup.
> 
> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Applied to for-linus for v5.12, with stable tag for v5.11, thanks!

> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>  drivers/pci/controller/dwc/pcie-designware-host.c |  2 ++
>  drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  4 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index bcd1cd9ba8c8..fcf935bf6f5e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -707,6 +707,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		}
>  	}
>  
> +	dw_pcie_iatu_detect(pci);
> +
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
>  		return -EINVAL;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 8a84c005f32b..8eae817c138d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -316,6 +316,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  			return PTR_ERR(pci->dbi_base);
>  	}
>  
> +	dw_pcie_iatu_detect(pci);
> +
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
>  		return -ENOMEM;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 5b72a5448d2e..5b9bf02d918b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -654,11 +654,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>  	pci->num_ob_windows = ob;
>  }
>  
> -void dw_pcie_setup(struct dw_pcie *pci)
> +void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
> -	u32 val;
>  	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>  	struct platform_device *pdev = to_platform_device(dev);
>  
>  	if (pci->version >= 0x480A || (!pci->version &&
> @@ -687,6 +685,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  
>  	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
>  		 pci->num_ob_windows, pci->num_ib_windows);
> +}
> +
> +void dw_pcie_setup(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
>  
>  	if (pci->link_gen > 0)
>  		dw_pcie_link_set_max_speed(pci, pci->link_gen);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5d979953800d..867369d4c4f7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -305,6 +305,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  			 enum dw_pcie_region_type type);
>  void dw_pcie_setup(struct dw_pcie *pci);
> +void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -- 
> 2.17.1
> 
