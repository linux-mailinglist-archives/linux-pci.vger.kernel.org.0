Return-Path: <linux-pci+bounces-10794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD1D93C688
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 17:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCA31F22FAA
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CD819CCEB;
	Thu, 25 Jul 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaM3lN+i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DA71993AE;
	Thu, 25 Jul 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921689; cv=none; b=DFJ0iPJPL0fkLyJ8aX79u3RaxWAOlDWk0Sz6+3JrOPAWB7CKKpg8pNjBu/CY5MrpQzvqDPaif6DZspb74jzV6T9Dugx287CFtUy/7SrO8+CXqHb+5LpXV77nu8KhpmAUJx0nZTvgZ0oJhS/elI/y2g1Jya1yv0exy2sOd2Su3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921689; c=relaxed/simple;
	bh=XwYVVIPGvDLM+Mi4lkud9Ay/FNg2RmftzXEjlRISXXo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SpWl0ujHBxD8uJ+gJXwnzBxPnbGusgxH+AufoLe2dbuio3b3rb/NYS9oyRmfcFSI+qU8ThnMg4jVNdKsMJ8BXOVSQ/eAmLEOlipscHCigDBcLd227Se5V6QhE67ewANiWEfE+tGkhFAlSZ/JsX1+qDsu8GE4IxpeNlkfkj2xYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaM3lN+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736C4C116B1;
	Thu, 25 Jul 2024 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921688;
	bh=XwYVVIPGvDLM+Mi4lkud9Ay/FNg2RmftzXEjlRISXXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eaM3lN+iLVyBPPl+yEcq6t0yIUHQzrNxG0e56HJ4cYuskPpcE2Myp72XAU77I8f9Q
	 56nrZ1j5Sps8BYWLpkdNaMvGQzPDo4DBKAYGsq/GRnc/HHmBXUhfXdVa4i0bxv5QOa
	 vrgr8lGA5k/wR74+3OIqOX+BJ5SLAckQqdTbThWIsf7AXRUQzXuVLrxoM2nM+1kVnu
	 k2+Yih1sZFgYaA3Tcc+xRWvSR/VdwocYU0hBKmnqTRvkNWKlUc/72f9QZyNu9xGUVQ
	 FmQp0sLXS9i6XS4DNIX2Ukur2ZMhgNyaJw4ZQLcFx6ZHaa114gdgESkylHcL0BvS8Z
	 nih0jxLIPhIaQ==
Date: Thu, 25 Jul 2024 10:34:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: George-Daniel Matei <danielgeorgem@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nic_swsd@realtek.com,
	netdev@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: r8169: add suspend/resume aspm quirk
Message-ID: <20240725153446.GA841157@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e0e1ceb-9da8-4227-8964-04e891c1d9e3@gmail.com>

[+cc Rafael in case you have suspend debug help]

On Tue, Jul 16, 2024 at 09:25:40PM +0200, Heiner Kallweit wrote:
> On 16.07.2024 14:13, George-Daniel Matei wrote:
> > On Thu, Jul 11, 2024 at 7:45 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >> On 10.07.2024 17:09, George-Daniel Matei wrote:
> >>>>> Added aspm suspend/resume hooks that run
> >>>>> before and after suspend and resume to change
> >>>>> the ASPM states of the PCI bus in order to allow
> >>>>> the system suspend while trying to prevent card hangs
> >>>>
> >>>> Why is this needed?  Is there a r8169 defect we're working around?
> >>>> A BIOS defect?  Is there a problem report you can reference here?
> >>>
> >>> We encountered this issue while upgrading from kernel v6.1 to v6.6.
> >>> The system would not suspend with 6.6. We tracked down the problem to
> >>> the NIC of the device, mainly that the following code was removed in
> >>> 6.6:
> >>>> else if (tp->mac_version >= RTL_GIGA_MAC_VER_46)
> >>>>         rc = pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);1
> >>
> >> With this (older) 6.1 version everything is ok?
> >> Would mean that L1.1 is active and the system suspends (STR?) properly
> >> also with L1.1 being active.
> >>
> > Yes, with 6.1 everything was ok. L1 was active and just the L1.1 substate
> > was enabled, L1.2 was disabled.
> > 
> >> Under 6.6 per default L1 (incl. sub-states) is disabled.
> >> Then you manually enable L1 (incl. L1.1, but not L1.2?) via sysfs,
> >> and now the system hangs on suspend?
> >>
> > Yes, in 6.6 L1 (+substates) is disabled. Like Bjorn mentioned, I
> > think that is because of 90ca51e8c654 ("r8169:
> > fix ASPM-related issues on a number of systems with NIC version from
> > RTL8168h". With L1 disabled the system would not suspend so I enabled
> > back L1 along with just L1.1 substate through sysfs, just to test, and
> > saw that the system could
> 
> It still sounds very weird that a system does not suspend to ram
> just because ASPM L1 is disabled for a single device.
> What if a PCI device is used which doesn't support ASPM?
> 
> Which subsystem fails to suspend? Can you provide a log showing
> the suspend error?

Can we push on this a little bit?  The fact that suspend fails is
super interesting to me.  I'd like to know exactly how this fails and
whether it's in the kernel or in firmware.  If we're violating some
assumption firmware is making, maybe there would be a more generic
fix.

How exactly do you suspend?  Is there any debugging output you can
collect while doing that?  Maybe [1] has hints.  I see a bunch of
trace_suspend_resume() calls, and I think they're connected to [2],
which looks like it might generate console/dmesg output, but I don't
know how to enable that.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/power/basic-pm-debugging.rst?id=v6.10
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/trace/events/power.h?id=v6.10#n247

