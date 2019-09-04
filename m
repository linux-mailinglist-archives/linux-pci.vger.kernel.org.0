Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5380A88D8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 21:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfIDOdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 10:33:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727083AbfIDOdz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Sep 2019 10:33:55 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 88FECCA4B544D53707B2;
        Wed,  4 Sep 2019 22:33:53 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 22:33:52 +0800
Subject: Re: PCI: Add stub pci_irq_vector and others
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <20190904122600.GA28660@gondor.apana.org.au>
CC:     Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <d5178f1e-0436-9d57-12c9-563e9bac82e2@huawei.com>
Date:   Wed, 4 Sep 2019 22:33:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190904122600.GA28660@gondor.apana.org.au>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019/9/4 20:26, Herbert Xu wrote:
> On Wed, Sep 04, 2019 at 05:10:34AM -0700, Ard Biesheuvel wrote:
>>
>> This is the reason we have so many empty static inline functions in
>> header files - it ensures that the symbols are declared even if the
>> only invocations are from dead code.
> 
> Does this patch work?

It works, Thanks.

Tested-by: YueHaibing <yuehaibing@huawei.com>

> 
> ---8<---
> This patch adds stub functions pci_alloc_irq_vectors_affinity and
> pci_irq_vector when CONFIG_PCI is off so that drivers can use them
> without resorting to ifdefs.
> 
> It also moves the PCI_IRQ_* macros outside of the ifdefs so that
> they are always available.
> 
> Fixes: 625f269a5a7a ("crypto: inside-secure - add support for...")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9f28..74415ee62211 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -925,6 +925,11 @@ enum {
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
>  };
>  
> +#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
> +#define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
> +#define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
> +#define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
> +
>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
>  
> @@ -1408,11 +1413,6 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  		      unsigned int command_bits, u32 flags);
>  
> -#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
> -#define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
> -#define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
> -#define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
> -
>  /*
>   * Virtual interrupts allow for more interrupts to be allocated
>   * than the device has interrupts for. These are not programmed
> @@ -1517,14 +1517,6 @@ static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
>  }
>  #endif
>  
> -static inline int
> -pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> -		      unsigned int max_vecs, unsigned int flags)
> -{
> -	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
> -					      NULL);
> -}
> -
>  /**
>   * pci_irqd_intx_xlate() - Translate PCI INTx value to an IRQ domain hwirq
>   * @d: the INTx IRQ domain
> @@ -1780,8 +1772,29 @@ static inline const struct pci_device_id *pci_match_id(const struct pci_device_i
>  							 struct pci_dev *dev)
>  { return NULL; }
>  static inline bool pci_ats_disabled(void) { return true; }
> +
> +static inline int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int
> +pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +			       unsigned int max_vecs, unsigned int flags,
> +			       struct irq_affinity *aff_desc)
> +{
> +	return -ENOSPC;
> +}
>  #endif /* CONFIG_PCI */
>  
> +static inline int
> +pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +		      unsigned int max_vecs, unsigned int flags)
> +{
> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
> +					      NULL);
> +}
> +
>  #ifdef CONFIG_PCI_ATS
>  /* Address Translation Service */
>  void pci_ats_init(struct pci_dev *dev);
> 

