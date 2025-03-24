Return-Path: <linux-pci+bounces-24533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9179FA6DD0A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 15:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBAD3B0318
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 14:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9267158524;
	Mon, 24 Mar 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qys4fsVH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829ADEEC5;
	Mon, 24 Mar 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826589; cv=none; b=HJPBgCR49sfcmT5zC3zgnmbmi+nsCoP7uXS7FN3bXy+aoJlUZTrrISjnaRdrEwCwXHzyETy4p+ZfsfFUDgzU2mjfwibzEsCk45XHeRPIXRd4ZYLM06HfbIH3R9gteaAeJv3jqIfy5tiQ8hkFJF3rGKd466+4IAsQHw4Cp7XiorI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826589; c=relaxed/simple;
	bh=YCl0Xb8LGqIfcEjzkA/NTLRkDnLwd92Deb1BZs32/AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdhCPMMEXixmrrv1Cergej8aeBBaEPzF9noR185DKFONj/t2Pc74/AQQc+RNFTZrsAYbBq3IET5nWbISOBtHmxbcf5bmi7Fe6BbefcapuxkLRUGl+zSyYsAVEZqdoBIvRSh9YCgwrnu+mS5uZBK2kz5Qfi8XA6EJoI8c1nXUwKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qys4fsVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83974C4CEDD;
	Mon, 24 Mar 2025 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742826589;
	bh=YCl0Xb8LGqIfcEjzkA/NTLRkDnLwd92Deb1BZs32/AY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qys4fsVHHw1FlqG0Qz2G7Vw7QrDXZuoQXgZdcRPLI3U9zqp77nl5KORDkQJIuiLfe
	 Qi7gzUyfWrPhWru22hVqfnUsj+kXy+1BQFE756ixfKuM+trN2YXXQE2pb99NNMwm8x
	 SWij92hGdCaUPz+36wQThm9zANEfrHMvviGv5wDRMok7QLIStZtujBi/qnX1ItxpvY
	 pCeaRFTNmuSLbyOgIwSZ3cEQyyYgNL4VrUA2at+OQdtGQJYmqUJMVB4vi2uDn09hYQ
	 RmcNKopa+W+JoNgRW+CRakpUrOtrqKJjowvGwbIP0GuuWMXlvNwGSdxX++T1hkO3f7
	 HZ9IfUeyk3Duw==
Date: Mon, 24 Mar 2025 15:29:46 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Roger Pau Monne <roger.pau@citrix.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
Message-ID: <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>


Hi,

