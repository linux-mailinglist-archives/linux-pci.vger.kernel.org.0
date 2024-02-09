Return-Path: <linux-pci+bounces-3298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0E784FC92
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 20:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28397281C00
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 19:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BA57861;
	Fri,  9 Feb 2024 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIpYRqrQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5D5A787
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707505442; cv=none; b=F07GK98hiiKootAZugOMDtJvZgpDEQLM8nH3Gq6UDa6OKkIYmly67oKeU8t5XJ5j/oib9/kgIHUgu+0hybp5IfmjtvbOS0+PUkf7NiMFpLlDNbco1jCmudeRFbdWmj+PWbkGTalPV0vvOhirS/tHj/pQ0zmsbNT0RyabmxzbPJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707505442; c=relaxed/simple;
	bh=0K7CsVTFmhDFPf9NPQ8gSAbTfxtdgziVTUuYmGTsVCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SRw3icfKuOoktx1+Dww7HhsNDHHT+4Bdn+o+9H4U2yeImTwdUO9rOEzs+bcDO529j03aeL6JT3Vq2jsoCvGLN2oizoleGQqDIynqG4ynE3nGDCe1acPc9wVPKwD69/Tb0N5AWlrXizoSgWYexHbot4RXAonKpJJqV92brChyYIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIpYRqrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEDBC433C7;
	Fri,  9 Feb 2024 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707505441;
	bh=0K7CsVTFmhDFPf9NPQ8gSAbTfxtdgziVTUuYmGTsVCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kIpYRqrQ1yhmvQk1XWyIpBhFFtHzX5RB1O5YVvx7VJSihgYzfIVj4hfmhJWABysP5
	 lPZKb2po0s4bunu114tiODgKPKVfoDlE7fLO5oBxr/0fKkg6K3oAHhXNN4Es6OfDQD
	 vVHwOZnl/QDh8xmaXLNwjpY/y5gZ1VSFpEg9OjAGmAimH3H07EJwiS+H6vvgwRgJ1A
	 +9jwXjQH5IrHXW5DV71PAErjW2OyBjLfgryfe7MUuRBnWBR0FqkXTwM3U9cSpkt7CH
	 m8aH24X6lZ0Qj+687olNRyK4ByUAYzyuxegomfhqbsIjOk4FfabAtWljWjplSpymfp
	 tLIvrIT8YuTOw==
Date: Fri, 9 Feb 2024 13:03:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com, rafael@kernel.org,
	sanath.s@amd.com
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
Message-ID: <20240209190359.GA1010379@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123185548.1040096-1-alex.williamson@redhat.com>

On Tue, Jan 23, 2024 at 11:55:31AM -0700, Alex Williamson wrote:
> The commit noted in fixes added a bogus requirement that runtime PM
> managed devices need to be in the RPM_ACTIVE state for PME polling.
> In fact, only devices in low power states should be polled.
> 
> However there's still a requirement that the device config space must
> be accessible, which has implications for both the current state of
> the polled device and the parent bridge, when present.  It's not
> sufficient to assume the bridge remains in D0 and cases have been
> observed where the bridge passes the D0 test, but the PM state
> indicates RPM_SUSPENDING and config space of the polled device becomes
> inaccessible during pci_pme_wakeup().
> 
> Therefore, since the bridge is already effectively required to be in
> the RPM_ACTIVE state, formalize this in the code and elevate the PM
> usage count to maintain the state while polling the subordinate
> device.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> Reported-by: Sanath S <sanath.s@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Applied with Rafael's reviewed-by to for-linus for v6.8, thanks!

> ---
>  drivers/pci/pci.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index bdbf8a94b4d0..764d7c977ef4 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2433,29 +2433,36 @@ static void pci_pme_list_scan(struct work_struct *work)
>  		if (pdev->pme_poll) {
>  			struct pci_dev *bridge = pdev->bus->self;
>  			struct device *dev = &pdev->dev;
> -			int pm_status;
> +			struct device *bdev = bridge ? &bridge->dev : NULL;
> +			int bref = 0;
>  
>  			/*
> -			 * If bridge is in low power state, the
> -			 * configuration space of subordinate devices
> -			 * may be not accessible
> +			 * If we have a bridge, it should be in an active/D0
> +			 * state or the configuration space of subordinate
> +			 * devices may not be accessible or stable over the
> +			 * course of the call.
>  			 */
> -			if (bridge && bridge->current_state != PCI_D0)
> -				continue;
> +			if (bdev) {
> +				bref = pm_runtime_get_if_active(bdev, true);
> +				if (!bref)
> +					continue;
> +
> +				if (bridge->current_state != PCI_D0)
> +					goto put_bridge;
> +			}
>  
>  			/*
> -			 * If the device is in a low power state it
> -			 * should not be polled either.
> +			 * The device itself should be suspended but config
> +			 * space must be accessible, therefore it cannot be in
> +			 * D3cold.
>  			 */
> -			pm_status = pm_runtime_get_if_active(dev, true);
> -			if (!pm_status)
> -				continue;
> -
> -			if (pdev->current_state != PCI_D3cold)
> +			if (pm_runtime_suspended(dev) &&
> +			    pdev->current_state != PCI_D3cold)
>  				pci_pme_wakeup(pdev, NULL);
>  
> -			if (pm_status > 0)
> -				pm_runtime_put(dev);
> +put_bridge:
> +			if (bref > 0)
> +				pm_runtime_put(bdev);
>  		} else {
>  			list_del(&pme_dev->list);
>  			kfree(pme_dev);
> -- 
> 2.43.0
> 

