Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5080613B6B5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 02:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAOBQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 20:16:55 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43973 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728795AbgAOBQz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 20:16:55 -0500
Received: by mail-il1-f195.google.com with SMTP id v69so13323689ili.10;
        Tue, 14 Jan 2020 17:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrM9hyWl7t9/dtdjzNEgfpEEAIhduRic/LBoSXXTBB4=;
        b=pns5Lv88UX7SC6zugFqCrYQDJ8yr5nVBeQOCbrRoelFwML7CXtJOCgvAk7D9lIBzJY
         b+xehkBgNGjxC4rvBKghrmatoOKYLyPBPcifAa0nS4VcXMIxFHjrY8zZSBLcWyKkLy3v
         T+VBPQbNF4wpZ1H3Et/rLrUffo/HRvngprOQlCRDUBnLaPE+0Wqy/6cw3kZvyKoWbSCt
         tyqNoDHA7r0lN1NiDLB5Kmftb1O+bCtbf0EXJGBGX9Rds/74zBr9qls2+LaDP4U2RwLV
         2CmBepR1mVIdHfprrZxzITv+mza444v9Zg3k/GqA5G9FmjBdONoQFQswAk0yBzWX+7rh
         l96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrM9hyWl7t9/dtdjzNEgfpEEAIhduRic/LBoSXXTBB4=;
        b=U8MEtLEPMR/19W+2eQjtUgKly/3qvAQOF3P3Fn6809i9u+aWpcDSOMPv1oERE5Afjl
         zFCv6fsTO/kAN4AaFOyxU8QCMMilmQGS0oSA9hQMv0R8P4aNY3SFZMzIT7dz+NqwpOuM
         Iu9l6zHVJYvu+iimOTYemLLkq7cSdL9+7viqxCgP5kS4QWKf9tkrvBO2UrVCLAuKKBdY
         qhkjIqAGc+fOR7VQOxcih7dsCwbVT0xQlgC3Q/sr1Q+bUwcqABpSmaKf57rPMZwW8mwT
         J7JNZRgRHlC2e7nqvglEsKqY/zsur9ryW6h6qiSrkoyDdRknSQx3/pp4JrbSMo4SsYwX
         V1oQ==
X-Gm-Message-State: APjAAAWTJo5nTDWcezePl332lujxm7f/GGyPOnmjo+GHpnICa+soZFR5
        0dCDD72kC88BW3BJZQmLSPI6cb9tlKakEkdpv9U=
X-Google-Smtp-Source: APXvYqzMmoQiLG1dWvKeO4SE97241zJmp6LiGBAX56u8Jm3+DnRxl9S+Dr6af5A/V4bgev6GgdAEiwn/r/usnIQkKeY=
X-Received: by 2002:a92:1906:: with SMTP id 6mr1401696ilz.130.1579051014396;
 Tue, 14 Jan 2020 17:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20200110214217.GA88274@google.com> <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net> <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv> <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
 <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com>
 <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com> <CACPcB9cQY9Vu3wG-QYZS6W6T_PZxnJ1ABNUUAF_qvk-VSxbpTA@mail.gmail.com>
In-Reply-To: <CACPcB9cQY9Vu3wG-QYZS6W6T_PZxnJ1ABNUUAF_qvk-VSxbpTA@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 14 Jan 2020 17:16:41 -0800
Message-ID: <CABeXuvpWR9foBREPPc4T0G_Pf7D3=uaiKv1+_SkLti2+SrKb5Q@mail.gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Kairui Song <kasong@redhat.com>
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

