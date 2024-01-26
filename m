Return-Path: <linux-pci+bounces-2558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA783D187
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 01:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134731C231A9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 00:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67153387;
	Fri, 26 Jan 2024 00:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZGCtXP2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB8197;
	Fri, 26 Jan 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706229319; cv=none; b=Jaj+X73ZiqMv5aOmvzqkxaJ+gM3K0E+ceQ7Y1kfUTHAxnpp42YCOzyIiHPlp4LeLKH7/aIP3T5Fg2/eVsJpP9yjMkk6gLfMOuugSjF/80ON3rL3iMhX9ftiCYiAdehxITUzc40/QJQk2e6uDpt6RBDiGYvSo6L0BJjPvwtsiAfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706229319; c=relaxed/simple;
	bh=m986K6zFIlrT+3xx6AdVYmVw1p6r7qdl+tS4SPDV+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MI1CxMNBrlYte7bHajUzalIu2FpxxdaG6TbUSMvAUOTlZXIiC/DuEDLe1KfiNRDZy1V4S+zAsbhLAiuSU8VcFzfIU3iRlCIJgffUKQgERo3QSVqt+qArGz4t2dBHCoacCkootjni1bJ7zuOQsvbFL3PTeG5aQ5ylfFy9g8XqRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZGCtXP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37EFC433C7;
	Fri, 26 Jan 2024 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706229318;
	bh=m986K6zFIlrT+3xx6AdVYmVw1p6r7qdl+tS4SPDV+JU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rZGCtXP25jujiWfIT6A0DUPA418VQFoekhEs7OAHyAQhR7ckr4N8L9mfTuBexZKzP
	 HW6eF7ZDxd59YFWh9VUPFW1JIuHox+x9TE0hE4Uqp6IBQwL0cTTsArKqQc5mj9Bp1t
	 OSF7faXSn9a7mJr79/J++7mhrn0/EGW9kSYdLiHux6oqnV0pD8A6vyD9JSJT5LQ3Sl
	 MfGfcSSwfTKQHjsLI60FC1nYpSh+GmPK6hZ6Pd2UL2SBp7Il6POOR1tftxQnMoaUEf
	 Ib8YQ0L67MCm4liiAkMx+UeYmffw0vn9h+KvUy/avCg6jgLghK9QYnSF7YNYZas/Oz
	 KPhZV9Cg/P4xA==
Date: Thu, 25 Jan 2024 18:35:14 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820,
 ACPI or EFI
Message-ID: <20240126003514.GA407167@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7caefe4b-bf05-49a3-bfb8-75e7fd73343b@amd.com>

On Wed, Jan 17, 2024 at 11:53:50AM -0600, Mario Limonciello wrote:
> On 12/15/2023 16:03, Mario Limonciello wrote:
> > commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
> > introduced checks for ensuring that MCFG table also has memory region
> > reservations to ensure no conflicts were introduced from a buggy BIOS.
> > 
> > This has proceeded over time to add other types of reservation checks
> > for ACPI PNP resources and EFI MMIO memory type.  The PCI firmware spec
> > does say that these checks are only required when the operating system
> > doesn't comprehend the firmware region:
> > 
> > ```
> > If the operating system does not natively comprehend reserving the MMCFG
> > region, the MMCFG region must be reserved by firmware. The address range
> > reported in the MCFG table or by _CBA method (see Section 4.1.3) must be
> > reserved by declaring a motherboard resource. For most systems, the
> > motherboard resource would appear at the root of the ACPI namespace
> > (under \_SB) in a node with a _HID of EISAID (PNP0C02), and the resources
> > in this case should not be claimed in the root PCI bus’s _CRS. The
> > resources can optionally be returned in Int15 E820h or EFIGetMemoryMap
> > as reserved memory but must always be reported through ACPI as a
> > motherboard resource.
> > ```
> > 
> > Running this check causes problems with accessing extended PCI
> > configuration space on OEM laptops that don't specify the region in PNP
> > resources or in the EFI memory map. That later manifests as problems with
> > dGPU and accessing resizable BAR. Similar problems don't exist in Windows
> > 11 with exact same laptop/firmware stack.
> > 
> > Due to the stability of the Windows ecosystem that x86 machines participate
> > it is unlikely that using the region specified in the MCFG table as
> > a reservation will cause a problem. The possible worst circumstance could
> > be that a buggy BIOS causes a larger hole in the memory map that is
> > unusable for devices than intended.
> > 
> > Change the default behavior to keep the region specified in MCFG even if
> > it's not specified in another source. This is expected to improve
> > machines that otherwise couldn't access PCI extended configuration space.
> > 
> > In case this change causes problems, add a kernel command line parameter
> > that can restore the previous behavior.
> > 
> > Link: https://members.pcisig.com/wg/PCI-SIG/document/15350
> >        PCI Firmware Specification 3.3
> >        Section 4.1.2 MCFG Table Description Note 2
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> 
> Bjorn,
> 
> Any thoughts on this version since our last conversation on V1?

