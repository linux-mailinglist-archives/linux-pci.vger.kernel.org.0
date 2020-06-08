Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22841F203D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFHTnw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 15:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgFHTnu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 15:43:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96355C08C5C2;
        Mon,  8 Jun 2020 12:43:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y17so18740078wrn.11;
        Mon, 08 Jun 2020 12:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eEhDs2ggMl3f7hmWAszT3Wg5EUHjiX8ZgjgQtEPz3Ew=;
        b=SeSuA/P6scbWq1Qmh2zpCSo7IcLTN9rnSoi07mfc7qWyYZK3Q3DYVo1VijgnOfNSdj
         r3vywNV9pCi0Afub1pOlwByjOut9ps2B/DjTMiU5XIHXPtx+bTupvONWl3wUj4GIE7XN
         7jmRn6U7u8Pw/6rqoy/LtoA1lwlByDxJbr48VQnlu+vjMfCDHjLY9HJJNEbvNCOb1HQq
         TYmx6d3y0qxRkn+koJEEJZLsxEDTZ7IqpiKn8n2+Si8QeluqpJvK+HQ9Jdmp0U6KjUMa
         Kdj9DY+26aXNWHArUb4TSzFok6Mz7H+tkNNgznU8lsMAe76hlbeSdAtfqawe6Y879Sf8
         khgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eEhDs2ggMl3f7hmWAszT3Wg5EUHjiX8ZgjgQtEPz3Ew=;
        b=QrpnTQhx3uIB+ojPsXS8T+TW+5IVIqXZZfypcnSqaoAb301zdGUGb8WL5EFdX4fMwC
         DSU1p0FxznQ+RN7enY/WYbDyPLcur0i2ermKFxNR+2ff1eAfPIxRpJDHMEKSj+VcO8sr
         sXs0ALua6OJLw6RRa80F0fnfU86pRYPOMuU4LpLvZv0XXDzTqfaMEpFH74IczoSlaX88
         amZ7ZkXGva2gcWrXb8+wm91Hj/EvV3hWMTIHf6QXj1QojZMLCVo7On7gNdNhMX++56+U
         UtsDTkAVzVmrrGqZb15hyIfQRwUpWh5iX+n7Gnsj4/5Kr3JQe+jRTTiZ2Xqeb+7MeARo
         QvaA==
X-Gm-Message-State: AOAM531TGQJ6lYUA69y3RNz49CT8PJuM3oL9YvhDGj4qancL2EOBCfwF
        KBvsaQYX+YsqJ6Ps4EHqQ2g=
X-Google-Smtp-Source: ABdhPJzbDt2pJwcpzdBFvHOLRZ0TDUp8Aq/TBRc5TkHGktIAfaGaZUxUEu/MKNMBoXEBH6K2qQduMg==
X-Received: by 2002:a5d:4b47:: with SMTP id w7mr385678wrs.234.1591645429157;
        Mon, 08 Jun 2020 12:43:49 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id t129sm538664wmf.41.2020.06.08.12.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:43:48 -0700 (PDT)
Subject: Re: [PATCH 5/9] usb: xhci-pci: Add support for reset controllers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        robh@kernel.org, mathias.nyman@linux.intel.com,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
 <20200608192701.18355-6-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5d3200cc-17cc-026f-1dfe-c10ec949f9ad@gmail.com>
Date:   Mon, 8 Jun 2020 12:43:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608192701.18355-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> Some atypical users of xhci-pci might need to manually reset their xHCI
> controller before starting the HCD setup. Check if a reset controller
> device is available to the PCI bus and trigger a reset.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/xhci-pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index ef513c2fb843..45f70facdfcd 100644
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
> @@ -347,6 +349,13 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  			return retval;
>  	}
>  
> +	reset = devm_reset_control_get(&dev->bus->dev, NULL);

Should not this be devm_reset_control_get_optional()?

> +	if (IS_ERR(reset)) {
> +		retval = PTR_ERR(reset);
> +		return retval;
> +	}
> +	reset_control_reset(reset);
> +
>  	/* Prevent runtime suspending between USB-2 and USB-3 initialization */
>  	pm_runtime_get_noresume(&dev->dev);
>  
> 

-- 
Florian
