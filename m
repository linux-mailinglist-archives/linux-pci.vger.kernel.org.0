Return-Path: <linux-pci+bounces-7073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A48BBA97
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 12:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027741C2081B
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 10:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743E218C3D;
	Sat,  4 May 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnmMvUfe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17WVN2Y7"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0CC1864C;
	Sat,  4 May 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714820200; cv=none; b=NWVfb4uwRrEWZzMqE1zPbUNSnObo4yBim7pUzNZ28YK714Igh5d2R/cef/Ob/6cJS4xOm6eTgihNmkzInDrx/4yKZ5KZwMG2n0jFO+/r0ku8w41VFKPAbdbq9ekrLs3ohnqRRTq3Ctv/o3a5jcko+t1mH1yAaadyg7D/HRim9+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714820200; c=relaxed/simple;
	bh=s9KRctzzpU59+kWtt7pRx5LfYMLjPZQcer89OqPBTvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnPZDtlbW108lCUmkOsqYZl1lVDpNhrqrY/I8s0l9f1ycN4CJRmr5JaHwWcLQO7D1FJnmBgKiuDo/jmjgZDZNxlhUtL9zNbrEjpL4XCzGAcli4Cdyym7EzDHHtyEXmCTxOYauMlpHr7XuV4hSq2zvSG+XIAxgVjTkkNiGPBFJgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnmMvUfe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17WVN2Y7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 4 May 2024 12:56:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714820196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnXpjKDzSmKzuITuxyK11zrEmBGX8AazM0Pu2GhWHdY=;
	b=DnmMvUfeBwAIxtyBbT6O782nWNT20kzvc7aVuka+1uisuJQEW4rmE7wlpqDvPpQxtrxEZ1
	wDUJtuhloso/Ry/UOxXXGlr71qAoA8enxlo28jOuePdd3+GDsjJZRjswSeXYFARN/KkeW+
	4AbS4tj75mRHZEedxH8kxZXCBGrN+OC2baIPusxWWMlaPt+ProNCjyshbWI7e+u233EWqq
	zKoz4nQMy3QrN34lLNvtpn1jv+PbJ1NkVcab7My5H8Dz3zKVp9i3vGvJX5Q52Y3DJ2IMfe
	xbnjcIKCit086OE5dB/xmMNszWCii8EUYczwBc3npbLvpKaKuwDIKP4lbU6+5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714820196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnXpjKDzSmKzuITuxyK11zrEmBGX8AazM0Pu2GhWHdY=;
	b=17WVN2Y7Lx/LAyKn3wf8HTUezuzQIrcjrMaTgkEuLRXxz08ss6t01hL7wzG67z4S+2nWJ0
	ynw4cpBJT6rFdJCQ==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <20240504105630.DPSzrgHe@linutronix.de>
References: <cover.1714762038.git.namcao@linutronix.de>
 <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
 <ZjX3t1NerOlGBhzw@wunner.de>
 <20240504093529.p8pbGxuK@linutronix.de>
 <ZjYFOrGlluGW_GzV@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjYFOrGlluGW_GzV@wunner.de>

On Sat, May 04, 2024 at 11:51:54AM +0200, Lukas Wunner wrote:
> On Sat, May 04, 2024 at 11:35:29AM +0200, Nam Cao wrote:
> > pci_stop_and_remove_bus_device() is not necessary to prevent kernel
> > crashing. But without this, we cannot hot-plug any other devices to this
> > slot afterward, despite the bridge has already been removed. Below is what
> > happens without pci_stop_and_remove_bus_device().
> > 
> > First, we hotplug a bridge. That fails, so QEMU removes this bridge:
> > (qemu) device_add pci-bridge,id=br2,bus=br1,chassis_nr=19,addr=1
> > [    9.289609] shpchp 0000:01:00.0: Latch close on Slot(1-1)
> > [    9.291145] shpchp 0000:01:00.0: Button pressed on Slot(1-1)
> > [    9.292705] shpchp 0000:01:00.0: Card present on Slot(1-1)
> > [    9.294369] shpchp 0000:01:00.0: PCI slot #1-1 - powering on due to button press
> > [   15.529997] pci 0000:02:01.0: [1b36:0001] type 01 class 0x060400 conventional PCI bridge
> > [   15.533907] pci 0000:02:01.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
> > [   15.535802] pci 0000:02:01.0: PCI bridge to [bus 00]
> > [   15.538519] pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
> > [   15.540261] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
> > [   15.543486] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> > [   15.547151] pci 0000:02:01.0: No bus number available for hot-added bridge
> > [   15.549067] shpchp 0000:01:00.0: Cannot add device at 0000:02:01
> > [   15.553104] shpchp 0000:01:00.0: Latch open on Slot(1-1)
> > [   15.555246] shpchp 0000:01:00.0: Card not present on Slot(1-1)
> 
> I'm not familiar with shpchp, I don't understand why it's thinking
> that there's no card after it failed to find a bus number.

