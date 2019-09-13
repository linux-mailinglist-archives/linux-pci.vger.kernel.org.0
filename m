Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EADDB17C3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2019 06:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfIMEjS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Sep 2019 00:39:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbfIMEjS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Sep 2019 00:39:18 -0400
Received: from localhost (unknown [84.241.200.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06CC2084F;
        Fri, 13 Sep 2019 04:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568349555;
        bh=V42IY/tDAhDb2DxVPh/wJZNEwQpXRbftt5CzHV3T5ZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Di7QjpuxEEMqAkGFRrIwi4KyQMYb2N7r2lRF+5/QOpX9SFXbF+XwsRTlItzo44o4t
         Hq4Y6RvSk0t4hHVQk78Yv+zipp1YU0fN25GZLdIwaBqSPkhF4zAJ9teFdsEpei82OX
         +R/Q6Q6FULOL8Bzxyoe+dulRaCgSkCIne34zGLK0=
Date:   Fri, 13 Sep 2019 05:39:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, bhelgaas@google.com,
        rafael@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jgg@mellanox.com, ashok.raj@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [RFC V1 2/7] drivers/base: Introduce callbacks for IMS interrupt
 domain
Message-ID: <20190913043910.GA119695@kroah.com>
References: <1568338328-22458-1-git-send-email-megha.dey@linux.intel.com>
 <1568338328-22458-3-git-send-email-megha.dey@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568338328-22458-3-git-send-email-megha.dey@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:03PM -0700, Megha Dey wrote:
> This patch serves as a preparatory patch to introduce a new IMS
> (Interrupt Message Store) domain. It consists of APIs which would
> be used as callbacks to the IRQ chip associated with the IMS domain.
> 
> The APIs introduced in this patch are:
> dev_ims_mask_irq - Generic irq chip callback to mask IMS interrupts
> dev_ims_unmask_irq - Generic irq chip callback to unmask IMS interrupts
> dev_ims_domain_write_msg - Helper to write MSI message to Device IMS
> 
> It also introduces IMS specific structures namely:
> dev_ims_ops - Callbacks for IMS domain ops
> dev_ims_desc - Device specific IMS msi descriptor data
> dev_ims_priv_data - Internal data structure containing a unique devid
> and a pointer to the IMS domain ops
> 
> Lastly, it adds a new config option MSI_IMS which must be enabled by
> any driver who would want to use the IMS infrastructure.
> 
> Since IMS is not PCI compliant (like platform-msi), most of the code is
> similar to platform-msi.c.
> 
> TODO: Conclude if ims-msi.c and platform-msi.c can be merged.
> 
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
> Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
> ---
>  drivers/base/Kconfig   |  7 ++++
>  drivers/base/Makefile  |  1 +
>  drivers/base/ims-msi.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h    | 35 ++++++++++++++++++-
>  4 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/base/ims-msi.c
> 
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index dc40449..038fabd 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -206,3 +206,10 @@ config GENERIC_ARCH_TOPOLOGY
>  	  runtime.
>  
>  endmenu
> +
> +config MSI_IMS
> +	bool "Device Specific Interrupt Message Storage (IMS)"
> +	select GENERIC_MSI_IRQ
> +	help
> +	  This allows device drivers to enable device specific
> +	  interrupt message storage (IMS) besides standard MSI-X interrupts.

This text tells me nothing about if I want to enable this or not.  How
is a user (or even a developer) supposed to know if their hardware
requires this?

And I _really_ dont want to see this in drivers/base/ if at all possible
because suddenly I am responsible for this code that I know nothing
about.

greg k-h
