Return-Path: <linux-pci+bounces-22907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1236BA4EEAE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 21:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA530189533C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E0324C07A;
	Tue,  4 Mar 2025 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rzjL0D6v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF05D2063F3;
	Tue,  4 Mar 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121159; cv=none; b=mbaat1WoHXIDPdJOBgHP2L9+0NDf3G2I7EX1iM9djq3s+hTuZsdNYlKVdV1CYuPHgYWdYaB0XasDx97dGihNvU6rIAvV2lRdjAWyjiqZKoVpOezCL9lslCPc21ZTlBAmOqVp50OHq8Ktj9n1pkp5XX9QjpYnBkg34PT+vz19I6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121159; c=relaxed/simple;
	bh=U/eFb/OESmts7OXb00T0AjKZaAO0FvaODgYQr6+SN4E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XrjS655UGw9mKdai376bUbPwJvLQcP9/8HDHRhqrHQD4Huk2+s8DZL/+qX8f768x5VvTs/IJo7mG+S3a7cgW3ibFBoRGaJkQi3lfoVa1bihG7mPJdk2FSYVCBMn0tCKKpF4GcQAlyKVKVKbDdpvm0e125ZJ6JqTnV7pLYvdgVnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rzjL0D6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C562C4CEE5;
	Tue,  4 Mar 2025 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741121158;
	bh=U/eFb/OESmts7OXb00T0AjKZaAO0FvaODgYQr6+SN4E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rzjL0D6vjy1aTbOmTZjO5d2W1L55mdV9KQ9N0D4XD4dgyRx84/ZqlUCAtAmnQ+Naa
	 ahnooz5VrnuBuW/FL/5DclNYdL36UU3AIbccX1bwPP7q4V+jpnYjoN884E0l64ASzC
	 TyL9VAQ2BS5aP0A9n/Hv35RSQfgytvKcm7xwIIUc7e/7sjnJtXZWfXdj283HOJld7M
	 SRq6BMv+iAe2xnNn1GMa5VqmjYoXf+NlB3Je/Q6PajSNHsRWnFNvcx2UDrzAErJPM4
	 1R6Azbqr2grRgOgJCfWaHpDEx3NoazvG7/4RUFyaSGLK/As0xcEjzPoBtj8oS5rG0N
	 QmwMvpnqQcoOQ==
Date: Tue, 4 Mar 2025 14:45:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250304204556.GA257201@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMciSVU2Xeh+3KsFK33GGLK7h59n9A_1RANdFV+ghGv39qcxPw@mail.gmail.com>

On Tue, Mar 04, 2025 at 01:35:14PM +0530, Naveen Kumar P wrote:
> On Fri, Feb 28, 2025 at 9:31 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Feb 26, 2025 at 06:28:33PM +0530, Naveen Kumar P wrote:
> > > On Wed, Feb 26, 2025 at 2:08 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Feb 25, 2025 at 06:46:02PM +0530, Naveen Kumar P wrote:
> > > > > On Tue, Feb 25, 2025 at 1:24 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Tue, Feb 25, 2025 at 12:29:00AM +0530, Naveen Kumar P wrote:
> > > > > > > On Mon, Feb 24, 2025 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > > > > > > > > On Wed, Feb 19, 2025 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > > > > > > > > > Hi all,
> > > > > > > > > > >
> > > > > > > > > > > I am writing to seek assistance with an issue we are
> > > > > > > > > > > experiencing with a PCIe device (PLDA Device 5555)
> > > > > > > > > > > connected through PCI Express Root Port 1 to the
> > > > > > > > > > > host bridge.
> > > > > > > > > > >
> > > > > > > > > > > We have observed that after booting the system, the
> > > > > > > > > > > Base Address Register (BAR0) memory of this device
> > > > > > > > > > > gets reset to 0x0 after approximately one hour or
> > > > > > > > > > > more (the timing is inconsistent). This was verified
> > > > > > > > > > > using the lspci output and the setpci -s 01:00.0
> > > > > > > > > > > BASE_ADDRESS_0 command.
> > > > > > > ...
> >
> > > I have downloaded the 6.13 kernel source and added additional debug
> > > logs in hotplug_event(), then built the kernel. After that rebooted
> > > with the new kernel using the following parameters:
> > > BOOT_IMAGE=/vmlinuz-6.13.0+ root=/dev/mapper/vg00-rootvol ro quiet
> > > libata.force=noncq pci=nomsi pcie_aspm=off pcie_ports=on "dyndbg=file
> > > drivers/pci/* +p; file drivers/acpi/* +p"
> >
> > Why "pci=nomsi"?  I don't think that should make a difference.  Also,
> > it contributes to the fact that Linux doesn't request OS control of
> > several features that it ordinarily does, so you end up in a somewhat
> > unusual state (which *should* still work, of course):
> >
> >   acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments HPX-Type3]
> >   acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> >
> > Same for "pcie_aspm=off".
>
> I initially suspected that the PCI BAR reset was happening due to the
> device entering a low-power state, so I set pcie_aspm=off to prevent
> it. 

ASPM never makes a device lose its state.  It's completely invisible
from a software point of view.

> As per your suggestion, I instrumented the PCI configuration
> accessors to log all reads and writes to my device (01:00.0). The
> corresponding patch
> (0002-instrumented-the-PCI-config-accessors-to-log-all-the.patch) is
> attached to this email. After applying the patch and rebooting with
> the same boot parameters, the issue reproduced after 193890 seconds.
> 
> The complete dmesg log (dmesg_march3rd_log.txt) is also attached.
> Could you check if this new log provides any useful clues?

> [193890.407810] ACPI: \_SB_.PCI0.RP01: ACPI: ACPI_NOTIFY_BUS_CHECK event
> [193890.407973] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bridge acquired in hotplug_event()
> [193890.408010] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Bus check in hotplug_event()
> [193890.408030] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Checking bridge in hotplug_event()
> [193890.408052] PCI READ: res=0, bus=01 dev=00 func=0 pos=0x00 len=4 data=0x55551556
> [193890.408095] PCI READ: res=0, bus=01 dev=00 func=0 pos=0x00 len=4 data=0x55551556

Looks perfectly fine.  This is reading the Vendor and Device IDs.

> [193890.408122] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Enabling slot in acpiphp_check_bridge()
> [193890.408184] ACPI: Device [PXSX] status [0000000f]
> [193890.408236] ACPI: Device [D015] status [0000000f]
> [193890.408305] ACPI: \_SB_.PCI0.RP01: acpiphp_glue: Releasing bridge in hotplug_event()

