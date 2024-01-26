Return-Path: <linux-pci+bounces-2600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B373083E285
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70110283EAA
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393D5224C9;
	Fri, 26 Jan 2024 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZXhBhTq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3382261A;
	Fri, 26 Jan 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297380; cv=none; b=Nbss/HCZsDRPeK1aLjDJRe6iKno0n/v3f70GxDPc1GxyiloWwjPINf/omRted7iTShoXFD7bAwLD61mJ6srNNIM5anjifoTdaWoOpoIZlEdEK7/my3Sc5yOOLDSPLS+xkC16Q45R4CTfWN2eBHLLimyN1N15Ao389FO0N4lJ3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297380; c=relaxed/simple;
	bh=wplePetjGGSutFZASxBToeC5djPktb7V8+iOKkDud5k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JjJC3Qf4aM1VJQExJUE0J1VVAso46uGwSBEcZnUTfeAn0gn3KqfsAwTzMa5+w6m9t4rV1f1qX+OAIFIWIA+6w7iNqIehTq4HrZkw7++srTOn69hYTl3fuOjxURtPkmEbtNHD7ZfbBituEsVJA0dbx/guj+A0EXwGPFfKHoZvtus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZXhBhTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9E0C433C7;
	Fri, 26 Jan 2024 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706297379;
	bh=wplePetjGGSutFZASxBToeC5djPktb7V8+iOKkDud5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eZXhBhTqFDJRwK21waHVWzEiVFadEQmlKIaRoUq0enXE4XeWC1PT2+6Wd89GwXCtq
	 Z0djqqRK/nY0iMv5jYilo97ZyK23MFkA6iBUnKHewIz4JiYcHwHU/vxogMFRu9g/37
	 K96uyKXVWdcZ0TbUEQq6t/0HDzZdEb8yM0tl6gjv5g2BKqU1qZWUzDPVyahyU2iyeG
	 bmJ5k225dKtWKUBQhFkTKbogy3tH/TKgoJNyuZFdu4XBx7bT1rOENtoGXQODid9hD7
	 SMMwU8UcBW40lLTpypz5HanH5zvt9iPg3gth8qLq+toRcYTHpjvZXwp3nbKVKch49H
	 S4uE9HcM6S5Gw==
Date: Fri, 26 Jan 2024 13:29:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/pci: Stop requiring ECAM to be declared in E820,
 ACPI or EFI
Message-ID: <20240126192937.GA448790@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4b2a119-ed12-4be8-ba75-4a046770efa7@amd.com>

On Fri, Jan 26, 2024 at 12:32:34PM -0600, Mario Limonciello wrote:
> On 1/25/2024 18:35, Bjorn Helgaas wrote:
> > On Wed, Jan 17, 2024 at 11:53:50AM -0600, Mario Limonciello wrote:
> > > On 12/15/2023 16:03, Mario Limonciello wrote:
> > > > commit 7752d5cfe3d1 ("x86: validate against acpi motherboard resources")
> > > > introduced checks for ensuring that MCFG table also has memory region
> > > > reservations to ensure no conflicts were introduced from a buggy BIOS.
> ...

> > > Any thoughts on this version since our last conversation on V1?
> > 
> > Just to let you know that I'm not ignoring this, and I'm trying to
> > formulate a useful response.
> 
> Thanks, I had been wondering.
> 
> FYI - we've also added another place to make noise about this ECAM
> issue in AMDGPU.  This warning should go into 6.9:
> 
> https://lore.kernel.org/amd-gfx/20240110101319.695169-1-Jun.Ma2@amd.com/

Looks similar to the PCI core warning here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/probe.c?id=v6.7#n1134

The comment says it doesn't work for devices on the root bus, though.
Maybe it could be made to work there as well?

> > mmconfig-shared.c has grown into an
> > extremely complicated mess and is a continual source of problems, so
> > I'd really like to untangle it a tiny bit if we can.
> > 
> > One thing is that per spec, ACPI motherboard resources are the ONLY
> > way to reserve ECAM space.  I'd like to reclaim a little clarity about
> > that and separate out the E820 and EFI stuff as secondary hacks.  But
> > there's an insane amount of history that got us here.
> 
> I guess you know better than anyone here.  But if my idea is
> actually viable then the E820 and EFI stuff turn into "information
> only".

That would definitely be a good thing.  I would like it if that were
more obvious from reading the code because I spend waaay too much time
staring at that labyrinth.

> > The problem we have to avoid is assigning a BAR that overlaps ECAM.
> > We assign BARs for lots of reasons.  dGPU and resizable BARs are
> > examples but there are others, like hotplug and SR-IOV.  The fact that
> > Windows works is a red herring because it allocates BARs differently.
> 
> Have we actually observed a case that assigning the BAR overlaps
> ECAM region thus far or it's hypothetical?

Yes, it has happened.  There's an example in the commit log here:
https://git.kernel.org/linus/070909e56a7d ("x86/pci: Reserve ECAM if
BIOS didn't include it in PNP0C02 _CRS")

> > And of course, if there's any way to solve this safely without
> > adding yet another kernel parameter, that would be vastly
> > preferable.
> 
> The kernel isn't static though; something we could do is keep the
> parameter around a year or two to get the bug feedback loop of
> people testing it and then rip it out if nothing comes up.

Yeah.  It's pretty hard to remove those options though.  For example,
"pci=routeirq" was added in the pre-git era and probably isn't
necessary, but how do we know nobody uses it?

Bjorn

