Return-Path: <linux-pci+bounces-42088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC072C87727
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 00:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE13235489C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 23:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916FE2EE274;
	Tue, 25 Nov 2025 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR6T5z4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D42D9EC9;
	Tue, 25 Nov 2025 23:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112729; cv=none; b=TUDGE/RUqet0EF+NOwRuAF6prrOgSXLRqF/LGOiVW72kYuR89qSTB5cl8QEvqxdBeSwc9RnyuFxdUX2bJbxuKIkm2kDEdOH9nFyZcSaGIULPPoX68cZThAthKgO5u+RQyVBIWTFWrowps6BN+BUcRZSKikt1Q3we4sSi/V7QPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112729; c=relaxed/simple;
	bh=RZMuzKujCtfq/0f3/HyE8UbzQWwAL0xsNRv+1kA7nCg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iG1szxWzu7qMug6u1DdnZgcMIHUHvmXFUV4RjUVxIIqjIeaPTXobHvGmsuQsqi0OIOH+fAtwj0LTdB9QjGdOHHclN0HBWV++n2KSPCamBXAopHyJUWIu2wHaqINDKkDnebvDgUNHf28HxghDCPsDsi+GrlhgEeNOn+dxa1OjC+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR6T5z4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C61D9C4CEF1;
	Tue, 25 Nov 2025 23:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764112727;
	bh=RZMuzKujCtfq/0f3/HyE8UbzQWwAL0xsNRv+1kA7nCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DR6T5z4pLDrZICkFIX6twECM7v7aOuTb/ZhXLFhSiUFXljPe2ZEJwUhX7PdOspjnd
	 xc+3x/e6BVEfgcY6Up3QjR7hFiaWkLAFXm8hjYeh301zRDjk9wp6GLx0mcZuBjkUor
	 Wf5fnuw7KPYBQBXua2rZ4qM10BzH/jp/DoDgZo6t3lLg/EgvUHBFZ29wAjMap9ewvU
	 CeVLjUiO26+0A+6O/rUXhKpN/CTPyKia5pwFaKXEQIsV42DzUj5x3cdZQYAB3/I3O4
	 KY1Udk/kAVP/Bf+ej2gtJVCGjpoPeVlefpSgNDTTnYVqFkxY8i2B5/lsP1oKTEg12u
	 rFK9mC8iBU4zQ==
Date: Tue, 25 Nov 2025 17:18:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI/PM: Reinstate clearing state_saved in legacy
 and !pm codepaths
Message-ID: <20251125231846.GA2767905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <094f2aad64418710daf0940112abe5a0afdc6bce.1763483367.git.lukas@wunner.de>

On Wed, Nov 19, 2025 at 09:50:01AM +0100, Lukas Wunner wrote:
> When a PCI device is suspended, it is normally the PCI core's job to save
> Config Space and put the device into a low power state.  However drivers
> are allowed to assume these responsibilities.  When they do, the PCI core
> can tell by looking at the state_saved flag in struct pci_dev:  The flag
> is cleared before commencing the suspend sequence and it is set when
> pci_save_state() is called.  If the PCI core finds the flag set late in
> the suspend sequence, it refrains from calling pci_save_state() itself.

This has been applied already, no issue there.  I have a few questions
to help come up with a short higher-level merge commit log.

> But there are two corner cases where the PCI core neglects to clear the
> flag before commencing the suspend sequence:
> 
> * If a driver has legacy PCI PM callbacks, pci_legacy_suspend() neglects
>   to clear the flag.  The (stale) flag is subsequently queried by
>   pci_legacy_suspend() itself and pci_legacy_suspend_late().
> 
> * If a device has no driver or its driver has no PCI PM callbacks,
>   pci_pm_freeze() neglects to clear the flag.  The (stale) flag is
>   subsequently queried by pci_pm_freeze_noirq().
> 
> The flag may be set prior to suspend if the device went through error
> recovery:  Drivers commonly invoke pci_restore_state() + pci_save_state()
> to restore Config Space after reset.

I guess the only point of pci_save_state() in this case is to set
state_saved again so a future pci_restore_state() will work, right?

The actual state being *saved* is pointless, assuming pci_save_state()
saves exactly the same data that pci_restore_state() restored.

And these are the pci_save_state() calls you removed with "treewide:
Drop pci_save_state() after pci_restore_state()".  Too bad we have to
document the behavior we're about to change, but that's what we need
to do.  It's just a little clutter to keep in mind for this release.

> The flag may also be set if drivers call pci_save_state() on probe to
> allow for recovery from subsequent errors.
> 
> The result is that pci_legacy_suspend_late() and pci_pm_freeze_noirq()
> don't call pci_save_state() and so the state that will be restored on
> resume is the one recorded on last error recovery or on probe, not the one
> that the device had on suspend.  If the two states happen to be identical,
> there's no problem.

So IIUC the effect is that after this change and the "treewide"
change,

  - If the driver uses legacy PM, the state restored on resume will be
    the state from suspend instead of the state on probe.

  - For devices with no driver or a driver without PM, if the device
    has already been runtime-suspended, we avoid a pointless
    pci_save_state(), so it's an optimization and not logically
    related to the legacy PM case.

Right?

I'm thinking of something like this for the merge commit and eventual
pull request; please correct me if this isn't right:

  Restore the suspend config state, not the state from probe or error
  recovery, for drivers using legacy PCI suspend.

  Avoid saving config state again for devices without driver PM if
  their state was already saved by runtime suspend.

> Reinstate clearing the flag in pci_legacy_suspend() and pci_pm_freeze().
> The two functions used to do that until commit 4b77b0a2ba27 ("PCI: Clear
> saved_state after the state has been restored") deemed it unnecessary
> because it assumed that it's sufficient to clear the flag on resume in
> pci_restore_state().  The commit seemingly did not take into account that
> pci_save_state() and pci_restore_state() are not only used by power
> management code, but also for error recovery.
> 
> Devices without driver or whose driver has no PCI PM callbacks may be in
> runtime suspend when pci_pm_freeze() is called.  Their state has already
> been saved, so don't clear the flag to skip a pointless pci_save_state()
> in pci_pm_freeze_noirq().
> 
> None of the drivers with legacy PCI PM callbacks seem to use runtime PM,
> so clear the flag unconditionally in their case.
> 
> Fixes: 4b77b0a2ba27 ("PCI: Clear saved_state after the state has been restored")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.32+
> ---
>  drivers/pci/pci-driver.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 302d61783f6c..327b21c48614 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -629,6 +629,8 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	struct pci_driver *drv = pci_dev->driver;
>  
> +	pci_dev->state_saved = false;
> +
>  	if (drv && drv->suspend) {
>  		pci_power_t prev = pci_dev->current_state;
>  		int error;
> @@ -1036,6 +1038,8 @@ static int pci_pm_freeze(struct device *dev)
>  
>  	if (!pm) {
>  		pci_pm_default_suspend(pci_dev);
> +		if (!pm_runtime_suspended(dev))
> +			pci_dev->state_saved = false;
>  		return 0;
>  	}
>  
> -- 
> 2.51.0
> 