Sorry, I got mixed up between the two.
 
> Could you reproduce with pciehp instead of shpchp please?

Same thing for pciehp below. I think the problem is because without 
pci_stop_and_remove_bus_device(), no one cleans up the device added in
pci_scan_slot(). When another device get hot-added, pci_get_slot() wrongly
thinks another device is already there, so the hot-plug fails.

Best regards,
Nam

(qemu) device_add pcie-pci-bridge,id=br1,bus=rp1
[   19.840550] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0009 from Slot Status
[   19.842843] pcieport 0000:00:03.0: pciehp: Slot(1): Button press: will power on in 5 sec
[   19.845289] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   19.847502] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 2c0
[   19.849876] pcieport 0000:00:03.0: pciehp: pciehp_check_link_active: lnk_status = 2011
[   19.852094] pcieport 0000:00:03.0: pciehp: Slot(1): Card present
[   19.853809] pcieport 0000:00:03.0: pciehp: Slot(1): Link Up
[   19.855412] pcieport 0000:00:03.0: pciehp: pciehp_get_power_status: SLOTCTRL 6c value read 6f1
[   19.857975] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   19.860199] pcieport 0000:00:03.0: pciehp: pciehp_power_on_slot: SLOTCTRL 6c write cmd 0
[   19.862586] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   19.864806] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 200
[   20.994936] pcieport 0000:00:03.0: pciehp: pciehp_check_link_status: lnk_status = 2011
[   20.997463] pci 0000:01:00.0: [1b36:000e] type 01 class 0x060400 PCIe to PCI/PCI-X bridge
[   21.001131] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
[   21.003071] pci 0000:01:00.0: PCI bridge to [bus 00]
[   21.005417] pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
[   21.007181] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
[   21.010084] pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   21.014162] pci 0000:01:00.0: vgaarb: pci_notify
[   21.015900] pci 0000:01:00.0: No bus number available for hot-added bridge
[   21.017865] pcieport 0000:00:03.0: pciehp: Cannot add device at 0000:01:00
[   21.019931] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   21.022178] pcieport 0000:00:03.0: pciehp: pciehp_power_off_slot: SLOTCTRL 6c write cmd 400
[   22.084607] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0018 from Slot Status
[   22.086845] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 340
[   22.089323] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   22.091539] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 300
[   22.093913] pcieport 0000:00:03.0: pciehp: pciehp_check_link_active: lnk_status = 11

(qemu) device_add e1000,bus=rp1,id=eth1
[   58.389527] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0009 from Slot Status
[   58.391789] pcieport 0000:00:03.0: pciehp: Slot(1): Button press: will power on in 5 sec
[   58.394175] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   58.396365] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 2c0
[   58.398681] pcieport 0000:00:03.0: pciehp: pciehp_check_link_active: lnk_status = 2011
[   58.400871] pcieport 0000:00:03.0: pciehp: Slot(1): Card present
[   58.402542] pcieport 0000:00:03.0: pciehp: Slot(1): Link Up
[   58.404154] pcieport 0000:00:03.0: pciehp: pciehp_get_power_status: SLOTCTRL 6c value read 6f1
[   58.406627] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   58.408798] pcieport 0000:00:03.0: pciehp: pciehp_power_on_slot: SLOTCTRL 6c write cmd 0
[   58.411213] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   58.413386] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 200
[   59.523011] pcieport 0000:00:03.0: pciehp: pciehp_check_link_status: lnk_status = 2011
[   59.525256] pcieport 0000:00:03.0: pciehp: Device 0000:01:00.0 already exists at 0000:01:00, skipping hot-add
[   59.528139] pcieport 0000:00:03.0: pciehp: pending interrupts 0x0010 from Slot Status
[   59.530325] pcieport 0000:00:03.0: pciehp: pciehp_set_indicators: SLOTCTRL 6c write cmd 1c0

