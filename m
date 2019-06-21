Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872BE4EAA5
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 16:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFUOc4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 10:32:56 -0400
Received: from foss.arm.com ([217.140.110.172]:33466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUOc4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 10:32:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53C8828;
        Fri, 21 Jun 2019 07:32:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBF953F575;
        Fri, 21 Jun 2019 07:32:53 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:32:51 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     bhelgaas@google.com, Jisheng.Zhang@synaptics.com,
        thierry.reding@gmail.com, kishon@ti.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V6 2/3] PCI: dwc: Cleanup DBI read and write APIs
Message-ID: <20190621143251.GB21807@e121166-lin.cambridge.arm.com>
References: <20190621111000.23216-1-vidyas@nvidia.com>
 <20190621111000.23216-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621111000.23216-2-vidyas@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 21, 2019 at 04:39:59PM +0530, Vidya Sagar wrote:
> Cleanup DBI read and write APIs by removing "__" (underscore) from their
> names as there are no no-underscore versions and the underscore versions
> are already doing what no-underscore versions typically do. It also removes
> passing dbi/dbi2 base address as one of the arguments as the same can be
> derived with in read and write APIs.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from v5:
> * Removed passing base address as one of the arguments as the same can be derived within
>   the API itself.
> * Modified ATU read/write APIs to call dw_pcie_{write/read}() API
> 
> Changes from v4:
> * This is a new patch in this series
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 28 ++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h | 43 ++++++++++++--------
>  2 files changed, 37 insertions(+), 34 deletions(-)

Gustavo, Jingoo,

please ACK this patch if you are OK with it so that I can merge
the series, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 9d7c51c32b3b..0b383feb13de 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -52,64 +52,60 @@ int dw_pcie_write(void __iomem *addr, int size, u32 val)
>  	return PCIBIOS_SUCCESSFUL;
>  }
>  
> -u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -		       size_t size)
> +u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
>  {
>  	int ret;
>  	u32 val;
>  
>  	if (pci->ops->read_dbi)
> -		return pci->ops->read_dbi(pci, base, reg, size);
> +		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
>  
> -	ret = dw_pcie_read(base + reg, size, &val);
> +	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
>  	if (ret)
>  		dev_err(pci->dev, "Read DBI address failed\n");
>  
>  	return val;
>  }
>  
> -void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			 size_t size, u32 val)
> +void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
>  {
>  	int ret;
>  
>  	if (pci->ops->write_dbi) {
> -		pci->ops->write_dbi(pci, base, reg, size, val);
> +		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
>  		return;
>  	}
>  
> -	ret = dw_pcie_write(base + reg, size, val);
> +	ret = dw_pcie_write(pci->dbi_base + reg, size, val);
>  	if (ret)
>  		dev_err(pci->dev, "Write DBI address failed\n");
>  }
>  
> -u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			size_t size)
> +u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size)
>  {
>  	int ret;
>  	u32 val;
>  
>  	if (pci->ops->read_dbi2)
> -		return pci->ops->read_dbi2(pci, base, reg, size);
> +		return pci->ops->read_dbi2(pci, pci->dbi_base2, reg, size);
>  
> -	ret = dw_pcie_read(base + reg, size, &val);
> +	ret = dw_pcie_read(pci->dbi_base2 + reg, size, &val);
>  	if (ret)
>  		dev_err(pci->dev, "read DBI address failed\n");
>  
>  	return val;
>  }
>  
> -void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			  size_t size, u32 val)
> +void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
>  {
>  	int ret;
>  
>  	if (pci->ops->write_dbi2) {
> -		pci->ops->write_dbi2(pci, base, reg, size, val);
> +		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
>  		return;
>  	}
>  
> -	ret = dw_pcie_write(base + reg, size, val);
> +	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
>  	if (ret)
>  		dev_err(pci->dev, "write DBI address failed\n");
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 14762e262758..88300b445a4d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -254,14 +254,10 @@ struct dw_pcie {
>  int dw_pcie_read(void __iomem *addr, int size, u32 *val);
>  int dw_pcie_write(void __iomem *addr, int size, u32 val);
>  
> -u32 __dw_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -		       size_t size);
> -void __dw_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			 size_t size, u32 val);
> -u32 __dw_pcie_read_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			size_t size);
> -void __dw_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> -			  size_t size, u32 val);
> +u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size);
> +void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
> +u32 dw_pcie_read_dbi2(struct dw_pcie *pci, u32 reg, size_t size);
> +void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>  int dw_pcie_link_up(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
> @@ -275,52 +271,63 @@ void dw_pcie_setup(struct dw_pcie *pci);
>  
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x4, val);
> +	dw_pcie_write_dbi(pci, reg, 0x4, val);
>  }
>  
>  static inline u32 dw_pcie_readl_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x4);
> +	return dw_pcie_read_dbi(pci, reg, 0x4);
>  }
>  
>  static inline void dw_pcie_writew_dbi(struct dw_pcie *pci, u32 reg, u16 val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x2, val);
> +	dw_pcie_write_dbi(pci, reg, 0x2, val);
>  }
>  
>  static inline u16 dw_pcie_readw_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x2);
> +	return dw_pcie_read_dbi(pci, reg, 0x2);
>  }
>  
>  static inline void dw_pcie_writeb_dbi(struct dw_pcie *pci, u32 reg, u8 val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->dbi_base, reg, 0x1, val);
> +	dw_pcie_write_dbi(pci, reg, 0x1, val);
>  }
>  
>  static inline u8 dw_pcie_readb_dbi(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->dbi_base, reg, 0x1);
> +	return dw_pcie_read_dbi(pci, reg, 0x1);
>  }
>  
>  static inline void dw_pcie_writel_dbi2(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -	__dw_pcie_write_dbi2(pci, pci->dbi_base2, reg, 0x4, val);
> +	dw_pcie_write_dbi2(pci, reg, 0x4, val);
>  }
>  
>  static inline u32 dw_pcie_readl_dbi2(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi2(pci, pci->dbi_base2, reg, 0x4);
> +	return dw_pcie_read_dbi2(pci, reg, 0x4);
>  }
>  
>  static inline void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -	__dw_pcie_write_dbi(pci, pci->atu_base, reg, 0x4, val);
> +	int ret;
> +
> +	ret = dw_pcie_write(pci->atu_base + reg, 0x4, val);
> +	if (ret)
> +		dev_err(pci->dev, "write ATU address failed\n");
>  }
>  
>  static inline u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
>  {
> -	return __dw_pcie_read_dbi(pci, pci->atu_base, reg, 0x4);
> +	int ret;
> +	u32 val;
> +
> +	ret = dw_pcie_read(pci->atu_base + reg, 0x4, &val);
> +	if (ret)
> +		dev_err(pci->dev, "Read ATU address failed\n");
> +
> +	return val;
>  }
>  
>  static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
> -- 
> 2.17.1
> 
