Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0B2C2998
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 00:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfI3WbU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 18:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfI3WbU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 18:31:20 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCF6220842;
        Mon, 30 Sep 2019 22:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569882679;
        bh=3hlrgytMsPG+Nev+4sXHGMfpWpuL+FFTmPNPIizXz4Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QzDciQpN52a/HyjuM3ARibJ1X2XtHJbWTe0x/FhRta1fa7GozAQPiQm/Y7RA1Skew
         KVQAOdj8auXOZTuby4unk9zaeFNcM+FNwqdG0ExczvJ8FRr5GfSRbALg9RJ+QEM1rU
         +cDcUF2xmIarD1CMNIBuJZ9mk2eqAiC7paElK9QQ=
Date:   Mon, 30 Sep 2019 17:31:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Move ATS declarations to linux/pci-ats.h
Message-ID: <20190930223117.GA215913@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190914213032.22314-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 14, 2019 at 11:30:32PM +0200, Krzysztof Wilczynski wrote:
> Move ATS function prototypes from include/linux/pci.h
> to include/linux/pci-ats.h as the ATS, PRI, and PASID
> interfaces are related, and are used only by the IOMMU
> drivers.  This effecively reverts the change done in
> commit ff9bee895c4d ("PCI: Move ATS declarations to
> linux/pci.h so they're all together").
> 
> Also, remove surplus forward declaration of struct pci_ats
> from include/linux/pci.h, as it is no longer needed, since
> the struct pci_ats has been embedded directly into struct
> pci_dev in the commit d544d75ac96a ("PCI: Embed ATS info
> directly into struct pci_dev").
> 
> No functional changes intended.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>

Applied to pci/virtualization for v5.5, thanks!

> ---
> Related:
>   https://lore.kernel.org/r/20190902211100.GH7013@google.com
>   https://lore.kernel.org/r/20190724233848.73327-9-skunberg.kelsey@gmail.com
> 
>  include/linux/pci-ats.h | 76 +++++++++++++++--------------------------
>  include/linux/pci.h     | 14 --------
>  2 files changed, 28 insertions(+), 62 deletions(-)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 1ebb88e7c184..a2001673d445 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -4,74 +4,54 @@
>  
>  #include <linux/pci.h>
>  
> -#ifdef CONFIG_PCI_PRI
> +#ifdef CONFIG_PCI_ATS
> +/* Address Translation Service */
> +int pci_enable_ats(struct pci_dev *dev, int ps);
> +void pci_disable_ats(struct pci_dev *dev);
> +int pci_ats_queue_depth(struct pci_dev *dev);
> +int pci_ats_page_aligned(struct pci_dev *dev);
> +#else /* CONFIG_PCI_ATS */
> +static inline int pci_enable_ats(struct pci_dev *d, int ps)
> +{ return -ENODEV; }
> +static inline void pci_disable_ats(struct pci_dev *d) { }
> +static inline int pci_ats_queue_depth(struct pci_dev *d)
> +{ return -ENODEV; }
> +static inline int pci_ats_page_aligned(struct pci_dev *dev)
> +{ return 0; }
> +#endif /* CONFIG_PCI_ATS */
>  
> +#ifdef CONFIG_PCI_PRI
>  int pci_enable_pri(struct pci_dev *pdev, u32 reqs);
>  void pci_disable_pri(struct pci_dev *pdev);
>  void pci_restore_pri_state(struct pci_dev *pdev);
>  int pci_reset_pri(struct pci_dev *pdev);
> -
>  #else /* CONFIG_PCI_PRI */
> -
>  static inline int pci_enable_pri(struct pci_dev *pdev, u32 reqs)
> -{
> -	return -ENODEV;
> -}
> -
> -static inline void pci_disable_pri(struct pci_dev *pdev)
> -{
> -}
> -
> -static inline void pci_restore_pri_state(struct pci_dev *pdev)
> -{
> -}
> -
> +{ return -ENODEV; }
> +static inline void pci_disable_pri(struct pci_dev *pdev) { }
> +static inline void pci_restore_pri_state(struct pci_dev *pdev) { }
>  static inline int pci_reset_pri(struct pci_dev *pdev)
> -{
> -	return -ENODEV;
> -}
> -
> +{ return -ENODEV; }
>  #endif /* CONFIG_PCI_PRI */
>  
>  #ifdef CONFIG_PCI_PASID
> -
>  int pci_enable_pasid(struct pci_dev *pdev, int features);
>  void pci_disable_pasid(struct pci_dev *pdev);
>  void pci_restore_pasid_state(struct pci_dev *pdev);
>  int pci_pasid_features(struct pci_dev *pdev);
>  int pci_max_pasids(struct pci_dev *pdev);
>  int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> -
> -#else  /* CONFIG_PCI_PASID */
> -
> +#else /* CONFIG_PCI_PASID */
>  static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
> -{
> -	return -EINVAL;
> -}
> -
> -static inline void pci_disable_pasid(struct pci_dev *pdev)
> -{
> -}
> -
> -static inline void pci_restore_pasid_state(struct pci_dev *pdev)
> -{
> -}
> -
> +{ return -EINVAL; }
> +static inline void pci_disable_pasid(struct pci_dev *pdev) { }
> +static inline void pci_restore_pasid_state(struct pci_dev *pdev) { }
>  static inline int pci_pasid_features(struct pci_dev *pdev)
> -{
> -	return -EINVAL;
> -}
> -
> +{ return -EINVAL; }
>  static inline int pci_max_pasids(struct pci_dev *pdev)
> -{
> -	return -EINVAL;
> -}
> -
> +{ return -EINVAL; }
>  static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
> -{
> -	return 0;
> -}
> +{ return 0; }
>  #endif /* CONFIG_PCI_PASID */
>  
> -
> -#endif /* LINUX_PCI_ATS_H*/
> +#endif /* LINUX_PCI_ATS_H */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 56767f50ad96..5f2ae580bd19 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -284,7 +284,6 @@ struct irq_affinity;
>  struct pcie_link_state;
>  struct pci_vpd;
>  struct pci_sriov;
> -struct pci_ats;
>  struct pci_p2pdma;
>  
>  /* The pci_dev structure describes PCI devices */
> @@ -1764,19 +1763,6 @@ static inline const struct pci_device_id *pci_match_id(const struct pci_device_i
>  static inline bool pci_ats_disabled(void) { return true; }
>  #endif /* CONFIG_PCI */
>  
> -#ifdef CONFIG_PCI_ATS
> -/* Address Translation Service */
> -int pci_enable_ats(struct pci_dev *dev, int ps);
> -void pci_disable_ats(struct pci_dev *dev);
> -int pci_ats_queue_depth(struct pci_dev *dev);
> -int pci_ats_page_aligned(struct pci_dev *dev);
> -#else
> -static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> -static inline void pci_disable_ats(struct pci_dev *d) { }
> -static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> -static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> -#endif
> -
>  /* Include architecture-dependent settings and functions */
>  
>  #include <asm/pci.h>
> -- 
> 2.23.0
> 
