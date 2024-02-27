Return-Path: <linux-pci+bounces-4161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FD86A2D1
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 23:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A174B24CD5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3055E4A;
	Tue, 27 Feb 2024 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmYYcYq5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91055E49;
	Tue, 27 Feb 2024 22:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074282; cv=none; b=riDJ1peOkqJ8TAqGjV78K9kQD8kgageRHz6vc2/i+u2GSY0OihASH0P7B5PmFH0UqlZqlXuFjOTA2Gqts86UX0LLU+iZ6TfGkXyGdWaSROK2x2Elpigudr3h2ezQk1HywY7/7wga3LrPGnaZGN7+KN7CNZnFxOG6ymWwCgXJSZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074282; c=relaxed/simple;
	bh=yWbzOPecXpXnHuJdheVvqTksk+sgim3cqqMa0mksMAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nY8blwP+JjIwB5bnB8+Oc84kmUjYQLu8OJFlhCrytBHxW/zwNwiD7JVnmvZtDg5eWaUkuBcblWr+aLbOXAO7oxYap0GiKBgWzM3Q4cCNPxS73ahlPym6wn6/HhIQFGQtiEroi/u79ldUgLEjegepV2pXlEIH1fe8tv+KTKdqg20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmYYcYq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BA6C433F1;
	Tue, 27 Feb 2024 22:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709074281;
	bh=yWbzOPecXpXnHuJdheVvqTksk+sgim3cqqMa0mksMAg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kmYYcYq5lpiPIbtqSejM4nrgrAeLOj3D57/vta8OZN+24gtwNtss58YKvkr023cD1
	 zeb86oO+JhkMe3ysc0U6oE7/murc6OFeviDtlpbwyyBIikRFzfHYWgyT0T6GP9400M
	 5dF+umqGrCZmWPp4AP7ojNjw0xZsf7eC8gym6HWYnHEgkdHQZfG4rdeliTzEE5udaP
	 8vNHxg9KrI99ntHtfeI+p3dzX42vCxAOT2yj1bfLUOn9oSFsQmrtgLAlmgMQU1/PJz
	 iMxvoJi3zGKM8Qsd51E+65MORBgFMyRTAN7xHKwti9/kpGZ1mSll1jmYs5boFaViWo
	 teGXe1At7fYNw==
Date: Tue, 27 Feb 2024 16:51:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mathias De Weerdt <mathias.de.weerdt@gmail.com>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	ben.chuang@genesyslogic.com.tw, johnsonm@danlj.org,
	linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: Bug Report: Delayed Wake from Suspend with Genesys Logic GL9755
 SD Host Controller
Message-ID: <20240227225120.GA242292@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfmkPJUSVZgGSrD4qNnxHDK7zE-S119L-HR2asDSGhnsCEU6Q@mail.gmail.com>

On Mon, Feb 26, 2024 at 06:33:11PM +0100, Mathias De Weerdt wrote:
> Hi Ilpo
> 
> That worked! I can now wake almost instantly from suspension.

Thanks for testing this!

I assume the sdhci_pci device (the SD card reader) worked before
suspend but does not work after wakeup, right?  If so, we still need
to fix the card reader.

Your dmesg log at [1] shows:

  [  181.568485] pcieport 0000:00:1c.6: broken device, retraining non-functional downstream link at 2.5GT/s
  [  182.568501] pcieport 0000:00:1c.6: retraining failed
  [  183.801823] pcieport 0000:00:1c.6: broken device, retraining non-functional downstream link at 2.5GT/s
  [  184.801799] pcieport 0000:00:1c.6: retraining failed
  ...
  [  251.188524] sdhci-pci 0000:2f:00.0: not ready 65535ms after resume; giving up
  [  251.188680] sdhci-pci 0000:2f:00.0: Unable to change power state from D3cold to D0, device inaccessible
  [  251.252837] mmc0: enable PCI MSI failed, error=-22
  [  251.352851] mmc0: Reset 0x1 never completed.
  [  251.352852] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
  [  251.352854] mmc0: sdhci: Sys addr:  0xffffffff | Version:  0x0000ffff

I found a report at [2] with the same symptom of "sdhci-pci ... Unable
to change power state from D3cold to D0, device inaccessible".  That
one turned out to be a Linux problem with restoring the ASPM L1
substates configuration after resume.  But I don't *think* that's what
you're seeing because:

  - 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
    suspend/resume") appeared in v6.1 and added the L1SS restore

  - a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability
    for suspend/resume"") appeared in v6.2 and reverted 4ff116d0d5fd

  - you're running a 6.7.6-arch1-1 kernel, and v6.7.6 doesn't appear
    to have the L1SS restore code from 4ff116d0d5fd

