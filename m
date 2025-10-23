Return-Path: <linux-pci+bounces-39200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C943AC0365F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 22:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFE11AA2FCE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405B218AD4;
	Thu, 23 Oct 2025 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fwf6vDmh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADE217332C;
	Thu, 23 Oct 2025 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251765; cv=none; b=Vpkbh1MHRzbXY37/ypS3FEPbyZyW+00/U10Ip5k2VoBV9KtADQ725Ly1Qir+tlCE+omU1Q+WTaddXOIfR02Z3LVSxviHFN5nwoNc6LF2mbqBf7DJyOu2G6qtPa+LgWG66VXKjQ/9bc/f72lfMets3hGxzQrXt4ZsB6vkvDGrNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251765; c=relaxed/simple;
	bh=XwBegz7tJEXFtipnq5Ve4Laqk1DLcrjbKOAQT8d1YWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HrHS4brBU/9HYTaN0kdhE0MPdrfKAtJ1JLILvjM7I14HQwEa6hl15npPrghgOMRAL6QXUUDekGZuLg5Z3BCrGq+NHWzNaXfCLuorSjPd711RNmOguJPNRprPi05hkTX1FUAqyxxPHVO9dqzJlNgroXmJxU6yo0wy75Zb8iv7SQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fwf6vDmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B063BC4CEE7;
	Thu, 23 Oct 2025 20:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761251764;
	bh=XwBegz7tJEXFtipnq5Ve4Laqk1DLcrjbKOAQT8d1YWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Fwf6vDmhHygtIw266Mza2L/w4Y4OEMdWFL9Srl47Ljq9RM/ghx3LLqTVxkVcK2Wmx
	 tEX36tQ/N8vPUPrLcnBQmjmo8COXFOzsnGQp6UG/x5ntmlK8yVOfW5haczGNE9M0Cc
	 p96vQbViTQmj/W+YrOJatUrsUkUgm6FN8dlooPScA8SyFsSzihmmVGtfB/CS5DK6iy
	 Qbz/fA/g54Sk2Amn2HsA7XW0iwSLvnrZkV1cscr8qsmSwGnSExkwf+WfGb8eu4hvif
	 M5mtlqxVBBqu04n+yUpYDUNOZX59sG3bw+yj+5FDrlEuA0lzcE6bg5xh+HBkSX4alq
	 CJTgPOtmL0L0A==
Date: Thu, 23 Oct 2025 15:36:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
	"K, Kiran" <kiran.k@intel.com>,
	"Ben Ami, Golan" <golan.ben.ami@intel.com>,
	"Berg, Johannes" <johannes.berg@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
Message-ID: <20251023203603.GA1312405@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA3PR11MB9016B8132E2E11806B58A0F7FCF0A@IA3PR11MB9016.namprd11.prod.outlook.com>

