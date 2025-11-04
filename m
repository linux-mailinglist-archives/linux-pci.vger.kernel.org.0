Return-Path: <linux-pci+bounces-40293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5494C32E0F
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 21:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9CED4E0410
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898712EA479;
	Tue,  4 Nov 2025 20:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPu1GqD9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB322DEA93
	for <linux-pci@vger.kernel.org>; Tue,  4 Nov 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287130; cv=none; b=d2SXAklZe8uDodXVBfTyxLkMlbdrawZ5aZcSShh8ob3S9BQaJ9PYB7I7yhg3gSxTeXWJIzRXJzoqYN0e1HgujFWBukn1q7PlJJ7I0A+H4fy2Swl740mcxzSWQ/exmQVt+0G3feFTrzM20YN888g2bWdnGXgpOYP4XbDCIzOoyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287130; c=relaxed/simple;
	bh=eN/DHds5lWyrFoLAoVx1B/GZXBazYv68vltxZzSC8WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/aM9axiYTAru9yqhebpbRy3bDxnQyBzi20+8OxVBWL72G++CexiZSJg11DpiOyxstlnkSuwQtC2YeYtyvTyS06RB90Nub6MrdZbbajwFgUIwl1E4r5K8lUiS9W3UqSQI2Bd80rsXRH4H9oq2hFwFYxoIGlCE5YcjMu7sXaKuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPu1GqD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABE4C4CEF7;
	Tue,  4 Nov 2025 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762287129;
	bh=eN/DHds5lWyrFoLAoVx1B/GZXBazYv68vltxZzSC8WM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CPu1GqD9OdKHs2Pk4MfjnzaIdB2mQTpDq59ZbU0Bp+6ypRvEASwFyAWBumSRWEkLh
	 7Z6kBkK91TSqueQZugFUsW8ZZnif4i/uWc0ykrq4b7YsDofdK0pfGdbLOREEDRga9A
	 nLzP/b9sM6SHVPdviCVYq3cFEhdBAu1fTt38ogMiqZk8gsl7rcY6SfriE9WmqkrrRv
	 zAoEb8UdDcWYc2NvLA0XbBeXCYlP/jI1Zd7mJR9ACizvHGtF0UjGHF6w77DhhYCSp+
	 5GL6w2G8TOwsf4i+WrBpvI/Sy6cjfBCdNdBPiIf8wzPOpAezSPwkpTyPPr647keVxl
	 6o8KFtyHdEBUg==
Message-ID: <0c4325b4-ae50-4e3a-821a-33e8c614db10@kernel.org>
Date: Tue, 4 Nov 2025 14:12:08 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bugzilla-daemon@kernel.org: [Bug 220729] dmesg flooded with
 "PME: Spurious native interrupt". AMD, related to audio.]
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: "Artem S. Tashkinov" <aros@gmx.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
References: <20251104200516.GA1866276@bhelgaas>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20251104200516.GA1866276@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

++ Vijendar

On 11/4/25 2:05 PM, Bjorn Helgaas wrote:
> [+cc Mario, author of 3f6f237b9dd1 ("drm/amd: Update strapping for
> NBIO 2.5.0"), which resolved bug #215884;
> Ilpo, bwctrl expert;
> +bcc reporter]
> 
> It looks like PME and bwctrl share the interrupt; Teika, if it's easy
> for you, you might see if this is reproducible without bwctrl.
> There's no direct config option for it, but I think you could remove
> bwctrl.o from drivers/pci/pcie/Makefile.
> 

It's quite possibly the same type of strapping issue.

Are you on the latest BIOS for your system?  If so we may need to check 
if the strapping register for your system matches like what 3f6f237b9dd1 
does.

I can make you a similar patch to 3f6f237b9dd1 to try, I just need to 
confirm what system you really have to get the right register for that 
system.  See below because I'm quite confused.

/proc/cpuinfo would help me understand what you have.
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
> 
> I'll mention the bug #215884 later, a similar bug, titled "PME:
> Spurious native interrupt - AMD Ryzen 9 5900HS".
> 
> My dmesg is flooded with these lines after resuming from sleep (=s2ram):
> 
> ------------------------------------------------------------------------
> [67851.893155] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67855.243097] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67856.919303] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67858.572783] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67861.715546] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67863.385768] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67866.705320] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67868.257949] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67871.422045] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> [67873.037464] pcieport 0000:00:08.1: PME: Spurious native interrupt!
> ------------------------------------------------------------------------
> 
> emitted about every 1.6 secs, but not strictly periodical. (You see in
> the above some intervals are 1.6 * 2 secs.) "$ lspci -vvvt" reports
> this:
> 
> ------------------------------------------------------------------------
>       +-08.1-[03]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Phoenix3

