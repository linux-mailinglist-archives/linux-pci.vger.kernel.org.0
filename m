Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298803CA0F1
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 16:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhGOOwr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 10:52:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234745AbhGOOwr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Jul 2021 10:52:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1863860FE7;
        Thu, 15 Jul 2021 14:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626360594;
        bh=16TRO9Qbmcnd0SRg6DNF/8XFK02qPEiiTLSukYvzfWw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=N4th+ueHz9sd9u/L0T1lQVcMZcK9N+j7V24gv5fDqYhlxh9N/55dFlBo0j7RZzS20
         VQhn3RY9hfl30RJGjtnA8wKRXudc+AobtFsIMIM/PvxPWG3zZZUBZGO6zXsIsgo3pP
         m/ohQl4VONZ+iPFq/+k9UKE+HmgV+368wecHAOT+VqIYcb0i/FWcZuRH96nPozqp4C
         miLAGFYB3ea53okFnlmb6qjvnx8g/VDf1R9NvFD+bBtSCerdLKyWRyRkcy5PVJQ/5h
         AWdNDkUHurytrdjXPNFmsnztf0nNOsQ2oINha+SFIHv2AZsNR6Uxk1ukzjA10aeqkN
         vYfNXB1DLLAVQ==
Date:   Thu, 15 Jul 2021 09:49:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ruben <rubenbryon@gmail.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [question]: BAR allocation failing
Message-ID: <20210715144952.GA1960220@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALdZjm6TsfsaQZRxJvr5YDh9VRn28vQjFY+JfZv-daU=gQu_Uw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 15, 2021 at 01:43:17AM +0300, Ruben wrote:
> No luck so far with "-global q35-pcihost.pci-hole64-size=2048G"
> ("-global q35-host.pci-hole64-size=" gave an error "warning: global
> q35-host.pci-hole64-size has invalid class name").
> The result stays the same.

Alex will have to chime in about the qemu option problem.

Your dmesg excerpts don't include the host bridge window info, e.g.,
"root bus resource [mem 0x7f800000-0xefffffff window]".  That tells
you what PCI thinks is available for devices.  This info comes from
ACPI, and I don't know whether the BIOS on qemu is smart enough to
compute it based on "q35-host.pci-hole64-size=".  But dmesg will tell
you.

"pci=nocrs" tells the kernel to ignore those windows from ACPI and
pretend everything that's not RAM is available for devices.  Of
course, that's not true in general, so it's not really safe.

PCI resources are hierarchical: an endpoint BAR must be contained
in the Root Ports window, which must in turn be contained in the host
bridge window.  You trimmed most of that information out from your
dmesg log, so we can't see exactly what's wrong.

> When we pass through the NVLink bridges we can have the (5 working)
> GPUs talk at full P2P bandwidth and is described in the NVidia docs as
> a valid option (ie. passing through all GPUs and NVlink bridges).
> In production we have the bridges passed through to a service VM which
> controls traffic, which is also described in their docs.
> 
> Op do 15 jul. 2021 om 01:03 schreef Alex Williamson
> <alex.williamson@redhat.com>:
> >
> > On Thu, 15 Jul 2021 00:32:30 +0300
> > Ruben <rubenbryon@gmail.com> wrote:
> >
> > > I am experiencing an issue with virtualizing a machine which contains
> > > 8 NVidia A100 80GB cards.
> > > As a bare metal host, the machine behaves as expected, the GPUs are
> > > connected to the host with a PLX chip PEX88096, which connects 2 GPUs
> > > to 16 lanes on the CPU (using the same NVidia HGX Delta baseboard).
> > > When passing through all GPUs and NVLink bridges to a VM, a problem
> > > arises in that the system can only initialize 4-5 of the 8 GPUs.
> > >
> > > The dmesg log shows failed attempts for assiging BAR space to the GPUs
> > > that are not getting initialized.
> > >
> > > Things that were tried:
> > > Q35-i440fx with and without UEFI
> > > Qemu 5.x, Qemu 6.0
> > > Host Ubuntu 20.04 host with Qemu/libvirt
> > > Now running proxmox 7 on debian 11, host kernel 5.11.22-2, VM kernel 5.4.0-77
> > > VM kernel parameters pci=nocrs pci=realloc=on/off
> > >
> > > ------------------------------------
> > >
> > > lspci -v:
> > > 01:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> > >         Memory at db000000 (32-bit, non-prefetchable) [size=16M]
> > >         Memory at 2000000000 (64-bit, prefetchable) [size=128G]
> > >         Memory at 1000000000 (64-bit, prefetchable) [size=32M]
> > >
> > > 02:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> > >         Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
> > >         Memory at 4000000000 (64-bit, prefetchable) [size=128G]
> > >         Memory at 6000000000 (64-bit, prefetchable) [size=32M]
> > >
> > > ...
> > >
> > > 0c:00.0 3D controller: NVIDIA Corporation Device 20b2 (rev a1)
> > >         Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
> > >         Memory at <ignored> (64-bit, prefetchable)
> > >         Memory at <ignored> (64-bit, prefetchable)
> > >
> > > ...
> > >
> > ...
> > >
> > > ------------------------------------
> > >
> > > I have (blindly) messed with parameters like pref64-reserve for the
> > > pcie-root-port but to be frank I have little clue what I'm doing so my
> > > question would be suggestions on what I can try.
> > > This server will not be running an 8 GPU VM in production but I have a
> > > few days left to test before it goes to work. I was hoping to learn
> > > how to overcome this issue in the future.
> > > Please be aware that my knowledge regarding virtualization and the
> > > Linux kernel does not reach far.
> >
> > Try playing with the QEMU "-global q35-host.pci-hole64-size=" option for
> > the VM rather than pci=nocrs.  The default 64-bit MMIO hole for
> > QEMU/q35 is only 32GB.  You might be looking at a value like 2048G to
> > support this setup, but could maybe get away with 1024G if there's room
> > in 32-bit space for the 3rd BAR.
> >
> > Note that assigning bridges usually doesn't make a lot of sense and
> > NVLink is a proprietary black box, so we don't know how to virtualize
> > it or what the guest drivers will do with it, you're on your own there.
> > We generally recommend to use vGPUs for such cases so the host driver
> > can handle all the NVLink aspects for GPU peer-to-peer.  Thanks,
> >
> > Alex
> >
