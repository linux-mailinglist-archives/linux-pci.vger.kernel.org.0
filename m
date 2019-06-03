Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB263364D
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2019 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfFCRP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jun 2019 13:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfFCRP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Jun 2019 13:15:56 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F13275EA;
        Mon,  3 Jun 2019 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559582154;
        bh=2h+RgAo0T6Nw45DtDKzzxaVU7MlALt05Scf5Fgt49lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvZWeWA/8epHjqHuL6VTVUApc4IZNGyNZsVJltEL26ScletXNr8OHi7br7PtN3ckx
         +sOtvoXrv3FO3yOIVuol3GsDJeZsQV8opd2LgfOetfr1do6a6tb/72Ogah+znW515S
         1maFoGxeVbW4jAmBC56rm9Uex3K31EmupO8DqX78=
Date:   Mon, 3 Jun 2019 12:15:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] PCI: Code reorganization for VGA device link
Message-ID: <20190603171552.GB189360@google.com>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-2-abhsahu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531050109.16211-2-abhsahu@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas]

On Fri, May 31, 2019 at 10:31:08AM +0530, Abhishek Sahu wrote:
> This patch does minor code reorganization. It introduces a helper
> function which creates device link from the non-VGA controller
> (consumer) to the VGA (supplier) and uses this helper function for
> creating device link from integrated HDA controller to VGA. It will
> help in subsequent patches which require a similar kind of device
> link from USB/Type-C USCI controller to VGA.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/pci/quirks.c | 44 +++++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a077f67fe1da..a20f7771a323 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4916,36 +4916,50 @@ static void quirk_fsl_no_msi(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_no_msi);
>  
>  /*
> - * GPUs with integrated HDA controller for streaming audio to attached displays
> - * need a device link from the HDA controller (consumer) to the GPU (supplier)
> - * so that the GPU is powered up whenever the HDA controller is accessed.
> - * The GPU and HDA controller are functions 0 and 1 of the same PCI device.
> - * The device link stays in place until shutdown (or removal of the PCI device
> - * if it's hotplugged).  Runtime PM is allowed by default on the HDA controller
> - * to prevent it from permanently keeping the GPU awake.
> + * GPUs can be multi-function PCI device which can contain controllers other
> + * than VGA (like Audio, USB, etc.). Internally in the hardware, these non-VGA
> + * controllers are tightly coupled with VGA controller. Whenever these
> + * controllers are runtime active, the VGA controller should also be in active
> + * state. Normally, in these GPUs, the VGA controller is present at function 0.
> + *
> + * This is a helper function which creates device link from the non-VGA
> + * controller (consumer) to the VGA (supplier). The device link stays in place
> + * until shutdown (or removal of the PCI device if it's hotplugged).
> + * Runtime PM is allowed by default on these non-VGA controllers to prevent
> + * it from permanently keeping the GPU awake.
>   */
> -static void quirk_gpu_hda(struct pci_dev *hda)
> +static void
> +pci_create_device_link_with_vga(struct pci_dev *pdev, unsigned int devfn)

There's nothing in this functionality that depends on VGA, so let's
remove "GPU, "VGA", etc from the description, the function name, the
local variable name, and the log message.  Maybe you need to allow the
caller to supply the class type (PCI_BASE_CLASS_DISPLAY for current
users, but Lukas mentioned a NIC that might be able to use this too).

Follow the prevailing indentation style, with return type and function
name on the same line, i.e.,

  static void pci_create_device_link(...)

>  {
>  	struct pci_dev *gpu;
>  
> -	if (PCI_FUNC(hda->devfn) != 1)
> +	if (PCI_FUNC(pdev->devfn) != devfn)
>  		return;
>  
> -	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(hda->bus),
> -					  hda->bus->number,
> -					  PCI_DEVFN(PCI_SLOT(hda->devfn), 0));
> +	gpu = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +					  pdev->bus->number,
> +					  PCI_DEVFN(PCI_SLOT(pdev->devfn), 0));
>  	if (!gpu || (gpu->class >> 16) != PCI_BASE_CLASS_DISPLAY) {
>  		pci_dev_put(gpu);
>  		return;
>  	}
>  
> -	if (!device_link_add(&hda->dev, &gpu->dev,
> +	if (!device_link_add(&pdev->dev, &gpu->dev,
>  			     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME))
> -		pci_err(hda, "cannot link HDA to GPU %s\n", pci_name(gpu));
> +		pci_err(pdev, "cannot link with VGA %s\n", pci_name(gpu));

I think we should emit a message in the success case, too.  There is
one in device_link_add(), but it's a dev_dbg() so we can't count on it
being in the log.  I'd like a pci_info() that we can count on.

> -	pm_runtime_allow(&hda->dev);
> +	pm_runtime_allow(&pdev->dev);
>  	pci_dev_put(gpu);
>  }
> +
> +/*
> + * Create device link for GPUs with integrated HDA controller for streaming
> + * audio to attached displays.
> + */
> +static void quirk_gpu_hda(struct pci_dev *hda)
> +{
> +	pci_create_device_link_with_vga(hda, 1);
> +}
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_ATI, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
> -- 
> 2.17.1
> 
