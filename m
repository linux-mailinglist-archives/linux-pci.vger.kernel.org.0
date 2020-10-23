Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B692971F4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 17:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461536AbgJWPJL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 11:09:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S461524AbgJWPJL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Oct 2020 11:09:11 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12B22245A
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 15:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603465750;
        bh=agsiQ/fEHt/WLHZ9yc2u7tPcpdORYofbT0f94P1+pG0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BpEplTahqATOEE2/VqclBWtocpZTOM0pu7c4raP1Zz7NhsSeh00m1RsoGcDyIoqm3
         Qm9MQzsxgxh1r1Jgt/kriyIp1OoJ48PRTI+mPIy2I/LBfLxl4MWBt+DuN3ECQYNTZP
         mqUjB110lXUtr8dN6lXDsr4Mh8B4n9BUW/N4X9c4=
Received: by mail-ot1-f45.google.com with SMTP id n11so1660032ota.2
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 08:09:09 -0700 (PDT)
X-Gm-Message-State: AOAM530LZ5KxrRYy/FO0xIWyY8GIja2OuuOStZ/1uGJShsZ50Wm76WXR
        taZ5kdoLtSpKAkUOej4VLGWxLwv//RJID8mQZA==
X-Google-Smtp-Source: ABdhPJwBzHAnYe5rFOHitj7oM3UtHRN4MFNdbRy80DvwfIQrRwjQie/KI14jn0pHVc4bguEtRvZBkjg7uytbiTq9K1w=
X-Received: by 2002:a9d:62d1:: with SMTP id z17mr1780111otk.192.1603465748971;
 Fri, 23 Oct 2020 08:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201022220038.1339854-1-robh@kernel.org> <20201022220507.GW1551@shell.armlinux.org.uk>
 <20201022220924.GX1551@shell.armlinux.org.uk> <CAL_JsqKzGK6sgRZMEEXVZQGbMsEOi86W-2CcJiWtsvHhiR7O7A@mail.gmail.com>
 <44c28085-d1ed-d4a0-10fe-0d9d3c0a8e7e@gmail.com>
In-Reply-To: <44c28085-d1ed-d4a0-10fe-0d9d3c0a8e7e@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 23 Oct 2020 10:08:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOZRgmyvcb8g18Z_nFTO6uVbMe_=UTFMXqU9gH0uG1TA@mail.gmail.com>
Message-ID: <CAL_JsqJOZRgmyvcb8g18Z_nFTO6uVbMe_=UTFMXqU9gH0uG1TA@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix duplicate resource requests
To:     vtolkm@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        PCI <linux-pci@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

