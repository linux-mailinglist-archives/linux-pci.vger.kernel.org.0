Return-Path: <linux-pci+bounces-12527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C4966704
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C40F284E91
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236214A4EA;
	Fri, 30 Aug 2024 16:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/BloYHr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB181B5820
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725035631; cv=none; b=hKi4s6T3Z8VPYTsEJywJ8jtHznrTzmofR4Xds5TMQRelLfzvZ6hSfnYXdWtl4VocDgE1nJ11g1KGK240buiacBmvOqFDmFsAahkzj0Dsx8qdcD0trNl+KDkP7d4qOMFC3N9TqzJmVWl8VMBwzBK+W5Tl0ziStp2zxk7lsaQy/5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725035631; c=relaxed/simple;
	bh=wheUwn/YYDiJ+ih0FlIZ/n6lb4BUXCsQbRSgQdnDLiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjE2W2LJEVfhBJzj/T1d2vR83SbSvNLDxXLyITgQJBWsWP9EHn2qTaRIwrJnclUMVfLbtROFdl4GT13s5Gx3UQdr/ZN3zZ+0mtK2SZVAhwE7gZDUunxSYZ93JX77U6kKdgUppWOwEb5nOhs70MDoiqi+tjPkfm/SRk/NEyGmGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S/BloYHr; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-714302e7285so1819134b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725035629; x=1725640429; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vrz+c6o8yQ/ha62uVOHeZZseeOZBJ48VofCxNIfW5KQ=;
        b=S/BloYHrOyHnZF/ZzvpJOMBttXOsozfrVeVKXJz2AO23EJKJOQuxObNyG0zqoA5SFA
         FN1TuY8pn0VJwSgtdexsuz/VB++vlBxV24wHOrV5BR/8GnmPuBEYjjfASttrIF04xca5
         PoLl8NDSiHQq5XMtdU6UaS56bCbt9tp3e3TbMtOmB7l7WRK4p7IjZcDw5U/06aDlQKmS
         t8R/zY/7+U3Fmf8pRUk4CRmcTBDRQ2uytRva0J74JvQcHm5Xj90OaTZpxr4vig1aDQE7
         NM9CoU4Zb4FsA/GqgWgbYD51WU9QU+3t6ac/ODGXjx60QQIkqi0mbMNPrMaeA9eMhN2k
         UERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725035629; x=1725640429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vrz+c6o8yQ/ha62uVOHeZZseeOZBJ48VofCxNIfW5KQ=;
        b=owlFkmYuqG9lhDIYQC0CayxGTUmw8mfPRs8udB2a6Fj+L77LVCAxUJousrcsdn1Kbt
         XpLGbmQoTWQ6fS9ka+2w82s1/qi8edEF4ntHrYu2JRdCcidZrGlziWAnNdQKbhYbL1x2
         lt2xKakkVoWAlO0xI1Ak/oMXPhTkUjazUjpoTS6L3aYlnXDSYu5sGr4LsK8a09MvskOg
         hKiDWYz12HRe+zeH8kgJOssBJq3x5zwABaol3gD0NpjGh4chTB49Ut+MxrbDLYCTfUYh
         j16Rgw/FC8nUyViKGXuvw4xY85oXx0YYga2hzmVd4uvCn9WQg2zHtSR9lLX/5/CIBqNq
         kfvg==
X-Forwarded-Encrypted: i=1; AJvYcCU83b32PBVdTttbBaQJAs664SZBuBx9jzkAC8bkY+6DFGlzXiG6mtHnISw4rhoug8zycF8EObd77us=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdDO+7hq5jROwF6rhN716m0uV2VtMyrmk2jjf3UTAcYqq7RUjR
	K21pp7hMt+rEpjwHVAGKq4g9u/eGOQiKHdhOaNpT8JDyr31dEkC5fIJV1maggw==
X-Google-Smtp-Source: AGHT+IEFIR4WehLNVjGEUs2gw5mnU3QWqaSdoqihZp/g8nHwvyMPpHyoucyIC0wG1iBpyPhz8/rbSw==
X-Received: by 2002:a05:6a00:234a:b0:714:1fc3:79f7 with SMTP id d2e1a72fcca58-715dfc506a0mr8912395b3a.17.1725035629373;
        Fri, 30 Aug 2024 09:33:49 -0700 (PDT)
Received: from thinkpad ([117.193.213.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9daac4sm2763284a12.92.2024.08.30.09.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 09:33:48 -0700 (PDT)
Date: Fri, 30 Aug 2024 22:03:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Thippeswamy Havalige <thippesw@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michal.simek@amd.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] PCI: xilinx-xdma: Add Xilinx QDMA Root Port driver
Message-ID: <20240830163341.437jztschfrstrrj@thinkpad>
References: <20240811022345.1178203-1-thippesw@amd.com>
 <20240811022345.1178203-3-thippesw@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240811022345.1178203-3-thippesw@amd.com>

On Sun, Aug 11, 2024 at 07:53:45AM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx QDMA Soft IP core as Root Port.
> 
> The Versal Prime devices support QDMA soft IP module in programmable logic.
> 
> The integrated QDMA Soft IP block has integrated bridge function that can
> act as PCIe Root Port.
> 
> Signed-off-by: Thippeswamy Havalige <thippesw@amd.com>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 54 ++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)
> ---
> changes in v4:
> - none
> 
> changes in v3:
> - Modify macro value to lower case.
> - Change return type based QDMA compatible.
> 
> changes in v2:
> - Add description for struct pl_dma_pcie
> ---
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index 5be5dfd8398f..1ea6a1d265bb 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -13,6 +13,7 @@
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
> +#include <linux/of_platform.h>

