Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D5178D0C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 10:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgCDJGB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 04:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDJGB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Mar 2020 04:06:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D436E2072D;
        Wed,  4 Mar 2020 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583312758;
        bh=nv9z76qB1AKdNeHNDVvjHLCUMfYUelYmliFzrlCR1xI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTrJb2nLOkC3o5SdH0RfJuDO3+VKd84OhHaBaZVRb3O2Ur83RlzXVHaQkO0GfHzHu
         3gmkPcBjGwKBXwt3VXDXDLJJXPBz5eP9uphOkBtnCJaPRyDemc+cPP9jUcmkSAR3hn
         MoNlOP+aswJByig32PeT4UbzI37cRSWxBn7/P6Kg=
Date:   Wed, 4 Mar 2020 10:05:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net
Subject: Re: [PATCH v3 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Message-ID: <20200304090555.GC1429273@kroah.com>
References: <20200302155528.19505-1-nsaenzjulienne@suse.de>
 <20200302155528.19505-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302155528.19505-5-nsaenzjulienne@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 02, 2020 at 04:55:28PM +0100, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideCore. Inform VideCore that VL805 was just reset.
> 
> Also, as this creates a dependency between XHCI_PCI and VideoCore's,
> reflect that on the firmware interface Kconfg.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v1:
>  - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
>    gets compiled when needed.
> 
>  drivers/firmware/Kconfig      |  1 +
>  drivers/usb/host/pci-quirks.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index ea869addc89b..40a468d712a5 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -180,6 +180,7 @@ config ISCSI_IBFT
>  config RASPBERRYPI_FIRMWARE
>  	tristate "Raspberry Pi Firmware Driver"
>  	depends on BCM2835_MBOX
> +	default XHCI_PCI
>  	help
>  	  This option enables support for communicating with the firmware on the
>  	  Raspberry Pi.
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index beb2efa71341..aee2eaa3f0e1 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -16,6 +16,9 @@
>  #include <linux/export.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> +
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
>  #include "pci-quirks.h"
>  #include "xhci-ext-caps.h"
>  
> @@ -1243,11 +1246,26 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
>  
>  static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  {
> +	int ret;
> +
>  	/* Skip Netlogic mips SoC's internal PCI USB controller.
>  	 * This device does not need/support EHCI/OHCI handoff
>  	 */
>  	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
>  		return;
> +
> +	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483) {
> +		ret = rpi_firmware_init_vl805(pdev);
> +		if (ret)
> +			/*
> +			 * Firmware might be outdated, or else, something
> +			 * failed, keep going and hope for the best.
> +			 */
> +			dev_warn(&pdev->dev,
> +				 "Failed to load VL805's firmware: %d\n",
> +				 ret);

{} please.

Also, you might want to provide a better warning, something like:
	"Failed to load VL805's firmware, will continue to attempt to
	work, but bad things might happen, you should fix this..."

or something to give people a chance to know what to do here.

thanks,

greg k-h
