Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466F062C48D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiKPQfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiKPQfH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:35:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F868C46;
        Wed, 16 Nov 2022 08:26:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 29B52CE1BE7;
        Wed, 16 Nov 2022 16:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265B5C433C1;
        Wed, 16 Nov 2022 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616003;
        bh=7dRd1C8mTpkHuyLg0ecBxDafE9jSuXIZwtzca2R9S/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P/gXMOOLklt9M+/GHi301BiUiczOapf+dKNFSW0BH0y6HzMrvFRsEYXJ3m7hzsZ02
         p0V5RHlJXYKcmkbTH3tOXnD2TLz0nWE0aNDSFSs/Vaoz/QlJe0ECihGDxI5KJA/qto
         3p3kqcvmrg+kARLZ0ruMZDLaBcw6HBEF+j97tmJFM1Tcyr+ftJwAW/7KKGmprqh5ZQ
         Q0YoUj1JLkwL1qISJE6Dqc3wUiMgrEKZhOCNtikFK9e/BwPTo+tIVIwjXN7fYRTEl1
         Z14lyP1muI4If7OVQsFCb7svIs9e8QTRj/MIUObE/rRuPFPEhsAww39nvt6/pBXUhz
         QeQXvU08px9kA==
Date:   Wed, 16 Nov 2022 10:26:41 -0600
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 29/39] PCI/MSI: Move pci_msi_enabled() to api.c
Message-ID: <20221116162641.GA1115904@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.271447896@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:01PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_msi_enabled() and make its kernel-doc comprehensive.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/api.c | 12 ++++++++++++
>  drivers/pci/msi/msi.c | 14 +-------------
>  drivers/pci/msi/msi.h |  3 +++
>  3 files changed, 16 insertions(+), 13 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 473df7ba0584..ee9ed5ccd94d 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -307,3 +307,15 @@ void pci_free_irq_vectors(struct pci_dev *dev)
>  	pci_disable_msi(dev);
>  }
>  EXPORT_SYMBOL(pci_free_irq_vectors);
> +
> +/**
> + * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
> + *
> + * Return: true if MSI has not been globally disabled through ACPI FADT,
> + * PCI bridge quirks, or the "pci=nomsi" kernel command-line option.
> + */
> +int pci_msi_enabled(void)
> +{
> +	return pci_msi_enable;
> +}
> +EXPORT_SYMBOL(pci_msi_enabled);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index d78646d1c116..59c33bc7fe81 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -13,7 +13,7 @@
>  #include "../pci.h"
>  #include "msi.h"
>  
> -static int pci_msi_enable = 1;
> +int pci_msi_enable = 1;
>  int pci_msi_ignore_mask;
>  
>  void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
> @@ -864,15 +864,3 @@ void pci_no_msi(void)
>  {
>  	pci_msi_enable = 0;
>  }
> -
> -/**
> - * pci_msi_enabled - is MSI enabled?
> - *
> - * Returns true if MSI has not been disabled by the command-line option
> - * pci=nomsi.
> - **/
> -int pci_msi_enabled(void)
> -{
> -	return pci_msi_enable;
> -}
> -EXPORT_SYMBOL(pci_msi_enabled);
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 77e2587f7e4f..f3f4ede53171 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -84,6 +84,9 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
>  	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
>  }
>  
> +/* Subsystem variables */
> +extern int pci_msi_enable;
> +
>  /* MSI internal functions invoked from the public APIs */
>  void pci_msi_shutdown(struct pci_dev *dev);
>  void pci_msix_shutdown(struct pci_dev *dev);
> 
