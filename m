Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E993419B71F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbgDAUhV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 16:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgDAUhV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 16:37:21 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4041B20784;
        Wed,  1 Apr 2020 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585773441;
        bh=XGuqY3v9GN49AYE1uApeV3PohFkEvU3ZN/PQTWB54s8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=P6QMqR3OG2gfhNx8K9SyIVJ5hpWYgYG7ZXtW02WMyiH/Ayu9p+bYk5g9f/hzkIzps
         WUwNHxvZh+pEhaMnWcc3jFcuVK+UvcqfA3SpV/B46I1EFklxgRHJnD7WdUXyvk4yZE
         V8/ZXZUPphZnR1y0h5j2EMZ/aAuJ08gjui7YGTlc=
Date:   Wed, 1 Apr 2020 15:37:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v6 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
Message-ID: <20200401203717.GA131226@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324182812.20420-3-nsaenzjulienne@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 07:28:10PM +0100, Nicolas Saenz Julienne wrote:
> On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> loaded directly from an EEPROM or, if not present, by the SoC's
> VideCore. The function informs VideCore that VL805 was just reset, or
> requests for a probe defer.

Cover letter mentions both "VideCore" and "VideoCore".  I dunno which
is correct, but between the commit log and the comment, this patch
mentions "VideCore" four times.

> Based on Tim Gover's downstream implementation.

Maybe a URL?

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> ---
> Changes since v4:
>  - Inline function definition when RASPBERRYPI_FIRMWARE is not defined
> 
> Changes since v1:
>  - Move include into .c file and add forward declaration to .h
> 
>  drivers/firmware/raspberrypi.c             | 38 ++++++++++++++++++++++
>  include/soc/bcm2835/raspberrypi-firmware.h |  7 ++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> index da26a584dca0..cbb495aff6a0 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -12,6 +12,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/pci.h>
>  #include <soc/bcm2835/raspberrypi-firmware.h>
>  
>  #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
> @@ -286,6 +287,43 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
>  }
>  EXPORT_SYMBOL_GPL(rpi_firmware_get);
>  
> +/*
> + * On the Raspberry Pi 4, after a PCI reset, VL805's firmware may either be
> + * loaded directly from an EEPROM or, if not present, by the SoC's VideCore.
> + * Inform VideCore that VL805 was just reset, or defer xhci's probe if not yet
> + * joinable trough the mailbox interface.

s/trough/through/

I don't see anything in this patch that looks like a mailbox
interface, but maybe that's just because I don't know anything about
Raspberry Pi.

> + */
> +int rpi_firmware_init_vl805(struct pci_dev *pdev)
> +{
> +	struct device_node *fw_np;
> +	struct rpi_firmware *fw;
> +	u32 dev_addr;
> +	int ret;
> +
> +	fw_np = of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (!fw_np)
> +		return 0;
> +
> +	fw = rpi_firmware_get(fw_np);
> +	of_node_put(fw_np);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	dev_addr = pdev->bus->number << 20 | PCI_SLOT(pdev->devfn) << 15 |
> +		   PCI_FUNC(pdev->devfn) << 12;
> +
> +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_NOTIFY_XHCI_RESET,
> +				    &dev_addr, sizeof(dev_addr));
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&pdev->dev, "loaded Raspberry Pi's VL805 firmware\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rpi_firmware_init_vl805);
> +
>  static const struct of_device_id rpi_firmware_of_match[] = {
>  	{ .compatible = "raspberrypi,bcm2835-firmware", },
>  	{},
> diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
> index cc9cdbc66403..3025aca3c358 100644
> --- a/include/soc/bcm2835/raspberrypi-firmware.h
> +++ b/include/soc/bcm2835/raspberrypi-firmware.h
> @@ -10,6 +10,7 @@
>  #include <linux/of_device.h>
>  
>  struct rpi_firmware;
> +struct pci_dev;
>  
>  enum rpi_firmware_property_status {
>  	RPI_FIRMWARE_STATUS_REQUEST = 0,
> @@ -141,6 +142,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
>  int rpi_firmware_property_list(struct rpi_firmware *fw,
>  			       void *data, size_t tag_size);
>  struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
> +int rpi_firmware_init_vl805(struct pci_dev *pdev);
>  #else
>  static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
>  					void *data, size_t len)
> @@ -158,6 +160,11 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
>  {
>  	return NULL;
>  }
> +
> +static inline int rpi_firmware_init_vl805(struct pci_dev *pdev)
> +{
> +	return 0;
> +}
>  #endif
>  
>  #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
> -- 
> 2.25.1
> 
