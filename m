Return-Path: <linux-pci+bounces-24755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E4AA7154B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB30116BF27
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 11:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A701AF0CA;
	Wed, 26 Mar 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZfxYTZXA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129E21D4356;
	Wed, 26 Mar 2025 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987132; cv=none; b=GLOzOWgd85prVExtCZ6SqSi+WixJR61TjOxHWmsvBGxiAjk13D3ehy1/bvJvKcrsrk0ia7N3Y/qJkMuFjEuIyhMDNe13kEK7YQEPjlCfIhW7VKkGLUxs9nrzbSlhSX40VQys1fg2ChWJ3/k6cuDnggHN1CnYoAMIUUl5E5yI1xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987132; c=relaxed/simple;
	bh=PQmbymTbfkcdRHkDMrXhnqkfOHzY9W0cRocA7k8l6so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVNatpD6ljChlFXSf97NG2woB5NtFzCYcWGn6ERDHkHRe7F2yBrKHb4CvyiFZN8/yrXP1PzU8tkYR41o2X2LN9qp93pgURgcGjAH7UWF/zCNzG9bN6BayR2zNe4D3ctXddMwnuQLXr+Ph6FyFcYLxXL9pWxk7wo5Hq1M7rOcMxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZfxYTZXA reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0614040E021F;
	Wed, 26 Mar 2025 11:05:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uiaUnygCJD3i; Wed, 26 Mar 2025 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742987114; bh=AIajk1zv3OvH1Ipjg8jxRnUw8MsF0F9Mfe1IOdT15RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfxYTZXAG6zXzF//9pke+YZaisHXBI/hXhjX7EtPx8wvwYQoFEZ3LJRs+NY2W2rx+
	 lQnhRsHG+gikYK6Q+7YEgDQJHqPcFjNCR48ler2zCCMFjyGiTF27XfFZD4xA+MCxd6
	 jF57KSjm0ZtLtIyeONuO6wdMKfIARDQBZitU3IvI0pOUKPUrFj+fudXrYvQD8bKGVz
	 6NpWVy1yhggl8+3pwmXxxOFW3D1bjqdkjUKQXaY7C2ony/PHgJhV0FBz9uDP35Xc3y
	 OK4Efj70OYgFnH6c11PVIQRT+zvK2VLBX0FcY5TwT4IkLUayopa9B6x4xiCDQThgN/
	 3bZyVRtu06CiZ8N/ysAELLR0iR2diP+3yGT9KeGFoGhUUrpy8PpZ3zlgKvEnMEOmEr
	 8F+zvcBkEpZ4EYd55K4lMWU0XcScsFCo/cJh45vm/XKrQqLxpXKzyyEOHJoxxLBbmw
	 m5UCDrVCauYkdpPmo4NDgAMb/SGwLkAoqTXrB/iMcqYHX02sqryb7zt44ia0E+1PG0
	 GyqyhZTIQiaP3qkBe+WUj7ekyn2h+DoTQOvpVsAYcRtaqiNNz0dW+IBqGaSWi2sRc5
	 lH678VDRrLa+IblO9r9W5JJFFi4riMgxfQ80UcJ6wG/qsV9qaSdnECdwLeI/zDhfKc
	 WuKp/f3Qrdn/6ZCvgnQDLYP0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E1DB340E0214;
	Wed, 26 Mar 2025 11:05:01 +0000 (UTC)
Date: Wed, 26 Mar 2025 12:04:55 +0100
From: Borislav Petkov <bp@alien8.de>
To: Roger Pau Monne <roger.pau@citrix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <20250326110455.GAZ-PfV3kOiQw97fDj@fat_crate.local>
References: <20250219092059.90850-1-roger.pau@citrix.com>
 <20250219092059.90850-4-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219092059.90850-4-roger.pau@citrix.com>
Content-Transfer-Encoding: quoted-printable

+ Linus so that he can whack it before it spreads any further.

