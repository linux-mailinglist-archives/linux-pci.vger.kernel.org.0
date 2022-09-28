Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D8C5ED569
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiI1Gwe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiI1GwH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 02:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37514A124
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664347801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wC/JlSTVfuFg2D8xSQgtQz9V5uV1YgBXHNCywsshxw=;
        b=EMG49HKlKnSirm+UDeYRcSzjoah1532TRY3zbRogOE/HrW47U9SEQciY3jmf0ZsaB/O2BR
        Ex2M6/Fs3P2oFnS8b3UVowu3QdKwCBhz1Lj3L9dVncMJgLCnWFfeCUSra/8oTcGBSdHJAA
        KLLPJa0+49gRhCxr1d94lvcLIRH+Yhs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-Ty3cABa5Nk6oUn6sskyAvg-1; Wed, 28 Sep 2022 02:50:00 -0400
X-MC-Unique: Ty3cABa5Nk6oUn6sskyAvg-1
Received: by mail-qk1-f197.google.com with SMTP id k2-20020a05620a414200b006ceec443c8bso8931532qko.14
        for <linux-pci@vger.kernel.org>; Tue, 27 Sep 2022 23:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+wC/JlSTVfuFg2D8xSQgtQz9V5uV1YgBXHNCywsshxw=;
        b=PevmzzrU+e/wsxKXyZc/u6W9k+kOKKXPKt7HQGJxWZKUJcWboNBPn1XleGI0asfbXL
         /5b9lLgtqmh07UZUBdaUPT79qNdO8VvrQXu9Q5pJYaLygngSV1B4pQAUWUHed+8F5qw1
         ZriAvFs3l0ElHoqE/UEo+4MaEiPlyRYXMubjxMb9mWkaEIooCnCKobFSJM1KskMmZS+k
         Od6gikTBJpY8Cw+Moztrv7jqoOLa2h/iqduDK8zJ/v6LhjrWmlaV4FtHb78c4Um4+/nS
         GxTB5oTkSNQ3EvkYL49mw4xpcqVDkp20nvpJBHgyrcdq4D0NP4jbwMjDM0jiowOyO8F6
         3EUg==
X-Gm-Message-State: ACrzQf1HrrmcvvzBSHwMkNCid0GFjQiHY6cMXvQPgkVBSrMMpvdFFjgW
        b1EkPm0FX40kBrzwQBolVg+VSgD0tXDYmFZTicYmvoTkjcN6j5nrHnL1w7GC+tyunKb/abKCbkY
        gbIgRBpcPrA9gzW7J+NOTtoxKYmuv0do2M/7d
X-Received: by 2002:a05:622a:1793:b0:35b:af87:4f22 with SMTP id s19-20020a05622a179300b0035baf874f22mr25694263qtk.673.1664347799178;
        Tue, 27 Sep 2022 23:49:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM66RyqdG8mKQYHhisZRyG7dnXcjWSPOqzBYAPvA1nPQJP77AYnhyykk0L4m0/h+0PQJXS2EyhW6YKQV6rAK9SY=
X-Received: by 2002:a05:622a:1793:b0:35b:af87:4f22 with SMTP id
 s19-20020a05622a179300b0035baf874f22mr25694247qtk.673.1664347798865; Tue, 27
 Sep 2022 23:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <1664288166-7432-1-git-send-email-lixiaochun.2888@163.com> <20220927184817.GA1719151@bhelgaas>
In-Reply-To: <20220927184817.GA1719151@bhelgaas>
From:   Xiaochun Li <xiaocli@redhat.com>
Date:   Wed, 28 Sep 2022 14:49:47 +0800
Message-ID: <CAA1RLiRkAqp+qXoi7-e6NbRoHoGLmV5F9R5wbR1xcsy8O0SWKQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI: Set no io resource for bridges that behind
 VMD controller
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Xiaochun Lee <lixiaochun.2888@163.com>,
        nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Xiaochun Lee <lixc17@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 28, 2022 at 2:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, Sep 27, 2022 at 10:16:06PM +0800, Xiaochun Lee wrote:
