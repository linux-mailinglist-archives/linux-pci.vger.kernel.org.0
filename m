Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E424662C4C4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiKPQi2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiKPQhu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:37:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D45E9D5;
        Wed, 16 Nov 2022 08:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96BB761ED9;
        Wed, 16 Nov 2022 16:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F9BC433D7;
        Wed, 16 Nov 2022 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616308;
        bh=c2dGFGQmMW2gB2BJno36TKOH8N1LNl8BA42e1b1583s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Urqx4Sx2y6ausq1Rn2h6VkOvD255FnIz/7hpaGtRnK/GkCaZc7J2KQE1uahowu90y
         x6zgeaqkjifqlzgOa+s/9Ro/XMCj+c60OuROzOkw0ipMQ5Jm6cQtmavrMNfgamkClT
         CdHQGa5nNMHH5GQMPpJpLVaYLjPsNGEUXbEjqJM3Yq++ug4pim6YNt5RctzENyPC6n
         QUK682mQ3rSJqmEdy3B8WIl9nT5h9LYJTnM9/xfw/Rh2psUf3pJbWiyj72M4puxlrz
         0IJGc+asGHOcW40Rkn4RvFxYc+KFboPzNMeJtTjyDo4num4U31ij0Jr+HG8WOeNSDa
         TKUQ8fu3mYxbA==
Date:   Wed, 16 Nov 2022 10:31:46 -0600
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
Subject: Re: [patch 35/39] PCI/MSI: Reject MSI-X early
Message-ID: <20221116163146.GA1116406@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.631728309@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:11PM +0100, Thomas Gleixner wrote:
> Similar to PCI multi-MSI reject MSI-X enablement when a irq domain is
> attached to the device which does not support MSI-X.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -760,6 +760,10 @@ int __pci_enable_msix_range(struct pci_d
>  	if (WARN_ON_ONCE(dev->msix_enabled))
>  		return -EINVAL;
>  
> +	/* Check MSI-X early on irq domain enabled architectures */
> +	if (!pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX, ALLOW_LEGACY))
> +		return -ENOTSUPP;
> +
>  	if (!pci_msi_supported(dev, nvec) || dev->current_state != PCI_D0)
>  		return -EINVAL;
>  
> 
