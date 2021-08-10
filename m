Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082653E8252
	for <lists+linux-pci@lfdr.de>; Tue, 10 Aug 2021 20:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238317AbhHJSGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Aug 2021 14:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239138AbhHJSE4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Aug 2021 14:04:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CA6760F41;
        Tue, 10 Aug 2021 17:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628617969;
        bh=aCHcLfUd5JORnIzw0K39neaXeH5LZeUvwqqXoDMiqTE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N05NqSYp+0krmpbQ10oIBL+BpM+l9TbB7ROO3u0KBenSYZ0Dh9GLC2n7XD6mANVP8
         85DRxV/GCzT4WZsG1x0lmWaWjhE431CoY143LjP/COrb5UaMMsEm3Ve8maUhVbVFos
         2Xjl82dO0V5oph2O46VvQ5cm4AUR6YIBnkBWOZmhIJo33I422zAkTnjWk8/EYxC9Zp
         xqC1hgOVCqhJakT4EXQAkFqaJPhEJzdwp0arYuUllKsUoMVW152RjF6vK3Kkq3gMvx
         RPXXUZo8F0H0odqRb8ihjVCeq08kju9wmWTrJk3MVpTmPHoLHXEfGcaxcc/oPgULVy
         X8KG/sMqkUFkA==
Received: by mail-qk1-f170.google.com with SMTP id n123so2483959qkn.12;
        Tue, 10 Aug 2021 10:52:49 -0700 (PDT)
X-Gm-Message-State: AOAM532vZucHU6V3AZblxYFkGx+jANBO+oyv71glg6pGpKxRTP4iETpw
        6jFewrbGhZyeKirXgBlPC/Qmn/TB5JeSsBVF1w==
X-Google-Smtp-Source: ABdhPJx9VTu3HLdmBB1H+V9JB76L5ymhtNhHvylWLPKK6eF4qmaj99O/mUpPj7F9Vp3STGsdAT2ln3caQqIwTlQEb3I=
X-Received: by 2002:a37:d81:: with SMTP id 123mr24404070qkn.311.1628617968453;
 Tue, 10 Aug 2021 10:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
 <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
 <20210804085045.3dddbb9c@coco.lan> <YQrARd7wgYS1nywt@robh.at.kernel.org>
 <20210805094612.2bc2c78f@coco.lan> <20210805095848.464cf85c@coco.lan>
 <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
 <20210810114211.01df0246@coco.lan> <CAL_JsqKtXoFeJO6_13U+VsSXNGX_1TQvwOyQYRk5JUgBhvQChA@mail.gmail.com>
 <20210810162054.1aa84b84@coco.lan> <CAL_JsqL-R=kTugNAC-C1gfSm6Xnb0Nw_iLcRki8aQMNQjcLN6A@mail.gmail.com>
