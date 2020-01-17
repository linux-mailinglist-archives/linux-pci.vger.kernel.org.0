Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3622140279
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 04:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgAQDqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 22:46:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53309 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQDqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jan 2020 22:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579232788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fo7HRBfpWlP4As+UqwBqxox4rOzMxaYO651E0ZJDut8=;
        b=arBo9VGLKECmi7SefM2M0JO8RchwzTeTHEIgm5Djqxm97mKt7wj/eJlO4tqU78C7TU524V
        cHpApxl2AmmzaR0tcRhoEUgjsM91S3qPamPpU4tFXAt+AuWshAAzNPbhVs0Do4T+W7lX4T
        vgy6I0dDHykNhgc9GNrksR8Fbelieo0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-icHzL5KWM-Wf_6BX15mz1w-1; Thu, 16 Jan 2020 22:46:27 -0500
X-MC-Unique: icHzL5KWM-Wf_6BX15mz1w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BEF6185432C;
        Fri, 17 Jan 2020 03:46:26 +0000 (UTC)
Received: from localhost (ovpn-12-20.pek2.redhat.com [10.72.12.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77F3F1A7E3;
        Fri, 17 Jan 2020 03:46:22 +0000 (UTC)
Date:   Fri, 17 Jan 2020 11:46:20 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dave Young <dyoung@redhat.com>,
        Jerry Hoemann <Jerry.Hoemann@hpe.com>,
        Randy Wright <rwright@hpe.com>
Cc:     Khalid Aziz <khalid@gonehiking.org>,
        Kairui Song <kasong@redhat.com>, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200117034620.GD22191@MiWiFi-R3L-srv>
References: <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
 <20200111005041.GB19291@MiWiFi-R3L-srv>
 <dc46c904-1652-09b3-f351-6b3a3e761d74@gonehiking.org>
 <CACPcB9c0-nRjM3DSN8wzZBTPsJKWjZ9d_aNTq5zUj4k4egb32Q@mail.gmail.com>
 <CABeXuvqquCU+1G=5onk9owASorhpcYWeWBge9U35BrorABcsuw@mail.gmail.com>
 <CACPcB9cQY9Vu3wG-QYZS6W6T_PZxnJ1ABNUUAF_qvk-VSxbpTA@mail.gmail.com>
 <b2360db7-66f5-421d-8fe0-150f08aa2f39@gonehiking.org>
 <CACPcB9epDPcowhnSJuEHQ8miCBX1oKjFx4Wdn4aYPe2_pueA5A@mail.gmail.com>
 <6b56ce15-5a5a-97b7-ded1-1fd88fec26eb@gonehiking.org>
 <20200117032413.GA16906@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117032413.GA16906@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01/17/20 at 11:24am, Dave Young wrote:
> On 01/15/20 at 02:17pm, Khalid Aziz wrote:
> > On 1/15/20 11:05 AM, Kairui Song wrote:
> > > On Thu, Jan 16, 2020 at 1:31 AM Khalid Aziz <khalid@gonehiking.org> wrote:
> > >>
> > >> On 1/13/20 10:07 AM, Kairui Song wrote:
> > >>> On Sun, Jan 12, 2020 at 2:33 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> > >>>>
> > >>>>> Hi, there are some previous works about this issue, reset PCI devices
> > >>>>> in kdump kernel to stop ongoing DMA:
> > >>>>>
> > >>>>> [v7,0/5] Reset PCIe devices to address DMA problem on kdump with iommu
> > >>>>> https://lore.kernel.org/patchwork/cover/343767/
> > >>>>>
> > >>>>> [v2] PCI: Reset PCIe devices to stop ongoing DMA
> > >>>>> https://lore.kernel.org/patchwork/patch/379191/
> > >>>>>
> > >>>>> And didn't get merged, that patch are trying to fix some DMAR error
> > >>>>> problem, but resetting devices is a bit too destructive, and the
> > >>>>> problem is later fixed in IOMMU side. And in most case the DMA seems
> > >>>>> harmless, as they targets first kernel's memory and kdump kernel only
> > >>>>> live in crash memory.
> > >>>>
> > >>>> I was going to ask the same. If the kdump kernel had IOMMU on, would
> > >>>> that still be a problem?
> > >>>
> > >>> It will still fail, doing DMA is not a problem, it only go wrong when
> > >>> a device's upstream bridge is mistakenly shutdown before the device
> > >>> shutdown.
> > >>>
> > >>>>
> > >>>>> Also, by the time kdump kernel is able to scan and reset devices,
> > >>>>> there are already a very large time window where things could go
> > >>>>> wrong.
> > >>>>>
> > >>>>> The currently problem observed only happens upon kdump kernel
> > >>>>> shutdown, as the upper bridge is disabled before the device is
> > >>>>> disabledm so DMA will raise error. It's more like a problem of wrong
> > >>>>> device shutting down order.
> > >>>>
> > >>>> The way it was described earlier "During this time, the SUT sometimes
> > >>>> gets a PCI error that raises an NMI." suggests that it isn't really
> > >>>> restricted to kexec/kdump.
> > >>>> Any attached device without an active driver might attempt spurious or
> > >>>> malicious DMA and trigger the same during normal operation.
> > >>>> Do you have available some more reporting of what happens during the
> > >>>> PCIe error handling?
> > >>>
> > >>> Let me add more info about this:
> > >>>
> > >>> On the machine where I can reproduce this issue, the first kernel
> > >>> always runs fine, and kdump kernel works fine during dumping the
> > >>> vmcore, even if I keep the kdump kernel running for hours, nothing
> > >>> goes wrong. If there are DMA during normal operation that will cause
> > >>> problem, this should have exposed it.
> > >>>
> > >>
> > >> This is the part that is puzzling me. Error shows up only when kdump
> > >> kernel is being shut down. kdump kernel can run for hours without this
> > >> issue. What is the operation from downstream device that is resulting in
> > >> uncorrectable error - is it indeed a DMA request? Why does that
> > >> operation from downstream device not happen until shutdown?
> > >>
> > >> I just want to make sure we fix the right problem in the right way.
> > >>
> > > 
> > > Actually the device could keep sending request with no problem during
> > > kdump kernel running. Eg. keep sending DMA, and all DMA targets first
> > > kernel's system memory, so kdump runs fine as long as nothing touch
> > > the reserved crash memory. And the error is reported by the port, when
> > > shutdown it has bus master bit, and downstream request will cause
> > > error.
> > > 
> > 
> > Problem really is there are active devices while kdump kernel is
> > running. You did say earlier - "And in most case the DMA seems
> > harmless, as they targets first kernel's memory and kdump kernel only
> > live in crash memory.". Even if this holds today, it is going to break
> > one of these days. There is the "reset_devices" option but that does not
> > work if driver is not loaded by kdump kernel. Can we try to shut down
> > devices in machine_crash_shutdown() before we start kdump kernel?
> 
> It is not a good idea :)  We do not add extra logic after a panic
> because the kernel is not stable and we want a correct vmcore.
> 
> Similar suggestions had been rejected a lot of times..

Yes.

About this bug, I think HPE may need to check if their firmware/hardware
has special design. I checked other vendors' system which has many
devices under several bridges, this issue is not seen.

Say the issue again, we have been excluding the unneeded devices drivers
from kdump initramfs. This issue is seen first time. And we don't suggest
customer to close IOMMU in kdump kernel if hardware IOMMU is deployed.

So for a system with hardware IOMMU, those devices will go through these
life cycles:

1) devices handling DMA transferring in 1st kernel;
2) after crash, we don't shutdown them. Means they are keeping alive,
and handling DMA transferring;
3) during kdump kernel boot, hardware IOMMU initialization will copy the
old iommu translation table to make the on-flight DMA continue;
4) device driver will initialize the relevant device, to reset it;
   - if no device driver loaded, the device will keep active in the
     whole kdump kernel life cycle
5) when vmcore dumping is done, we try to reboot kdump kernel, shutdown
all devices;

The issue happened in the 5) step. As Kairui provided log, shutting down
the bridge which subordinate devices are not controlled by loaded driver
will cause the UR and NMI, then hang happened.

Thanks
Baoquan

