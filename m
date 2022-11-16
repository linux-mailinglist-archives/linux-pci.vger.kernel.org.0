Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3260462C467
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239114AbiKPQaF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239159AbiKPQ3r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:29:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC506035F;
        Wed, 16 Nov 2022 08:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B3C6B81DE2;
        Wed, 16 Nov 2022 16:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7905C433C1;
        Wed, 16 Nov 2022 16:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615838;
        bh=DiTEt8XP0MxtxKbF5ev7VXOTUwbITQ2VyXFIkyGrEn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PJ6wYAJRMkj/NnbJKwutaEqZGsul0Y5oZ+yT84rWOuJiP+x2WAy2XC1Hdsnf2CweP
         Y0+tPWImMSwYmXIsB64fs2r3+RwLwvptw8bZNL/hnIdDAGQoshhpq2d+G4awA8LAEi
         cbUeZHPd0sTqISD9d50J//8Xvlv1QxAiamBAD7GWuiHsBIQQQZ/Kdle1bKcYK2sTIe
         NQgxmVstgW3cEmnfco4AZJUTpnhbNfpEElLkIPJXmpTyq30zRs0Dn2VzVeYjl0Z/We
         TaVLWE0vlpVmCGS9+QNfYXtDa7eocyk+ce9knsywPyNpt11zw1FZyBCTGgYY2Yi4Q9
         /uoSU11QFLcxw==
Date:   Wed, 16 Nov 2022 10:23:56 -0600
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
Subject: Re: [patch 24/39] PCI/MSI: Move pci_irq_vector() to api.c
Message-ID: <20221116162356.GA1115513@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.984490384@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:53PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_irq_vector() and let its kernel-doc match the rest of the file.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/api.c | 23 +++++++++++++++++++++++
>  drivers/pci/msi/msi.c | 24 ------------------------
>  2 files changed, 23 insertions(+), 24 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 8546749afa6e..0f1ec87e3f9f 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -182,3 +182,26 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  	return nvecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> +
> +/**
> + * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
> + * @dev: the PCI device to operate on
> + * @nr:  device-relative interrupt vector index (0-based); has different
> + *       meanings, depending on interrupt mode
> + *         MSI-X        the index in the MSI-X vector table
> + *         MSI          the index of the enabled MSI vectors
> + *         INTx         must be 0
> + *
> + * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
> + */
> +int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> +{
> +	unsigned int irq;
> +
> +	if (!dev->msi_enabled && !dev->msix_enabled)
> +		return !nr ? dev->irq : -EINVAL;
> +
> +	irq = msi_get_virq(&dev->dev, nr);
> +	return irq ? irq : -EINVAL;
> +}
> +EXPORT_SYMBOL(pci_irq_vector);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index a028774f438d..38ad2fe4b85c 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -900,30 +900,6 @@ void pci_free_irq_vectors(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_free_irq_vectors);
>  
>  /**
> - * pci_irq_vector - return Linux IRQ number of a device vector
> - * @dev:	PCI device to operate on
> - * @nr:		Interrupt vector index (0-based)
> - *
> - * @nr has the following meanings depending on the interrupt mode:
> - *   MSI-X:	The index in the MSI-X vector table
> - *   MSI:	The index of the enabled MSI vectors
> - *   INTx:	Must be 0
> - *
> - * Return: The Linux interrupt number or -EINVAl if @nr is out of range.
> - */
> -int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> -{
> -	unsigned int irq;
> -
> -	if (!dev->msi_enabled && !dev->msix_enabled)
> -		return !nr ? dev->irq : -EINVAL;
> -
> -	irq = msi_get_virq(&dev->dev, nr);
> -	return irq ? irq : -EINVAL;
> -}
> -EXPORT_SYMBOL(pci_irq_vector);
> -
> -/**
>   * pci_irq_get_affinity - return the affinity of a particular MSI vector
>   * @dev:	PCI device to operate on
>   * @nr:		device-relative interrupt vector index (0-based).
> 
