Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB3513532B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 07:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgAIG0A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 01:26:00 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58666 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgAIGZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 01:25:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0096PK1b049200;
        Thu, 9 Jan 2020 00:25:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578551120;
        bh=kAw1vzwuzqIquRbIjNI7JlohBi4vAp/1Yvos+L9W2dQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=zBWYVRXOLHrMXrsOGnxuXx+itbmp/KwB334sy4xemw9xrROks2ldnnaubWOIU46ma
         36Ar6+wl6P/TD1StEfPQUcIkkpmrwWoX5mwIfCDNf30DRF5/QaB9R+QfoxtQ1jzEpr
         t9+a4us9oRzSGJHSlY+XbImGCfNMWfN6xtAodKTY=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0096PKBL078279
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Jan 2020 00:25:20 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 9 Jan
 2020 00:25:19 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 9 Jan 2020 00:25:19 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0096PBR6112605;
        Thu, 9 Jan 2020 00:25:12 -0600
Subject: Re: [v3 3/6] PCI: endpoint: Add support to handle multiple base for
 mapping outbound memory
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-rockchip@lists.infradead.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200108162211.22358-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <53d74632-34ee-f7f7-656f-a93a6c10e7ba@ti.com>
Date:   Thu, 9 Jan 2020 11:57:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200108162211.22358-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 08/01/20 9:52 PM, Lad Prabhakar wrote:
> R-Car PCIe controller has support to map multiple memory regions for
> mapping the outbound memory in local system also the controller limits
> single allocation for each region (that is, once a chunk is used from the
> region it cannot be used to allocate a new one). This features inspires to
> add support for handling multiple memory bases in endpoint framework.
> 
> With this patch pci_epc_mem_init() now accepts multiple regions, also
> page_size for each memory region is passed during initialization so as
> to handle single allocation for each region by setting the page_size to
> window_size.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  |  12 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  31 ++-
>  drivers/pci/controller/pcie-rockchip-ep.c     |  14 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c |  29 +--
>  drivers/pci/endpoint/pci-epc-core.c           |   7 +-
>  drivers/pci/endpoint/pci-epc-mem.c            | 199 ++++++++++++++----
>  include/linux/pci-epc.h                       |  46 ++--
>  7 files changed, 245 insertions(+), 93 deletions(-)
>
.
.
<snip>
.
.
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 2091508c1620..289c266c2d90 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -358,13 +358,15 @@ EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>   * @epc: the EPC device on which address is allocated
>   * @func_no: the endpoint function number in the EPC device
>   * @phys_addr: physical address of the local system
> + * @window: index to the window region where PCI address will be mapped
>   * @pci_addr: PCI address to which the physical address should be mapped
>   * @size: the size of the allocation
>   *
>   * Invoke to map CPU address with PCI address.
>   */
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
> -		     phys_addr_t phys_addr, u64 pci_addr, size_t size)
> +		     phys_addr_t phys_addr, int window,
> +		     u64 pci_addr, size_t size)
>  {
>  	int ret;
>  	unsigned long flags;
> @@ -376,7 +378,8 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no,
>  		return 0;
>  
>  	spin_lock_irqsave(&epc->lock, flags);
> -	ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr, size);
> +	ret = epc->ops->map_addr(epc, func_no, phys_addr,
> +				 window, pci_addr, size);
>  	spin_unlock_irqrestore(&epc->lock, flags);
>  
>  	return ret;
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index d2b174ce15de..f205f7819292 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -38,57 +38,77 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
>  /**
>   * __pci_epc_mem_init() - initialize the pci_epc_mem structure
>   * @epc: the EPC device that invoked pci_epc_mem_init
> - * @phys_base: the physical address of the base
> - * @size: the size of the address space
> - * @page_size: size of each page
> + * @windows: pointer to windows supported by the device
> + * @num_windows: number of windows device supports
>   *
>   * Invoke to initialize the pci_epc_mem structure used by the
>   * endpoint functions to allocate mapped PCI address.
>   */
> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> -		       size_t page_size)
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> +		       int num_windows)
>  {
> -	int ret;
> -	struct pci_epc_mem *mem;
> -	unsigned long *bitmap;
> +	struct pci_epc_mem *mem = NULL;
> +	unsigned long *bitmap = NULL;
>  	unsigned int page_shift;
> -	int pages;
> +	size_t page_size;
>  	int bitmap_size;
> +	int pages;
> +	int ret;
> +	int i;
>  
> -	if (page_size < PAGE_SIZE)
> -		page_size = PAGE_SIZE;
> +	epc->mem_windows = 0;
>  
> -	page_shift = ilog2(page_size);
> -	pages = size >> page_shift;
> -	bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> +	if (!windows)
> +		return -EINVAL;
>  
> -	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> -	if (!mem) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	if (num_windows <= 0)
> +		return -EINVAL;
>  
> -	bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> -	if (!bitmap) {
> -		ret = -ENOMEM;
> -		goto err_mem;
> -	}
> +	epc->mem = kcalloc(num_windows, sizeof(*mem), GFP_KERNEL);
> +	if (!epc->mem)
> +		return -EINVAL;
> +
> +	for (i = 0; i < num_windows; i++) {
> +		page_size = windows[i].page_size;
> +		if (page_size < PAGE_SIZE)
> +			page_size = PAGE_SIZE;
> +		page_shift = ilog2(page_size);
> +		pages = windows[i].size >> page_shift;
> +		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> +
> +		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> +		if (!mem) {
> +			ret = -ENOMEM;
> +			goto err_mem;
> +		}
>  
> -	mem->bitmap = bitmap;
> -	mem->phys_base = phys_base;
> -	mem->page_size = page_size;
> -	mem->pages = pages;
> -	mem->size = size;
> +		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +		if (!bitmap) {
> +			ret = -ENOMEM;
> +			goto err_mem;
> +		}
>  
> -	epc->mem = mem;
> +		mem->bitmap = bitmap;
> +		mem->window.phys_base = windows[i].phys_base;
> +		mem->page_size = page_size;
> +		mem->pages = pages;
> +		mem->window.size = windows[i].size;
> +		mem->window.map_size = 0;
> +
> +		epc->mem[i] = mem;
> +	}
> +	epc->mem_windows = num_windows;
>  
>  	return 0;
>  
>  err_mem:
> -	kfree(mem);
> +	for (; i >= 0; i--) {

mem has to be reinitialized for every iteration of the loop.
> +		kfree(mem->bitmap);
> +		kfree(epc->mem[i]);
> +	}
> +	kfree(epc->mem);
>  
> -err:
> -return ret;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>  
> @@ -101,48 +121,127 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>   */
>  void pci_epc_mem_exit(struct pci_epc *epc)
>  {
> -	struct pci_epc_mem *mem = epc->mem;
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	if (!epc->mem_windows)
> +		return;
> +
> +	for (i = 0; i <= epc->mem_windows; i++) {
> +		mem = epc->mem[i];
> +		kfree(mem->bitmap);
> +		kfree(epc->mem[i]);
> +	}
> +	kfree(epc->mem);
>  
>  	epc->mem = NULL;
> -	kfree(mem->bitmap);
> -	kfree(mem);
> +	epc->mem_windows = 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  
> +static int pci_epc_find_best_fit_window(struct pci_epc *epc, size_t size)
> +{
> +	size_t window_least_size = 0;
> +	int best_fit_window = -1;
> +	struct pci_epc_mem *mem;
> +	size_t actual_size;
> +	size_t avail_size;
> +	int i;
> +
> +	for (i = 0; i < epc->mem_windows; i++) {
> +		mem = epc->mem[i];
> +
> +		actual_size = ALIGN(size, mem->page_size);
> +		avail_size = mem->window.size - mem->window.map_size;
> +
> +		if (best_fit_window == -1) {
> +			if (actual_size <= avail_size) {
> +				best_fit_window = i;
> +				window_least_size = mem->window.size;
> +			}
> +		} else {
> +			if (actual_size <= avail_size &&
> +			    mem->window.size < window_least_size) {
> +				best_fit_window = i;
> +				window_least_size = mem->window.size;
> +			}
> +		}
> +	}
> +
> +	return best_fit_window;
> +}

This function shouldn't be required at all. Just loop over all the
windows invoking bitmap_find_free_region(), breaking the loop if it
succeeds and continuing if there is no free region.
> +
>  /**
>   * pci_epc_mem_alloc_addr() - allocate memory address from EPC addr space
>   * @epc: the EPC device on which memory has to be allocated
>   * @phys_addr: populate the allocated physical address here
> + * @window: populate the window here which will be used to map PCI address
>   * @size: the size of the address space that has to be allocated
>   *
>   * Invoke to allocate memory address from the EPC address space. This
>   * is usually done to map the remote RC address into the local system.
>   */
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> -				     phys_addr_t *phys_addr, size_t size)
> +				     phys_addr_t *phys_addr,
> +				     int *window, size_t size)
>  {
> +	int best_fit = PCI_EPC_DEFAULT_WINDOW;
> +	void __iomem *virt_addr = NULL;
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
>  	int pageno;
> -	void __iomem *virt_addr;
> -	struct pci_epc_mem *mem = epc->mem;
> -	unsigned int page_shift = ilog2(mem->page_size);
>  	int order;
>  
> +	if (epc->mem_windows <= 0)
> +		return NULL;
> +
> +	if (epc->mem_windows > 1) {
> +		best_fit = pci_epc_find_best_fit_window(epc, size);
> +		if (best_fit < 0)
> +			return NULL;
> +	}
> +
> +	mem = epc->mem[best_fit];
>  	size = ALIGN(size, mem->page_size);
> +	if (size > (mem->window.size - mem->window.map_size))
> +		return NULL;
> +	page_shift = ilog2(mem->page_size);
>  	order = pci_epc_mem_get_order(mem, size);
>  
>  	pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
>  	if (pageno < 0)
>  		return NULL;

This has to be invoked now in a loop for the number of windows. If
pageno < 0, continue the loop or else break.
>  
> -	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
> +	*phys_addr = mem->window.phys_base +
> +		     ((phys_addr_t)pageno << page_shift);
>  	virt_addr = ioremap(*phys_addr, size);
> -	if (!virt_addr)
> +	if (!virt_addr) {
>  		bitmap_release_region(mem->bitmap, pageno, order);
> +	} else {
> +		mem->window.map_size += size;

The map_size shouldn't be required.
> +		*window = best_fit;

Can't the platform driver get the window based on the address? Let's try
to avoid modifying API's for platform specific requirements.
> +	}
>  
>  	return virt_addr;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> +static int pci_epc_get_matching_window(struct pci_epc *epc,
> +				       phys_addr_t phys_addr)
> +{
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	for (i = 0; i < epc->mem_windows; i++) {
> +		mem = epc->mem[i];
> +
> +		if (mem->window.phys_base == phys_addr)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  /**
>   * pci_epc_mem_free_addr() - free the allocated memory address
>   * @epc: the EPC device on which memory was allocated
> @@ -155,16 +254,26 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>  			   void __iomem *virt_addr, size_t size)
>  {
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
> +	int window = 0;
>  	int pageno;
> -	struct pci_epc_mem *mem = epc->mem;
> -	unsigned int page_shift = ilog2(mem->page_size);
>  	int order;
>  
> +	if (epc->mem_windows > 1) {
> +		window = pci_epc_get_matching_window(epc, phys_addr);
> +		if (window < 0)
> +			return;
> +	}
> +
> +	mem = epc->mem[window];
> +	page_shift = ilog2(mem->page_size);
>  	iounmap(virt_addr);
> -	pageno = (phys_addr - mem->phys_base) >> page_shift;
> +	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
>  	size = ALIGN(size, mem->page_size);
>  	order = pci_epc_mem_get_order(mem, size);
>  	bitmap_release_region(mem->bitmap, pageno, order);
> +	mem->window.map_size -= size;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 56f1846b9d39..89daafa0d19f 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -48,7 +48,8 @@ struct pci_epc_ops {
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no,
>  			     struct pci_epf_bar *epf_bar);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no,
> -			    phys_addr_t addr, u64 pci_addr, size_t size);
> +			    phys_addr_t addr, int window,
> +			    u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no,
>  			      phys_addr_t addr);
>  	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 interrupts);
> @@ -64,17 +65,31 @@ struct pci_epc_ops {
>  	struct module *owner;
>  };
>  
> +#define PCI_EPC_DEFAULT_WINDOW         0
> +
> +/**
> + * struct pci_epc_mem_window - address window of the endpoint controller
> + * @phys_base: physical base address of the PCI address window
> + * @size: the size of the PCI address window
> + * @map_size: size of allocated chunk in window
> + * @page_size: size of each page
> + */
> +struct pci_epc_mem_window {
> +	phys_addr_t	phys_base;
> +	size_t		size;
> +	size_t		map_size;

mem->bitmap already holds the map_size information. This structure can
be used only for passing info about the mem windows from platform to the
core. So map_size shouldn't be required.

Thanks
Kishon