On Fri, Mar 21, 2025 at 09:00:09AM +0100, Jürgen Groß wrote:
> On 20.03.25 22:07, Bjorn Helgaas wrote:
> > On Wed, Feb 19, 2025 at 10:20:57AM +0100, Roger Pau Monne wrote:
> > > Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both
> > > MSI and MSI-X entries globally, regardless of the IRQ chip they are using.
> > > Only Xen sets the pci_msi_ignore_mask when routing physical interrupts over
> > > event channels, to prevent PCI code from attempting to toggle the maskbit,
> > > as it's Xen that controls the bit.
> > > 
> > > However, the pci_msi_ignore_mask being global will affect devices that use
> > > MSI interrupts but are not routing those interrupts over event channels
> > > (not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
> > > bridge.  In that scenario the VMD bridge configures MSI(-X) using the
> > > normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
> > > bridge configure the MSI entries using indexes into the VMD bridge MSI
> > > table.  The VMD bridge then demultiplexes such interrupts and delivers to
> > > the destination device(s).  Having pci_msi_ignore_mask set in that scenario
> > > prevents (un)masking of MSI entries for devices behind the VMD bridge.
> > > 
> > > Move the signaling of no entry masking into the MSI domain flags, as that
> > > allows setting it on a per-domain basis.  Set it for the Xen MSI domain
> > > that uses the pIRQ chip, while leaving it unset for the rest of the
> > > cases.
> > > 
> > > Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
> > > with Xen dropping usage the variable is unneeded.
> > > 
> > > This fixes using devices behind a VMD bridge on Xen PV hardware domains.
> > > 
> > > Albeit Devices behind a VMD bridge are not known to Xen, that doesn't mean
> > > Linux cannot use them.  By inhibiting the usage of
> > > VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
> > > bodge devices behind a VMD bridge do work fine when use from a Linux Xen
> > > hardware domain.  That's the whole point of the series.
> > > 
> > > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > > Acked-by: Juergen Gross <jgross@suse.com>
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > I assume you'll merge this series via the Xen tree.  Let me know if
> > otherwise.
> 
> I've pushed the series to the linux-next branch of the Xen tree.
> 
> 
> Juergen

This patch landed in latest next-20250324 tag causing this crash:

[    0.753426] BUG: kernel NULL pointer dereference, address: 0000000000000002
[    0.753921] #PF: supervisor read access in kernel mode
[    0.754286] #PF: error_code(0x0000) - not-present page
[    0.754656] PGD 0 P4D 0
[    0.754842] Oops: Oops: 0000 [#1]
[    0.755080] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.14.0-rc7-next-20250324 #1 NONE
[    0.755691] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.756349] RIP: 0010:msix_prepare_msi_desc+0x39/0x80
[    0.756390] Code: 20 c7 46 04 01 00 00 00 8b 56 4c 89 d0 0d 01 01 00 00 66 89 46 4c 8b 8f 64 02 00 00 89 4e 50 48 8b 8f 70 06 00 00 48 89 4e 58 <41> f6 40 02 40 75 2a c1 ea 02 bf 80 00 00 00 21 fa 25 7f ff ff ff
[    0.756390] RSP: 0000:ffff8881002a76e0 EFLAGS: 00010202
[    0.756390] RAX: 0000000000000101 RBX: ffff88810074d000 RCX: ffffc9000002e000
[    0.756390] RDX: 0000000000000000 RSI: ffff8881002a7710 RDI: ffff88810074d000
[    0.756390] RBP: ffff8881002a7710 R08: 0000000000000000 R09: ffff8881002a76b4
[    0.756390] R10: 000000701000c001 R11: ffffffff82a3dc01 R12: 0000000000000000
[    0.756390] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000002
[    0.756390] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    0.756390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.756390] CR2: 0000000000000002 CR3: 0000000002a3d001 CR4: 00000000003706b0
[    0.756390] Call Trace:
[    0.756390]  <TASK>
[    0.756390]  ? __die_body+0x1b/0x60
[    0.756390]  ? page_fault_oops+0x2d0/0x310
[    0.756390]  ? exc_page_fault+0x59/0xc0
[    0.756390]  ? asm_exc_page_fault+0x22/0x30
[    0.756390]  ? msix_prepare_msi_desc+0x39/0x80
[    0.756390]  ? msix_capability_init+0x172/0x2c0
[    0.756390]  ? __pci_enable_msix_range+0x1a8/0x1d0
[    0.756390]  ? pci_alloc_irq_vectors_affinity+0x7c/0xf0
[    0.756390]  ? vp_find_vqs_msix+0x187/0x400
[    0.756390]  ? vp_find_vqs+0x2f/0x250
[    0.756390]  ? snprintf+0x3e/0x50
[    0.756390]  ? vp_modern_find_vqs+0x13/0x60
[    0.756390]  ? init_vq+0x184/0x1e0
[    0.756390]  ? vp_get_status+0x20/0x20
[    0.756390]  ? virtblk_probe+0xeb/0x8d0
[    0.756390]  ? __kernfs_new_node+0x122/0x160
[    0.756390]  ? vp_get_status+0x20/0x20
[    0.756390]  ? virtio_dev_probe+0x171/0x1c0
[    0.756390]  ? really_probe+0xc2/0x240
[    0.756390]  ? driver_probe_device+0x1d/0x70
[    0.756390]  ? __driver_attach+0x96/0xe0
[    0.756390]  ? driver_attach+0x20/0x20
[    0.756390]  ? bus_for_each_dev+0x7b/0xb0
[    0.756390]  ? bus_add_driver+0xe6/0x200
[    0.756390]  ? driver_register+0x5e/0xf0
[    0.756390]  ? virtio_blk_init+0x4d/0x90
[    0.756390]  ? add_boot_memory_block+0x90/0x90
[    0.756390]  ? do_one_initcall+0xe2/0x250
[    0.756390]  ? xas_store+0x4b/0x4b0
[    0.756390]  ? number+0x13b/0x260
[    0.756390]  ? ida_alloc_range+0x36a/0x3b0
[    0.756390]  ? parameq+0x13/0x90
[    0.756390]  ? parse_args+0x10f/0x2a0
[    0.756390]  ? do_initcall_level+0x83/0xb0
[    0.756390]  ? do_initcalls+0x43/0x70
[    0.756390]  ? rest_init+0x80/0x80
[    0.756390]  ? kernel_init_freeable+0x70/0xb0
[    0.756390]  ? kernel_init+0x16/0x110
[    0.756390]  ? ret_from_fork+0x30/0x40
[    0.756390]  ? rest_init+0x80/0x80
[    0.756390]  ? ret_from_fork_asm+0x11/0x20
[    0.756390]  </TASK>
[    0.756390] Modules linked in:
[    0.756390] CR2: 0000000000000002
[    0.756390] ---[ end trace 0000000000000000 ]---
[    0.756390] RIP: 0010:msix_prepare_msi_desc+0x39/0x80
[    0.756390] Code: 20 c7 46 04 01 00 00 00 8b 56 4c 89 d0 0d 01 01 00 00 66 89 46 4c 8b 8f 64 02 00 00 89 4e 50 48 8b 8f 70 06 00 00 48 89 4e 58 <41> f6 40 02 40 75 2a c1 ea 02 bf 80 00 00 00 21 fa 25 7f ff ff ff
[    0.756390] RSP: 0000:ffff8881002a76e0 EFLAGS: 00010202
[    0.756390] RAX: 0000000000000101 RBX: ffff88810074d000 RCX: ffffc9000002e000
[    0.756390] RDX: 0000000000000000 RSI: ffff8881002a7710 RDI: ffff88810074d000
[    0.756390] RBP: ffff8881002a7710 R08: 0000000000000000 R09: ffff8881002a76b4
[    0.756390] R10: 000000701000c001 R11: ffffffff82a3dc01 R12: 0000000000000000
[    0.756390] R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000002
[    0.756390] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    0.756390] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.756390] CR2: 0000000000000002 CR3: 0000000002a3d001 CR4: 00000000003706b0
[    0.756390] note: swapper[1] exited with irqs disabled
[    0.782774] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    0.783560] Kernel Offset: disabled
[    0.783909] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---


msix_prepare_msi_desc+0x39/0x80:
msix_prepare_msi_desc at drivers/pci/msi/msi.c:616
 611            desc->nvec_used                         = 1;
 612            desc->pci.msi_attrib.is_msix            = 1;
 613            desc->pci.msi_attrib.is_64              = 1;
 614            desc->pci.msi_attrib.default_irq        = dev->irq;
 615            desc->pci.mask_base                     = dev->msix_base;
>616<           desc->pci.msi_attrib.can_mask           = !(info->flags & MSI_FLAG_NO_MASK) &&
 617                                                      !desc->pci.msi_attrib.is_virtual;
 618
 619            if (desc->pci.msi_attrib.can_mask) {
 620                    void __iomem *addr = pci_msix_desc_addr(desc);
 621

Reverting patch 3 fixes the issue.

Daniel

