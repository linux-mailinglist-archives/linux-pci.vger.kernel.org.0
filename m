Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C9B8EF4C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfHOP1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 11:27:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55965 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbfHOP13 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2019 11:27:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id f72so1601734wmf.5
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2019 08:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XyD06YZS2Z9vjlAjxD/F+RLqC6OCWBrblTJoR3CHyz0=;
        b=Xn3JTQOgXl+mQcM/zqDgeSHvfZseygMlge17mmxWyDewdGmU4b4Rsl5vZUlf4v0gOV
         HsbzS5FGpWMIv/yHzSu+d9QEEunyonmy7mXtzSYpTVuSwoWqcBJBRVPytPU4Q4B4dz88
         rcy3rV334o6YSRV0rzJpwVcJ/PnWzVI7EqKDMsDTTER8sIjZC1zHelLkKIXoL5RKX45t
         UsycYHYiaAf7/i7yDrIuXR/WWgW1aTEKoXB1RwiL1Ze7KRsuzpWozKt0Tr65zWAY4eGy
         L2ULJgCcv5sHz2C3oDBSu0zBAcRTPBmbWYVe81EHIb6nJXyuw62ttiwvt/D4S+DG07os
         e4sA==
X-Gm-Message-State: APjAAAWRSyYhb0r2XEAqwnr8q3UltHMisauY132TQS/FzEczVou/jJG0
        XQtFbEdRGxIBnFM4IiPQhfBmcAHBxCU=
X-Google-Smtp-Source: APXvYqxe3J9geeNRz3vyjHD53+OQ9de7Rnny6r2RtTiMr5lRzviRCKfNI6NE/YpaOkqoNTszUrn39g==
X-Received: by 2002:a1c:f20a:: with SMTP id s10mr3397376wmc.145.1565882846338;
        Thu, 15 Aug 2019 08:27:26 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id d16sm3726349wrj.47.2019.08.15.08.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 08:27:25 -0700 (PDT)
Subject: Re: [PATCH v2] usb: xhci-pci: reorder removal to avoid use-after-free
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1565782781938.37795@mentor.com>
 <15aa45c7-6e45-d03f-9336-4291f8b2dc66@redhat.com>
 <29aadcf136bb4d5285afb4fc5b500b49@SVR-IES-MBX-03.mgc.mentorg.com>
 <662c2014-f52c-a4a7-cbf0-78d43c3a4f22@redhat.com>
 <1565793165678.11527@mentor.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3cb06e75-70a8-0f59-ae08-5bbd99abbead@redhat.com>
