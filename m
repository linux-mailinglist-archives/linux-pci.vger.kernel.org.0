Return-Path: <linux-pci+bounces-22245-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC5DA429F3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C4417C618
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B3264FA6;
	Mon, 24 Feb 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGuPLexM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6740264A98;
	Mon, 24 Feb 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418400; cv=none; b=e7Vv0cQ2WoldTylgy5MklGbXzRyaZSfK5Vxwkv/w0a4sSep+aS33ecci0KeL5u3Q+lupFB52boc7yyco9jbAuqh8vyy0tYXzGnTISmiwAEmxXEbMUL9DLk3HbvaKvi85ue6Ft3lE9mGautgS0i7UcRIoule1nPzP8MCCuwSCKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418400; c=relaxed/simple;
	bh=xsa6CB+0p3j46klgNP8VObiplu83k0LJzmWbufYfbpw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QDcouLrQYpdPnHs3uL/WJ0O0hJHSrg9h7keEpPhbF0dZSiNHXLf+Nac5TrOqhKnua2zMqMI0uiY75IjPmhEbquGq45b3x29EzFo0Ae5GiJTwWA4Wt0Y+BzJNXXbFeTCvZ2AP8o+ylW/fpIjjMlbseYGpBjacvMj+vmmTT5QP+MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGuPLexM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A825C4CED6;
	Mon, 24 Feb 2025 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740418399;
	bh=xsa6CB+0p3j46klgNP8VObiplu83k0LJzmWbufYfbpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iGuPLexMPJg7W5C91pminzicrpjldK7F/XuaOaWEQjACx7w4LiFfEVNbadaSdTNP3
	 MzkI7wUKAFH3kk5+R4wo7Lqda653WxTs40KQKa4TwLWzN3taw7LBDaK2wonAoeJKHw
	 U3KeGcf5nbTbsn50L+4flIvqSc52/hYjdRk6dnlXrSrrHhaClngSrD2hmMSutgRwYB
	 8J4hjK+VHehMJRSWzbi0cP3GK7+m4oSe6exKMBwsGH9Ca8Ey1j6HEmSwP9/kQFHCv/
	 c8s0NbxTN7Y1DThPQfJPsEvOpxKZf+eBZXk8E0YL8RvDTaWpkSZbwzofiK4LeV24vo
	 zLuPyiTekCg6Q==
Date: Mon, 24 Feb 2025 11:33:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250224173317.GA466030@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMciSVXDS_n7-XzHevMmAOhb-qCNsCBbE1Pym-zWybnOyjZWmw@mail.gmail.com>

