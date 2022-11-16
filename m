Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5062C4CE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbiKPQjl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiKPQjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:39:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DDD554DB;
        Wed, 16 Nov 2022 08:34:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B527EB81DEC;
        Wed, 16 Nov 2022 16:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159DEC433D7;
        Wed, 16 Nov 2022 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616438;
        bh=x+FQ4/MpGL9yLk16x2UT0Pz93Rr0XvkLBBEeUOH3wwY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=na2MPsiTrPucVz6/AhoUlhZeTmGqycasH1P82SNGFQNhjaGt+xqwimYaedMuGWr07
         2vVMdMIUAkNkaA2KbtCN3DafY+lDDruZ1hK+YMRgFiteoc/v/9E8rxnFYhb+bThW5B
         OhkGPjZn6wsMl2BxiehR4o1/MCH743xNbmSkFgk0zr88fQ8eztT1AE5FeTTwy8RS/A
         h2KW9o3kcLhgwthLMqQx+TEdpMfwFxyxYAHGA0mhKCZPV6Arl4k14cQfLBm4vaTQeN
         vV55xEuBQq8fWilZFv5cmXL0uBwl1VVertyG4mjU/pWInxq7c10i1MJ+z6C27LefDK
         d67lCxWIC5Fbg==
Date:   Wed, 16 Nov 2022 10:33:56 -0600
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
Subject: Re: [patch 36/39] PCI/MSI: Validate MSIX contiguous restriction early
Message-ID: <20221116163356.GA1116458@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.691357406@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:55:12PM +0100, Thomas Gleixner wrote:
> With interrupt domains the sanity check for MSI-X vector validation can be
> done _before_ any allocation happens. The sanity check only applies to the
> allocation functions which have an 'entries' array argument. The entries
> array is filled by the caller with the requested MSI-X indicies. Some drivers
> have gaps in the index space which is not supported on all architectures.
> 
> The PCI/MSI irqdomain has a 'feature' bit to enforce this validation late
> during the allocation phase.
> 
> Just do it right away before doing any other work along with the other
> sanity checks on that array.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

s/indicies/indices/ (commit log)
s/irqdomain/irq domain/?  IIRC previous logs used "irq domain"
s/MSIX/MSI-X/ (subject line)

> ---
>  drivers/pci/msi/msi.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -725,13 +725,17 @@ static int msix_capability_init(struct p
>  	return ret;
>  }
>  
> -static bool pci_msix_validate_entries(struct msix_entry *entries, int nvec, int hwsize)
> +static bool pci_msix_validate_entries(struct pci_dev *dev, struct msix_entry *entries,
> +				      int nvec, int hwsize)
>  {
> +	bool nogap;
>  	int i, j;
>  
>  	if (!entries)
>  		return true;
>  
> +	nogap = pci_msi_domain_supports(dev, MSI_FLAG_MSIX_CONTIGUOUS, DENY_LEGACY);
> +
>  	for (i = 0; i < nvec; i++) {
>  		/* Entry within hardware limit? */
>  		if (entries[i].entry >= hwsize)
> @@ -742,6 +746,9 @@ static bool pci_msix_validate_entries(st
>  			if (entries[i].entry == entries[j].entry)
>  				return false;
>  		}
> +		/* Check for unsupported gaps */
> +		if (nogap && entries[i].entry != i)
> +			return false;
>  	}
>  	return true;
>  }
> @@ -773,7 +780,7 @@ int __pci_enable_msix_range(struct pci_d
>  	if (hwsize < 0)
>  		return hwsize;
>  
> -	if (!pci_msix_validate_entries(entries, nvec, hwsize))
> +	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
>  		return -EINVAL;
>  
>  	/* PCI_IRQ_VIRTUAL is a horrible hack! */
> 
