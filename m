Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C562BB857
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 22:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgKTVaj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 16:30:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgKTVai (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 16:30:38 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7841E2240B;
        Fri, 20 Nov 2020 21:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605907837;
        bh=yYWeZ4bWNoarJNFW+Bl6kgWy2hoART6WL65Zj6FeDK0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zCmRQXICfs6qq+5SYKY1oY/aj2+nMa4EtRC/zg6zm+CoTkMC/pw9nI/iSoqDlro9q
         URc/rknIEgisXNb6lbQ8nLd8drRT9tOypVQcGz8DPkiPJo2znZ2Au5oCyAfrwNccji
         jRQvdZi68LgYcYtAgfJhkioiIrqaZ7Q/wD/eLHe8=
Date:   Fri, 20 Nov 2020 15:30:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
Message-ID: <20201120213036.GA278887@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117145728.4516-1-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 08:27:28PM +0530, Vidya Sagar wrote:
> There are devices (Ex:- Marvell SATA controller) that don't support
> 64-bit MSIs and the same is advertised through their MSI capability
> register. 

I *think* you're saying these devices behave correctly per spec: they
don't support 64-bit MSI, and they don't advertise support for 64-bit
MSI.  Right?

> Set no_64bit_msi flag explicitly for such devices in the
> MSI setup code so that the msi_verify_entries() API would catch
> if the MSI arch code tries to use 64-bit MSI.

And you want msi_verify_entries() to catch attempts by the arch code
to assign a 64-bit MSI address?

That sounds OK, but the error message ("Device has broken 64-bit MSI")
is not appropriate if the device is actually *not* broken.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  drivers/pci/msi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d52d118979a6..af49da28854e 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -581,10 +581,12 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
>  	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>  	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>  
> -	if (control & PCI_MSI_FLAGS_64BIT)
> +	if (control & PCI_MSI_FLAGS_64BIT) {
>  		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> -	else
> +	} else {
>  		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
> +		dev->no_64bit_msi = 1;
> +	}
>  
>  	/* Save the initial mask status */
>  	if (entry->msi_attrib.maskbit)
> -- 
> 2.17.1
> 
