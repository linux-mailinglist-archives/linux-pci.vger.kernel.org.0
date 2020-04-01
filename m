Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0CC19B731
	for <lists+linux-pci@lfdr.de>; Wed,  1 Apr 2020 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgDAUlx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Apr 2020 16:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732411AbgDAUlx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Apr 2020 16:41:53 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A3320784;
        Wed,  1 Apr 2020 20:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585773712;
        bh=fOb6323VVZj8kSp5HYZBO6o0MOZ9Hc27kb2duDD/dnM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zqlOgx8EK/+RtZkVEUJkxz5HghOAcO1dHWzBPmGkHR5NyuhO4dmVH21IpMJ/fSX/9
         JJyPeI7JSEUwtXf7u0DS6YMZiRa3WhAM8uH+EZaZbh3cqkZt9PS6lUTFKtQMwF6QBI
         014NBWXhsw2Zj22M8wwX6RSyHBASz9wMpd88c1OE=
Date:   Wed, 1 Apr 2020 15:41:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v6 3/4] PCI: brcmstb: Wait for Raspberry Pi's firmware
 when present
Message-ID: <20200401204149.GA131584@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324182812.20420-4-nsaenzjulienne@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 07:28:11PM +0100, Nicolas Saenz Julienne wrote:
> xHCI's PCI fixup, run at the end of pcie-brcmstb's probe, depends on

Is there a function name for this fixup that you can mention?

> RPi4's VideoCore firmware interface to be up and running. It's possible
> for both initializations to race, so make sure it's available prior to
> starting.

I guess "both initializations" means brcm_pcie_probe() and something
else?  It'd be nice to include that function name here, too.

> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 3a10e678c7f4..a3d3070a5832 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -28,6 +28,8 @@
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
>  #include "../pci.h"
>  
>  /* BRCM_PCIE_CAP_REGS - Offset for the mandatory capability config regs */
> @@ -917,11 +919,24 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node, *msi_np;
>  	struct pci_host_bridge *bridge;
> +	struct device_node *fw_np;
>  	struct brcm_pcie *pcie;
>  	struct pci_bus *child;
>  	struct resource *res;
>  	int ret;
>  
> +	/*
> +	 * We have to wait for the Raspberry Pi's firmware interface to be up
> +	 * as some PCI fixups depend on it.

It'd be nice to know the nature of this dependency between the
firmware interface and the fixups.  This may be useful for future
maintenance.  E.g., if PCI config access doesn't work until the
firmware interface is up, that would affect almost everything.  But
you say "some PCI fixups", so I suppose the actual dependency is
probably something else.

> +	 */
> +	fw_np = of_find_compatible_node(NULL, NULL,
> +					"raspberrypi,bcm2835-firmware");
> +	if (fw_np && !rpi_firmware_get(fw_np)) {
> +		of_node_put(fw_np);
> +		return -EPROBE_DEFER;
> +	}
> +	of_node_put(fw_np);
> +
>  	bridge = devm_pci_alloc_host_bridge(&pdev->dev, sizeof(*pcie));
>  	if (!bridge)
>  		return -ENOMEM;
> -- 
> 2.25.1
> 
