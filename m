Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0495662C47A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbiKPQco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiKPQbf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:31:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDEA63158;
        Wed, 16 Nov 2022 08:24:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B770A61ED6;
        Wed, 16 Nov 2022 16:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3483C433C1;
        Wed, 16 Nov 2022 16:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615889;
        bh=5g+lcRTgojvcHO75iDpTjlaYEoDk4vaOgEIAFKquvjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CGfT9EujGvvtjcam7zJkxMdubgo56iBrswn0DlhLFS3nOTHL1qm3LwBUMO05J3w6H
         1GeFR/VxrTv0g2tCX5oiDoRupCot1sfREV2psK7cDcKLuGqEkLqI7oddjNKarF1+zM
         JEac4McFFKKpbTQbNkJUiP5aacLCSrn+xE0MZi9s7/g5oTufE8wmvvxlCz8DFrH8Gv
         jLRj5SGvcYknM0Blv/Fn5U5HcI3irfG45BEnTEwPgtwh0pAb7RTJcLtnrtT7FWU60E
         YReC72piHkL32yXPlfDvvvl78qjUseY6DiIACDvpzvJHN6uFGSeVeH95OB/3xcv3i3
         fkQvwqB8am0JQ==
Date:   Wed, 16 Nov 2022 10:24:47 -0600
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
Subject: Re: [patch 26/39] PCI/MSI: Move pci_msix_vec_count() to api.c
Message-ID: <20221116162447.GA1115701@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.099461602@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:56PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_msix_vec_count() and make its kernel-doc comprehensive.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/api.c | 20 ++++++++++++++++++++
>  drivers/pci/msi/msi.c | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 2ff2a9ccfc47..83ea38ffa116 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -60,6 +60,26 @@ void pci_disable_msi(struct pci_dev *dev)
>  EXPORT_SYMBOL(pci_disable_msi);
>  
>  /**
> + * pci_msix_vec_count() - Get number of MSI-X interrupt vectors on device
> + * @dev: the PCI device to operate on
> + *
> + * Return: number of MSI-X interrupt vectors available on this device
> + * (i.e., the device's MSI-X capability structure "table size"), -EINVAL
> + * if the device is not MSI-X capable, other errnos otherwise.
> + */
> +int pci_msix_vec_count(struct pci_dev *dev)
> +{
> +	u16 control;
> +
> +	if (!dev->msix_cap)
> +		return -EINVAL;
> +
> +	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
> +	return msix_table_size(control);
> +}
> +EXPORT_SYMBOL(pci_msix_vec_count);
> +
> +/**
>   * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
>   * @dev:     the PCI device to operate on
>   * @entries: input/output parameter, array of MSI-X configuration entries
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index ed8caf5ac99f..1226d66da992 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -701,26 +701,6 @@ void pci_msi_shutdown(struct pci_dev *dev)
>  	pcibios_alloc_irq(dev);
>  }
>  
> -/**
> - * pci_msix_vec_count - return the number of device's MSI-X table entries
> - * @dev: pointer to the pci_dev data structure of MSI-X device function
> - * This function returns the number of device's MSI-X table entries and
> - * therefore the number of MSI-X vectors device is capable of sending.
> - * It returns a negative errno if the device is not capable of sending MSI-X
> - * interrupts.
> - **/
> -int pci_msix_vec_count(struct pci_dev *dev)
> -{
> -	u16 control;
> -
> -	if (!dev->msix_cap)
> -		return -EINVAL;
> -
> -	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
> -	return msix_table_size(control);
> -}
> -EXPORT_SYMBOL(pci_msix_vec_count);
> -
>  static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>  			     int nvec, struct irq_affinity *affd, int flags)
>  {
> 
