Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272362CAC6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbiKPU0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiKPU0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:26:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B44EE38;
        Wed, 16 Nov 2022 12:26:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CD17B81EB6;
        Wed, 16 Nov 2022 20:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CC4C433C1;
        Wed, 16 Nov 2022 20:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668630381;
        bh=LnfKvQyu5LUOGKBK1uCUDy/9AsCzw3hD7g+IrE0Tgmg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bvaa5iUZC7VoB6vvIAyaIIijV0LU2QhGNQjd/a5yZx2FbzvEq9fBxJb73XBf+TyCB
         xtCF8EyKknZRUtJkty7yRD/omIzDPJBBAAb7fK7f6Ejz9mY6McYWV5TPrEOJsqwm7P
         91Qf8daYlx1GHsg3HqvZMW38X+tE2ee/qEIKcA/HDWnmh8eQV/MmKsJoasKg5pBr7B
         ZlesdDq3VQ7eCt3MWEx1QakITt+CZ5EC/nmDEBLrVrts9aoQTzhXVbVrDVzRk6ZntK
         PlBOTWU7HLqH2x/Q+ynORdwLZmJU7et6yAyHmKRKgD+M5WPbc0BYrUq58DfBfSVuJj
         3l/AjS2K9zzCA==
Date:   Wed, 16 Nov 2022 14:26:19 -0600
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
Subject: Re: [patch 24/33] PCI/MSI: Provide prepare_desc() MSI domain op
Message-ID: <20221116202619.GA1134246@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.632756918@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:49PM +0100, Thomas Gleixner wrote:
> Dynamic MSI-X vector allocation post MSI-X allows to allocate vectors at a
> given index or at any free index in the available table range.

Is "post MSI-X" missing something?  "post MSI-X enablement" or
something?

> The latter
> requires that the core code selects the index at descriptor allocation time.
> 
> This requires that the PCI/MSI-X specific setup of the MSI-X descriptor,
> which is partially depending on the chosen index happens after allocation.

Is there a comma missing after "index"?  I.e., setup of the descriptor
partially depends on the chosen index?  And the above requires that
setup happens after allocation?

> Implement the prepare_desc() op in the PCI/MSI-X specific msi_domain_ops
> which is invoked before the core interrupt descriptor and the associated
> Linux interrupt number is allocated. That callback is also provided for the
> upcoming PCI/IMS implementations so the implementation specific interrupt
> domain can do their domain specific initialization of the MSI descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -202,6 +202,14 @@ static void pci_unmask_msix(struct irq_d
>  	pci_msix_unmask(irq_data_get_msi_desc(data));
>  }
>  
> +static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
> +				  struct msi_desc *desc)
> +{
> +	/* Don't fiddle with preallocated MSI descriptors */
> +	if (!desc->pci.mask_base)
> +		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
> +}
> +
>  static struct msi_domain_template pci_msix_template = {
>  	.chip = {
>  		.name			= "PCI-MSIX",
> @@ -212,6 +220,7 @@ static struct msi_domain_template pci_ms
>  	},
>  
>  	.ops = {
> +		.prepare_desc		= pci_msix_prepare_desc,
>  		.set_desc		= pci_device_domain_set_desc,
>  	},
>  
> 
