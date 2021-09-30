Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F10841D84D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350261AbhI3LF2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 07:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350196AbhI3LF1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Sep 2021 07:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632999825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=keN+btlYVBJGWOu91I+oCLYZrcd1MoxAA4HpYxaefz4=;
        b=e5OQUoFF3Gewm8xnWcmIBTnP0b42ewR0GpgKsoedMKsC5l1SJAHZPOkg1xvH2lu7yukuxg
        sxNfDPKbYx/IpCu8I9j+3QoHp+N2Z8R5VyWhYr7hJUTnyTVWNekqYZPya8t7TM6HmvYp96
        0Whzcp/pW5ddItPbPtNxPAYh4vQ9t0k=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-VGTnDSL4OhSB5GuZyouFaQ-1; Thu, 30 Sep 2021 07:03:43 -0400
X-MC-Unique: VGTnDSL4OhSB5GuZyouFaQ-1
Received: by mail-ed1-f71.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so5579897edj.21
        for <linux-pci@vger.kernel.org>; Thu, 30 Sep 2021 04:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=keN+btlYVBJGWOu91I+oCLYZrcd1MoxAA4HpYxaefz4=;
        b=kLia1/QwxoIhosGN7sIc655tPN3NDjMQUz7Hs6NW7sld+gNAQc2Tf+y/ZET3FuUPUv
         8I9nrK+RU3ZqKIjNIrBoZYe6g79VzRnTj+ybVcTaoDoHyGbWUE7WfuWIR69gm2gwDxiJ
         vfvTBvcGZK2HLSbjDMlfNq6y3xfnBZMl7yYBhhmqKt8eTZMGKBgg7OnYBqEOJBKi+co5
         Ck7XQ+VR8EHm6Muq8j2tAApR3p5sO/YI+tbFGXIBocwIxvZO6tAELfHM2jJF+UOJFKoT
         isqncJI1TFMF9QZ+A8S6aBXlvISgabj0LOj2CLbwxfr4LHc88OwZjcRVZIhV/g0ZaSZk
         6+3w==
X-Gm-Message-State: AOAM532sR81sovK3IULdZAza9HjqNjeIW9jvcM5yEUFkEFdAik+A8NET
        SLab5IhXLGPBIyrNqnapfQJZDMCpc3x+vbII6cNJm1IuMo+qCdzAvixk6Lya6Crb/bIUi+GXe5y
        U9pGrUEkxgxIUhH/K03Ia
X-Received: by 2002:a17:906:2e8d:: with SMTP id o13mr5757131eji.513.1632999822752;
        Thu, 30 Sep 2021 04:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8LNAIxQqSSpjIHptID8EWuyzXRl8baUIAwt3FwCua7Hi/w5dhATxEGvg5mbk5gBCu14U0Ww==
X-Received: by 2002:a17:906:2e8d:: with SMTP id o13mr5757108eji.513.1632999822544;
        Thu, 30 Sep 2021 04:03:42 -0700 (PDT)
Received: from redhat.com ([2.55.134.220])
        by smtp.gmail.com with ESMTPSA id v8sm1291353ejy.79.2021.09.30.04.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:03:42 -0700 (PDT)
Date:   Thu, 30 Sep 2021 07:03:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jason Wang <jasowang@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 4/6] virtio: Initialize authorized attribute for
 confidential guest
Message-ID: <20210930065953-mutt-send-email-mst@kernel.org>
References: <20210930010511.3387967-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930010511.3387967-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 06:05:09PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Confidential guest platforms like TDX have a requirement to allow
> only trusted devices. By default the confidential-guest core will
> arrange for all devices to default to unauthorized (via
> dev_default_authorization) in device_initialize(). Since virtio
> driver is already hardened against the attack from the un-trusted host,
> override the confidential computing default unauthorized state
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Architecturally this all looks backwards. IIUC nothing about virtio
makes it authorized or trusted. The driver is hardened,
true, but this should be set at the driver not the device level.
And in particular, not all virtio drivers are hardened -
I think at this point blk and scsi drivers have been hardened - so
treating them all the same looks wrong.

> ---
>  drivers/virtio/virtio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 588e02fb91d3..377b0ccdc503 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -5,6 +5,8 @@
>  #include <linux/module.h>
>  #include <linux/idr.h>
>  #include <linux/of.h>
> +#include <linux/cc_platform.h>
> +#include <linux/device.h>
>  #include <uapi/linux/virtio_ids.h>
>  
>  /* Unique numbering for virtio devices. */
> @@ -390,6 +392,13 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
>  
> +	/*
> +	 * For Confidential guest (like TDX), virtio devices are
> +	 * trusted. So set authorized status as true.
> +	 */
> +	if (cc_platform_has(CC_ATTR_GUEST_DEVICE_FILTER))
> +		dev->dev.authorized = true;
> +
>  	/* We always start by resetting the device, in case a previous
>  	 * driver messed it up.  This also tests that code path a little. */
>  	dev->config->reset(dev);
> -- 
> 2.25.1

