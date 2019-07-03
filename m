Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7D445EAFB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 19:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfGCR45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 13:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfGCR44 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 13:56:56 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D752184C;
        Wed,  3 Jul 2019 17:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176615;
        bh=5x9nYr/bGtljeo+8XgQwsEz86LG7/Qa1TONMqcKMLrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SA8RPFrWCwm9msjhObImMtqTZdAN5oNTrvABGhRXT/ipfE+q9BkK9sOiE82WKFakY
         Ov2czFSZ62pGhHWnaKDWxfjfG99LMRHQRewYtS7WVBORQA78tJ04yQhn0WNyKyYEBL
         NyXflP/xQJtjvF8NiKQ9CYWZ8sHyALj0BwM5HReo=
Date:   Wed, 3 Jul 2019 12:56:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v3 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
Message-ID: <20190703175654.GN128603@google.com>
References: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a0534c2ec69e0d7e03c4da3e8d539e8591a5686c.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0534c2ec69e0d7e03c4da3e8d539e8591a5686c.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 01:38:42PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Since pci_prg_resp_pasid_required() function has dependency on both
> PASID and PRI, define it only if both CONFIG_PCI_PRI and
> CONFIG_PCI_PASID config options are enabled.

This is likely just confusion on my part, but I don't understand what
you're doing here.

pci_prg_resp_pasid_required() does not actually *depend* on the
CONFIG_PCI_PRI config symbol.

It is currently compiled only if CONFIG_PCI_ATS=y (which controls
compilation of the entire ats.c) and CONFIG_PCI_PASID=y (since it's
within #ifdef CONFIG_PCI_PASID).

pci_prg_resp_pasid_required() is called by attach_device()
(amd_iommu.c), which is only compiled if CONFIG_AMD_IOMMU=y, and that
selects PCI_PRI.

It is also called by iommu_enable_dev_iotlb() (intel-iommu.c).  That
file is compiled if CONFIG_INTEL_IOMMU=y and the call itself is inside
#ifdef CONFIG_INTEL_IOMMU_SVM.  But I don't see the PCI_PRI connection
here.

If this is just to limit the visibility, say that.  But I don't think
that's really a good reason.  The chain of config symbols seems a
little too complicated.

> Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
> interface.")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c       | 10 ++++++----
>  include/linux/pci-ats.h | 12 +++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 97c08146534a..f9eeb7db0db3 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -395,6 +395,8 @@ int pci_pasid_features(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_pasid_features);
>  
> +#ifdef CONFIG_PCI_PRI
> +
>  /**
>   * pci_prg_resp_pasid_required - Return PRG Response PASID Required bit
>   *				 status.
> @@ -402,10 +404,8 @@ EXPORT_SYMBOL_GPL(pci_pasid_features);
>   *
>   * Returns 1 if PASID is required in PRG Response Message, 0 otherwise.
>   *
> - * Even though the PRG response PASID status is read from PRI Status
> - * Register, since this API will mainly be used by PASID users, this
> - * function is defined within #ifdef CONFIG_PCI_PASID instead of
> - * CONFIG_PCI_PRI.
> + * Since this API has dependency on both PRI and PASID, protect it
> + * with both CONFIG_PCI_PRI and CONFIG_PCI_PASID.
>   */
>  int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>  {
> @@ -425,6 +425,8 @@ int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>  }
>  EXPORT_SYMBOL_GPL(pci_prg_resp_pasid_required);
>  
> +#endif
> +
>  #define PASID_NUMBER_SHIFT	8
>  #define PASID_NUMBER_MASK	(0x1f << PASID_NUMBER_SHIFT)
>  /**
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 1ebb88e7c184..1a0bdaee2f32 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -40,7 +40,6 @@ void pci_disable_pasid(struct pci_dev *pdev);
>  void pci_restore_pasid_state(struct pci_dev *pdev);
>  int pci_pasid_features(struct pci_dev *pdev);
>  int pci_max_pasids(struct pci_dev *pdev);
> -int pci_prg_resp_pasid_required(struct pci_dev *pdev);
>  
>  #else  /* CONFIG_PCI_PASID */
>  
> @@ -67,11 +66,18 @@ static inline int pci_max_pasids(struct pci_dev *pdev)
>  	return -EINVAL;
>  }
>  
> +#endif /* CONFIG_PCI_PASID */
> +
> +#if defined(CONFIG_PCI_PRI) && defined(CONFIG_PCI_PASID)
> +
> +int pci_prg_resp_pasid_required(struct pci_dev *pdev);
> +
> +#else /* CONFIG_PCI_PASID && CONFIG_PCI_PRI */
> +
>  static inline int pci_prg_resp_pasid_required(struct pci_dev *pdev)
>  {
>  	return 0;
>  }
> -#endif /* CONFIG_PCI_PASID */
> -
> +#endif
>  
>  #endif /* LINUX_PCI_ATS_H*/
> -- 
> 2.21.0
> 
