Return-Path: <linux-pci+bounces-30505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0475AE656B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6ACB4C1AD6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F6298CD7;
	Tue, 24 Jun 2025 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEYhdUxa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531052BDC06;
	Tue, 24 Jun 2025 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769337; cv=none; b=J5Y4Q53qArOhsAdtsnS2g1y032b5pP95n7sjdR0mxs0d7bBnXPD3wJzGYDWHlQ8oGkpZcY96nHtjF24aCers15kl0AtMORZO29fgqszhdJgBHcrzx9mlznc0T530pf+yx2MsW2GheSzjRIMVX883ELZeRAwlhqLcIdsDLCXHBtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769337; c=relaxed/simple;
	bh=8Ix2Yu8WfDxcmsb51j41qezjfHG5UnQRJivXeCgJV40=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=l9V0R99QiNk2AtNnXd4YJ3XgYm1oD8XBgGyVCFerOExOnuU9cUfqCvXmwTeXiOqnmvaOpaSqbYZasVi+iHAGxB0z0DEDJVppAtia3CHMytsBTP0l0JzRXkn6aDG6l2HtAHAVSn8Mp6lKVBLQ/QRc7ovr6bAAgZ0d+jxmFJ7C7+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEYhdUxa; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750769329; x=1782305329;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=8Ix2Yu8WfDxcmsb51j41qezjfHG5UnQRJivXeCgJV40=;
  b=LEYhdUxasnxs0mPpjC1hfljlFVnk5Q5JTXFftjvtFHHOnVuyCGlcBfvH
   ZG+P1OBq4FpREQC5ccUd6wH4qZiS+YLSl/q1pyh/7y0WQ08Re590vS0SV
   OAOGzx2ziMfh8jXAktpeb1FISDeWN6DiJiZVnAnXaJK7p2tUy44JyOn6y
   Kw3KO1iQmrpP7lmKF+09HlMaggV2cSCvjXhYCQSGauV1NFOn6vpbyQdA0
   zewi124vSXluba8m75PAk9ESua3fbwZg9Rmz6Ho119ryEEhXzI0X88CLC
   CBJKGSmL50szwKqokX6yJEvdKXYTXIRfzu+lWXf5cMQho65xcBf00x9el
   g==;
X-CSE-ConnectionGUID: I+behXDNT+KoBStNzTnOuw==
X-CSE-MsgGUID: mPewiGJGQpiPyoK3g3aH6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="75542890"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="75542890"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:48:43 -0700
X-CSE-ConnectionGUID: Brx7dDenRYOS+3lnySp+Eg==
X-CSE-MsgGUID: qwY2Y/LoRSSJUDW6JMqxsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="189090767"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 05:48:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 15:48:36 +0300 (EEST)
To: D Scott Phillips <scott@os.amperecomputing.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <86plf0lgit.fsf@scott-ph-mail.amperecomputing.com>
Message-ID: <78aed75b-137b-b48e-3699-20fcde248680@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <86plf0lgit.fsf@scott-ph-mail.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1510153036-1750767620=:943"
Content-ID: <de89ff86-b250-aee6-9f01-e36250ef8e17@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1510153036-1750767620=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <7466805e-576c-2257-9292-d520bd7c339b@linux.intel.com>

On Wed, 18 Jun 2025, D Scott Phillips wrote:

> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> writes:
>=20
> > Resetting resource is problematic as it prevent attempting to allocate
> > the resource later, unless something in between restores the resource.
> > Similarly, if fail_head does not contain all resources that were reset,
> > those resource cannot be restored later.
> >
> > The entire reset/restore cycle adds complexity and leaving resources
> > into reseted state causes issues to other code such as for checks done
> > in pci_enable_resources(). Take a small step towards not resetting
> > resources by delaying reset until the end of resource assignment and
> > build failure list (fail_head) in sync with the reset to avoid leaving
> > behind resources that cannot be restored (for the case where the caller
> > provides fail_head in the first place to allow restore somewhere in the
> > callchain, as is not all callers pass non-NULL fail_head).
> >
> > The Expansion ROM check is temporarily left in place while building the
> > failure list until the upcoming change which reworks optional resource
> > handling.
> >
> > Ideally, whole resource reset could be removed but doing that in a big
> > step would make the impact non-tractable due to complexity of all
> > related code.
> >
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Hi Ilpo, I'm seeing a crash on arm64 at boot that I bisected to this
> change. I don't think it's the same as the other issues reported. I've
> confirmed the crash is still there after your follow up patches.  The
> crash itself is below[1].

