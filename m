Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588062C474
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiKPQbN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbiKPQae (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:30:34 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898261745;
        Wed, 16 Nov 2022 08:24:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 75FDECE1BE5;
        Wed, 16 Nov 2022 16:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2D3C43151;
        Wed, 16 Nov 2022 16:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615864;
        bh=KtY9Vs/brf6w8qE0/o2ebQAHWrfi6LuL4OCBYWS1b/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OsAR5tUMX+89dO25+e1oBaNX+VGOE54GjAZOeyQYzbZTqgTpNZPlC7Zf0Qy0SimWL
         OR8t+btKVpMvqEQ2V7aoAZN1zMjTQCRrK8WO5AVFz/X8LqfPWIRfiLYx7B9ez2Li1x
         NP++bYoQ8hvu729w4z5dH2whv3CJCLy6w/xF27iMn12m008IlvYWFnrvIvDGMtohSP
         Qd6I11EqTQKaL3+Y4S0xJbyXIyRL3xDNLy1DOi1v45qWxTG45M3xoCgIlj3dBMQk7k
         Zy92tOMVgmRKIk+cihrJp3nIEtIdrW9BrFRb27cgnQ5SzXTHkivURkBvDJ8YCfNGMu
         AqP9aJE9VxrtA==
Date:   Wed, 16 Nov 2022 10:24:23 -0600
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
Subject: Re: [patch 25/39] PCI/MSI: Move pci_free_irq_vectors() to api.c
Message-ID: <20221116162423.GA1115645@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.042870570@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:54PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_free_irq_vectors() and make its kernel-doc comprehensive.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/api.c | 15 +++++++++++++++
>  drivers/pci/msi/msi.c | 13 -------------
>  2 files changed, 15 insertions(+), 13 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 0f1ec87e3f9f..2ff2a9ccfc47 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -205,3 +205,18 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  	return irq ? irq : -EINVAL;
>  }
>  EXPORT_SYMBOL(pci_irq_vector);
> +
> +/**
> + * pci_free_irq_vectors() - Free previously allocated IRQs for a device
> + * @dev: the PCI device to operate on
> + *
> + * Undo the interrupt vector allocations and possible device MSI/MSI-X
> + * enablement earlier done through pci_alloc_irq_vectors_affinity() or
> + * pci_alloc_irq_vectors().
> + */
> +void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +	pci_disable_msix(dev);
> +	pci_disable_msi(dev);
> +}
> +EXPORT_SYMBOL(pci_free_irq_vectors);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 38ad2fe4b85c..ed8caf5ac99f 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -887,19 +887,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
>  }
>  
>  /**
> - * pci_free_irq_vectors - free previously allocated IRQs for a device
> - * @dev:		PCI device to operate on
> - *
> - * Undoes the allocations and enabling in pci_alloc_irq_vectors().
> - */
> -void pci_free_irq_vectors(struct pci_dev *dev)
> -{
> -	pci_disable_msix(dev);
> -	pci_disable_msi(dev);
> -}
> -EXPORT_SYMBOL(pci_free_irq_vectors);
> -
> -/**
>   * pci_irq_get_affinity - return the affinity of a particular MSI vector
>   * @dev:	PCI device to operate on
>   * @nr:		device-relative interrupt vector index (0-based).
> 
