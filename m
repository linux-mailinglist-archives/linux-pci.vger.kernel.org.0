Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57112C46
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 13:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfECLXr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 07:23:47 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58740 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbfECLXr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 May 2019 07:23:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58EB9374;
        Fri,  3 May 2019 04:23:46 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 503E33F220;
        Fri,  3 May 2019 04:23:44 -0700 (PDT)
Date:   Fri, 3 May 2019 12:23:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 1/2] PCI: dwc: Add API support to de-initialize host
Message-ID: <20190503112338.GA25649@e121166-lin.cambridge.arm.com>
References: <20190502170426.28688-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502170426.28688-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 02, 2019 at 10:34:25PM +0530, Vidya Sagar wrote:
> Add an API to group all the tasks to be done to de-initialize host which
> can then be called by any DesignWare core based driver implementations
> while adding .remove() support in their respective drivers.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes from v3:
> * Added check if (pci_msi_enabled() && !pp->ops->msi_host_init) before calling
>   dw_pcie_free_msi() API to mimic init path
> 
> Changes from v2:
> * Rebased on top of linux-next top of the tree branch
> 
> Changes from v1:
> * s/Designware/DesignWare
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 8 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
>  2 files changed, 13 insertions(+)

Series doesn't apply to v5.1-rc1, what's based on ? I suspect
there is a dependency on pci/keystone, given the tight timeline
for the merge window, would you mind postponing it to v5.3 ?

I do not think it is urgent, I am happy to create a branch
for it as soon as v5.2-rc1 is released.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 77db32529319..d069e4290180 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -496,6 +496,14 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	return ret;
>  }
>  
> +void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +	pci_stop_root_bus(pp->root_bus);
> +	pci_remove_root_bus(pp->root_bus);
> +	if (pci_msi_enabled() && !pp->ops->msi_host_init)
> +		dw_pcie_free_msi(pp);
> +}
> +
>  static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  				     u32 devfn, int where, int size, u32 *val,
>  				     bool write)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index deab426affd3..4f48ec78c7b9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -348,6 +348,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>  void dw_pcie_free_msi(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_host_deinit(struct pcie_port *pp);
>  int dw_pcie_allocate_domains(struct pcie_port *pp);
>  #else
>  static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> @@ -372,6 +373,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  }
>  
> +static inline void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +}
> +
>  static inline int dw_pcie_allocate_domains(struct pcie_port *pp)
>  {
>  	return 0;
> -- 
> 2.17.1
> 
