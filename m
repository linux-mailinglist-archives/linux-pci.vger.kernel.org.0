Return-Path: <linux-pci+bounces-37757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93393BC8AE6
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 13:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9867B4F53F0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45CD217704;
	Thu,  9 Oct 2025 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7Y/gv7D"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3072D1F4E;
	Thu,  9 Oct 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007776; cv=none; b=Nuw2I/Chdga7ConPlw7RgtW3vgFvjft2dmpJKOkVZ5y2uIJJgzo8jYr8y9fPlf1JyQUggs1y5KcGu42DY+lcOEvG17Q8hbCZX04zKkrT/E072jMdhVpWrdEbvwpZtc4zhldTmI8Kwdl1QATthT3wKiS3y+On8dJe85SNUMQifeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007776; c=relaxed/simple;
	bh=Vq7oGzjqucn5ulUwqAMwacYd92lP8JOxW98E6JeOzj0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U6Yo40DELFg+KodrNzYIiCXbFJGFju0KEna3EllV8pyN945mC/ORcirIDOAa2LQ7O2Cq8xNdtcFYq4vjL5BSLZmfkC53+vH3LuYx3cZaoNlAsReDqHN6UFy4s0tJVdMnQy2maQISi9nO9k+eXHmSKrYEbYYn9idFIyWMdCy9HUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7Y/gv7D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760007774; x=1791543774;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Vq7oGzjqucn5ulUwqAMwacYd92lP8JOxW98E6JeOzj0=;
  b=H7Y/gv7D2ShU0vRGqs1XdCG3O/uYg0SRMsS5AuOhfvAFAITe9dTRNNWt
   GS++MpI6AkmdaeUS6lLXFh8b+mSk9QEvNEeKXG26LlqEcS01SsHcHyqnh
   0LDvYTyL1bYN0nk2oNVgUhoyQ93hkIenVDdrjF3/GVhl6WAV9GVvmD+33
   raF+hMvYaAAw8xc3jMWCec/TxjQHIcstecVJx74fOvUW77QNMAsLlrZrC
   FGrDbQ7vQ8YYNPjQVA4/GcnS0PpgkWJnma8IUWgj97G4L1mH0VJ/6ssnt
   I2PZZjmSYwzhU1oQlTpHI6UiO8IjSjCQo6A3vHc95BDkU2eZRf9sZgYGA
   A==;
X-CSE-ConnectionGUID: XBKpJ/J8R0a86WbKZuhaGQ==
X-CSE-MsgGUID: C893O09XQqeHZGOznHedGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="49778379"
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="49778379"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 04:02:54 -0700
X-CSE-ConnectionGUID: Hz1NnZ2HQKiBshdhRdy78Q==
X-CSE-MsgGUID: MZ0XjDnWTgeWIDkfK2Wtzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,216,1754982000"; 
   d="scan'208";a="180265763"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2025 04:02:52 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 9 Oct 2025 14:02:48 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Yangyu Chen <cyy@cyyself.name>, linux-pci@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] PCI: Fix regression in
 pci_bus_distribute_available_resources
