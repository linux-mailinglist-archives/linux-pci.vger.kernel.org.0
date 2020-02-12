Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E9715A2F8
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 09:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgBLINL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 03:13:11 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172]:40379 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLINL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 03:13:11 -0500
Received: by mail-lj1-f172.google.com with SMTP id n18so1217539ljo.7
        for <linux-pci@vger.kernel.org>; Wed, 12 Feb 2020 00:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSzFH/sCCdv/1TUzNwifZbbH6Z/8YZwip7w5s4aKqiQ=;
        b=tk9sYesE5oGDBtD7lIFDMUygr8FXr300pewoT/V9HNaWUeYVNEePbdcFeaaLgIjtxU
         kNL8gAKQN1XCbE2Pt28fGYq4g57/wnkueZad1ohM2bVhZTN4EbRNMPGr3GN36TRM4flC
         y1AHJxIrE+ugkVWChg0FU6M1UFI2Ubj7YrmTKxQNwklF0m0DMsvE1Mia3D3LJS5IkQts
         aqTA1DRIjcjG65PcbueGAy42j5bz+EnlU9GYcTSEiCU7BIz+MakIuIZs3Mopviv7IzlF
         5l0cOiB45F+xVwnDy7XDSNhg2Gm8cW1R+CxzaeKm+Lw5IkGCx+4eIUaI82Z04xS9z9H6
         RI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSzFH/sCCdv/1TUzNwifZbbH6Z/8YZwip7w5s4aKqiQ=;
        b=h7a5D5aVlUZH9dVfYWDL5spfdOUDdn5XetVICERmxKHSJI/sfee7DmGB58p0NEltwR
         QMcTltBhNe6WnuHsjpoeSRSDidQMiqeA1BJ2rgDn7KK7LjyygzBFY8yBF1KhlYsXMUQz
         vyKu+C0tpWnbsTl8g8XMA0qBcs3yV6oFmFgPcYU6iRYXdxBjuZixWt3wOKx3OPg3zd9l
         hA7ZRrWL5+6d/DVZTkjkGQtrXLVpdtLRzTh735cVcStw71c5VY1x+Vhgmi5xlvd3UJMk
         HNpn78AOtTM73pTDN3kdm0jXO0cQrCFwLsSjXJi6f1mZ4FoZI7d6+YjV8SIN06rBitsq
         BQGw==
X-Gm-Message-State: APjAAAWgHIt2uYviFmblGfb/gCLOJQ88kzKMgs2LlrXq2rCwjE7Oe0tf
        4zO9fzWfFu15ubhZxsskXtxDoAk+KkOKnyrMMmY=
X-Google-Smtp-Source: APXvYqx6b9KLdEed9L+Lr+/tiOOUdL7AH2ho6PtomHVtRUcoT6mHbYXR8Tz78uhYrTdYRA72HiEw8+CKWuPSGTczLrk=
X-Received: by 2002:a2e:978c:: with SMTP id y12mr6908234lji.167.1581495188352;
 Wed, 12 Feb 2020 00:13:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHhAz+jXDfwWA=+Cb0fXooZHHRNyYLF2ykeO8pHaXH2fw5a2sQ@mail.gmail.com>
 <20200211201605.GA235978@google.com>