On Thu, Oct 23, 2025 at 09:42:16AM +0000, Devegowda, Chandrashekar wrote:
> > On Tue, Mar 18, 2025 at 10:55:06AM -0400, Luiz Augusto von Dentz wrote:
> > > On Fri, Mar 14, 2025 at 3:40 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Fri, Mar 14, 2025 at 12:16:13PM +0200, Chandrashekar Devegowda
> > wrote:
> > > > > Support function level reset (flr) on hardware exception to
> > > > > recover controller. Driver also implements the back-off time
> > > > > of 5 seconds and the maximum number of retries are limited
> > > > > to 5 before giving up.
> > > >
> > > > Sort of weird that the commit log mentions FLR, but it's not
> > > > mentioned in the patch itself except for
> > > > BTINTEL_PCIE_FLR_RESET_MAX_RETRY.  Apparently the assumption
> > > > is that DSM_SET_RESET_METHOD_PCIE performs an FLR.
> > > >
> > > > Since this is an ACPI _DSM, presumably this mechanism only
> > > > works for devices built into the platform, not for any
> > > > potential plug-in devices that would not be described via
> > > > ACPI.  I guess this driver probably already only works for
> > > > built-in devices because it also uses DSM_SET_WDISABLE2_DELAY
> > > > and DSM_SET_RESET_METHOD.
> > > >
> > > > There is a generic PCI core way to do FLR (pcie_reset_flr()),
> > > > so I assume the _DSM exists because the device needs some
> > > > additional device-specific work around the FLR.
> > > >
> > > > > +static void btintel_pcie_removal_work(struct work_struct *wk) {
> > > > > +     struct btintel_pcie_removal *removal =
> > > > > +             container_of(wk, struct btintel_pcie_removal, work);
> > > > > +     struct pci_dev *pdev = removal->pdev;
> > > > > +     struct pci_bus *bus;
> > > > > +     struct btintel_pcie_data *data;
> > > > > +
> > > > > +     data = pci_get_drvdata(pdev);
> > > > > +
> > > > > +     pci_lock_rescan_remove();
> > > > > +
> > > > > +     bus = pdev->bus;
> > > > > +     if (!bus)
> > > > > +             goto out;
> > > > > +
> > > > > +     btintel_acpi_reset_method(data->hdev);
> > > > > +     pci_stop_and_remove_bus_device(pdev);
> > > > > +     pci_dev_put(pdev);
> > > > > +
> > > > > +     if (bus->parent)
> > > > > +             bus = bus->parent;
> > > > > +     pci_rescan_bus(bus);
> > > >
> > > > This remove and rescan by a driver that's bound to the device
> > > > subverts the driver model.  pci_stop_and_remove_bus_device()
> > > > detaches the driver from the device.  After the driver is
> > > > detached, we should not be running any driver code.
> > >
> > > Yeah, this self removal was sort of bugging me as well, although
> > > I'm not familiar enough with the pci subsystem, having the
> > > driver remove and continue running code like pci_rescan_bus
> > > seems wrong as we may end up with multiple instances of the same
> > > driver.
> > >
> > > > There are a couple other drivers that remove their own device
> > > > (ath9k, iwlwifi, asus_wmi, eeepc-laptop), but I think those
> > > > are broken and it's a mistake to add this pattern to more
> > > > drivers.
> > > >
> > > > What's the reason for doing the remove and rescan?  The PCI
> > > > core doesn't reset the device when you do this, so it's not a
> > > > "bigger hammer reset".
> > >
> > > I guess it was more of the expectation of Chandru to have a sort
> > > of hard reset, driver remove+probe, instead of a soft reset
> > > where the driver will just need to reinit itself after
> > > performing pcie_reset_flr.
> > 
> > If the object is just to reinitialize the driver, I think this
> > hack of removing and rescanning is a bad way to do it.  If you
> > reset the device, you now know the state of the device and you can
> > make the driver state match it.  If necessary you can always reuse
> > part or all of the .remove() and .probe() methods yourself,
> > without this dance of calling pci_stop_and_remove_bus_device() and
> > pci_rescan_bus().
> 
> I’m sharing insights from our recent work on the PLDR for the BT
> driver. The above method supports FLR effectively, but for PLDR it
> is required to unload Wifi driver before doing PLDR via ACPI method.

IIUC "PLDR" is an ACPI method that does a reset, and you want to reset
a BT device.

> Currently, calling pci_rescan_bus() successfully rebinds both the
> WiFi and BT drivers. This approach follows the method used for the
> WiFi driver, as seen here:
> 
> https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c#L2182

It looks like this is a multi-function device, iwlwifi is bound to
function 0, and btintel is bound to function 1.

Then it looks like iwl_trans_pcie_removal_wk() starts with the wifi
device, finds the corresponding BT device, removes the BT device, runs
PLDR on the wifi device, removes the wifi device, and rescans to find
both devices again:

  iwl_trans_pcie_removal_wk
    wifi = removal->pdev			# WiFi device
    bt = pci_get_slot(...)			# BT device
    pci_stop_and_remove_bus_device(bt)
    iwl_trans_pcie_set_product_reset(wifi)	# do PLDR on WiFi
    pci_stop_and_remove_bus_device(wifi)
    pci_rescan_bus

It seems problematic to me for the WiFi driver to remove the BT
driver.  What if BT was active at the time?  Why is it ok to yank the
rug out from under it?

Why does the BT driver have to be unloaded before resetting the WiFi
device?  Why does the WiFi driver have to be unloaded before resetting
the BT device?

Theoretically, the functions of a PCI multi-function device are
independent and really don't have any influence on each other.

If you had a single driver that claimed both devices, that driver
could coordinate this since it would know about both and could
synchronize their activity when needed.

Maybe you could have a wrapper driver that claims both and delegates
each function to either iwlwifi or btintel as needed?  Since the
wrapper, iwlwifi, and btintel would be linked into a single module,
you could arrange callbacks between them to synchronize and handle
these resets.

If you reset the device, you know the state of the device afterward,
and the driver should be able to initialize its own data structures
accordingly.  This should not require any PCI device removal or
rescan.

Bjorn

