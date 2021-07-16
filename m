Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B23CBEC5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jul 2021 23:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhGPV7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jul 2021 17:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhGPV7o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Jul 2021 17:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BE93613F1;
        Fri, 16 Jul 2021 21:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626472608;
        bh=tKOagru+qVjZu758/c2+PD/cp+FBJEYcEqv4iWhxaPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=e2UqQdNW5pYCKTyKK8jAqDuZqpEirChvkwC599w+H6aOm9Qv8mu9vy48R51bYAr0j
         w3yCkdaLqpqIKUWJZK1HoYcHsFLWBHYpVXq3Zr7YoSVjTTwo+B9ifXHaXZaUobTqEW
         3pQ1ggAuaoDtyEZ9t1wn0V64OH29cF8Futx8VmCFYYumKBx0Akm6BtmzcFwEOVAzHU
         CJ7+FKQqUIoYRikNq+AqZIpJWXxhg+nBu2vFOKKigN/Inalh9OK68cNBtnz4pU3y0L
         T9ND9WMdh4Bxd2t+Or2QLw+7vrlhS2p3NObkHye4pyt/7cnerVAG9umOO/P+Wf9xow
         H2VYyTbl/sWWA==
Date:   Fri, 16 Jul 2021 16:56:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] PCI/portdrv: Use link bandwidth notification
 capability bit
Message-ID: <20210716215647.GA2146665@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512213314.7778-1-stuart.w.hayes@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 13, 2021 at 03:03:14AM +0530, Stuart Hayes wrote:
> The pcieport driver can fail to attach to a downstream port that doesn't
> support bandwidth notification.  This can happen when, in
> pcie_port_device_register(), pci_init_service_irqs() tries (and fails) to
> set up a bandwidth notification IRQ for a device that doesn't support it.

I'm trying to figure out exactly how this fails.  The only failure
path in pcie_init_service_irqs() is when
pci_alloc_irq_vectors(PCI_IRQ_LEGACY) fails, which I guess means the
port's dev->irq was zero?

And to even attempt legacy IRQs, either we had pcie_pme_no_msi() or
pcie_port_enable_irq_vec() failed?

> This patch changes get_port_device_capability() to look at the link
> bandwidth notification capability bit in the link capabilities register of
> the port, instead of assuming that all downstream ports have that
> capability.

I think this needs:

  Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")

because even though b4c7d2076b4e ("PCI/LINK: Remove bandwidth
notification") removed *most* of e8303bb7a75c, it did not remove the
code in get_port_device_capability() that you're fixing here.

I can fix this up locally, no need to resend.  I think the patch
itself is fine, just trying to understand the commit log.

> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> 
> changes from v1:
> 	- corrected spelling errors in commit message
> 	- added Lukas' reviewed-by:
> 
> ---
>  drivers/pci/pcie/portdrv_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index e1fed6649c41..3ee63968deaa 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -257,8 +257,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> -		services |= PCIE_PORT_SERVICE_BWNOTIF;
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		u32 linkcap;
> +
> +		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
> +		if (linkcap & PCI_EXP_LNKCAP_LBNC)
> +			services |= PCIE_PORT_SERVICE_BWNOTIF;
> +	}
>  
>  	return services;
>  }
> -- 
> 2.27.0
> 
