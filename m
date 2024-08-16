Return-Path: <linux-pci+bounces-11776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49E9955347
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2024 00:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBF2284716
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD60146593;
	Fri, 16 Aug 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvu/5YR7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DDE14601F;
	Fri, 16 Aug 2024 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723847283; cv=none; b=d1c65sxPg+LOncK+OBW0qOv8LgJOxRcLmLDk5SnR4vvVyyiY0Ik1Q8CwyscucjidmTcweP70+uUPwPDNDjhKLGCvou3VtowyoFZDveefGsGHwnKR7yWlJAoy2ZRO0b5XJnsMiljx7omIU3/pxyXF5wTAVolpzsFnQP61ygbSR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723847283; c=relaxed/simple;
	bh=Ii6inpTZ7GQIaMzsYLjbWaMhIjmeyAuIup9P1I702SM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ddpz0LOQtovsdKutPkczFWa1eiPOnwV2esX1XrPp0Xj9EbKaqExbbyaUDD9dfgkNM2/xujeVKIO23C/gJWVzZE/AlfPfaQPCvJsE9KdBlwIZqNW9Y0zblERJCwZkNbcbZj2boFcigCdIq0EdRZYJDycq3veaJxYdO7Rl8KcrBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvu/5YR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B00C4AF0B;
	Fri, 16 Aug 2024 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723847283;
	bh=Ii6inpTZ7GQIaMzsYLjbWaMhIjmeyAuIup9P1I702SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mvu/5YR7UaxzeH1bqhwRMHUSfgEAKJ7xmabU/kWfGssvm0ceitzSdWxMySZtrQKKm
	 BQsvhgj/V6lQvSBvt1yj2uUDSUGx1lmgvAA+sfzb3Kf1XOZQVeynnDHfLIBOBEfomx
	 3SAUXBjPW2djVzCjjQfQB3Tf44CHF9B5NZXOtV9wqw0gipdmwY6RAmellUz7YyvzXA
	 vWqajQmTOecR84wtV42Ny9/ZClkCx4US+hEJF+tonjXneVYsdirv0WUrgmAaOt+Rpt
	 0suegb73TZaUwTSzM6pWMsISykj91/Xky7q5Q7Bf8ekRuhORg+8q62/aw6bDTDKyCx
	 PLyyvCwAp/DCw==
Date: Fri, 16 Aug 2024 17:28:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, nirmal.patel@linux.intel.com,
	jonathan.derrick@linux.dev, ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com
Subject: Re: [PATCH 1/2] PCI: ASPM: Allow OS to configure ASPM where BIOS is
 incapable of
Message-ID: <20240816222800.GA75500@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530085227.91168-1-kai.heng.feng@canonical.com>

On Thu, May 30, 2024 at 04:52:26PM +0800, Kai-Heng Feng wrote:
> Since commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM
> and LTR"), ASPM is configured for NVMe devices enabled in VMD domain.
> 
> However, that doesn't cover the case when FADT has ACPI_FADT_NO_ASPM
> set.
> 
> So add a new attribute to bypass aspm_disabled so OS can configure ASPM.
> 
> Fixes: f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and LTR")
> Link: https://lore.kernel.org/linux-pm/218aa81f-9c6-5929-578d-8dc15f83dd48@panix.com/
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/pcie/aspm.c | 8 ++++++--
>  include/linux/pci.h     | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index cee2365e54b8..e719605857b1 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1416,8 +1416,12 @@ static int __pci_enable_link_state(struct pci_dev *pdev, int state, bool locked)
>  	 * the _OSC method), we can't honor that request.
>  	 */
>  	if (aspm_disabled) {
> -		pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
> -		return -EPERM;
> +		if (aspm_support_enabled && pdev->aspm_os_control)
> +			pci_info(pdev, "BIOS can't program ASPM, let OS control it\n");
> +		else {
> +			pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
> +			return -EPERM;

1) I dislike having this VMD-specific special case in the generic
code.

2) I think the "BIOS can't program ASPM ..." message is a little bit
misleading.  We're making the assumption that BIOS doesn't know about
devices below the VMD bridge, but we really don't know that.  BIOS
*could* have a VMD driver, and it could configure ASPM below the VMD.
We're just assuming that it doesn't.

It's also a little bit too verbose -- I think we get this message for
*every* device below VMD?  Maybe the vmd driver could print something
about ignoring the ACPI FADT "PCIe ASPM Controls" bit once per VMD?
Then it's clearly connected to something firmware folks know about.

3) The code ends up looking like this:

  if (aspm_disabled) {
    if (aspm_support_enabled && pdev->aspm_os_control)
      pci_info(pdev, "BIOS can't program ASPM, let OS control it\n");
    else {
      pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
      return -EPERM;
    }
  }

and I think it's confusing to check "aspm_support_enabled" and
"pdev->aspm_os_control" after we've already decided that ASPM is
sort of disabled by "aspm_disabled".

Plus, we're left with questions about all the *other* tests of
"aspm_disabled" in pcie_aspm_sanity_check(),
pcie_aspm_pm_state_change(), pcie_aspm_powersave_config_link(),
__pci_disable_link_state(), etc.  Why do they *not* need this change?

And what about pcie_aspm_init_link_state()?  Why doesn't *it* pay
attention to "aspm_disabled"?  It's all very complicated.

This is similar in some ways to native_aer, native_pme, etc., which we
negotiate with _OSC.  I wonder if we could make something similar for
this, since it's another case where we want to make something specific
to a host bridge instead of global.

> +		}
>  	}
>  
>  	if (!locked)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fb004fd4e889..58cbd4bea320 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -467,6 +467,7 @@ struct pci_dev {
>  	unsigned int	no_command_memory:1;	/* No PCI_COMMAND_MEMORY */
>  	unsigned int	rom_bar_overlap:1;	/* ROM BAR disable broken */
>  	unsigned int	rom_attr_enabled:1;	/* Display of ROM attribute enabled? */
> +	unsigned int	aspm_os_control:1;	/* Display of ROM attribute enabled? */

Comment is wrong (but I hope we can avoid a per-device bit anyway).

>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> -- 
> 2.43.0
> 