On Mon, Jan 13, 2020 at 9:07 AM Kairui Song <kasong@redhat.com> wrote:
>
> On Sun, Jan 12, 2020 at 2:33 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> >
> > > Hi, there are some previous works about this issue, reset PCI devices
> > > in kdump kernel to stop ongoing DMA:
> > >
> > > [v7,0/5] Reset PCIe devices to address DMA problem on kdump with iommu
> > > https://lore.kernel.org/patchwork/cover/343767/
> > >
> > > [v2] PCI: Reset PCIe devices to stop ongoing DMA
> > > https://lore.kernel.org/patchwork/patch/379191/
> > >
> > > And didn't get merged, that patch are trying to fix some DMAR error
> > > problem, but resetting devices is a bit too destructive, and the
> > > problem is later fixed in IOMMU side. And in most case the DMA seems
> > > harmless, as they targets first kernel's memory and kdump kernel only
> > > live in crash memory.
> >
> > I was going to ask the same. If the kdump kernel had IOMMU on, would
> > that still be a problem?
>
> It will still fail, doing DMA is not a problem, it only go wrong when
> a device's upstream bridge is mistakenly shutdown before the device
> shutdown.
>
> >
> > > Also, by the time kdump kernel is able to scan and reset devices,
> > > there are already a very large time window where things could go
> > > wrong.
> > >
> > > The currently problem observed only happens upon kdump kernel
> > > shutdown, as the upper bridge is disabled before the device is
> > > disabledm so DMA will raise error. It's more like a problem of wrong
> > > device shutting down order.
> >
> > The way it was described earlier "During this time, the SUT sometimes
> > gets a PCI error that raises an NMI." suggests that it isn't really
> > restricted to kexec/kdump.
> > Any attached device without an active driver might attempt spurious or
> > malicious DMA and trigger the same during normal operation.
> > Do you have available some more reporting of what happens during the
> > PCIe error handling?
>
> Let me add more info about this:
>
> On the machine where I can reproduce this issue, the first kernel
> always runs fine, and kdump kernel works fine during dumping the
> vmcore, even if I keep the kdump kernel running for hours, nothing
> goes wrong. If there are DMA during normal operation that will cause
> problem, this should have exposed it.
>
> The problem only occur when kdump kernel try to reboot, no matter how
> long the kdump kernel have been running (few minutes or hours). The
> machine is dead after printing:
> [  101.438300] reboot: Restarting system^M
> [  101.455360] reboot: machine restart^M
>
> And I can find following logs happend just at that time, in the
> "Integrated Management Log" from the iLO web interface:
> 1254 OS 12/25/2019 09:08 12/25/2019 09:08 1 User Remotely Initiated NMI Switch
> 1253 System Error 12/25/2019 09:08 12/25/2019 09:08 1 An Unrecoverable
> System Error (NMI) has occurred (Service Information: 0x00000000,
> 0x00000000)
> 1252 PCI Bus 12/25/2019 09:07 12/25/2019 09:07 1 Uncorrectable PCI
> Express Error (Embedded device, Bus 0, Device 2, Function 2, Error
> status 0x00100000)
> 1251 System Error 12/25/2019 09:07 12/25/2019 09:07 1 Unrecoverable
> System Error (NMI) has occurred.  System Firmware will log additional
> details in a separate IML entry if possible
> 1250 PCI Bus 12/25/2019 09:07 12/25/2019 09:07 1 PCI Bus Error (Slot
> 0, Bus 0, Device 2, Function 2)
>
> And the topology is:
> [0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
>           +-01.0-[02]--
>           +-01.1-[05]--
>           +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
>           +-02.1-[0f]--
>           +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array
> Gen9 Controllers
>
> It's a bridge reporting the error. It should be an unsupported request
> error, bacause downstream device is still alive and sending request,
> but the port have bus mastering off. If I manually shutdown the "Smart
> Array" (HPSA) device before kdump reboot, it will always reboot just
> fine.
>
> And as the patch descriptions said, the HPSA is used in first kernel,
> but didn't get reset in kdump kernel because driver is not loaded.
> When shutting down a bridge, kernel should shutdown downstream device
> first, and then shutdown and clear bus master bit of the bridge. But
> in kdump case, kernel skipped some device shutdown due to driver not
> loaded issue, and kernel don't know they are enabled.
>
> This problem is not limited to HPSA, the NIC listed in above topology
> maybe also make the bridge error out, if HPSA get loaded in kdump
> kernel and NIC get ignored.

It looks like the right answer is for the kernel to handle such cases
gracefully. From what I recall, we can only trust the bus mastering at
root ports. So, it is possible that the endpoint devices can always
try to DMA, but it can be blocked by the root port. So the right fix
seems to teach kernel how to handle these insted of hacking the
shutdown code.
-Deepa


-Deepa
