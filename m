Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB08C44DEC9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 01:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhKLADn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 19:03:43 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:33387 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhKLADm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 19:03:42 -0500
Received: by mail-pj1-f41.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5012519pjj.0;
        Thu, 11 Nov 2021 16:00:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XGHZ26K2ZnTdtM9Vpe3wWAEf07Z04ZfkU4P5oNhWnoo=;
        b=jyq7etcftIf8kruXN+h36v3bnLYdnBrAm21geAcwt9/3udAN8loL8Xkb8Zj1CNOS3V
         mw+vP9AzpCvPyGv12VyZxuXeBWTlQCeKPIuI671x3FTTshZpSnz3mWS6fAsO3iqFLWBw
         OljWDvb+aRBJPh7S3Y+31QtSd8kfCKdZfX8fc8tM7juuOAxUrigPUaVTLWPLNDby89la
         GOzt3zWFckuQpNnw71AXqJR40cJNUxcWhmZ3aQtCbnhyhnfszv20aIHxDMnO9mZJe21f
         8biwfwtrhcBjEazG6asjtocIFKpfrT4FJnGrDgt+mhqcb6bNIfad0UdPWdM3gn8Jor+c
         cuug==
X-Gm-Message-State: AOAM532moL9aeNe6NIa97sme8IR1/Pvqbr0haMPyHq1Sgt+jkXOSNRK4
        g94M+oBkGrJnhimfB8ETevc=
X-Google-Smtp-Source: ABdhPJzcd9mdPRgXPHgt4Ji2bt4ozpzXtBL50vxOCskZCd67vSddBhyBW9fvPEpZflJXmLhznAK+gg==
X-Received: by 2002:a17:903:4053:b0:143:6d84:984c with SMTP id n19-20020a170903405300b001436d84984cmr3449505pla.37.1636675252787;
        Thu, 11 Nov 2021 16:00:52 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z30sm4042467pfg.30.2021.11.11.16.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:00:52 -0800 (PST)
Date:   Fri, 12 Nov 2021 01:00:43 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-pci@vger.kernel.org, mst@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pciehp: fast unplug for virtual machines
Message-ID: <YY2uqx4LC2J5F/w9@rocinante>
References: <20211111090225.946381-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111090225.946381-1-kraxel@redhat.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Gerd,

> The PCIe specification asks the OS to wait five seconds after the
> attention button has been pressed before actually un-plugging the
> device.  This gives the operator the chance to cancel the operation
> by pressing the attention button again within those five seconds.
> 
> For physical hardware this makes sense.  Picking the wrong button
> by accident can easily happen and it can be corrected that way.
> 
> For virtual hardware the benefits are questionable.  Typically
> users find the five second delay annoying.
> 
> This patch adds the fast_virtual_unplug module parameter to the
> pciehp driver.  When enabled (which is the default) the linux
> kernel will simply skip the delay for virtual pcie ports, which
> reduces the total time for the unplug operation from 6-7 seconds
> to 1-2 seconds.
> 
> Virtual pcie ports are identified by PCI ID.  For now the qemu
> pcie root ports are detected, other hardware can be added easily.

Bjorn asked to correct the PCIe references, whereas I would ask you to
change "linux" to "Linux", "qemu" to "QEMU", and generally capitalise
things where and as needed throughout.

>   * @request_result: result of last user request submitted to the IRQ thread
>   * @requester: wait queue to wake up on completion of user request,
>   *	used for synchronous slot enable/disable request via sysfs
> + * @is_virtual: virtual machine pcie port.

It would be "PCIe" here too for consistency.

> +	if (dev->port->vendor == PCI_VENDOR_ID_REDHAT &&
> +	    dev->port->device == 0x000c)
> +		/* qemu pcie root port */
> +		ctrl->is_virtual = true;

I would personally move the comment above the if-statement as it looks
a little awkward added like that.  You could also add a little bit more
detail why this is set for QEMU and what it's needed, etc.  Also, if you
don't mind, let's change it to "QEMU" in the comment for consistency.

> -		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
> +		if (ctrl->is_virtual && fast_virtual_unplug) {
> +			schedule_delayed_work(&ctrl->button_work, 1);
> +		} else {
> +			schedule_delayed_work(&ctrl->button_work, 5 * HZ);
> +		}

The brackets are fine but technically not needed above as per the kernel
coding style.

	Krzysztof
