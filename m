Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB78262C4B1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbiKPQgm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiKPQgT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:36:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC82C4AF0F;
        Wed, 16 Nov 2022 08:29:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73A9FB81DEC;
        Wed, 16 Nov 2022 16:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47C0C433C1;
        Wed, 16 Nov 2022 16:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616144;
        bh=hVb5cZ9h4Awq2TaSKDMFPSYVKSJauXtseNAwJdFPQTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sZcXqH8UiU/elt5GvwYbh2B+DZGPqk1sud0NS7fEI0eViqdPkVb+879ylMHAugf+B
         C5+QqPsKMsYDb6sR3DqEvugc1GG0twBVU1LTdpOKNNj/1J9dVphQvJOfzV2YxAaxYN
         dQvudz5Ej3gJABS4RmWFtmjghcLuI05vzt/R+jXC02fkci8X6jJcU1+nEj5oJbYlES
         +ukBtYxfgEsupsfwAFOwMNk9cWfWug3zG3QVZj3upG1hZfG44cNyFrrUcOeFYusaKI
         0zn0M3hyw1qDW/8FNj5lPRuyhS+0s/xbtMPrx3kG+7dLBqto5DiNz8bsGZ3CMuiTou
         A71jz0OhBH/Ww==
Date:   Wed, 16 Nov 2022 10:29:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 33/39] PCI/MSI: Sanitize MSI-X checks
Message-ID: <20221116162902.GA1116195@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.516946468@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:07PM +0100, Thomas Gleixner wrote:
> There is no point in doing the same sanity checks over and over in a loop
> during MSI-X enablement. Put them in front of the loop and return early
> when they fail.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c |   67 +++++++++++++++++++++++++-------------------------
>  1 file changed, 34 insertions(+), 33 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -721,47 +721,31 @@ static int msix_capability_init(struct p
>  	return ret;
>  }
>  
> -static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
> -			     int nvec, struct irq_affinity *affd, int flags)
> +static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int hwsize)
>  {
> -	int nr_entries;
>  	int i, j;
>  
> -	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
> -		return -EINVAL;
> +	if (!entries)
> +		return true;
>  
> -	nr_entries = pci_msix_vec_count(dev);
> -	if (nr_entries < 0)
> -		return nr_entries;
> -	if (nvec > nr_entries && !(flags & PCI_IRQ_VIRTUAL))
> -		return nr_entries;
> -
> -	if (entries) {
> -		/* Check for any invalid entries */
> -		for (i = 0; i < nvec; i++) {
> -			if (entries[i].entry >= nr_entries)
> -				return -EINVAL;		/* invalid entry */
> -			for (j = i + 1; j < nvec; j++) {
> -				if (entries[i].entry == entries[j].entry)
> -					return -EINVAL;	/* duplicate entry */
> -			}
> +	for (i = 0; i < nvec; i++) {
> +		/* Entry within hardware limit? */
> +		if (entries[i].entry >= hwsize)
> +			return false;
> +
> +		/* Check for duplicate entries */
> +		for (j = i + 1; j < nvec; j++) {
> +			if (entries[i].entry == entries[j].entry)
> +				return false;
>  		}
>  	}
> -
> -	/* Check whether driver already requested for MSI IRQ */
> -	if (dev->msi_enabled) {
> -		pci_info(dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
> -		return -EINVAL;
> -	}
> -	return msix_capability_init(dev, entries, nvec, affd);
> +	return true;
>  }
>  
> -int __pci_enable_msix_range(struct pci_dev *dev,
> -			    struct msix_entry *entries, int minvec,
> -			    int maxvec, struct irq_affinity *affd,
> -			    int flags)
> +int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
> +			    int maxvec, struct irq_affinity *affd, int flags)
>  {
> -	int rc, nvec = maxvec;
> +	int hwsize, rc, nvec = maxvec;
>  
>  	if (maxvec < minvec)
>  		return -ERANGE;
> @@ -774,6 +758,23 @@ int __pci_enable_msix_range(struct pci_d
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> +	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
> +		return -EINVAL;
> +
> +	hwsize = pci_msix_vec_count(dev);
> +	if (hwsize < 0)
> +		return hwsize;
> +
> +	if (!pci_msix_validate_entries(entries, nvec, hwsize))
> +		return -EINVAL;
> +
> +	/* PCI_IRQ_VIRTUAL is a horrible hack! */
> +	if (nvec > hwsize && !(flags & PCI_IRQ_VIRTUAL))
> +		nvec = hwsize;
> +
> +	if (nvec < minvec)
> +		return -ENOSPC;
> +
>  	rc = pci_setup_msi_context(dev);
>  	if (rc)
>  		return rc;
> @@ -785,7 +786,7 @@ int __pci_enable_msix_range(struct pci_d
>  				return -ENOSPC;
>  		}
>  
> -		rc = __pci_enable_msix(dev, entries, nvec, affd, flags);
> +		rc = msix_capability_init(dev, entries, nvec, affd);
>  		if (rc == 0)
>  			return nvec;
>  
> 
