Return-Path: <linux-pci+bounces-12138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFF895D642
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 21:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A6E1C21081
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C037D1925BC;
	Fri, 23 Aug 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6TuGExr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206F1885B9;
	Fri, 23 Aug 2024 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724442843; cv=none; b=IxyAY23JHjkxBTAEOKR9ZCTf50C8PNQuyyTV1u1YwPiWO7w0xJxmishOPeU59KbcRzQcEJh8Re25HUreVlj15gNk4Yte3rbSx6KolbsQQPwonI2unFZfHH/uhqc9wFID/bsSZH5YPGLS1A5MAIE30BVcKEddFlaiyheKVm15BaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724442843; c=relaxed/simple;
	bh=FbLzJM1sevygIw62wwjrGDZMa5dNQfyCcprINFgo/Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EqDrdxDL54QSVFJ01AdLthlw5h8RlufiPcqTc9MvGVtjbVp+wVUaVgEwJNUOBcZpGe6ofNWe5orflfske0QgyJ/XcSCm7SPuh7S13UYzK0WynS7ejSfRfPuJx7HGs1LCi3dvsoi2rqEjUNOVGrjCEkb6W8zaVnIKAizosFp4HRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6TuGExr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC22C32786;
	Fri, 23 Aug 2024 19:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724442843;
	bh=FbLzJM1sevygIw62wwjrGDZMa5dNQfyCcprINFgo/Dc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=U6TuGExrg/rj/EK/jeeQeNKcTWby1eVjRt66rDgTcfJ36+bWzhpyFozet0x4dfXOc
	 5ic8+xJMH/nNfm0ScBx3wJJOWGOcvIE6LB30/pMsYuagsqGfEfWCC3ZkbRpCAxAhGJ
	 0nlNozgSgDoeAFE8ij0ibdbhEItHq81aYAj1Cnxwp3XxIbb+/KEAwLdDU6TVC1hmhe
	 sznAVkC8x4yCyVyXJ0BZDOohq/xNB6BSrREDFuVbmfa6Sdy+SOTGxJzPXSkj466GQR
	 LFGqm3dW5Y4L0LMaKkUaGVXDcspi3WGBWEfLwuYzLdaqJgs9i6v66fEQIPDymx4Iae
	 IEyPUTS10tB3g==
Date: Fri, 23 Aug 2024 14:54:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
Message-ID: <20240823195400.GA377553@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823154023.360234-3-superm1@kernel.org>

[+cc Duc, Alex]

On Fri, Aug 23, 2024 at 10:40:20AM -0500, Mario Limonciello wrote:
> If a dock is plugged in at the same time as autosuspend delay then this
> can cause malfunctions in the USB4 stack. This happens because the
> device is still in D3cold at the time that the PCI core handed
> control back to the USB4 stack.

I assume the USB device in question is in the dock that was hot-added?
This patch suggests that pci_dev_wait() has waited for a read of
PCI_COMMAND to respond with something other than ~0, but the device is
still in D3cold.  I suppose we got to pci_dev_wait() via
pci_pm_bridge_power_up_actions() calling
pci_bridge_wait_for_secondary_bus(), since I wouldn't expect a reset
in the hot-add case.

> A device that has gone through a reset may return a value in PCI_COMMAND
> but that doesn't mean it's finished transitioning to D0.  For evices that
> support power management explicitly check PCI_PM_CTRL on everything but
> system resume to ensure the transition happened.

s/evices/devices/

> Devices that don't support power management and system resume will
> continue to use PCI_COMMAND.

Is there a bugzilla or other report with more details that we can
include here?

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4->v5:
>  * Fix misleading indentation
>  * Amend commit message
> ---
>  drivers/pci/pci.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 1e219057a5069..f032a4aaec268 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1309,21 +1309,33 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int
>  	 * the read (except when CRS SV is enabled and the read was for the
>  	 * Vendor ID; in that case it synthesizes 0x0001 data).
>  	 *
> -	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
> +	 * Wait for the device to return a non-CRS completion.  On devices
> +	 * that support PM control and on waits that aren't part of system
> +	 * resume read the PM control register to ensure the device has
> +	 * transitioned to D0.  On devices that don't support PM control,
> +	 * or during system resume read the command register to instead of
> +	 * Vendor ID so we don't have to contend with the CRS SV value.
>  	 */
>  	for (;;) {
> -		u32 id;
> -
>  		if (pci_dev_is_disconnected(dev)) {
>  			pci_dbg(dev, "disconnected; not waiting\n");
>  			return -ENOTTY;
>  		}
>  
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> -		if (!PCI_POSSIBLE_ERROR(id))
> -			break;
> +		if (dev->pm_cap && reset_type != PCI_DEV_WAIT_RESUME) {
> +			u16 pmcsr;
> +
> +			pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +			if (!PCI_POSSIBLE_ERROR(pmcsr) &&
> +			    (pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D0)
> +				break;
> +		} else {
> +			u32 id;
> +
> +			pci_read_config_dword(dev, PCI_COMMAND, &id);
> +			if (!PCI_POSSIBLE_ERROR(id))
> +				break;
> +		}

What is the rationale behind using PCI_PM_CTRL in some cases and
PCI_COMMAND in others?  Is there some spec language we can cite for
this?

IIUC, pci_dev_wait() waits for a device to be ready after a reset
(FLR, D3hot->D0 transition for devices where No_Soft_Reset is clear,
DPC) and after power-up from D3cold (pci_pm_bridge_power_up_actions()).
I think device readiness in all of these cases is covered by PCIe
r6.0, sec 6.6.1.

If the Root Port above the device supports Configuration RRS Software
Visibility, I think we probably should use that here instead of either
PCI_COMMAND or PCI_PM_CTRL.  SR-IOV VFs don't implement Vendor ID,
which might complicate this a little.  But it niggles in my mind that
there may be some other problem beyond that.  Maybe Alex remembers.

Anyway, if we meet the requirements of sec 6.6.1, the device should be
ready to respond to config requests, and I assume that also means
the device is in D0.

>  		if (delay > timeout) {
>  			pci_warn(dev, "not ready %dms after %s; giving up\n",
> -- 
> 2.43.0
> 

