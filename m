Return-Path: <linux-pci+bounces-32323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15BB07E0F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 21:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBB2A44E11
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A2029B20C;
	Wed, 16 Jul 2025 19:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsTgLPKP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBC928B4EF
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752694453; cv=none; b=tely/Am4Kh41Nnzz70+TnZB3e6rn005vyEu9BGWPN0+5A9VzkgfyaoDZkKQqJdYktNW8vazQyd/rN7Cz4jsjESbKY7GHlbGMRbR3RY6+QllukuvQhJR6dJQEbZDNLkHInnb67pwHVY2dQ6NblgSTTqBQZrooJJwUS8uYV4vURx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752694453; c=relaxed/simple;
	bh=AkZ+rqhw910Z5Pjt5OkYFp3LJGm6Dlmkaj7iDiGoEH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bPEpLkGKO/KQUCC0Nuwk/vglNet5jHDC/2St7iJtVbEP50EiNLtrgkEuOz2W9hJlA7ny5MxYgP+3nUWDYDmQro3GbFqH/BQyFons54bLHEEuiwTlUZb+T/vzWGR9SIa8plC+rSUzZyOD8N38RhJOLEhZBcgPjGhKOqGJewn1cQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsTgLPKP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE5EC4CEE7;
	Wed, 16 Jul 2025 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752694452;
	bh=AkZ+rqhw910Z5Pjt5OkYFp3LJGm6Dlmkaj7iDiGoEH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TsTgLPKPuw3MmH8gQbEgLwiXQSGQ9xg13L5GQ/6SiBnxUAkPX2Bx3AoFji00YtDiB
	 Rd+3ZSEiSr0iYt/ysvUnCksIhDC35PI6TZiutkMLHfn7DeLlFbLGQ02PAz2VQQyz0Z
	 poeAtc3F9MA64Pe4meRNlg83WJUDBzTC+cspaLtQdrJv6F3VB5IpOcBYLj+DjQoaNS
	 4WlL1oSUTSwEM8KfDRbxWJ4Ddv8MuS1BVMypJkzLgVbxzzaW8I/hh3OC9kISR9Vr5/
	 v+UnnNXqQg+XpxOKnnUAEZRnMGylCuVBT6QPA+5NnfJjkxZby5cv4Y10JTXjwUfBYl
	 wdgLrwqoCAUVQ==
Date: Wed, 16 Jul 2025 14:34:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, ashishk@purestorage.com,
	macro@orcam.me.uk, bamstadt@purestorage.com, msaggi@purestorage.com,
	sconnor@purestorage.com
Subject: Re: [PATCH 1/1] PCI: Add CONFIG_PCI_NOSPEED_QUIRK to remove
 pcie_failed_link_retrain
Message-ID: <20250716193411.GA2551185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716190206.15269-2-mattc@purestorage.com>

On Wed, Jul 16, 2025 at 01:02:06PM -0600, Matthew W Carlis wrote:
> It is desirable to be able to remove pcie_failed_link_retrain for some
> systems which are known to have PCIe devices with good LTSSM behavior
> or a high degree of compatibility and which may be required to endure
> large numbers of hot-plug events or DPC triggers & always arrive at the
> maximum link speed. It appears that there is a degree of variability
> in DSP/RP behavior in terms of setting the LBMS bit & therefore
> difficult to tune pcie_failed_link_retrain with a very high degree
> of accuracy in terms of never forcing a device to Gen1 that would
> be able to arrive at its maximum speed on its own.
> 
> Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
> ---
>  drivers/pci/Kconfig  | 9 +++++++++
>  drivers/pci/pci.h    | 8 +++++++-
>  drivers/pci/quirks.c | 3 +++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9c0e4aaf4e8c..8f01808231f7 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -68,6 +68,15 @@ config PCI_QUIRKS
>  	  Disable this only if your target machine is unaffected by PCI
>  	  quirks.
>  
> +config PCI_NOSPEED_QUIRK
> +	default n
> +	bool "Remove forced Gen1 link speed Gen1 quirk" if EXPERT
> +	help
> +	  This disables a workaround that will guide the PCIe link to
> +	  2.5GT/s speed if it thinks the link has failed to train. Enable
> +	  this if you think this workaround is forcing the link to 2.5GT/s
> +	  when it should not.

This seems awfully specific to me, really too specific to carry in the
upstream tree.  pcie_failed_link_retrain() is itself ridiculously
specific, and I'm not sure we should even keep carrying that.

Maybe we should just accept that broken hardware exists and add quirks
to limit link speed or tell the user to buy a working device.

>  config PCI_DEBUG
>  	bool "PCI Debugging"
>  	depends on DEBUG_KERNEL
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..51fddc6419f3 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -785,7 +785,6 @@ void pci_acs_init(struct pci_dev *dev);
>  int pci_dev_specific_acs_enabled(struct pci_dev *dev, u16 acs_flags);
>  int pci_dev_specific_enable_acs(struct pci_dev *dev);
>  int pci_dev_specific_disable_acs_redir(struct pci_dev *dev);
> -int pcie_failed_link_retrain(struct pci_dev *dev);
>  #else
>  static inline int pci_dev_specific_acs_enabled(struct pci_dev *dev,
>  					       u16 acs_flags)
> @@ -800,11 +799,18 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>  {
>  	return -ENOTTY;
>  }
> +#endif
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +#ifndef CONFIG_PCI_NOSPEED_QUIRK
> +int pcie_failed_link_retrain(struct pci_dev *dev);
> +#else
>  static inline int pcie_failed_link_retrain(struct pci_dev *dev)
>  {
>  	return -ENOTTY;
>  }
>  #endif
> +#endif
>  
>  /* PCI error reporting and recovery */
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 39bb0c025119..d2d06f9ec983 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -36,6 +36,8 @@
>  #include <linux/switchtec.h>
>  #include "pci.h"
>  
> +#ifndef CONFIG_PCI_NOSPEED_QUIRK
> +
>  static bool pcie_lbms_seen(struct pci_dev *dev, u16 lnksta)
>  {
>  	if (test_bit(PCI_LINK_LBMS_SEEN, &dev->priv_flags))
> @@ -140,6 +142,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  
>  	return ret;
>  }
> +#endif
>  
>  static ktime_t fixup_debug_start(struct pci_dev *dev,
>  				 void (*fn)(struct pci_dev *dev))
> -- 
> 2.46.0
> 

