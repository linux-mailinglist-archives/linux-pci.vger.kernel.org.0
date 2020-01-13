Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC831396F9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAMRHY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 12:07:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30462 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728558AbgAMRHY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 12:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578935242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gx9m20Qk3Xew8B11Dz3yhd4x1rylP5kEcfScufxzD+g=;
        b=RBov/H/jkFNElYMRA2J0DXi/GnGTyFNjWKK4KfeRwphylq6jkbWQ02SfKaHU2ZHDrn8roY
        zAU53vWK5aI/nd2UL84cPghnBDrD4jnNsi5oEAYIHdSrRpdyAPQCH8wD/yMJF/9XLAp04Z
        FtevAy7PT0IW9IKoIUhokJFRtrwxzuY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-VPz6SJVwNb-en-Lu2X8hjg-1; Mon, 13 Jan 2020 12:07:21 -0500
X-MC-Unique: VPz6SJVwNb-en-Lu2X8hjg-1
Received: by mail-io1-f71.google.com with SMTP id w22so1326368ior.6
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2020 09:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gx9m20Qk3Xew8B11Dz3yhd4x1rylP5kEcfScufxzD+g=;
        b=uShtrZf71laxmVb5xuv23kZszrTycwagt23ezXj7JZwpu6KB7KuEbOqr3znKD2OAds
         Pn7ksMni1KpI5M3A1eoKMcmnUaqfwbxkTNS2XLcgByMCOquqjCzWpNbTiXIREPcom28O
         8yGh13DmyEXI8hDSrXEhGOkDvgV9F8pP8EGw1v3jTKHs+H1Kr5cI/JK94R+Qad/IWtAL
         wM9Y+sVlBv31WPg5u453kYFl8hGNDsAUHVxi8oM/A2Job6mI51fsI1TcbXufVOz0H2ab
         enyI5+uLUcx9BS9ALDL687K32/dgs/OU0+pFhB6ZD6cj1nv7WYbgLNJyQzqieE+Mngv4
         r7Pg==
X-Gm-Message-State: APjAAAVt9TrLt4l8K8JLYZZ2yQAwrLV0C7QCllQ5hy7tQoebbisWuMjn
        8alpCqJU/7Z3AMdi8Uc4qbc7WBQukN3x5/CQG7a5PDhoNlVYoH31juwtVLCsa0T8865xGO/28hg
        eSVZGJ+OEO+fi1BtkD29grU+4t4IIfSiepYdD
X-Received: by 2002:a92:3a95:: with SMTP id i21mr15325107ilf.249.1578935241112;
        Mon, 13 Jan 2020 09:07:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqybkxs75cXBlQl+HLFb+zkWG3jPuMlMG/HxwG716bsD3R5CD/DpAv8WBPsaL2BcMPN9Ehf3LemhyTAMNhuZ8cM=
X-Received: by 2002:a92:3a95:: with SMTP id i21mr15325082ilf.249.1578935240847;
 Mon, 13 Jan 2020 09:07:20 -0800 (PST)
MIME-Version: 1.0
References: <20200110214217.GA88274@google.com> <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net> <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv> <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
 <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com> <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com>
In-Reply-To: <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Tue, 14 Jan 2020 01:07:09 +0800
Message-ID: <CACPcB9cQY9Vu3wG-QYZS6W6T_PZxnJ1ABNUUAF_qvk-VSxbpTA@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>, Baoquan He <bhe@redhat.com>,
        Jerry Hoemann <Jerry.Hoemann@hpe.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Wright <rwright@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 2:33 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> > Hi, there are some previous works about this issue, reset PCI devices
