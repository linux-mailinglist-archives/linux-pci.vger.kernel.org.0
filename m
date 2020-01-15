Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3A13BA85
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 08:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAOH40 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jan 2020 02:56:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24646 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726088AbgAOH4Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jan 2020 02:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579074983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdllriL4WWDFomXLLsIgDwSvICpThVOsYLzhpnyxYyo=;
        b=bxuHo+tcFDXnsdXbNfuKqySb/rITklCuMrvwlpTG01DtEOEL/q4PUnUVtRXzMx0jLZrCN3
        LMB5WLq+yNOvAFujCxjZaHXqKWS9vUixJjaUL+Znmwd5zq2AAQdvrSOTravEo+WsBt+NyC
        ryWmsjdbur9IZZBFd5hCm923LTkMLeY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-mw5hhpzeMeqBJ1E5OI_2vA-1; Wed, 15 Jan 2020 02:56:22 -0500
X-MC-Unique: mw5hhpzeMeqBJ1E5OI_2vA-1
Received: by mail-io1-f72.google.com with SMTP id u6so9836191iog.21
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 23:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdllriL4WWDFomXLLsIgDwSvICpThVOsYLzhpnyxYyo=;
        b=Y6IvXeYQQ2CodbNoDhE4fotVy6cLU+PyOoxSofb6fxs3x4/xR82oAWSSdYO4jIP+go
         tD/vNi1a6o+mCBdHXkvHT3sHc+u7VxqNFavXB68C+GVdOYsWO5EQbeOI/ipfjucgSc0G
         WzQbi78dcHDMt3IVMZAxHIMrOrPWdK6ElicOZdqPH6r9jrupX4ZMAuyrYdd3rkkVBZ4f
         JQTF4Gm6UoY4tFaKQxQ34XaTnekcCNAvPYsHSX6sWq/pnYaAAaGYDAFCIheKntch3xOb
         9aZhYLZi0Ag3EovhfWsL2gmhhwvuTIwSnN1VbBAsbAFpzyAP3aKW6EnizUcOEjzcHK7T
         +l2Q==
X-Gm-Message-State: APjAAAWielhCLNWTTbuMX9oqN/XOSZHHZt/gldTajelaP3kGqBmKDJVO
        C48ATATnRuVk65+R73lEWypugJs0r1WSPQQO9XWuSbPb+jf7qZc8mjA/aYUn8uHWJ3tY6ETrze8
        0XVvpu9EFfoz2jN0PdoIN8TZ4sgIp/IdK7s7s
X-Received: by 2002:a6b:6c0f:: with SMTP id a15mr21590167ioh.13.1579074981809;
        Tue, 14 Jan 2020 23:56:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqy198MdKmwc7tS5Kch4x8fvNx6UwEIXGLOEJwdMlSxXDqGkCuEWt5QtzcEk2BKG3fwW40gxmoyiYXZB33S09IY=
X-Received: by 2002:a6b:6c0f:: with SMTP id a15mr21590148ioh.13.1579074981372;
 Tue, 14 Jan 2020 23:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20200110214217.GA88274@google.com> <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net> <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv> <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
 <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com>
 <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com>
 <CACPcB9cQY9Vu3wG-QYZS6W6T_PZxnJ1ABNUUAF_qvk-VSxbpTA@mail.gmail.com> <CABeXuvpWR9foBREPPc4T0G_Pf7D3=uaiKv1+_SkLti2+SrKb5Q@mail.gmail.com>
