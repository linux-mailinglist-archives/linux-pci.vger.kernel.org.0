Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F778D3EB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 14:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbfHNMyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Aug 2019 08:54:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfHNMyf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2019 08:54:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id g8so767762edm.6
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2019 05:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VhOtcUs6qecW9A5Ku6t6s7+WyBSfMvyZ0VSLJHIcnmU=;
        b=D9tUU0YEFBXMadGDx0nLZflssJymUfZhkienHx+Qp/YN21+vDs2uPYDe3dnmpXBtF1
         qnkel4+FS65uyPrpL1uSAkt7hR8p0hqgCQqeH/X8iU3GB2XfC0V39X/2PGyDA5Mkb1+V
         Z46P6jag271R/W0WzRSMDD0BawX3vjNdN4bZ8GopZfQCF/RN7I/y+kEpXIw6DmKAejZ7
         7c5sQNQHv90KHws+ltGFFM7pgskbNUWBQL5Fr/cILbhx7Z6uJwYO2r2hgIk9EdvDNy1f
         Ma8CwPRbVCANigt+oMtcSmbsKo7LC/EdTusyjh5CgNuFF25Q+3tJOvqZTewDyLmw+Kd7
         PWUQ==
X-Gm-Message-State: APjAAAVQmJbDqY19EzSl9PGIoLR8k3gwW8MmcjyQH1UQUgoKOQrQUC/H
        fVfWfSDhhZPTV3vZseW9wuitolPQ4n0=
X-Google-Smtp-Source: APXvYqwHMa7CKohDcZxGXolr6aOboQawDOqzt7xdmk0Fs4g+/LFuohCkiGITZ0UNicDhSJh1b747Vw==
X-Received: by 2002:a50:fb82:: with SMTP id e2mr2969241edq.15.1565787272521;
        Wed, 14 Aug 2019 05:54:32 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id ng6sm10794969ejb.13.2019.08.14.05.54.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 05:54:31 -0700 (PDT)
Subject: Re: [PATCH] usb: xhci-pci: reorder removal to avoid use-after-free
To:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>
Cc:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1565782781938.37795@mentor.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <15aa45c7-6e45-d03f-9336-4291f8b2dc66@redhat.com>
Date:   Wed, 14 Aug 2019 14:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565782781938.37795@mentor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 14-08-19 13:39, Schmid, Carsten wrote:
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

Assuming this has been tested, overal this looks good to me.

But there are 2 things to fix:

1) Maybe pick a more descriptive struct member name then pdev.
    pdev with pci-devices often points to a pci_device ...
    How about: role_switch_pdev ?

2) xhci_ext_cap_init() is not the last call which can fail in
    xhci_pci_probe(), since you now no longer use devm_add_action_or_reset
    for auto-cleanup, you must now manually cleanup by calling
    xhci_ext_cap_remove() when later steps of xhci_pci_probe() fail.
    it looks like you will need a new ext_cap_remove error-exit label
    for this put above the put_usb3_hcd label and goto this new label
    instead of to put_usb3_hcd in all error paths after a successful call
    to xhci_ext_cap_init()

Regards,

Hans


> ---
>   drivers/usb/host/xhci-ext-caps.c | 22 ++++++++++++----------
>   drivers/usb/host/xhci-pci.c      |  4 ++++
>   drivers/usb/host/xhci-pci.h      | 19 +++++++++++++++++++
>   drivers/usb/host/xhci.h          |  1 +
>   4 files changed, 36 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/usb/host/xhci-pci.h
> 
> diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
> index 399113f9fc5c..d2ab1e2a39c0 100644
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
> +	priv->pdev = pdev;
>   
>   	return 0;
>   }
> @@ -88,3 +82,11 @@ int xhci_ext_cap_init(struct xhci_hcd *xhci)
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(xhci_ext_cap_init);
> +
> +void xhci_ext_cap_remove(struct xhci_hcd *xhci)
> +{
> +	struct xhci_pci_priv *priv = (struct xhci_pci_priv *)xhci->priv;
> +	if (priv->pdev)
> +		platform_device_unregister(priv->pdev);
> +}
> +EXPORT_SYMBOL_GPL(xhci_ext_cap_remove);
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index c2fe218e051f..a4d094df56f7 100644
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
> @@ -393,6 +395,8 @@ static void xhci_pci_remove(struct pci_dev *dev)
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
> index 000000000000..ead9618d7368
> --- /dev/null
> +++ b/drivers/usb/host/xhci-pci.h
> @@ -0,0 +1,19 @@
> +/*
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
> +	struct platform_device *pdev;
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
