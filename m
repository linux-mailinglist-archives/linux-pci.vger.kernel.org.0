Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFBF1313D3
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 15:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgAFOie (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 09:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgAFOie (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 09:38:34 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16A0220731;
        Mon,  6 Jan 2020 14:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578321513;
        bh=FesBo1upHM+kuo7tXW02SAn+zVTYT92KHE4R6S1mh88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LzWHqUnIiFJpaDWbx/gEgjkBNW8J4uabH0xBLBr1E1CCPnySXqNsdTH+XTEuhddZy
         Bh5LyRZCqTYqcQguTIOVzWLW1cSr3Il0Da4wwHC3ZU3VPczDtEO/PpYketnxxt2X8w
         IFYIFYnRxdSPQL7O6ugK16LxIE/7RKIR7wlMmdII=
Date:   Mon, 6 Jan 2020 08:38:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: pci: Clear ACS state at kexec
Message-ID: <20200106143832.GA108920@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104225149.27342-1-deepa.kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 04, 2020 at 02:51:49PM -0800, Deepa Dinamani wrote:
> ACS bits remain sticky through kexec reset. This is not really a
> problem for Linux because turning IOMMU on assumes ACS on. But,
> this becomes a problem if we kexec into something other than
> Linux and that does not turn ACS on always.

"Sticky" in the PCIe spec specifically describes bits that are
unaffected by hot reset or FLR (see PCIe r5.0, sec 7.4), but the
PCI_ACS_CTRL register contains no RWS bits, so I don't think that's
what you mean here.

I suspect you mean something like "kexec doesn't reset the device, so
the new kernel inherits the PCI_ACS_CTRL settings from Linux"?

So it looks like you're unconditionally disabling ACS during kexec.
The comment in pci_enable_acs() suggests that ACS may have been
enabled by platform firmware.  Maybe we should *restore* the original
ACS settings from before Linux enabled ACS rather than clearing them?

> Reset the ACS bits to default before kexec or device remove.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  drivers/pci/pci-driver.c |  4 ++++
>  drivers/pci/pci.c        | 39 +++++++++++++++++++++++++++------------
>  drivers/pci/pci.h        |  1 +
>  3 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..bd8d08e50b97 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -453,6 +453,8 @@ static int pci_device_remove(struct device *dev)
>  
>  	/* Undo the runtime PM settings in local_pci_probe() */
>  	pm_runtime_put_sync(dev);
> +	/* Undo the PCI ACS settings in pci_init_capabilities() */
> +	pci_disable_acs(pci_dev);

Can this be a separate patch?  It doesn't seem to have anything to do
with kexec, so a different patch with (presumably) a different
rationale would be good.

>  	/*
>  	 * If the device is still on, set the power state as "unknown",
> @@ -493,6 +495,8 @@ static void pci_device_shutdown(struct device *dev)
>  	 */
>  	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
>  		pci_clear_master(pci_dev);
> +	if (kexec_in_progress)
> +		pci_disable_acs(pci_dev);

Shouldn't this be in the same "if" block as pci_clear_master()?  If
the device is in D3cold, it's not going to work to disable ACS because
config space isn't accessible.

>  }
>  
>  #ifdef CONFIG_PM
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index da2e59daad6f..8254617cff03 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3261,15 +3261,23 @@ static void pci_disable_acs_redir(struct pci_dev *dev)
>  	pci_info(dev, "disabled ACS redirect\n");
>  }
>  
> +
> +/* Standard PCI ACS capailities
> + * Source Validation | P2P Request Redirect | P2P Completion Redirect | Upstream Forwarding

Please make this comment fit in 80 columns.

> + */
> +#define PCI_STD_ACS_CAP (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_UF)
> +
>  /**
> - * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
> + * pci_std_enable_disable_acs - enable/disable ACS on devices using standard
> + * ACS capabilities
>   * @dev: the PCI device
>   */
> -static void pci_std_enable_acs(struct pci_dev *dev)
> +static void pci_std_enable_disable_acs(struct pci_dev *dev, int enable)

Maybe you could split this refactoring into its own patch that doesn't
actually change any behavior?  Then the kexec patch would be a
one-liner and the device remove patch would be another one-liner, so
it's obvious where the important changes are.

>  {
>  	int pos;
>  	u16 cap;
>  	u16 ctrl;
> +	u16 val = 0;
>  
>  	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ACS);
>  	if (!pos)
> @@ -3278,19 +3286,26 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>  	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
>  	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
>  
> -	/* Source Validation */
> -	ctrl |= (cap & PCI_ACS_SV);
> +	val = (cap & PCI_STD_ACS_CAP);
>  
> -	/* P2P Request Redirect */
> -	ctrl |= (cap & PCI_ACS_RR);
> +	if (enable)
> +		ctrl |= val;
> +	else
> +		ctrl &= ~val;
>  
> -	/* P2P Completion Redirect */
> -	ctrl |= (cap & PCI_ACS_CR);
> +	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +}
>  
> -	/* Upstream Forwarding */
> -	ctrl |= (cap & PCI_ACS_UF);
> +/**
> + * pci_disable_acs - enable ACS if hardware support it

s/enable/disable/ (in comment)
s/support/supports/

> + * @dev: the PCI device
> + */
> +void pci_disable_acs(struct pci_dev *dev)
> +{
> +	if (pci_acs_enable)
> +		pci_std_enable_disable_acs(dev, 0);
>  
> -	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> +	pci_disable_acs_redir(dev);
>  }
>  
>  /**
> @@ -3305,7 +3320,7 @@ void pci_enable_acs(struct pci_dev *dev)
>  	if (!pci_dev_specific_enable_acs(dev))
>  		goto disable_acs_redir;
>  
> -	pci_std_enable_acs(dev);
> +	pci_std_enable_disable_acs(dev, 1);
>  
>  disable_acs_redir:
>  	/*
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 6394e7746fb5..480e4de46fa8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -526,6 +526,7 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
>  }
>  
>  void pci_enable_acs(struct pci_dev *dev);
> +void pci_disable_acs(struct pci_dev *dev);
>  #ifdef CONFIG_PCI_QUIRKS
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
> -- 
> 2.17.1
> 