I don't know what Phoenix3 is; I've never heard of such a device.  This 
sounds like a totally wrong string.

>       |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Rembrandt Radeon High Definition Audio Controller

This is quite obviously not Rembrandt either.

>       |            +-00.2  Advanced Micro Devices, Inc. [AMD] Family 19h (Model 74h) CCP/PSP 3.0 Device
>       |            +-00.3  Advanced Micro Devices, Inc. [AMD] Device 15b9
>       |            +-00.4  Advanced Micro Devices, Inc. [AMD] Device 15ba
>       |            +-00.5  Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor
>       |            +-00.6  Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller
>       |            \-00.7  Advanced Micro Devices, Inc. [AMD] Sensor Fusion Hub
> ------------------------------------------------------------------------
> 
> $ dmesg | grep '00:08.1'
> ------------------------------------------------------------------------
> pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Root Port
> pci 0000:00:08.1: PCI bridge to [bus 03]
> pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:08.1:   bridge window [mem 0x60000000-0x606fffff]
> pci 0000:00:08.1:   bridge window [mem 0x7f00000000-0x7f107fffff 64bit pref]
> pci 0000:00:08.1: enabling Extended Tags
> pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> pci 0000:00:08.1: PCI bridge to [bus 03]
> pci 0000:00:08.1: PCI bridge to [bus 03]
> pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
> pci 0000:00:08.1:   bridge window [mem 0x60000000-0x606fffff]
> pci 0000:00:08.1:   bridge window [mem 0x7f00000000-0x7f107fffff 64bit pref]
> pci 0000:00:08.1: Adding to iommu group 7
> pcieport 0000:00:08.1: PME: Signaling with IRQ 34
> input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card1/input18
> input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:03:00.1/sound/card1/input19
> input: HD-Audio Generic Headphone Mic as /devices/pci0000:00/0000:00:08.1/0000:03:00.6/sound/card0/input21
> ------------------------------------------------------------------------
> 
> $ grep '34:' /proc/interrupts
> ------------------------------------------------------------------------
> 34:          0          0   [snip]  IR-PCI-MSI-0000:00:08.1    0-edge      PCIe PME, PCIe bwctrl
> ------------------------------------------------------------------------
> 
> The problem is related to audio. When I plug in an earphone and wear
> it, I here  noise (like: Sh...Bz! Sh...Bz!), and this noise is
> synchronized to the above dmesg line. (It is reported on the active VT
> too, so I can visually see this synchronization.)
> 
> When I play some music, this message and the noise stop. When I stop
> music, sometimes the above message and the noise return, but it is not
> always; sometimes only one of noise or the message comes back; else
> none come back, and it's fixed until next sleep.
> 
> This happens only after awakening, not right after booting.
> 
> This is similar to the fixed bug #215884, but not identical. It
> reported that it only happend when a headphone is plugged in, but for
> mine, it happens regardless if an earphone is plugged. (I can't hear
> any noise emitted from the PC speaker, but the repeated dmesg occurs.)
> 
> (Probably an excess detail: Even when you plug in an earphone, you can
> direct ALSA to mute the earphone and output from the pc speaker. In
> such case I still hear noise from the earphone, and the period seems
> to be the same, but the noise patter is different.)
> 
> I'm not sure if this message is a regression of 6.17. I noticed the
> noise issue IIRC in 6.16, but not sure about that either.
> 
> Thanks beforehand.