Just to let you know that I'm not ignoring this, and I'm trying to
formulate a useful response.  mmconfig-shared.c has grown into an
extremely complicated mess and is a continual source of problems, so
I'd really like to untangle it a tiny bit if we can.

One thing is that per spec, ACPI motherboard resources are the ONLY
way to reserve ECAM space.  I'd like to reclaim a little clarity about
that and separate out the E820 and EFI stuff as secondary hacks.  But
there's an insane amount of history that got us here.

The problem we have to avoid is assigning a BAR that overlaps ECAM.
We assign BARs for lots of reasons.  dGPU and resizable BARs are
examples but there are others, like hotplug and SR-IOV.  The fact that
Windows works is a red herring because it allocates BARs differently.

It's also little bit of a burr under my saddle to add things for a
problem on unspecified machines, where I don't even know whether the
machines are already in the field or the firmware could still be
fixed.

And of course, if there's any way to solve this safely without adding
yet another kernel parameter, that would be vastly preferable.

Sorry, nothing actionable here but wanted to let you know that it's
keeping me awake at night ;)

Bjorn

> > v1->v2:
> >   * Rebase on pci/next
> >   * Add an escape hatch
> >   * Reword commit message
> > ---
> >   .../admin-guide/kernel-parameters.txt         |  6 ++++++
> >   arch/x86/pci/mmconfig-shared.c                | 19 +++++++++++++++----
> >   2 files changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..eacd0c0521c2 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1473,6 +1473,12 @@
> >   			(in particular on some ATI chipsets).
> >   			The kernel tries to set a reasonable default.
> > +	enforce_ecam_resv [X86]
> > +			Enforce requiring an ECAM reservation specified in
> > +			BIOS for PCI devices.
> > +			This parameter is only valid if CONFIG_PCI_MMCONFIG
> > +			is enabled.
> > +
> >   	enforcing=	[SELINUX] Set initial enforcing status.
> >   			Format: {"0" | "1"}
> >   			See security/selinux/Kconfig help text.
> > diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> > index 0cc9520666ef..aee117c6bbf9 100644
> > --- a/arch/x86/pci/mmconfig-shared.c
> > +++ b/arch/x86/pci/mmconfig-shared.c
> > @@ -34,6 +34,15 @@ static DEFINE_MUTEX(pci_mmcfg_lock);
> >   LIST_HEAD(pci_mmcfg_list);
> > +static bool enforce_ecam_resv __read_mostly;
> > +static int __init parse_ecam_options(char *str)
> > +{
> > +	enforce_ecam_resv = true;
> > +
> > +	return 1;
> > +}
> > +__setup("enforce_ecam_resv", parse_ecam_options);
> > +
> >   static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
> >   {
> >   	if (cfg->res.parent)
> > @@ -569,10 +578,12 @@ static void __init pci_mmcfg_reject_broken(int early)
> >   	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> >   		if (!pci_mmcfg_reserved(NULL, cfg, early)) {
> > -			pr_info("not using ECAM (%pR not reserved)\n",
> > -				&cfg->res);
> > -			free_all_mmcfg();
> > -			return;
> > +			pr_info("ECAM %pR not reserved, %s\n", &cfg->res,
> > +				enforce_ecam_resv ? "ignoring" : "using anyway");
> > +			if (enforce_ecam_resv) {
> > +				free_all_mmcfg();
> > +				return;
> > +			}
> >   		}
> >   	}
> >   }
> > 
> > base-commit: 67e04d921cb6902e8c2abdbf748279d43f25213e
> 

