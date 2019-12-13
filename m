Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C408911EC88
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 22:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfLMVGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 16:06:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfLMVGV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 16:06:21 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233352467F;
        Fri, 13 Dec 2019 21:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576271179;
        bh=OP2MD7vVXuZ/HR6hPSa6omAMP75J4W5hL0C2oHOrUbs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tx+2GWSRS+H8b4lB7kgdEPsStI0GtH+zDkqAG67ypoIIrqqt1s663RnkMCFrLSqff
         XJ31ChhjjricI9t0Z3pQjlMvfnk45c2HM93aIYDFnOUALEy6BYrnt3S/OJxBr+as0W
         AEDghZjQNgcTIedqSsall4WFzRdLjOdmi2o27CEU=
Date:   Fri, 13 Dec 2019 15:06:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [v2 2/6] pci: endpoint: add support to handle features of
 outbound memory
Message-ID: <20191213195727.GA170874@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213084748.11210-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 08:47:44AM +0000, Lad Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> rcar pcie controller has support to map multiple memory regions
> for mapping the outbound memory in local system, this feature
> inspires to add support for handling such features in endpoint
> framework. similar features exists on other controllers where
> outbound regions can be specifically used for low/high priority
> transactions, and regions can be flagged and used for allocation
> of large/small memory allocations.
> This patch adds support to handle such features, where the
> properties described for outbound regions are used whenever a
> request to memory is made.

For this and the other patches, please:

  - start sentences with a capital letter
  - leave a blank line between paragraphs
  - wrap commit log text to use the whole 80 character line (I wrap to
    75 characters to account for "git log" indenting by 4 spaces)
  - check your signed-off-by: it shows your name as "Lad, Prabhakar",
    while your email From: line shows "Lad Prabhakar".  Choose one :)

> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index 2bf8bd1..4b610cd 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c

