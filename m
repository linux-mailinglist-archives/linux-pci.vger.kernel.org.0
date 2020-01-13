Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22002138FBE
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 12:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMLFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 06:05:54 -0500
Received: from foss.arm.com ([217.140.110.172]:37740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgAMLFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 06:05:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32EDA13D5;
        Mon, 13 Jan 2020 03:05:53 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F03423F6C4;
        Mon, 13 Jan 2020 03:05:51 -0800 (PST)
Date:   Mon, 13 Jan 2020 11:05:50 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 04/12] PCI: mobiveil: Modularize the Mobiveil PCIe Host
 Bridge IP driver
Message-ID: <20200113110548.GJ42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-5-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191120034451.30102-5-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:45:43AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> Modularize the Mobiveil PCIe host driver according to the
> abstraction of Root Complex and Endpoint and move it into
> a new directory.
> 
> Split the RC related routines into pcie-mobiveil-host.c,
> and common routines into pcie-mobiveil.c, move the macro
> definitions and function declarations into pcie-mobiveil.h,
> and the Mobiveil platform reference code into
> pcie-mobiveil-plat.c. So that it is easy to reuse the
> extracted routines to add a new host driver, which
> integrated Mobiveil PCIe GPEX IP.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

> ---
> V9:
>  - New patch splited from the #1 of V8 patches to make it easy to review.
> 
>  MAINTAINERS                                   |   2 +-
>  drivers/pci/controller/Kconfig                |  11 +-
>  drivers/pci/controller/Makefile               |   2 +-
>  drivers/pci/controller/mobiveil/Kconfig       |  24 ++
>  drivers/pci/controller/mobiveil/Makefile      |   4 +
>  .../pcie-mobiveil-host.c}                     | 398 +-----------------
>  .../controller/mobiveil/pcie-mobiveil-plat.c  |  60 +++
>  .../pci/controller/mobiveil/pcie-mobiveil.c   | 227 ++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   | 178 ++++++++
>  9 files changed, 497 insertions(+), 409 deletions(-)
>  create mode 100644 drivers/pci/controller/mobiveil/Kconfig
>  create mode 100644 drivers/pci/controller/mobiveil/Makefile
>  rename drivers/pci/controller/{pcie-mobiveil.c => mobiveil/pcie-mobiveil-host.c} (61%)
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f7f8cdbc471..a4ad99619e53 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12612,7 +12612,7 @@ M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
> -F:	drivers/pci/controller/pcie-mobiveil.c
> +F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
>  
>  PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
>  M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index f5de9119e8d3..74fd332755ae 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -241,16 +241,6 @@ config PCIE_MEDIATEK
>  	  Say Y here if you want to enable PCIe controller support on
>  	  MediaTek SoCs.
>  
> -config PCIE_MOBIVEIL
> -	bool "Mobiveil AXI PCIe controller"
> -	depends on ARCH_ZYNQMP || COMPILE_TEST
> -	depends on OF
> -	depends on PCI_MSI_IRQ_DOMAIN
> -	help
> -	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
> -	  Soft IP. It has up to 8 outbound and inbound windows
> -	  for address translation and it is a PCIe Gen4 IP.
> -
>  config PCIE_TANGO_SMP8759
>  	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
>  	depends on ARCH_TANGO && PCI_MSI && OF
> @@ -289,4 +279,5 @@ config PCI_HYPERV_INTERFACE
>  	  have a common interface with the Hyper-V PCI frontend driver.
>  
>  source "drivers/pci/controller/dwc/Kconfig"
> +source "drivers/pci/controller/mobiveil/Kconfig"
>  endmenu
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index a2a22c9d91af..44414cfd45ea 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -27,11 +27,11 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
> -obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
>  # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
>  obj-y				+= dwc/
> +obj-y				+= mobiveil/
>  
>  
>  # The following drivers are for devices that use the generic ACPI
> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
> new file mode 100644
> index 000000000000..64343c07bfed
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +menu "Mobiveil PCIe Core Support"
> +	depends on PCI
> +
> +config PCIE_MOBIVEIL
> +	bool
> +
> +config PCIE_MOBIVEIL_HOST
> +	bool
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_MOBIVEIL
> +
> +config PCIE_MOBIVEIL_PLAT
> +	bool "Mobiveil AXI PCIe controller"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on OF
> +	select PCIE_MOBIVEIL_HOST
> +	help
> +	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
> +	  Soft IP. It has up to 8 outbound and inbound windows
> +	  for address translation and it is a PCIe Gen4 IP.
> +
> +endmenu
> diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
> new file mode 100644
> index 000000000000..9fb6d1c6504d
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
> +obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
> +obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
> diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> similarity index 61%
> rename from drivers/pci/controller/pcie-mobiveil.c
> rename to drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> index 512b27a0536e..2cc424e78d33 100644
> --- a/drivers/pci/controller/pcie-mobiveil.c
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
> @@ -9,7 +9,6 @@
>   * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>   */
>  
> -#include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> @@ -26,265 +25,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  
> -#include "../pci.h"
> -
> -/* register offsets and bit positions */
> -
> -/*
> - * translation tables are grouped into windows, each window registers are
> - * grouped into blocks of 4 or 16 registers each
> - */
> -#define PAB_REG_BLOCK_SIZE		16
> -#define PAB_EXT_REG_BLOCK_SIZE		4
> -
> -#define PAB_REG_ADDR(offset, win)	\
> -	(offset + (win * PAB_REG_BLOCK_SIZE))
> -#define PAB_EXT_REG_ADDR(offset, win)	\
> -	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
> -
> -#define LTSSM_STATUS			0x0404
> -#define  LTSSM_STATUS_L0_MASK		0x3f
> -#define  LTSSM_STATUS_L0		0x2d
> -
> -#define PAB_CTRL			0x0808
> -#define  AMBA_PIO_ENABLE_SHIFT		0
> -#define  PEX_PIO_ENABLE_SHIFT		1
> -#define  PAGE_SEL_SHIFT			13
> -#define  PAGE_SEL_MASK			0x3f
> -#define  PAGE_LO_MASK			0x3ff
> -#define  PAGE_SEL_OFFSET_SHIFT		10
> -
> -#define PAB_AXI_PIO_CTRL		0x0840
> -#define  APIO_EN_MASK			0xf
> -
> -#define PAB_PEX_PIO_CTRL		0x08c0
> -#define  PIO_ENABLE_SHIFT		0
> -
> -#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
> -#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
> -#define  PAB_INTP_INTX_MASK		0x01e0
> -#define  PAB_INTP_MSI_MASK		0x8
> -
> -#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
> -#define  WIN_ENABLE_SHIFT		0
> -#define  WIN_TYPE_SHIFT			1
> -#define  WIN_TYPE_MASK			0x3
> -#define  WIN_SIZE_MASK			0xfffffc00
> -
> -#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
> -
> -#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
> -#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
> -#define  AXI_WINDOW_ALIGN_MASK		3
> -
> -#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
> -#define  PAB_BUS_SHIFT			24
> -#define  PAB_DEVICE_SHIFT		19
> -#define  PAB_FUNCTION_SHIFT		16
> -
> -#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
> -#define PAB_INTP_AXI_PIO_CLASS		0x474
> -
> -#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
> -#define  AMAP_CTRL_EN_SHIFT		0
> -#define  AMAP_CTRL_TYPE_SHIFT		1
> -#define  AMAP_CTRL_TYPE_MASK		3
> -
> -#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
> -#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
> -#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
> -#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
> -#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
> -
> -/* starting offset of INTX bits in status register */
> -#define PAB_INTX_START			5
> -
> -/* supported number of MSI interrupts */
> -#define PCI_NUM_MSI			16
> -
> -/* MSI registers */
> -#define MSI_BASE_LO_OFFSET		0x04
> -#define MSI_BASE_HI_OFFSET		0x08
> -#define MSI_SIZE_OFFSET			0x0c
> -#define MSI_ENABLE_OFFSET		0x14
> -#define MSI_STATUS_OFFSET		0x18
> -#define MSI_DATA_OFFSET			0x20
> -#define MSI_ADDR_L_OFFSET		0x24
> -#define MSI_ADDR_H_OFFSET		0x28
> -
> -/* outbound and inbound window definitions */
> -#define WIN_NUM_0			0
> -#define WIN_NUM_1			1
> -#define CFG_WINDOW_TYPE			0
> -#define IO_WINDOW_TYPE			1
> -#define MEM_WINDOW_TYPE			2
> -#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
> -#define MAX_PIO_WINDOWS			8
> -
> -/* Parameters for the waiting for link up routine */
> -#define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_MIN			90000
> -#define LINK_WAIT_MAX			100000
> -
> -#define PAGED_ADDR_BNDRY		0xc00
> -#define OFFSET_TO_PAGE_ADDR(off)	\
> -	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
> -#define OFFSET_TO_PAGE_IDX(off)		\
> -	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
> -
> -struct mobiveil_msi {			/* MSI information */
> -	struct mutex lock;		/* protect bitmap variable */
> -	struct irq_domain *msi_domain;
> -	struct irq_domain *dev_domain;
> -	phys_addr_t msi_pages_phys;
> -	int num_of_vectors;
> -	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
> -};
> -
> -struct root_port {
> -	char root_bus_nr;
> -	void __iomem *config_axi_slave_base;	/* endpoint config base */
> -	struct resource *ob_io_res;
> -	int irq;
> -	raw_spinlock_t intx_mask_lock;
> -	struct irq_domain *intx_domain;
> -	struct mobiveil_msi msi;
> -	struct pci_host_bridge *bridge;
> -};
> -
> -struct mobiveil_pcie {
> -	struct platform_device *pdev;
> -	void __iomem *csr_axi_slave_base;	/* root port config base */
> -	void __iomem *apb_csr_base;	/* MSI register base */
> -	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
> -	int apio_wins;
> -	int ppio_wins;
> -	int ob_wins_configured;		/* configured outbound windows */
> -	int ib_wins_configured;		/* configured inbound windows */
> -	struct root_port rp;
> -};
> -
> -/*
> - * mobiveil_pcie_sel_page - routine to access paged register
> - *
> - * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
> - * for this scheme to work extracted higher 6 bits of the offset will be
> - * written to pg_sel field of PAB_CTRL register and rest of the lower 10
> - * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
> - */
> -static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
> -{
> -	u32 val;
> -
> -	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
> -	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
> -	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
> -
> -	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
> -}
> -
> -static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
> -{
> -	if (off < PAGED_ADDR_BNDRY) {
> -		/* For directly accessed registers, clear the pg_sel field */
> -		mobiveil_pcie_sel_page(pcie, 0);
> -		return pcie->csr_axi_slave_base + off;
> -	}
> -
> -	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
> -	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
> -}
> -
> -static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
> -{
> -	if ((uintptr_t)addr & (size - 1)) {
> -		*val = 0;
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	}
> -
> -	switch (size) {
> -	case 4:
> -		*val = readl(addr);
> -		break;
> -	case 2:
> -		*val = readw(addr);
> -		break;
> -	case 1:
> -		*val = readb(addr);
> -		break;
> -	default:
> -		*val = 0;
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	}
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
> -{
> -	if ((uintptr_t)addr & (size - 1))
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -
> -	switch (size) {
> -	case 4:
> -		writel(val, addr);
> -		break;
> -	case 2:
> -		writew(val, addr);
> -		break;
> -	case 1:
> -		writeb(val, addr);
> -		break;
> -	default:
> -		return PCIBIOS_BAD_REGISTER_NUMBER;
> -	}
> -
> -	return PCIBIOS_SUCCESSFUL;
> -}
> -
> -static u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> -{
> -	void *addr;
> -	u32 val;
> -	int ret;
> -
> -	addr = mobiveil_pcie_comp_addr(pcie, off);
> -
> -	ret = mobiveil_pcie_read(addr, size, &val);
> -	if (ret)
> -		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
> -
> -	return val;
> -}
> -
> -static void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
> -			       size_t size)
> -{
> -	void *addr;
> -	int ret;
> -
> -	addr = mobiveil_pcie_comp_addr(pcie, off);
> -
> -	ret = mobiveil_pcie_write(addr, size, val);
> -	if (ret)
> -		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
> -}
> -
> -static u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
> -{
> -	return mobiveil_csr_read(pcie, off, 0x4);
> -}
> -
> -static void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
> -{
> -	mobiveil_csr_write(pcie, val, off, 0x4);
> -}
> -
> -static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
> -{
> -	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
> -		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
> -}
> +#include "pcie-mobiveil.h"
>  
>  static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
>  {
> @@ -464,103 +205,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
>  	return 0;
>  }
>  
> -static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> -			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
> -{
> -	u32 value;
> -	u64 size64 = ~(size - 1);
> -
> -	if (win_num >= pcie->ppio_wins) {
> -		dev_err(&pcie->pdev->dev,
> -			"ERROR: max inbound windows reached !\n");
> -		return;
> -	}
> -
> -	value = mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> -	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK);
> -	value |= type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
> -		 (lower_32_bits(size64) & WIN_SIZE_MASK);
> -	mobiveil_csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
> -
> -	mobiveil_csr_writel(pcie, upper_32_bits(size64),
> -			    PAB_EXT_PEX_AMAP_SIZEN(win_num));
> -
> -	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr),
> -			    PAB_PEX_AMAP_AXI_WIN(win_num));
> -	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
> -			    PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
> -
> -	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
> -			    PAB_PEX_AMAP_PEX_WIN_L(win_num));
> -	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
> -			    PAB_PEX_AMAP_PEX_WIN_H(win_num));
> -
> -	pcie->ib_wins_configured++;
> -}
> -
> -/*
> - * routine to program the outbound windows
> - */
> -static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> -			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
> -{
> -	u32 value;
> -	u64 size64 = ~(size - 1);
> -
> -	if (win_num >= pcie->apio_wins) {
> -		dev_err(&pcie->pdev->dev,
> -			"ERROR: max outbound windows reached !\n");
> -		return;
> -	}
> -
> -	/*
> -	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
> -	 * to 4 KB in PAB_AXI_AMAP_CTRL register
> -	 */
> -	value = mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> -	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
> -	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> -		 (lower_32_bits(size64) & WIN_SIZE_MASK);
> -	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
> -
> -	mobiveil_csr_writel(pcie, upper_32_bits(size64),
> -			    PAB_EXT_AXI_AMAP_SIZE(win_num));
> -
> -	/*
> -	 * program AXI window base with appropriate value in
> -	 * PAB_AXI_AMAP_AXI_WIN0 register
> -	 */
> -	mobiveil_csr_writel(pcie,
> -			    lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
> -			    PAB_AXI_AMAP_AXI_WIN(win_num));
> -	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
> -			    PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
> -
> -	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
> -			    PAB_AXI_AMAP_PEX_WIN_L(win_num));
> -	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
> -			    PAB_AXI_AMAP_PEX_WIN_H(win_num));
> -
> -	pcie->ob_wins_configured++;
> -}
> -
> -static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
> -{
> -	int retries;
> -
> -	/* check if the link is up or not */
> -	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> -		if (mobiveil_pcie_link_up(pcie))
> -			return 0;
> -
> -		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
> -	}
> -
> -	dev_err(&pcie->pdev->dev, "link never came up\n");
> -
> -	return -ETIMEDOUT;
> -}
> -
>  static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
>  {
>  	phys_addr_t msg_addr = pcie->pcie_reg_base;
> @@ -962,43 +606,3 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
>  
>  	return 0;
>  }
> -
> -static int mobiveil_pcie_probe(struct platform_device *pdev)
> -{
> -	struct mobiveil_pcie *pcie;
> -	struct pci_host_bridge *bridge;
> -	struct device *dev = &pdev->dev;
> -
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> -	if (!bridge)
> -		return -ENOMEM;
> -
> -	pcie = pci_host_bridge_priv(bridge);
> -	pcie->rp.bridge = bridge;
> -
> -	pcie->pdev = pdev;
> -
> -	return mobiveil_pcie_host_probe(pcie);
> -}
> -
> -static const struct of_device_id mobiveil_pcie_of_match[] = {
> -	{.compatible = "mbvl,gpex40-pcie",},
> -	{},
> -};
> -
> -MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
> -
> -static struct platform_driver mobiveil_pcie_driver = {
> -	.probe = mobiveil_pcie_probe,
> -	.driver = {
> -		.name = "mobiveil-pcie",
> -		.of_match_table = mobiveil_pcie_of_match,
> -		.suppress_bind_attrs = true,
> -	},
> -};
> -
> -builtin_platform_driver(mobiveil_pcie_driver);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
> -MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
> new file mode 100644
> index 000000000000..64c85f852869
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Mobiveil PCIe Host controller
> + *
> + * Copyright (c) 2018 Mobiveil Inc.
> + * Copyright 2019 NXP
> + *
> + * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> + * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Same feedback as before with the recode tag.

