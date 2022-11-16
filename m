Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCFC62C3B8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiKPQPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiKPQPR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:15:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2FA56EDE;
        Wed, 16 Nov 2022 08:15:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74520B81DD9;
        Wed, 16 Nov 2022 16:15:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FF5C433C1;
        Wed, 16 Nov 2022 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615314;
        bh=jVuqpvEFC7W6prrFUac475QeeZYTTYxuYTZUcm0S4nk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fvHJksodCE+BmfIH4iURixL0h+Qx5bHlH1u2A1T39qpe+ZRm0gW3u9NiL/PoneJHF
         gBs6qQXnXxNhzk3JCdlSqhJzAeyZXOqDlCIk5tfGzK5J6NfxYqqGsIzhddwZKPhrl5
         57OynNzSRecGFG2yBpWFUSfl5gJ+5eHVpQzQxC4w0mTIsuwDxjeAvrYGBypV6CylQs
         lPnDcFmAtgaAtuZ+n4h264NFBubzIca30hLaOzvYoIZxKbiMpOCHnPv/AcUdqIdEnI
         +i4S8ooMu4HgWl9ykepn/RqU1Nv5fwTeen8jc7KMRbnLel08Q1WvND13agJcsVDK5r
         sJTVHFkI3A8KQ==
Date:   Wed, 16 Nov 2022 10:15:12 -0600
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
Subject: Re: [patch 14/39] PCI/MSI: Let the MSI core free descriptors
Message-ID: <20221116161512.GA1114737@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.409654736@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:37PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> Let the core do the freeing of descriptors and just keep it around for the
> legacy case.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -24,11 +24,12 @@ void pci_msi_teardown_msi_irqs(struct pc
>  	struct irq_domain *domain;
>  
>  	domain = dev_get_msi_domain(&dev->dev);
> -	if (domain && irq_domain_is_hierarchy(domain))
> +	if (domain && irq_domain_is_hierarchy(domain)) {
>  		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
> -	else
> +	} else {
>  		pci_msi_legacy_teardown_msi_irqs(dev);
> -	msi_free_msi_descs(&dev->dev);
> +		msi_free_msi_descs(&dev->dev);
> +	}
>  }
>  
>  /**
> @@ -170,6 +171,9 @@ struct irq_domain *pci_msi_create_irq_do
>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>  		pci_msi_domain_update_chip_ops(info);
>  
> +	/* Let the core code free MSI descriptors when freeing interrupts */
> +	info->flags |= MSI_FLAG_FREE_MSI_DESCS;
> +
>  	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
>  	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
>  		info->flags |= MSI_FLAG_MUST_REACTIVATE;
> 