On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> On Wed, Feb 19, 2025 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > Hi all,
> > >
> > > I am writing to seek assistance with an issue we are experiencing with
> > > a PCIe device (PLDA Device 5555) connected through PCI Express Root
> > > Port 1 to the host bridge.
> > >
> > > We have observed that after booting the system, the Base Address
> > > Register (BAR0) memory of this device gets reset to 0x0 after
> > > approximately one hour or more (the timing is inconsistent). This was
> > > verified using the lspci output and the setpci -s 01:00.0
> > > BASE_ADDRESS_0 command.
> > >
> > > To diagnose the issue, we checked the dmesg log, but it did not
> > > provide any relevant information. I then enabled dynamic debugging for
> > > the PCI subsystem (drivers/pci/*) and noticed the following messages
> > > related ACPI hotplug in the dmesg log:
> > >
> > > [    0.465144] pci 0000:01:00.0: reg 0x10: [mem 0xb0400000-0xb07fffff]
> > > ...
> > > [ 6710.000355] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> > > [ 7916.250868] perf: interrupt took too long (4072 > 3601), lowering
> > > kernel.perf_event_max_sample_rate to 49000
> > > [ 7984.719647] perf: interrupt took too long (5378 > 5090), lowering
> > > kernel.perf_event_max_sample_rate to 37000
> > > [11051.409115] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> > > [11755.388727] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> > > [12223.885715] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> > > [14303.465636] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> > > After these messages appear, reading the device BAR memory results in
> > > 0x0 instead of the expected value.
> > >
> > > I would like to understand the following:
> > >
> > > 1. What could be causing these hotplug_event debug messages?
> >
> > This is an ACPI Notify event.  Basically the platform is telling us to
> > re-enumerate the hierarchy below RP01 because a device might have been
> > added or removed.
>
> Thank you for your response regarding the PCI BAR reset issue we are
> experiencing with the PLDA Device 5555. I have a few follow-up
> questions and additional information to share.
> 
> 1. Clarification on "Platform":
> 
> Does the term "platform" refer to the BIOS/ACPI subsystem in this context?

Yes, "platform" refers to the BIOS/ACPI subsystem.

> Can the platform signal to re-enumerate the hierarchy below RP01
> without an actual device being removed or added? In our case, the PCI
> PLDA device is neither physically removed nor connected to the bus on
> the fly.

Yes, I think a Bus Check notification is just a request for the OS to
re-enumerate starting at the point in the device tree where it is
notified.  It's possible that no add or remove has occurred.  ACPI
r6.5, sec 5.6.6, includes the example of hardware that can't detect
device changes during a system sleep state, so it issues a Bus Check
on wake.

> 2. System Configuration:
> 
> We are currently using an x86_64 system with Ubuntu 20.04.6 LTS
> (kernel version: 5.4.0-148-generic).
> I have enabled dynamic debug logs for all files in the PCI and ACPI
> subsystems and rebooted the system with the following parameters:
> $ cat /proc/cmdline
> BOOT_IMAGE=/vmlinuz-5.4.0-148-generic root=/dev/mapper/vg00-rootvol ro
> quiet libata.force=noncq pci=nomsi pcie_aspm=off pcie_ports=on
> "dyndbg=file drivers/pci/* +p; file drivers/acpi/* +p"
> 
>
> 3. Observations:
> 
> After rebooting with more debug logs, I noticed the issue after 1 day,
> 11:48 hours.
> A snippet of the dmesg log is mentioned below (complete dmesg log is
> attached to this email):
> 
> [128845.248503] ACPI: GPE event 0x01
> [128845.356866] ACPI: \_SB_.PCI0.RP01: ACPI_NOTIFY_BUS_CHECK event
> [128845.357343] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in
> hotplug_event()

If you could add more debug in hotplug_event() and the things it
calls, we might get more clues about what's happening.

> 4. BAR Reset Issue:
> 
> I filtered the lspci output to show the contents of the configuration
> space starting at offset 0x10 for getting BASE_ADDRESS_0 by running
> sudo lspci -xxx -s 01:00.0 | grep "10:".
> Prior to the BAR reset issue, the lspci output was:
> $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> 10: 00 00 40 b0 00 00 00 00 00 00 00 00 00 00 00 00
> 
> During the ACPI_NOTIFY_BUS_CHECK event, the lspci output initially
> showed all FF's, and then the next run of the same command showed
> BASE_ADDRESS_0 reset to zero:
> $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Looks like the device isn't responding at all here.  Could happen if
the device is reset or powered down.

What is this device?  What driver is bound to it?  I don't see
anything in dmesg that identifies a driver.

> $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> I am not sure why lspci initially showed all FF's and then the next
> run showed BAR0 reset.
> Complete sudo lspci -xxx -s 01:00.0 output is captured in the attached
> dmesg_log_pci_bar_reset.txt file.
> 
> /sys/firmware/acpi/interrupts/gpe01:       1  EN     enabled      unmasked
> /sys/firmware/acpi/interrupts/gpe02:       1  EN     enabled      unmasked
> 
> 
> 5. Debugging Steps:
> 
> Instrumenting acpiphp_check_bridge() will indicate whether we are
> enabling or disabling a slot (enable_slot() or disable_slot()). Based
> on the dmesg log, there is only one ACPI_NOTIFY_BUS_CHECK event, and
> it is most likely for disable_slot(). However, does instrumenting
> acpiphp_check_bridge() will explain why this is happening without
> actually removing the PCI PLDA device?

No, it won't explain that.  But if there was no add/remove event,
re-enumeration should be harmless.  The objective of instrumentation
would be to figure out why it isn't harmless in this case.

> 6. Reproduction and Additional Information:
> 
> We do not see any clear pattern or procedure to reproduce this issue.
> Once the issue occurs, rebooting the machine resolves it, but it
> reoccurs after an unpredictable time.
> We have another identical hardware setup with an older kernel (Ubuntu
> 16.04.4 LTS, kernel version: 4.4.0-66-generic), and this issue has not
> been observed so far on that machine.
> Any additional pointers or suggestions on how to proceed to the root
> cause of this issue would be greatly appreciated.

You're seeing the problem on v5.4 (Nov 2019), which is much newer than
v4.4 (Jan 2016).  But v5.4 is still really too old to spend a lot of
time on unless the problem still happens on a current kernel.

Bjorn

