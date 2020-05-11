Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E601CDD0D
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 16:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgEKOZU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 10:25:20 -0400
Received: from foss.arm.com ([217.140.110.172]:33334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgEKOZU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 10:25:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E051F1045;
        Mon, 11 May 2020 07:25:18 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F4643F68F;
        Mon, 11 May 2020 07:25:17 -0700 (PDT)
Date:   Mon, 11 May 2020 15:25:14 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 4/4] USB: pci-quirks: Add Raspberry Pi 4 quirk
Message-ID: <20200511142514.GB27249@e121166-lin.cambridge.arm.com>
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-5-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505161318.26200-5-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 05, 2020 at 06:13:17PM +0200, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideoCore. Inform VideoCore that VL805 was just reset.
> 
> Also, as this creates a dependency between USB_PCI and VideoCore's
> firmware interface, and since USB_PCI can't be set as a module neither
> this can. Reflect that on the firmware interface Kconfg.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
> 
> Changes since v5:
>  - Fix Kconfig issue with allmodconfig
> 
> Changes since v4:
>  - Do not split up error message
> 
> Changes since v3:
>  - Add more complete error message
> 
> Changes since v1:
>  - Make RASPBERRYPI_FIRMWARE dependent on this quirk to make sure it
>    gets compiled when needed.
> 
>  drivers/firmware/Kconfig      |  3 ++-
>  drivers/usb/host/pci-quirks.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+), 1 deletion(-)

Hi Mathias,

I would need your ACK to merge this series, thanks.

Lorenzo

> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 8007d4aa76dc..b42140cff8ac 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -178,8 +178,9 @@ config ISCSI_IBFT
>  	  Otherwise, say N.
>  
>  config RASPBERRYPI_FIRMWARE
> -	tristate "Raspberry Pi Firmware Driver"
> +	bool "Raspberry Pi Firmware Driver"
>  	depends on BCM2835_MBOX
> +	default USB_PCI
>  	help
>  	  This option enables support for communicating with the firmware on the
>  	  Raspberry Pi.
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 92150ecdb036..0b949acfa258 100644
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
> @@ -1243,11 +1246,24 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
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
> +		if (ret) {
> +			/* Firmware might be outdated, or something failed */
> +			dev_warn(&pdev->dev,
> +				 "Failed to load VL805's firmware: %d. Will continue to attempt to work, but bad things might happen. You should fix this...\n",
> +				 ret);
> +		}
> +	}
> +
>  	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
>  			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
>  			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
> -- 
> 2.26.2
> 
