Return-Path: <linux-pci+bounces-525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550A9805B23
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 18:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35501F21513
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127CC67E96;
	Tue,  5 Dec 2023 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPMe9AXH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E475C675D4;
	Tue,  5 Dec 2023 17:31:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36861C433CA;
	Tue,  5 Dec 2023 17:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701797514;
	bh=VVH9vaa3NIbXaZRQY1J4gbGa1FbI2OkXk/kP1bbSPl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iPMe9AXHPK+OymiBqb8LdnvNpeM+rILC8efHarDiy8eEUaQY0oxMXJBgIYoTxuvTF
	 VB3WHt6+MzR2BkgpxN/tZmBqQLfbNL+phpmip2vWXxNbUC0m4T7XS8y8yLI/VfMEvf
	 mtsvJaoTPK/4sESY9cXowzk+Wf4sSINDjxNOcYSQE75TB+eAfTK3TASCbboKWXls9q
	 lAeLXA5fhN30FgMtPJ7vbfDFdKkIuk8ZJk8iryAXUx9QOEETlKHO0WyKR9ivzJDEUb
	 eC5KyneboYKOpQSHUj995St4IlUey8z6G/4mpBEBZTYPTPrqTOSJ14rayjr0zhymNG
	 lT2xTxv/cpE6w==
Date: Tue, 5 Dec 2023 11:31:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pci: Stop requiring MMCONFIG to be declared in E820,
 ACPI or EFI for newer systems
Message-ID: <20231205173152.GA680118@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <519ebaea-60ae-413f-8746-0f75574b8cb9@amd.com>

On Tue, Dec 05, 2023 at 11:00:31AM -0600, Mario Limonciello wrote:
> On 12/5/2023 10:17, Bjorn Helgaas wrote:
> > On Tue, Dec 05, 2023 at 09:48:45AM -0600, Mario Limonciello wrote:
> > > commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
> > > introduced checks for ensuring that MCFG table also has memory region
> > > reservations to ensure no conflicts were introduced from a buggy BIOS.
> > > 
> > > This has proceeded over time to add other types of reservation checks
> > > for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
> > > however says that these checks are only required when the operating system
> > > doesn't comprehend the firmware region:
> > > 
> > > ```
> > > If the operating system does not natively comprehend reserving the MMCFG
> > > region, the MMCFG region must be reserved by firmware. The address range
> > > reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
> > > reserved by declaring a motherboard resource. For most systems, the
> > > motherboard resource would appear at the root of the ACPI namespace
> > > (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
> > > in this case should not be claimed in the root PCI bus’s _CRS. The
> > > resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
> > > as reserved memory but must always be reported through ACPI as a
> > > motherboard resource.
> > > ```
> > 
> > My understanding is that native comprehension would mean Linux knows
> > how to discover and/or configure the MMCFG base address and size in
> > the hardware and that Linux would then reserve that region so it's not
> > used for anything else.
> > 
> > Linux doesn't have that, at least for x86.  It relies on the MCFG
> > table to discover the MMCFG region, and it relies on PNP0C02 _CRS to
> > reserve it.
> 
> MCFG to discover it matches the PCI firmware spec, but as I point
> out above the decision to reserve this region doesn't require
> PNP0C01/PNP0C02 _CRS.

Can you explain this reasoning a little more?  I claim Linux does not
natively comprehend reserving the MMCFG region, but it sounds like you
don't agree?  I think "native" comprehension would mean Linux would
not need the MCFG table.

> This is a decision made by Linux historically.
>
> > > Running this check causes problems with accessing extended PCI
> > > configuration space on OEM laptops that don't specify the region in PNP
> > > resources or in the EFI memory map. That later manifests as problems with
> > > dGPU and accessing resizable BAR.
> > 
> > Is there a problem report we can reference here?
> 
> Nothing public to share. AMD BIOS team is in discussion with the OEM to add
> the reservation in a BIOS upgrade so it works with things like the LTS
> kernels.

Is there some reason this can't be made public (it's obviously fine to
redact proprietary details)?  It's really hard to make this code work
for all the cases even when we know all the details, and practically
impossible if we don't.

> Knowing Windows works without it I feel this is still something that we
> should be looking at fixing from an upstream perspective though which is
> what prompted my patch and discussion.

We definitely need to change Linux so it works correctly with firmware
in the field, whether that means fixing a Linux defect or working
around a firmware defect.

