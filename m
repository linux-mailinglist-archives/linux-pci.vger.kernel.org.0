Return-Path: <linux-pci+bounces-13125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52D976F37
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 18:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF231C23832
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 16:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EEE1BE245;
	Thu, 12 Sep 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="korcF1/i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D871865F7;
	Thu, 12 Sep 2024 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160232; cv=none; b=OuxisRPAh9uczpVwnGFod4cZGJ5OjPpvo9Cry7z/1i9QC1zFmyxPKvDVKHILVGm5AQCvJs+BG2x4g4JaMLv8tt84Jp1WRvikm93RpE0IJNyFHzuqRWTYWP0dyb+Ek03Uq7AaJpGqWwZvJbjbRN7NAOlABWx1q2S/VTLB6YcS7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160232; c=relaxed/simple;
	bh=Jj/M0eZBMZoxDv71JmXMGVCQT07R36WyX1KvbT/rYaw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OvwSYHDGQNiDjmP7vlXgpQoXhKRwl+HIe6B9jGqm55+8a+VAHwW82wZlvU91IB41/Q6cA40Qu0aLLRGc1ZL+gpP5+No+uSYEs2P1R+mUQh9eFP61cduGngVgO34yI9c7lv9V4ZbjxR5eN7ILYNTbZ4SJSKd3vb8BW9nkvntj95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=korcF1/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CEDC4CEC3;
	Thu, 12 Sep 2024 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726160231;
	bh=Jj/M0eZBMZoxDv71JmXMGVCQT07R36WyX1KvbT/rYaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=korcF1/i50mRH0RuPqEW7Uu7oFsXOdoHeoZnO7mTDzDvDJsAi+Y8GfJYEqN7Fpa2e
	 m7wXdxY/jl0yCYm6YfSfChmwDvEinti/AknoLvKE/TEo8MUPTCj1e3wuB/sl3owNwW
	 pNqA8XQwxmuGDDgz0YPaE5QYlVb+7FFGfVcDFLnoVUu0v5mtxbhV/4qPHMBjm5Ipai
	 tzpjLcJwjfJkjBAcJlorlxJynZ0SWwfQ63eR/4bIuZg7Y9Lt3wyixP3+ak6krK334+
	 af/xOKEx+EbeyK6j3rnkZ7Ruz4tZiFFfRkNg3P3yQdoK357qEII8W18Y/e069bwrgU
	 xCyRHqS55Hy5A==
Date: Thu, 12 Sep 2024 11:57:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, mario.limonciello@amd.com,
	mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kaihengfeng@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <20240912165709.GA674430@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p7vP8TcPj=u5TTuPMXFaWW15hwpJdECCprvXGBhigKD6Q@mail.gmail.com>

[+cc Rafael]

On Thu, Sep 12, 2024 at 11:00:43AM +0800, Kai-Heng Feng wrote:
> On Thu, Sep 12, 2024 at 3:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > > Some laptops wake up after poweroff when HP Thunderbolt Dock G4 is
> > > connected.
> > >
> > > The following error message can be found during shutdown:
> > > pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> > > pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> > > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> > > pcieport 0000:09:04.0:    [ 7] BadDLLP
> > >
> > > Calling aer_remove() during shutdown can quiesce the error message,
> > > however the spurious wakeup still happens.
> > >
> > > The issue won't happen if the device is in D3 before system shutdown, so
> > > putting device to low power state before shutdown to solve the issue.
> > >
> > > I don't have a sniffer so this is purely guesswork, however I believe
> > > putting device to low power state it's the right thing to do.
> >
> > My objection here is that we don't have an explanation of why this
> > should matter or a pointer to any spec language about this situation,
> > so it feels a little bit random.
> 
> I have the same feeling too. The PCIe spec doesn't specify what's the
> correct power state for shutdown.
> So we can only "logically" think the software should put devices to
> low power state during shutdown.
> 
> > I suppose the problem wouldn't happen if AER interrupts were disabled?
> > We already do disable them in aer_suspend(), but maybe that's not used
> > in the shutdown path?
> 
> That was my first thought, so I modified pcie_port_shutdown_service()
> to disable AER interrupt.
> That approach didn't work though.
> 
> > My understanding is that .shutdown() should turn off device interrupts
> > and stop DMA.  So maybe we need an aer_shutdown() that disables
> > interrupts?
> 
> Logically we should do that. However that approach doesn't solve this issue.

I'm not completely clear on the semantics of the .shutdown()
interface.  The doc at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/driver.h?id=v6.10#n73
says "@shutdown: Called at shut-down time to quiesce the device"

Turning off device interrupts and DMA *would* fit within the idea of
quiescing the device.  Does that also include changing the device
power state?  I dunno.  The power state isn't *mentioned* in the
.shutdown() context, while it *is* mentioned for .suspend().

IIUC, this patch and commit log uses "shutdown" to refer to a
system-wide *poweroff*, which is a different concept despite using the
same "shutdown" name.

So should the system poweroff procedure use .suspend()?  Should it use
both .shutdown() and .suspend()?  I think it only uses .shutdown()
today:

  kernel_power_off
    kernel_shutdown_prepare(SYSTEM_POWER_OFF)
      device_shutdown
        while (!list_empty(&devices_kset->list))
          dev->bus->shutdown(dev)
            pci_device_shutdown

There are several driver .shutdown() methods that do things like this:

  e1000_shutdown
    if (system_state == SYSTEM_POWER_OFF)
      pci_set_power_state(pdev, PCI_D3hot)

Maybe that's the right thing and should be done by the PCI core, which
is similar to what you propose here.  But I think it muddies the
definition of .shutdown() a bit by mixing in power management stuff.

> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=219036
> > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > ---
> > >  drivers/pci/pci-driver.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index af2996d0d17f..4c6f66f3eb54 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -510,6 +510,14 @@ static void pci_device_shutdown(struct device *dev)
> > >       if (drv && drv->shutdown)
> > >               drv->shutdown(pci_dev);
> > >
> > > +     /*
> > > +      * If driver already changed device's power state, it can mean the
> > > +      * wakeup setting is in place, or a workaround is used. Hence keep it
> > > +      * as is.
> > > +      */
> > > +     if (!kexec_in_progress && pci_dev->current_state == PCI_D0)
> > > +             pci_prepare_to_sleep(pci_dev);
> > > +
> > >       /*
> > >        * If this is a kexec reboot, turn off Bus Master bit on the
> > >        * device to tell it to not continue to do DMA. Don't touch
> > > --
> > > 2.43.0
> > >

