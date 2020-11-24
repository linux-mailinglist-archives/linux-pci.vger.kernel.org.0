Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B15F2C332A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 22:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgKXVkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 16:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732867AbgKXVkX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Nov 2020 16:40:23 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FE09206E5;
        Tue, 24 Nov 2020 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606254022;
        bh=Tc13627qaGoJFHj+rlNukdlF3YFb+U3BeasxgtFq7cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KbWcyt8kt2/6OUMLenaAiS43p4Gf0eEKzXpZJAn0sUiHQWR40Ka6YaVcVozMQeCux
         3mc9t4DDzmv+aP4Q/WuxmkpuIcWlcvGZN1WhtcexV9e/z7Os9M8yXNj5Qf6BwyZ/+B
         GwTuZUR1qBM/TzjFtD+k5Gvv7+dx38ydUhQZPx+A=
Date:   Tue, 24 Nov 2020 15:40:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/5] PCI: Add a reset quirk for VMD
Message-ID: <20201124214020.GA590491@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120225144.15138-3-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Alex]

On Fri, Nov 20, 2020 at 03:51:41PM -0700, Jon Derrick wrote:
> VMD domains should be reset in-between special attachment such as VFIO
> users. VMD does not offer a reset, however the subdevice domain itself
> can be reset starting at the Root Bus. Add a Secondary Bus Reset on each
> of the individual root port devices immediately downstream of the VMD
> root bus.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/pci/quirks.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f70692a..ee58b51 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3744,6 +3744,49 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> +/* Issues SBR to VMD domain to clear PCI configuration */
> +static int reset_vmd_sbr(struct pci_dev *dev, int probe)
> +{
> +	char __iomem *cfgbar, *base;
> +	int rp;
> +	u16 ctl;
> +
> +	if (probe)
> +		return 0;
> +
> +	if (dev->dev.driver)
> +		return 0;

I guess "dev" here is the VMD endpoint?  And if the vmd.c driver is
bound to it, you return success without doing anything?

If there's no driver for the VMD device, who is trying to reset it?

I guess I don't quite understand how VMD works.  I would have thought
that if vmd.c isn't bound to the VMD device, the devices behind the
VMD would be inaccessible and there'd be no point in a reset.

> +	cfgbar = pci_iomap(dev, 0, 0);
> +	if (!cfgbar)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Subdevice config space is mapped linearly using 4k config space
> +	 * increments. Use increments of 0x8000 to locate root port devices.
> +	 */
> +	for (rp = 0; rp < 4; rp++) {
> +		base = cfgbar + rp * 0x8000;

I really don't like this part -- iomapping BAR 0 (apparently
VMD_CFGBAR), and making up the ECAM-ish addresses and basically
open-coding ECAM accesses below.  I guess this assumes Root Ports are
only on functions .0, .2, .4, .6?

Is it all open-coded here because this reset path is only of interest
when vmd.c is NOT bound to the the VMD device, so you can't use
vmd->cfgbar, etc?

What about the case when vmd.c IS bound?  We don't do anything here,
so does that mean we instead use the usual case of asserting SBR on
the Root Ports behind the VMD?

> +		if (readl(base + PCI_COMMAND) == 0xFFFFFFFF)
> +			continue;
> +
> +		/* pci_reset_secondary_bus() */
> +		ctl = readw(base + PCI_BRIDGE_CONTROL);
> +		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> +		readw(base + PCI_BRIDGE_CONTROL);
> +		msleep(2);
> +
> +		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +		writew(ctl, base + PCI_BRIDGE_CONTROL);
> +		readw(base + PCI_BRIDGE_CONTROL);
> +	}
> +
> +	ssleep(1);
> +	pci_iounmap(dev, cfgbar);
> +	return 0;
> +}
> +
>  /* Device-specific reset method for Chelsio T4-based adapters */
>  static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
>  {
> @@ -3919,6 +3962,11 @@ static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
>  		reset_ivb_igd },
>  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
>  		reset_ivb_igd },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D, reset_vmd_sbr },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0, reset_vmd_sbr },
> +	{ PCI_VENDOR_ID_INTEL, 0x467f, reset_vmd_sbr },
> +	{ PCI_VENDOR_ID_INTEL, 0x4c3d, reset_vmd_sbr },
> +	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B, reset_vmd_sbr },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
>  	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
>  	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> -- 
> 1.8.3.1
> 
