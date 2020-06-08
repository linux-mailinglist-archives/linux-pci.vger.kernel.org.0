Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50FF1F204E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jun 2020 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFHTvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Jun 2020 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgFHTvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jun 2020 15:51:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC6C08C5C2;
        Mon,  8 Jun 2020 12:51:06 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so18733767wrm.13;
        Mon, 08 Jun 2020 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o5RsBAa3pHyGyH1Nf7xqWjY4s1FOdQYE7k1GR7WvK+Y=;
        b=N3vINQBBjDhjwltCTk4vLqaHoCDmpSznY1srZ5V/zbmPxdqlnC+/pmPlQHHoAwIe9B
         oUaY7MSfZe4RcX5zuaV2XyDtBx1bR9mPWAw7K8PoLXukvY8ImPCBpiGot87xw/RFYKix
         GLxs4Af3xmFpKolPH1YeZ+Rmw0/ZrgO0S9ioEUI/Tz0SSzVEgZ2UB3KYF9jtXSk/6s7b
         ip2VxR06bCDpND0T303PPmw3GNmtaFCBLGMH08iyT3g9YBE4QSONyykzMR3Y+qwLSU60
         fd6immvVGQp9DZJhlGWE7rmFD1svntJnV4yvgdsl+NNBFAWQzIZ2CXJFWPSNtNba4wPR
         SDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o5RsBAa3pHyGyH1Nf7xqWjY4s1FOdQYE7k1GR7WvK+Y=;
        b=a1GTnIXwbc1LzjXZU5HGuv0+WBKekVuT12cIvENxOAETjntXuloi3A/bFdeNBiBMkf
         ZKiWgt7tY5i7fCPEb0FEdcHOO/pXPCuBuYumG2jhwBXrXUrGelg1PWOtNetvV6deesAb
         vHERPKOWepvtJQO8XrL/BNZmO+Bun73BBEEGtf4fyKrJCAExwNqq0aSaCQJlcVVu/TVI
         Wsoi68WN8pUiAn2J5wQaCaRQcAczfZcoeQKzLAQkaAg5gRZMS8fq3G/pJZ2xFPwC7LRG
         kdIOZJj/tgN684pyjGV4tiB5yLIHNGXDkI4wWZ9Mn79wq1uoERlUvx0e37MsYEwD2BoS
         7ubQ==
X-Gm-Message-State: AOAM53390Qp0N7UjYaE/jXoJIRCUjs+L1WxQ+z4aiUqfPoS0ITHoxhob
        oXbURRaALJYJZSQsw3FBQ6w=
X-Google-Smtp-Source: ABdhPJw+Lng+MYT9sFvOIDd5/BQc0mai6p2yW5rVQDkoQhjjOqgKoQROdpu5l2JKcDlSnSwrtuty3Q==
X-Received: by 2002:adf:b198:: with SMTP id q24mr421481wra.368.1591645865305;
        Mon, 08 Jun 2020 12:51:05 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id s8sm772992wrg.50.2020.06.08.12.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:51:04 -0700 (PDT)
Subject: Re: [PATCH 7/9] usb: host: pci-quirks: Bypass xHCI quirks for
 Raspberry Pi 4
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com, gregkh@linuxfoundation.org, wahrenst@gmx.net,
        robh@kernel.org, mathias.nyman@linux.intel.com,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     linux-kernel@vger.kernel.org, tim.gover@raspberrypi.org,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com
References: <20200608192701.18355-1-nsaenzjulienne@suse.de>
 <20200608192701.18355-8-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6b1084e1-05ca-5321-46fd-7b6f83224a49@gmail.com>
Date:   Mon, 8 Jun 2020 12:50:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608192701.18355-8-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/8/2020 12:26 PM, Nicolas Saenz Julienne wrote:
> The board doesn't need the quirks to be run, and takes case of its own

(if you have to resubmit) takes care

> initialization trough a reset controller device. So let's bypass it

its quirk.

> quirk.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/usb/host/pci-quirks.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
> index 92150ecdb036..4b3be05d1290 100644
> --- a/drivers/usb/host/pci-quirks.c
> +++ b/drivers/usb/host/pci-quirks.c
> @@ -16,6 +16,8 @@
>  #include <linux/export.h>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> +#include <linux/of.h>
> +
>  #include "pci-quirks.h"
>  #include "xhci-ext-caps.h"
>  
> @@ -1248,6 +1250,16 @@ static void quirk_usb_early_handoff(struct pci_dev *pdev)
>  	 */
>  	if (pdev->vendor == 0x184e)	/* vendor Netlogic */
>  		return;
> +
> +	/*
> +	 * Bypass the Raspberry Pi 4 controller xHCI controller, things are
> +	 * taken care by the board's co-processor.

taken care of by.

With that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_VIA && pdev->device == 0x3483 &&
> +	    of_device_is_compatible(of_get_parent(pdev->bus->dev.of_node),
> +				    "brcm,bcm2711-pcie"))
> +		return;
> +
>  	if (pdev->class != PCI_CLASS_SERIAL_USB_UHCI &&
>  			pdev->class != PCI_CLASS_SERIAL_USB_OHCI &&
>  			pdev->class != PCI_CLASS_SERIAL_USB_EHCI &&
> 

-- 
Florian
