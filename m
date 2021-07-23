Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0253D3C00
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhGWOKC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 10:10:02 -0400
Received: from foss.arm.com ([217.140.110.172]:46974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235351AbhGWOKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 10:10:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0BD1D6E;
        Fri, 23 Jul 2021 07:50:33 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9BC93F73D;
        Fri, 23 Jul 2021 07:50:31 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:50:26 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linusw@kernel.org>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] ARM: ixp4xx: fix building both pci drivers
Message-ID: <20210723145026.GA3330@lpieralisi>
References: <20210721151546.2325937-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721151546.2325937-1-arnd@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 05:15:22PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When both the old and the new PCI drivers are enabled
> in the same kernel, there are a couple of namespace
> conflicts that cause a build failure:
> 
> drivers/pci/controller/pci-ixp4xx.c:38: error: "IXP4XX_PCI_CSR" redefined [-Werror]
>    38 | #define IXP4XX_PCI_CSR                  0x1c
>       |
> In file included from arch/arm/mach-ixp4xx/include/mach/hardware.h:23,
>                  from arch/arm/mach-ixp4xx/include/mach/io.h:15,
>                  from arch/arm/include/asm/io.h:198,
>                  from include/linux/io.h:13,
>                  from drivers/pci/controller/pci-ixp4xx.c:20:
> arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h:221: note: this is the location of the previous definition
>   221 | #define IXP4XX_PCI_CSR(x) ((volatile u32 *)(IXP4XX_PCI_CFG_BASE_VIRT+(x)))
>       |
> drivers/pci/controller/pci-ixp4xx.c:148:12: error: 'ixp4xx_pci_read' redeclared as different kind of symbol
>   148 | static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
>       |            ^~~~~~~~~~~~~~~
> 
> Rename both the ixp4xx_pci_read/ixp4xx_pci_write functions and the
> IXP4XX_PCI_CSR macro. In each case, I went with the version that
> has fewer callers to keep the change small.
> 
> Fixes: f7821b493458 ("PCI: ixp4xx: Add a new driver for IXP4xx")
> Cc: soc@kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../mach-ixp4xx/include/mach/ixp4xx-regs.h    | 48 +++++++++----------
>  drivers/pci/controller/pci-ixp4xx.c           |  8 ++--
>  2 files changed, 28 insertions(+), 28 deletions(-)

