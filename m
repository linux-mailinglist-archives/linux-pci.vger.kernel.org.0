Return-Path: <linux-pci+bounces-31860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928BB0078F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 17:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF75F3A44D6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EAC27510A;
	Thu, 10 Jul 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsARUbBS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E91274FE4;
	Thu, 10 Jul 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162568; cv=none; b=TsWjQMnp10n+3nDSfYFobIl6XwTDtTNiwwtovfwRTxSCnuy8RUOfJ0GFWLFCMoWx7ccuApuy8bq/KLJEaw22WwEYVk5VfhV6SmD1o8KmvwrM1mUeTxAbrKCFLYcBYya5cSpeWeKxJmYuxUspCuvirWXugi8fOLP3A/BWf8dCpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162568; c=relaxed/simple;
	bh=foG9f9cdzF4VjUfn2UjSlnSdvbnX8/uWCSS01L4+zeY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ePJ49MMmJSw7DuPvYGR3E2GWR7TLzgYL5BBUlFdlnAqJD6SJuV/ea18MtLlpFPxw7zroSZmi/edWmhbo/REUsCDDJyd/SL5/czZBL2G47cMazcETAt21biCbAuKPJSRiJ6n/ZzZK3lfytT1NaaK9ATCppXRck3Z1fhS/I60e/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsARUbBS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212F1C4CEE3;
	Thu, 10 Jul 2025 15:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752162568;
	bh=foG9f9cdzF4VjUfn2UjSlnSdvbnX8/uWCSS01L4+zeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TsARUbBSF0wAe3pbM5uyEMmR9Ln5cuZ3udIlyzm4MYZwV/Y2RWpc1nDqSSRTHkE98
	 ZuIzkvCMq63HnwyQC2tC9y6CaOWHFqPKE0COCNrM7BEXbxAd/vMIm1DumdxgJBkbEJ
	 upZVauqkPcJFek8GCxKOKjT5heqjge5H3ZHFqHdWBzoic/Ct5MzDw+1te9HELqoURE
	 hHOMkS0ocyix2d6kY19sg8zCwQYrbzlfnJ7cWpRkxWWn6TChNGka2+67GRvnzpn03W
	 9ZfyzT3zingvYk2OMz5UKWM5ZCGzzReiCGVfhc9SPSeW28I9GGjyO5K9TRGoSBGpgX
	 dOcPsVrfk999Q==
Date: Thu, 10 Jul 2025 10:49:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Huang <huangalex409@gmail.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: BUG: ASPM issues with Radeon Pro WX3100
Message-ID: <20250710154926.GA2250118@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8640445b-a868-4c1f-a32b-449bbffa2553@gmail.com>

