Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0F11BCA
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2019 16:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfEBOvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 May 2019 10:51:54 -0400
Received: from foss.arm.com ([217.140.101.70]:47048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfEBOvy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 May 2019 10:51:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60CEAA78;
        Thu,  2 May 2019 07:51:53 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AEFB3F5AF;
        Thu,  2 May 2019 07:51:51 -0700 (PDT)
Date:   Thu, 2 May 2019 15:51:46 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2 2/2] PCI: dwc: Export APIs to support .remove()
 implementation
Message-ID: <20190502145146.GA19656@e121166-lin.cambridge.arm.com>
References: <20190416141516.23908-1-vidyas@nvidia.com>
 <20190416141516.23908-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416141516.23908-3-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 16, 2019 at 07:45:16PM +0530, Vidya Sagar wrote:
> Export all configuration space access APIs and also other APIs to
> support host controller drivers of DesignWare core based
> implementations while adding support for .remove() hook to build their
> respective drivers as modules
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
> v2:
> * s/Designware/DesignWare
> 
>  .../pci/controller/dwc/pcie-designware-host.c |  4 ++
>  drivers/pci/controller/dwc/pcie-designware.c  | 38 +++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  | 35 +++--------------
>  3 files changed, 48 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d7881490282d..2a5332e5ccfa 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -333,6 +333,7 @@ void dw_pcie_msi_init(struct pcie_port *pp)
>  	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_HI, 4,
>  			    upper_32_bits(msi_target));
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_msi_init);
>  
>  int dw_pcie_host_init(struct pcie_port *pp)
>  {
> @@ -515,6 +516,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  		dw_pcie_free_msi(pp);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_host_init);
>  
>  void dw_pcie_host_deinit(struct pcie_port *pp)
>  {
> @@ -522,6 +524,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
>  	pci_remove_root_bus(pp->root_bus);
>  	dw_pcie_free_msi(pp);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>  
>  static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>  				     u32 devfn, int where, int size, u32 *val,
> @@ -731,3 +734,4 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  	val |= PORT_LOGIC_SPEED_CHANGE;
>  	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 31f6331ca46f..f98e2f284ae1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -40,6 +40,7 @@ int dw_pcie_read(void __iomem *addr, int size, u32 *val)
>  
>  	return PCIBIOS_SUCCESSFUL;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_read);
>  
>  int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  {
> @@ -57,6 +58,7 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  
>  	return PCIBIOS_SUCCESSFUL;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_write);
>  
>  u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>  		       size_t size)
> @@ -89,6 +91,42 @@ void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
>  		dev_err(pci->dev, "Write DBI address failed\n");
>  }
>  
> +void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_writel_dbi);
> +
> +u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_readl_dbi);
> +
> +void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_writew_dbi);
> +
> +u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_readw_dbi);
> +
> +void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
> +{
> +	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_writeb_dbi);
> +
> +u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
> +{
> +	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_readb_dbi);
> +
>  static u32 dw_pcie_readl_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg)
>  {
>  	u32 offset = PCIE_GET_ATU_OUTB_UNR_REG_OFFSET(index);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ea8d1caf11c5..86df36701a37 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -265,35 +265,12 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>  			 enum dw_pcie_region_type type);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  
> -static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
> -{
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
> -}
> -
> -static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
> -{
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
> -}
> -
> -static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
> -{
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
> -}
> -
> -static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
> -{
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
> -}
> -
> -static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
> -{
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
> -}
> -
> -static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
> -{
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
> -}
> +void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val);
> +u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg);
> +void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val);
> +u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg);
> +void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val);
> +u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg);

What's the point of exporting all these functions ?

Export __dw_pcie_{write/read}_dbi() and be done with it.

Thanks,
Lorenzo

>  
>  static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -- 
> 2.17.1
> 