Thanks for the report. I'm sorry about the delay, I was away a few days
(and hoping all the gremlins in that resource change would already have=20
been finally solved but it seems my hopes were premature).

> It looks like the problem begins when:
>=20
> amdgpu_device_resize_fb_bar()
>  pci_resize_resource()
>   pci_reassign_bridge_resources()
>    __pci_bus_size_bridges()
>=20
> adds pci_hotplug_io_size to `realloc_head`. The io resource allocation
> has failed earlier because the root port doesn't have an io window[2].
>=20
> Then with this patch, pci_reassign_bridge_resources()'s call to
> __pci_bridge_assign_resources() now returns the io added space for
> hotplug in the `failed` list where the old code dropped it and did not.
>=20
> That sends pci_reassign_bridge_resources() into the `cleanup:` path,
> where I think the cleanup code doesn't properly release the resources
> that were assigned by __pci_bridge_assign_resources() and there's a
> conflict reported in pci_claim_resource() where a restored resource is
> found as conflicting with itself:
>=20
> > pcieport 000d:00:01.0: bridge window [mem 0x340000000000-0x340017ffffff=
 64bit pref]: can't claim; address conflict with PCI Bus 000d:01 [mem 0x340=
000000000-0x340017ffffff 64bit pref]
>=20
> Setting `pci=3Dhpiosize=3D0` avoids this crash, as does this change:
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 16d5d390599a..59ece11702da 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2442,7 +2442,7 @@ int pci_reassign_bridge_resources(struct pci_dev *b=
ridge, unsigned long type)
>  =09LIST_HEAD(saved);
>  =09LIST_HEAD(added);
>  =09LIST_HEAD(failed);
> -=09unsigned int i;
> +=09unsigned int i, relevant_fails;
>  =09int ret;
> =20
>  =09down_read(&pci_bus_sem);
> @@ -2490,7 +2490,16 @@ int pci_reassign_bridge_resources(struct pci_dev *=
bridge, unsigned long type)
>  =09__pci_bridge_assign_resources(bridge, &added, &failed);
>  =09BUG_ON(!list_empty(&added));
> =20
> -=09if (!list_empty(&failed)) {
> +=09relevant_fails =3D 0;
> +=09list_for_each_entry(dev_res, &failed, list) {
> +=09=09restore_dev_resource(dev_res);
> +=09=09if (((dev_res->res->flags ^ type) & PCI_RES_TYPE_MASK) =3D=3D 0)
> +=09=09=09relevant_fails++;
> +=09}
> +=09free_list(&failed);
> +
> +=09/* Cleanup if we had failures in resources of interest */
> +=09if (relevant_fails !=3D 0) {
>  =09=09ret =3D -ENOSPC;
>  =09=09goto cleanup;
>  =09}
> @@ -2509,11 +2518,6 @@ int pci_reassign_bridge_resources(struct pci_dev *=
bridge, unsigned long type)
>  =09return 0;
> =20
>  cleanup:
> -=09/* Restore size and flags */
> -=09list_for_each_entry(dev_res, &failed, list)
> -=09=09restore_dev_resource(dev_res);
> -=09free_list(&failed);
> -
>  =09/* Revert to the old configuration */
>  =09list_for_each_entry(dev_res, &saved, list) {
>  =09=09struct resource *res =3D dev_res->res;
>=20
> I don't know this code well enough to know if that changes is completely
> bonkers or what.

It will take me a bit of time to assimilate all the information too, this=
=20
code has astronomical complexity and a failure due to resize is yet=20
another angle to it. I'll get back to you once I've figured more out.

> Maybe a change that gets zero as pci_hotplug_io_size
> for root ports that don't have an io window would be better?

Similar to this, I personally don't like having a non-zero IO window for=20
the cases where there is no io ports required for any devices. On dual=20
socket systems here, it always leads to exhausting the io port space and=20
the later probed devices that would actually have io port resources will=20
not get them. While those failures are not critical/important in my case,=
=20
it seems pointless to allocate IO window just for that sake of potential=20
hotplug, hotplug could just get it when there's a true need for the IO
window (and nothing bogusly reserved all io port space).

So IMO, a patch to change the default hotplug IO window to zero would=20
make sense which effectively matches what you provided on the cmdline. But=
=20
this is said before fully understanding what goes wrong on the resize=20
path, it may need corrections too. But regardless of that, I think zeroing=
=20
HP IO window is worthwhile on its own right to avoid exhausting the IO=20
port space for nothing.

> Any other
> ideas, or other information about the crash that I could provide?

I suppose the actual crash itself is because the driver does make some=20
invalid assumption about the resources without checking the resources=20
first (I've not had time to locate and check the driver code yet).

> [1]: Crash:
> > SError Interrupt on CPU0, code 0x00000000be000411 -- SError
> > CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.15.2+ #16 PREEMPT(=
undef)
> > Hardware name: Adlink Ampere Altra Developer Platform/Ampere Altra Deve=
loper Platform, BIOS TianoCore 2.09.100.00 (SYS: 2.10.20221028) 04/30/2
> > Workqueue: events work_for_cpu_fn
> > pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > pc : _raw_spin_lock_irqsave+0x34/0xb0
> > lr : __wake_up+0x30/0x80
> > sp : ffff800080003e20
> > x29: ffff800080003e20 x28: ffff07ff808b0000 x27: 0000000000050260
> > x26: 0000000000000001 x25: ffffcc5decad6bd8 x24: ffffcc5decc8b5b8
> > x23: ffff080138a10000 x22: ffff080138a00000 x21: 0000000000000003
> > x20: ffff080138a14dc8 x19: 0000000000000000 x18: 006808018e775f03
> > x17: ffff3bc1330d2000 x16: ffffcc5e3a520ed8 x15: 8daad055c6e77021
> > x14: f231631cf9328575 x13: 0e51168d06a6cf91 x12: f5db8c23b764520c
> > x11: 0000000000000040 x10: 0000000000000000 x9 : ffffcc5e3a520f08
> > x8 : 0000000000002113 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : 0000000000000000 x4 : ffff800080003e08 x3 : 00000000000000c0
> > x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff080138a14dc8
> > Kernel panic - not syncing: Asynchronous SError Interrupt
> > CPU: 0 UID: 0 PID: 9 Comm: kworker/0:0 Not tainted 6.15.2+ #16 PREEMPT(=
undef)
> > Hardware name: Adlink Ampere Altra Developer Platform/Ampere Altra Deve=
loper Platform, BIOS TianoCore 2.09.100.00 (SYS: 2.10.20221028) 04/30/2
> > Workqueue: events work_for_cpu_fn
> > Call trace:
> >  show_stack+0x30/0x98 (C)
> >  dump_stack_lvl+0x7c/0xa0
> >  dump_stack+0x18/0x2c
> >  panic+0x184/0x3c0
> >  nmi_panic+0x90/0xa0
> >  arm64_serror_panic+0x6c/0x90
> >  do_serror+0x58/0x60
> >  el1h_64_error_handler+0x38/0x60
> >  el1h_64_error+0x84/0x88
> >  _raw_spin_lock_irqsave+0x34/0xb0 (P)
> >  amdgpu_ih_process+0xf0/0x150 [amdgpu]
> >  amdgpu_irq_handler+0x34/0xa0 [amdgpu]
> >  __handle_irq_event_percpu+0x60/0x248
> >  handle_irq_event+0x4c/0xc0
> >  handle_fasteoi_irq+0xa0/0x1c8
> >  handle_irq_desc+0x3c/0x68
> >  generic_handle_domain_irq+0x24/0x40
> >  __gic_handle_irq_from_irqson.isra.0+0x15c/0x260
> >  gic_handle_irq+0x28/0x80
> >  call_on_irq_stack+0x24/0x30
> >  do_interrupt_handler+0x88/0xa0
> >  el1_interrupt+0x44/0xd0
> >  el1h_64_irq_handler+0x18/0x28
> >  el1h_64_irq+0x84/0x88
> >  amdgpu_device_rreg.part.0+0x4c/0x190 [amdgpu] (P)
> >  amdgpu_device_rreg+0x24/0x40 [amdgpu]
> >  psp_wait_for+0x88/0xd8 [amdgpu]
> >  psp_v11_0_bootloader_load_component+0x164/0x1b0 [amdgpu]
> >  psp_v11_0_bootloader_load_kdb+0x20/0x40 [amdgpu]
> >  psp_hw_start+0x5c/0x580 [amdgpu]
> >  psp_load_fw+0x9c/0x280 [amdgpu]
> >  psp_hw_init+0x44/0xa0 [amdgpu]
> >  amdgpu_device_fw_loading+0xf8/0x358 [amdgpu]
> >  amdgpu_device_ip_init+0x684/0x990 [amdgpu]
> >  amdgpu_device_init+0xba4/0x1038 [amdgpu]
> >  amdgpu_driver_load_kms+0x20/0xb8 [amdgpu]
> >  amdgpu_pci_probe+0x1f8/0x7f8 [amdgpu]
> >  local_pci_probe+0x44/0xb0
> >  work_for_cpu_fn+0x24/0x40
> >  process_one_work+0x17c/0x410
> >  worker_thread+0x254/0x388
> >  kthread+0x10c/0x128
> >  ret_from_fork+0x10/0x20
> > Kernel Offset: 0x4c5dba380000 from 0xffff800080000000
> > PHYS_OFFSET: 0x80000000
> > CPU features: 0x0800,000042e0,01202650,8241720b
> > Memory Limit: none
> > ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---
>=20
> [2]: boot snippet
> > ACPI: PCI Root Bridge [PCI1] (domain 000d [bus 00-ff])
> > acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segment=
s MSI EDR HPX-Type3]
> > acpi PNP0A08:01: _OSC: platform does not support [PCIeHotplug PME LTR D=
PC]
> > acpi PNP0A08:01: _OSC: OS now controls [PCIeCapability]
> > acpi PNP0A08:01: FADT indicates ASPM is unsupported, using BIOS configu=
ration
> > acpi PNP0A08:01: MCFG quirk: ECAM at [mem 0x37fff0000000-0x37ffffffffff=
] for [bus 00-ff] with pci_32b_read_ops
> > acpi PNP0A08:01: ECAM area [mem 0x37fff0000000-0x37ffffffffff] reserved=
 by PNP0C02:00
