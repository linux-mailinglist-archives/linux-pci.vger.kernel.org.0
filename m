Return-Path: <linux-pci+bounces-32465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D2B096F5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 00:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15AF83BCF6F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 22:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9564D238152;
	Thu, 17 Jul 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IOAl88kX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC97224B09;
	Thu, 17 Jul 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791714; cv=none; b=oXkufKUTZp1DSHpJchg5iQfRTFaWjsvMJKyyqypG/fKbrILnjfK0ZFQ+Aqjotd6PoTwQWeJUfaohYgcpLQJBopPvwJ6qV5JTTiLh0EPgOx1lF5pH5ogkV5mkLB2U0fahMOsEKRyMJ9/ULWz/vaAFsWWrKMbgUVVDcwTnlpG6SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791714; c=relaxed/simple;
	bh=AcG89q44N75jkC0nwSdCQtJW9mEHeTqXIylkV6w+AME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvkb7MGweeMNJ+3eDsV9g3pE4Mf3L6z8S2v5td9iLOX9sVOietNvwDSpSjwJlqnXum/DJcVDljtWBOPtGaLndhHLjSOkLsJjsVyCM3JfLm9UBryzLeYHoRmvFY0YnmjbgCEdbZ5eCPmKHG/XuQQ/IVPKK/dwF7XbQ5nHyWc3q44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IOAl88kX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752791714; x=1784327714;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AcG89q44N75jkC0nwSdCQtJW9mEHeTqXIylkV6w+AME=;
  b=IOAl88kX0NuutnwNuEOE8+dRAu9tw6YHwuvI2mCvJqlRAaxuCz+3FmGQ
   I8Otfa1QdqaX1HdwF8YX3fjIPa1seCU+zQ+0vFl27taCYIp79penp8KNd
   siwEt58VKr58wcnW0rHOlLy2bPN7CB6CwVgUSSBomqrWOsW0dzadOnpFw
   FDCrR2AQenMpV78CWqmR9qogTmu2Mxhv38ZGIVX0TA+DbCNwIKAHroGfb
   5V8qwnQS7NMdQ4KUqGKYYbzlMHjbptWT/oRjpa/JuUbNXWMYpo0WytOPT
   i2ZT4e7+K6dTdwCsAPE4y2KsHzMijq+5tGaWe/Zp0pDUM3KnYLUymKEpR
   g==;
X-CSE-ConnectionGUID: FSkp1TidShqKMLL3nUIAdA==
X-CSE-MsgGUID: Cp7GtIJiTeSbenZeCCFn/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="65773697"
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="65773697"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 15:35:12 -0700
X-CSE-ConnectionGUID: ROwT5RWQQvCcgZSuD1KWxg==
X-CSE-MsgGUID: nNJ0Eu9gSeiUMoPhCGsbzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,320,1744095600"; 
   d="scan'208";a="163543496"
Received: from agladkov-desk.ger.corp.intel.com (HELO stinkbox) ([10.245.244.179])
  by orviesa005.jf.intel.com with SMTP; 17 Jul 2025 15:35:04 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 18 Jul 2025 01:35:03 +0300
Date: Fri, 18 Jul 2025 01:35:03 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
	"open list:HIBERNATION (aka Software Suspend, aka swsusp)" <linux-pm@vger.kernel.org>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
	"open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
	"open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	Merthan =?utf-8?Q?Karaka=C5=9F?= <m3rthn.k@gmail.com>
Subject: Re: [PATCH v4 2/5] PCI: Put PCIe ports with downstream devices into
 D3 at hibernate
Message-ID: <aHl6l4cu8S0EVcc5@intel.com>
References: <20250616175019.3471583-1-superm1@kernel.org>
 <20250616175019.3471583-3-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616175019.3471583-3-superm1@kernel.org>
X-Patchwork-Hint: comment