But to make double sure, could you try manually disabling ASPM before
suspending by running these commands as root and collecting all the
output (use "script" or similar):

  ROOT=00:1c.6
  SD=2f:00.0

  lspci -s$ROOT -vvxxxx
  lspci -s$SD   -vvxxxx

  setpci -s$SD   CAP_EXP+0x10.w=0x0000:0x0003
  setpci -s$ROOT CAP_EXP+0x10.w=0x0000:0x0003 

  lspci -s$ROOT -vvxxxx
  lspci -s$SD   -vvxxxx

Then suspend, resume, and see if we still complain about putting the
sdhci-pci device in D0.

I expect the card reader probably will still not work, and if that's
the case, maybe something is wrong with power control for the 2f:00.0
sdhci-pci device, possibly a BIOS bug, e.g., BIOS knows how to put
2f:00.0 in D3cold, but doesn't know how to return it to D0.

It's possible a BIOS update could fix this, but it would be good to
know what machine and BIOS version this is so we could try to work
around this in Linux.

The dmesg log doesn't include the earliest boot messages, so I don't
know what machine this is or the BIOS version, etc.  There should be a
complete boot-time log in /var/log/dmesg or similar.

[1] https://lore.kernel.org/r/CAKfmkPK+T0887-uQORxOzbcz-ZxBY+wKLYPRoiQiUfNhffQBEg@mail.gmail.com
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216782

> On Mon, 26 Feb 2024 at 12:49, Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Mon, 26 Feb 2024, Mathias De Weerdt wrote:
> >
> > > Hi Bjorn
> > >
> > > This has indeed never worked. I have even tried plenty of older
> > > kernels and now also the latest mainline.
> > >
> > > I collected the data you requested on the following kernel (Latest
> > > mainline as of yesterday)
> > > Linux core-arch 6.8.0-rc5-1-mainline #1 SMP PREEMPT_DYNAMIC Sun, 25
> > > Feb 2024 21:59:28 +0000 x86_64 GNU/Linux
> > >
> > > After booting the laptop I put it to sleep and woke it up and
> > > collected the dmesg and lspci logs. (They have been attached)
> > >
> > > Thanks for your quick response.
> > > If you need anything else please let me know.
> > >
> > > Kinds regards
> > > Mathias
> > >
> > > On Mon, 26 Feb 2024 at 00:31, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > On Sun, Feb 25, 2024 at 11:38:35PM +0100, Mathias De Weerdt wrote:
> > > > > Hi
> > > > >
> > > > > I am writing to report a potential bug in the Linux kernel related to
> > > > > waking from suspend on a system(Laptop) with a Genesys Logic GL9755 SD
> > > > > Host Controller. Below are the details of the issue:
> > > >
> > > > Hi Mathias, thanks very much for this report.  A few questions below.
> > > >
> > > > > Issue Description:
> > > > > After suspending the system, waking it up takes an extended amount of
> > > > > time, typically 1 to 2 minutes. The delay occurs consistently and is
> > > > > observed in the dmesg logs.
> > > > >
> > > > >
> > > > > System Information:
> > > > > - OS: Arch Linux x86_64
> > > > > - Kernel: 6.7.5-arch1-1 and 6.7.6-arch1-1
> > > > > - SD Host Controller: Genesys Logic GL9755 SD Host Controller (PCI ID:
> > > > > 17a0:9755)
> > > > >
> > > > > Observed Logs (dmesg):
> > > > > [ 642.483972] sdhci-pci 0000:2f:00.0: not ready 1023ms after resume; waiting
> > > > > [ 643.537370] sdhci-pci 0000:2f:00.0: not ready 2047ms after resume; waiting
> > > > > [ 645.724028] sdhci-pci 0000:2f:00.0: not ready 4095ms after resume; waiting
> > > > > [ 649.990655] sdhci-pci 0000:2f:00.0: not ready 8191ms after resume; waiting
> > > > > [ 658.310658] sdhci-pci 0000:2f:00.0: not ready 16383ms after resume; waiting
> > > > > [ 675.590673] sdhci-pci 0000:2f:00.0: not ready 32767ms after resume; waiting
> > > > > [ 709.723965] sdhci-pci 0000:2f:00.0: not ready 65535ms after resume; giving up
> > > > > [ 709.724183] sdhci-pci 0000:2f:00.0: Unable to change power state
> > > > > from D3cold to D0, device inaccessible
> >
> > Hi Mathias,
> >
> > In your dmesg, there's the Target Speed quirk triggering. Please try these
> > two patches, they should fix the logic bug that causes the long delay you
> > see:
> >
> > https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2402092125070.2376@angie.orcam.me.uk/T/#t
> >
> > (They won't help to the link not coming up issue though).
> >
> > --
> >  i.

