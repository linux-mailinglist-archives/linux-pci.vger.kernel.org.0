Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC563CA099
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 16:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhGOOaJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 10:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhGOOaJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 10:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E7C061380;
        Thu, 15 Jul 2021 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626359235;
        bh=AGyuleLLySuJZOXIhP50qs5G+JR+3YkSlYA9wEtrdFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LAsigfQEioFHBsO2Yfllu37Uivtp8fbLz0MwAN8MRlLxMQHPUp57HSg54SQxkd2Hv
         heYfTnSgyunAAsnbjXORA5Nfo7Dh2Pq9M347Gs3KCgRspQNXssHk5T6gitGls/Mup5
         VI85BHRmF4GVPAil13xrKX53LAsIJ7IuFYltLtWC1Hvw5v4HlpHE70b3GIzCJEVvxb
         90ebkVkyKivVHfnK+HhgW2TNNKMTR1Vtra5cuGIDYkQLuWUl3xguSlUhwK9LRxOuuY
         ehI4h/7zJljh0j4AB70SP4vz6bJUnfMJdf3+ihLiFOcFVXjK0RUfvXoBES7pnpozuW
         1B+jZUJCgnfhw==
Date:   Thu, 15 Jul 2021 09:27:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] genirq/affinity: add helper of irq_affinity_calc_sets
Message-ID: <20210715142714.GA1957636@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715111827.569756-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 07:18:27PM +0800, Ming Lei wrote:
> When driver requests to allocate irq affinity managed vectors,
> pci_alloc_irq_vectors_affinity() may fallback to single vector
> allocation. In this situation, we don't need to call
> irq_create_affinity_masks for calling into ->calc_sets() for
> avoiding potential memory leak, so add the helper for this purpose.
> 
> Fixes: c66d4bd110a1 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Cc: linux-pci@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/pci/msi.c         |  3 ++-
>  include/linux/interrupt.h |  7 +++++++
>  kernel/irq/affinity.c     | 29 ++++++++++++++++++-----------
>  3 files changed, 27 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9232255c8515..3d6db20d1b2b 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1224,7 +1224,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  			 * for the single interrupt case.
>  			 */
>  			if (affd)
> -				irq_create_affinity_masks(1, affd);
> +				WARN_ON_ONCE(irq_affinity_calc_sets(1, affd));

Hmmm.  Not sure I like this yet:

  - I prefer required code to be on its own, not hidden inside a
    WARN() (personal preference, I know).

  - WARN() doesn't seem like the right thing here.  I think this
    generates a backtrace but the driver that called this has no
    indication.  Isn't the problem that a .calc_sets() method set
    "affd->nr_sets > IRQ_AFFINITY_MAX_SETS"?

    It looks like those methods are supplied by drivers
    (nvme_calc_irq_sets(), csio_calc_sets()) and it seems like they
    should find out about this somehow.

>  			pci_intx(dev, 1);
>  			return 1;
>  		}
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 2ed65b01c961..c7ff84d60465 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -340,6 +340,7 @@ irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
>  
>  unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  				       const struct irq_affinity *affd);
> +int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd);
>  
>  #else /* CONFIG_SMP */
>  
> @@ -391,6 +392,12 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
>  	return maxvec;
>  }
>  
> +static inline int irq_affinity_calc_sets(unsigned int affvecs,
> +					 struct irq_affinity *affd)
> +{
> +	return 0;
> +}
> +
>  #endif /* CONFIG_SMP */
>  
>  /*
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index 4d89ad4fae3b..735f697d7d15 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -405,6 +405,23 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
>  	affd->set_size[0] = affvecs;
>  }
>  
> +int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
> +{
> +	/*
> +	 * Simple invocations do not provide a calc_sets() callback. Install
> +	 * the generic one.
> +	 */
> +	if (!affd->calc_sets)
> +		affd->calc_sets = default_calc_sets;
> +
> +	/* Recalculate the sets */
> +	affd->calc_sets(affd, affvecs);
> +
> +	if (affd->nr_sets > IRQ_AFFINITY_MAX_SETS)
> +		return -ERANGE;
> +	return 0;
> +}
> +
>  /**
>   * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
>   * @nvecs:	The total number of vectors
> @@ -429,17 +446,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
>  	else
>  		affvecs = 0;
>  
> -	/*
> -	 * Simple invocations do not provide a calc_sets() callback. Install
> -	 * the generic one.
> -	 */
> -	if (!affd->calc_sets)
> -		affd->calc_sets = default_calc_sets;
> -
> -	/* Recalculate the sets */
> -	affd->calc_sets(affd, affvecs);
> -
> -	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
> +	if (WARN_ON_ONCE(irq_affinity_calc_sets(affvecs, affd)))
>  		return NULL;
>  
>  	/* Nothing to assign? */
> -- 
> 2.31.1
> 
