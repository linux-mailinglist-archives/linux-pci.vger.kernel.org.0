Return-Path: <linux-pci+bounces-22385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A338CA44DE4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B191170B3F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662A019E7ED;
	Tue, 25 Feb 2025 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGrtdVth"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF313B5B6;
	Tue, 25 Feb 2025 20:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740515901; cv=none; b=ZZB7hSU6yfl29DQsAwC06IMJOrVkOo+yBPVUC5LIT7eZDhaXaYu1hbAReln0Zx3Nz1557z8FV72qiS1vR3Y9BsrAYexcpo0R3e0mMU7MwCUVOnJ5m/ySUBSEp40pB170VaK84epsfrvaDgnN4oTYb/6QfJpsPJH1BAbozoJ4Vz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740515901; c=relaxed/simple;
	bh=J2rkB2PHUhOcdIxRiQMlCkNw1+TaIn4gTsxuIvAhsoo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MNF9zy/xMWOTDn+ivTdSw3hW4Bek0JvoZgu9TR6nFl8qI/npKLMT7VvwnD3jDZnb+eMHpCIXGFrw8JQqDAx3mnXUrz9ey3GIUvjJqpSRvMsacpvgTEJ7NSGh7jTKuWi7VHOa/tYC6Wr4beu7FLIbqIhtvY4HJ9qkroDgr/gsBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGrtdVth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8051FC4CEDD;
	Tue, 25 Feb 2025 20:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740515900;
	bh=J2rkB2PHUhOcdIxRiQMlCkNw1+TaIn4gTsxuIvAhsoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GGrtdVthoxLVMlEI/fF8VwHYL/Yw7TMYgSCbDxAM7dUxLvnktgJFAcBNpBxvOZZ/M
	 bIN9kq4blyIwTx+m3XVuXnGOh3iMLQ5IkK+eRCNVL4J8OzpzHnDzywLlyWYKZAj+R8
	 zvcP75LCQUidbJaQ0wvtMu1m1KIMalzVJhmHhLP86DyoMpQBwlidgtTPjBbWXT0tFG
	 ivY846gbSAMcjYa9OuBLh3DDZ0/yX/XM6Xx8s5IvVWidW1yL3t/7CSB1hhWPep73+x
	 JO/N/J6XjENKEgwNDFm18UNX2mzY6Ylo2cPOcJAb3Luo+O/QIXqqki64UDBINWUGoN
	 hU6tkRHgi5qMQ==
Date: Tue, 25 Feb 2025 14:38:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250225203818.GA516645@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMciSVX3X=DxLU0tfj4rG5WPaS5BCUDcMp2MYWBitT0ecEH+ig@mail.gmail.com>

On Tue, Feb 25, 2025 at 06:46:02PM +0530, Naveen Kumar P wrote:
> On Tue, Feb 25, 2025 at 1:24 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Tue, Feb 25, 2025 at 12:29:00AM +0530, Naveen Kumar P wrote:
> > > On Mon, Feb 24, 2025 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > > > > On Wed, Feb 19, 2025 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > I am writing to seek assistance with an issue we are experiencing with
> > > > > > > a PCIe device (PLDA Device 5555) connected through PCI Express Root
> > > > > > > Port 1 to the host bridge.
> > > > > > >
> > > > > > > We have observed that after booting the system, the Base Address
> > > > > > > Register (BAR0) memory of this device gets reset to 0x0 after
> > > > > > > approximately one hour or more (the timing is inconsistent). This was
> > > > > > > verified using the lspci output and the setpci -s 01:00.0
> > > > > > > BASE_ADDRESS_0 command.
> >
> > > ...
> > > I booted with the pcie_aspm=off kernel parameter, which means that
> > > PCIe Active State Power Management (ASPM) is disabled. Given this
> > > context, should I consider removing this setting to see if it affects
> > > the occurrence of the Bus Check notifications and the BAR0 reset
> > > issue?
> >
> > Doesn't seem likely to be related.  Once configured, ASPM operates
> > without any software intervention.  But note that "pcie_aspm=off"
> > means the kernel doesn't touch ASPM configuration at all, and any
> > configuration done by firmware remains in effect.
> >
> > You can tell whether ASPM has been enabled by firmware with "sudo
> > lspci -vv" before the problem occurs.
> >
> > > > > During the ACPI_NOTIFY_BUS_CHECK event, the lspci output initially
> > > > > showed all FF's, and then the next run of the same command showed
> > > > > BASE_ADDRESS_0 reset to zero:
> > > > > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > > > > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > > >
> > > > Looks like the device isn't responding at all here.  Could happen if
> > > > the device is reset or powered down.
> > >
> > > From the kernel driver or user space tools, is it possible to
> > > determine whether the device has been reset or powered down?  Are
> > > there any power management settings or configurations that could be
> > > causing the device to reset or power down unexpectedly?
> >
> > Not really.  By "powered down", I meant D3cold, where the main power
> > is removed.  Config space is readable in all other power states.
> >
> > > > What is this device?  What driver is bound to it?  I don't see
> > > > anything in dmesg that identifies a driver.
> > >
> > > The PCIe device in question is a Xilinx FPGA endpoint, which is
> > > flashed with RTL code to expose several host interfaces to the system
> > > via the PCIe link.
> > >
> > > We have an out-of-tree driver for this device, but to eliminate the
> > > driver's role in this issue, I renamed the driver to prevent it from
> > > loading automatically after rebooting the machine. Despite not using
> > > the driver, the issue still occurred.
> >
> > Oh, right, I forgot that you mentioned this before.
> >
> > > > You're seeing the problem on v5.4 (Nov 2019), which is much newer than
> > > > v4.4 (Jan 2016).  But v5.4 is still really too old to spend a lot of
> > > > time on unless the problem still happens on a current kernel.
> >
> > This part is important.  We don't want to spend a lot of time
> > debugging an issue that may have already been fixed upstream.
>
> Sure, I started building the 6.13 kernel and will post more
> information if I notice the issue on the 6.13 kernel.
> 
> Regarding the CommClk- (Common Clock Configuration) bit, it indicates
> whether the common clock configuration is enabled or disabled. When it
> is set to CommClk-, it means that the common clock configuration is
> disabled.
> 
> LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
>         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 
> For my device, I noticed that the common clock configuration is
> disabled. Could this be causing the BAR reset issue?

Not to my knowledge.

> How is the CommClk bit determined(to set or clear)? and is it okay to
> enable this bit after booting the kernel?

It is somewhere in drivers/pci/pcie/aspm.c, i.e.,
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aspm.c?id=v6.13#n383

