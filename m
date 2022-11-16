Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B196F62C4BD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbiKPQiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiKPQhj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:37:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A56F5E3E1;
        Wed, 16 Nov 2022 08:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D787B81DB9;
        Wed, 16 Nov 2022 16:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8F9C43150;
        Wed, 16 Nov 2022 16:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616279;
        bh=jmn/eepB0DIDFxOFu+/KtMmJJA+nW4C/Pt+OKJfWu1c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=F3if8fsPODhEgaNJWILnJb37FdgCXbeMFIjp54W0pwFKt5sT0Iw1UMp5TuHpYpit8
         tOdLuWl/Z69WnTg8DcAxKqSXOlFylW4Kf178W06YC6KzQhKoNkfHR8eId8dsntQnI7
         g51Cm5bcPIRA/z4LCRJnx/GvsBZoCZWIllysP2p2zlr1Qd0AQQW4WsYpxbs+9WnzkB
         LbO7VqK8NEPnzll7xPECReCcVhZC8jWL66SsLBN1Hv9553Of1+WJwbbsjofzyMVh6j
         fhMR7Lq9azFChp09TIyRnrFymHU9byRjcJNfw8LpBdrHr1WX15uv2beNKTFCDtZSaE
         skG08ejR82xOw==
Date:   Wed, 16 Nov 2022 10:31:18 -0600
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
Subject: Re: [patch 34/39] PCI/MSI: Reject multi-MSI early
Message-ID: <20221116163118.GA1116261@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.574339988@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:09PM +0100, Thomas Gleixner wrote:
> When hierarchical MSI interrupt domains are enabled then there is no point
> to do tons of work and detect the missing support for multi-MSI late in the
> allocation path.
> 
> Just query the domain feature flags right away. The query function is going
> to be used for other purposes later and has a mode argument which influences
> the result:
> 
>   ALLOW_LEGACY returns true when:
>      - there is no irq domain attached (legacy support)
>      - there is a irq domain attached which has the feature flag set
> 
>   DENY_LEGACY returns only true when:
>      - there is a irq domain attached which has the feature flag set
> 
> This allows to use the function universally without ifdeffery in the
> calling code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   22 ++++++++++++++++++++++
>  drivers/pci/msi/msi.c       |    4 ++++
>  drivers/pci/msi/msi.h       |    9 +++++++++
>  3 files changed, 35 insertions(+)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -187,6 +187,28 @@ struct irq_domain *pci_msi_create_irq_do
>  }
>  EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
>  
> +/**
> + * pci_msi_domain_supports - Check for support of a particular feature flag
> + * @pdev:		The PCI device to operate on
> + * @feature_mask:	The feature mask to check for (full match)
> + * @mode:		If ALLOW_LEGACY this grants the feature when there is no irq domain
> + *			associated to the device. If DENY_LEGACY the lack of an irq domain
> + *			makes the feature unsupported

Looks like some of these might be wider than 80 columns, which I think
was the typical width of this file.

> + */
> +bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
> +			     enum support_mode mode)
> +{
> +	struct msi_domain_info *info;
> +	struct irq_domain *domain;
> +
> +	domain = dev_get_msi_domain(&pdev->dev);
> +
> +	if (!domain || !irq_domain_is_hierarchy(domain))
> +		return mode == ALLOW_LEGACY;
> +	info = domain->host_data;
> +	return (info->flags & feature_mask) == feature_mask;
> +}
> +
>  /*
>   * Users of the generic MSI infrastructure expect a device to have a single ID,
>   * so with DMA aliases we have to pick the least-worst compromise. Devices with
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -347,6 +347,10 @@ static int msi_capability_init(struct pc
>  	struct msi_desc *entry;
>  	int ret;
>  
> +	/* Reject multi-MSI early on irq domain enabled architectures */
> +	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW_LEGACY))
> +		return 1;
> +
>  	/*
>  	 * Disable MSI during setup in the hardware, but mark it enabled
>  	 * so that setup code can evaluate it.
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -97,6 +97,15 @@ int __pci_enable_msix_range(struct pci_d
>  void __pci_restore_msi_state(struct pci_dev *dev);
>  void __pci_restore_msix_state(struct pci_dev *dev);
>  
> +/* irq_domain related functionality */
> +
> +enum support_mode {
> +	ALLOW_LEGACY,
> +	DENY_LEGACY,
> +};
> +
> +bool pci_msi_domain_supports(struct pci_dev *dev, unsigned int feature_mask, enum support_mode mode);
> +
>  /* Legacy (!IRQDOMAIN) fallbacks */
>  
>  #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> 
