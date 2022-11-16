Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B1F62C4D1
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiKPQjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiKPQjZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:39:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A556577;
        Wed, 16 Nov 2022 08:34:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E3261ED9;
        Wed, 16 Nov 2022 16:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE45C433C1;
        Wed, 16 Nov 2022 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616459;
        bh=uKdi6p36V3LxvyJcPehYkuLKJyY4N3pQgjmLWMWFgaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=stK5Sq+XYQnGDmF0ajQ0dsc8W0wzIBD35x1fFSV0rFbwn3x6rOntrYG8t7nCRryTB
         oSmX9yd3we8Imo2kf09h7MUSTamtcY+snYZRFnzJ9pMkmTIhShomfvA4C1+o5R5a18
         Ant1oFcyahAFgVtaRECkY8b98GkZBG9Z7sVCPbvPcWaCr7Sw2bqk7BRb+jmb/lcYwW
         YuHmF8va9UIWfhEuWlYUJkaNsInbBuvpXfptMMan4tfRgz3URO2U3cy/KQotTcm6fp
         GkIg2q9DWmlDdAhWOALLHl3v9gbl/fIhngvLE4nWGxS/4DiqtV8/PjAFOyu0XJ+mnl
         QGQMuVkTDlXZA==
Date:   Wed, 16 Nov 2022 10:34:17 -0600
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
Subject: Re: [patch 37/39] PCI/MSI: Remove redundant msi_check() callback
Message-ID: <20221116163417.GA1116723@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.749446904@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:14PM +0100, Thomas Gleixner wrote:
> All these sanity checks are now done _before_ any allocation work
> happens. No point in doing it twice.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   48 --------------------------------------------
>  1 file changed, 48 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -64,51 +64,6 @@ static irq_hw_number_t pci_msi_domain_ca
>  		(pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
>  }
>  
> -static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
> -{
> -	return !desc->pci.msi_attrib.is_msix && desc->nvec_used > 1;
> -}
> -
> -/**
> - * pci_msi_domain_check_cap - Verify that @domain supports the capabilities
> - *			      for @dev
> - * @domain:	The interrupt domain to check
> - * @info:	The domain info for verification
> - * @dev:	The device to check
> - *
> - * Returns:
> - *  0 if the functionality is supported
> - *  1 if Multi MSI is requested, but the domain does not support it
> - *  -ENOTSUPP otherwise
> - */
> -static int pci_msi_domain_check_cap(struct irq_domain *domain,
> -				    struct msi_domain_info *info,
> -				    struct device *dev)
> -{
> -	struct msi_desc *desc = msi_first_desc(dev, MSI_DESC_ALL);
> -
> -	/* Special handling to support __pci_enable_msi_range() */
> -	if (pci_msi_desc_is_multi_msi(desc) &&
> -	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
> -		return 1;
> -
> -	if (desc->pci.msi_attrib.is_msix) {
> -		if (!(info->flags & MSI_FLAG_PCI_MSIX))
> -			return -ENOTSUPP;
> -
> -		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
> -			unsigned int idx = 0;
> -
> -			/* Check for gaps in the entry indices */
> -			msi_for_each_desc(desc, dev, MSI_DESC_ALL) {
> -				if (desc->msi_index != idx++)
> -					return -ENOTSUPP;
> -			}
> -		}
> -	}
> -	return 0;
> -}
> -
>  static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,
>  				    struct msi_desc *desc)
>  {
> @@ -118,7 +73,6 @@ static void pci_msi_domain_set_desc(msi_
>  
>  static struct msi_domain_ops pci_msi_domain_ops_default = {
>  	.set_desc	= pci_msi_domain_set_desc,
> -	.msi_check	= pci_msi_domain_check_cap,
>  };
>  
>  static void pci_msi_domain_update_dom_ops(struct msi_domain_info *info)
> @@ -130,8 +84,6 @@ static void pci_msi_domain_update_dom_op
>  	} else {
>  		if (ops->set_desc == NULL)
>  			ops->set_desc = pci_msi_domain_set_desc;
> -		if (ops->msi_check == NULL)
> -			ops->msi_check = pci_msi_domain_check_cap;
>  	}
>  }
>  
> 
