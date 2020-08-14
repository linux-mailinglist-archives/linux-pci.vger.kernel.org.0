Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E42E2447CD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 12:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgHNKQC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 06:16:02 -0400
Received: from foss.arm.com ([217.140.110.172]:32858 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNKQB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Aug 2020 06:16:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAF991063;
        Fri, 14 Aug 2020 03:16:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF8E53F6CF;
        Fri, 14 Aug 2020 03:15:58 -0700 (PDT)
Date:   Fri, 14 Aug 2020 11:15:56 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, gregkh@linuxfoundation.org, robh@kernel.org,
        wahrenst@gmx.net, p.zabel@pengutronix.de,
        andy.shevchenko@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        mathias.nyman@linux.intel.com
Subject: Re: [PATCH v5 9/9] Revert "PCI: brcmstb: Wait for Raspberry Pi's
 firmware when present"
Message-ID: <20200814101556.GB19387@e121166-lin.cambridge.arm.com>
References: <20200629161845.6021-1-nsaenzjulienne@suse.de>
 <20200629161845.6021-10-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629161845.6021-10-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 29, 2020 at 06:18:45PM +0200, Nicolas Saenz Julienne wrote:
> This reverts commit 44331189f9082c7e659697bbac1747db3def73e7.
> 
> Now that the VL805 init routine is run through a reset controller driver
> the device dependencies are being taken care of by the device core. No
> need to do it manually here.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 17 -----------------
>  1 file changed, 17 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 7730ea845ff2..752f5b331579 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -28,8 +28,6 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> -#include <soc/bcm2835/raspberrypi-firmware.h>
> -
>  #include "../pci.h"
>  
>  /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
> @@ -931,26 +929,11 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node, *msi_np;
>  	struct pci_host_bridge *bridge;
> -	struct device_node *fw_np;
>  	struct brcm_pcie *pcie;
>  	struct pci_bus *child;
>  	struct resource *res;
>  	int ret;
>  
> -	/*
> -	 * We have to wait for Raspberry Pi's firmware interface to be up as a
> -	 * PCI fixup, rpi_firmware_init_vl805(), depends on it. This driver's
> -	 * probe can race with the firmware interface's (see
> -	 * drivers/firmware/raspberrypi.c) and potentially break the PCI fixup.
> -	 */
> -	fw_np = of_find_compatible_node(NULL, NULL,
> -					"raspberrypi,bcm2835-firmware");
> -	if (fw_np && !rpi_firmware_get(fw_np)) {
> -		of_node_put(fw_np);
> -		return -EPROBE_DEFER;
> -	}
> -	of_node_put(fw_np);
> -
>  	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
>  	if (!bridge)
>  		return -ENOMEM;
> -- 
> 2.27.0
> 
