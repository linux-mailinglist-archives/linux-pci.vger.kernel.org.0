Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 754C8167C44
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2020 12:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBULhK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Feb 2020 06:37:10 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49306 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgBULhK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Feb 2020 06:37:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01LBaeiV060451;
        Fri, 21 Feb 2020 05:36:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582285000;
        bh=EcRsLSr8W7nw5h4+Jtj+iHEI5lrm+n8a9Rg2plUXAEg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uLFB0+JoRywtNV6I1qOYMV6dmYyC57xd8KPxR+txKiEfEG1DweTd+v3WwJ5sSkbtN
         2q8PQiNtcue3WO1R/bNqQIKWaKiI1nyKKtpPrSbdyl+3KwqRWTNW/Gi9j935WWuHeg
         t9it8jXfe9oTRL0TwGhlIZBxxVa/gVGn2ukRbCIc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01LBaeYs094127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Feb 2020 05:36:40 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 21
 Feb 2020 05:36:40 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 21 Feb 2020 05:36:40 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01LBaXsg070114;
        Fri, 21 Feb 2020 05:36:34 -0600
Subject: Re: [PATCH v4 3/6] PCI: endpoint: Add support to handle multiple base
 for mapping outbound memory
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
CC:     Andrew Murray <andrew.murray@arm.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200208183641.6674-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <ea5fa2ec-3c0c-0343-0b14-9bbfa93feaa3@ti.com>
Date:   Fri, 21 Feb 2020 17:10:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200208183641.6674-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Prabhakar,

On 09/02/20 12:06 am, Lad Prabhakar wrote:
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

This patch looks much better now except for one comment below..
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c |   7 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c  |  29 ++--
>  drivers/pci/controller/pcie-rockchip-ep.c        |   7 +-
>  drivers/pci/endpoint/pci-epc-mem.c               | 166 ++++++++++++++++-------
>  include/linux/pci-epc.h                          |  39 ++++--
>  5 files changed, 168 insertions(+), 80 deletions(-)
> 
.
.
<snip>
.
.
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index d2b174c..b3eedee 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -38,57 +38,76 @@ static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
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
> -
> -	if (page_size < PAGE_SIZE)
> -		page_size = PAGE_SIZE;
> -
> -	page_shift = ilog2(page_size);
> -	pages = size >> page_shift;
> -	bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> -
> -	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> -	if (!mem) {
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> -	if (!bitmap) {
> -		ret = -ENOMEM;
> -		goto err_mem;
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
> +
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
> +
> +		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> +		if (!bitmap) {
> +			ret = -ENOMEM;
> +			goto err_mem;
> +		}
> +
> +		mem->bitmap = bitmap;
> +		mem->window.phys_base = windows[i].phys_base;
> +		mem->page_size = page_size;
> +		mem->pages = pages;
> +		mem->window.size = windows[i].size;
> +		epc->mem[i] = mem;
>  	}
> -
> -	mem->bitmap = bitmap;
> -	mem->phys_base = phys_base;
> -	mem->page_size = page_size;
> -	mem->pages = pages;
> -	mem->size = size;
> -
> -	epc->mem = mem;
> +	epc->mem_windows = num_windows;
>  
>  	return 0;
>  
>  err_mem:
> -	kfree(mem);
> +	for (; i >= 0; i--) {
> +		mem = epc->mem[i];
> +		kfree(mem->bitmap);
> +		kfree(mem);
> +	}
> +	kfree(epc->mem);
>  
> -err:
> -return ret;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
>  
> @@ -101,11 +120,21 @@ EXPORT_SYMBOL_GPL(__pci_epc_mem_init);
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
> +		kfree(mem);
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
> @@ -121,20 +150,30 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> -	int pageno;
> -	void __iomem *virt_addr;
> -	struct pci_epc_mem *mem = epc->mem;
> -	unsigned int page_shift = ilog2(mem->page_size);
> +	void __iomem *virt_addr = NULL;
> +	struct pci_epc_mem *mem;
> +	unsigned int page_shift;
> +	int pageno = -EINVAL;
>  	int order;
> +	int i;
>  
> -	size = ALIGN(size, mem->page_size);
> -	order = pci_epc_mem_get_order(mem, size);
> +	for (i = 0; i < epc->mem_windows; i++) {
> +		mem = epc->mem[i];
> +		size = ALIGN(size, mem->page_size);
> +		order = pci_epc_mem_get_order(mem, size);
> +
> +		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> +						 order);
> +		if (pageno >= 0)
> +			break;
> +	}
>  
> -	pageno = bitmap_find_free_region(mem->bitmap, mem->pages, order);
>  	if (pageno < 0)
>  		return NULL;
>  
> -	*phys_addr = mem->phys_base + ((phys_addr_t)pageno << page_shift);
> +	page_shift = ilog2(mem->page_size);
> +	*phys_addr = mem->window.phys_base +
> +		     ((phys_addr_t)pageno << page_shift);
>  	virt_addr = ioremap(*phys_addr, size);
>  	if (!virt_addr)
>  		bitmap_release_region(mem->bitmap, pageno, order);
> @@ -143,6 +182,22 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> +struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> +						phys_addr_t phys_addr)
> +{
> +	struct pci_epc_mem *mem;
> +	int i;
> +
> +	for (i = 0; i < epc->mem_windows; i++) {
> +		mem = epc->mem[i];
> +
> +		if (mem->window.phys_base == phys_addr)
> +			return mem;

This will work only if the phys_addr is same as start of windows base.
This need not be true for all the platforms and will fail for all the
allocations except the first allocation.

Thanks
Kishon
