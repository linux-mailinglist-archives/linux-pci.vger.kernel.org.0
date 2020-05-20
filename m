Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206911DC1D1
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgETWH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 18:07:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35850 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgETWH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 18:07:27 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so5126442iol.3;
        Wed, 20 May 2020 15:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WUh3b880eTZB9TUeMaUcw/6WEtirPL5dFoPDjLOVxK0=;
        b=rUtDg4buD1G3bmFnFN8RfGzEnUpKowsg4S2yi7m1WGfegf5Rtgkjq5yg09rxG7GxLG
         ezf/7ePyP+oTzSTdUE9VBLTR9SI4abwV/NO8dlwr43tL5nveSQH/p5pPGswHy9vCzL+Q
         tYK0R/WfkiFF3FVyc3h8mFfiKCsVR8sZtPX479smlmaYshWq8FoO8+04wzXcc6R9dAga
         KJnZSG9p+AshVO2NBoqqnt9lIxONh3Wjy0fANIMIJWLGZm5qtsHMcSrYdXCO4W0O39Ti
         SmqQnNeRq9a2ZHOu39/lelrytGtdVJZyaEiU41TwrhbKgjjCZIr3TP9a/6ovrRCNSH88
         BJiw==
X-Gm-Message-State: AOAM530FxMoS1C6cDntBiiMhG8vyoDuyKr6cWtRnFpZyo87Zdvk/67d9
        VBgq0RrmLsvKrqyhLZ/rCw==
X-Google-Smtp-Source: ABdhPJwWAIyGPF3V7h0vTyeYZmnRkJL8NmG4CG554Lffu6o5pQ/beMaQbAl2N3fnm/qyqabvBHC99w==
X-Received: by 2002:a05:6638:60e:: with SMTP id g14mr1231252jar.54.1590012445798;
        Wed, 20 May 2020 15:07:25 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i13sm2025192ill.65.2020.05.20.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 15:07:25 -0700 (PDT)
Received: (nullmailer pid 683784 invoked by uid 1000);
        Wed, 20 May 2020 22:07:24 -0000
Date:   Wed, 20 May 2020 16:07:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 03/14] PCI: cadence: Add support to use custom read
 and write accessors
Message-ID: <20200520220724.GA636352@bogus>
References: <20200506151429.12255-1-kishon@ti.com>
 <20200506151429.12255-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506151429.12255-4-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 08:44:18PM +0530, Kishon Vijay Abraham I wrote:
> Add support to use custom read and write accessors. Platforms that
> don't support half word or byte access or any other constraint
> while accessing registers can use this feature to populate custom
> read and write accessors. These custom accessors are used for both
> standard register access and configuration space register access of
> the PCIe host bridge.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence.h | 107 +++++++++++++++---
>  1 file changed, 94 insertions(+), 13 deletions(-)

Actually, take back my R-by...

> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index df14ad002fe9..70b6b25153e8 100644
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
> +	const struct cdns_pcie_ops *ops;
>  };
>  
>  /**
> @@ -299,69 +304,145 @@ struct cdns_pcie_ep {
>  /* Register access */
>  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>  {
> -	writeb(value, pcie->reg_base + reg);
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x1, value);
> +		return;
> +	}
> +
> +	writeb(value, addr);
>  }
>  
>  static inline void cdns_pcie_writew(struct cdns_pcie *pcie, u32 reg, u16 value)
>  {
> -	writew(value, pcie->reg_base + reg);
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x2, value);
> +		return;
> +	}
> +
> +	writew(value, addr);
>  }

cdns_pcie_writeb and cdns_pcie_writew are used, so remove them.

>  
>  static inline void cdns_pcie_writel(struct cdns_pcie *pcie, u32 reg, u32 value)
>  {
> -	writel(value, pcie->reg_base + reg);
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->write) {
> +		pcie->ops->write(addr, 0x4, value);
> +		return;
> +	}
> +
> +	writel(value, addr);

writel isn't broken for you, so you don't need this either.

>  }
>  
>  static inline u32 cdns_pcie_readl(struct cdns_pcie *pcie, u32 reg)
>  {
> -	return readl(pcie->reg_base + reg);
> +	void __iomem *addr = pcie->reg_base + reg;
> +
> +	if (pcie->ops && pcie->ops->read)
> +		return pcie->ops->read(addr, 0x4);
> +
> +	return readl(addr);

And neither is readl.

>  }
>  
>  /* Root Port register access */
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

You removed 2 out of 3 calls to this. I think I'd just make the root 
port writes always be 32-bit. It is all just one time init stuff 
anyways.

Either rework the calls to assemble the data into 32-bits or keep these 
functions and do the RMW here.

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

Same for these EP functions. 

Unless there are places where doing a RMW is fundamentally broken like 
in config space (not counting the one time init stuff).

Rob
