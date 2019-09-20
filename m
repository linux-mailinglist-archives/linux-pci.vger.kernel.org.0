Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5576CB97EB
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2019 21:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfITTmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Sep 2019 15:42:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbfITTmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Sep 2019 15:42:20 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FC792080F;
        Fri, 20 Sep 2019 19:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569008538;
        bh=XfrvLsR7U7GA+FNnD4n8DUE8hu+xicJwQHbsa29aZ1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnzn25soggx/Qi7634WAtPzkt9fYU5AfIJlRnndq3hBaRY5YWkq0uGRMrvGlLjGdA
         6PoEKwY5PlRv34+EEHDUOFSyTcZxwJz5g39O9bJ6UUL2IiF+KoO3PqQyLW0T8NbIS3
         e0FfebnWaJXtQ16BXflbJVY5LLNIhZ+5PSs7BAFs=
Date:   Fri, 20 Sep 2019 14:42:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-pci@vger.kernel.org,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pvanleeuwen@insidesecure.com" <pvanleeuwen@insidesecure.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: PCI: Add stub pci_irq_vector and others
Message-ID: <20190920194216.GB226476@google.com>
References: <20190902141910.1080-1-yuehaibing@huawei.com>
 <20190903014518.20880-1-yuehaibing@huawei.com>
 <MN2PR20MB29732EEECB217DDDF822EDA5CAB80@MN2PR20MB2973.namprd20.prod.outlook.com>
 <CAKv+Gu8PVYyA-mzjrhR6r6upMc=xzpAhsbkuKRtb8T2noo_2XQ@mail.gmail.com>
 <20190904122600.GA28660@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904122600.GA28660@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 10:26:00PM +1000, Herbert Xu wrote:
> On Wed, Sep 04, 2019 at 05:10:34AM -0700, Ard Biesheuvel wrote:
> >
> > This is the reason we have so many empty static inline functions in
> > header files - it ensures that the symbols are declared even if the
> > only invocations are from dead code.
> 
> Does this patch work?
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

Since you've already sent your crypto pull request for v5.4, would you
like me to include this in mine?

If you'd rather send it yourself, I'd prefer:

  PCI: Add pci_irq_vector() and other stubs when !CONFIG_PCI

  Add stub functions pci_alloc_irq_vectors_affinity() and
  pci_irq_vector() when CONFIG_PCI is off so drivers can use them
  without resorting to ifdefs.

  Also move the PCI_IRQ_* macros outside of the ifdefs so they are
  always available.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

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
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
