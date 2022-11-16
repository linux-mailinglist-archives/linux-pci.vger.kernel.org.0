Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5981E62C492
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbiKPQfh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiKPQfN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:35:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E47168C67;
        Wed, 16 Nov 2022 08:27:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEC8761EC4;
        Wed, 16 Nov 2022 16:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05698C43144;
        Wed, 16 Nov 2022 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616027;
        bh=HjlrE3qPS6/S+YHpKCAMnsJE4Mb7DH9bPKzcgSrHjf8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a+yzJd2CNITMQpCmphnjYBlYPf3TcNFtxM3gMRzXahRo3NLEq/N2MFr9RLxFunkwM
         donzPkOGwl1yBERAJPNIP1cG1zIuD92CtPfauE+mRRWZxm6hm2oxJnBbcuZaGQ0zP5
         1OYwJxr4AnIMoy3YQgFfEoYQuP0hK9CPaPCelDFPvzHUs7HnKO/s7Y1Rb0NzDmCnBc
         91w6kIBi1FQPE4WnYjxobgHPjJpLEQCi/COd3H/vZw1Cd3r/dP92IuL/eh6QBbzcpc
         kk/M2/Kz8j5k83VUsThOguMMDS4KukqRClsb6boI6wwW0vMDP71jRNjc4BkzrT7Ads
         JId6fNTbXeILQ==
Date:   Wed, 16 Nov 2022 10:27:05 -0600
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
Subject: Re: [patch 30/39] PCI/MSI: Move pci_msi_restore_state() to api.c
Message-ID: <20221116162705.GA1115960@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.331584998@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:03PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
>     
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
>     
> Move pci_msi_enabled() and add kernel-doc for the function.
>     
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index ee9ed5ccd94d..8d1cf6db9bd7 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -308,6 +308,21 @@ void pci_free_irq_vectors(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_free_irq_vectors);
>  
> +/**
> + * pci_restore_msi_state() - Restore cached MSI(-X) state on device
> + * @dev: the PCI device to operate on
> + *
> + * Write the Linux-cached MSI(-X) state back on device. This is
> + * typically useful upon system resume, or after an error-recovery PCI
> + * adapter reset.
> + */
> +void pci_restore_msi_state(struct pci_dev *dev)
> +{
> +	__pci_restore_msi_state(dev);
> +	__pci_restore_msix_state(dev);
> +}
> +EXPORT_SYMBOL_GPL(pci_restore_msi_state);
> +
>  /**
>   * pci_msi_enabled() - Are MSI(-X) interrupts enabled system-wide?
>   *
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 59c33bc7fe81..a5d168c823ff 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -199,7 +199,7 @@ bool __weak arch_restore_msi_irqs(struct pci_dev *dev)
>  	return true;
>  }
>  
> -static void __pci_restore_msi_state(struct pci_dev *dev)
> +void __pci_restore_msi_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	u16 control;
> @@ -231,7 +231,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
>  	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
>  }
>  
> -static void __pci_restore_msix_state(struct pci_dev *dev)
> +void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	bool write_msg;
> @@ -257,13 +257,6 @@ static void __pci_restore_msix_state(struct pci_dev *dev)
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }
>  
> -void pci_restore_msi_state(struct pci_dev *dev)
> -{
> -	__pci_restore_msi_state(dev);
> -	__pci_restore_msix_state(dev);
> -}
> -EXPORT_SYMBOL_GPL(pci_restore_msi_state);
> -
>  static void pcim_msi_release(void *pcidev)
>  {
>  	struct pci_dev *dev = pcidev;
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index f3f4ede53171..8170ef2c5ad0 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -94,6 +94,8 @@ void pci_free_msi_irqs(struct pci_dev *dev);
>  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
>  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
>  			    int maxvec,  struct irq_affinity *affd, int flags);
> +void __pci_restore_msi_state(struct pci_dev *dev);
> +void __pci_restore_msix_state(struct pci_dev *dev);
>  
>  /* Legacy (!IRQDOMAIN) fallbacks */
>  
> 