Date:   Thu, 15 Aug 2019 17:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565793165678.11527@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 14-08-19 16:32, Schmid, Carsten wrote:
> On driver removal, the platform_device_unregister call
> attached through devm_add_action_or_reset was executed
> after usb_hcd_pci_remove.
> This lead to a use-after-free for the iomem resorce of
> the xhci-ext-caps driver in the platform removal
> because the parent of the resource was freed earlier.
> 
> Fix this by reordering of the removal sequence.
> 
> Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> v2:
>    - more speaking name for private data element
>    - consider failure in driver init sequence
>    - fix minor issues found by checkpatch.pl
> ---
>   drivers/usb/host/xhci-ext-caps.c | 25 +++++++++++++++----------
>   drivers/usb/host/xhci-pci.c      |  8 +++++++-
>   drivers/usb/host/xhci-pci.h      | 20 ++++++++++++++++++++
>   drivers/usb/host/xhci.h          |  1 +
>   4 files changed, 43 insertions(+), 11 deletions(-)
>   create mode 100644 drivers/usb/host/xhci-pci.h
> 
> diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
> index 399113f9fc5c..28a7d53ecf2c 100644
> --- a/drivers/usb/host/xhci-ext-caps.c
> +++ b/drivers/usb/host/xhci-ext-caps.c
> @@ -7,21 +7,19 @@
>   
>   #include <linux/platform_device.h>
>   #include "xhci.h"
> +#include "xhci-pci.h"
>   
>   #define USB_SW_DRV_NAME		"intel_xhci_usb_sw"
>   #define USB_SW_RESOURCE_SIZE	0x400
>   
> -static void xhci_intel_unregister_pdev(void *arg)
> -{
> -	platform_device_unregister(arg);
> -}
> -
>   static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
>   {
>   	struct usb_hcd *hcd = xhci_to_hcd(xhci);
>   	struct device *dev = hcd->self.controller;
>   	struct platform_device *pdev;
>   	struct resource	res = { 0, };
> +	struct xhci_pci_priv *priv = (struct xhci_pci_priv *)xhci->priv;
> +
>   	int ret;
>   
>   	pdev = platform_device_alloc(USB_SW_DRV_NAME, PLATFORM_DEVID_NONE);
> @@ -52,11 +50,7 @@ static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
>   		return ret;
>   	}
>   
> -	ret = devm_add_action_or_reset(dev, xhci_intel_unregister_pdev, pdev);
> -	if (ret) {
> -		dev_err(dev, "couldn't add unregister action for intel_xhci_usb_sw pdev\n");
> -		return ret;
> -	}
> +	priv->role_switch_pdev = pdev;
>   
>   	return 0;
>   }
> @@ -88,3 +82,14 @@ int xhci_ext_cap_init(struct xhci_hcd *xhci)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(xhci_ext_cap_init);
> +
> +void xhci_ext_cap_remove(struct xhci_hcd *xhci)
> +{
> +	struct xhci_pci_priv *priv = (struct xhci_pci_priv *)xhci->priv;
> +
> +	if (priv->role_switch_pdev) {
> +		platform_device_unregister(priv->role_switch_pdev);
> +		priv->role_switch_pdev = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(xhci_ext_cap_remove);
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index c2fe218e051f..f2201f380c17 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -14,6 +14,7 @@
>   #include <linux/acpi.h>
>   
>   #include "xhci.h"
> +#include "xhci-pci.h"
>   #include "xhci-trace.h"
>   
>   #define SSIC_PORT_NUM		2
> @@ -62,6 +63,7 @@ static struct hc_driver __read_mostly xhci_pci_hc_driver;
>   static int xhci_pci_setup(struct usb_hcd *hcd);
>   
>   static const struct xhci_driver_overrides xhci_pci_overrides __initconst = {
> +	.extra_priv_size = sizeof(struct xhci_pci_priv),
>   	.reset = xhci_pci_setup,
>   };
>   
> @@ -350,7 +352,7 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   	retval = usb_add_hcd(xhci->shared_hcd, dev->irq,
>   			IRQF_SHARED);
>   	if (retval)
> -		goto put_usb3_hcd;
> +		goto remove_ext_cap;
>   	/* Roothub already marked as USB 3.0 speed */
>   
>   	if (!(xhci->quirks & XHCI_BROKEN_STREAMS) &&
> @@ -368,6 +370,8 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>   
>   	return 0;
>   
> +remove_ext_cap:
> +	xhci_ext_cap_remove(xhci);
>   put_usb3_hcd:
>   	usb_put_hcd(xhci->shared_hcd);
>   dealloc_usb2_hcd:
> @@ -393,6 +397,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
>   		xhci->shared_hcd = NULL;
>   	}
>   
> +	xhci_ext_cap_remove(xhci);
> +
>   	/* Workaround for spurious wakeups at shutdown with HSW */
>   	if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)
>   		pci_set_power_state(dev, PCI_D3hot);
> diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
> new file mode 100644
> index 000000000000..fc0cde231679
> --- /dev/null
> +++ b/drivers/usb/host/xhci-pci.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * xhci-pci.h - xHCI extended capability handling platform Glue.
> + *
> + * Copyright (C) 2019 Mentor Graphics (Deutschland) GmbH
> + * Derived from xhci-plat.h
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + */
> +
> +#ifndef _XHCI_PCI_H
> +#define _XHCI_PCI_H
> +
> +struct xhci_pci_priv {
> +	struct platform_device *role_switch_pdev;
> +};
> +
> +#endif	/* _XHCI_PCI_H */
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index fabbce1c542a..847d2021fc2c 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -2052,6 +2052,7 @@ void xhci_init_driver(struct hc_driver *drv,
>   		      const struct xhci_driver_overrides *over);
>   int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
>   int xhci_ext_cap_init(struct xhci_hcd *xhci);
> +void xhci_ext_cap_remove(struct xhci_hcd *xhci);
>   
>   int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
>   int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
> 
