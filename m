Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B559B116
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405655AbfHWNim (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 09:38:42 -0400
Received: from foss.arm.com ([217.140.110.172]:34638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbfHWNil (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 09:38:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F6628;
        Fri, 23 Aug 2019 06:38:40 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A40F03F718;
        Fri, 23 Aug 2019 06:38:39 -0700 (PDT)
Date:   Fri, 23 Aug 2019 14:38:38 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.co, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 03/10] PCI: designware-ep: Move the function of
 getting MSI capability forward
Message-ID: <20190823133837.GF14582@e119886-lin.cambridge.arm.com>
References: <20190822112242.16309-1-xiaowei.bao@nxp.com>
 <20190822112242.16309-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822112242.16309-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 07:22:35PM +0800, Xiaowei Bao wrote:
> Move the function of getting MSI capability to the front of init
> function, because the init function of the EP platform driver will use
> the return value by the function of getting MSI capability.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
> v2:
>  - No change.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index b8388f8..0a6c199 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -656,6 +656,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ret < 0)
>  		epc->max_functions = 1;
>  
> +	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
> +
> +	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
> +
>  	if (ep->ops->ep_init)
>  		ep->ops->ep_init(ep);
>  
> @@ -672,9 +676,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
>  		return -ENOMEM;
>  	}
> -	ep->msi_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSI);
> -
> -	ep->msix_cap = dw_pcie_ep_find_capability(pci, PCI_CAP_ID_MSIX);
>  
>  	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  	if (offset) {
> -- 
> 2.9.5
> 