On Wed, Jul 09, 2025 at 09:02:17PM -0400, Alex Huang wrote:
> On 2025-07-08 19:07, Bjorn Helgaas wrote:
> > On Thu, Jul 03, 2025 at 12:09:20AM -0400, Alex Huang wrote:
> >> Recently, I dug up a Radeon Pro WX3100 and when booting, got a black screen
> >> with some complaints of No EDID read and then a `Fatal error during GPU
> >> init`. With windows booting fine and an MSI Kombustor run turning out just
> >> fine, I would say hardware failure highly unlikely. The logs seem unrelated
> >> (although I have attached them anyways), lspci -vvxxx output for the device
> >> is also at the end of the email. Also here is lspci -vvxxx for the upstream
> >> PCI bridge attached to the GPU.
> >>
> >> A bisect reveals the offending commit is 0064b0ce85bb ("drm/amd/pm: enable
> >> ASPM by default"). The simple fix appears to be setting `amdgpu.aspm=0` in
> >> kernel boot parameters. This seemingly is a case of something in the Lenovo
> >> ideacentre (specifically the ideacentre 510A-15ARR I found this bug on)
> >> incorrectly reporting ASPM availability. I'd think this is a PCI driver
> >> issue, but I am by no means an expert here. If this ends up on the wrong
> >> mailing list, please do let me know.
> > 
> > The messages below show that you're running v5.12.0-rc7+, but
> > 0064b0ce85bb didn't appear until v5.14.  Obviously it was reproducible
> > if you could bisect it, but I'm confused about where you observed the
> > problem.
> 
> Prior to v5.14, it's possible to replicate the bug with
> amdgpu.aspm=1, basically replicating what the change itself did.
> > 
> > The newer log you posted at
> > https://lore.kernel.org/r/e03b119d-4a27-45a0-8058-3ac7fbee23c7@gmail.com
> > is from v6.16.0-rc4+, which is great because it's a current kernel,
> > but the issue there looks much different (an oops in
> > drm_gem_object_handle_put_unlocked()) and doesn't seem like a PCI
> > issue at all.
> 
> Sorry, I had assumed you wanted the output from the PCI debug patch,
> which is why I had set amdgpu.aspm=0 to have easier access to logs.
> I've attached a log where the bug can be seen, although it's just
> amdgpu complaining and then falling over.
> 
> > If you can reproduce a PCI issue in v6.16, I'd love to look at it, but
> > right now I don't see anything I can help with.
> 
> Annoyingly, PCI doesn't complain at all about this issue, PCI just
> quietly reports ASPM is available (even when that is not the case)
> and amdgpu uses that to attempt to configure ASPM for the graphics
> card.
>
> Peeking at the return value for amdgpu_device_should_use_aspm shows
> pcie_aspm_enabled returns true even though ASPM is explicitly set to
> the "disable" mode in the BIOS.
>
> Leading me to believe this is a case of ASPM being incorrectly
> detected as enabled.

ASPM is designed to be a feature that the PCI core can discover and
configure independent of the driver.  Devices advertise ASPM support
via their Link Capabilities register, e.g., this one claims to support
L1 as well as the L1.1 and L1.2 substates:

  01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Lexa XT [Radeon PRO WX 3100] (prog-if 00 [VGA controller])
    Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
      LnkCap: Port #0, Speed 8GT/s, Width x8, ASPM L1, Exit Latency L1 <1us
	      ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
    Capabilities: [370 v1] L1 PM Substates
      L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
		PortCommonModeRestoreTime=0us PortTPowerOnTime=170us

I don't know what your BIOS "disable" switch does.  It's possible it
just keeps BIOS from configuring ASPM, while leaving it advertised as
"supported" in config space, and Linux would configure ASPM in that
case.  There is also a bit in the ACPI FADT that says "OSPM must not
enable OSPM ASPM control on this platform," and maybe the BIOS
"disable" switch would set that.  If set, this would be mentioned in
the dmesg log.

I don't have any insight into why amdgpu inserts itself in the middle
of ASPM configuration.  There might be hardware defects it works
around, or it could be working around old or current ASPM defects in
the PCI core.

> My reasons for my conclusion can basically be summarized like this:
> - pcie_aspm_enabled returns true even if ASPM is disabled in BIOS.

The BIOS switch could (a) prevent BIOS from enabling ASPM itself
(could figure this out by booting with "pci=earlydump" and looking at
Link Control), (b) set the ACPI FADT bit (would be shown in dmesg), or
(c) change what's advertised in Link Capabilities (very unlikely since
it would require AMDGPU-specific support in BIOS; also, Linux can't
change Link Capabilities, and lspci showed L1 supported).  There's no
other BIOS-OS handshake I'm aware of.

> - amdgpu crashes with a non obvious issue and a lot of warnings as
>   long as it tries to configure ASPM.

ASPM configuration should only affect power consumption.  AFAIK, even
if it's configured incorrectly, we should not see any functional
issues.

> - putting the WX3100 into another machine caused it to boot just
>   fine, and did in fact correctly configure ASPM.

I mentioned my suspicion of L1.2 because that does depend on some
platform electrical properties that we don't know how to discover.
But even so, we shouldn't see a functional issue.

> - https://lore.kernel.org/lkml/CADnq5_PmxGxrJG5uZkkFXQ1YbJbDZTvAqb2oYqdCE=NtqBojqw@mail.gmail.com/
>   mentions "It's more of an issue with whether the underlying
>   platform supports ASPM or not"
> 
> It's possible I'm barking up the wrong tree here, I'm not familiar
> with this part of the kernel, if this turns out to actually be an
> amdgpu problem, please let me know.

> >> I also did try enabling/disabling ASPM on the BIOS side to no avail.
> >>
> >> The bug appears to be systematically existent for many other cards I ended
> >> up plugging into the device (thus conclusion as PCI driver issue). 

This sounds interesting.  More details here?  I guess you also see
issues with different cards plugged into the same slot?  And there
appears to be some ASPM connection there, too?

> ...
> kernel: amdgpu 0000:01:00.0: amdgpu: [drm] Display Core v3.2.334 initialized on DCE 11.2
> kernel: amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
> kernel: amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
> kernel: amdgpu 0000:01:00.0: [drm] *ERROR* No EDID read.
> kernel: amdgpu 0000:01:00.0: amdgpu:
>         last message was failed ret is 65535

This is in smu7_send_msg_to_smc() and it looks like we might have
gotten ~0 when reading a register.  Possibly a PCIe error, since the
Root Complex typically synthesizes ~0 data returns when a read fails
on PCIe.

> kernel: ------------[ cut here ]------------
> kernel: WARNING: CPU: 1 PID: 154 at drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:1111 uvd_v6_0_ring_insert_nop+0xb5/0xc0 [amdgpu]

This is:

  WARN_ON(ring->wptr % 2 || count % 2);

so apparently ring->wptr or count are expected to be even, but at
least one was odd.  Makes me wonder if wptr was set from a PCIe read
that returned ~0.

Both are a little odd since I don't see any AER errors mentioned in
the dmesg or the lspci output.  But worth looking into to see if there
are errors that we could catch earlier or handle better.  Also of
course odd if an error like this were related to ASPM.

Bjorn

