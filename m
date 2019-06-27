Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 522E45816D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 13:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0LZb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jun 2019 07:25:31 -0400
Received: from foss.arm.com ([217.140.110.172]:52192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbfF0LZb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 07:25:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09DE22B;
        Thu, 27 Jun 2019 04:25:29 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 725E73F718;
        Thu, 27 Jun 2019 04:25:27 -0700 (PDT)
Date:   Thu, 27 Jun 2019 12:25:22 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V9 1/3] PCI: dwc: Add API support to de-initialize host
Message-ID: <20190627112522.GA3782@e121166-lin.cambridge.arm.com>
References: <20190625092238.13207-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625092238.13207-1-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 02:52:36PM +0530, Vidya Sagar wrote:
> Add an API to group all the tasks to be done to de-initialize host which
> can then be called by any DesignWare core based driver implementations
> while adding .remove() support in their respective drivers.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> Changes from v8:
> * None
> 
> Changes from v7:
> * None
> 
> Changes from v6:
> * None
> 
> Changes from v5:
> * None
> 
> Changes from v4:
> * None
> 
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

I have applied the series in pci/dwc for v5.3, thanks.

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
> index b8993f2b78df..14762e262758 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -351,6 +351,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>  void dw_pcie_free_msi(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_host_deinit(struct pcie_port *pp);
>  int dw_pcie_allocate_domains(struct pcie_port *pp);
>  #else
>  static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> @@ -375,6 +376,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
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
