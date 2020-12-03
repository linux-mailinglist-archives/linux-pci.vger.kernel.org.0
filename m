Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D232CDD75
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 19:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgLCSZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 13:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731594AbgLCSZF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:25:05 -0500
Date:   Thu, 3 Dec 2020 12:24:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607019864;
        bh=OSYjR3KU12Rh2mAMrwtk4wsx9Qj28rYM92rA8hzOoJk=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=obo0nDCtSHQuTaolGry8nmvcpThiQsMJPk4PCnntVYyIAtI6JPR3IBCF1yM/IAVuk
         3jj5/DY6oaP4fr+gTNjC5tckZ0VmghCRZJ66FY8Djyu5Vz07IuhBBhVbR6jiC7XaYw
         oKdoO+/XSHK/fqoK3o4xhc+8zGUEQpXBe+84oqGc5B6w1slXUd4wTrG+FppUsFyXjt
         a+rViIG9dfLnxF7RftJqhq+1jhz+NNNC0lsg2TXU7tMxntgNrS5TCaRWPErz+TPckF
         cj5dac5pi6Kp5NYnhjVvmWi9P+e0+AGs61834a+SIVRL9Z/zw4p7sBodOT1INkU/G9
         VuvOe8s3owWWw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V2] PCI/MSI: Set device flag indicating only 32-bit MSI
 support
Message-ID: <20201203182423.GA1555592@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124105035.24573-1-vidyas@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24, 2020 at 04:20:35PM +0530, Vidya Sagar wrote:
> There are devices (Ex:- Marvell SATA controller) that don't support
> 64-bit MSIs and the same is advertised through their MSI capability
> register. Set no_64bit_msi flag explicitly for such devices in the
> MSI setup code so that the msi_verify_entries() API would catch
> if the MSI arch code tries to use 64-bit MSI.

This seems good to me.  I'll post a possible revision to set
dev->no_64bit_msi in the device enumeration path instead of in the IRQ
allocation path, since it's really a property of the device, not of
the msi_desc.

I like the extra checking this gives us.  Was this prompted by
tripping over something, or is it something you noticed by code
reading?  If the former, a hint about what was wrong and how it's
being fixed would be useful.

> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Addressed Bjorn's comment and changed the error message
> 
>  drivers/pci/msi.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index d52d118979a6..8de5ba6b4a59 100644
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
> @@ -602,8 +604,9 @@ static int msi_verify_entries(struct pci_dev *dev)
>  	for_each_pci_msi_entry(entry, dev) {
>  		if (!dev->no_64bit_msi || !entry->msg.address_hi)
>  			continue;
> -		pci_err(dev, "Device has broken 64-bit MSI but arch"
> -			" tried to assign one above 4G\n");
> +		pci_err(dev, "Device has either broken 64-bit MSI or "
> +			"only 32-bit MSI support but "
> +			"arch tried to assign one above 4G\n");
>  		return -EIO;
>  	}
>  	return 0;
> -- 
> 2.17.1
> 
