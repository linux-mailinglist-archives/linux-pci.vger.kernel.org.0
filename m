Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D66286C0
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbiKNRNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 12:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiKNRNG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 12:13:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189143E099;
        Mon, 14 Nov 2022 09:13:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C2E61316;
        Mon, 14 Nov 2022 17:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DC6C433D7;
        Mon, 14 Nov 2022 17:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668445985;
        bh=XwxXvuiW9/9Vy0E1jY3sIXPuGdDEeo1Bri/WwkrhOIw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=geA4J/DOQTTRPNnYOOhL/CSFNsLNFxqGcp44MY1Q2RgHaCtpGaYF0IRYwfTz3ip9p
         G18YYLUJ8CYVqaLWMJQUFBzIJUjStInyQ4x+VYpGtyLGTA7zBJUYwkdVl56V27fAGb
         CfA33516arvHEJ8oZwbhBX85trGpK8IuR25KCLs1Gg8Fu2DlD0X7FGIsqT+eODV6Sx
         h8LR+M6dC1vwa4ippvoxMLvTI/KdnQWvC+UUz92vd5QRu2001I0k2xklUzTXHyW82H
         z3IKnWSql4szK0ia9xHwmiIvKZ9hIbqiwxLCWdzWGsLI1EKVXNdGX9NOKYXYUgwbNC
         XQXuTjUlW5DUA==
Date:   Mon, 14 Nov 2022 11:13:03 -0600
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
Subject: Re: [patch 16/20] PCI/MSI: Use
 msi_domain_alloc/free_irqs_all_locked()
Message-ID: <20221114171303.GA919141@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111132706.948397248@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:57:03PM +0100, Thomas Gleixner wrote:
> Switch to the new domain id aware interfaces to phase out the previous
> ones. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -14,7 +14,7 @@ int pci_msi_setup_msi_irqs(struct pci_de
>  
>  	domain = dev_get_msi_domain(&dev->dev);
>  	if (domain && irq_domain_is_hierarchy(domain))
> -		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
> +		return msi_domain_alloc_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN, nvec);
>  
>  	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
>  }
> @@ -25,7 +25,7 @@ void pci_msi_teardown_msi_irqs(struct pc
>  
>  	domain = dev_get_msi_domain(&dev->dev);
>  	if (domain && irq_domain_is_hierarchy(domain)) {
> -		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
> +		msi_domain_free_irqs_all_locked(&dev->dev, MSI_DEFAULT_DOMAIN);
>  	} else {
>  		pci_msi_legacy_teardown_msi_irqs(dev);
>  		msi_free_msi_descs(&dev->dev);
> 
