Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487DD1F4540
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbgFISNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 14:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387968AbgFISNh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 14:13:37 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59257C05BD1E;
        Tue,  9 Jun 2020 11:13:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k26so4094113wmi.4;
        Tue, 09 Jun 2020 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HvCHrSiZhJmADjuwF4pBq6CIXD97v5dk3vK3Zip2OOk=;
        b=p0GOKJhY6wvvU2KcdvgSuWvIVOpAzgRnrkvFSIxYIkGFk6IoPtNOKV+/C18Ll29uPz
         nBqyZLreTeWkUgSZWSIcnYIAhnHW5oWpyoqdX+3R9a2ibqgr6MRGrcI6Ffk8WxHwJ8aL
         DdL+01t0CyzWPLd6BCGSvgJybzf8+fQoFv3/xgOUXuXrNnzO0VKYTPNmbNe/1WV/HE3q
         jw1+BE07aYnrIqUEBD64HiQX69YOWyTRCM9Hdu4pzqb2nezJyq3ReuRBk+owjEdTOpDN
         2gSAi6PvxDCAZsHw+ndUGZqll3ZwBtsP1Opa0hBcnGKJg+eLzNZKoTdC8dV0o4aIYTOE
         o1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HvCHrSiZhJmADjuwF4pBq6CIXD97v5dk3vK3Zip2OOk=;
        b=X7xiLndquOJBc1tqOunLNH+0sCzcn7fH3nRgKGQDVSVkmGurW1JdkJKQtCYel0hay+
         W7WNjdJ2prkhEXvuqfzfYqKBHka3G2WkhnT1JgnM5m2JWB9CA67cjUO2G3aZ0E9VxOdT
         h19cumVsYf+ldfa5y96oJD0qWtPWa5hvKyjb35ZKLeqcYgs/bTS7Zc/v3HgYcPEa+o0q
         xIrkSkogAbiyZKEyctB5gnDUCCvPR31F/eh034nZX+SVgfg7T+thQeryM0I650aFlCOa
         znsMDt4Zxjz4CkV1gc1x7EJsnXUPSMZKu7iBVUN0IzcKr4oozlQNKWr+Et8qDwOugcSe
         rYeA==
X-Gm-Message-State: AOAM5335liB2tpJDzdKY+g8O3KRKkdPtDFn8UppUyPa5JmnwJ6O59IWA
        P8s5XdrLNTj0mvbRgNBgtjo=
X-Google-Smtp-Source: ABdhPJxhpOaX7J8Q3M/gSS5Xp3Uaihda4VDb5vi94Gott9/Hfou31WEbAepReRxcUx6Qz/aimAEscQ==
X-Received: by 2002:a05:600c:4102:: with SMTP id j2mr5191612wmi.48.1591726414843;
        Tue, 09 Jun 2020 11:13:34 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id l204sm3904721wmf.19.2020.06.09.11.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 11:13:33 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] usb: xhci-pci: Add support for reset controllers
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-usb@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.org,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        andy.shevchenko@gmail.com, mathias.nyman@linux.intel.com,
        lorenzo.pieralisi@arm.com
References: <20200609175003.19793-1-nsaenzjulienne@suse.de>
 <20200609175003.19793-6-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d452ddb8-cd30-1bfc-7b72-af3412e22ed4@gmail.com>
Date:   Tue, 9 Jun 2020 11:13:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609175003.19793-6-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/9/2020 10:49 AM, Nicolas Saenz Julienne wrote:
> Some atypical users of xhci-pci might need to manually reset their xHCI
> controller before starting the HCD setup. Check if a reset controller
> device is available to the PCI bus and trigger a reset.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v1:
>  - Use proper reset API
>  - Make code simpler
> 
>  drivers/usb/host/xhci-pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index ef513c2fb843..6e96affa4ceb 100644
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

Sorry for not catching this earlier, since this is a generic integration
with the reset controller API, should not you also add a
reset_control_reset() to hcd_pci_resume() for symmetry?

> +
>  	/* Prevent runtime suspending between USB-2 and USB-3 initialization */
>  	pm_runtime_get_noresume(&dev->dev);
>  
> 

-- 
Florian
