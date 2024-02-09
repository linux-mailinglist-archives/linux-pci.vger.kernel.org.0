Return-Path: <linux-pci+bounces-3291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524B684F9B7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 17:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80451F21195
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E93F7BAF4;
	Fri,  9 Feb 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHkXTYmp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962276414
	for <linux-pci@vger.kernel.org>; Fri,  9 Feb 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496523; cv=none; b=M8RrpYdOpmz9ZorvKmE2Q+J7SNplkD0UM8Ok9qyhbkOgs8iOUK1RxPEbMQwdfqNayG+gg1PpZcOprIUO3IZUYBmqWXLw4pnmNZE2bCfjm9xvvfVqac6pQqcr6/HZ6V8MzB2itbXGEOUwGrNCu9xzCpSU5opNGFcvH1WO9YiUAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496523; c=relaxed/simple;
	bh=fkxOF6wOuKgeCnuTpGDp6RLCajENLwlDI8Wn5brPQps=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o/nckbyrN/UPlrqztf+UOZ7mBfY4dQjPN64TeXlYi3lIsH+phMtqc1rzlq754n3w5ZJXoglBlozyUvSIy1pBcKOEMdBEJ1lhWKFtJ2V67kPXxHs3269NCwJuKu8LXaQtFAdR2T7euAo9H4MSLs0JIBwY/llloUn/y9xOWgAcrqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHkXTYmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1985C433C7;
	Fri,  9 Feb 2024 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707496522;
	bh=fkxOF6wOuKgeCnuTpGDp6RLCajENLwlDI8Wn5brPQps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GHkXTYmpdpfXqVTh0L+2bnMM2XW3PYSB/qPjhX3JldjvD/2deaMaSY0eYAusGdpBg
	 RDgmTTXJMgTdS7nt4Rts38X/8VkZBLtPjG1T3BKaqNTHXihao55UrZBSmuIIZIHYux
	 Ai0CH5zcmZ329toawd7xznCr9/y1mu9lmqo0QKy1+kc2rMEy+8nldNLl9C5LRMNKXi
	 SteTQ46Gl8Ml3LWM7CnVF8/xblN8sJPScxMMkY52G94uL/KfTIH2SHkZVm4WSQtzlL
	 QdmGeGmcgUnj3tXxaq65e1baGYU1ZPQqJ0eC1TSXQVNaESTycx1DWWZxwqdT7p4aSJ
	 EQyYh2vhqs22Q==
Date: Fri, 9 Feb 2024 10:35:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de,
	mika.westerberg@linux.intel.com, rafael@kernel.org,
	sanath.s@amd.com
Subject: Re: [PATCH] PCI: Fix active state requirement in PME polling
Message-ID: <20240209163521.GA1003145@bhelgaas>
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

This apparently fixes a problem: the bugzilla says something about
disks attached to Thunderbolt/USB4 docks not working, but I doubt it's
actually specific to Thunderbolt/USB4 or to disks.

The bugzilla also indicates that d3fcd7360338 was a regression.
d3fcd7360338 appeared in v6.6, so this fix is likely a candidate for
the current release (v6.8).

I'd like to mention both the user-visible problem being fixed and 
the fact that it fixes a regression here in the commit log so we can
make the case for putting this in v6.8.

> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Fixes: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
> Reported-by: Sanath S <sanath.s@amd.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218360
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
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

