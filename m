Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6284E260
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2019 10:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFUIxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 04:53:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54825 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfFUIxF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jun 2019 04:53:05 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1heFI7-0007Qv-Gj
        for linux-pci@vger.kernel.org; Fri, 21 Jun 2019 08:53:03 +0000
Received: by mail-pf1-f198.google.com with SMTP id u21so3977206pfn.15
        for <linux-pci@vger.kernel.org>; Fri, 21 Jun 2019 01:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u1hSlNEter5h1ru+YK0xU7QWME8tCkI1M6jD8mwebc0=;
        b=Ty6XwWBUWwCfB7WDRIOsVVVEXAFC9MSrlvBScJCtc+AQP7Gt1FLUgP6QwNhmGi1aX2
         H4X4Nm99/LibajpQPduF9S82/mENWHL8iyai3Hq+EkoZcCzKKYhmQ4/RFhj3XUzrZvHW
         ioOU/oJ8T0GDhJPH5OJs5MiGKwZRfYcWSdakSQoZB5DhAEK0p2HHMqdNrkcqYc9F+aws
         gWPxeENS0MO/b4V5sRO2X0jgVWavp+8CmRQpKJnalaZke9hOh3cPJArGO1DJB0rPURxH
         thV780d8ErWzROG5YKNgdSqFIftD8sJk1G8gSaRPlkvqom42oZXGAiJiIHO7VLr4rFKP
         JYlQ==
X-Gm-Message-State: APjAAAVGgFlFgSd8P5wPG0xKX1qSV54Ef5M8+2FFeCqwils8lYi30ZzB
        cbl23U8XcClzcLZUXL+fz7DYBJTPjlGc0iT1eeikUlELArDDC32+6A0zSLiSJqfsJ5EdDyhDd3K
        97z2ZoNdmJ+veHNHTYISwFhtT6oGlopyCYGMM6A==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1mr48855011plb.271.1561107182194;
        Fri, 21 Jun 2019 01:53:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz8nVP924V3DK7kjmQuC0S7gMYc5j/LFZzSXMJFzmTAzQwvANHE7EWYdGbGTao99GI3cwnXmQ==
X-Received: by 2002:a17:902:e281:: with SMTP id cf1mr48854995plb.271.1561107181925;
        Fri, 21 Jun 2019 01:53:01 -0700 (PDT)
Received: from 2001-b011-380f-3511-28ca-1aa7-7f48-7d86.dynamic-ip6.hinet.net (2001-b011-380f-3511-28ca-1aa7-7f48-7d86.dynamic-ip6.hinet.net. [2001:b011:380f:3511:28ca:1aa7:7f48:7d86])
        by smtp.gmail.com with ESMTPSA id l44sm4959357pje.29.2019.06.21.01.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 01:53:01 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] PCI: pciehp: Do not disable interrupt twice on
 suspend
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
Date:   Fri, 21 Jun 2019 16:52:57 +0800
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <62F7BEE7-F38E-41C8-A181-B03F9308DE81@canonical.com>
References: <20190618125051.2382-1-mika.westerberg@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

at 20:50, Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> We try to keep PCIe hotplug ports runtime suspended when entering system
> suspend. Due to the fact that the PCIe portdrv sets NEVER_SKIP driver PM
> flag the PM core always calls system suspend/resume hooks even if the
> device is left runtime suspended. Since PCIe hotplug driver re-uses the
> same function for both it ends up disabling hotplug interrupt twice and
> the second time following is printed:
>
>   pciehp 0000:03:01.0:pcie204: pcie_do_write_cmd: no response from device
>
> Prevent this from happening by checking whether the device is already
> runtime suspended when system suspend hook is called.
>
> Fixes: 9c62f0bfb832 ("PCI: pciehp: Implement runtime PM callbacks")
> Reported-by: Kai Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/pci/hotplug/pciehp_core.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_core.c  
> b/drivers/pci/hotplug/pciehp_core.c
> index 6ad0d86762cb..3f8c13ddb3e8 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -248,7 +248,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	return pcie_ports_native || host->native_pme;
>  }
>
> -static int pciehp_suspend(struct pcie_device *dev)
> +static void pciehp_disable_interrupt(struct pcie_device *dev)
>  {
>  	/*
>  	 * Disable hotplug interrupt so that it does not trigger
> @@ -256,7 +256,19 @@ static int pciehp_suspend(struct pcie_device *dev)
>  	 */
>  	if (pme_is_native(dev))
>  		pcie_disable_interrupt(get_service_data(dev));
> +}
>
> +#ifdef CONFIG_PM_SLEEP
> +static int pciehp_suspend(struct pcie_device *dev)
> +{
> +	/*
> +	 * If the port is already runtime suspended we can keep it that
> +	 * way.
> +	 */
> +	if (dev_pm_smart_suspend_and_suspended(&dev->port->dev))
> +		return 0;
> +
> +	pciehp_disable_interrupt(dev);
>  	return 0;
>  }
>
> @@ -274,6 +286,7 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
>
>  	return 0;
>  }
> +#endif
>
>  static int pciehp_resume(struct pcie_device *dev)
>  {
> @@ -287,6 +300,12 @@ static int pciehp_resume(struct pcie_device *dev)
>  	return 0;
>  }
>
> +static int pciehp_runtime_suspend(struct pcie_device *dev)
> +{
> +	pciehp_disable_interrupt(dev);
> +	return 0;
> +}
> +
>  static int pciehp_runtime_resume(struct pcie_device *dev)
>  {
>  	struct controller *ctrl = get_service_data(dev);
> @@ -313,10 +332,12 @@ static struct pcie_port_service_driver  
> hpdriver_portdrv = {
>  	.remove		= pciehp_remove,
>
>  #ifdef	CONFIG_PM
> +#ifdef	CONFIG_PM_SLEEP
>  	.suspend	= pciehp_suspend,
>  	.resume_noirq	= pciehp_resume_noirq,
> +#endif
>  	.resume		= pciehp_resume,
> -	.runtime_suspend = pciehp_suspend,
> +	.runtime_suspend = pciehp_runtime_suspend,
>  	.runtime_resume	= pciehp_runtime_resume,
>  #endif	/* PM */
>  };
> -- 
> 2.20.1


