Return-Path: <linux-pci+bounces-27228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09281AAAF64
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 05:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA7C3AB2DC
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 03:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93133B358F;
	Mon,  5 May 2025 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLb11n0X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9766F396ED6
	for <linux-pci@vger.kernel.org>; Mon,  5 May 2025 23:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486395; cv=none; b=dESOXoYatd5wF51LZSBo+VHDoUFyDpbECM0QmOZsO4/355jPaaDFLX8IUGyTCPF39TbQpkC0xyxJ+e6NGIhcAT1PXiNs+HfpmO4hl0PPLq2agMcsuoydrqwamdSqvRdsxL0d0qC4hmOTE5/03hbXHoSxNjQ1wSsdir/vUGkiGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486395; c=relaxed/simple;
	bh=+ng9IX5PYlTkr54csTUOeVzsQtO8Dt8p+/RHtisF7xk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G+wz6znQ6Bo6fldygWAyMmhfR1dUpTiv081HaWu5YPVwvSrGRbdq6XKDoOp3kkZoRa0EGZbabfHH2h4rI+nKvd47Z8rBNWIFHlfoo4esbHp4ey1klVxBl6sBRG8XwhOU7zBddxXmgKLcZLDioKogxNew2fNb7MMgsS9jaivNUWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLb11n0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61094C4CEED;
	Mon,  5 May 2025 23:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486394;
	bh=+ng9IX5PYlTkr54csTUOeVzsQtO8Dt8p+/RHtisF7xk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rLb11n0XTrGYcIEfiRAkY6OFLnTohFdA3yK73ccWKsIdcSd/dUb1O50XPVHckd64d
	 cEiX/hHeI0P+FXBVK/KIMmMoUNR+59iruHvBfN4jnV9JakrvaKD7berContfufhSuz
	 YvYe4G7R8eeztOZMFpZtqPqwbAL47D28HdgmvQFwdTzo94S5SVfXIhwErd3FVl9V9d
	 ZbK6TpoGy/987zwCC31tXR6K9dlGUMlPdxPIf8mafzsccUM+91MprGwL7uqwJOVIqE
	 h/Xrzyu0pKrDucNnQl9IES+11q2HWeQHXbMzQdTV5D2Lo5bAQvjVb4UlkcCiOhnkci
	 4Dc1ZLvO6g29w==
Date: Mon, 5 May 2025 18:06:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, bhelgaas@google.com,
	rafael.j.wysocki@intel.com, huang.ying.caritas@gmail.com,
	stern@rowland.harvard.edu, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Explicitly put devices into D0 when initializing
Message-ID: <20250505230632.GA1007257@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424043232.1848107-1-superm1@kernel.org>

On Wed, Apr 23, 2025 at 11:31:32PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> AMD BIOS team has root caused an issue that NVME storage failed to come
> back from suspend to a lack of a call to _REG when NVME device was probed.
> 
> commit 112a7f9c8edbf ("PCI/ACPI: Call _REG when transitioning D-states")
> added support for calling _REG when transitioning D-states, but this only
> works if the device actually "transitions" D-states.
> 
> commit 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI
> devices") added support for runtime PM on PCI devices, but never actually
> 'explicitly' sets the device to D0.
> 
> To make sure that devices are in D0 and that platform methods such as
> _REG are called, explicitly set all devices into D0 during initialization.
> 
> Fixes: 967577b062417 ("PCI/PM: Keep runtime PM enabled for unbound PCI devices")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Applied to pci/pm for v6.16, thanks!

> ---
> v2:
>  * Move runtime PM calls after setting to D0
>  * Use pci_pm_power_up_and_verify_state()
> ---
>  drivers/pci/pci-driver.c |  6 ------
>  drivers/pci/pci.c        | 13 ++++++++++---
>  drivers/pci/pci.h        |  1 +
>  3 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index c8bd71a739f72..082918ce03d8a 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -555,12 +555,6 @@ static void pci_pm_default_resume(struct pci_dev *pci_dev)
>  	pci_enable_wake(pci_dev, PCI_D0, false);
>  }
>  
> -static void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> -{
> -	pci_power_up(pci_dev);
> -	pci_update_current_state(pci_dev, PCI_D0);
> -}
> -
>  static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
>  {
>  	pci_pm_power_up_and_verify_state(pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e77d5b53c0cec..8d125998b30b7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3192,6 +3192,12 @@ void pci_d3cold_disable(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_d3cold_disable);
>  
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev)
> +{
> +	pci_power_up(pci_dev);
> +	pci_update_current_state(pci_dev, PCI_D0);
> +}
> +
>  /**
>   * pci_pm_init - Initialize PM functions of given PCI device
>   * @dev: PCI device to handle.
> @@ -3202,9 +3208,6 @@ void pci_pm_init(struct pci_dev *dev)
>  	u16 status;
>  	u16 pmc;
>  
> -	pm_runtime_forbid(&dev->dev);
> -	pm_runtime_set_active(&dev->dev);
> -	pm_runtime_enable(&dev->dev);
>  	device_enable_async_suspend(&dev->dev);
>  	dev->wakeup_prepared = false;
>  
> @@ -3266,6 +3269,10 @@ void pci_pm_init(struct pci_dev *dev)
>  	pci_read_config_word(dev, PCI_STATUS, &status);
>  	if (status & PCI_STATUS_IMM_READY)
>  		dev->imm_ready = 1;
> +	pci_pm_power_up_and_verify_state(dev);
> +	pm_runtime_forbid(&dev->dev);
> +	pm_runtime_set_active(&dev->dev);
> +	pm_runtime_enable(&dev->dev);
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62a..49165b739138b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -148,6 +148,7 @@ void pci_dev_adjust_pme(struct pci_dev *dev);
>  void pci_dev_complete_resume(struct pci_dev *pci_dev);
>  void pci_config_pm_runtime_get(struct pci_dev *dev);
>  void pci_config_pm_runtime_put(struct pci_dev *dev);
> +void pci_pm_power_up_and_verify_state(struct pci_dev *pci_dev);
>  void pci_pm_init(struct pci_dev *dev);
>  void pci_ea_init(struct pci_dev *dev);
>  void pci_msi_init(struct pci_dev *dev);
> -- 
> 2.43.0
> 