On Wed, Feb 19, 2025 at 10:20:57AM +0100, Roger Pau Monne wrote:
> Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for b=
oth
> MSI and MSI-X entries globally, regardless of the IRQ chip they are usi=
ng.
> Only Xen sets the pci_msi_ignore_mask when routing physical interrupts =
over
> event channels, to prevent PCI code from attempting to toggle the maskb=
it,
> as it's Xen that controls the bit.
>=20
> However, the pci_msi_ignore_mask being global will affect devices that =
use
> MSI interrupts but are not routing those interrupts over event channels
> (not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
> bridge.  In that scenario the VMD bridge configures MSI(-X) using the
> normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
> bridge configure the MSI entries using indexes into the VMD bridge MSI
> table.  The VMD bridge then demultiplexes such interrupts and delivers =
to
> the destination device(s).  Having pci_msi_ignore_mask set in that scen=
ario
> prevents (un)masking of MSI entries for devices behind the VMD bridge.
>=20
> Move the signaling of no entry masking into the MSI domain flags, as th=
at
> allows setting it on a per-domain basis.  Set it for the Xen MSI domain
> that uses the pIRQ chip, while leaving it unset for the rest of the
> cases.
>=20
> Remove pci_msi_ignore_mask at once, since it was only used by Xen code,=
 and
> with Xen dropping usage the variable is unneeded.
>=20
> This fixes using devices behind a VMD bridge on Xen PV hardware domains=
.
>=20
> Albeit Devices behind a VMD bridge are not known to Xen, that doesn't m=
ean
> Linux cannot use them.  By inhibiting the usage of
> VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mas=
k
> bodge devices behind a VMD bridge do work fine when use from a Linux Xe=
n
> hardware domain.  That's the whole point of the series.
>=20
> Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Juergen Gross <jgross@suse.com>

Did anyone actually test this on a normal KVM guest?

c3164d2e0d181027da8fc94f8179d8607c3d440f is the first bad commit
commit c3164d2e0d181027da8fc94f8179d8607c3d440f
Author: Roger Pau Monne <roger.pau@citrix.com>
Date:   Wed Feb 19 10:20:57 2025 +0100

    PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
   =20
    Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for=
 both
    MSI and MSI-X entries globally, regardless of the IRQ chip they are u=
sing.
    Only Xen sets the pci_msi_ignore_mask when routing physical interrupt=
s over
    event channels, to prevent PCI code from attempting to toggle the mas=
kbit,
    as it's Xen that controls the bit.
   =20
    However, the pci_msi_ignore_mask being global will affect devices tha=
t use
    MSI interrupts but are not routing those interrupts over event channe=
ls
    (not using the Xen pIRQ chip).  One example is devices behind a VMD P=
CI
    bridge.  In that scenario the VMD bridge configures MSI(-X) using the
    normal IRQ chip (the pIRQ one in the Xen case), and devices behind th=
e
    bridge configure the MSI entries using indexes into the VMD bridge MS=
I
    table.  The VMD bridge then demultiplexes such interrupts and deliver=
s to
    the destination device(s).  Having pci_msi_ignore_mask set in that sc=
enario
    prevents (un)masking of MSI entries for devices behind the VMD bridge=
.
   =20
    Move the signaling of no entry masking into the MSI domain flags, as =
that
    allows setting it on a per-domain basis.  Set it for the Xen MSI doma=
in
    that uses the pIRQ chip, while leaving it unset for the rest of the
    cases.
   =20
    Remove pci_msi_ignore_mask at once, since it was only used by Xen cod=
e, and
    with Xen dropping usage the variable is unneeded.
   =20
    This fixes using devices behind a VMD bridge on Xen PV hardware domai=
ns.
   =20
    Albeit Devices behind a VMD bridge are not known to Xen, that doesn't=
 mean
    Linux cannot use them.  By inhibiting the usage of
    VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_m=
ask
    bodge devices behind a VMD bridge do work fine when use from a Linux =
Xen
    hardware domain.  That's the whole point of the series.
   =20
    Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
    Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
    Acked-by: Juergen Gross <jgross@suse.com>
    Acked-by: Bjorn Helgaas <bhelgaas@google.com>
    Message-ID: <20250219092059.90850-4-roger.pau@citrix.com>
    Signed-off-by: Juergen Gross <jgross@suse.com>

 arch/x86/pci/xen.c    |  8 ++------
 drivers/pci/msi/msi.c | 37 +++++++++++++++++++++----------------
 include/linux/msi.h   |  3 ++-
 kernel/irq/msi.c      |  2 +-
 4 files changed, 26 insertions(+), 24 deletions(-)

[    1.254066] zram: Added device: zram0
[    1.255093] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    1.257577] ahci 0000:00:1f.2: version 3.0
[    1.259050] BUG: kernel NULL pointer dereference, address: 00000000000=
00000
[    1.261239] #PF: supervisor read access in kernel mode
[    1.261544] #PF: error_code(0x0000) - not-present page
[    1.261544] PGD 0=20
[    1.261544] Oops: Oops: 0000 [#1] SMP
[    1.261544] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0+ #=
1 PREEMPT(voluntary)=20
[    1.261544] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2=
023.11-8 02/21/2024
[    1.261544] RIP: 0010:msi_setup_msi_desc+0x75/0x170
[    1.261544] Code: 89 54 24 06 48 8d 54 24 06 f3 48 ab 48 89 ef e8 c1 6=
a fe ff 0f b7 44 24 06 f6 85 3f 08 00 00 10 74 08 80 cc 01 66 89 44 24 06=
 <41> 8b 16 81 e2 00 00 40 00 0f 85 bb 00 00 00 89 c6 66 c1 ee 08 83
[    1.261544] RSP: 0018:ffa0000000023980 EFLAGS: 00010246
[    1.261544] RAX: 0000000000000080 RBX: ffa0000000023988 RCX: 000000000=
0000082
[    1.261544] RDX: 0000000000000000 RSI: 0000000000000293 RDI: ffffffff8=
3a16138
[    1.261544] RBP: ff11000006fdd000 R08: 0000000000000002 R09: ffa000000=
0023964
[    1.261544] R10: 0000000000000000 R11: ffffffff81dd71e0 R12: 000000000=
0000000
[    1.261544] R13: 0000000000000001 R14: 0000000000000000 R15: 000000000=
0000001
[    1.261544] FS:  0000000000000000(0000) GS:ff110000f0b78000(0000) knlG=
S:0000000000000000
[    1.261544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.261544] CR2: 0000000000000000 CR3: 0000000002e23001 CR4: 000000000=
0771ef0
[    1.261544] PKRU: 55555554
[    1.261544] Call Trace:
[    1.261544]  <TASK>
[    1.261544]  ? __die_body.cold+0x19/0x29
[    1.261544]  ? page_fault_oops+0x15a/0x260
[    1.261544]  ? exc_page_fault+0x81/0x1b0
[    1.261544]  ? asm_exc_page_fault+0x26/0x30
[    1.261544]  ? pci_mmcfg_arch_unmap+0x40/0x40
[    1.261544]  ? msi_setup_msi_desc+0x75/0x170
[    1.261544]  __msi_capability_init+0x2d/0x2a0
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  ? irq_domain_update_bus_token+0x6b/0x80
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  ? pci_conf1_read+0xb2/0xf0
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  __pci_enable_msi_range+0x271/0x380
[    1.261544]  pci_alloc_irq_vectors_affinity+0xc2/0x110
[    1.261544]  ahci_init_one+0x701/0xd20
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  ? srso_alias_return_thunk+0x5/0xfbef5
[    1.261544]  ? __kernfs_new_node.isra.0+0xcb/0x200
[    1.261544]  local_pci_probe+0x42/0x90
[    1.261544]  pci_device_probe+0xdc/0x260
[    1.261544]  ? sysfs_do_create_link_sd+0x6e/0xe0
[    1.261544]  really_probe+0xdb/0x340
[    1.261544]  ? pm_runtime_barrier+0x54/0x90
[    1.261544]  ? __device_attach_driver+0x110/0x110
[    1.261544]  __driver_probe_device+0x78/0x110
[    1.261544]  driver_probe_device+0x1f/0xa0
[    1.261544]  __driver_attach+0xba/0x1c0
[    1.261544]  bus_for_each_dev+0x8b/0xe0
[    1.261544]  bus_add_driver+0x112/0x1f0
[    1.261544]  driver_register+0x72/0xd0
[    1.261544]  ? ata_sff_init+0x40/0x40
[    1.261544]  do_one_initcall+0x57/0x300
[    1.261544]  kernel_init_freeable+0x237/0x2c0
[    1.261544]  ? rest_init+0xd0/0xd0
[    1.261544]  kernel_init+0x1a/0x130
[    1.261544]  ret_from_fork+0x31/0x50
[    1.261544]  ? rest_init+0xd0/0xd0
[    1.261544]  ret_from_fork_asm+0x11/0x20
[    1.261544]  </TASK>
[    1.261544] Modules linked in:
[    1.261544] CR2: 0000000000000000
[    1.261544] ---[ end trace 0000000000000000 ]---
[    1.261544] RIP: 0010:msi_setup_msi_desc+0x75/0x170
[    1.261544] Code: 89 54 24 06 48 8d 54 24 06 f3 48 ab 48 89 ef e8 c1 6=
a fe ff 0f b7 44 24 06 f6 85 3f 08 00 00 10 74 08 80 cc 01 66 89 44 24 06=
 <41> 8b 16 81 e2 00 00 40 00 0f 85 bb 00 00 00 89 c6 66 c1 ee 08 83
[    1.261544] RSP: 0018:ffa0000000023980 EFLAGS: 00010246
[    1.261544] RAX: 0000000000000080 RBX: ffa0000000023988 RCX: 000000000=
0000082
[    1.261544] RDX: 0000000000000000 RSI: 0000000000000293 RDI: ffffffff8=
3a16138
[    1.261544] RBP: ff11000006fdd000 R08: 0000000000000002 R09: ffa000000=
0023964
[    1.261544] R10: 0000000000000000 R11: ffffffff81dd71e0 R12: 000000000=
0000000
[    1.261544] R13: 0000000000000001 R14: 0000000000000000 R15: 000000000=
0000001
[    1.261544] FS:  0000000000000000(0000) GS:ff110000f0b78000(0000) knlG=
S:0000000000000000
[    1.261544] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.261544] CR2: 0000000000000000 CR3: 0000000002e23001 CR4: 000000000=
0771ef0
[    1.261544] PKRU: 55555554
[    1.261544] note: swapper/0[1] exited with irqs disabled
[    1.374076] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000009
[    1.378062] Kernel Offset: disabled
[    1.378062] ---[ end Kernel panic - not syncing: Attempted to kill ini=
t! exitcode=3D0x00000009 ]---