Are you picking this up via arm-soc ? I can take this via the PCI tree,
just let me know:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> index abb07f105515..74e63d4531aa 100644
> --- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> +++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
> @@ -218,30 +218,30 @@
>  /*
>   * PCI Control/Status Registers
>   */
> -#define IXP4XX_PCI_CSR(x) ((volatile u32 *)(IXP4XX_PCI_CFG_BASE_VIRT+(x)))
> -
> -#define PCI_NP_AD               IXP4XX_PCI_CSR(PCI_NP_AD_OFFSET)
> -#define PCI_NP_CBE              IXP4XX_PCI_CSR(PCI_NP_CBE_OFFSET)
> -#define PCI_NP_WDATA            IXP4XX_PCI_CSR(PCI_NP_WDATA_OFFSET)
> -#define PCI_NP_RDATA            IXP4XX_PCI_CSR(PCI_NP_RDATA_OFFSET)
> -#define PCI_CRP_AD_CBE          IXP4XX_PCI_CSR(PCI_CRP_AD_CBE_OFFSET)
> -#define PCI_CRP_WDATA           IXP4XX_PCI_CSR(PCI_CRP_WDATA_OFFSET)
> -#define PCI_CRP_RDATA           IXP4XX_PCI_CSR(PCI_CRP_RDATA_OFFSET)
> -#define PCI_CSR                 IXP4XX_PCI_CSR(PCI_CSR_OFFSET) 
> -#define PCI_ISR                 IXP4XX_PCI_CSR(PCI_ISR_OFFSET)
> -#define PCI_INTEN               IXP4XX_PCI_CSR(PCI_INTEN_OFFSET)
> -#define PCI_DMACTRL             IXP4XX_PCI_CSR(PCI_DMACTRL_OFFSET)
> -#define PCI_AHBMEMBASE          IXP4XX_PCI_CSR(PCI_AHBMEMBASE_OFFSET)
> -#define PCI_AHBIOBASE           IXP4XX_PCI_CSR(PCI_AHBIOBASE_OFFSET)
> -#define PCI_PCIMEMBASE          IXP4XX_PCI_CSR(PCI_PCIMEMBASE_OFFSET)
> -#define PCI_AHBDOORBELL         IXP4XX_PCI_CSR(PCI_AHBDOORBELL_OFFSET)
> -#define PCI_PCIDOORBELL         IXP4XX_PCI_CSR(PCI_PCIDOORBELL_OFFSET)
> -#define PCI_ATPDMA0_AHBADDR     IXP4XX_PCI_CSR(PCI_ATPDMA0_AHBADDR_OFFSET)
> -#define PCI_ATPDMA0_PCIADDR     IXP4XX_PCI_CSR(PCI_ATPDMA0_PCIADDR_OFFSET)
> -#define PCI_ATPDMA0_LENADDR     IXP4XX_PCI_CSR(PCI_ATPDMA0_LENADDR_OFFSET)
> -#define PCI_ATPDMA1_AHBADDR     IXP4XX_PCI_CSR(PCI_ATPDMA1_AHBADDR_OFFSET)
> -#define PCI_ATPDMA1_PCIADDR     IXP4XX_PCI_CSR(PCI_ATPDMA1_PCIADDR_OFFSET)
> -#define PCI_ATPDMA1_LENADDR     IXP4XX_PCI_CSR(PCI_ATPDMA1_LENADDR_OFFSET)
> +#define _IXP4XX_PCI_CSR(x) ((volatile u32 *)(IXP4XX_PCI_CFG_BASE_VIRT+(x)))
> +
> +#define PCI_NP_AD               _IXP4XX_PCI_CSR(PCI_NP_AD_OFFSET)
> +#define PCI_NP_CBE              _IXP4XX_PCI_CSR(PCI_NP_CBE_OFFSET)
> +#define PCI_NP_WDATA            _IXP4XX_PCI_CSR(PCI_NP_WDATA_OFFSET)
> +#define PCI_NP_RDATA            _IXP4XX_PCI_CSR(PCI_NP_RDATA_OFFSET)
> +#define PCI_CRP_AD_CBE          _IXP4XX_PCI_CSR(PCI_CRP_AD_CBE_OFFSET)
> +#define PCI_CRP_WDATA           _IXP4XX_PCI_CSR(PCI_CRP_WDATA_OFFSET)
> +#define PCI_CRP_RDATA           _IXP4XX_PCI_CSR(PCI_CRP_RDATA_OFFSET)
> +#define PCI_CSR                 _IXP4XX_PCI_CSR(PCI_CSR_OFFSET) 
> +#define PCI_ISR                 _IXP4XX_PCI_CSR(PCI_ISR_OFFSET)
> +#define PCI_INTEN               _IXP4XX_PCI_CSR(PCI_INTEN_OFFSET)
> +#define PCI_DMACTRL             _IXP4XX_PCI_CSR(PCI_DMACTRL_OFFSET)
> +#define PCI_AHBMEMBASE          _IXP4XX_PCI_CSR(PCI_AHBMEMBASE_OFFSET)
> +#define PCI_AHBIOBASE           _IXP4XX_PCI_CSR(PCI_AHBIOBASE_OFFSET)
> +#define PCI_PCIMEMBASE          _IXP4XX_PCI_CSR(PCI_PCIMEMBASE_OFFSET)
> +#define PCI_AHBDOORBELL         _IXP4XX_PCI_CSR(PCI_AHBDOORBELL_OFFSET)
> +#define PCI_PCIDOORBELL         _IXP4XX_PCI_CSR(PCI_PCIDOORBELL_OFFSET)
> +#define PCI_ATPDMA0_AHBADDR     _IXP4XX_PCI_CSR(PCI_ATPDMA0_AHBADDR_OFFSET)
> +#define PCI_ATPDMA0_PCIADDR     _IXP4XX_PCI_CSR(PCI_ATPDMA0_PCIADDR_OFFSET)
> +#define PCI_ATPDMA0_LENADDR     _IXP4XX_PCI_CSR(PCI_ATPDMA0_LENADDR_OFFSET)
> +#define PCI_ATPDMA1_AHBADDR     _IXP4XX_PCI_CSR(PCI_ATPDMA1_AHBADDR_OFFSET)
> +#define PCI_ATPDMA1_PCIADDR     _IXP4XX_PCI_CSR(PCI_ATPDMA1_PCIADDR_OFFSET)
> +#define PCI_ATPDMA1_LENADDR     _IXP4XX_PCI_CSR(PCI_ATPDMA1_LENADDR_OFFSET)
>  
>  /*
>   * PCI register values and bit definitions 
> diff --git a/drivers/pci/controller/pci-ixp4xx.c b/drivers/pci/controller/pci-ixp4xx.c
> index 896a45b24236..654ac4a82beb 100644
> --- a/drivers/pci/controller/pci-ixp4xx.c
> +++ b/drivers/pci/controller/pci-ixp4xx.c
> @@ -145,7 +145,7 @@ static int ixp4xx_pci_check_master_abort(struct ixp4xx_pci *p)
>  	return 0;
>  }
>  
> -static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
> +static int ixp4xx_pci_read_indirect(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
>  {
>  	ixp4xx_writel(p, IXP4XX_PCI_NP_AD, addr);
>  
> @@ -170,7 +170,7 @@ static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
>  	return ixp4xx_pci_check_master_abort(p);
>  }
>  
> -static int ixp4xx_pci_write(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 data)
> +static int ixp4xx_pci_write_indirect(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 data)
>  {
>  	ixp4xx_writel(p, IXP4XX_PCI_NP_AD, addr);
>  
> @@ -308,7 +308,7 @@ static int ixp4xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
>  	dev_dbg(p->dev, "read_config from %d size %d dev %d:%d:%d address: %08x cmd: %08x\n",
>  		where, size, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn), addr, cmd);
>  
> -	ret = ixp4xx_pci_read(p, addr, cmd, &val);
> +	ret = ixp4xx_pci_read_indirect(p, addr, cmd, &val);
>  	if (ret)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> @@ -356,7 +356,7 @@ static int ixp4xx_pci_write_config(struct pci_bus *bus,  unsigned int devfn,
>  	dev_dbg(p->dev, "write_config_byte %#x to %d size %d dev %d:%d:%d addr: %08x cmd %08x\n",
>  		value, where, size, bus_num, PCI_SLOT(devfn), PCI_FUNC(devfn), addr, cmd);
>  
> -	ret = ixp4xx_pci_write(p, addr, cmd, val);
> +	ret = ixp4xx_pci_write_indirect(p, addr, cmd, val);
>  	if (ret)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> -- 
> 2.29.2
> 