> > in kdump kernel to stop ongoing DMA:
> >
> > [v7,0/5] Reset PCIe devices to address DMA problem on kdump with iommu
> > https://lore.kernel.org/patchwork/cover/343767/
> >
> > [v2] PCI: Reset PCIe devices to stop ongoing DMA
> > https://lore.kernel.org/patchwork/patch/379191/
> >
> > And didn't get merged, that patch are trying to fix some DMAR error
> > problem, but resetting devices is a bit too destructive, and the
> > problem is later fixed in IOMMU side. And in most case the DMA seems
> > harmless, as they targets first kernel's memory and kdump kernel only
> > live in crash memory.
>
> I was going to ask the same. If the kdump kernel had IOMMU on, would
> that still be a problem?

It will still fail, doing DMA is not a problem, it only go wrong when
a device's upstream bridge is mistakenly shutdown before the device
shutdown.

>
> > Also, by the time kdump kernel is able to scan and reset devices,
> > there are already a very large time window where things could go
> > wrong.
> >
> > The currently problem observed only happens upon kdump kernel
> > shutdown, as the upper bridge is disabled before the device is
> > disabledm so DMA will raise error. It's more like a problem of wrong
> > device shutting down order.
>
> The way it was described earlier "During this time, the SUT sometimes
> gets a PCI error that raises an NMI." suggests that it isn't really
> restricted to kexec/kdump.
> Any attached device without an active driver might attempt spurious or
> malicious DMA and trigger the same during normal operation.
> Do you have available some more reporting of what happens during the
> PCIe error handling?

Let me add more info about this:

On the machine where I can reproduce this issue, the first kernel
always runs fine, and kdump kernel works fine during dumping the
vmcore, even if I keep the kdump kernel running for hours, nothing
goes wrong. If there are DMA during normal operation that will cause
problem, this should have exposed it.

The problem only occur when kdump kernel try to reboot, no matter how
long the kdump kernel have been running (few minutes or hours). The
machine is dead after printing:
[  101.438300] reboot: Restarting system^M
[  101.455360] reboot: machine restart^M

And I can find following logs happend just at that time, in the
"Integrated Management Log" from the iLO web interface:
1254 OS 12/25/2019 09:08 12/25/2019 09:08 1 User Remotely Initiated NMI Switch
1253 System Error 12/25/2019 09:08 12/25/2019 09:08 1 An Unrecoverable
System Error (NMI) has occurred (Service Information: 0x00000000,
0x00000000)
1252 PCI Bus 12/25/2019 09:07 12/25/2019 09:07 1 Uncorrectable PCI
Express Error (Embedded device, Bus 0, Device 2, Function 2, Error
status 0x00100000)
1251 System Error 12/25/2019 09:07 12/25/2019 09:07 1 Unrecoverable
System Error (NMI) has occurred.  System Firmware will log additional
details in a separate IML entry if possible
1250 PCI Bus 12/25/2019 09:07 12/25/2019 09:07 1 PCI Bus Error (Slot
0, Bus 0, Device 2, Function 2)

And the topology is:
[0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
          +-01.0-[02]--
          +-01.1-[05]--
          +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
          |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
          |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
          +-02.1-[0f]--
          +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array
Gen9 Controllers

It's a bridge reporting the error. It should be an unsupported request
error, bacause downstream device is still alive and sending request,
but the port have bus mastering off. If I manually shutdown the "Smart
Array" (HPSA) device before kdump reboot, it will always reboot just
fine.

And as the patch descriptions said, the HPSA is used in first kernel,
but didn't get reset in kdump kernel because driver is not loaded.
When shutting down a bridge, kernel should shutdown downstream device
first, and then shutdown and clear bus master bit of the bridge. But
in kdump case, kernel skipped some device shutdown due to driver not
loaded issue, and kernel don't know they are enabled.

This problem is not limited to HPSA, the NIC listed in above topology
maybe also make the bridge error out, if HPSA get loaded in kdump
kernel and NIC get ignored.

>
> "The reaction to the NMI that the kdump kernel takes is problematic."
> Or the NMI should not have been triggered to begin with? Where does that happen?

The NMI is triggered by firmware upon the bridge error mentioned
above, it should have triggered a kernel panic, but on the test
system, it just hanged and no longer give any output, so I can't post
any log about it.