In-Reply-To: <20251008200930.GA638461@bhelgaas>
Message-ID: <56429ac6-8188-ce6c-eec1-0de7f93e912c@linux.intel.com>
References: <20251008200930.GA638461@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 8 Oct 2025, Bjorn Helgaas wrote:
> On Wed, Oct 08, 2025 at 10:36:52PM +0800, Yangyu Chen wrote:
> > The refactoring in upstream commit 4292a1e45fd4 ("PCI: Refactor
> > distributing available memory to use loops") switched
> > pci_bus_distribute_available_resources to operate on an array of bridge
> > windows. That rewrite accidentally looked up bus resources via
> > pci_bus_resource_n and then passed those pointers to helper routines
> > that expect the resource to belong to the device. As soon as we
> > execute that code, pci_resource_num warned because the resource
> > wasn't in the bridge's resource array.
> > 
> > This happens on my AMD Strix Halo machine with Thunderbolt device, the
> > error message is shown below:
> > 
> > [    4.212389] ------------[ cut here ]------------
> > [    4.212391] WARNING: CPU: 6 PID: 272 at drivers/pci/pci.h:471 pci_bus_distribute_available_resources+0x6ad/0x6d0
> > [    4.212400] Modules linked in: raid6_pq(+) hid_generic uas usb_storage scsi_mod usbhid hid scsi_common amdgpu amdxcp drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec i2c_algo_bit drm_suballoc_helper drm_display_helper cec rc_core drm_client_lib drm_kms_helper sdhci_pci sdhci_uhs2 xhci_pci sp5100_tco xhci_hcd r8169 drm nvme sdhci watchdog realtek usbcore thunderbolt cqhci atlantic nvme_core mdio_devres psmouse libphy mmc_core nvme_keyring video i2c_piix4 macsec nvme_auth serio_raw mdio_bus i2c_smbus usb_common crc16 hkdf wmi
> > [    4.212443] CPU: 6 UID: 0 PID: 272 Comm: irq/33-pciehp Not tainted 6.17.0+ #1 PREEMPT(voluntary)
> > [    4.212447] Hardware name: PELADN YO Series/YO1, BIOS 1.04 05/15/2025
> > [    4.212449] RIP: 0010:pci_bus_distribute_available_resources+0x6ad/0x6d0
> > [    4.212453] Code: ff e9 a2 48 c7 c7 b8 b7 83 a3 4c 89 4c 24 18 e8 a9 2a fb ff 4c 8b 4c 24 18 e9 ca fd ff ff 48 8b 05 60 53 47 01 e9 94 fe ff ff <0f> 0b e9 5d fe ff ff 48 8b 05 55 53 47 01 e9 81 fe ff ff e8 4b 87
> > [    4.212455] RSP: 0018:ffffaffcc0d4f9a8 EFLAGS: 00010206
> > [    4.212458] RAX: 00000000000000cd RBX: ffff9721a687f800 RCX: ffff9721a687c828
> > [    4.212459] RDX: 0000000000000000 RSI: 00000000000000cd RDI: ffff97218bc8a3c0
> > [    4.212461] RBP: ffff9721a687c828 R08: ffffaffcc0d4f9f8 R09: 0000000000000001
> > [    4.212462] R10: ffff97218bc8d700 R11: 0000000000000000 R12: ffffaffcc0d4f9f8
> > [    4.212462] R13: ffffaffcc0d4f9f8 R14: 0000000000000000 R15: ffff97218bc8a000
> > [    4.212464] FS:  0000000000000000(0000) GS:ffff973ee1ad9000(0000) knlGS:0000000000000000
> > [    4.212465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    4.212467] CR2: 00005640b0f29360 CR3: 0000000ccb224000 CR4: 0000000000f50ef0
> > [    4.212469] PKRU: 55555554
> > [    4.212470] Call Trace:
> > [    4.212473]  <TASK>
> > [    4.212478]  pci_bus_distribute_available_resources+0x590/0x6d0
> > [    4.212483]  pci_bridge_distribute_available_resources+0x62/0xb0
> > [    4.212487]  pci_assign_unassigned_bridge_resources+0x65/0x1b0
> > [    4.212490]  pciehp_configure_device+0x92/0x160
> > [    4.212495]  pciehp_handle_presence_or_link_change+0x1b5/0x350
> > [    4.212498]  pciehp_ist+0x147/0x1c0
> > [    4.212502]  irq_thread_fn+0x20/0x60
> > [    4.212508]  irq_thread+0x1cc/0x360
> > [    4.212511]  ? __pfx_irq_thread_fn+0x10/0x10
> > [    4.212515]  ? __pfx_irq_thread_dtor+0x10/0x10
> > [    4.212518]  ? __pfx_irq_thread+0x10/0x10
> > [    4.212521]  kthread+0xf9/0x240
> > [    4.212525]  ? __pfx_kthread+0x10/0x10
> > [    4.212528]  ret_from_fork+0x195/0x1d0
> > [    4.212533]  ? __pfx_kthread+0x10/0x10
> > [    4.212536]  ret_from_fork_asm+0x1a/0x30
> > [    4.212540]  </TASK>
> > [    4.212541] ---[ end trace 0000000000000000 ]---
> > 
> > Fix the regression by always fetching the resource directly from the
> > bridge: use pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i). This
> > restores the original behaviour while keeping the refactored structure.
> > And then we can successfully assign resources to the Thunderbolt device.
> > 
> > Fixes: 4292a1e45fd4 ("PCI: Refactor distributing available memory to use loops")
> > 
> > Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> 
> Tentatively applied to pci/for-linus for v6.18, pending Ilpo's review.

Thanks to Yangyu for the patch. 

I see it already was pulled by Linus. No big objection to this as it 
clearly seems to help and should cause no issue to move back to use 
pci_resource_n().

However, that change to pci_bus_resource_n() was very much done 
intentionally as those two calls should have been equivalent. Initially
I was perplexed how this change can fix anything but it seem one of my 
pci_bus_resource_n() conversions was wrong...

> Thank you very much for debugging and providing a patch!
> 
> > ---
> >  drivers/pci/setup-bus.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 362ad108794d..4a8735b275e4 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -2085,7 +2085,8 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	int i;
> >  
> >  	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> > -		struct resource *res = pci_bus_resource_n(bus, i);
> > +		struct resource *res =
> > +			pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);

Was this change actually necessary to fix anything or was it changed just 
due to noticing the other case?

> >  
> >  		available[i] = available_in[i];
> >  
> > @@ -2158,7 +2159,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  			continue;
> >  
> >  		for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
> > -			res = pci_bus_resource_n(bus, i);
> > +			res = pci_resource_n(dev, PCI_BRIDGE_RESOURCES + i);

This was misconverted by me, as dev is not same as bridge here, so it 
should have been pci_bus_resource_n(b, i); (b is dev->subordinate).

-- 
 i.


