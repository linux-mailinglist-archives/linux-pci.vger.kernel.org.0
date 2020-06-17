Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805A1FCA65
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 12:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgFQKCs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 17 Jun 2020 06:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQKCq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 06:02:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEEAC061573
        for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2020 03:02:45 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUty-0004vi-20; Wed, 17 Jun 2020 12:02:38 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1jlUtw-0004iI-Cc; Wed, 17 Jun 2020 12:02:36 +0200
Message-ID: <70fc0b8dd6d1a6b39fb5d334ff86265cd84d8979.camel@pengutronix.de>
Subject: Re: [PATCH v3 5/9] usb: xhci-pci: Add support for reset controllers
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
Date:   Wed, 17 Jun 2020 12:02:36 +0200
In-Reply-To: <20200612171334.26385-6-nsaenzjulienne@suse.de>
References: <20200612171334.26385-1-nsaenzjulienne@suse.de>
         <20200612171334.26385-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 2020-06-12 at 19:13 +0200, Nicolas Saenz Julienne wrote:
> Some atypical users of xhci-pci might need to manually reset their xHCI
> controller before starting the HCD setup. Check if a reset controller
> device is available to the PCI bus and trigger a reset.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v2:
>  - Also reset on resume
> 
> Changes since v1:
>  - Use proper reset API
>  - Make code simpler
> 
>  drivers/usb/host/xhci-pci.c | 10 ++++++++++
>  drivers/usb/host/xhci.h     |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index ef513c2fb843..e76b9283faa3 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -12,6 +12,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/acpi.h>
> +#include <linux/reset.h>
>  
>  #include "xhci.h"
>  #include "xhci-trace.h"
> @@ -339,6 +340,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct xhci_hcd *xhci;
>  	struct usb_hcd *hcd;
>  	struct xhci_driver_data *driver_data;
> +	struct reset_control *reset;
>  
>  	driver_data = (struct xhci_driver_data *)id->driver_data;
>  	if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
> @@ -347,6 +349,11 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  			return retval;
>  	}
>  
> +	reset = devm_reset_control_get_optional_exclusive(&dev->bus->dev, NULL);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +	reset_control_reset(reset);

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
