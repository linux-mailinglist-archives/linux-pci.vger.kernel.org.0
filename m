Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D53B49FB0D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234242AbiA1Ntz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 08:49:55 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35270
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236514AbiA1Nty (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 08:49:54 -0500
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 947203F1A4
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643377787;
        bh=UkZPUFpbbylFwxnaYR4Vj+0DUUxTBiAegwzTMuhCopk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=vlp/FXIRPzSiFYKM39TgxaWp6rYaCkEVnTgBKzIFu9ZCa0kizJJk/yTlEmgFk46H1
         cjmhUQctFn3c0KKoXCty7AcBypWguuXgpZ80guJEhOe7v3utTIcK6ot+QW1dicr0ot
         CV7OxuxEmGMlH0V9yltBR3pwkMGs9pj5NNvSpE+evJ4p7Vkn/hs9kmSkFhWOwYZPRN
         cejDbpTP7E1b2tNQ+aU862ihxtLEErDPXlfTA7Vd+VbBLJ3fsQfdmZyMICAmrzZOAi
         5iAvwcoVHBRsaqu81L+7jsuSiN7Hctk4QlWwByvkulQ9GH8pNNU1ck26wV2pWydsKP
         G/UHcbALrlMrQ==
Received: by mail-oo1-f70.google.com with SMTP id h13-20020a4aa74d000000b002e99030d358so3194233oom.6
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 05:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkZPUFpbbylFwxnaYR4Vj+0DUUxTBiAegwzTMuhCopk=;
        b=rVpqAc5akwxZMY1UbWEtxKTuhXxyiUeS+3DuwKhmx3E9UZuy0ct7GThGC6Qsk7HhqI
         yRnaUPVwXWyn+H051fcOeKuhoHIPqwlrOxjOA4hxMX4tuPXVvass/X7RC5v9JPah1q9v
         Ftv8NZEdOym89mbCL4i1B1c5YZCluoSuNdHnCP0UxUz8KJY5OjsuPKVAhIvNSBzaHqP6
         3F5CFTnOTTD7C9DYX1e7RH+ranftkayT4o8VJ2mP9xydlULq3kuWn/RECX78Osx5P9HT
         LZ23hWEbfLabHPjXIZh1ijcgNip1avIDqCtxgJCO6Jj6lregvGa53yQVULiGNyHvl3+j
         aegQ==
X-Gm-Message-State: AOAM533SbjZsINAOmxu5PgFGgszsdRxXQH/ZrzyqyvbhlNPF/ys1F4zt
        IaM0dlaWpdTsIAE5GuGrh/WXopzgUwerZ6WQ7IeJHEdN/5mvIUIlvt/LMrjIT3sexsLsQewhH7n
        ZBRr18yNtIMl9YKL0N1jUdBsLj+VX5vTCnaFCh7QfLAyzU4O6lQv6pQ==
X-Received: by 2002:a05:6808:179e:: with SMTP id bg30mr5647266oib.57.1643377786526;
        Fri, 28 Jan 2022 05:49:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdjB37L+oqW7eqTasVzfQjR1lx63SsN48AbTHnPL+yZ4bE5FA4Fg3OKeu25UJhf4WXfhr96PeqwU4xAAbJq18=
X-Received: by 2002:a05:6808:179e:: with SMTP id bg30mr5647251oib.57.1643377786228;
 Fri, 28 Jan 2022 05:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20220128092931.00004a24@linux.intel.com> <20220128130805.GA199531@bhelgaas>
In-Reply-To: <20220128130805.GA199531@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 28 Jan 2022 21:49:34 +0800
Message-ID: <CAAd53p5HJT-UHd-Bm9KhWaEKAhUiWcYerLaM=ztksAe4XdLLCA@mail.gmail.com>
Subject: Re: [Bug 215525] New: HotPlug does not work on upstream kernel 5.17.0-rc1
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        linux-pci@vger.kernel.org, Blazej Kucman <blazej.kucman@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Lukas Wunner <lukas@wunner.de>,
        Naveen Naidu <naveennaidu479@gmail.com>,
        Keith Busch <kbusch@kernel.org>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 9:08 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Kai-Heng]
>
> On Fri, Jan 28, 2022 at 09:29:31AM +0100, Mariusz Tkaczyk wrote:
> > On Thu, 27 Jan 2022 20:52:12 -0600
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Jan 27, 2022 at 03:46:15PM +0100, Mariusz Tkaczyk wrote:
> > > > ...
> > > > Thanks for your suggestions. Blazej did some tests and results were
> > > > inconclusive. He tested it on two same platforms. On the first one
> > > > it didn't work, even if he reverted all suggested patches. On the
> > > > second one hotplugs always worked.
> > > >
> > > > He noticed that on first platform where issue has been found
> > > > initally, there was boot parameter "pci=nommconf". After adding
> > > > this parameter on the second platform, hotplugs stopped working too.
> > > >
> > > > Tested on tag pci-v5.17-changes. He have CONFIG_HOTPLUG_PCI_PCIE
> > > > and CONFIG_DYNAMIC_DEBUG enabled in config. He also attached two
> > > > dmesg logs to bugzilla with boot parameter 'dyndbg="file pciehp*
> > > > +p" as requested. One with "pci=nommconf" and one without.
> > > >
> > > > Issue seems to related to "pci=nommconf" and it is probably caused
> > > > by change outside pciehp.
> > >
> > > Maybe I'm missing something.  If I understand correctly, the problem
> > > has nothing to do with the kernel version (correct me if I'm wrong!)
> >
> > The problem occurred after the merge commit. It is some kind of
> > regression.
>
> The bug report doesn't yet contain the evidence showing this.  It only
> contains dmesg logs with "pci=nommconf" where pciehp doesn't work
> (which is the expected behavior) and a log without "pci=nommconf"
> where pciehp does work (which is again the expected behavior).
>
> > > PCIe native hotplug doesn't work when booted with "pci=nommconf".
> > > When using "pci=nommconf", obviously we can't access the extended PCI
> > > config space (offset 0x100-0xfff), so none of the extended
> > > capabilities are available.
> > >
> > > In that case, we don't even ask the platform for control of PCIe
> > > hotplug via _OSC.  From the dmesg diff from normal (working) to
> > > "pci=nommconf" (not working):
> > >
> > >   -Command line: BOOT_IMAGE=/boot/vmlinuz-smp ...
> > >   +Command line: BOOT_IMAGE=/boot/vmlinuz-smp pci=nommconf ...
> > >   ...
> > >   -acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM
> > > Segments MSI HPX-Type3] -acpi PNP0A08:00: _OSC: platform does not
> > > support [AER LTR] -acpi PNP0A08:00: _OSC: OS now controls
> > > [PCIeHotplug PME PCIeCapability] +acpi PNP0A08:00: _OSC: OS supports
> > > [ASPM ClockPM Segments MSI HPX-Type3] +acpi PNP0A08:00: _OSC: not
> > > requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> > > +acpi PNP0A08:00: MMCONFIG is disabled, can't access extended PCI
> > > configuration space under this bridge.
> >
> > So, it shouldn't work from years but it has been broken recently, that
> > is the only objection I have. Could you tell why it was working?
> > According to your words- it shouldn't. We are using VMD driver, is that
> > matter?
>
> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") looks like
> a it could be related.  Try reverting that commit and see whether it
> makes a difference.

The affected NVMe is indeed behind VMD domain, so I think the commit
can make a difference.

Does VMD behave differently on laptops and servers?
Anyway, I agree that the issue really lies in "pci=nommconf".

Kai-Heng

>
> Bjorn
