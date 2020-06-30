Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196020FFD4
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 00:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgF3WEa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 18:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgF3WEa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 18:04:30 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99E39206B6;
        Tue, 30 Jun 2020 22:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593554670;
        bh=mGA2YplFVjTnmZVR4xUfskfFkFqNGscVAmlQNbhySbI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=p8yt4+qi4BuB9Mc9sfNMTpAWkpq2htNh7wMHhY4tNUsL/Fh9A3cwxhjWGkISAx3Wp
         sRhF5Ux4mEMe8xmN49t3JK0CAshd5Zu4uuTNMTzeutSp9T6zbWhvuM0eFcn+YNHd0a
         oK1kV4BY9JJS+2AuSLrL8lm7XIJrf9RPuBbGTpUQ=
Date:   Tue, 30 Jun 2020 17:04:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI/MSI: Forward MSI-X vector enable error code in
 pci_alloc_irq_vectors_affinity()
Message-ID: <20200630220428.GA3490187@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616073318.20229-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 09:33:16AM +0200, Piotr Stankiewicz wrote:
> When debugging an issue where I was asking the PCI machinery to enable a
> set of MSI-X vectors, without falling back on MSI, I ran across a
> behaviour which seems odd. The pci_alloc_irq_vectors_affinity() will
> always return -ENOSPC on failure, when allocating MSI-X vectors only,
> whereas with MSI fallback it will forward any error returned by
> __pci_enable_msi_range(). This is a confusing behaviour, so have the
> pci_alloc_irq_vectors_affinity() forward the error code from
> __pci_enable_msix_range() when appropriate.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to pci/msi for v5.8, thanks!

> ---
>  drivers/pci/msi.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 6b43a5455c7a..cade9be68b09 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1191,8 +1191,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   struct irq_affinity *affd)
>  {
>  	struct irq_affinity msi_default_affd = {0};
> -	int msix_vecs = -ENOSPC;
> -	int msi_vecs = -ENOSPC;
> +	int nvecs = -ENOSPC;
>  
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
> @@ -1203,17 +1202,16 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	}
>  
>  	if (flags & PCI_IRQ_MSIX) {
> -		msix_vecs = __pci_enable_msix_range(dev, NULL, min_vecs,
> -						    max_vecs, affd, flags);
> -		if (msix_vecs > 0)
> -			return msix_vecs;
> +		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> +						affd, flags);
> +		if (nvecs > 0)
> +			return nvecs;
>  	}
>  
>  	if (flags & PCI_IRQ_MSI) {
> -		msi_vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs,
> -						  affd);
> -		if (msi_vecs > 0)
> -			return msi_vecs;
> +		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> +		if (nvecs > 0)
> +			return nvecs;
>  	}
>  
>  	/* use legacy IRQ if allowed */
> @@ -1231,9 +1229,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		}
>  	}
>  
> -	if (msix_vecs == -ENOSPC)
> -		return -ENOSPC;
> -	return msi_vecs;
> +	return nvecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>  
> -- 
> 2.17.2
> 
