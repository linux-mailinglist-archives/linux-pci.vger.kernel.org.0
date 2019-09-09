Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E879AD810
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2019 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbfIILle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Sep 2019 07:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbfIILle (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Sep 2019 07:41:34 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 582BA218AF;
        Mon,  9 Sep 2019 11:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568029292;
        bh=UIBpQL4IyoiRivShLSPvpPLy/w0INLuoSj765Ms5he4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUsN32R35u2UBRj2lHEcA9H44gsX3xq+T5JpQmqDZWfJa1FKtItfngp9xYD5JwbTx
         xrTzIzCNrmEsodCvE2TC1jZyOwtkUb0qNP8keMHS8wjJkqKG+aRjDmBg1y7di6ZbHG
         vjxrtpyNpkPBkeyHRqWC/dCmpSrudREk4MBNKyFI=
Date:   Mon, 9 Sep 2019 06:41:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     tiwai@suse.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
Message-ID: <20190909114129.GT103977@google.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827134756.10807-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Maybe:

  PCI: Add pci_pr3_present() to check for Power Resources for D3hot

On Tue, Aug 27, 2019 at 09:47:55PM +0800, Kai-Heng Feng wrote:
> A driver may want to know the existence of _PR3, to choose different
> runtime suspend behavior. A user will be add in next patch.

Maybe include something like this in the commit lot?

  Add pci_pr3_present() to check whether the platform supplies _PR3 to
  tell us which power resources the device depends on when in D3hot.

> This is mostly the same as nouveau_pr3_present().
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pci.c   | 20 ++++++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1b27b5af3d55..776af15b92c2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5856,6 +5856,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  	return 0;
>  }
>  
> +bool pci_pr3_present(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
> +	struct acpi_device *parent_adev;
> +
> +	if (acpi_disabled)
> +		return false;
> +
> +	if (!parent_pdev)
> +		return false;
> +
> +	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
> +	if (!parent_adev)
> +		return false;
> +
> +	return parent_adev->power.flags.power_resources &&
> +		acpi_has_method(parent_adev->handle, "_PR3");

I think this is generally OK, but it doesn't actually check whether
*pdev* has a _PR3; it checks whether pdev's *parent* does.  So does
that mean this is dependent on the GPU topology, i.e., does it assume
that there is an upstream bridge and that power for everything under
that bridge can be managed together?

I'm wondering whether the "parent_pdev = pci_upstream_bridge()" part
should be in the caller rather than in pci_pr3_present()?

I can't connect any of the dots from _PR3 through to
"need_eld_notify_link" (whatever "eld" is :)) and the uses of
hda_intel.need_eld_notify_link (and needs_eld_notify_link()).

But that's beyond the scope of *this* patch and it makes sense that
you do want to discover the _PR3 existence, so I'm fine with this once
we figure out the pdev vs parent question.

> +}
> +EXPORT_SYMBOL_GPL(pci_pr3_present);
> +
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 82e4cd1b7ac3..9b6f7b67fac9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
>  
>  void
>  pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
> +bool pci_pr3_present(struct pci_dev *pdev);
>  #else
>  static inline struct irq_domain *
>  pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
> +static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_EEH
> -- 
> 2.17.1
> 
