Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8FA62C3B5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKPQO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiKPQO5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:14:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B96B56572;
        Wed, 16 Nov 2022 08:14:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E490DB81DA9;
        Wed, 16 Nov 2022 16:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597FC433C1;
        Wed, 16 Nov 2022 16:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615293;
        bh=3jHYcM7FuEy5OUC4SwSTcV7zvFrD7SfjF+WS6WLSYEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KVVezaQSNPVYb6hCL4ff6+8gaVLjNQPJM+j7z7JCIaGpO+komsTUSuLi7AaGOzhwx
         2rzkGF4vJTL4L7hBaRSzNaVbPIYhYPStj02V14xUHiisGRvUlK97HBEKE7M7Bww+0X
         K2AiIEkcCTiXODDdyPz+Klh3LYdqOhQvDfsiQD12zd2yPyAmpfMrzUeYXtGZaIDhoy
         vzKRttMPALCM9fC3pVepzYVkmusgvF4WHsoHiaKoujfx367H6rM2jc5t0gd8uaauiJ
         krqJoKnB7FA/Id3APLTOCSgHib6+yUeAXjphnnV/0nn1YS28xUBriVTZGV1HdkLYZf
         pGD5rJUG1OPSQ==
Date:   Wed, 16 Nov 2022 10:14:52 -0600
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
Subject: Re: [patch 13/39] PCI/MSI: Use msi_domain_info::bus_token
Message-ID: <20221116161452.GA1114659@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.352437595@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:35PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> Set the bus token in the msi_domain_info structure and let the core code
> handle the update.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -162,8 +162,6 @@ struct irq_domain *pci_msi_create_irq_do
>  					     struct msi_domain_info *info,
>  					     struct irq_domain *parent)
>  {
> -	struct irq_domain *domain;
> -
>  	if (WARN_ON(info->flags & MSI_FLAG_LEVEL_CAPABLE))
>  		info->flags &= ~MSI_FLAG_LEVEL_CAPABLE;
>  
> @@ -178,13 +176,10 @@ struct irq_domain *pci_msi_create_irq_do
>  
>  	/* PCI-MSI is oneshot-safe */
>  	info->chip->flags |= IRQCHIP_ONESHOT_SAFE;
> +	/* Let the core update the bus token */
> +	info->bus_token = DOMAIN_BUS_PCI_MSI;
>  
> -	domain = msi_create_irq_domain(fwnode, info, parent);
> -	if (!domain)
> -		return NULL;
> -
> -	irq_domain_update_bus_token(domain, DOMAIN_BUS_PCI_MSI);
> -	return domain;
> +	return msi_create_irq_domain(fwnode, info, parent);
>  }
>  EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
>  
> 
