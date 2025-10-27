Return-Path: <linux-pci+bounces-39415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11601C0CE1A
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 11:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB62E4EACCB
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C02F12DA;
	Mon, 27 Oct 2025 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="blGwpcR/"
X-Original-To: linux-pci@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9A1E1DFC;
	Mon, 27 Oct 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559708; cv=none; b=DxnmE119fZ3+kij9G1ZMPElgnIQ+VwI04+dvEzHtA7wxBV8kuJF+Nb1np6eS/bPvGt1+4Mwxg0kDRnoEygKvazjnwG95Zdckb4wdbNcW4YF6bJb1rnKfDr+qKAPLWjcY8Y2Cm+Baf4HugKVp40H4sV8JZWjxyei7xXhP+M7Tqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559708; c=relaxed/simple;
	bh=6cQdiRpHxGaSASPH+29ugh5AbQWjEi4s33N7R1Ic96I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=reMtAcbFI0nL11JfPlctAzQfRuOJMUSkPR+LiiCsG0m1wpqVY7L/HD8orGyFq6TqS9/oxTU6JUgmkudD8SJHv16tkl87jlG8dAvUHxnbk94UzJY1tTjUpbu828VvNPOmYNPThG0jTj8zrr8Wiqp4uzuALUcqbbM9FxIEhCxbCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=blGwpcR/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DNc7Rk44kEIOfqYX6DTwbrnkDvExScI7F/8Nc7y8mkw=;
	t=1761559707; x=1762769307; b=blGwpcR/lO8s54fKp8tYzM4vDPleLA0aEcf84bCJPow3BBT
	A8ueA9/2Z4T5nZicHYIEHbc2wH3NASU5mkzZxwRLr4ITsLjvBKkhf7vuEwgJv9KUm6q1x4zeLqvvk
	fciCJLcG35dGD8sxhH/sCnt/cbuiFP06L0s3kME2h/zeli4eLv2CVvsJ3Diw+qEazvJvCj5qD/vVm
	hjOz9adK3DjtFkAr4C/gOW8INNEZk94uKd5CSAmvZdD0eZWmLmCm9WHoiFFdW5xq3+bskVRvutyP1
	SmAnBuTV8cz9RC2rmj4yGu0XBofauUz7Tre9LgxVoId+EQeBQcYQc17G17XNYufQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vDK9H-0000000AQMF-1ssO;
	Mon, 27 Oct 2025 11:08:23 +0100
Message-ID: <7acf9a2f2cec5d00fc1581ad3a12b1f4b580b349.camel@sipsolutions.net>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Support function level reset
From: Johannes Berg <johannes@sipsolutions.net>
To: Bjorn Helgaas <helgaas@kernel.org>, "Devegowda, Chandrashekar"
	 <chandrashekar.devegowda@intel.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 "linux-bluetooth@vger.kernel.org"	 <linux-bluetooth@vger.kernel.org>,
 "linux-pci@vger.kernel.org"	 <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,  "Srivatsa, Ravishankar"
 <ravishankar.srivatsa@intel.com>, "Tumkur Narayan, Chethan"
 <chethan.tumkur.narayan@intel.com>, "K, Kiran" <kiran.k@intel.com>, "Ben
 Ami, Golan" <golan.ben.ami@intel.com>
Date: Mon, 27 Oct 2025 11:08:22 +0100
In-Reply-To: <20251023203603.GA1312405@bhelgaas>
References: <20251023203603.GA1312405@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

So I've been asked to chime in here, mostly on behalf of iwlwifi, and
I'll actually respond to two of your messages a bit.

(from your previous email first:)

> Sort of weird that the commit log mentions FLR, but it's not mentioned
> in the patch itself except for BTINTEL_PCIE_FLR_RESET_MAX_RETRY.
> Apparently the assumption is that DSM_SET_RESET_METHOD_PCIE performs
> an FLR.

It's not just weird, it's simply wrong. This is not about FLR at all.

> Since this is an ACPI _DSM, presumably this mechanism only works for
> devices built into the platform, not for any potential plug-in devices
> that would not be described via ACPI.  I guess this driver probably
> already only works for built-in devices because it also uses
> DSM_SET_WDISABLE2_DELAY and DSM_SET_RESET_METHOD.

It ... depends. Sometimes it can work even for discrete devices if the
platform ACPI is prepared for it. But if you just take it into a
platform not prepared to handle it, then yes, obviously it cannot work.
The driver overall should and can work for discrete devices plugged into
an arbitrary platform (I have one plugged into an ARM board), but it
generally will not have all the platform integration features. (Though
some people are actually asking about DT support. I guess taken to the
logical conclusion for the reset discussion at hand that would mean
having a voltage regulator or so linked that the driver can use to power
off and on the device.)

> There is a generic PCI core way to do FLR (pcie_reset_flr()), so I
> assume the _DSM exists because the device needs some additional
> device-specific work around the FLR.

Nah, FLR was misleading. This is not related to FLR, see below for a
more complete discussion.