In-Reply-To: <CABeXuvpWR9foBREPPc4T0G_Pf7D3=uaiKv1+_SkLti2+SrKb5Q@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Wed, 15 Jan 2020 15:56:10 +0800
Message-ID: <CACPcB9eZF2=wohTBCbF9ow8T+2-QdGr=Q41jPk5iA7+1MkLY8w@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Khalid Aziz <khalid@gonehiking.org>
Cc:     Baoquan He <bhe@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 9:17 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Mon, Jan 13, 2020 at 9:07 AM Kairui Song <kasong@redhat.com> wrote:
> >
> > On Sun, Jan 12, 2020 at 2:33 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >
> > > > Hi, there are some previous works about this issue, reset PCI devices
> > > > in kdump kernel to stop ongoing DMA:
> > > >
> > > > [v7,0/5] Reset PCIe devices to address DMA problem on kdump with iommu
> > > > https://lore.kernel.org/patchwork/cover/343767/
> > > >
> > > > [v2] PCI: Reset PCIe devices to stop ongoing DMA
> > > > https://lore.kernel.org/patchwork/patch/379191/
> > > >
> > > > And didn't get merged, that patch are trying to fix some DMAR error
> > > > problem, but resetting devices is a bit too destructive, and the
> > > > problem is later fixed in IOMMU side. And in most case the DMA seems
> > > > harmless, as they targets first kernel's memory and kdump kernel only
> > > > live in crash memory.
> > >
> > > I was going to ask the same. If the kdump kernel had IOMMU on, would
> > > that still be a problem?
> >
> > It will still fail, doing DMA is not a problem, it only go wrong when
> > a device's upstream bridge is mistakenly shutdown before the device
> > shutdown.
> >
> > >
> > > > Also, by the time kdump kernel is able to scan and reset devices,
> > > > there are already a very large time window where things could go
> > > > wrong.
> > > >
> > > > The currently problem observed only happens upon kdump kernel
> > > > shutdown, as the upper bridge is disabled before the device is
> > > > disabledm so DMA will raise error. It's more like a problem of wrong
> > > > device shutting down order.
> > >
> > > The way it was described earlier "During this time, the SUT sometimes
> > > gets a PCI error that raises an NMI." suggests that it isn't really
> > > restricted to kexec/kdump.
> > > Any attached device without an active driver might attempt spurious or
> > > malicious DMA and trigger the same during normal operation.
> > > Do you have available some more reporting of what happens during the
> > > PCIe error handling?
> >
> > Let me add more info about this:
> >
> > On the machine where I can reproduce this issue, the first kernel
> > always runs fine, and kdump kernel works fine during dumping the
> > vmcore, even if I keep the kdump kernel running for hours, nothing
> > goes wrong. If there are DMA during normal operation that will cause
> > problem, this should have exposed it.
> >
> > The problem only occur when kdump kernel try to reboot, no matter how
> > long the kdump kernel have been running (few minutes or hours). The
> > machine is dead after printing:
> > [  101.438300] reboot: Restarting system^M
> > [  101.455360] reboot: machine restart^M
> >
> > And I can find following logs happend just at that time, in the
> > "Integrated Management Log" from the iLO web interface:
> > 1254 OS 12/25/2019 09:08 12/25/2019 09:08 1 User Remotely Initiated NMI Switch
> > 1253 System Error 12/25/2019 09:08 12/25/2019 09:08 1 An Unrecoverable
> > System Error (NMI) has occurred (Service Information: 0x00000000,
> > 0x00000000)
> > 1252 PCI Bus 12/25/2019 09:07 12/25/2019 09:07 1 Uncorrectable PCI
> > Express Error (Embedded device, Bus 0, Device 2, Function 2, Error
> > status 0x00100000)
> > 1251 System Error 12/25/2019 09:07 12/25/2019 09:07 1 Unrecoverable
> > System Error (NMI) has occurred.  System Firmware will log additional
> > details in a separate IML entry if possible
> > 1250 PCI Bus 12/25/2019 09:07 12/25/2019 09:07 1 PCI Bus Error (Slot
> > 0, Bus 0, Device 2, Function 2)
> >
> > And the topology is:
> > [0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
> >           +-01.0-[02]--
> >           +-01.1-[05]--
> >           +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
> >           |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
> >           +-02.1-[0f]--
> >           +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array
> > Gen9 Controllers
> >
> > It's a bridge reporting the error. It should be an unsupported request
> > error, bacause downstream device is still alive and sending request,
> > but the port have bus mastering off. If I manually shutdown the "Smart
> > Array" (HPSA) device before kdump reboot, it will always reboot just
> > fine.
> >
> > And as the patch descriptions said, the HPSA is used in first kernel,
> > but didn't get reset in kdump kernel because driver is not loaded.
> > When shutting down a bridge, kernel should shutdown downstream device
> > first, and then shutdown and clear bus master bit of the bridge. But
> > in kdump case, kernel skipped some device shutdown due to driver not
> > loaded issue, and kernel don't know they are enabled.
> >
> > This problem is not limited to HPSA, the NIC listed in above topology
> > maybe also make the bridge error out, if HPSA get loaded in kdump
> > kernel and NIC get ignored.
>
> It looks like the right answer is for the kernel to handle such cases
> gracefully. From what I recall, we can only trust the bus mastering at
> root ports. So, it is possible that the endpoint devices can always
> try to DMA, but it can be blocked by the root port. So the right fix
> seems to teach kernel how to handle these insted of hacking the
> shutdown code.
> -Deepa
>

Kexec have been disabling bus mastering on endpoints to prevent memory
corruption since commit b566a22c2332 ("PCI: disable Bus Master on PCI
device shutdown"), later improved by 4fc9bbf98fd6 ("PCI: Disable Bus
Master only on kexec reboot") and 6e0eda3c3898 ("PCI: Don't try to
disable Bus Master on disconnected PCI devices").

That's done before 2014, it worked for kexec reboot, so I think
disable bus mastering on endpoints should work in most cases.

It's true that on some machine disabling bus mastering doesn't work
well, but I guess kexec/kdump will also not work well on such machine?
And for kdump, the hardware is already in an unstable status, and
kernel don't know how to shutdown/reset some device due to driver not
loaded. And loading all drivers in kdump kernel is usually not
practical. So I think disable bus mastering bit is the best effort
kernel could do at that time (upon shutdown, at least ensure device
shutdown is in right order)?

And about the UR error and Bus Mastering bit, from the spec:
"Endpoints:When this bit is Set, the PCI Express Function is allowed
to issue Memory or I/O Requests. When this bit is Clear, the PCI
Express Function is not allowed to issue any Memory or I/O Requests."
"Root and Switch Ports: This bit controls forwarding of Memory or I/O
Requests by a Switch or Root Port in the Upstream direction. When this
bit is 0b, Memory and I/O Requests received at a Root Port or the
Downstream side of a Switch Port must be handled as Unsupported
Requests (UR), and for Non-Posted Requests a Completion with UR
completion status must be returned."

Hardware is supposed to report UR error, but this hanging problem is
only observed on some HPE machines, the firmware will send NMI (and
supposed to panic the kernel) when it happened. So maybe this could be
fixed with the firmware or apply some workaround for HPE (eg in
hpwdt)?




--
Best Regards,
Kairui Song

