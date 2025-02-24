Return-Path: <linux-pci+bounces-22254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B38A42C2A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F8316D772
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9226657E;
	Mon, 24 Feb 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY54XUrY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF9413F43B;
	Mon, 24 Feb 2025 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423559; cv=none; b=qVbPKlYeGYrfwHdP4IuWruLI33n74WQ1EVwcPJcE8KTYp+v+J2pkUdsMcjEMu+TMn+zrWwGouGyuDsP1bymtLeiPliA1ZCLiMf+POBoWTopIN7MfIWGAUsFnoSsGMn5rUB1k3v+zjadMXLCtUDyBpTI1LYFgZqlJn+UosZT6FMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423559; c=relaxed/simple;
	bh=KYthieVj/9Pr5ksnnqwQBvMZxzZb5IsS2YVg7V+j/L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeXEH4+ipuAUi0MF0ckRHEf7HaMpgOYkTNO8PK5/LjqeP4AMvEkU4lghy1Gqz0kP0rMrHVtKE/trTMSuu3GfZ6HtTxfa9TqdAXd5rq3yTijb1TOiiZ/vj+GLOHanHD5PDSC7oEhSRT4GE0GdQEt58UQtHyAzjKxBtf9uAJ9lavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY54XUrY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5452c2805bcso5260893e87.2;
        Mon, 24 Feb 2025 10:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740423554; x=1741028354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAgfDIH05KobIJl9Rv3CAcwgU/FDNBB4KpD1MvLrjAA=;
        b=nY54XUrY94A7xLpiLEAMJXxxPkzBT+g037YmIwXX61hPc6ZbHuPTCIu1BH/xa8x1vo
         bwm3f3N44ZVhMGejRcmYyEv9AmafDFdqYGOPKQWYYIYTJ5z6EhT22Qg6f7reVL7n2vPo
         Mj0DibafxBb9XST8l4pAQxyePjzghKflvePgCv7ZzM8aeAjY0naoRnBItVm/6TkF+Rb7
         53xQP8jFSZ+PRgn+EHhhZ+gMAWdleywPdMWC+xRlH+skgC1qKgx2tjwVf0eCrVvdVzBI
         MPQ195f6mAgnk1xxmuY5DRsW9Ww+0m/9jmpzDOs6xnAMuNcaMcHO+/tB8pDs2LTSj5DU
         KrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740423554; x=1741028354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAgfDIH05KobIJl9Rv3CAcwgU/FDNBB4KpD1MvLrjAA=;
        b=n5tJibn9DGxtm4cH3UGr3V0G3kE9Dh5bJPbQqEP5FLZC/5BRfcIJH/biTHvnLY9k5j
         lpB+X8H8ofqFasXaAq7g86gKL5v9oS4LKIsI8zc5l/p9LjMNfiCmyMCnrUQqgm88ELZ2
         nMf1+/4YKSBWQL0rGeoqQO5ce9wKCly+lPUoPoNdsTU8JX3tpNVO2eNabRnJ6yfjrcLl
         u0somgBboVP+vYp4yFzySNfLUkwePrED56nODVOGwtbickEABMWXM/GiegxmiNM9czXR
         pvw4tvSIYSyuGr2eoAOvOng4Ju3sbmwaDCv+TpdH6VXVOHgITOHHi7w94JysjjrpSh86
         yUGw==
X-Forwarded-Encrypted: i=1; AJvYcCVE1mejCY9fXbJqVaasbrvH07SKzdn2h1uNmsSRxlJTJsd6RTiayceTYQRtBIzEYOMzNVad2Ms5iLM4@vger.kernel.org, AJvYcCVyX+RkmzyQENv3JBfQf7hsfWWF1krrNve7homWShgTBcJEziIZFr/xQGBWWr6V4As1jc8pns8/B5iRuJk2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw46Bkq5AMqRwWNNdj38nD+U1VotarBkbulUvfIfv9wRuGvv2ID
	5YQNk62eupe5Ru6xBUdVeHr7VzRvvNWYIb8kRSm+7kze2KLCwNwNvwRMLqeP9uNVawvvCy6UOGm
	xEoYruIul/o8uOZDCF7/01rUo2w==
X-Gm-Gg: ASbGncteYUS/pSatq/H7HmTrzAx2+P2JPIezcHIccsm2gd+gGNG4Ap5Y5SkDJwrtYxU
	DpwVJ8NOh/54a1eb+VvZkVICdCKwnvoQanqAxBkqDfyWamPOaICyE8NOJEXOB6QmkcWKTH9nwe6
	eGym4xxe1j
