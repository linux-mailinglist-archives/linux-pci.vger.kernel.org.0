Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31603F3751
	for <lists+linux-pci@lfdr.de>; Sat, 21 Aug 2021 01:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhHTXeK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 19:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231506AbhHTXeJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 19:34:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E85461184;
        Fri, 20 Aug 2021 23:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629502410;
        bh=e/bDc226rtUN+ZSsR3mfNTICiOyVOib8bsPamAIIgEk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nYyhJ/EhIR0yUnd87yTF/lGX/ojnejzNyXbhImBAWd4nO0xPSqA3JYNN4d6BAzbUC
         01L7t8zJqbNUbD5lu0lXVFgzGVJOys1nYtcSnp1fsvpqbpvL8pT5xx2l9crxksm/Zy
         gWJhWMoU6cegg2HFqguEGpKTdmJsDaUrwcg7jiq6orlLC66uc2GUh4JI6JqkuJktnO
         aiFiJGNdMfEmbl3mWOtVO4DAcp6zAV0QgIQVpAbgimlR9wBP6nJQ8KDzgaoTjUHPeX
         gO6PDhW+ANiy/hC1HuZc1cSvRycj4JWfXuOY57f6jkEEwCKKx8iQP+6ul965eKMPTj
         GAtq0rhbV5/qQ==
Date:   Fri, 20 Aug 2021 18:33:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     bhelgaas@google.com, corbet@lwn.net, Jonathan.Cameron@huawei.com,
        bilbao@vt.edu, gregkh@linuxfoundation.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxarm@huawei.com, luzmaximilian@gmail.com,
        mchehab+huawei@kernel.org, schnelle@linux.ibm.com,
        song.bao.hua@hisilicon.com, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI/MSI: Fix the confusing IRQ sysfs ABI for MSI-X
Message-ID: <20210820233328.GA3368938@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820223744.8439-2-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thomas, Marc]

On Sat, Aug 21, 2021 at 10:37:43AM +1200, Barry Song wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> /sys/bus/pci/devices/.../irq sysfs ABI is very confusing at this
> moment especially for MSI-X cases. 

AFAICT this patch *only* affects MSI-X.  So are you saying the sysfs
ABI is fine for MSI but confusing for MSI-X?

> While MSI sets IRQ to the first
> number in the vector, MSI-X does nothing for this though it saves
> default_irq in msix_setup_entries(). Weird the saved default_irq
> for MSI-X is never used in pci_msix_shutdown(), which is quite
> different with pci_msi_shutdown(). Thus, this patch moves to show
> the first IRQ number which is from the first msi_entry for MSI-X.
> Hopefully, this can make IRQ ABI more clear and more consistent.
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  drivers/pci/msi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9232255..6bbf81b 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -771,6 +771,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	int ret;
>  	u16 control;
>  	void __iomem *base;
> +	struct msi_desc *desc;
>  
>  	/* Ensure MSI-X is disabled while it is set up */
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> @@ -814,6 +815,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  
>  	pcibios_free_irq(dev);
> +
> +	desc = first_pci_msi_entry(dev);
> +	dev->irq = desc->irq;

This change is not primarily about sysfs.  This is about changing
"dev->irq" when MSI-X is enabled, and it's only incidental that sysfs
reflects that.

So we need to know the effect of changing dev->irq.  Drivers may use
the value of dev->irq, and I'm *guessing* this change shouldn't break
them since we already do this for MSI, but I'd like some more expert
opinion than mine :)

For MSI we have:

  msi_capability_init
    msi_setup_entry
      entry = alloc_msi_entry(nvec)
      entry->msi_attrib.default_irq = dev->irq;     /* Save IOAPIC IRQ */
    dev->irq = entry->irq;

  pci_msi_shutdown
    /* Restore dev->irq to its default pin-assertion IRQ */
    dev->irq = desc->msi_attrib.default_irq;

and for MSI-X we have:

  msix_capability_init
    msix_setup_entries
      for (i = 0; i < nvec; i++)
        entry = alloc_msi_entry(1)
	entry->msi_attrib.default_irq = dev->irq;

  pci_msix_shutdown
    for_each_pci_msi_entry(entry, dev)
      __pci_msix_desc_mask_irq
+   dev->irq = entry->msi_attrib.default_irq;   # added by this patch


Things that seem strange to me:

  - The msi_setup_entry() comment "Save IOAPIC IRQ" seems needlessly
    specific; maybe it should be "INTx IRQ".

  - The pci_msi_shutdown() comment "Restore ... pin-assertion IRQ"
    should match the msi_setup_entry() one, e.g., maybe it should also
    be "INTx IRQ".  There are no INTx or IOAPIC pins in PCIe.

  - The only use of .default_irq is to save and restore dev->irq, so
    it looks like a per-device thing, not a per-vector thing.

    In msi_setup_entry() there's only one msi_entry, so there's only
    one saved .default_irq.

    In msix_setup_entries(), we get nvecs msi_entry structs, and we
    get a saved .default_irq in each one?

  - In pci_msix_shutdown() we restore dev->irq from the .default_irq
    of whatever "entry" contains after the for_each_pci_msi_entry()
    loop.  Is "entry" defined there?  I don't know what the cursor
    contains after a list_for_each_entry() loop exits.

>  	return 0;
>  
>  out_avail:
> @@ -1024,6 +1029,7 @@ static void pci_msix_shutdown(struct pci_dev *dev)
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
>  	pci_intx_for_msi(dev, 1);
>  	dev->msix_enabled = 0;
> +	dev->irq = entry->msi_attrib.default_irq;
>  	pcibios_alloc_irq(dev);
>  }
>  
> -- 
> 1.8.3.1
> 