> > acpi PNP0A08:01: ECAM at [mem 0x37fff0000000-0x37ffffffffff] for [bus 0=
0-ff]
> > PCI host bridge to bus 000d:00
> > pci_bus 000d:00: root bus resource [mem 0x50000000-0x5fffffff window]
> > pci_bus 000d:00: root bus resource [mem 0x340000000000-0x37ffdfffffff w=
indow]
> > pci_bus 000d:00: root bus resource [bus 00-ff]
> > pci 000d:00:00.0: [1def:e100] type 00 class 0x060000 conventional PCI e=
ndpoint
> > pci 000d:00:01.0: [1def:e101] type 01 class 0x060400 PCIe Root Port
> > pci 000d:00:01.0: PCI bridge to [bus 01-03]
> > pci 000d:00:01.0:   bridge window [io  0xe000-0xefff]
> > pci 000d:00:01.0:   bridge window [mem 0x50000000-0x502fffff]
> > pci 000d:00:01.0:   bridge window [mem 0x340000000000-0x3400101fffff 64=
bit pref]
> > pci 000d:00:01.0: supports D1 D2
> > pci 000d:00:01.0: PME# supported from D0 D1 D3hot
> > ...
> > pci 000d:00:01.0: bridge window [mem 0x340000000000-0x340017ffffff 64bi=
t pref]: assigned
> > pci 000d:00:01.0: bridge window [mem 0x50000000-0x502fffff]: assigned
> > pci 000d:00:01.0: bridge window [io  size 0x1000]: can't assign; no spa=
ce
> > pci 000d:00:01.0: bridge window [io  size 0x1000]: failed to assign
> > pci 000d:00:01.0: bridge window [io  size 0x1000]: can't assign; no spa=
ce
> > pci 000d:00:01.0: bridge window [io  size 0x1000]: failed to assign
>=20

--=20
 i.
--8323328-1510153036-1750767620=:943--

