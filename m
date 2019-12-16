Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9697120829
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2019 15:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfLPOHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 09:07:33 -0500
Received: from foss.arm.com ([217.140.110.172]:56638 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbfLPOHc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 09:07:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E65101FB;
        Mon, 16 Dec 2019 06:07:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7983F718;
        Mon, 16 Dec 2019 06:07:31 -0800 (PST)
Date:   Mon, 16 Dec 2019 14:07:29 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 03/13] PCI: cadence: Add support to use custom read and
 write accessors
Message-ID: <20191216140729.GX24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-4-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:37PM +0530, Kishon Vijay Abraham I wrote:
> Add support to use custom read and write accessors. Platforms that
> doesn't support half word or byte access or any other constraint

s/doesn't/don't/

> while accessing registers can use this feature to populate custom
> read and write accessors. These custom accessors are used for both
> standard register access and configuration space register access.

You can put the following sentence underneath a --- as it's not needed
in the commit message (but may be helpful to reviewers).

> This is in preparation for adding PCIe support in TI's J721E SoC which
> uses Cadence PCIe core.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence.h | 99 +++++++++++++++++--
>  1 file changed, 90 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index a2b28b912ca4..d0d91c69fa1d 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -223,6 +223,11 @@ enum cdns_pcie_msg_routing {
>  	MSG_ROUTING_GATHER,
>  };
>  
> +struct cdns_pcie_ops {
> +	u32	(*read)(void __iomem *addr, int size);
> +	void	(*write)(void __iomem *addr, int size, u32 value);
> +};
> +
>  /**
>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>   * @reg_base: IO mapped register base
> @@ -239,7 +244,7 @@ struct cdns_pcie {
>  	int			phy_count;
>  	struct phy		**phy;
>  	struct device_link	**link;
> -	const struct cdns_pcie_common_ops *ops;

What was cdns_pcie_common_ops? It's not defined in the current tree is it?

> +	const struct cdns_pcie_ops *ops;
>  };
>  
>  /**
> @@ -301,21 +306,47 @@ struct cdns_pcie_ep {
>  /* Register access */
>  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>  {
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x1, value);
> +		return;
> +	}
> +
>  	writeb(value, pcie->reg_base + reg);

Can you use 'addr' here instead of 'pcie->reg_base + reg'? (And similar for the
rest of them).

Thanks,

Andrew Murray


>  }
>  
>  static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
>  {
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x2, value);
> +		return;
> +	}
> +
>  	writew(value, pcie->reg_base + reg);
>  }
>  
>  static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
>  {
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x4, value);
> +		return;
> +	}
> +
>  	writel(value, pcie->reg_base + reg);
>  }
>  
>  static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
>  {
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->read)
> +		return pcie->ops->read(addr, 0x4);
> +
>  	return readl(pcie->reg_base + reg);
>  }
>  
> @@ -323,47 +354,97 @@ static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
>  static inline void cdns_pcie_rp_writeb(struct cdns_pcie *pcie,
>  				       u32 reg, u8 value)
>  {
> -	writeb(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x1, value);
> +		return;
> +	}
> +
> +	writeb(value, addr);
>  }
>  
>  static inline void cdns_pcie_rp_writew(struct cdns_pcie *pcie,
>  				       u32 reg, u16 value)
>  {
> -	writew(value, pcie->reg_base + CDNS_PCIE_RP_BASE + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_RP_BASE + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x2, value);
> +		return;
> +	}
> +
> +	writew(value, addr);
>  }
>  
>  /* Endpoint Function register access */
>  static inline void cdns_pcie_ep_fn_writeb(struct cdns_pcie *pcie, u8 fn,
>  					  u32 reg, u8 value)
>  {
> -	writeb(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x1, value);
> +		return;
> +	}
> +
> +	writeb(value, addr);
>  }
>  
>  static inline void cdns_pcie_ep_fn_writew(struct cdns_pcie *pcie, u8 fn,
>  					  u32 reg, u16 value)
>  {
> -	writew(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x2, value);
> +		return;
> +	}
> +
> +	writew(value, addr);
>  }
>  
>  static inline void cdns_pcie_ep_fn_writel(struct cdns_pcie *pcie, u8 fn,
>  					  u32 reg, u32 value)
>  {
> -	writel(value, pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x4, value);
> +		return;
> +	}
> +
> +	writel(value, addr);
>  }
>  
>  static inline u8 cdns_pcie_ep_fn_readb(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  {
> -	return readb(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
> +
> +	if (pcie->ops && pcie->ops->read)
> +		return pcie->ops->read(addr, 0x1);
> +
> +	return readb(addr);
>  }
>  
>  static inline u16 cdns_pcie_ep_fn_readw(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  {
> -	return readw(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
> +
> +	if (pcie->ops && pcie->ops->read)
> +		return pcie->ops->read(addr, 0x2);
> +
> +	return readw(addr);
>  }
>  
>  static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  {
> -	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
> +	void __iomem *addr = pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg;
> +
> +	if (pcie->ops && pcie->ops->read)
> +		return pcie->ops->read(addr, 0x4);
> +
> +	return readl(addr);
>  }
>  
>  #ifdef CONFIG_PCIE_CADENCE_HOST
> -- 
> 2.17.1
> 
