Return-Path: <linux-pci+bounces-40292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF32FC32DFD
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 21:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB411884607
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B5D223710;
	Tue,  4 Nov 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk4C2BOY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5161F7098
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 20:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762286718; cv=none; b=Y8/MCkenKxIUgATpwfDp7GFAZBY6r/mdhK9FTY9R9ERrtl2m57jls6cK2+uyJ5elks7KqrWedMcYZYOWIAcNm9zGou5RBW8gtrndRlbFMehYKnuWgI1IiAjQXWq55WImpvZXhj6lbOv9IM/64GnSd7n0KIyObXsimBshKKclWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762286718; c=relaxed/simple;
	bh=DKbjP4lugb4/LapH36pqEN8crjAuWBgc1jT3ggRec0M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=U4zBmAQFxtLrmBlvAqIhprBMAH5uyTo/v7ED5LVWS5YAXDr1UFdE4hf1KBFS4ZB8aKnpX2vTxEx3iiE6EuO0HFtUVnsred0LyqL3935i9xRKrQ8ZSsI3GIZqxoRMch4R6fXgXzgHrwHYORwIKpNh0nD73yCBFw0sC0pgOEF9g4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk4C2BOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DA8C4CEF7;
	Tue,  4 Nov 2025 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762286717;
	bh=DKbjP4lugb4/LapH36pqEN8crjAuWBgc1jT3ggRec0M=;
	h=Date:From:To:Cc:Subject:From;
	b=Dk4C2BOYKruX19oOE5vtTbCWowcQJCQqAMkrs9fwkw78chSM7N7BF2BE6MnJbg4DC
	 TEonP0EAJTuce+z2ORNMgtn8b+yzEIkUJOkqmt30qc2u/KrFg0I450I6YTg+hqOaup
	 wQZQwYjphiap06WiRABF4YSRtXYT0tdrXBs0JEZyoPpn9KODagRQrhwBB6OXeaXKw0
	 BDvAghgCBqc90/fDMpEwjWu78BuFbX7dczHYqDSzkpM8BFGYGqZTR0zs6cvU0Ayyl4
	 40Sj/C4hfcgyuLFEWmLYu+cUL0x6drSJd7MKx8viD65UdKbNT+rxyw+in7u3hmAlnB
	 jHkhbMaBCmtoA==
Date: Tue, 4 Nov 2025 14:05:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: "Artem S. Tashkinov" <aros@gmx.com>,
	Mario Limonciello <superm1@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: [bugzilla-daemon@kernel.org: [Bug 220729] dmesg flooded with "PME:
 Spurious native interrupt". AMD, related to audio.]
Message-ID: <20251104200516.GA1866276@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[+cc Mario, author of 3f6f237b9dd1 ("drm/amd: Update strapping for
NBIO 2.5.0"), which resolved bug #215884;
Ilpo, bwctrl expert;
+bcc reporter]

It looks like PME and bwctrl share the interrupt; Teika, if it's easy
for you, you might see if this is reproducible without bwctrl.
There's no direct config option for it, but I think you could remove
bwctrl.o from drivers/pci/pcie/Makefile.

----- Forwarded message from bugzilla-daemon@kernel.org -----

I'll mention the bug #215884 later, a similar bug, titled "PME:
Spurious native interrupt - AMD Ryzen 9 5900HS".

My dmesg is flooded with these lines after resuming from sleep (=s2ram):

------------------------------------------------------------------------
[67851.893155] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67855.243097] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67856.919303] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67858.572783] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67861.715546] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67863.385768] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67866.705320] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67868.257949] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67871.422045] pcieport 0000:00:08.1: PME: Spurious native interrupt!
[67873.037464] pcieport 0000:00:08.1: PME: Spurious native interrupt!
------------------------------------------------------------------------

emitted about every 1.6 secs, but not strictly periodical. (You see in
the above some intervals are 1.6 * 2 secs.) "$ lspci -vvvt" reports
this:

------------------------------------------------------------------------
     +-08.1-[03]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Phoenix3
     |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Rembrandt Radeon High Definition Audio Controller
     |            +-00.2  Advanced Micro Devices, Inc. [AMD] Family 19h (Model 74h) CCP/PSP 3.0 Device
     |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device 15b9
     |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device 15ba
     |            +-00.5  Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor
     |            +-00.6  Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller
     |            \-00.7  Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub
------------------------------------------------------------------------

$ dmesg | grep '00:08.1'
------------------------------------------------------------------------
pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Root Port
pci 0000:00:08.1: PCI bridge to [bus 03]
pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
pci 0000:00:08.1:   bridge window [mem 0x60000000-0x606fffff]
pci 0000:00:08.1:   bridge window [mem 0x7f00000000-0x7f107fffff 64bit pref]
pci 0000:00:08.1: enabling Extended Tags
pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
pci 0000:00:08.1: PCI bridge to [bus 03]
pci 0000:00:08.1: PCI bridge to [bus 03]
pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
pci 0000:00:08.1:   bridge window [mem 0x60000000-0x606fffff]
pci 0000:00:08.1:   bridge window [mem 0x7f00000000-0x7f107fffff 64bit pref]
pci 0000:00:08.1: Adding to iommu group 7
pcieport 0000:00:08.1: PME: Signaling with IRQ 34
input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card1/input18
input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card1/input19
input: HD-Audio Generic Headphone Mic as /devices/pci0000:00/0000:00:08.1/0000:03:00.6/sound/card0/input21
------------------------------------------------------------------------

$ grep '34:' /proc/interrupts
------------------------------------------------------------------------
34:          0          0   [snip]  IR-PCI-MSI-0000:00:08.1    0-edge      PCIe PME, PCIe bwctrl
------------------------------------------------------------------------

The problem is related to audio. When I plug in an earphone and wear
it, I here  noise (like: Sh...Bz! Sh...Bz!), and this noise is
synchronized to the above dmesg line. (It is reported on the active VT
too, so I can visually see this synchronization.)

When I play some music, this message and the noise stop. When I stop
music, sometimes the above message and the noise return, but it is not
always; sometimes only one of noise or the message comes back; else
none come back, and it's fixed until next sleep.

This happens only after awakening, not right after booting.

This is similar to the fixed bug #215884, but not identical. It
reported that it only happend when a headphone is plugged in, but for
mine, it happens regardless if an earphone is plugged. (I can't hear
any noise emitted from the PC speaker, but the repeated dmesg occurs.)

(Probably an excess detail: Even when you plug in an earphone, you can
direct ALSA to mute the earphone and output from the pc speaker. In
such case I still hear noise from the earphone, and the period seems
to be the same, but the noise patter is different.)

I'm not sure if this message is a regression of 6.17. I noticed the
noise issue IIRC in 6.16, but not sure about that either.

Thanks beforehand.

