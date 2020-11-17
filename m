Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF12B727C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 00:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgKQXcz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 18:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgKQXcz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 18:32:55 -0500
Received: from localhost (189.sub-72-105-114.myvzw.com [72.105.114.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07823222E9;
        Tue, 17 Nov 2020 23:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605655974;
        bh=F85FPfaEMeTqj4QbSsa0bWrg7O9YPVayE7SXkfK4SA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cziEFupjhFZcHgYnqrEvbe6SaAz6oQ+qOqxTqFAaUIxqrPgS9vZ9ceIHjW9T8Y8+z
         t1sdYv7ETJsZJlXiAN2a5J24tAiJR1peifvoUF7QhGTVX7wT/f6+lwOfIyKOnzCHmT
         N6NNITOPum+fU/6gjZsqvENGY/BgEKIgHbCUR3sk=
Date:   Tue, 17 Nov 2020 17:32:52 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org,
        alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201117233252.GA21051@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106100526.17726-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 12:05:25PM +0200, Andy Shevchenko wrote:
> Pericom PCIe-USB adapter advertises MSI, but documentation says
> "The MSI Function is not implemented on this device." in the chapters
> 7.3.27, 7.3.29-7.3.31.
> 
> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> Reported-by: alberto.vignani@fastwebnet.it
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I added the URL you sent and applied both of these, thanks!

> ---
> v2: dropped confusing word (David), added ifdeffery (Ben)
>  drivers/pci/quirks.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692ac79c5..e66e0cc8f99b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5567,17 +5567,26 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
>  
>  /*
> - * Device [12d8:0x400e] and [12d8:0x400f]
> + * Device 12d8:0x400e [OHCI] and 12d8:0x400f [EHCI]
> + *
>   * These devices advertise PME# support in all power states but don't
>   * reliably assert it.
> + *
> + * These devices advertise MSI, but documentation (PI7C9X440SL.pdf) says
> + * "The MSI Function is not implemented on this device." in the chapters
> + * 7.3.27, 7.3.29-7.3.31.
>   */
> -static void pci_fixup_no_pme(struct pci_dev *dev)
> +static void pci_fixup_no_msi_no_pme(struct pci_dev *dev)
>  {
> +#ifdef CONFIG_PCI_MSI
> +	pci_info(dev, "The MSI is not implemented on this device, disabling it\n");
> +	dev->no_msi = 1;
> +#endif
>  	pci_info(dev, "PME# is unreliable, disabling it\n");
>  	dev->pme_support = 0;
>  }
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
> -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_msi_no_pme);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_msi_no_pme);
>  
>  static void apex_pci_fixup_class(struct pci_dev *pdev)
>  {
> -- 
> 2.28.0
> 
