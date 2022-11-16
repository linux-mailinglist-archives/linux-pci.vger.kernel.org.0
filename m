Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CFB62C3BB
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbiKPQPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiKPQPv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:15:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8C74D5E1;
        Wed, 16 Nov 2022 08:15:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BB71CE1BBB;
        Wed, 16 Nov 2022 16:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A606C433D6;
        Wed, 16 Nov 2022 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615346;
        bh=sDJKa1fbG0u3Us3nL6jtxWazW2/yIEjiBXrsp/ZezNI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OKLQAXunR0A8tOp3VcPtuOkm+Fb0sHJnqyryDeFuwlCNZXpvXInros6PSED8376eZ
         IBexbk15bbBAN/CfADlMufcqkmkWw6VXAz9VYupLJ4TgYr2A5AD1mX2byD7cPqT1Vj
         LGeKraHBrWKWwFbCgk94zdAjCm1WoA+1WwuEOlx7B1udWeFdG4VadEko0xYYydS2Eu
         BNSE0qfMHIvhe7yuA1sQiBzZUjdvk3v3+q7EMfl1FWZBI1D1KDW16Gpg9AZNoePjCd
         IUbfeGRLsFunbPknRv0RhY9W8ziRmH2o+xa7hahtABjosB43Dxe9cl9/XwAzh/xkT0
         uGk0NsCdAk7WQ==
Date:   Wed, 16 Nov 2022 10:15:45 -0600
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
Subject: Re: [patch 17/39] PCI/MSI: Get rid of externs in msi.h
Message-ID: <20221116161545.GA1114836@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.582175082@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:42PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> Follow the style of <linux/pci.h>
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -5,12 +5,12 @@
>  
>  #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
>  
> -extern int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> -extern void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
> +int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> +void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
>  
>  #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> -extern int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> -extern void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
> +int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> +void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
>  #else
>  static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
>  {
> 
