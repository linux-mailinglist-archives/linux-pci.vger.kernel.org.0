Return-Path: <linux-pci+bounces-22650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1CDA49E36
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D76D1729A0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFA8270EAB;
	Fri, 28 Feb 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK1leaUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190E270041;
	Fri, 28 Feb 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758495; cv=none; b=epWFl9ObTrEdpEdV1XKsGOGcNJikO4SqpkuPVxaKKQtmVgr3p3TLQFb29XnmwiXEvGoIdiwCTLvxEbE26M4oJ+Oz+lRg8s5YOXZHyf+skCiaoo4631SUqUp4rhwQjNFjBS2zWzalOmsmA9I3ys1vBXPF/IT93wW0zUElC+1UJzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758495; c=relaxed/simple;
	bh=nLe42b5YqahQ2bBbKWI/L708bdmiC3psGRi86jrrOXk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QVK1jrpND3zxq1iw84FEK96KLVVNQxReMcc25jwhQg2jDYZUVlQjqmj9/rKNn9rpPpIzqyBUangCQYOV6991Kqo7kF2ZYNWUCpLjN07Z2E9iNS7vPZPrA0fa2hW1R8bLvlZiesviDaJze1mgDObhR3KdUIDuW/0Uq40LGT//feI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK1leaUT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B40C4CEE2;
	Fri, 28 Feb 2025 16:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740758494;
	bh=nLe42b5YqahQ2bBbKWI/L708bdmiC3psGRi86jrrOXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NK1leaUT1OwqQKt4H0xAdLLXEpzGhZQnMiT7RCoIWRD8Cw57tBYjuPzgU/ENHlFkE
	 ToCSFIoox/UImp8s6JjVEHWFyhg3Lv2p0sAKTLBc4/CilmTWRm4atYZBOvE3xtoZlW
	 8dnIfftXC3yxduqarVzg3gZwvpk2NDu7UwcYQF7yhmxl42dLua0GdLLXKouocXxw+E
	 ua4ux2sBPAUrF2cDvMc86PH4UsNaacqM/tRfaiUKVHgzkSSFS41Nrnw7WTaJA7g95k
	 DAFHFibunGV+fwqqpZxForCIAIfxRjBH/MlpxHHwyyN90c+sG3RRPkDKusr4yNRypD
	 KPkX+mM/6vFDA==
Date: Fri, 28 Feb 2025 10:01:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250228160133.GA51628@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMciSVUFpkuxt-8MzvsRnM9B8F0UQGjfUxBJufGVK1=m2DooNw@mail.gmail.com>

On Wed, Feb 26, 2025 at 06:28:33PM +0530, Naveen Kumar P wrote:
> On Wed, Feb 26, 2025 at 2:08 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Feb 25, 2025 at 06:46:02PM +0530, Naveen Kumar P wrote:
> > > On Tue, Feb 25, 2025 at 1:24 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Tue, Feb 25, 2025 at 12:29:00AM +0530, Naveen Kumar P wrote:
> > > > > On Mon, Feb 24, 2025 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > > > > > > On Wed, Feb 19, 2025 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > > > > > > > Hi all,
> > > > > > > > >
> > > > > > > > > I am writing to seek assistance with an issue we are
> > > > > > > > > experiencing with a PCIe device (PLDA Device 5555)
> > > > > > > > > connected through PCI Express Root Port 1 to the
> > > > > > > > > host bridge.
> > > > > > > > >
> > > > > > > > > We have observed that after booting the system, the
> > > > > > > > > Base Address Register (BAR0) memory of this device
> > > > > > > > > gets reset to 0x0 after approximately one hour or
> > > > > > > > > more (the timing is inconsistent). This was verified
> > > > > > > > > using the lspci output and the setpci -s 01:00.0
> > > > > > > > > BASE_ADDRESS_0 command.
> > > > > ...

> I have downloaded the 6.13 kernel source and added additional debug
> logs in hotplug_event(), then built the kernel. After that rebooted
> with the new kernel using the following parameters:
> BOOT_IMAGE=/vmlinuz-6.13.0+ root=/dev/mapper/vg00-rootvol ro quiet
> libata.force=noncq pci=nomsi pcie_aspm=off pcie_ports=on "dyndbg=file
> drivers/pci/* +p; file drivers/acpi/* +p"

Why "pci=nomsi"?  I don't think that should make a difference.  Also,
it contributes to the fact that Linux doesn't request OS control of
several features that it ordinarily does, so you end up in a somewhat
unusual state (which *should* still work, of course):

  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments HPX-Type3]
  acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

Same for "pcie_aspm=off".

Why "pcie_ports=on"?  That's not a valid parameter:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/portdrv.c?id=v6.13#n619

> Complete dmesg log and the patch(to get additional debug information)
> are attached to this email.
> 
> Any further guidance on these observations?

I'm out of ideas.  I would instrument the PCI config accessors to log
all the reads and writes to your device (01:00.0) to see what we do to
the device.  Maybe there's some hint:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/access.c?id=v6.13#n35

> Additionally, I noticed that the initial bootup logs with the
> "0.000000" timestamp are missing in the dmesg log with this new
> kernel. I'm unsure what might be causing this issue.

Probably overflowed the message buffer.  You can try increasing the
buffer size:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/kernel-parameters.txt?id=v6.13#n3190

You can also experiment with the dyndbg parameter to be more selective
about the ACPI messages if some aren't useful.

Bjorn

