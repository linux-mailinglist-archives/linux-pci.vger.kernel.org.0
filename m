Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD283163A
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 22:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEaUjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 16:39:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbfEaUjL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 16:39:11 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDFE626EAA;
        Fri, 31 May 2019 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559335150;
        bh=0HQst+0fKJNxhhK6HyvWrG2LQu7CnOIDA2z+zG4RBrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nXGB11sOFweqgSBdu+PiCNu+F9xDoJOdlrcoFTVwdlNywa/wrg6nmiwz+TCdKLZMj
         L6e/0EURXi5SEDep9yncxz7Mx9aQc0/VHR4px9GmiLWYnPAPUPt4/12AGVG1Be+0Qz
         mNBd7sW3ycKdBcLIkxwpafcUBnPKzUvW47xQqHGY=
Date:   Fri, 31 May 2019 15:39:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Abhishek Sahu <abhsahu@nvidia.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 2/2] PCI: Create device link for NVIDIA GPU
Message-ID: <20190531203908.GA58810@google.com>
References: <20190531050109.16211-1-abhsahu@nvidia.com>
 <20190531050109.16211-3-abhsahu@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531050109.16211-3-abhsahu@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Lukas, author of 07f4f97d7b4b ("vga_switcheroo: Use device link
for HDA controller")]

On Fri, May 31, 2019 at 10:31:09AM +0530, Abhishek Sahu wrote:
> NVIDIA Turing GPUs include hardware support for USB Type-C and
> VirtualLink. It helps in delivering the power, display, and data
> required to power VR headsets through a single USB Type-C connector.
> The Turing GPU is a multi-function PCI device has the following
> four functions:
> 
> 	- VGA display controller (Function 0)
> 	- Audio controller (Function 1)
> 	- USB xHCI Host controller (Function 2)
> 	- USB Type-C USCI controller (Function 3)
> 
> The function 0 is tightly coupled with other functions in the
> hardware. When function 0 goes in runtime suspended state,

"Runtime suspended" is a Linux concept, not a PCI concept.  Please
replace this with the appropriate PCI term, e.g., "D3hot" or whatever
it is.

> then it will do power gating for most of the hardware blocks.
> Some of these hardware blocks are used by other functions which
> leads to functional failure. So if any of these functions (1/2/3)
> are active, then function 0 should also be in active state.

Instead of "active" and "active state", please use the specific states
required in terms of PCI.

> 'commit 07f4f97d7b4b ("vga_switcheroo: Use device link for
> HDA controller")' creates the device link from function 1 to
> function 0. A similar kind of device link needs to be created
> between function 0 and functions 2 and 3 for NVIDIA Turing GPU.

I can't point to language that addresses this, but this sounds like a
case of the GPU not conforming to the PCI spec.  The general
assumption is that the OS should be able to discover everything it
needs to do power management directly from the architected PCI config
space.

It is definitely not ideal to have to add quirks like this for devices
designed this way.  Such quirks force us to do otherwise unnecessary
OS updates as new devices are released.

If all the devices in a multi-function device were connected
intimately enough that they all had to be managed by the same driver,
I could imagine putting these non-discoverable dependencies in the
driver.  But these devices don't seem to be related in that way.

If there *is* spec language that allows dependencies like this, please
include the citation in your commit log.

> This patch does the same and create the required device links. It
> will make function 0 to be runtime PM active if other functions
> are still active.
> 
> Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
> ---
>  drivers/pci/quirks.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index a20f7771a323..afdbc199efc5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4967,6 +4967,29 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>  			      PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>  
> +/* Create device link for NVIDIA GPU with integrated USB controller to VGA. */
> +static void quirk_gpu_usb(struct pci_dev *usb)
> +{
> +	pci_create_device_link_with_vga(usb, 2);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			      PCI_CLASS_SERIAL_USB, 8, quirk_gpu_usb);
> +
> +/*
> + * Create device link for NVIDIA GPU with integrated Type-C UCSI controller
> + * to VGA. Currently there is no class code defined for UCSI device over PCI
> + * so using UNKNOWN class for now and it will be updated when UCSI
> + * over PCI gets a class code.

Ugh.  Here's a good example of having to do yet another OS update.

> + */
> +#define PCI_CLASS_SERIAL_UNKNOWN	0x0c80
> +static void quirk_gpu_usb_typec_ucsi(struct pci_dev *ucsi)
> +{
> +	pci_create_device_link_with_vga(ucsi, 3);
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +			      PCI_CLASS_SERIAL_UNKNOWN, 8,
> +			      quirk_gpu_usb_typec_ucsi);
> +
>  /*
>   * Some IDT switches incorrectly flag an ACS Source Validation error on
>   * completions for config read requests even though PCIe r4.0, sec
> -- 
> 2.17.1
> 