X-Google-Smtp-Source: AGHT+IF2sGr/cec9AWF55p6Eds8H08H2l5S2epO4fFQpl8cKp0/MCXX/bfOgiCT3cTTE/m7vLbpimfCFyFijFXreTis=
X-Received: by 2002:a05:6512:2389:b0:542:29a6:db5a with SMTP id
 2adb3069b0e04-548510ecfb8mr67751e87.35.1740423553491; Mon, 24 Feb 2025
 10:59:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVXDS_n7-XzHevMmAOhb-qCNsCBbE1Pym-zWybnOyjZWmw@mail.gmail.com>
 <20250224173317.GA466030@bhelgaas>
In-Reply-To: <20250224173317.GA466030@bhelgaas>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Tue, 25 Feb 2025 00:29:00 +0530
X-Gm-Features: AQ5f1Jrdcnk-qJGymxdfr0AHwI-TLuap3w6OjaLZVHwNV2L0dQLsY1tRLdGenLM
Message-ID: <CAMciSVVV9tHH1M2bOnwqCJCQ8OjNFGjuQB7R-fY7JHHD5tQHoA@mail.gmail.com>
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:03=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org>=
 wrote:
>
> On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > On Wed, Feb 19, 2025 at 10:36=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.=
org> wrote:
> > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > > Hi all,
> > > >
> > > > I am writing to seek assistance with an issue we are experiencing w=
ith
> > > > a PCIe device (PLDA Device 5555) connected through PCI Express Root
> > > > Port 1 to the host bridge.
> > > >
> > > > We have observed that after booting the system, the Base Address
> > > > Register (BAR0) memory of this device gets reset to 0x0 after
> > > > approximately one hour or more (the timing is inconsistent). This w=
as
> > > > verified using the lspci output and the setpci -s 01:00.0
> > > > BASE_ADDRESS_0 command.
> > > >
> > > > To diagnose the issue, we checked the dmesg log, but it did not
> > > > provide any relevant information. I then enabled dynamic debugging =
for
> > > > the PCI subsystem (drivers/pci/*) and noticed the following message=
s
> > > > related ACPI hotplug in the dmesg log:
> > > >
> > > > [    0.465144] pci 0000:01:00.0: reg 0x10: [mem 0xb0400000-0xb07fff=
ff]
> > > > ...
> > > > [ 6710.000355] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in ho=
tplug_event()
> > > > [ 7916.250868] perf: interrupt took too long (4072 > 3601), lowerin=
g
> > > > kernel.perf_event_max_sample_rate to 49000
> > > > [ 7984.719647] perf: interrupt took too long (5378 > 5090), lowerin=
g
> > > > kernel.perf_event_max_sample_rate to 37000
> > > > [11051.409115] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in ho=
tplug_event()
> > > > [11755.388727] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in ho=
tplug_event()
> > > > [12223.885715] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in ho=
tplug_event()
> > > > [14303.465636] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in ho=
tplug_event()
> > > > After these messages appear, reading the device BAR memory results =
in
> > > > 0x0 instead of the expected value.
> > > >
> > > > I would like to understand the following:
> > > >
> > > > 1. What could be causing these hotplug_event debug messages?
> > >
> > > This is an ACPI Notify event.  Basically the platform is telling us t=
o
> > > re-enumerate the hierarchy below RP01 because a device might have bee=
n
> > > added or removed.
> >
> > Thank you for your response regarding the PCI BAR reset issue we are
> > experiencing with the PLDA Device 5555. I have a few follow-up
> > questions and additional information to share.
> >
> > 1. Clarification on "Platform":
> >
> > Does the term "platform" refer to the BIOS/ACPI subsystem in this conte=
xt?
>
> Yes, "platform" refers to the BIOS/ACPI subsystem.
>
> > Can the platform signal to re-enumerate the hierarchy below RP01
> > without an actual device being removed or added? In our case, the PCI
> > PLDA device is neither physically removed nor connected to the bus on
> > the fly.
>
> Yes, I think a Bus Check notification is just a request for the OS to
> re-enumerate starting at the point in the device tree where it is
> notified.  It's possible that no add or remove has occurred.  ACPI
> r6.5, sec 5.6.6, includes the example of hardware that can't detect
> device changes during a system sleep state, so it issues a Bus Check
> on wake.
I booted with the pcie_aspm=3Doff kernel parameter, which means that
PCIe Active State Power Management (ASPM) is disabled. Given this
context, should I consider removing this setting to see if it affects
the occurrence of the Bus Check notifications and the BAR0 reset
issue?

>
> > 2. System Configuration:
> >
> > We are currently using an x86_64 system with Ubuntu 20.04.6 LTS
> > (kernel version: 5.4.0-148-generic).
> > I have enabled dynamic debug logs for all files in the PCI and ACPI
> > subsystems and rebooted the system with the following parameters:
> > $ cat /proc/cmdline
> > BOOT_IMAGE=3D/vmlinuz-5.4.0-148-generic root=3D/dev/mapper/vg00-rootvol=
 ro
> > quiet libata.force=3Dnoncq pci=3Dnomsi pcie_aspm=3Doff pcie_ports=3Don
> > "dyndbg=3Dfile drivers/pci/* +p; file drivers/acpi/* +p"
> >
> >
> > 3. Observations:
> >
> > After rebooting with more debug logs, I noticed the issue after 1 day,
> > 11:48 hours.
> > A snippet of the dmesg log is mentioned below (complete dmesg log is
> > attached to this email):
> >
> > [128845.248503] ACPI: GPE event 0x01
> > [128845.356866] ACPI: \_SB_.PCI0.RP01: ACPI_NOTIFY_BUS_CHECK event
> > [128845.357343] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in
> > hotplug_event()
>
> If you could add more debug in hotplug_event() and the things it
> calls, we might get more clues about what's happening.
>
> > 4. BAR Reset Issue:
> >
> > I filtered the lspci output to show the contents of the configuration
> > space starting at offset 0x10 for getting BASE_ADDRESS_0 by running
> > sudo lspci -xxx -s 01:00.0 | grep "10:".
> > Prior to the BAR reset issue, the lspci output was:
> > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > 10: 00 00 40 b0 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > During the ACPI_NOTIFY_BUS_CHECK event, the lspci output initially
> > showed all FF's, and then the next run of the same command showed
> > BASE_ADDRESS_0 reset to zero:
> > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>
> Looks like the device isn't responding at all here.  Could happen if
> the device is reset or powered down.
From the kernel driver or user space tools, is it possible to
determine whether the device has been reset or powered down?
Are there any power management settings or configurations that could
be causing the device to reset or power down unexpectedly?
>
> What is this device?  What driver is bound to it?  I don't see
> anything in dmesg that identifies a driver.
The PCIe device in question is a Xilinx FPGA endpoint, which is
flashed with RTL code to expose several host interfaces to the system
via the PCIe link.

We have an out-of-tree driver for this device, but to eliminate the
driver's role in this issue, I renamed the driver to prevent it from
loading automatically after rebooting the machine. Despite not using
the driver, the issue still occurred.

>
> > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >
> > I am not sure why lspci initially showed all FF's and then the next
> > run showed BAR0 reset.
> > Complete sudo lspci -xxx -s 01:00.0 output is captured in the attached
> > dmesg_log_pci_bar_reset.txt file.
> >
> > /sys/firmware/acpi/interrupts/gpe01:       1  EN     enabled      unmas=
ked
> > /sys/firmware/acpi/interrupts/gpe02:       1  EN     enabled      unmas=
ked
> >
> >
> > 5. Debugging Steps:
> >
> > Instrumenting acpiphp_check_bridge() will indicate whether we are
> > enabling or disabling a slot (enable_slot() or disable_slot()). Based
> > on the dmesg log, there is only one ACPI_NOTIFY_BUS_CHECK event, and
> > it is most likely for disable_slot(). However, does instrumenting
> > acpiphp_check_bridge() will explain why this is happening without
> > actually removing the PCI PLDA device?
>
> No, it won't explain that.  But if there was no add/remove event,
> re-enumeration should be harmless.  The objective of instrumentation
> would be to figure out why it isn't harmless in this case.
>
> > 6. Reproduction and Additional Information:
> >
> > We do not see any clear pattern or procedure to reproduce this issue.
> > Once the issue occurs, rebooting the machine resolves it, but it
> > reoccurs after an unpredictable time.
> > We have another identical hardware setup with an older kernel (Ubuntu
> > 16.04.4 LTS, kernel version: 4.4.0-66-generic), and this issue has not
> > been observed so far on that machine.
> > Any additional pointers or suggestions on how to proceed to the root
> > cause of this issue would be greatly appreciated.
>
> You're seeing the problem on v5.4 (Nov 2019), which is much newer than
> v4.4 (Jan 2016).  But v5.4 is still really too old to spend a lot of
> time on unless the problem still happens on a current kernel.
>
> Bjorn