> > From: Xiaochun Lee <lixc17@lenovo.com>
> >
> > When enable VMDs on Intel CPUs, VMD controllers(8086:28c0) be
> > recognized by VMD driver and there are many failed messages of
> > BAR 13 when scan the bridges and assign IO resource behind it
> > as listed below, the bridge wants to get 0x6000 as its IO
> > resource, but there is no IO resources on the host bridge.
> >
> > VMD host bridge resources:
> > vmd 0000:e2:00.5: PCI host bridge to bus 10001:00
> > pci_bus 10001:00: root bus resource [bus 00-1f]
> > pci_bus 10001:00: root bus resource [mem 0xf4000000-0xf5ffffff]
> > pci_bus 10001:00: root bus resource [mem 0x29ffff02010-0x29fffffffff 64=
bit]
> > pci_bus 10001:00: scanning bus
> >
> > Read bridge IO resource:
> > pci 10001:00:02.0: PCI bridge to [bus 01]
> > pci 10001:00:02.0:   bridge window [io  0x1000-0x6fff]
> > pci 10001:00:03.0: PCI bridge to [bus 02]
> > pci 10001:00:03.0:   bridge window [io  0x1000-0x6fff]
> >
> > Failed messages of BAR#13:
> > pci 10001:00:02.0: BAR 13: no space for [io  size 0x6000]
> > pci 10001:00:02.0: BAR 13: failed to assign [io  size 0x6000]
> > pci 10001:00:03.0: BAR 13: no space for [io  size 0x6000]
> > pci 10001:00:03.0: BAR 13: failed to assign [io  size 0x6000]
> >
> > VMD-enabled root ports use
> > Enhanced Configuration Access Mechanism (ECAM) access
> > PCI Express configuration space, and offer VMD_CFGBAR as
> > base of PCI Express configuration space for the bridges
> > behind it. The configuration space includes IO resources,
>
> I don't quite understand this part.  ECAM is an MMIO method, so it
> uses memory space, not I/O port space.

VMD read PCI IO base has a special callback function "vmd_pci_read",
The call stack list as below:

pci_read_bridge_windows()
        pci_read_config_word(bridge, PCI_IO_BASE, &io) # read BAR 13
                pci_bus_read_config_word()
                        bus->ops->read()
                                vmd_pci_read() # for VMD bus
                                        vmd_cfg_addr()
                                                offset =3D
PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
                                                return vmd->cfgbar +
offset; #base vmd->cfgbar
                                        readw(addr) # read value out

And vmd->cfgbar points to  an iomap for VMD_CFGBAR as listed below.
vmd->cfgbar =3D pcim_iomap(dev, VMD_CFGBAR, 0);

Intel spec Sapphire Rapids Server Processor,EDS volume two,Revision 0.9
Chapter 9 Volume Management Device (VMD) Registers
Section 9.1.9 VMD Configuration Base Address show CFGBAR is offset 0x10.

dmesg list as following:
[    2.091800] pci 0000:64:00.5: [8086:28c0] type 00 class 0x010400
[    2.091810] pci 0000:64:00.5: reg 0x10: [mem
0x24ffc000000-0x24ffdffffff 64bit pref]
[    2.091816] pci 0000:64:00.5: reg 0x18: [mem 0xe0000000-0xe1ffffff]
[    2.091827] pci 0000:64:00.5: reg 0x20: [mem
0x24ffff00000-0x24fffffffff 64bit]

Commad "lspci -vvv -s 64:00.5" shown as below:
0000:64:00.5 RAID bus controller: Intel Corporation Volume Management
Device NVMe RAID Controller (rev 04)
        DeviceName: Intel RAID Controller CPU1
        Subsystem: Lenovo Device 010f
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        NUMA node: 0
        Region 0: Memory at 24ffc000000 (64-bit, prefetchable) [size=3D32M]
        Region 2: Memory at e0000000 (32-bit, non-prefetchable) [size=3D32M=
]
        Region 4: Memory at 24ffff00000 (64-bit, non-prefetchable) [size=3D=
1M]

So for VMD, actually the bridges configuration IO base and IO limit of
BAR#13 are read from VMD host bridge BAR0(offset 0x10), not like the normal
bridges on x86 read Configuration via IO port(0cf8-0cff : PCI conf1)

And refer spec PCI Express=C2=AE Base Specification Revision 5.0 Version 1.=
0
Section 7.2 PCI Express Configuration Mechanisms
subsection 7.2.2 PCI Express Enhanced Configuration Access Mechanism (ECAM)
has a description as below.
The ECAM utilizes a flat memory-mapped address space to access device
configuration registers. In this case, the memory address determines the
configuration register accessed and the memory data updates (for a write)
or returns the contents of (for a read) the addressed register.

>
> > but these IO resources are not actually used on X86,
> > it can result in BAR#13 assign IO resource failed.
> > Therefor,clear IO resources by setting an IO base value
> > greater than limit to these bridges here, so in this case,
> > we can leverage kernel parameter "pci=3Dhpiosize=3D0KB" to
> > avoid this failed messages show up.
>
> Is the only purpose of this patch to avoid the "no space" and "failed
> to assign" messages?  Or is there something that actually doesn't
> work?

Yes, only to avoid the failed messages showing up, we don't find any functi=
on
impact so far. Our customers extremely care about these failed messages,
They keep complaining about it. For that non-vmd hot plug bridges,
append kernel parameter "pci=3Dhpiosize=3D0KB" can avoid them show up, but =
for
bridges behind VMD, it couldn't work, there isn't any workaround so far.

