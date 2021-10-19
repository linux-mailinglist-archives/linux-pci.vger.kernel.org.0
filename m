Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228094341AE
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhJSW4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 18:56:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhJSW4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 18:56:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8712B61074;
        Tue, 19 Oct 2021 22:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634684032;
        bh=a6eeZS/LZBl+OZKeBZ0Xvg/kT5IZrCEt3S2OPTd7s20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n9y7wy/hVq0fzn44+J2dKMaBrYIZp+5HEzTYhKxH+uV+GPsyrLHNxvfRzaSHNItEs
         hRYUZVLQ962h0t0kTtoBUkiZ3qPH/70/vebaBKcs0c4FxoUF912mYoYqDlbyW4BpWU
         EqMTK/4NJ3wZJ9bJukVHO1Vnu9WviQVsqRVuN5laK+EbSZfQfhLXQgMZomCNwaFems
         P1JxE+pDJ3W7ifngq/lKOuLLcKyU2kKc79OLnsgdlMc/5xR5AcTlqBbYWqIyhSnhIr
         +503+vqcBtUDCTlj6ts+F9i1ceme2o9tOlZzDb/EwVxRkKkjC1MYvm8VJ82WhwCXB9
         Zc1OU4gON+Jmw==
Date:   Tue, 19 Oct 2021 17:53:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com, tsbogend@alpha.franken.de,
        linux-pci@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/6] MIPS: OCTEON: Remove redundant clearing of AER
 status registers
Message-ID: <20211019225351.GA2416612@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81597ce8ee30ad01da86fe1edf0fab76aa9b9710.1633369560.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 11:29:28PM +0530, Naveen Naidu wrote:
> e8635b484f64 ("MIPS: Add Cavium OCTEON PCI support.") added MIPS
> specific code to enable PCIe and AER error reporting (*irrespective
> of CONFIG_PCIEAER value*) because PCI core didn't do that at the time.
> 
> Currently when CONFIG_PCIEAER=y, the Uncorrectable Error status,
> Correctable Error status and Root status registers are cleared
> during the PCI Bus enumeration path by pci_aer_init() via
> pci_init_capabilities()

So the current tree (before this patch) always clears these AER status
registers regardless of CONFIG_PCIEAER.

After this patch, we would clear them only if CONFIG_PCIEAER=y.  I
don't see anything in arch/mips that sets CONFIG_PCIEAER, so I'm
concerned we will no longer clear the AER status bits.

I only want to propose a change here if we're very confident that it
won't change any OCTEON behavior.

> It is now no longer necessary for Octeon code to clear AER status
> registers since it's done by PCI core.
> 
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  arch/mips/pci/pci-octeon.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/arch/mips/pci/pci-octeon.c b/arch/mips/pci/pci-octeon.c
> index fc29b85cfa92..8e8b282226cc 100644
> --- a/arch/mips/pci/pci-octeon.c
> +++ b/arch/mips/pci/pci-octeon.c
> @@ -124,11 +124,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>  	/* Find the Advanced Error Reporting capability */
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>  	if (pos) {
> -		/* Clear Uncorrectable Error Status */
> -		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
> -				      &dconfig);
> -		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS,
> -				       dconfig);
>  		/* Enable reporting of all uncorrectable errors */
>  		/* Uncorrectable Error Mask - turned on bits disable errors */
>  		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, 0);
> @@ -138,9 +133,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>  		 * correctable, not if the error is reported.
>  		 */
>  		/* PCI_ERR_UNCOR_SEVER - Uncorrectable Error Severity */
> -		/* Clear Correctable Error Status */
> -		pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &dconfig);
> -		pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, dconfig);
>  		/* Enable reporting of all correctable errors */
>  		/* Correctable Error Mask - turned on bits disable errors */
>  		pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, 0);
> @@ -159,9 +151,6 @@ int pcibios_plat_dev_init(struct pci_dev *dev)
>  				       PCI_ERR_ROOT_CMD_COR_EN |
>  				       PCI_ERR_ROOT_CMD_NONFATAL_EN |
>  				       PCI_ERR_ROOT_CMD_FATAL_EN);
> -		/* Clear the Root status register */
> -		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &dconfig);
> -		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, dconfig);
>  	}
>  
>  	return 0;
> -- 
> 2.25.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