> -int __pci_epc_mem_init(struct pci_epc *epc, phys_addr_t phys_base, size_t size,
> -		       size_t page_size)
> +int __pci_epc_mem_init(struct pci_epc *epc, struct pci_epc_mem_window *windows,
> +		       int num_windows, size_t page_size)
>  {
> -	int ret;
> -	struct pci_epc_mem *mem;
> -	unsigned long *bitmap;
> +	struct pci_epc_mem *mem = NULL;
> +	unsigned long *bitmap = NULL;
>  	unsigned int page_shift;
> -	int pages;
>  	int bitmap_size;
> +	int pages;
> +	int ret;
> +	int i;
> +
> +	epc->mem_windows = 0;
> +
> +	if (!windows)
> +		return -EINVAL;
> +
> +	if (num_windows <= 0)
> +		return -EINVAL;

Why is num_windows signed?

>  void pci_epc_mem_exit(struct pci_epc *epc)
>  {
> -	struct pci_epc_mem *mem = epc->mem;
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	if (!epc->mem_windows)
> +		return;

If you fix the loop below, why do you even need to test this?

> +	for (i = 0; i <= epc->mem_windows; i--) {

Huh?  "<="?  "i--"?  Surely you mean

	for (i = 0; i < epc->mem_windows; i++) {

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
> +static int pci_epc_find_best_fit_window(struct pci_epc *epc, size_t size,
> +					u32 flags)

Can this just return a struct pci_epc_mem *, so the caller doesn't
have to lookup epc->mem[i] again?

> +{
> +	size_t window_least_size = 0;
> +	int best_fit_window = -1;
> +	struct pci_epc_mem *mem;
> +	size_t actual_size;
> +	size_t avail_size;
> +	u32 win_flags;
> +	int i;
> +
> +	for (i = 0; i < epc->mem_windows; i++) {
> +		mem = epc->mem[i];
> +		win_flags = mem->window.flags;
> +
> +		actual_size = ALIGN(size, mem->page_size);
> +		avail_size = mem->window.size - mem->window.map_size;
> +
> +		if (win_flags == 0x0) {
> +			if (best_fit_window == -1) {
> +				if (actual_size <= avail_size) {
> +					best_fit_window = i;
> +					window_least_size = mem->window.size;
> +				}
> +			} else {
> +				if (actual_size <= avail_size &&
> +				    mem->window.size < window_least_size) {
> +					best_fit_window = i;
> +					window_least_size = mem->window.size;
> +				}
> +			}
> +		} else {
> +			if (mem->window.map_size &&
> +			    (win_flags | PCI_EPC_WINDOW_FLAG_NON_MULTI_ALLOC))
> +				continue;
> +
> +			if (!(win_flags | flags))
> +				continue;
> +
> +			if (best_fit_window == -1) {
> +				if (actual_size <= avail_size) {
> +					best_fit_window = i;
> +					window_least_size = mem->window.size;
> +				}
> +			} else {
> +				if (actual_size <= avail_size &&
> +				    mem->window.size < window_least_size) {
> +					best_fit_window = i;
> +					window_least_size = mem->window.size;
> +				}
> +			}
> +		}
> +	}
> +
> +	return best_fit_window;
> +}
> +
>  /**
>   * pci_epc_mem_alloc_addr() - allocate memory address from EPC addr space
>   * @epc: the EPC device on which memory has to be allocated
>   * @phys_addr: populate the allocated physical address here
> + * @window: populate the window here which will be used to map PCI address
>   * @size: the size of the address space that has to be allocated
> + * @flags: look for window as requested in flags
>   *
>   * Invoke to allocate memory address from the EPC address space. This
>   * is usually done to map the remote RC address into the local system.
>   */
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> -				     phys_addr_t *phys_addr, size_t size)
> +				     phys_addr_t *phys_addr,
> +				     int *window, size_t size, uint32_t flags)
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

Why bother testing epc->mem_windows here?  Just make sure
pci_epc_find_best_fit_window() returns the correct thing for
"mem_windows == 0" and "mem_windows == 1", and remove both the tests
above.

> +		best_fit = pci_epc_find_best_fit_window(epc, size, flags);
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
>  
> -	*phys_addr = mem->phys_base + (pageno << page_shift);
> +	*phys_addr = mem->window.phys_base + (pageno << page_shift);
>  	virt_addr = ioremap(*phys_addr, size);
> -	if (!virt_addr)
> +	if (!virt_addr) {
>  		bitmap_release_region(mem->bitmap, pageno, order);
> +	} else {
> +		mem->window.map_size += size;
> +		*window = best_fit;
> +	}
>  
>  	return virt_addr;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> +static int pci_epc_get_matching_window(struct pci_epc *epc,
> +				       phys_addr_t phys_addr)

Return struct pci_epc_mem * again?

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
> @@ -155,16 +281,26 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
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

Same here (unnecessary test).

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

> @@ -85,7 +126,8 @@ struct pci_epc_mem {
>   * @dev: PCI EPC device
>   * @pci_epf: list of endpoint functions present in this EPC device
>   * @ops: function pointers for performing endpoint operations
> - * @mem: address space of the endpoint controller
> + * @mem: array of address space of the endpoint controller
> + * @mem_windows: number of windows supported by device
>   * @max_functions: max number of functions that can be configured in this EPC
>   * @group: configfs group representing the PCI EPC device
>   * @lock: spinlock to protect pci_epc ops
> @@ -94,7 +136,8 @@ struct pci_epc {
>  	struct device			dev;
>  	struct list_head		pci_epf;
>  	const struct pci_epc_ops	*ops;
> -	struct pci_epc_mem		*mem;
> +	struct pci_epc_mem		**mem;
> +	int				mem_windows;

Can't this be unsigned int and then there's no need to check
"mem_windows < 0"?

>  	u8				max_functions;
>  	struct config_group		*group;
>  	/* spinlock to protect against concurrent access of EP controller */
