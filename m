Return-Path: <linux-pci+bounces-22261-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35294A42D19
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B362178B41
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C61FCCFA;
	Mon, 24 Feb 2025 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpglDdjU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C871A5B8B;
	Mon, 24 Feb 2025 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426866; cv=none; b=UJyIdS7tTFCQ4PmlCcgaBo6bB1qI/23kC50frpNpLJ0C01byyzIf/tQSSeAyDiTw5LLB8u21sQGOWba6p38TQ4bKqm6DQoG/brop3Z1BhS9uyTP/Ebwb3h+S11llS8kqS6unYfaahUsRBgEoU89767i62zhRmBBmOf3dqVT8gZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426866; c=relaxed/simple;
	bh=eqo9h/PAZIFf5dMdH1i9KPDuTNmee9ed3YQZ/4tZnaY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lUS5jhql8AwYzz8RNnK8HQ+6kuWx8EkDMmcSUR6koke6x9xsdcVNKStzxBkgeIOyAGoe3lvxwZMAvIO5sD2XMxfMmNVCp53cG8rRwL7DxVtC0B6ZKGSZs/xy7ShDsPuvACPChKFZzlpoNWxgmwP3UA7OqmJeSI/uwbgkJE6vQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpglDdjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA40C4CED6;
	Mon, 24 Feb 2025 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740426865;
	bh=eqo9h/PAZIFf5dMdH1i9KPDuTNmee9ed3YQZ/4tZnaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cpglDdjU1KMY82rxuH8gT0zRoyKc2n6kTkm4p5aWOIjwBB9C+4g0BTTXUfU6lTvX9
	 sJy+i/PsStFGOxxqxdmxOyOTdtxE8jd0INf4I6XWYP6hs21zmKRR1lL9z08MiNVza7
	 wipiYzFN9H1yQLjdXFqSG3oLbcu5PtdNqccPC69oAlC0kkjK5vZSj4QtVuHTjzWc5Z
	 CX3RBOaSXlmCcuLNhj4xcuNpZiSABVcq2A/elCjGyYu+puvSFDJ1X3f0x5HVKVVzTt
	 718WO/Me3Xn2STtbtb3mcg6V3E2VpiQkLIfKEpN2tpb7AaqMzOMYXpli8YjNm0OkvJ
	 4CzmON7cRxb3w==
Date: Mon, 24 Feb 2025 13:54:23 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Naveen Kumar P <naveenkumar.parna@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernelnewbies <kernelnewbies@kernelnewbies.org>,
	linux-acpi@vger.kernel.org
Subject: Re: PCI: hotplug_event: PCIe PLDA Device BAR Reset
Message-ID: <20250224195423.GA473540@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMciSVVV9tHH1M2bOnwqCJCQ8OjNFGjuQB7R-fY7JHHD5tQHoA@mail.gmail.com>

On Tue, Feb 25, 2025 at 12:29:00AM +0530, Naveen Kumar P wrote:
> On Mon, Feb 24, 2025 at 11:03 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Feb 24, 2025 at 05:45:35PM +0530, Naveen Kumar P wrote:
> > > On Wed, Feb 19, 2025 at 10:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Wed, Feb 19, 2025 at 05:52:47PM +0530, Naveen Kumar P wrote:
> > > > > Hi all,
> > > > >
> > > > > I am writing to seek assistance with an issue we are experiencing with
> > > > > a PCIe device (PLDA Device 5555) connected through PCI Express Root
> > > > > Port 1 to the host bridge.
> > > > >
> > > > > We have observed that after booting the system, the Base Address
> > > > > Register (BAR0) memory of this device gets reset to 0x0 after
> > > > > approximately one hour or more (the timing is inconsistent). This was
> > > > > verified using the lspci output and the setpci -s 01:00.0
> > > > > BASE_ADDRESS_0 command.

> ...
> I booted with the pcie_aspm=off kernel parameter, which means that
> PCIe Active State Power Management (ASPM) is disabled. Given this
> context, should I consider removing this setting to see if it affects
> the occurrence of the Bus Check notifications and the BAR0 reset
> issue?

Doesn't seem likely to be related.  Once configured, ASPM operates
without any software intervention.  But note that "pcie_aspm=off"
means the kernel doesn't touch ASPM configuration at all, and any
configuration done by firmware remains in effect.

You can tell whether ASPM has been enabled by firmware with "sudo
lspci -vv" before the problem occurs.

> > > During the ACPI_NOTIFY_BUS_CHECK event, the lspci output initially
> > > showed all FF's, and then the next run of the same command showed
> > > BASE_ADDRESS_0 reset to zero:
> > > $ sudo lspci -xxx -s 01:00.0 | grep "10:"
> > > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >
> > Looks like the device isn't responding at all here.  Could happen if
> > the device is reset or powered down.
>
> From the kernel driver or user space tools, is it possible to
> determine whether the device has been reset or powered down?  Are
> there any power management settings or configurations that could be
> causing the device to reset or power down unexpectedly?

Not really.  By "powered down", I meant D3cold, where the main power
is removed.  Config space is readable in all other power states.

> > What is this device?  What driver is bound to it?  I don't see
> > anything in dmesg that identifies a driver.
>
> The PCIe device in question is a Xilinx FPGA endpoint, which is
> flashed with RTL code to expose several host interfaces to the system
> via the PCIe link.
> 
> We have an out-of-tree driver for this device, but to eliminate the
> driver's role in this issue, I renamed the driver to prevent it from
> loading automatically after rebooting the machine. Despite not using
> the driver, the issue still occurred.

Oh, right, I forgot that you mentioned this before.

> > You're seeing the problem on v5.4 (Nov 2019), which is much newer than
> > v4.4 (Jan 2016).  But v5.4 is still really too old to spend a lot of
> > time on unless the problem still happens on a current kernel.

This part is important.  We don't want to spend a lot of time
debugging an issue that may have already been fixed upstream.

Bjorn