On Mon, Jun 16, 2025 at 12:50:16PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> For the suspend flow PCIe ports that have downstream devices are put into
> the appropriate D3 state when children are not in D0. For the hibernate
> flow, PCIe ports with downstream devices stay in D0 however. This can
> lead to PCIe ports that are remained powered on needlessly during
> hibernate.
> 
> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
> pci_pm_suspend_noirq() in that PCIe ports that are power manageable should
> without downstream devices in D0 should be put into their appropriate
> sleep state.
> 
> Cc: AceLan Kao <acelan.kao@canonical.com>
> Cc: Kai-Heng Feng <kaihengf@nvidia.com>
> Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
> Cc: Denis Benato <benato.denis96@gmail.com>
> Cc: Merthan Karakaş <m3rthn.k@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4:
>  * Use helper even when CONFIG_SUSPEND not set (LKP robot)
> v3:
>  * Split out common code between suspend_noirq() and poweroff_noirq()
>    to a helper function
>  * https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
> ---
>  drivers/pci/pci-driver.c | 94 ++++++++++++++++++++++++++--------------
>  1 file changed, 61 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0d4c67829958b..f7a0c23515718 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -759,6 +759,56 @@ static void pci_pm_complete(struct device *dev)
>  
>  #endif /* !CONFIG_PM_SLEEP */
>  
> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
> +/**
> + * pci_pm_set_prepare_bus_pm
> + * @pci_dev: pci device
> + *
> + * Prepare the device to go into a low power state by saving state
> + * and configure bus PM policy.
> + *
> + * Return: TRUE for bus PM will be used
> + *         FALSE for bus PM will be skipped
> + */
> +static bool pci_pm_set_prepare_bus_pm(struct pci_dev *pci_dev)
> +{
> +	if (!pci_dev->state_saved) {
> +		pci_save_state(pci_dev);
> +
> +		/*
> +		 * If the device is a bridge with a child in D0 below it,
> +		 * it needs to stay in D0, so check skip_bus_pm to avoid
> +		 * putting it into a low-power state in that case.
> +		 */
> +		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
> +			pci_prepare_to_sleep(pci_dev);
> +	}
> +
> +	pci_dbg(pci_dev, "PCI PM: Sleep power state: %s\n",
> +		pci_power_name(pci_dev->current_state));
> +
> +	if (pci_dev->current_state == PCI_D0) {
> +		pci_dev->skip_bus_pm = true;
> +		/*
> +		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
> +		 * downstream device is in D0, so avoid changing the power state
> +		 * of the parent bridge by setting the skip_bus_pm flag for it.
> +		 */
> +		if (pci_dev->bus->self)
> +			pci_dev->bus->self->skip_bus_pm = true;
> +	}
> +
> +	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
> +		pci_dbg(pci_dev, "PCI PM: Skipped\n");
> +		return FALSE;
> +	}
> +
> +	pci_pm_set_unknown_state(pci_dev);
> +
> +	return TRUE;
> +}
> +#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
> +
>  #ifdef CONFIG_SUSPEND
>  static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
>  {
> @@ -878,38 +928,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
>  		}
>  	}
>  
> -	if (!pci_dev->state_saved) {
> -		pci_save_state(pci_dev);
> -
> -		/*
> -		 * If the device is a bridge with a child in D0 below it,
> -		 * it needs to stay in D0, so check skip_bus_pm to avoid
> -		 * putting it into a low-power state in that case.
> -		 */
> -		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
> -			pci_prepare_to_sleep(pci_dev);
> -	}
> -
> -	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
> -		pci_power_name(pci_dev->current_state));
> -
> -	if (pci_dev->current_state == PCI_D0) {
> -		pci_dev->skip_bus_pm = true;
> -		/*
> -		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
> -		 * downstream device is in D0, so avoid changing the power state
> -		 * of the parent bridge by setting the skip_bus_pm flag for it.
> -		 */
> -		if (pci_dev->bus->self)
> -			pci_dev->bus->self->skip_bus_pm = true;
> -	}
> -
> -	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
> -		pci_dbg(pci_dev, "PCI PM: Skipped\n");
> +	if (!pci_pm_set_prepare_bus_pm(pci_dev))
>  		goto Fixup;
> -	}
> -
> -	pci_pm_set_unknown_state(pci_dev);
>  
>  	/*
>  	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
> @@ -1136,6 +1156,8 @@ static int pci_pm_poweroff(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	pci_dev->skip_bus_pm = false;
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>  
> @@ -1199,8 +1221,8 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  			return error;
>  	}
>  
> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> -		pci_prepare_to_sleep(pci_dev);
> +	if (!pci_pm_set_prepare_bus_pm(pci_dev))
> +		goto Fixup;

This looks like it's doing similar stuff to what I wanted to do here:
https://lore.kernel.org/linux-pci/20240925144526.2482-2-ville.syrjala@linux.intel.com/

and a bunch of other stuff that seems to lack an explanation:
- the pci_has_subordinate() check is disappearing
- pci_save_state() is now getting called for the poweroff path
- same for pci_pm_set_unknown_state()
- the pci_pm_bridge_power_up_actions() call is being added to
  pci_pm_restore_noirq() for some reason

>  	/*
>  	 * The reason for doing this here is the same as for the analogous code
> @@ -1209,6 +1231,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>  		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
>  
> +Fixup:
>  	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>  
>  	return 0;
> @@ -1218,10 +1241,15 @@ static int pci_pm_restore_noirq(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
> +	pci_power_t prev_state = pci_dev->current_state;
> +	bool skip_bus_pm = pci_dev->skip_bus_pm;
>  
>  	pci_pm_default_resume_early(pci_dev);
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  
> +	if (!skip_bus_pm && prev_state == PCI_D3cold)
> +		pci_pm_bridge_power_up_actions(pci_dev);
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return 0;
>  
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

