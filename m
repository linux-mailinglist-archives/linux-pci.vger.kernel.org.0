Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8F19E244
	for <lists+linux-pci@lfdr.de>; Sat,  4 Apr 2020 03:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDDBch (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Apr 2020 21:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgDDBch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Apr 2020 21:32:37 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06CC12064A;
        Sat,  4 Apr 2020 01:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585963956;
        bh=xIYK4wImKay/0dszF05ia/yWAuS8n90Oeh2DxReT6fI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N/fEDA4rBknQFfBkxhTKA4XVyeazw3vgJECsX8oZOFlpsg4d9eR7z11Zqfo61tL3Z
         RTqEcJ4iWOTtXUQl/bELvmEg6l/tPytYkfZRxzzIF41X1j1eIlX1z0VcRAof7j2RwE
         1dVfB6aJEBEl6ClxmnBzEkev3P6IPpBQBpOgvv3k=
Date:   Fri, 3 Apr 2020 20:32:33 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     =?iso-8859-1?Q?Lu=EDs?= Mendes <luis.p.mendes@gmail.com>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Problem with PCIe enumeration of Google/Coral TPU Edge module on
 Linux
Message-ID: <20200404013233.GA30614@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEzXK1qmYkpHzhbBmYG_Mvk+s6-NAJO-17+VW9fm-=trSZ-v5Q@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 02, 2020 at 03:13:36PM +0100, Luís Mendes wrote:
> Hi Bjorn,
> 
> The command that worked was:
> #  sh -c "echo 1 >
> /sys/bus/pci/devices/0000\:00\:01.0/pci_bus/0000\:01/bus_rescan"
> 
> The only new information compared to yesterday dmesg are the following lines:
> ...
> [   20.633566] mvneta f1070000.ethernet eth0: Link is Up - 1Gbps/Full
> - flow control off
> [   20.633598] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> [ 1048.661591] FAT-fs (sda1): Volume was not properly unmounted. Some
> data may be corrupt. Please run fsck.
> [ 1049.792121] EXT4-fs (sdb1): mounted filesystem with ordered data
> mode. Opts: (null)
> [60026.321476] pci_bus 0000:01: __pci_bus_assign_resources
> [60026.321481] pci_bus 0000:01: pbus_assign_resources_sorted
> [60026.321485] pci 0000:01:00.0: __dev_sort_resources
> [60026.321487] __assign_resources_sorted
> [60026.321490] pci 0000:01:00.0: __pci_bus_assign_resources
> [60026.321493] pci 0000:01:00.0: pdev_assign_fixed_resources

The idea I'm pushing on is that maybe Linux don't program endpoint
BARs correctly.  This theory is weak because I'm pretty sure there are
ARM systems where firmware doesn't program the BARs, and some of them
seem to work.  But resource assignment is arch-specific and even
mvebu-specific, so maybe this is a wrinkle.

The hotplug case is much less arch-specific than the boot-time case,
so I wonder if you'll see something different if you remove the device
and then re-enumerate it?  I don't think you have a hotplug-capable
slot, but we can do something similar via sysfs.

I tried to test this on my x86 system (where BARs are assigned by
the BIOS at boot-time) by clearing the BAR of an idle device, removing
it, and re-enumerating it.  Boot-time enumeration said:

  pci 0000:00:1c.0: PCI bridge to [bus 02]
  pci 0000:02:00.0: reg 0x14: [mem 0xf1100000-0xf1100fff]

Here I cleared the BAR, removed, rescanned:

  # setpci -s02:00.0 BASE_ADDRESS_1.L=0
  # echo 1 > /sys/devices/pci0000:00/0000:00:1c.0/0000:02:00.0/remove
  # echo 1 > /sys/devices/pci0000:00/0000:00:1c.0/rescan

and dmesg said:

  pci 0000:02:00.0: [10ec:525a] type 00 class 0xff0000
  pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x00000fff]
  pci 0000:02:00.0: BAR 1: assigned [mem 0xf1100000-0xf1100fff]
  pci 0000:02:00.0: BAR 1: error updating (0xf1100000 != 0xffffffff)

So we correctly detected the device, read the cleared BAR, and
allocated space for it, and tried to update the BAR.  On my system the
update failed, I think because of a power management issue (all config
reads now return 0xffffffff).  But there have been a lot of power
management fixes since the v5.2 kernel I'm running, so it's possible
you'd have better luck.

On your system, I think you would want something like:

  # echo 1 > /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/remove
  # echo 1 > /sys/devices/pci0000:00/0000:00:01.0/rescan

> On Thu, Apr 2, 2020 at 12:31 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > On Wed, Apr 01, 2020 at 10:20:42PM +0100, Luís Mendes wrote:
> > > Hi Bjorn,
> > >
> > > Here is the dmesg output with the new kernel patch:
> > > https://paste.ubuntu.com/p/7cv7ZcyrnG/
> >
> > Thanks.  What happens if you do this:
> >
> >   # echo 1 > sys/devices/pci0000:00/0000:00:01.0/pci_bus/0000:01/rescan
> >
> > (I think on v5.6 that file is "bus_rescan" instead of "rescan".
> > There's a patch queued up to change it.)
