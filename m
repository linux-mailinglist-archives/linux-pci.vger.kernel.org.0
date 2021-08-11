Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164693E8AD7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 09:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbhHKHLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 03:11:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235440AbhHKHLq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Aug 2021 03:11:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3130360EE2;
        Wed, 11 Aug 2021 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628665880;
        bh=EVbsI4fhrFB4IvjQ0v5yd/Um+sEgvjmFm320FTAuwvY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=teLwpVm+SMKy2J46UduWEy4L1Y9Upce+tpb3pfdM+K6WJbCbJvn3RJbp06tQQ3+Vz
         Ir12vnTDJdpEpASUq8KwfFNbNyK6Bt0xlL22glT3I3UNe24d3tAbzOu3aiOTzqpvEJ
         Sx1A0qq98f2+00ByhjZxtJBLdyUw7W6R3je1bRIy/CkHDQXN0SlRwwu8FumzttEwxA
         LpQaqr7HKMdAVUOx7PqxjtmQ+gxjQmaQ6BU/UIy1q4Eu5teykIdrJa9wy1M8YCzGiA
         qRJd7uEEI9/VI83nwNVXGHZdjuENi4VaLBV3964DscBbJCZOeOJmNGz55Sv4d15WTd
         EyOSR4B3DePAg==
Date:   Wed, 11 Aug 2021 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/4] DT schema changes for HiKey970 PCIe hardware to
 work
Message-ID: <20210811091115.03b36daa@coco.lan>
In-Reply-To: <CAL_JsqKr9csV5fPZxD=kRRB5W6RCjHz0VsP6-nx0RQt8mgVJ5w@mail.gmail.com>
References: <cover.1627965261.git.mchehab+huawei@kernel.org>
        <CAL_JsqLjw=+szXWJjGe86tMc51NA-5j=jVSXUAWuKeZRuJNJUg@mail.gmail.com>
        <20210804085045.3dddbb9c@coco.lan>
        <YQrARd7wgYS1nywt@robh.at.kernel.org>
        <20210805094612.2bc2c78f@coco.lan>
        <20210805095848.464cf85c@coco.lan>
        <CAL_JsqKso=z8LG3ViaggyS1k+1T2F5aAhP3_RNhumQoUUD+bbg@mail.gmail.com>
        <20210810114211.01df0246@coco.lan>
        <CAL_JsqKtXoFeJO6_13U+VsSXNGX_1TQvwOyQYRk5JUgBhvQChA@mail.gmail.com>
        <20210810162054.1aa84b84@coco.lan>
        <CAL_JsqL-R=kTugNAC-C1gfSm6Xnb0Nw_iLcRki8aQMNQjcLN6A@mail.gmail.com>
        <CAL_JsqKr9csV5fPZxD=kRRB5W6RCjHz0VsP6-nx0RQt8mgVJ5w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 10 Aug 2021 11:52:34 -0600
Rob Herring <robh@kernel.org> escreveu:

