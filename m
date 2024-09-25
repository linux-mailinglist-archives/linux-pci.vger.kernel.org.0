Return-Path: <linux-pci+bounces-13528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 634229866E0
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 21:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE632849BB
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0413EFF3;
	Wed, 25 Sep 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J81XJgvD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B0D13E043
	for <linux-pci@vger.kernel.org>; Wed, 25 Sep 2024 19:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292527; cv=none; b=ppKF5yGqQGQEewo2GMMZauHoxo/GuNiiQo1NzabxMgyhlxNSnwLpxgMQGWCWTUDd8nfHoo69g2b3kBaJ+fPj0J2CTDWe/GQQXmftNkblkhsYDl8ECaC1s64JBeehmfCYrptuCZXuiOPgE7suJ0ZDO0GWMWq5BDpO5E3rgxhX8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292527; c=relaxed/simple;
	bh=ZXQvVtzfo/b72whxwqfbT5X5HSRNrrDK7B6xTa+DefA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VB6ZF5ni9iNRkOlZPzzyhTiVvHWMupQmZbl2xJMxUpmDA7QiPsYyv/ijRgucHvYLxtQEihXFChHOOcVz9Ny/JYxagGkJ0FRK/4TmKvcrYdLp8sYyln3pDuMZKRKv1o76PrzU/O7ds8apPxFp+CzLpDUsFUVmklM6F7P7qDPU7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J81XJgvD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD8C4CEC3;
	Wed, 25 Sep 2024 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727292527;
	bh=ZXQvVtzfo/b72whxwqfbT5X5HSRNrrDK7B6xTa+DefA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=J81XJgvD0g2duP9iThKrtUPpgh8mLpfxyVb2WPM5wG7FbLW2M4FeYCasM5KYyZjdZ
	 iHjFx/JMv1XKiIrmtKdxoMBNqRd1N1ois6AnHd1sZ3x2g89oNycGYTzlFcpPDLD8TQ
	 s+mUEcALx37p/E1UnFMQVJOjL2tPgxwTTm9N+ZWio3dUu2r8J+HYxPwwuWIj6M+DKQ
	 tbYhqYeGPLiNk0zqDJv+0yPEs2DZzpdjSGLGTW9M7EQQFyyusAM/CJvirtOdo5OT4H
	 2m8zHA8kwBN9U4bH4a8/cUUebtR3a0dlcQzf2R9sROn+oUpQviM7z+RHu8+duHaOGh
	 wIF+6qavshxRA==
Date: Wed, 25 Sep 2024 14:28:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI/PM: Respect pci_dev->skip_bus_pm in the
 .poweroff() path
Message-ID: <20240925192842.GA9182@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925144526.2482-2-ville.syrjala@linux.intel.com>

On Wed, Sep 25, 2024 at 05:45:21PM +0300, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> On some older laptops i915 needs to leave the GPU in
> D0 when hibernating the system, or else the BIOS
> hangs somewhere. Currently that is achieved by calling
> pci_save_state() ahead of time, which then skips the
> whole pci_prepare_to_sleep() stuff.

IIUC this refers to pci_pm_suspend_noirq(), which has this:

  if (!pci_dev->state_saved) {
    pci_save_state(pci_dev);
    if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
      pci_prepare_to_sleep(pci_dev);
  }

Would be good if the commit log included the name of the function
where pci_prepare_to_sleep() is skipped.

If there's a general requirement to leave all devices in D0 when
hibernating, it would be nice to have have some documentation like an
ACPI spec reference.

Or if this is some i915-specific thing, maybe a pointer to history
like a lore or bugzilla reference.

> It feels to me that this approach could lead to unintended
> side effects as it causes the pci code to deviate from the
> standard path in various ways. In order to keep i915
> behaviour more standard it seems preferrable to use
> pci_dev->skip_bus_pm here. Duplicate the relevant logic
> from pci_pm_suspend_noirq() in pci_pm_poweroff_noirq().
> 
> It also looks like the current code is may put the parent
> bridge into D3 despite leaving the device in D0. Though
> perhaps the host bridge (which is where the integrated
> GPU lives) always has subordinates, which would make
> this a non-issue for i915. But maybe this could be a
> problem for other devices. Utilizing skip_bus_pm will
> make the behaviour of leaving the bridge in D0 a bit
> more explicit if nothing else.

s/is may/may/

Rewrap to fill 75 columns.  Could apply to all patches in the series.

Will need an ack from Rafael, author of:

  d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
  3e26c5feed2a ("PCI: PM: Skip devices in D0 for suspend-to-idle")

which added .skip_bus_pm and its use in pci_pm_suspend_noirq().

IIUC this is a cleanup that doesn't fix any known problem?  The
overall diffstat doesn't make it look like a simplification, although
it might certainly be cleaner somehow:

> drivers/gpu/drm/i915/i915_driver.c | 121 +++++++++++++++++++----------
> drivers/pci/pci-driver.c           |  16 +++-
> 2 files changed, 94 insertions(+), 43 deletions(-)

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: intel-gfx@lists.freedesktop.org
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>  drivers/pci/pci-driver.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index f412ef73a6e4..ef436895939c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1142,6 +1142,8 @@ static int pci_pm_poweroff(struct device *dev)
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  
> +	pci_dev->skip_bus_pm = false;
> +
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>  
> @@ -1206,9 +1208,21 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  			return error;
>  	}
>  
> -	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
> +	if (!pci_dev->state_saved && !pci_dev->skip_bus_pm &&
> +	    !pci_has_subordinate(pci_dev))
>  		pci_prepare_to_sleep(pci_dev);
>  
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
>  	/*
>  	 * The reason for doing this here is the same as for the analogous code
>  	 * in pci_pm_suspend_noirq().
> -- 
> 2.44.2
> 

