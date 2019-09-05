Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C278AABDC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfIETS5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:18:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbfIETS5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 15:18:57 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1C0D2070C;
        Thu,  5 Sep 2019 19:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567711137;
        bh=lHXmlHm6b27COW2mrPddTjNkNktmB067pe+ggnrN9zM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQgeQyYq3J1fVBeqhZ6zgMOh3rD8fHwSWpiNbWn6eEG9+eOBQjmeiflIt0aBOeMBF
         2MRyXsMLhrxjgU5uh1G87ULtbMFmx4YJLDJgQ7UADbxMk6Ynm2Fs1jtoPkgNjmRI3v
         55h1Py/o91DxZH7kigWIYE7CmJ9ZzvwWIjGEgeBE=
Date:   Thu, 5 Sep 2019 14:18:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v7 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
Message-ID: <20190905191854.GE103977@google.com>
References: <cover.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <ef40dbdc4eae32490caec47bed5b57eeb438dd80.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef40dbdc4eae32490caec47bed5b57eeb438dd80.1567029860.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 28, 2019 at 03:14:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Since pci_prg_resp_pasid_required() function has dependency on both
> PASID and PRI, define it only if both CONFIG_PCI_PRI and
> CONFIG_PCI_PASID config options are enabled.
> 
> Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
> interface.")

[Don't split tags, including "Fixes:" across lines]

This definitely doesn't fix e5567f5f6762.  That commit added
pci_prg_resp_pasid_required(), but with no dependency on
CONFIG_PCI_PRI or CONFIG_PCI_PASID.

This patch is only required when a subsequent patch is applied.  It
should be squashed into the commit that requires it so it's obvious
why it's needed.

I've been poking at this series, and I'll post a v8 soon with this and
other fixes.

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/ats.c       | 10 ++++++----
>  include/linux/pci-ats.h | 12 +++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index e18499243f84..cdd936d10f68 100644
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
