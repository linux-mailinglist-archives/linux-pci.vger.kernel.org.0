Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE028A7C8
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 22:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfHLUEV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 16:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727224AbfHLUEV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 16:04:21 -0400
Received: from localhost (c-73-15-1-175.hsd1.ca.comcast.net [73.15.1.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A03620842;
        Mon, 12 Aug 2019 20:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565640260;
        bh=EJ2lTruVh/1fGf2yGnTcEGnDg8x3DVlONmdu9/TL7Iw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nY4XojttZDbG1bic4vcp0d2bSENKgnBmsRaNh3tc3MX/3n9MGraifns3xVE3VTGHs
         j+ajgtfwY0upKodseE2CmYuXCpXZ75NLWkLhm/QcJ9J3EtcQebpt+hotdhtNzUOv0k
         Kotl3ekPcvU15tTvcWt1rjOrM3/TK7K/IPH4tzUk=
Date:   Mon, 12 Aug 2019 15:04:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
Subject: Re: [PATCH v5 1/7] PCI/ATS: Fix pci_prg_resp_pasid_required()
 dependency issues
Message-ID: <20190812200418.GJ11785@google.com>
References: <cover.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0d7e0e0d079c438897f4da8cdca4b55994b1233b.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7e0e0d079c438897f4da8cdca4b55994b1233b.1564702313.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 01, 2019 at 05:05:58PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Since pci_prg_resp_pasid_required() function has dependency on both
> PASID and PRI, define it only if both CONFIG_PCI_PRI and
> CONFIG_PCI_PASID config options are enabled.

I don't really like this.  It makes the #ifdefs more complicated and I
don't think it really buys us anything.  Will anything break if we
just drop this patch?

> Fixes: e5567f5f6762 ("PCI/ATS: Add pci_prg_resp_pasid_required()
> interface.")
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