> > Does the problem still occur with this series?
> > https://lore.kernel.org/r/20231121183643.249006-1-helgaas@kernel.org
> > 
> > This appeared in linux-next 20231130.
> 
> Thanks for sharing that.  If I do respin a variation of this patch I'll
> rebase on top of that.
> 
> I had a try with that series on top of 6.7-rc4, but it doesn't fix the issue
> (but obviously the patch I sent does).
> 
> # journalctl -k | grep ECAM
> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 0xe0000000-0xefffffff]
> (base 0xe0000000) for domain 0000 [bus 00-ff]
> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem
> 0xe0000000-0xefffffff] not reserved)
> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: ECAM [mem 0xe0000000-0xefffffff]
> (base 0xe0000000) for domain 0000 [bus 00-ff]
> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: [Firmware Info]: ECAM [mem
> 0xe0000000-0xefffffff] not reserved in ACPI motherboard resources
> Dec 05 06:37:46 cl-fw-fedora kernel: PCI: not using ECAM ([mem
> 0xe0000000-0xefffffff] not reserved)

Can you boot with 'efi=debug dyndbg="file arch/x86/pci +p"' and share
the complete dmesg log (redacted if necessary) somewhere?  It's
important to know more about why and how this doesn't work.  I added
more debug logging, but possibly it's still not enough.

> > > Similar problems don't exist in Windows 11 with exact same
> > > laptop/firmware stack, and in discussion with AMD's BIOS team
> > > Windows doesn't have similar checks.
> > 
> > I would love to know AMD BIOS team's take on this.  Does the BIOS
> > reserve the MMCFG space in any way?
> 
> On the AMD reference platform this OEM system is based on it is reserved in
> the EFI memory map.  So on a 6.7 based kernel the reference system you can
> see this emitted:
> 
> PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as EfiMemoryMappedIO

The EfiMemoryMappedIO entry is not a *reservation* (this was a poor
choice of words in the logging, and my series changes it).  This entry
only means the firmware requests that the OS map this region to a
virtual address so it can be used by EFI runtime services (UEFI v2.9,
sec 7.2).

> But on the OEM system this is not reserved by EFI memory map or _CRS.
> 
> That's why my assumption after reading the firmware spec and seeing the
> behavior is that Windows makes the reservation *based on* what's in MCFG.

Is there some spec language that says MCFG reserves space?  I'm not
aware of anything about ACPI static tables reserving MMIO space.
Here's my reasoning around static tables vs _CRS for reservations:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/PCI/acpi-info.rst?id=v6.6#n32

> > > As this series of checks was first introduced as a mitigation for buggy
> > > BIOS before EFI was introduced add a BIOS date range to only enforce the
> > > checks on hardware that predates the release of Windows 11.
> > 
> > Many of the MMCFG checks in Linux are historical artifacts that are
> > likely related to Linux defects, not BIOS defects, so I wouldn't
> > expect to see them in Windows.  But it's hard to remove them now.
> 
> I guess I was hoping that by cutting a line in the sand we could avoid
> breaking anything that was relying upon the older behavior.
> 
> > > Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
> > >        PCI Firmware Specification 3.3
> > >        Section 4.1.2 MCFG Table Description Note 2
> > > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > > ---
> > >   arch/x86/pci/mmconfig-shared.c | 10 +++++++---
> > >   1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> > > index 4b3efaa82ab7..e4594b181ebf 100644
> > > --- a/arch/x86/pci/mmconfig-shared.c
> > > +++ b/arch/x86/pci/mmconfig-shared.c
> > > @@ -570,9 +570,13 @@ static void __init pci_mmcfg_reject_broken(int early)
> > >   	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> > >   		if (pci_mmcfg_check_reserved(NULL, cfg, early) == 0) {
> > > -			pr_info(PREFIX "not using MMCONFIG\n");
> > > -			free_all_mmcfg();
> > > -			return;
> > > +			if (dmi_get_bios_year() >= 2021) {
> > > +				pr_info(PREFIX "MMCONFIG wasn't reserved by ACPI or EFI\n");
> > 
> > I think this leads to using the MMCONFIG area without reserving it
> > anywhere, so we may end up assigning that space to something else,
> > which won't work, i.e., the problem described here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=5cef3014e02d
> > 
> > > +			} else {
> > > +				pr_info(PREFIX "not using MMCONFIG\n");
> > > +				free_all_mmcfg();
> > > +				return;
> > > +			}
> > >   		}
> > >   	}
> > >   }
> > > -- 
> > > 2.34.1
> > > 
> 