(the email I'm responding to:)

> IIUC "PLDR" is an ACPI method that does a reset, and you want to reset
> a BT device.

Not really.

PLDR is a Windows-ism, we really shouldn't even use this name.

(PLDR means "product level device reset", which is really trying to
reset more than each function. There's some magic required in Windows to
achieve this at their driver abstraction level.)

From a hardware perspective, it has a number of shared components [1],
as well as BT and WiFi functions on the device. Doing function reset on
either will only reset the individual function parts, not the shared
components.

[1] I could go into more details but it's not really for this discussion


To actually do that reset we need ACPI help, first calling the product
reset DSM (see iwl_trans_pcie_set_product_reset()) to enable the right
kind of reset among the various options, and then calling _RST on the
corresponding _PRR object. I _think_ this might even be specified
somewhere, so maybe pci_dev_acpi_reset() should try to find a _PRR
object, and we could remove this code? But I'm no ACPI expert. AFAICT
there's no _RST method on the object itself, only on the corresponding
_PRR object.

> > Currently, calling pci_rescan_bus() successfully rebinds both the
> > WiFi and BT drivers. This approach follows the method used for the
> > WiFi driver, as seen here:
> >=20
> > https://elixir.bootlin.com/linux/v6.18-rc1/source/drivers/net/wireless/=
intel/iwlwifi/pcie/gen1_2/trans.c#L2182
>=20
> It looks like this is a multi-function device, iwlwifi is bound to
> function 0, and btintel is bound to function 1.

Yes.

> Then it looks like iwl_trans_pcie_removal_wk() starts with the wifi
> device, finds the corresponding BT device, removes the BT device, runs
> PLDR on the wifi device, removes the wifi device, and rescans to find
> both devices again:

More or less, yes, see also above for a full discussion.

>   iwl_trans_pcie_removal_wk
>     wifi =3D removal->pdev			# WiFi device
>     bt =3D pci_get_slot(...)			# BT device
>     pci_stop_and_remove_bus_device(bt)
>     iwl_trans_pcie_set_product_reset(wifi)	# do PLDR on WiFi
>     pci_stop_and_remove_bus_device(wifi)
>     pci_rescan_bus
>=20
> It seems problematic to me for the WiFi driver to remove the BT
> driver.  What if BT was active at the time?  Why is it ok to yank the
> rug out from under it?

So first of all, it's not really different from unbinding it via sysfs,
so this is necessarily always supported. There's even PCIe hotplug, as
you surely know, and this device could be behind a Thunderbolt port
(I've actually done this in the, albeit fairly distant, past, when
admittedly BT was still USB.)

From a hardware perspective, the reason to do this is if one side (BT or
WiFi) detects that there's an error in a shared hardware components.
This may be either side, but it's not always predictable which side will
first detect the error, say WiFi is mostly idle then it won't
necessarily detect it.

Crucially though, the hardware is basically dead at this point anyway -
both BT and WiFi will be affected. One of them might just not know it
yet, and might not even notice until eventually getting a command
timeout to a random command, which might not be triggered until
"something happens" such as userspace triggering a scan.

> Why does the BT driver have to be unloaded before resetting the WiFi
> device?  Why does the WiFi driver have to be unloaded before resetting
> the BT device?

See above, I think.

> Theoretically, the functions of a PCI multi-function device are
> independent and really don't have any influence on each other.

"Theoretically", see above.

> If you had a single driver that claimed both devices, that driver
> could coordinate this since it would know about both and could
> synchronize their activity when needed.

Yes, but it'd be very complex to maintain that across two unrelated
subsystems, and wouldn't actually _help_ much.

> Maybe you could have a wrapper driver that claims both and delegates
> each function to either iwlwifi or btintel as needed?  Since the
> wrapper, iwlwifi, and btintel would be linked into a single module,
> you could arrange callbacks between them to synchronize and handle
> these resets.

While it would be possible to build such a driver, it'd be rather
complex to maintain, and wouldn't actually help anything.

> If you reset the device, you know the state of the device afterward,
> and the driver should be able to initialize its own data structures
> accordingly.  This should not require any PCI device removal or
> rescan.

Obviously, we know the state of the device, but ... it _does_ require
PCI removal *and* rescan, because the device completely falls off the
bus and needs to be rediscovered. The drivers also fundamentally have to
be unbound from it, since all state of the device (including BAR setup)
is lost. I'm fairly certain that if you were to query even the device
IDs after the reset, you'd see 0xFFFFFFFF, but in truth I don't fully
understand how this works at the PCIe bus level.

In any case, I didn't see any other way to do this when I implemented
it, and don't see it now either.


(going back to your earlier email:)

> This remove and rescan by a driver that's bound to the device subverts
> the driver model.  pci_stop_and_remove_bus_device() detaches the
> driver from the device.  After the driver is detached, we should not
> be running any driver code.

I mean, I _guess_ you could argue that? I don't really think of it that
way - the code that is running to do all this isn't actually part of the
driver context of this module. Now, if you're going to argue that a
"driver module" cannot have code (other than init/exit I guess) running
outside of the driver context I suppose you could do that, but that's
probably broken by half the modules in the tree anyway.

I also don't think that it's actually possible for the driver to unbind
itself within the context of the driver model, so in effect you're
arguing that a driver is also not allowed to call device_reprobe() for
it's own device, which I'd think some calls do today. The code here is
just a slightly more complex PCI-specific case of this because of the
device hardware behaviour described above.

Do we have to be careful with this vs. say module unload? Obviously,
just like anything else that isn't pure driver code, which also has to
be careful, just against remove() callback rather than module exit. But
this code isn't really tied to the driver model, it's running outside of
that context.


I hope this clarifies things. I apologise on behalf of the BT team for
misleading you on pretty much all of the terminology.

johannes

