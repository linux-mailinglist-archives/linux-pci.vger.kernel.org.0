Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F3C25B1C9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIBQfH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 12:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIBQfG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 12:35:06 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4E5920758;
        Wed,  2 Sep 2020 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599064506;
        bh=KxFin5A9dCw9jPCu/DGxlbI3xeSp5sIBjTaaSCNQ57Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DTDMutwtpLJppf/wm3p39RnFJwoSm9LTWg6yzoW9TaLw/2ae9hpmvRFfqKeMjVcAJ
         w631tXHhcbrL7xPHlvlKXn5IkLsmk7FNkwhVMDIMLUdMj1NZ5YEXE+dZKt946/QSep
         zoj+PuansiTu2KQgZxZg5f5XaNA45N7dgaAKpaJU=
Date:   Wed, 2 Sep 2020 11:35:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] PCI: Add 'rcec' field to pci_dev for associated
 RCiEPs
Message-ID: <20200902163504.GA254301@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812164659.1118946-8-sean.v.kelley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 12, 2020 at 09:46:56AM -0700, Sean V Kelley wrote:
> From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> 
> When attempting error recovery for an RCiEP associated with an RCEC device,
> there needs to be a way to update the Root Error Status, the Uncorrectable
> Error Status and the Uncorrectable Error Severity of the parent RCEC.
> So add the 'rcec' field to the pci_dev structure and provide a hook for the
> Root Port Driver to associate RCiEPs with their respective parent RCEC.

> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -202,6 +202,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  		pci_walk_dev_affected(dev, report_frozen_detected, &status);
>  		if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
>  			status = flr_on_rciep(dev);
> +			/*
> +			 * The callback only clears the Root Error Status
> +			 * of the RCEC (see aer.c).
> +			 */
> +			if (dev->rcec)
> +				reset_link(dev->rcec);
>  			if (status != PCI_ERS_RESULT_RECOVERED) {
>  				pci_warn(dev, "function level reset failed\n");
>  				goto failed;
> @@ -245,7 +251,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	     pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)) {
>  		pci_aer_clear_device_status(dev);
>  		pci_aer_clear_nonfatal_status(dev);
> +	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END && dev->rcec) {
> +		pci_aer_clear_device_status(dev->rcec);
> +		pci_aer_clear_nonfatal_status(dev->rcec);

Conceptually, I'm not sure why we need the dev->rcec link.  The error
was *reported* via the RCEC, so don't we know the RCEC up front,
before we even identify the RCiEP?  Can't we just remember that and
dispense with dev->rcec?

I'm also concerned that if we fail to identify the RCiEP (i.e., we
don't have a valid "dev" to use dev->rcec), we will fail to clear the
error status bits.  I think it's possible that the RCEC will report an
error, but the RCiEP that generated the error message is not
responding so we can't find it.

>  	}
> +
>  	pci_info(dev, "device recovery successful\n");
>  	return status;
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index d5b109499b10..a64e88b7166b 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -90,6 +90,18 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>  #define PCIE_PORTDRV_PM_OPS	NULL
>  #endif /* !PM */
>  
> +static int pcie_hook_rcec(struct pci_dev *pdev, void *data)
> +{
> +	struct pci_dev *rcec = (struct pci_dev *)data;
> +
> +	pdev->rcec = rcec;
> +	pci_dbg(rcec, "RCiEP(under an RCEC) %04x:%02x:%02x.%d\n",
> +		pci_domain_nr(pdev->bus), pdev->bus->number,
> +		PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));

If we do need dev->rcec, this should use pci_name() for the second
device instead of formatting the name manually.  I think I would
connect this with the RCiEP instead of the RCEC, e.g.,

  pci_dbg(pdev, "PME & error events reported via %s\n", pci_name(rcec));

> +
> +	return 0;
> +}
> +
>  /*
>   * pcie_portdrv_probe - Probe PCI-Express port devices
>   * @dev: PCI-Express port device being probed
> @@ -110,6 +122,9 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	     (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC)))
>  		return -ENODEV;
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(dev, pcie_hook_rcec, dev);
> +
>  	status = pcie_port_device_register(dev);
>  	if (status)
>  		return status;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c7fc5726872c..ba29816c827b 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -330,6 +330,7 @@ struct pci_dev {
>  #ifdef CONFIG_PCIEPORTBUS
>  	u16		rcec_cap;	/* RCEC capability offset */
>  	struct rcec_ext *rcec_ext;	/* RCEC cached assoc. endpoint extended capabilities */
> +	struct pci_dev	*rcec;		/* Associated RCEC device */
>  #endif
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */
> -- 
> 2.28.0
> 