In-Reply-To: <CAL_JsqL-R=kTugNAC-C1gfSm6Xnb0Nw_iLcRki8aQMNQjcLN6A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 10 Aug 2021 11:52:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKr9csV5fPZxD=kRRB5W6RCjHz0VsP6-nx0RQt8mgVJ5w@mail.gmail.com>
Message-ID: <CAL_JsqKr9csV5fPZxD=kRRB5W6RCjHz0VsP6-nx0RQt8mgVJ5w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to work
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 10, 2021 at 11:13 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Aug 10, 2021 at 8:21 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Tue, 10 Aug 2021 07:44:50 -0600
> > Rob Herring <robh@kernel.org> escreveu:
> >
> > > On Tue, Aug 10, 2021 at 3:42 AM Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:
> > > >
> > > > Em Fri, 6 Aug 2021 10:23:35 -0600
> > > > Rob Herring <robh@kernel.org> escreveu:
> > > >
> > > > > On Thu, Aug 5, 2021 at 1:58 AM Mauro Carvalho Chehab
> > > > > <mchehab+huawei@kernel.org> wrote:
> > > > > >
> > > > > > Em Thu, 5 Aug 2021 09:46:12 +0200
> > > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> > > > > >
> > > > > > > Em Wed, 4 Aug 2021 10:28:53 -0600
> > > > > > > Rob Herring <robh@kernel.org> escreveu:
> > > > > > >
> > > > > > > > On Wed, Aug 04, 2021 at 08:50:45AM +0200, Mauro Carvalho Chehab wrote:
> > > > > > > > > Em Tue, 3 Aug 2021 16:11:42 -0600
> > > > > > > > > Rob Herring <robh+dt@kernel.org> escreveu:
> > > > > > > > >
> > > > > > > > > > On Mon, Aug 2, 2021 at 10:39 PM Mauro Carvalho Chehab
> > > > > > > > > > <mchehab+huawei@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Hi Rob,
> > > > > > > > > > >
> > > > > > > > > > > That's the third version of the DT bindings for Kirin 970 PCIE and its
> > > > > > > > > > > corresponding PHY.
> > > > > > > > > > >
> > > > > > > > > > > It is identical to v2, except by:
> > > > > > > > > > >         -          pcie@7,0 { // Lane 7: Ethernet
> > > > > > > > > > >         +          pcie@7,0 { // Lane 6: Ethernet
> > > > > > > > > >
> > > > > > > > > > Can you check whether you have DT node links in sysfs for the PCI
> > > > > > > > > > devices? If you don't, then something is wrong still in the topology
> > > > > > > > > > or the PCI core is failing to set the DT node pointer in struct
> > > > > > > > > > device. Though you don't rely on that currently, we want the topology
> > > > > > > > > > to match. It's possible this never worked on arm/arm64 as mainly
> > > > > > > > > > powerpc relied on this.
> > > > > > > > > >
> > > > > > > > > > I'd like some way to validate the DT matches the PCI topology. We
> > > > > > > > > > could have a tool that generates the DT structure based on the PCI
> > > > > > > > > > topology.
> > > > > > > > >
> > > > > > > > > The of_node node link is on those places:
> > > > > > > > >
> > > > > > > > >   $ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> > > > > > > > >   /sys/devices/platform/soc/f4000000.pcie/of_node
> > > > > > > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> > > > > > > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> > > > > > > > >   /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node
> > > > > > > >
> > > > > > > > Looks like we're missing some...
> > > > > > > >
> > > > > > > > It's not immediately obvious to me what's wrong here. Only the root
> > > > > > > > bus is getting it's DT node set. The relevant code is pci_scan_device(),
> > > > > > > > pci_set_of_node() and pci_set_bus_of_node(). Give me a few days to try
> > > > > > > > to reproduce and debug it.
> > > > > > >
> > > > > > > I added a printk on both pci_set_*of_node() functions:
> > > > > > >
> > > > > > >       [    4.872991]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> > > > > > >       [    4.913806]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000
> > > > > > >       [    4.978102] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > > > >       [    4.990622]  (null): pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > > > >       [    5.052383] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
> > > > > > >       [    5.059263]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.085552]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.112073]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.138320]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.164673]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.233759] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
> > > > > > >       [    5.240539]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.310545] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
> > > > > > >       [    5.324719] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
> > > > > > >       [    5.338914] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
> > > > > > >       [    5.345516]  (null): pci_set_of_node: of_node: (null)
> > > > > > >       [    5.415795] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)
> > > > > >
> > > > > > The enclosed patch makes the above a clearer:
> > > > > >
> > > > > >         [    4.800975]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> > > > > >         [    4.855983] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
> > > > > >         [    4.879169] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > > >         [    4.900602] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > > >         [    4.953086] pci_bus 0000:02: pci_set_bus_of_node: of_node: (null)
> > > > >
> > > > > I believe the issue is we need another bridge node in the DT
> > > > > hierarchy. What we have is:
> > > > >
> > > > > Bus 0 is node /soc/pcie@f4000000
> > > > > Bus 1 is device 0 on bus 0 is node /soc/pcie@f4000000/pcie@0,0
> > > > > Bus 2 is device 0 on bus 1 in node ... whoops, there's no device 0
> > > > > under /soc/pcie@f4000000/pcie@0,0
> > > > >
> > > > > So we need the hierarchy to be: /soc/pcie@f4000000/pcie@0/pcie@0/pcie@{1,5,7}
> > > >
> > > > Adding a child pcie@0 produces the following output from my debug
> > > > patches:
> > >
> > > You removed your changes to the PCI code other than the debug print?
> >
> > Yes.
> >
> > > >
> > > > [    4.984278]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
> > > > [    5.042992] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
> > > > [    5.083738] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > [    5.124377] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
> > > > [    5.168395] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > > > [    5.200719] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > >
> > > This should not happen. The devfn doesn't match.
> > >
> > > > [    5.247777] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > > > [    5.276768] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > > > [    5.305018] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > > > [    5.333093] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
> > > > [    5.395620] pci_bus 0000:03: pci_set_bus_of_node: of_node: (null)
> > > > [    5.416333] pci 0000:03:00.0: pci_set_of_node: of_node: (null)
> > > > [    5.451353] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
> > > > [    5.473970] pci_bus 0000:05: pci_set_bus_of_node: of_node: (null)
> > > > [    5.487765] pci_bus 0000:06: pci_set_bus_of_node: of_node: (null)
> > > > [    5.530219] pci 0000:06:00.0: pci_set_of_node: of_node: (null)
> > > > [    5.560896] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)
> > > >
> > > > It produces the following sysfs nodes:
> > > >
> > > >         $ find /sys/devices/platform/soc/f4000000.pcie/ -name of_node
> > > >         /sys/devices/platform/soc/f4000000.pcie/of_node
> > > >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/of_node
> > > >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/of_node
> > > >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/0000:01:00.0/pci_bus/0000:02/of_node
> > > >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/0000:00:00.0/pci_bus/0000:01/of_node
> > > >         /sys/devices/platform/soc/f4000000.pcie/pci0000:00/pci_bus/0000:00/of_node
> > > >
> > > >
> > > > I'm enclosing the DT schema I'm using.
> > > >
> > > >
> > > >
> > > > Thanks,
> > > > Mauro
> > > >
> > > > ---
> > > >
> > > >                 pcie@f4000000 {
> > > >                         compatible = "hisilicon,kirin970-pcie";
> > > >                         reg = <0x0 0xf4000000 0x0 0x1000000>,
> > > >                               <0x0 0xfc180000 0x0 0x1000>,
> > > >                               <0x0 0xf5000000 0x0 0x2000>;
> > > >                         reg-names = "dbi", "apb", "config";
> > > >                         bus-range = <0x00 0xff>;
> > > >                         #address-cells = <3>;
> > > >                         #size-cells = <2>;
> > > >                         device_type = "pci";
> > > >                         phys = <&pcie_phy>;
> > > >                         ranges = <0x02000000 0x0 0x00000000
> > > >                                   0x0 0xf6000000
> > > >                                   0x0 0x02000000>;
> > > >                         num-lanes = <1>;
> > > >                         #interrupt-cells = <1>;
> > > >                         interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> > > >                         interrupt-names = "msi";
> > > >                         interrupt-map-mask = <0 0 0 7>;
> > > >                         interrupt-map = <0x0 0 0 1
> > > >                                          &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> > > >                                         <0x0 0 0 2
> > > >                                          &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> > > >                                         <0x0 0 0 3
> > > >                                          &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> > > >                                         <0x0 0 0 4
> > > >                                          &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> > > >                         reset-gpios = <&gpio7 0 0>;
> > > >                         hisilicon,clken-gpios = <&gpio27 3 0>, <&gpio17 0 0>,
> > > >                                                 <&gpio20 6 0>;
> > > >                         pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
> > > >                                 reg = <0x80 0 0 0 0>;
> > >
> > > s/0x80/0/
> > >
> > > >                                 compatible = "pciclass,0604";
> > > >                                 device_type = "pci";
> > > >                                 #address-cells = <3>;
> > > >                                 #size-cells = <2>;
> > > >                                 ranges;
> > > >                                 bus-range = <0x01 0xff>;
> > > >                                 msi-parent = <&its_pcie>;
> > > >
> > > >                                 pcie@0,0 { // Lane 0: upstream
> > > >                                         reg = <0x010000 0 0 0 0>;
> > >
> > > While technically correct having the bus# in the address, that doesn't
> > > work for FDT since we don't know the bus assignment. So we should just
> > > use 0.
> >
> > Using 0 causes DTB compilation to produce a warning, due to the
> > bus-range.

What's the warning? 'bus-range' should be optional.

> > Without the bus-range, there will be runtime warnings,
> > as this will be assigned as bus 1.
>
> Okay, that might be something we need to fix.

Actually, I don't see how there's a problem. First, the only place we
read 'bus-range' is of_pci_parse_bus_range() and that's only called
for the host bridge. Any other occurrence of 'bus-range' should be
ignored. The only place we read 'reg' is of_pci_get_devfn() and we
mask just the devfn bits.

>            [    4.992572] pci_bus 0000:00: root bus resource [bus 00-01]

I don't see any way this can happen other than pcie@f4000000 node
containing 'bus-range = <0 1>;'. It comes from
pci_host_bridge.windows.

Rob
