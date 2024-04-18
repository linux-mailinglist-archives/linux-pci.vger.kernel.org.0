Return-Path: <linux-pci+bounces-6450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DB58AA0E3
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 19:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8921C21CB4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A54C171E6C;
	Thu, 18 Apr 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjptRVcn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E616191A;
	Thu, 18 Apr 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460556; cv=none; b=WChx58RtAf7oo9Hh53u836CjjWAjZliV7Hbue7C/GT4BoIf5dbFZcinj2F7jwXtgcxbyVljeK9Mrijiucs2o1LPhA4kPSCbEf1BHL3iAHnOUWaKCLRfJSeZx9g+4WD2cQcPwF1VD8LKqelJ1mxuHaTMgF3pkAH3dpYdkH78DRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460556; c=relaxed/simple;
	bh=LgJPMxU3HO9QRE31RUOPaGcABDjdwgiW7iye+x76HXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dAZKGUNGi8eKz3ni3/d4bf5MrBP+9x9jY0ljgRha19ymErVVb8WgdZQy5frkL6Zu+cKNWokA+33BDRyIvt8iaqaIQTk7FXSz0ab/8l2YfAcj4cK1JCCA4LbW43L0tw0aXqVZ1CfUxQAXKq6DFjwzPo0S6XDnqWYnxSN9yS1D0N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjptRVcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22C1C113CC;
	Thu, 18 Apr 2024 17:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713460555;
	bh=LgJPMxU3HO9QRE31RUOPaGcABDjdwgiW7iye+x76HXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CjptRVcnWckpf1w0k3mjQdfgDyZNJ9iiw5mf48AG27ABJcUFrlWeDe2520MNdOMQv
	 Vsx8nHFWxYmvK8YXEQfxqEeIr3D/5C9C8/pBiWqHxxheNJMANFtbReKOkY/+xR4fM/
	 v+RiLZuudMNONV2yB0JFCxq6xDP9T58AVEAqhOEjUtK9+gueTcpp3LHOdISjDuX084
	 f82SPmO/83F0s7X1yTX1yC3JvbiivFEhWnCPlaI4vB/i7ZFCHrAR4alLE7Gk4iN5I3
	 tv7eWlIv8YaO5tiCeFTI+ae6iBsjl31Iy1z0BCWjPPKhhur9FbqQyqPL9FqZIf7irE
	 f76Dj7kxQM7jw==
Date: Thu, 18 Apr 2024 12:15:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-pci@vger.kernel.org, Mateusz Kaduk <mateusz.kaduk@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, Tj <linux@iam.tj>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/pci: Skip early E820 check for ECAM region
Message-ID: <20240418171554.GA243364@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1897030-77a4-416d-86c4-6d4d560e5fd8@redhat.com>

On Thu, Apr 18, 2024 at 10:14:21AM +0200, Hans de Goede wrote:
> On 4/17/24 10:40 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Arul, Mateusz, Imcarneiro91, and Aman reported a regression caused by
> > 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map").  On the
> > Lenovo Legion 9i laptop, that commit removes the area containing ECAM from
> > E820, which means the early E820 validation started failing, which meant we
> > didn't enable ECAM in the "early MCFG" path
> > 
> > The lack of ECAM caused many ACPI methods to fail, resulting in the
> > embedded controller, PS/2, audio, trackpad, and battery devices not being
> > detected.  The _OSC method also failed, so Linux could not take control of
> > the PCIe hotplug, PME, and AER features:
> > 
> >   # pci_mmcfg_early_init()
> > 
> >   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
> >   PCI: not using ECAM ([mem 0xc0000000-0xce0fffff] not reserved)
> > 
> >   ACPI Error: AE_ERROR, Returned by Handler for [PCI_Config] (20230628/evregion-300)
> >   ACPI: Interpreter enabled
> >   ACPI: Ignoring error and continuing table load
> >   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
> >   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
> >   ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0010)
> >   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PC00.RP01._SB.PC00], AE_NOT_FOUND (20230628/dswload2-162)
> >   ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20230628/psobject-220)
> >   ...
> >   ACPI Error: Aborting method \_SB.PC00._OSC due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
> >   acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)
> > 
> >   # pci_mmcfg_late_init()
> > 
> >   PCI: ECAM [mem 0xc0000000-0xce0fffff] (base 0xc0000000) for domain 0000 [bus 00-e0]
> >   PCI: [Firmware Info]: ECAM [mem 0xc0000000-0xce0fffff] not reserved in ACPI motherboard resources
> >   PCI: ECAM [mem 0xc0000000-0xce0fffff] is EfiMemoryMappedIO; assuming valid
> >   PCI: ECAM [mem 0xc0000000-0xce0fffff] reserved to work around lack of ACPI motherboard _CRS
> > 
> > Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be reserved by a PNP0C02
> > resource, but it need not be mentioned in E820, so we shouldn't look at
> > E820 to validate the ECAM space described by MCFG.
> > 
> > 946f2ee5c731 ("[PATCH] i386/x86-64: Check that MCFG points to an e820
> > reserved area") added a sanity check of E820 to work around buggy MCFG
> > tables, but that over-aggressive validation causes failures like this one.
> > 
> > Keep the E820 validation check only for older BIOSes (pre-2016) so the
> > buggy 2006-era machines don't break.  Skip the early E820 check for 2016
> > and newer BIOSes.
> 
> I know a fix for this has been long in the making so I don't want to throw
> a spanner into the works, but I wonder why is the is_efi_mmio() check inside
> the if (!early && !acpi_disabled) {} block (before this patch) ?
> 
> is_efi_mmio() only relies on EFI memdescriptors and those are setup pretty
> early. Assuming that the EFI memdescriptors are indeed setup before
> pci_mmcfg_reserved(..., ..., early=true) gets called we could simply move
> the is_efi_mmio(&cfg->res) outside (below) the if (!early && !acpi_disabled)
> {} so that it always runs before the is_mmconf_reserved(e820__mapped_all, ...)
> check.
> 
> Looking at the dmesg above the is_efi_mmio() check does succeed, so this
> should fix the issue without needing a BIOS year check ?

As far as I know there is no spec requirement that an area described
by MCFG appear in either the E820 map or the EFI map.

I would like to get away from relying on these things that the spec
doesn't require because they are so prone to breakage.

I would love to just get rid of this early usage of
pci_mmcfg_reserved() completely; I'm just afraid of breaking some
ancient 2006-era machine that still happens to be running.

Did I understand your question correctly?

Bjorn

