Return-Path: <linux-pci+bounces-40284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35205C32BA0
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 20:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B331C189B27D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 19:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261693321B9;
	Tue,  4 Nov 2025 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZQ5WhPe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3352EC097;
	Tue,  4 Nov 2025 19:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762283031; cv=none; b=nKcsjLg//noyWn9YYEfoVxfy1XqIT/H5F1viOBaImrx/KWUFWc/XotNfSk0RfFctQmv68BB3oecEuwRZMJQ1PPyBPPrlyKTQnrhReq3zJEA8gXTzOpBqan06wE8nVdQV07fMABYz6nP95yiwR30pDlPDSVSiEoAfwJ2pgPXAivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762283031; c=relaxed/simple;
	bh=FtgggpqbNGjSWPdIdf3hIlTuRws7DAmDVOCHpryft4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b/MzLYj7GKxYESBy4/cFxohPXJcrjX5prQ1FNpxfcFMJ/lu75ZZY+ddge9nbbqo/mbSyFaV4yy7a1/dcVZ4TUH64rdTBxDguCHSh/OzbBX6NIbcoILQCoy/6RyhBcqaiCCXEwRbcP2nMsuNxYNfpobKzK6iFdbcK/OJWnmU/ehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZQ5WhPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D34DC4CEF7;
	Tue,  4 Nov 2025 19:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762283029;
	bh=FtgggpqbNGjSWPdIdf3hIlTuRws7DAmDVOCHpryft4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NZQ5WhPepNKuN3+vz/qpL5DIvgOD7Q3mvRS7jLazvqBUAtYFCxNWAnuMqqOrO4MHH
	 VMYd+H2VjMD6luWFGI9PhZaJHT5eO0cBCznd5uLDmrFXlT1P1nRrSLtIYtZMrNOPR1
	 D9BabXCvSNVklXKI0ongOL4VO0wCjJRfltg5zlfj+i55O6mD3PESOEcEmLLQ7rgw1z
	 /ov+QQHaYk6xQVgRQNpotzkG1/K50htYLIA8Lj8DFbYIHaPsgjVdJJ7/Aca+kgj0eK
	 OxNj6q6yR7HcLohGVNg4q48YGuhFhKem6hWW+roBQZjVZ6S3vp81OO0/oA4lKdGyPz
	 5X7T+3Lu52B1w==
Date: Tue, 4 Nov 2025 13:03:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RESEND v13 22/25] CXL/PCI: Export and rename merge_result() to
 pci_ers_merge_result()
Message-ID: <20251104190348.GA1865266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104170305.4163840-23-terry.bowman@amd.com>

On Tue, Nov 04, 2025 at 11:03:02AM -0600, Terry Bowman wrote:
> CXL uncorrectable errors (UCE) will soon be handled separately from the PCI
> AER handling. The merge_result() function can be made common to use in both
> handling paths.
> 
> Rename the PCI subsystem's merge_result() to be pci_ers_merge_result().
> Export pci_ers_merge_result() to make available for the CXL and other
> drivers to use.
> 
> Update pci_ers_merge_result() to support recently introduced PCI_ERS_RESULT_PANIC
> result.

Seems like this merge_result() change maybe should be in the same
patch that added PCI_ERS_RESULT_PANIC?  That would also solve the
problem that the subject line doesn't mention this important
functional change.

I haven't seen the user(s) of pci_ers_merge_result() yet, but this
seems like it might be a little too low level to be exported to
modules and in include/linux/pci.h.  Maybe there's no other way.

Wrap commit log to fit in 75 columns.

Suggest possible subject prefix of "PCI/ERR" since the only CXL
connection is that you want to *use* this from CXL.

> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---
> 
> Changes in v12->v13:
> - Renamed pci_ers_merge_result() to pcie_ers_merge_result().
>   pci_ers_merge_result() is already used in eeh driver. (Bot)
> 
> Changes in v11->v12:
> - Remove static inline pci_ers_merge_result() definition for !CONFIG_PCIEAER.
>   Is not needed. (Lukas)
> 
> Changes in v10->v11:
> - New patch
> - pci_ers_merge_result() - Change export to non-namespace and rename
>   to be pci_ers_merge_result()
> - Move pci_ers_merge_result() definition to pci.h. Needs pci_ers_result
> ---
>  drivers/pci/pcie/err.c | 14 +++++++++-----
>  include/linux/pci.h    |  7 +++++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index bebe4bc111d7..9394bbdcf0fb 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -21,9 +21,12 @@
>  #include "portdrv.h"
>  #include "../pci.h"
>  
> -static pci_ers_result_t merge_result(enum pci_ers_result orig,
> -				  enum pci_ers_result new)
> +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
> +				       enum pci_ers_result new)
>  {
> +	if (new == PCI_ERS_RESULT_PANIC)
> +		return PCI_ERS_RESULT_PANIC;
> +
>  	if (new == PCI_ERS_RESULT_NO_AER_DRIVER)
>  		return PCI_ERS_RESULT_NO_AER_DRIVER;
>  
> @@ -45,6 +48,7 @@ static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  
>  	return orig;
>  }
> +EXPORT_SYMBOL(pcie_ers_merge_result);
>  
>  static int report_error_detected(struct pci_dev *dev,
>  				 pci_channel_state_t state,
> @@ -81,7 +85,7 @@ static int report_error_detected(struct pci_dev *dev,
>  		vote = err_handler->error_detected(dev, state);
>  	}
>  	pci_uevent_ers(dev, vote);
> -	*result = merge_result(*result, vote);
> +	*result = pcie_ers_merge_result(*result, vote);
>  	device_unlock(&dev->dev);
>  	return 0;
>  }
> @@ -139,7 +143,7 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
>  
>  	err_handler = pdrv->err_handler;
>  	vote = err_handler->mmio_enabled(dev);
> -	*result = merge_result(*result, vote);
> +	*result = pcie_ers_merge_result(*result, vote);
>  out:
>  	device_unlock(&dev->dev);
>  	return 0;
> @@ -159,7 +163,7 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
>  
>  	err_handler = pdrv->err_handler;
>  	vote = err_handler->slot_reset(dev);
> -	*result = merge_result(*result, vote);
> +	*result = pcie_ers_merge_result(*result, vote);
>  out:
>  	device_unlock(&dev->dev);
>  	return 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 33d16b212e0d..d3e3300f79ec 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1887,9 +1887,16 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
>  #ifdef CONFIG_PCIEAER
>  bool pci_aer_available(void);
>  void pcie_clear_device_status(struct pci_dev *dev);
> +pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
> +				       enum pci_ers_result new);
>  #else
>  static inline bool pci_aer_available(void) { return false; }
>  static inline void pcie_clear_device_status(struct pci_dev *dev) { }
> +static inline pci_ers_result_t pcie_ers_merge_result(enum pci_ers_result orig,
> +						     enum pci_ers_result new)
> +{
> +	return PCI_ERS_RESULT_NONE;
> +}
>  #endif
>  
>  bool pci_ats_disabled(void);
> -- 
> 2.34.1
> 

