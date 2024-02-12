Return-Path: <linux-pci+bounces-3372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B056852171
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 23:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8D228251D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 22:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565684E1CC;
	Mon, 12 Feb 2024 22:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuvVXgRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F151018;
	Mon, 12 Feb 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776997; cv=none; b=puzdX4qwum549V6ghzY8bXNW26hFGXhHX6vH7sZEbL08Ex3pJugtfAox13sDpzfPyngrFPV5CM/vbJHfr4OmSap3E4oXigN8b3JVT+Zdjap6EfuhILLxSGN+gxuCHIE1ffvGEhebc2pfG1Lz7/ZNE1rJIMbr3odz8JvhxMzesv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776997; c=relaxed/simple;
	bh=QDgu/1IR84IYGTUzhIMywCT+Q6GZ4y2glQv4TC3lWus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s3v9+ojjn272ZhK+Y1ZnJylljSxqB0Cs4LBObQcDlcnmzecJ3WyHTox2PRB9u9bRixPaTjGS/98aEn5lzi6G7aM8wm49I41jsThRgMxOidSMq0Mblr0ocyHSRkrlgeKlgLucSmlzh4/ny/gQOyeBpERMCVPd0MFfo4B9HV99BY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuvVXgRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AD0C433F1;
	Mon, 12 Feb 2024 22:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707776996;
	bh=QDgu/1IR84IYGTUzhIMywCT+Q6GZ4y2glQv4TC3lWus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FuvVXgRCPRyIMfFHMSJ+2Cmm1oTlCRV7ezVO8bIeFWzeJSjx/4DOVf9E0EaEqD2F4
	 JEkZQbq1nrnU/pYho0SOQrnBcfDrBDviAEwVcRPee8cZ4eR7QyVunltqa+8N+dAixY
	 yh0PECZ+PON8TNQxjZfXavms69iJ/CGTqAPLD/y07aI5aNaMWylh/hlpbgNdgAn6mL
	 Ki3EffaiR4XwlkaTjNDBtmIQ+11tgiOGUilxA/mZyGti2mP/52TTvOQ1YBizeyKwVZ
	 tOuKvfqf4elyNtIvBfcrNfwPcOu4jiLgmx8H/dcE2y5luqk1vzDQUCb3XeiTSU3hbn
	 2ekfW2iLSOQxw==
Date: Mon, 12 Feb 2024 16:29:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ivan Hu <ivan.hu@canonical.com>
Subject: Re: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820,
 ACPI or EFI
Message-ID: <20240212222955.GA1147798@bhelgaas>
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

[+cc Ivan in case there's opportunity to improve FWTS]

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

I really want to clarify the dmesg logging such that it's clear that
PNP0C02 reservation is the only valid way to reserve the space
described by MCFG.  Obviously we have to retain the fallbacks, but I
think there should be FW_BUG logging in that case.  We currently only
do FW_INFO for missing PNP0C02 reservations.

I think we should try to change FWTS so it validates MCFG addresses
against the PNP0C02 reservations required by spec, instead of
searching E820 for them.  The spec doesn't require MCFG regions to be
in E820, and I think searching there encourages the wrong behavior.
It probably also doesn't work at all on arm64, since it doesn't have
E820 at all.

The /sys/devices/pnp0/00:xx/resources files and "system 00:xx: [mem
...] has been reserved" lines in dmesg would be much better places to
check.

Bjorn