> ---
> Changes since v2:
>  - Fix subject line.
>=20
> Changes since v1:
>  - Fix build.
>  - Expand commit message.
> ---
>  arch/x86/pci/xen.c    |  8 ++------
>  drivers/pci/msi/msi.c | 37 +++++++++++++++++++++----------------
>  include/linux/msi.h   |  3 ++-
>  kernel/irq/msi.c      |  2 +-
>  4 files changed, 26 insertions(+), 24 deletions(-)
>=20
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 0f2fe524f60d..b8755cde2419 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -436,7 +436,8 @@ static struct msi_domain_ops xen_pci_msi_domain_ops=
 =3D {
>  };
> =20
>  static struct msi_domain_info xen_pci_msi_domain_info =3D {
> -	.flags			=3D MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_D=
EV_SYSFS,
> +	.flags			=3D MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS |
> +				  MSI_FLAG_DEV_SYSFS | MSI_FLAG_NO_MASK,
>  	.ops			=3D &xen_pci_msi_domain_ops,
>  };
> =20
> @@ -484,11 +485,6 @@ static __init void xen_setup_pci_msi(void)
>  	 * in allocating the native domain and never use it.
>  	 */
>  	x86_init.irqs.create_pci_msi_domain =3D xen_create_pci_msi_domain;
> -	/*
> -	 * With XEN PIRQ/Eventchannels in use PCI/MSI[-X] masking is solely
> -	 * controlled by the hypervisor.
> -	 */
> -	pci_msi_ignore_mask =3D 1;
>  }
> =20
>  #else /* CONFIG_PCI_MSI */
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 2f647cac4cae..4c8c2b57b5f6 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -10,12 +10,12 @@
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/irq.h>
> +#include <linux/irqdomain.h>
> =20
>  #include "../pci.h"
>  #include "msi.h"
> =20
>  int pci_msi_enable =3D 1;
> -int pci_msi_ignore_mask;
> =20
>  /**
>   * pci_msi_supported - check whether MSI may be enabled on a device
> @@ -285,6 +285,8 @@ static void pci_msi_set_enable(struct pci_dev *dev,=
 int enable)
>  static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>  			      struct irq_affinity_desc *masks)
>  {
> +	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
> +	const struct msi_domain_info *info =3D d->host_data;
>  	struct msi_desc desc;
>  	u16 control;
> =20
> @@ -295,8 +297,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, =
int nvec,
>  	/* Lies, damned lies, and MSIs */
>  	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
>  		control |=3D PCI_MSI_FLAGS_MASKBIT;
> -	/* Respect XEN's mask disabling */
> -	if (pci_msi_ignore_mask)
> +	if (info->flags & MSI_FLAG_NO_MASK)
>  		control &=3D ~PCI_MSI_FLAGS_MASKBIT;
> =20
>  	desc.nvec_used			=3D nvec;
> @@ -604,12 +605,15 @@ static void __iomem *msix_map_region(struct pci_d=
ev *dev,
>   */
>  void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
>  {
> +	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
> +	const struct msi_domain_info *info =3D d->host_data;
> +
>  	desc->nvec_used				=3D 1;
>  	desc->pci.msi_attrib.is_msix		=3D 1;
>  	desc->pci.msi_attrib.is_64		=3D 1;
>  	desc->pci.msi_attrib.default_irq	=3D dev->irq;
>  	desc->pci.mask_base			=3D dev->msix_base;
> -	desc->pci.msi_attrib.can_mask		=3D !pci_msi_ignore_mask &&
> +	desc->pci.msi_attrib.can_mask		=3D !(info->flags & MSI_FLAG_NO_MASK) =
&&
>  						  !desc->pci.msi_attrib.is_virtual;
> =20
>  	if (desc->pci.msi_attrib.can_mask) {
> @@ -659,9 +663,6 @@ static void msix_mask_all(void __iomem *base, int t=
size)
>  	u32 ctrl =3D PCI_MSIX_ENTRY_CTRL_MASKBIT;
>  	int i;
> =20
> -	if (pci_msi_ignore_mask)
> -		return;
> -
>  	for (i =3D 0; i < tsize; i++, base +=3D PCI_MSIX_ENTRY_SIZE)
>  		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
> @@ -714,6 +715,8 @@ static int msix_setup_interrupts(struct pci_dev *de=
v, struct msix_entry *entries
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry=
 *entries,
>  				int nvec, struct irq_affinity *affd)
>  {
> +	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
> +	const struct msi_domain_info *info =3D d->host_data;
>  	int ret, tsize;
>  	u16 control;
> =20
> @@ -744,15 +747,17 @@ static int msix_capability_init(struct pci_dev *d=
ev, struct msix_entry *entries,
>  	/* Disable INTX */
>  	pci_intx_for_msi(dev, 0);
> =20
> -	/*
> -	 * Ensure that all table entries are masked to prevent
> -	 * stale entries from firing in a crash kernel.
> -	 *
> -	 * Done late to deal with a broken Marvell NVME device
> -	 * which takes the MSI-X mask bits into account even
> -	 * when MSI-X is disabled, which prevents MSI delivery.
> -	 */
> -	msix_mask_all(dev->msix_base, tsize);
> +	if (!(info->flags & MSI_FLAG_NO_MASK)) {
> +		/*
> +		 * Ensure that all table entries are masked to prevent
> +		 * stale entries from firing in a crash kernel.
> +		 *
> +		 * Done late to deal with a broken Marvell NVME device
> +		 * which takes the MSI-X mask bits into account even
> +		 * when MSI-X is disabled, which prevents MSI delivery.
> +		 */
> +		msix_mask_all(dev->msix_base, tsize);
> +	}
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> =20
>  	pcibios_free_irq(dev);
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index b10093c4d00e..59a421fc42bf 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -73,7 +73,6 @@ struct msi_msg {
>  	};
>  };
> =20
> -extern int pci_msi_ignore_mask;
>  /* Helper functions */
>  struct msi_desc;
>  struct pci_dev;
> @@ -556,6 +555,8 @@ enum {
>  	MSI_FLAG_PCI_MSIX_ALLOC_DYN	=3D (1 << 20),
>  	/* PCI MSIs cannot be steered separately to CPU cores */
>  	MSI_FLAG_NO_AFFINITY		=3D (1 << 21),
> +	/* Inhibit usage of entry masking */
> +	MSI_FLAG_NO_MASK		=3D (1 << 22),
>  };
> =20
>  /**
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 396a067a8a56..7682c36cbccc 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -1143,7 +1143,7 @@ static bool msi_check_reservation_mode(struct irq=
_domain *domain,
>  	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
>  		return false;
> =20
> -	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_ignore_mask)
> +	if (info->flags & MSI_FLAG_NO_MASK)
>  		return false;
> =20
>  	/*
> --=20
> 2.46.0
>=20
>=20

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