> > > > >                         pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
> > > > >                                 reg = <0x80 0 0 0 0>;  
> > > >
> > > > s/0x80/0/
> > > >  
> > > > >                                 compatible = "pciclass,0604";
> > > > >                                 device_type = "pci";
> > > > >                                 #address-cells = <3>;
> > > > >                                 #size-cells = <2>;
> > > > >                                 ranges;
> > > > >                                 bus-range = <0x01 0xff>;
> > > > >                                 msi-parent = <&its_pcie>;
> > > > >
> > > > >                                 pcie@0,0 { // Lane 0: upstream
> > > > >                                         reg = <0x010000 0 0 0 0>;  
> > > >
> > > > While technically correct having the bus# in the address, that doesn't
> > > > work for FDT since we don't know the bus assignment. So we should just
> > > > use 0.  
> > >
> > > Using 0 causes DTB compilation to produce a warning, due to the
> > > bus-range.  
> 
> What's the warning? 'bus-range' should be optional.

With this DT schema (simplified to show only relevant bits):

		pcie@f4000000 {
			bus-range = <0x00 0xff>;
			pcie@0,0 { // Lane 0: PCIe switch: Bus 1, Device 0
				bus-range = <0x01 0xff>;
				pcie@0,0 { // Lane 0: upstream
					reg = <0x0000 0 0 0 0>;
					pcie@1,0 { // Lane 4: M.2
						reg = <0x0800 0 0 0 0>;
					};

					pcie@5,0 { // Lane 5: Mini PCIe
						reg = <0x2800 0 0 0 0>;
					};

					pcie@7,0 { // Lane 6: Ethernet
						reg = <0x3800 0 0 0 0>;
					};
				};
			};
		};


This is the compilation warning:
	$ make dtbs
	arch/arm64/boot/dts/hisilicon/hi3670.dtsi:735.5-29: Warning (pci_device_bus_num): /soc/pcie@f4000000/pcie@0,0/pcie@0,0:bus-range: PCI bus number 0 out of range, expected (1 - 1)

This is solved by changing:
				pcie@0,0 { // Lane 0: upstream
					reg = <0x0000 0 0 0 0>;
to:
				pcie@0,0 { // Lane 0: upstream
					reg = <0x010000 0 0 0 0>;



> 
> > > Without the bus-range, there will be runtime warnings,
> > > as this will be assigned as bus 1.  
> >
> > Okay, that might be something we need to fix.  
> 
> Actually, I don't see how there's a problem. First, the only place we
> read 'bus-range' is of_pci_parse_bus_range() and that's only called
> for the host bridge. Any other occurrence of 'bus-range' should be
> ignored. The only place we read 'reg' is of_pci_get_devfn() and we
> mask just the devfn bits.
> 
> >            [    4.992572] pci_bus 0000:00: root bus resource [bus 00-01]  
> 
> I don't see any way this can happen other than pcie@f4000000 node
> containing 'bus-range = <0 1>;'. It comes from
> pci_host_bridge.windows.

Yeah, you're right. On the first versions, 'bus-range = <0 1>;' was used,
just like:
	arch/arm64/boot/dts/hisilicon/hi3660.dtsi

(I have a fixup patch fixing the warning on Kirin 960 due to that)

Ok, I did another test here: if I drop both dma-range, it will output:

	[    3.778028] kirin-pcie f4000000.pcie:   No bus range found for /soc/pcie@f4000000, using [bus 00-ff]

But no conflict warnings. So, I guess dropping bus-range and the explicit
bus 1 setting at "reg" is a clean approach.

As a reference, this is the dmesg log here (with OF debug turned on):

# dmesg|grep -i pci
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.14.0-rc1+ root=UUID=646147e1-d186-44cc-b0d2-60c42f8dcc6d ro drm.debug=0x6 earlycon=pl011,0xfff32000,115200 console=tty0 console=ttyAMA6,115200n8 root=/dev/sdd12 rootwait rw quiet efi=noruntime drm.debug=0x06 "dyndbg=file drivers/pci/of.c +p;  drivers/gpu/* +p; file drivers/pci/of.c +p;  drivers/spmi/* +p; file drivers/pci/of.c +p;  drivers/mfd/* +p; file drivers/pci/of.c +p;  drivers/regulator/* +p; file drivers/pci/of.c +p;  drivers/usb/core/hub.c +p" no_console_suspend loglevel=9 kernel.panic=5
[    0.000000] Unknown command line parameters: BOOT_IMAGE=/boot/vmlinuz-5.14.0-rc1+ dyndbg=file drivers/pci/of.c +p;  drivers/gpu/* +p; file drivers/pci/of.c +p;  drivers/spmi/* +p; file drivers/pci/of.c +p;  drivers/mfd/* +p; file drivers/pci/of.c +p;  drivers/regulator/* +p; file drivers/pci/of.c +p;  drivers/usb/core/hub.c +p
[    0.725101] PCI: CLS 0 bytes, default 64
[    1.520828] ehci-pci: EHCI PCI platform driver
[    1.521022] ohci-pci: OHCI PCI platform driver
[    2.204793]     dyndbg=file drivers/pci/of.c +p;  drivers/gpu/* +p; file drivers/pci/of.c +p;  drivers/spmi/* +p; file drivers/pci/of.c +p;  drivers/mfd/* +p; file drivers/pci/of.c +p;  drivers/regulator/* +p; file drivers/pci/of.c +p;  drivers/usb/core/hub.c +p
[    3.767252] kirin-pcie f4000000.pcie: host bridge /soc/pcie@f4000000 ranges:
[    3.778028] kirin-pcie f4000000.pcie:   No bus range found for /soc/pcie@f4000000, using [bus 00-ff]
[    3.792466] kirin-pcie f4000000.pcie: Parsing ranges property...
[    3.801919] kirin-pcie f4000000.pcie:      MEM 0x00f6000000..0x00f7ffffff -> 0x0000000000
[    3.813680] kirin-pcie f4000000.pcie: invalid resource
[    3.822189] kirin-pcie f4000000.pcie: iATU unroll: enabled
[    3.831159] kirin-pcie f4000000.pcie: Detected iATU regions: 8 outbound, 8 inbound
[    3.943155] kirin-pcie f4000000.pcie: Link up
[    3.956821]  (null): pci_set_bus_of_node: of_node: /soc/pcie@f4000000
[    3.979143] kirin-pcie f4000000.pcie: PCI host bridge to bus 0000:00
[    3.989441] pci_bus 0000:00: root bus resource [bus 00-ff]
[    3.998050] pci_bus 0000:00: root bus resource [mem 0xf6000000-0xf7ffffff] (bus address [0x00000000-0x01ffffff])
[    4.011965] pci 0000:00:00.0: [19e5:3670] type 01 class 0x060400
[    4.021177] pci 0000:00:00.0: reg 0x10: [mem 0xf6000000-0xf6ffffff]
[    4.031041] pci 0000:00:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000
[    4.041362] pci 0000:00:00.0: supports D1 D2
[    4.049191] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot
[    4.059554] pci_bus 0000:01: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
[    4.071133] pci 0000:01:00.0: [10b5:8606] type 01 class 0x060400
[    4.080831] pci 0000:01:00.0: reg 0x10: [mem 0xf6000000-0xf601ffff]
[    4.103511] pci 0000:01:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0
[    4.115403] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    4.139816] pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.157297] pci_bus 0000:02: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
[    4.172380] pci 0000:02:01.0: [10b5:8606] type 01 class 0x060400
[    4.182279] pci 0000:02:01.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
[    4.197047] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[    4.207583] pci 0000:02:04.0: [10b5:8606] type 01 class 0x060400
[    4.217659] pci 0000:02:04.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
[    4.234551] pci 0000:02:04.0: PME# supported from D0 D3hot D3cold
[    4.254284] pci 0000:02:05.0: [10b5:8606] type 01 class 0x060400
[    4.267668] pci 0000:02:05.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
[    4.282530] pci 0000:02:05.0: PME# supported from D0 D3hot D3cold
[    4.295077] pci 0000:02:07.0: [10b5:8606] type 01 class 0x060400
[    4.306032] pci 0000:02:07.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
[    4.320927] pci 0000:02:07.0: PME# supported from D0 D3hot D3cold
[    4.333414] pci 0000:02:09.0: [10b5:8606] type 01 class 0x060400
[    4.340439] pci 0000:02:09.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0
[    4.350084] pci 0000:02:09.0: PME# supported from D0 D3hot D3cold
[    4.358150] pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.366379] pci 0000:02:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.374515] pci 0000:02:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.382682] pci 0000:02:07.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.390834] pci 0000:02:09.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    4.399079] pci_bus 0000:03: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
[    4.409309] pci 0000:03:00.0: [144d:a809] type 00 class 0x010802
[    4.415564] pci 0000:03:00.0: reg 0x10: [mem 0xf6000000-0xf6003fff 64bit]
[    4.422769] pci 0000:03:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0
[    4.433782] pci 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    4.449954] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    4.456836] pci_bus 0000:04: pci_set_bus_of_node: of_node: (null)
[    4.457918] pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
[    4.478895] pci_bus 0000:05: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0
[    4.491772] pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
[    4.503438] pci_bus 0000:06: pci_set_bus_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
[    4.529140] pci 0000:06:00.0: [10ec:8168] type 00 class 0x020000
[    4.535374] pci 0000:06:00.0: reg 0x10: [io  0x0000-0x00ff]
[    4.541229] pci 0000:06:00.0: reg 0x18: [mem 0xf7000000-0xf7000fff 64bit]
[    4.548194] pci 0000:06:00.0: reg 0x20: [mem 0xf7200000-0xf7203fff 64bit pref]
[    4.561063] pci 0000:06:00.0: pci_set_of_node: of_node: /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0
[    4.582075] pci 0000:06:00.0: supports D1 D2
[    4.586357] pci 0000:06:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    4.594727] pci_bus 0000:06: busn_res: [bus 06-ff] end is updated to 06
[    4.601538] pci_bus 0000:07: pci_set_bus_of_node: of_node: (null)
[    4.608473] pci_bus 0000:07: busn_res: [bus 07-ff] end is updated to 07
[    4.615124] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 07
[    4.621810] pci 0000:00:00.0: BAR 0: assigned [mem 0xf6000000-0xf6ffffff]
[    4.628606] pci 0000:00:00.0: BAR 14: assigned [mem 0xf7000000-0xf72fffff]
[    4.628610] pci 0000:00:00.0: BAR 15: assigned [mem 0xf7300000-0xf73fffff pref]
[    4.642813] pci 0000:00:00.0: BAR 13: no space for [io  size 0x1000]
[    4.649174] pci 0000:00:00.0: BAR 13: failed to assign [io  size 0x1000]
[    4.661518] pci 0000:01:00.0: BAR 14: assigned [mem 0xf7000000-0xf71fffff]
[    4.669074] pci 0000:01:00.0: BAR 15: assigned [mem 0xf7300000-0xf73fffff 64bit pref]
[    4.677066] pci 0000:01:00.0: BAR 0: assigned [mem 0xf7200000-0xf721ffff]
[    4.683891] pci 0000:01:00.0: BAR 13: no space for [io  size 0x1000]
[    4.690252] pci 0000:01:00.0: BAR 13: failed to assign [io  size 0x1000]
[    4.690266] pci 0000:02:01.0: BAR 14: assigned [mem 0xf7000000-0xf70fffff]
[    4.690270] pci 0000:02:07.0: BAR 14: assigned [mem 0xf7100000-0xf71fffff]
[    4.710728] pci 0000:02:07.0: BAR 15: assigned [mem 0xf7300000-0xf73fffff 64bit pref]
[    4.727780] pci 0000:02:07.0: BAR 13: no space for [io  size 0x1000]
[    4.727783] pci 0000:02:07.0: BAR 13: failed to assign [io  size 0x1000]
[    4.727790] pci 0000:03:00.0: BAR 0: assigned [mem 0xf7000000-0xf7003fff 64bit]
[    4.727904] pci 0000:02:01.0: PCI bridge to [bus 03]
[    4.753165] pci 0000:02:01.0:   bridge window [mem 0xf7000000-0xf70fffff]
[    4.769738] pci 0000:02:04.0: PCI bridge to [bus 04]
[    4.774843] pci 0000:02:05.0: PCI bridge to [bus 05]
[    4.779959] pci 0000:06:00.0: BAR 4: assigned [mem 0xf7300000-0xf7303fff 64bit pref]
[    4.787839] pci 0000:06:00.0: BAR 2: assigned [mem 0xf7100000-0xf7100fff 64bit]
[    4.795273] pci 0000:06:00.0: BAR 0: no space for [io  size 0x0100]
[    4.801543] pci 0000:06:00.0: BAR 0: failed to assign [io  size 0x0100]
[    4.808159] pci 0000:02:07.0: PCI bridge to [bus 06]
[    4.813166] pci 0000:02:07.0:   bridge window [mem 0xf7100000-0xf71fffff]
[    4.819981] pci 0000:02:07.0:   bridge window [mem 0xf7300000-0xf73fffff 64bit pref]
[    4.827782] pci 0000:02:09.0: PCI bridge to [bus 07]
[    4.832871] pci 0000:01:00.0: PCI bridge to [bus 02-07]
[    4.838138] pci 0000:01:00.0:   bridge window [mem 0xf7000000-0xf71fffff]
[    4.844952] pci 0000:01:00.0:   bridge window [mem 0xf7300000-0xf73fffff 64bit pref]
[    4.852751] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    4.857980] pci 0000:00:00.0:   bridge window [mem 0xf7000000-0xf72fffff]
[    4.864770] pci 0000:00:00.0:   bridge window [mem 0xf7300000-0xf73fffff pref]
[    4.881547] pcieport 0000:00:00.0: PME: Signaling with IRQ 58
[    4.888905] pcieport 0000:00:00.0: AER: enabled with IRQ 58
[    4.895013] pcieport 0000:01:00.0: enabling device (0000 -> 0002)
[    4.903260] pcieport 0000:02:01.0: enabling device (0000 -> 0002)
[    4.914761] pcieport 0000:02:07.0: enabling device (0000 -> 0002)
[    4.928984] nvme nvme0: pci function 0000:03:00.0

Thanks,
Mauro