> + */
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "pcie-mobiveil.h"
> +
> +static int mobiveil_pcie_probe(struct platform_device *pdev)
> +{
> +	struct mobiveil_pcie *pcie;
> +	struct pci_host_bridge *bridge;
> +	struct device *dev = &pdev->dev;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	pcie->rp.bridge = bridge;
> +
> +	pcie->pdev = pdev;
> +
> +	return mobiveil_pcie_host_probe(pcie);
> +}
> +
> +static const struct of_device_id mobiveil_pcie_of_match[] = {
> +	{.compatible = "mbvl,gpex40-pcie",},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
> +
> +static struct platform_driver mobiveil_pcie_driver = {
> +	.probe = mobiveil_pcie_probe,
> +	.driver = {
> +		.name = "mobiveil-pcie",
> +		.of_match_table = mobiveil_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(mobiveil_pcie_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
> +MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> new file mode 100644
> index 000000000000..2773f823c9ea
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
> @@ -0,0 +1,227 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Mobiveil PCIe Host controller
> + *
> + * Copyright (c) 2018 Mobiveil Inc.
> + * Copyright 2019 NXP
> + *
> + * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> + * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "pcie-mobiveil.h"
> +
> +/*
> + * mobiveil_pcie_sel_page - routine to access paged register
> + *
> + * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
> + * for this scheme to work extracted higher 6 bits of the offset will be
> + * written to pg_sel field of PAB_CTRL register and rest of the lower 10
> + * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
> + */
> +static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
> +{
> +	u32 val;
> +
> +	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
> +	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
> +	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
> +
> +	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
> +}
> +
> +static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	if (off < PAGED_ADDR_BNDRY) {
> +		/* For directly accessed registers, clear the pg_sel field */
> +		mobiveil_pcie_sel_page(pcie, 0);
> +		return pcie->csr_axi_slave_base + off;
> +	}
> +
> +	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
> +	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
> +}
> +
> +static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
> +{
> +	if ((uintptr_t)addr & (size - 1)) {
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	switch (size) {
> +	case 4:
> +		*val = readl(addr);
> +		break;
> +	case 2:
> +		*val = readw(addr);
> +		break;
> +	case 1:
> +		*val = readb(addr);
> +		break;
> +	default:
> +		*val = 0;
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
> +{
> +	if ((uintptr_t)addr & (size - 1))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	switch (size) {
> +	case 4:
> +		writel(val, addr);
> +		break;
> +	case 2:
> +		writew(val, addr);
> +		break;
> +	case 1:
> +		writeb(val, addr);
> +		break;
> +	default:
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +	}
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
> +{
> +	void *addr;
> +	u32 val;
> +	int ret;
> +
> +	addr = mobiveil_pcie_comp_addr(pcie, off);
> +
> +	ret = mobiveil_pcie_read(addr, size, &val);
> +	if (ret)
> +		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
> +
> +	return val;
> +}
> +
> +void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
> +			       size_t size)
> +{
> +	void *addr;
> +	int ret;
> +
> +	addr = mobiveil_pcie_comp_addr(pcie, off);
> +
> +	ret = mobiveil_pcie_write(addr, size, val);
> +	if (ret)
> +		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
> +}
> +
> +bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
> +{
> +	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
> +		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
> +}
> +
> +void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
> +			u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
> +{
> +	u32 value;
> +	u64 size64 = ~(size - 1);
> +
> +	if (win_num >= pcie->ppio_wins) {
> +		dev_err(&pcie->pdev->dev,
> +			"ERROR: max inbound windows reached !\n");
> +		return;
> +	}
> +
> +	value = mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
> +	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK);
> +	value |= type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
> +		 (lower_32_bits(size64) & WIN_SIZE_MASK);
> +	mobiveil_csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
> +
> +	mobiveil_csr_writel(pcie, upper_32_bits(size64),
> +			    PAB_EXT_PEX_AMAP_SIZEN(win_num));
> +
> +	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr),
> +			    PAB_PEX_AMAP_AXI_WIN(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
> +			    PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
> +
> +	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
> +			    PAB_PEX_AMAP_PEX_WIN_L(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
> +			    PAB_PEX_AMAP_PEX_WIN_H(win_num));
> +
> +	pcie->ib_wins_configured++;
> +}
> +
> +/*
> + * routine to program the outbound windows
> + */
> +void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
> +			u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
> +{
> +	u32 value;
> +	u64 size64 = ~(size - 1);
> +
> +	if (win_num >= pcie->apio_wins) {
> +		dev_err(&pcie->pdev->dev,
> +			"ERROR: max outbound windows reached !\n");
> +		return;
> +	}
> +
> +	/*
> +	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
> +	 * to 4 KB in PAB_AXI_AMAP_CTRL register
> +	 */
> +	value = mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
> +	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
> +	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
> +		 (lower_32_bits(size64) & WIN_SIZE_MASK);
> +	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
> +
> +	mobiveil_csr_writel(pcie, upper_32_bits(size64),
> +			    PAB_EXT_AXI_AMAP_SIZE(win_num));
> +
> +	/*
> +	 * program AXI window base with appropriate value in
> +	 * PAB_AXI_AMAP_AXI_WIN0 register
> +	 */
> +	mobiveil_csr_writel(pcie,
> +			    lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
> +			    PAB_AXI_AMAP_AXI_WIN(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
> +			    PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
> +
> +	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
> +			    PAB_AXI_AMAP_PEX_WIN_L(win_num));
> +	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
> +			    PAB_AXI_AMAP_PEX_WIN_H(win_num));
> +
> +	pcie->ob_wins_configured++;
> +}
> +
> +int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
> +{
> +	int retries;
> +
> +	/* check if the link is up or not */
> +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> +		if (mobiveil_pcie_link_up(pcie))
> +			return 0;
> +
> +		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
> +	}
> +
> +	dev_err(&pcie->pdev->dev, "link never came up\n");
> +
> +	return -ETIMEDOUT;
> +}
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> new file mode 100644
> index 000000000000..e3148078e9dd
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -0,0 +1,178 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * PCIe host controller driver for Mobiveil PCIe Host controller
> + *
> + * Copyright (c) 2018 Mobiveil Inc.
> + * Copyright 2019 NXP
> + *
> + * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
> + * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> + */
> +
> +#ifndef _PCIE_MOBIVEIL_H
> +#define _PCIE_MOBIVEIL_H
> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/msi.h>
> +#include "../../pci.h"
> +
> +/* register offsets and bit positions */
> +
> +/*
> + * translation tables are grouped into windows, each window registers are
> + * grouped into blocks of 4 or 16 registers each
> + */
> +#define PAB_REG_BLOCK_SIZE		16
> +#define PAB_EXT_REG_BLOCK_SIZE		4
> +
> +#define PAB_REG_ADDR(offset, win)	\
> +	(offset + (win * PAB_REG_BLOCK_SIZE))
> +#define PAB_EXT_REG_ADDR(offset, win)	\
> +	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
> +
> +#define LTSSM_STATUS			0x0404
> +#define  LTSSM_STATUS_L0_MASK		0x3f
> +#define  LTSSM_STATUS_L0		0x2d
> +
> +#define PAB_CTRL			0x0808
> +#define  AMBA_PIO_ENABLE_SHIFT		0
> +#define  PEX_PIO_ENABLE_SHIFT		1
> +#define  PAGE_SEL_SHIFT			13
> +#define  PAGE_SEL_MASK			0x3f
> +#define  PAGE_LO_MASK			0x3ff
> +#define  PAGE_SEL_OFFSET_SHIFT		10
> +
> +#define PAB_AXI_PIO_CTRL		0x0840
> +#define  APIO_EN_MASK			0xf
> +
> +#define PAB_PEX_PIO_CTRL		0x08c0
> +#define  PIO_ENABLE_SHIFT		0
> +
> +#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
> +#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
> +#define  PAB_INTP_INTX_MASK		0x01e0
> +#define  PAB_INTP_MSI_MASK		0x8
> +
> +#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
> +#define  WIN_ENABLE_SHIFT		0
> +#define  WIN_TYPE_SHIFT			1
> +#define  WIN_TYPE_MASK			0x3
> +#define  WIN_SIZE_MASK			0xfffffc00
> +
> +#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
> +
> +#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
> +#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
> +#define  AXI_WINDOW_ALIGN_MASK		3
> +
> +#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
> +#define  PAB_BUS_SHIFT			24
> +#define  PAB_DEVICE_SHIFT		19
> +#define  PAB_FUNCTION_SHIFT		16
> +
> +#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
> +#define PAB_INTP_AXI_PIO_CLASS		0x474
> +
> +#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
> +#define  AMAP_CTRL_EN_SHIFT		0
> +#define  AMAP_CTRL_TYPE_SHIFT		1
> +#define  AMAP_CTRL_TYPE_MASK		3
> +
> +#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
> +#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
> +#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
> +#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
> +#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
> +
> +/* starting offset of INTX bits in status register */
> +#define PAB_INTX_START			5
> +
> +/* supported number of MSI interrupts */
> +#define PCI_NUM_MSI			16
> +
> +/* MSI registers */
> +#define MSI_BASE_LO_OFFSET		0x04
> +#define MSI_BASE_HI_OFFSET		0x08
> +#define MSI_SIZE_OFFSET			0x0c
> +#define MSI_ENABLE_OFFSET		0x14
> +#define MSI_STATUS_OFFSET		0x18
> +#define MSI_DATA_OFFSET			0x20
> +#define MSI_ADDR_L_OFFSET		0x24
> +#define MSI_ADDR_H_OFFSET		0x28
> +
> +/* outbound and inbound window definitions */
> +#define WIN_NUM_0			0
> +#define WIN_NUM_1			1
> +#define CFG_WINDOW_TYPE			0
> +#define IO_WINDOW_TYPE			1
> +#define MEM_WINDOW_TYPE			2
> +#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
> +#define MAX_PIO_WINDOWS			8
> +
> +/* Parameters for the waiting for link up routine */
> +#define LINK_WAIT_MAX_RETRIES		10
> +#define LINK_WAIT_MIN			90000
> +#define LINK_WAIT_MAX			100000
> +
> +#define PAGED_ADDR_BNDRY		0xc00
> +#define OFFSET_TO_PAGE_ADDR(off)	\
> +	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
> +#define OFFSET_TO_PAGE_IDX(off)		\
> +	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
> +
> +struct mobiveil_msi {			/* MSI information */
> +	struct mutex lock;		/* protect bitmap variable */
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *dev_domain;
> +	phys_addr_t msi_pages_phys;
> +	int num_of_vectors;
> +	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
> +};
> +
> +struct root_port {
> +	char root_bus_nr;
> +	void __iomem *config_axi_slave_base;	/* endpoint config base */
> +	struct resource *ob_io_res;
> +	int irq;
> +	raw_spinlock_t intx_mask_lock;
> +	struct irq_domain *intx_domain;
> +	struct mobiveil_msi msi;
> +	struct pci_host_bridge *bridge;
> +};
> +
> +struct mobiveil_pcie {
> +	struct platform_device *pdev;
> +	void __iomem *csr_axi_slave_base;	/* root port config base */
> +	void __iomem *apb_csr_base;	/* MSI register base */
> +	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
> +	int apio_wins;
> +	int ppio_wins;
> +	int ob_wins_configured;		/* configured outbound windows */
> +	int ib_wins_configured;		/* configured inbound windows */
> +	struct root_port rp;
> +};
> +
> +int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
> +bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
> +int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
> +void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
> +			u64 pci_addr, u32 type, u64 size);
> +void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
> +			u64 pci_addr, u32 type, u64 size);
> +u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
> +void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
> +			size_t size);
> +
> +static inline u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
> +{
> +	return mobiveil_csr_read(pcie, off, 0x4);
> +}
> +
> +static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val,
> +				       u32 off)
> +{
> +	mobiveil_csr_write(pcie, val, off, 0x4);
> +}
> +
> +#endif /* _PCIE_MOBIVEIL_H */
> -- 
> 2.17.1
> 
