Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7062CA60
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiKPUNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPUNd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:13:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA7227156;
        Wed, 16 Nov 2022 12:13:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBF4CB81EAA;
        Wed, 16 Nov 2022 20:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC94C433D6;
        Wed, 16 Nov 2022 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629609;
        bh=lM4FyB0BKBw2VxE7mkOwnEHXctCOrTcE0BLfNPcwQFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Gn9AMwI/HCd3z3N18CNIMIXLUaX+iRxHZkxbCnU6X3wXGB9R2OF7ILDQvu6TT2Hac
         obzoCW3tCPyWMt1OSgYUGi9u/PbbyNLXtEZ8fgIUnvKuAs0SgAkJFwO1nWX81RTu7w
         SCWfNxWoPzeSTktmHgYShI1VWU4fHeeK/1yh5jzX0ArYJNPVOeQR2jQUqPQFgoiu9C
         +QjHK9Tegoj+OcrjM9mSv1uvM4BJ7UiGe3eEz4u4v7AtqJ4teRXemS466AlHas6s/J
         e47fTwxQqjZSsvRYfSMUq7xNwvk090gLEVoerQnbyrU3IrbrxJ3YV6QGArKUL/zjhj
         RVoMHSL5fN8UA==
Date:   Wed, 16 Nov 2022 14:13:27 -0600
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
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 14/33] PCI/MSI: Remove unused
 pci_dev_has_special_msi_domain()
Message-ID: <20221116201327.GA1133644@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.064632154@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:33PM +0100, Thomas Gleixner wrote:
> The check for special MSI domains like VMD which prevents the interrupt
> remapping code to overwrite device::msi::domain is not longer required and
> has been replaced by an x86 specific version which is aware of MSI parent
> domains.
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   21 ---------------------
>  include/linux/msi.h         |    2 --
>  2 files changed, 23 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -414,24 +414,3 @@ struct irq_domain *pci_msi_get_device_do
>  					     DOMAIN_BUS_PCI_MSI);
>  	return dom;
>  }
> -
> -/**
> - * pci_dev_has_special_msi_domain - Check whether the device is handled by
> - *				    a non-standard PCI-MSI domain
> - * @pdev:	The PCI device to check.
> - *
> - * Returns: True if the device irqdomain or the bus irqdomain is
> - * non-standard PCI/MSI.
> - */
> -bool pci_dev_has_special_msi_domain(struct pci_dev *pdev)
> -{
> -	struct irq_domain *dom = dev_get_msi_domain(&pdev->dev);
> -
> -	if (!dom)
> -		dom = dev_get_msi_domain(&pdev->bus->dev);
> -
> -	if (!dom)
> -		return true;
> -
> -	return dom->bus_token != DOMAIN_BUS_PCI_MSI;
> -}
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -599,8 +599,6 @@ struct irq_domain *pci_msi_create_irq_do
>  					     struct irq_domain *parent);
>  u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
>  struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
> -bool pci_dev_has_special_msi_domain(struct pci_dev *pdev);
> -
>  #endif /* CONFIG_GENERIC_MSI_IRQ */
>  
>  #endif /* LINUX_MSI_H */
> 