>
> I don't think it's worth making a quirk just to avoid the message.
> There are several systems where I/O port space is not available, and
> it *would* be nice to have a generic approach that handles that
> better.

The bridge IO base and limit of BAR#13 read from their host bridge
BAR0(offset 0x10),it might be an uncorrected value set by the VROC driver i=
n
UEFI.Hence, it seems the firmware could fix it. But it is really hard to pu=
sh
them to enhance it, so I prepare a quirk for the corresponding bridges here=
.
If making a generic approach to avoid the failed message for assigning IO
resource of BAR#13, where do you prefer adding it?
Do you have any recommendations? Thanks!
And would you please share with me which systems have an unavailable
IO port space too, appreciate it.

>
> > Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
> > ---
> >  drivers/pci/quirks.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 4944798e75b5..efecf12e8059 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -5956,3 +5956,63 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x=
56b1, aspm_l1_acceptable_latency
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptab=
le_latency);
> >  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptab=
le_latency);
> >  #endif
> > +
> > +#if defined(CONFIG_X86_64) || defined(CONFIG_X86)
> > +
> > +#ifdef CONFIG_UML_X86
> > +#define is_vmd(bus)             false
> > +#endif /* CONFIG_UML_X86 */
> > +
> > +/*
> > + * VMD-enabled root ports use Enhanced Configuration Access Mechanism =
(ECAM)
> > + * access PCI Express configuration space, and offer VMD_CFGBAR as the
> > + * base of PCI Express configuration space for the bridges behind it.
> > + * The configuration space includes IO resources, but these IO
> > + * resources are not actually used on X86, and it can result
> > + * in BAR#13 assign IO resource failed. Therefor, clear IO resources
> > + * by setting an IO base value greater than limit to these bridges her=
e,
> > + * so in this case, append kernel parameter "pci=3Dhpiosize=3D0KB" can=
 avoid
> > + * the BAR#13 failed messages show up.
> > + */
> > +static void quirk_vmd_no_iosize(struct pci_dev *bridge)
> > +{
> > +     u8 io_base_lo, io_limit_lo;
> > +     u16 io_low;
> > +     u32 io_upper16;
> > +     unsigned long io_mask,  base, limit;
> > +
> > +     io_mask =3D PCI_IO_RANGE_MASK;
> > +     if (bridge->io_window_1k)
> > +             io_mask =3D PCI_IO_1K_RANGE_MASK;
> > +
> > +     /* VMD Domain */
> > +     if (is_vmd(bridge->bus) && bridge->is_hotplug_bridge) {
> > +             pci_read_config_byte(bridge, PCI_IO_BASE, &io_base_lo);
> > +             pci_read_config_byte(bridge, PCI_IO_LIMIT, &io_limit_lo);
> > +             base =3D (io_base_lo & io_mask) << 8;
> > +             limit =3D (io_limit_lo & io_mask) << 8;
> > +             /* if there are defined io ports behind the bridge on x86=
,
> > +              * we clear it, since there is only 64KB IO resource on i=
t,
> > +              * beyond that, hotplug io bridges don't needs IO port re=
source,
> > +              * such as NVMes attach on it. So the corresponding range=
 must be
> > +              * turned off by writing base value greater than limit to=
 the
> > +              * bridge's base/limit registers.
> > +              */
> > +             if (limit >=3D base) {
> > +                     /* Clear upper 16 bits of I/O base/limit */
> > +                     io_upper16 =3D 0;
> > +                     /* set base value greater than limit */
> > +                     io_low =3D 0x00f0;
> > +
> > +                     /* Temporarily disable the I/O range before updat=
ing PCI_IO_BASE */
> > +                     pci_write_config_dword(bridge, PCI_IO_BASE_UPPER1=
6, 0x0000ffff);
> > +                     /* Update lower 16 bits of I/O base/limit */
> > +                     pci_write_config_word(bridge, PCI_IO_BASE, io_low=
);
> > +                     /* Update upper 16 bits of I/O base/limit */
> > +                     pci_write_config_dword(bridge, PCI_IO_BASE_UPPER1=
6, io_upper16);
> > +             }
> > +     }
> > +}
> > +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID,
> > +             PCI_CLASS_BRIDGE_PCI, 8, quirk_vmd_no_iosize);
> > +#endif
> > --
> > 2.37.3
> >
>


--=20
Best Regards,
Xiaochun Li (Xavier) (Mr.)
RedHat Onsite engineer
Lenovo Linux Kernel Engineer
Lenovo Infrastructure Solutions Group (ISG)/China Standard Time Zone(CST)