In-Reply-To: <20200211201605.GA235978@google.com>
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Wed, 12 Feb 2020 13:42:56 +0530
Message-ID: <CAHhAz+hyFOt_k1Pc9u-WMHWjXq-7jT_yn2u2VbnPpg4R8w8TXA@mail.gmail.com>
Subject: Re: pcie: kernel log - BAR 15: no space for... BAR 15: failed to assign..
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 12, 2020 at 1:46 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Feb 11, 2020 at 10:02:13PM +0530, Muni Sekhar wrote:
> > On Tue, Feb 11, 2020 at 8:10 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Feb 11, 2020 at 07:36:00PM +0530, Muni Sekhar wrote:
> > > > On Tue, Feb 11, 2020 at 3:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Sun, Feb 09, 2020 at 07:59:41AM +0530, Muni Sekhar wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > After rebooting the system following messages are seen in dmesg.
> > > > > > Not sure if these indicate a problem. Can some one look at these and
> > > > > > confirm if this is problem or can be ignored ?
> > > > > >
> > > > > > Also any suggestions as to what would cause this?
> > > > > >
> > > > > > [    1.084728] pci 0000:00:1c.0: BAR 15: no space for [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.084813] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.084890] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> > > > > > [    1.084949] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> > > > > > [    1.085037] pci 0000:00:1c.2: BAR 15: no space for [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085108] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085199] pci 0000:00:1c.3: BAR 15: no space for [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085270] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085343] pci 0000:00:1c.0: BAR 13: assigned [io  0x1000-0x1fff]
> > > > > > [    1.085403] pci 0000:00:1c.2: BAR 13: assigned [io  0x2000-0x2fff]
> > > > > > [    1.085470] pci 0000:00:1c.3: BAR 15: no space for [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085540] pci 0000:00:1c.3: BAR 15: failed to assign [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085613] pci 0000:00:1c.2: BAR 14: no space for [mem size 0x00200000]
> > > > > > [    1.085672] pci 0000:00:1c.2: BAR 14: failed to assign [mem size 0x00200000]
> > > > > > [    1.085738] pci 0000:00:1c.2: BAR 15: no space for [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085808] pci 0000:00:1c.2: BAR 15: failed to assign [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085884] pci 0000:00:1c.0: BAR 15: no space for [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.085954] pci 0000:00:1c.0: BAR 15: failed to assign [mem size
> > > > > > 0x00200000 64bit pref]
> > > > > > [    1.086026] pci 0000:00:1c.0: PCI bridge to [bus 01]
> > > > > > [    1.086083] pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > > > > > [    1.086144] pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd07fffff]
> > > > >
> > > > > The "no space" and "failed to assign" messages are all for bridge
> > > > > windows (13 is the I/O window, 14 is the MMIO window, 15 is the MMIO
> > > > > pref window).  I can't tell if you have any devices below these
> > > > > bridges (lspci would show them).  If you don't have any devices below
> > > > > these bridges, you can ignore the messages.
> > > >
> > > > I have the devices below these bridges. FPGA endpoint is connected to
> > > > '00:1c.0 PCI bridge' and Ethernet controller is connected to '00:1c.3
> > > > PCI bridge'.
> > > > Does these messages impact the functionality of the connected devices?
> > >
> > > Yes.  We tried to allocate 0x00200000 of prefetchable MMIO to 00:1c.0
> > > for use by the FPGA endpoint.  But this failed, so there is no
> > > prefetchable MMIO available for the FPGA.  The 0xd0400000-0xd07fffff
> > > non-prefetachable MMIO space *is* available for it.
> > >
> > > Similarly, we were unable to allocate 0x00200000 of prefetchable MMIO
> > > for the 00:1c.3 bridge for use by the ethernet controller.  I don't
> > > know what non-prefetchable MMIO space was allocated or what the NIC
> > > needs.
> > >
> > > "lspci -v" will show you what the FPGA and the NIC need.
> > >
> > > > If so what kind of impact and is there any solution for this?
> > >
> > > > Also, I'd like to know why "no space" and "failed to assign"
> > > > messages displayed?
> > >
> > > These messages mean we tried to allocate space for the bridges but we
> > > unable to do so.  This is because either the host bridge didn't have
> > > big enough apertures (on x86, these usually come from ACPI _CRS
> > > methods), or there's a bug in the Linux allocation algorithms.
> > >
> > > I can't tell anything more without seeing the complete dmesg log,
> > > which contains the host bridge aperture information and the BAR sizes
> > > of the FPGA and NIC.
> > Thank you for the clarification. dmesg log is attached.
> > If PCI bridge aperture is small, What is the most sensible way to proceed?
>
> Here's the relevant info from your dmesg log:
>
>   PCI host bridge to bus 0000:00
>   pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
>   pci_bus 0000:00: root bus resource [mem 0xc0000000-0xd0c18ffe window]
>   pci_bus 0000:00: root bus resource [bus 00-ff]
>   pci 0000:00:1c.0: PCI bridge to [bus 01]
>   pci 0000:00:1c.0:   bridge window [mem 0xd0400000-0xd07fffff]
>   pci 0000:01:00.0: [1556:5555] type 00 class 0x050000 # FPGA
>   pci 0000:01:00.0: reg 0x10: [mem 0xd0400000-0xd07fffff]
>   pci 0000:00:1c.3: PCI bridge to [bus 03]
>   pci 0000:00:1c.3:   bridge window [io  0xd000-0xdfff]
>   pci 0000:00:1c.3:   bridge window [mem 0xd0a00000-0xd0bfffff]
>   pci 0000:03:00.0: [8086:1533] type 00 class 0x020000 # I210 NIC
>   pci 0000:03:00.0: reg 0x10: [mem 0xd0a00000-0xd0afffff]
>   pci 0000:03:00.0: reg 0x18: [io  0xd000-0xd01f]
>   pci 0000:03:00.0: reg 0x1c: [mem 0xd0b00000-0xd0b03fff]
>
> The FPGA at 01:00.0 has one non-prefetchable memory BAR and is
> assigned [mem 0xd0400000-0xd07fffff].  That range is inside the host
> bridge aperture ([mem 0xc0000000-0xd0c18ffe window]) and is routed
> through the 00:1c.0 bridge (bridge window [mem 0xd0400000-0xd07fffff]).
> So the FPGA resources are fine.
>
> The fact that Linux tried and failed to allocate prefetchable memory
> space for the bridge is immaterial because the FPGA can't use
> prefetchable memory anyway.
>
> The NIC at 03:00.0 is similar: it has two non-prefetchable memory BARs
> and one I/O BAR.  They're all assigned valid space, and the fact that
> Linux tried and failed to allocate prefetchable memory space for the
> bridge makes no difference because the NIC can't use it.
>
> So these messages do not indicate a problem.  Maybe there's something
> we can do to make this more clear to the user.
Thank you for the detailed explanation.
>
> Bjorn



-- 
Thanks,
Sekhar