Looks like this header is not used.

- Mani

>  
>  #include "../pci.h"
>  #include "pcie-xilinx-common.h"
> @@ -71,10 +72,24 @@
>  
>  /* Phy Status/Control Register definitions */
>  #define XILINX_PCIE_DMA_REG_PSCR_LNKUP	BIT(11)
> +#define QDMA_BRIDGE_BASE_OFF		0xcd8
>  
>  /* Number of MSI IRQs */
>  #define XILINX_NUM_MSI_IRQS	64
>  
> +enum xilinx_pl_dma_version {
> +	XDMA,
> +	QDMA,
> +};
> +
> +/**
> + * struct xilinx_pl_dma_variant - PL DMA PCIe variant information
> + * @version: DMA version
> + */
> +struct xilinx_pl_dma_variant {
> +	enum xilinx_pl_dma_version version;
> +};
> +
>  struct xilinx_msi {
>  	struct irq_domain	*msi_domain;
>  	unsigned long		*bitmap;
> @@ -88,6 +103,7 @@ struct xilinx_msi {
>   * struct pl_dma_pcie - PCIe port information
>   * @dev: Device pointer
>   * @reg_base: IO Mapped Register Base
> + * @cfg_base: IO Mapped Configuration Base
>   * @irq: Interrupt number
>   * @cfg: Holds mappings of config space window
>   * @phys_reg_base: Physical address of reg base
> @@ -97,10 +113,12 @@ struct xilinx_msi {
>   * @msi: MSI information
>   * @intx_irq: INTx error interrupt number
>   * @lock: Lock protecting shared register access
> + * @variant: PL DMA PCIe version check pointer
>   */
>  struct pl_dma_pcie {
>  	struct device			*dev;
>  	void __iomem			*reg_base;
> +	void __iomem			*cfg_base;
>  	int				irq;
>  	struct pci_config_window	*cfg;
>  	phys_addr_t			phys_reg_base;
> @@ -110,16 +128,23 @@ struct pl_dma_pcie {
>  	struct xilinx_msi		msi;
>  	int				intx_irq;
>  	raw_spinlock_t			lock;
> +	const struct xilinx_pl_dma_variant   *variant;
>  };
>  
>  static inline u32 pcie_read(struct pl_dma_pcie *port, u32 reg)
>  {
> +	if (port->variant->version == QDMA)
> +		return readl(port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
> +
>  	return readl(port->reg_base + reg);
>  }
>  
>  static inline void pcie_write(struct pl_dma_pcie *port, u32 val, u32 reg)
>  {
> -	writel(val, port->reg_base + reg);
> +	if (port->variant->version == QDMA)
> +		writel(val, port->reg_base + reg + QDMA_BRIDGE_BASE_OFF);
> +	else
> +		writel(val, port->reg_base + reg);
>  }
>  
>  static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
> @@ -173,6 +198,9 @@ static void __iomem *xilinx_pl_dma_pcie_map_bus(struct pci_bus *bus,
>  	if (!xilinx_pl_dma_pcie_valid_device(bus, devfn))
>  		return NULL;
>  
> +	if (port->variant->version == QDMA)
> +		return port->cfg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> +
>  	return port->reg_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
>  }
>  
> @@ -731,6 +759,15 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
>  
>  	port->reg_base = port->cfg->win;
>  
> +	if (port->variant->version == QDMA) {
> +		port->cfg_base = port->cfg->win;
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
> +		port->reg_base = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(port->reg_base))
> +			return PTR_ERR(port->reg_base);
> +		port->phys_reg_base = res->start;
> +	}
> +
>  	err = xilinx_request_msi_irq(port);
>  	if (err) {
>  		pci_ecam_free(port->cfg);
> @@ -760,6 +797,8 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
>  	if (!bus)
>  		return -ENODEV;
>  
> +	port->variant = of_device_get_match_data(dev);
> +
>  	err = xilinx_pl_dma_pcie_parse_dt(port, bus->res);
>  	if (err) {
>  		dev_err(dev, "Parsing DT failed\n");
> @@ -791,9 +830,22 @@ static int xilinx_pl_dma_pcie_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> +static const struct xilinx_pl_dma_variant xdma_host = {
> +	.version = XDMA,
> +};
> +
> +static const struct xilinx_pl_dma_variant qdma_host = {
> +	.version = QDMA,
> +};
> +
>  static const struct of_device_id xilinx_pl_dma_pcie_of_match[] = {
>  	{
>  		.compatible = "xlnx,xdma-host-3.00",
> +		.data = &xdma_host,
> +	},
> +	{
> +		.compatible = "xlnx,qdma-host-3.00",
> +		.data = &qdma_host,
>  	},
>  	{}
>  };
> -- 
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