=E2=80=AAOn Fri, Oct 23, 2020 at 4:19 AM =E2=84=A2=D6=9F=E2=98=BB=D2=87=CC=
=AD =D1=BC =D2=89 =C2=AE <vtolkm@googlemail.com> wrote:=E2=80=AC
>
> On 23/10/2020 02:51, Rob Herring wrote:
> > On Thu, Oct 22, 2020 at 5:09 PM Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> >> On Thu, Oct 22, 2020 at 11:05:07PM +0100, Russell King - ARM Linux adm=
in wrote:
> >>>> @@ -1001,9 +995,12 @@ static int mvebu_pcie_parse_request_resources(=
struct mvebu_pcie *pcie)
> >>>>              pcie->realio.name =3D "PCI I/O";
> >>>>
> >>>>              pci_add_resource(&bridge->windows, &pcie->realio);
> >>>> +           ret =3D devm_request_resource(dev, &iomem_resource, &pci=
e->realio);
> >>> I think you're trying to claim this resource against the wrong parent=
.
> >> Fixing this to ioport_resource results in in working PCIe.
> > Copy-n-paste... Thanks for testing.
> >
> > Rob
>
> Run tested the patch with 5.9.1 and it seems fixing the issue, not sure
> about the meaning of "BAR 0: error updating":
>
>
> mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> mvebu-pcie soc:pcie: Parsing ranges property...
> mvebu-pcie soc:pcie: MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> mvebu-pcie soc:pcie: MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> mvebu-pcie soc:pcie: MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> mvebu-pcie soc:pcie: MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> mvebu-pcie soc:pcie: IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus
> address [0x00080000-0x00081fff])
> pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus
> address [0x00040000-0x00041fff])
> pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus
> address [0x00044000-0x00045fff])
> pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus
> address [0x00048000-0x00049fff])
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
> pci_bus 0000:00: scanning bus
> pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
> pci 0000:00:01.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
> pci 0000:00:02.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
> pci 0000:00:03.0: reg 0x38: [mem 0x00000000-0x000007ff pref]
> pci_bus 0000:00: fixups for bus
> pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 0
> pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:00:02.0: scanning [bus 00-00] behind bridge, pass 0
> pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:00:03.0: scanning [bus 00-00] behind bridge, pass 0
> pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguri=
ng
> pci 0000:00:01.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:01: scanning bus
> pci_bus 0000:01: fixups for bus
> pci_bus 0000:01: bus scan returning with max=3D01
> pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
> pci 0000:00:02.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:02: scanning bus
> pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
> pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x001fffff 64bit]
> pci 0000:02:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
> pci 0000:02:00.0: supports D1 D2
> pci 0000:00:02.0: ASPM: current common clock configuration is
> inconsistent, reconfiguring
> pci_bus 0000:02: fixups for bus
> pci_bus 0000:02: bus scan returning with max=3D02
> pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
> pci 0000:00:03.0: scanning [bus 00-00] behind bridge, pass 1
> pci_bus 0000:03: scanning bus
> pci 0000:03:00.0: [168c:002e] type 00 class 0x028000
> pci 0000:03:00.0: reg 0x10: [mem 0x00000000-0x0000ffff 64bit]
> pci 0000:03:00.0: supports D1
> pci 0000:03:00.0: PME# supported from D0 D1 D3hot
> pci 0000:03:00.0: PME# disabled
> pci 0000:00:03.0: ASPM: current common clock configuration is
> inconsistent, reconfiguring
> pci_bus 0000:03: fixups for bus
> pci_bus 0000:03: bus scan returning with max=3D03
> pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
> pci_bus 0000:00: bus scan returning with max=3D03
> pci 0000:00:02.0: BAR 8: assigned [mem 0xe0000000-0xe02fffff]
> pci 0000:00:03.0: BAR 8: assigned [mem 0xe0300000-0xe03fffff]
> pci 0000:00:01.0: BAR 6: assigned [mem 0xe0400000-0xe04007ff pref]
> pci 0000:00:02.0: BAR 6: assigned [mem 0xe0500000-0xe05007ff pref]
> pci 0000:00:03.0: BAR 6: assigned [mem 0xe0600000-0xe06007ff pref]
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:02:00.0: BAR 0: assigned [mem 0xe0000000-0xe01fffff 64bit]
> pci 0000:02:00.0: BAR 0: error updating (0xe0000004 !=3D 0xffffffff)
> pci 0000:02:00.0: BAR 0: error updating (high 0x000000 !=3D 0xffffffff)

Based on the logs in bugzilla, this was introduced between 5.4 and 5.8.

> pci 0000:02:00.0: BAR 6: assigned [mem 0xe0200000-0xe020ffff pref]
> pci 0000:00:02.0: PCI bridge to [bus 02]
> pci 0000:00:02.0: bridge window [mem 0xe0000000-0xe02fffff]
> pci 0000:03:00.0: BAR 0: assigned [mem 0xe0300000-0xe030ffff 64bit]
> pci 0000:03:00.0: BAR 0: error updating (0xe0300004 !=3D 0xffffffff)
> pci 0000:03:00.0: BAR 0: error updating (high 0x000000 !=3D 0xffffffff)
> pci 0000:00:03.0: PCI bridge to [bus 03]
> pci 0000:00:03.0: bridge window [mem 0xe0300000-0xe03fffff]
> pci 0000:00:03.0: enabling device (0140 -> 0142)
> pci 0000:00:03.0: enabling bus mastering
> pci 0000:00:02.0: enabling device (0140 -> 0142)
> pci 0000:00:02.0: enabling bus mastering
>
> ----
>
> Pardon the ignorance, how the further workflow of the patch from
> patchwork, commit to next (5.10) branch and then backport to 5.9?

Once in 5.10-rc, it will be picked up by stable maintainers for all
stable kernels.

Rob
