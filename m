Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2211BE3
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBO6g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 10:58:36 -0400
Received: from foss.arm.com ([217.140.101.70]:47150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBO6g (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 10:58:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C96CDA78;
        Thu,  2 May 2019 07:58:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1DD83F5AF;
        Thu,  2 May 2019 07:58:33 -0700 (PDT)
Date:   Thu, 2 May 2019 15:58:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 1/2] PCI: dwc: Add API support to de-initialize host
Message-ID: <20190502145830.GB19656@e121166-lin.cambridge.arm.com>
References: <20190416141516.23908-1-vidyas@nvidia.com>
 <20190416141516.23908-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416141516.23908-2-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 16, 2019 at 07:45:15PM +0530, Vidya Sagar wrote:
> Add an API to group all the tasks to be done to de-initialize host which
> can then be called by any DesignWare core based driver implementations
> while adding .remove() support in their respective drivers.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> v2:
> * s/Designware/DesignWare
> 
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 5 +++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e4169e738a5..d7881490282d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -516,6 +516,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	return ret;
>  }
>  
> +void dw_pcie_host_deinit(struct pcie_port *pp)
> +{
> +	pci_stop_root_bus(pp->root_bus);
> +	pci_remove_root_bus(pp->root_bus);
> +	dw_pcie_free_msi(pp);

This must mirror the init path, so AFAICS it should not be done
if pp->ops->msi_host_init != NULL

Lorenzo

> +}
> +
>  static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  				     u32 devfn, int where, int size, u32 *val,
>  				     bool write)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index adff0c713665..ea8d1caf11c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -343,6 +343,7 @@ void dw_pcie_msi_init(struct pcie_port *pp);
>  void dw_pcie_free_msi(struct pcie_port *pp);
>  void dw_pcie_setup_rc(struct pcie_port *pp);
>  int dw_pcie_host_init(struct pcie_port *pp);
> +void dw_pcie_host_deinit(struct pcie_port *pp);
>  int dw_pcie_allocate_domains(struct pcie_port *pp);
>  #else
>  static inline irqreturn_t dw_handle_msi_irq(struct pcie_port *pp)
> @@ -367,6 +368,10 @@ static inline int dw_pcie_host_init(struct pcie_port *pp)
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
