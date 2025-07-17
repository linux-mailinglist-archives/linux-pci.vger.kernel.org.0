Return-Path: <linux-pci+bounces-32458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C90F7B09694
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F2C1AA65FA
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C438A2367DA;
	Thu, 17 Jul 2025 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwDRaKlh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4192153CE;
	Thu, 17 Jul 2025 21:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789354; cv=none; b=Af29UY2//gxRDRNz8Hd8ue6LDWoMsxgTKeN63Uh8vl9FLV+Z7J0738Qu5ZkeW6EBNxlL5iNt+D078VLXYXgeEt5gXiIOhmVNh+jiX4lUVvolhmyg1tC1HxoAJVtUE3kmX9Joa0cAjfx4bVHuDf1sCi4qXmY0hWqr0o4ITHhPZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789354; c=relaxed/simple;
	bh=aQ8AEa5y0u+VVf9vSpXwnKG8i5PF3aKYF/4AKnW6whs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fQMi0zwJrnLe5G4lx/sHDzWcLmft7kC7k8CcS9JTmNsH2gjroE/JuLL4Rf/VBq7gtZbW82bqJCOq+bNTqxR6KIYIT70X0KVq6xdmJ6uOlvlVeZQmYU98g4fWT5UXxQwQTPrUpAqjZgrEZuqJjMhj6Urme/0SaUFXank6Mw92qhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwDRaKlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10260C4CEE3;
	Thu, 17 Jul 2025 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752789354;
	bh=aQ8AEa5y0u+VVf9vSpXwnKG8i5PF3aKYF/4AKnW6whs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kwDRaKlhffwnn7T6xKYIeqt0Cc1Wm5ueQDly3Pp9Nrua+jQ+MJBM8lA5NWQSIaXMo
	 PCHcq7gHmgr7FT9HTCdqnrjdkOFtc1Oise47quZjRV1YAoV/amk9ayH9OWyRBVNCHS
	 JaJvjIK+pZVstUJ2kgeQNjDNjLt50nW3XqYFKWP1vDzweH7XSAfPUpWkVU5cIddhlh
	 HgqgR4XZeQIF+jZF0GTbq54tgGtvQEPnOlmrw0UE9hG9V/pUHeuTSj6UAnheFE21+2
	 XnAVOmgjCsYyCcovCAYVKhKPntKcSQkTWZ4FmFLvYSENNQcek7ntk0Jky9gaFnKovE
	 FzXv1G0dRIvvA==
Date: Thu, 17 Jul 2025 16:55:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20250717215552.GA2655127@bhelgaas>
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

On Mon, Jun 16, 2025 at 12:50:16PM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> For the suspend flow PCIe ports that have downstream devices are put into
> the appropriate D3 state when children are not in D0. For the hibernate
> flow, PCIe ports with downstream devices stay in D0 however. This can
> lead to PCIe ports that are remained powered on needlessly during
> hibernate.

I suppose by "appropriate D3 state", you mean the Port is put in
D3cold if all children are in D3cold, or D3hot if they are all in
D1-D3hot?  PM-illiterate folks like me need some help to know what is
"appropriate" :)

This refers specifically to "PCIe ports", but it looks like the code
applies to PCI bridges in general, so maybe it should just say
"bridges"?

s/ports that are remained powered on/ports that remain powered on/
(or "bridges that remain powered on")

> Adjust the pci_pm_poweroff_noirq() to follow the same flow as
> pci_pm_suspend_noirq() in that PCIe ports that are power manageable should
> without downstream devices in D0 should be put into their appropriate
> sleep state.

Extra "should" in this sentence, I guess?
(s/power manageable should/power manageable/)

Also "PCIe ports" here, maybe should be "bridges"?

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

I guess "configure bus PM policy" must mean "if this device is in D0,
set skip_bus_pm = true for the device and any upstream bridge so we
won't change their power state"?

> + * Return: TRUE for bus PM will be used
> + *         FALSE for bus PM will be skipped
> + */
> +static bool pci_pm_set_prepare_bus_pm(struct pci_dev *pci_dev)

The "pci_pm_set_prepare_bus_pm" name doesn't immediately suggest a
property that can be true or false.  It complicates things a bit when
a bool function has side effects in addition to giving a yes/no or
true/false answer.  Not sure whether or how this could be improved.

And it's a little confusing that we return false when we set
skip_bus_pm = true (mostly).  It's tough to keep track of what
true/false means.

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

"true" and "false" instead of "TRUE" and "FALSE".

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

This part looks like it's mostly factoring this code out to
pci_pm_set_prepare_bus_pm().  Would it be practical to split that
factoring to a patch that makes no functional change?  I'm wondering
if that would make the functional change smaller and easier to
understand.

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
>  
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
> 

