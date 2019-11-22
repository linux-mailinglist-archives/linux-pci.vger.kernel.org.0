Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EA51073E3
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 15:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfKVOL4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 09:11:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35824 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfKVOLz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 09:11:55 -0500
Received: by mail-qk1-f193.google.com with SMTP id i19so6392953qki.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 06:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8+p1jvH6TLCf1lrXLF4YAwGOCqiAFIhS+JPaXil09w=;
        b=mGgh4lk7Q2NmXguqTtgrqx+O1xoOYOyO/mXEEfMajG4f03bIZn46AMw4mkJsVZWzmE
         oT0jYxdwLfqPVf+LYXyuNkn5uB+GYB8fpM3Wvr6l0TuqC1MfC3lxfCQ46rKIggGZXrOK
         5EPrEQGRehVEfuJ/bRfH6B6+LWrmG4p2oOWafcHmZKD3+BxHvFPY3EuOuPCBW+t4R/3n
         hGsWIx2CJtd2iMZMRzIAwMf0un6vzNxUAVB0TNYJcFcDJSQ3J/bh4eL9IXSeUXkgAcsQ
         XatMFO8i4PoFwQE1CZBvNzzTb8H89n87XNzxqHJEb3fmtKu19icRYtqMT3YN/ZuFQpg3
         yBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8+p1jvH6TLCf1lrXLF4YAwGOCqiAFIhS+JPaXil09w=;
        b=oYKtIOWDZy4/R2uNWeOkTV6nT1PNtnTdOYo8xlaKGARGf0seRPG4eW5kiAo0G6VHcG
         f6myFdz+WvCJNAvju54n7iTS/0z8RD1i7ZlZTKxrKMqyAu2onjXU6ke6j4RNwaQ46DQc
         DFrkdvVlfD/wnHh3TINE+XsvDYIoWk3AYrBWZx+J2g8GFACDyT0o3c1/ug+avoTn2AwJ
         Pl+lM2FZohZp+HUoDvKInjn8zdULNAVV5qPI/BQy4/jmijjrms+I88WmFIk8ydZoe5pN
         DrNhYAAJ5mr0ZZTKnAceSCxTzta6RT2KG2I7dXErodyVdlQHualN9CC94qYaejelo16g
         qkyA==
X-Gm-Message-State: APjAAAUbPMA1co50Ml5laGVbpaWyJRUJOXt6gU0P+AzY5xycDKOGUs7y
        MKh/HejoDYen01r87FYCWCH13dxH0mcQfY1CIWw=
X-Google-Smtp-Source: APXvYqyOT5o04hKglebk/8D1Wl+csA9LZcN2WlacKUJAawJuXA1DuBmWn0akKUW5gujAHxYgYhqq3Ef4mNx8+B0S9K4=
X-Received: by 2002:a37:6c01:: with SMTP id h1mr3298735qkc.484.1574431913113;
 Fri, 22 Nov 2019 06:11:53 -0800 (PST)
MIME-Version: 1.0
References: <CAMdYzYp7kQdMKzX2RQW0tY2P4Um=CNJW93RPquBmYATRGrxwng@mail.gmail.com>
 <20191112022938.GA89741@google.com> <CAMdYzYrYHtiEXwiKxwWcKSV7Re6dG4zTvkKtZxvso+fLBRYbPQ@mail.gmail.com>
 <991e386e-4c4f-fcbd-89a1-1edd82f63ece@arm.com> <CAMdYzYri-yroFtvVXdNZH=sNOM7RP_PBHVnmbHuAKmGBZ0GifA@mail.gmail.com>
 <CAMdYzYrc-AJNpnqR6Xw9Np0wuUvS4-u+TCS2WEo78TfyEhCQKg@mail.gmail.com>
 <CAMdYzYow8SuXb_8ow433O_+Wezxb-U08WDUiLxcTKh+1_zBzkQ@mail.gmail.com>
 <CAMdYzYphu1vHEprfry52+vH9Hjp3ZddgY5hk4Xqk2b3v=DU80g@mail.gmail.com>
 <2a381384-9d47-a7e2-679c-780950cd862d@rock-chips.com> <CAMdYzYowLb-FRUxP_TC+4LFwYdvszq+mBvfXBiDTCqtbF0x5xg@mail.gmail.com>
In-Reply-To: <CAMdYzYowLb-FRUxP_TC+4LFwYdvszq+mBvfXBiDTCqtbF0x5xg@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 22 Nov 2019 09:11:21 -0500
Message-ID: <CAMdYzYqn3L7x-vc+_K6jG0EVTiPGbz8pQ-N1Q1mRbcVXE822Yg@mail.gmail.com>
Subject: Re: [BUG] rk3399-rockpro64 pcie synchronous external abort
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 21, 2019 at 8:02 PM Peter Geis <pgwipeout@gmail.com> wrote:
>
> On Wed, Nov 20, 2019 at 9:05 PM Shawn Lin <shawn.lin@rock-chips.com> wrote:
> >
> <snip>
> >
> > Not having too much time to follow up w/ upstream development, sorry.
> > I attach a patch based on Linux-next for debugging, but I don't know if
> > it could work as expected since I can't test it now. But at least it
> > shows what the problems were.
>
> Well it is certainly hideous, and does not compile cleanly (built-in
> complains, module is broken), but it finished scanning all buses.
> I'll do some more serious testing and get back to you with more results.
> Thanks!

As promised, here is the results of this patch:
# lspci
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
Express Root Port
01:00.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
02:01.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
02:03.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
02:05.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
02:07.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
04:00.0 VGA compatible controller: NVIDIA Corporation GK106 [GeForce
GTX 645 OEM] (rev a1)
04:00.1 Audio device: NVIDIA Corporation GK106 HDMI Audio Controller (rev a1)
06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9123 PCIe
SATA 6.0 Gb/s controller (rev 11)
06:00.1 IDE interface: Marvell Technology Group Ltd. 88SE912x IDE
Controller (rev 11)

# lspci -t
-[0000:00]---00.0-[01-06]----00.0-[02-06]--+-01.0-[03]--
                                           +-03.0-[04]--+-00.0
                                           |            \-00.1
                                           +-05.0-[05]--
                                           \-07.0-[06]--+-00.0
                                                        \-00.1

# lspci -v
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI
Express Root Port (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 228
        Bus: primary=00, secondary=01, subordinate=06, sec-latency=0
        I/O behind bridge: 00000000-00000fff [size=4K]
        Memory behind bridge: None
        Prefetchable memory behind bridge: 00000000-000fffff [size=1M]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit+
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
        Capabilities: [c0] Express Root Port (Slot+), MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [274] Transaction Processing Hints
        Kernel driver in use: pcieport

01:00.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 229
        Bus: primary=01, secondary=02, subordinate=06, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Upstream Port, MSI 00
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100] Virtual Channel
        Capabilities: [200] Advanced Error Reporting
        Capabilities: [300] Vendor Specific Information: ID=0000 Rev=0
Len=c00 <?>
        Kernel driver in use: pcieport

02:01.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 231
        Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Downstream Port (Slot+), MSI 00
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100] Virtual Channel
        Capabilities: [200] Advanced Error Reporting
        Kernel driver in use: pcieport

02:03.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 233
        Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Downstream Port (Slot+), MSI 00
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100] Virtual Channel
        Capabilities: [200] Advanced Error Reporting
        Kernel driver in use: pcieport

02:05.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 234
        Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Downstream Port (Slot+), MSI 00
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100] Virtual Channel
        Capabilities: [200] Advanced Error Reporting
        Kernel driver in use: pcieport

02:07.0 PCI bridge: ASMedia Technology Inc. ASM1184e PCIe Switch Port
(prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 235
        Bus: primary=02, secondary=06, subordinate=06, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: None
        Prefetchable memory behind bridge: None
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [78] Power Management version 3
        Capabilities: [80] Express Downstream Port (Slot+), MSI 00
        Capabilities: [c0] Subsystem: ASMedia Technology Inc. ASM1184e
PCIe Switch Port
        Capabilities: [100] Virtual Channel
        Capabilities: [200] Advanced Error Reporting
        Kernel driver in use: pcieport

04:00.0 VGA compatible controller: NVIDIA Corporation GK106 [GeForce
GTX 645 OEM] (rev a1) (prog-if 00 [VGA controller])
        Subsystem: Pegatron GK106 [GeForce GTX 645 OEM]
        Flags: fast devsel, IRQ 232
        Memory at <unassigned> (64-bit, prefetchable) [disabled]
        Memory at <unassigned> (64-bit, prefetchable) [disabled]
        I/O ports at <unassigned> [disabled]
        Capabilities: [60] Power Management version 3
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Express Endpoint, MSI 00
        Capabilities: [b4] Vendor Specific Information: Len=14 <?>
        Capabilities: [100] Virtual Channel
        Capabilities: [128] Power Budgeting <?>
        Capabilities: [600] Vendor Specific Information: ID=0001 Rev=1
Len=024 <?>
        Capabilities: [900] Secondary PCI Express <?>
        Kernel modules: nouveau

04:00.1 Audio device: NVIDIA Corporation GK106 HDMI Audio Controller (rev a1)
        Subsystem: Pegatron GK106 HDMI Audio Controller
        Flags: fast devsel
        Capabilities: [60] Power Management version 3
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [78] Express Endpoint, MSI 00

06:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9123 PCIe
SATA 6.0 Gb/s controller (rev 11) (prog-if 01 [AHCI 1.0])
        Subsystem: Marvell Technology Group Ltd. 88SE9123 PCIe SATA
6.0 Gb/s controller
        Flags: fast devsel, IRQ 232
        I/O ports at 0000
        I/O ports at 0000
        I/O ports at 0000
        I/O ports at 0000
        I/O ports at 0000
        Memory at <ignored> (32-bit, non-prefetchable)
        Expansion ROM at <ignored> [disabled]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
        Capabilities: [70] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting

06:00.1 IDE interface: Marvell Technology Group Ltd. 88SE912x IDE
Controller (rev 11) (prog-if 8f [PCI native mode controller, supports
both channels switched to ISA compatibility mode, supports bus
mastering])
        Subsystem: Marvell Technology Group Ltd. 88SE912x IDE Controller
        Flags: fast devsel
        I/O ports at 0000
        I/O ports at 0000
        I/O ports at 0000
        I/O ports at 0000
        I/O ports at 0000
        Memory at <ignored> (32-bit, non-prefetchable)
        Expansion ROM at <unassigned>
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit-
        Capabilities: [70] Express Legacy Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting

dmesg:
[   52.602805] rockchip-pcie f8000000.pcie: missing legacy phy; search
for per-lane PHY
[   52.633171] rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
[   52.636853] rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
[   52.665513] rockchip-pcie f8000000.pcie: current link width is x1
[   52.667675] rockchip-pcie f8000000.pcie: idling lane 1
[   52.670208] rockchip-pcie f8000000.pcie: idling lane 2
[   52.673324] rockchip-pcie f8000000.pcie: idling lane 3
[   52.678183] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
[   52.681530] rockchip-pcie f8000000.pcie: Parsing ranges property...
[   52.685148] rockchip-pcie f8000000.pcie:   MEM
0xfa000000..0xfbdfffff -> 0xfa000000
[   52.688901] rockchip-pcie f8000000.pcie:    IO
0xfbe00000..0xfbffffff -> 0xfbe00000
[   52.702615] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
[   52.705800] pci_bus 0000:00: root bus resource [bus 00-1f]
[   52.707798] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
[   52.710864] pci_bus 0000:00: root bus resource [io
0x0000-0x1fffff] (bus address [0xfbe00000-0xfbffffff])
[   52.714658] pci_bus 0000:00: scanning bus
[   52.717990] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
[   52.724951] pci 0000:00:00.0: supports D1
[   52.726604] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[   52.729216] pci 0000:00:00.0: PME# disabled
[   52.981495] pci_bus 0000:00: fixups for bus
[   52.983383] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[   52.986165] pci 0000:00:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   52.989673] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[   52.998243] pci_bus 0000:01: scanning bus
[   53.001836] pci 0000:01:00.0: [1b21:1184] type 01 class 0x060400
[   53.007401] pci 0000:01:00.0: Max Payload Size set to 256 (was 128, max 256)
[   53.010465] pci 0000:01:00.0: enabling Extended Tags
[   53.017344] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[   53.019592] pci 0000:01:00.0: PME# disabled
[   53.024976] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[   53.041892] rockchip-pcie f8000000.pcie: phy link changes
[   53.271553] pci_bus 0000:01: fixups for bus
[   53.274158] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
[   53.276941] pci 0000:01:00.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   53.279910] pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
[   53.290186] pci_bus 0000:02: scanning bus
[   53.291820] do_rockchip_pcie_serror:hey!
[   53.293905] do_rockchip_pcie_serror:hey!
[   53.305314] pci 0000:02:01.0: [1b21:1184] type 01 class 0x060400
[   53.310885] pci 0000:02:01.0: Max Payload Size set to 256 (was 128, max 256)
[   53.313851] pci 0000:02:01.0: enabling Extended Tags
[   53.319975] pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
[   53.322901] pci 0000:02:01.0: PME# disabled
[   53.344870] do_rockchip_pcie_serror:hey!
[   53.346430] do_rockchip_pcie_serror:hey!
[   53.357285] pci 0000:02:03.0: [1b21:1184] type 01 class 0x060400
[   53.362818] pci 0000:02:03.0: Max Payload Size set to 256 (was 128, max 256)
[   53.365783] pci 0000:02:03.0: enabling Extended Tags
[   53.371869] pci 0000:02:03.0: PME# supported from D0 D3hot D3cold
[   53.374766] pci 0000:02:03.0: PME# disabled
[   53.396764] do_rockchip_pcie_serror:hey!
[   53.398333] do_rockchip_pcie_serror:hey!
[   53.409167] pci 0000:02:05.0: [1b21:1184] type 01 class 0x060400
[   53.414653] pci 0000:02:05.0: Max Payload Size set to 256 (was 128, max 256)
[   53.417619] pci 0000:02:05.0: enabling Extended Tags
[   53.423265] pci 0000:02:05.0: PME# supported from D0 D3hot D3cold
[   53.426049] pci 0000:02:05.0: PME# disabled
[   53.447276] do_rockchip_pcie_serror:hey!
[   53.449363] do_rockchip_pcie_serror:hey!
[   53.459200] pci 0000:02:07.0: [1b21:1184] type 01 class 0x060400
[   53.465029] pci 0000:02:07.0: Max Payload Size set to 256 (was 128, max 256)
[   53.467434] pci 0000:02:07.0: enabling Extended Tags
[   53.473584] pci 0000:02:07.0: PME# supported from D0 D3hot D3cold
[   53.475787] pci 0000:02:07.0: PME# disabled
[   53.498792] do_rockchip_pcie_serror:hey!
[   53.500963] do_rockchip_pcie_serror:hey!
[   53.509676] do_rockchip_pcie_serror:hey!
[   53.511148] do_rockchip_pcie_serror:hey!
[   53.521486] do_rockchip_pcie_serror:hey!
[   53.523028] do_rockchip_pcie_serror:hey!
[   53.532712] do_rockchip_pcie_serror:hey!
[   53.534233] do_rockchip_pcie_serror:hey!
[   53.542761] do_rockchip_pcie_serror:hey!
[   53.544797] do_rockchip_pcie_serror:hey!
[   53.553497] do_rockchip_pcie_serror:hey!
[   53.554955] do_rockchip_pcie_serror:hey!
[   53.565383] do_rockchip_pcie_serror:hey!
[   53.566939] do_rockchip_pcie_serror:hey!
[   53.576816] do_rockchip_pcie_serror:hey!
[   53.578358] do_rockchip_pcie_serror:hey!
[   53.586948] do_rockchip_pcie_serror:hey!
[   53.588974] do_rockchip_pcie_serror:hey!
[   53.597684] do_rockchip_pcie_serror:hey!
[   53.599158] do_rockchip_pcie_serror:hey!
[   53.608521] do_rockchip_pcie_serror:hey!
[   53.610013] do_rockchip_pcie_serror:hey!
[   53.618541] do_rockchip_pcie_serror:hey!
[   53.620010] do_rockchip_pcie_serror:hey!
[   53.629141] do_rockchip_pcie_serror:hey!
[   53.630609] do_rockchip_pcie_serror:hey!
[   53.639288] do_rockchip_pcie_serror:hey!
[   53.641271] do_rockchip_pcie_serror:hey!
[   53.649883] do_rockchip_pcie_serror:hey!
[   53.651344] do_rockchip_pcie_serror:hey!
[   53.660619] do_rockchip_pcie_serror:hey!
[   53.662088] do_rockchip_pcie_serror:hey!
[   53.670721] do_rockchip_pcie_serror:hey!
[   53.672701] do_rockchip_pcie_serror:hey!
[   53.681443] do_rockchip_pcie_serror:hey!
[   53.682922] do_rockchip_pcie_serror:hey!
[   53.692871] do_rockchip_pcie_serror:hey!
[   53.694405] do_rockchip_pcie_serror:hey!
[   53.702984] do_rockchip_pcie_serror:hey!
[   53.705005] do_rockchip_pcie_serror:hey!
[   53.713716] do_rockchip_pcie_serror:hey!
[   53.715179] do_rockchip_pcie_serror:hey!
[   53.725222] do_rockchip_pcie_serror:hey!
[   53.726755] do_rockchip_pcie_serror:hey!
[   53.736770] do_rockchip_pcie_serror:hey!
[   53.738283] do_rockchip_pcie_serror:hey!
[   53.746842] do_rockchip_pcie_serror:hey!
[   53.748855] do_rockchip_pcie_serror:hey!
[   53.757557] pci_bus 0000:02: fixups for bus
[   53.759331] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 0
[   53.762066] pci 0000:02:01.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   53.765616] pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 0
[   53.767824] pci 0000:02:03.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   53.771232] pci 0000:02:05.0: scanning [bus 00-00] behind bridge, pass 0
[   53.774037] pci 0000:02:05.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   53.777467] pci 0000:02:07.0: scanning [bus 00-00] behind bridge, pass 0
[   53.779646] pci 0000:02:07.0: bridge configuration invalid ([bus
00-00]), reconfiguring
[   53.783096] pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
[   53.793143] pci_bus 0000:03: scanning bus
[   53.794767] do_rockchip_pcie_serror:hey!
[   53.798261] do_rockchip_pcie_serror:hey!
[   54.026694] pci_bus 0000:03: fixups for bus
[   54.028933] pci_bus 0000:03: bus scan returning with max=03
[   54.030975] pci_bus 0000:03: busn_res: [bus 03-1f] end is updated to 03
[   54.034051] pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
[   54.043471] pci_bus 0000:04: scanning bus
[   54.047067] pci 0000:04:00.0: [10de:11c4] type 00 class 0x030000
[   54.051173] pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00ffffff]
[   54.054502] pci 0000:04:00.0: reg 0x14: [mem 0x00000000-0x07ffffff
64bit pref]
[   54.058096] pci 0000:04:00.0: reg 0x1c: [mem 0x00000000-0x01ffffff
64bit pref]
[   54.061432] pci 0000:04:00.0: reg 0x24: initial BAR value 0x00000000 invalid
[   54.063740] pci 0000:04:00.0: reg 0x24: [io  size 0x0080]
[   54.066588] pci 0000:04:00.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[   54.070087] pci 0000:04:00.0: Max Payload Size set to 256 (was 128, max 256)
[   54.079340] pci 0000:04:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 126.016 Gb/s
with 8 GT/s x16 link)
[   54.090881] pci 0000:04:00.0: vgaarb: VGA device added:
decodes=io+mem,owns=none,locks=none
[   54.098178] pci 0000:04:00.1: [10de:0e0b] type 00 class 0x040300
[   54.101950] pci 0000:04:00.1: reg 0x10: [mem 0x00000000-0x00003fff]
[   54.106759] pci 0000:04:00.1: Max Payload Size set to 256 (was 128, max 256)
[   54.121728] do_rockchip_pcie_serror:hey!
[   54.123286] do_rockchip_pcie_serror:hey!
[   54.125381] do_rockchip_pcie_serror:hey!
[   54.126852] do_rockchip_pcie_serror:hey!
[   54.128867] do_rockchip_pcie_serror:hey!
[   54.130331] do_rockchip_pcie_serror:hey!
[   54.131747] do_rockchip_pcie_serror:hey!
[   54.133663] do_rockchip_pcie_serror:hey!
[   54.135140] do_rockchip_pcie_serror:hey!
[   54.137111] do_rockchip_pcie_serror:hey!
[   54.138586] do_rockchip_pcie_serror:hey!
[   54.139984] do_rockchip_pcie_serror:hey!
[   54.371838] pci_bus 0000:04: fixups for bus
[   54.374185] pci_bus 0000:04: bus scan returning with max=04
[   54.377066] pci_bus 0000:04: busn_res: [bus 04-1f] end is updated to 04
[   54.379567] pci 0000:02:05.0: scanning [bus 00-00] behind bridge, pass 1
[   54.389098] pci_bus 0000:05: scanning bus
[   54.390718] do_rockchip_pcie_serror:hey!
[   54.392729] do_rockchip_pcie_serror:hey!
[   54.622660] pci_bus 0000:05: fixups for bus
[   54.624945] pci_bus 0000:05: bus scan returning with max=05
[   54.626966] pci_bus 0000:05: busn_res: [bus 05-1f] end is updated to 05
[   54.629967] pci 0000:02:07.0: scanning [bus 00-00] behind bridge, pass 1
[   54.639123] pci_bus 0000:06: scanning bus
[   54.642628] pci 0000:06:00.0: [1b4b:9123] type 00 class 0x010601
[   54.646519] pci 0000:06:00.0: reg 0x10: initial BAR value 0x00008000 invalid
[   54.649456] pci 0000:06:00.0: reg 0x10: [io  size 0x0008]
[   54.651786] pci 0000:06:00.0: reg 0x14: initial BAR value 0x00008040 invalid
[   54.654657] pci 0000:06:00.0: reg 0x14: [io  size 0x0004]
[   54.657499] pci 0000:06:00.0: reg 0x18: initial BAR value 0x00008100 invalid
[   54.659776] pci 0000:06:00.0: reg 0x18: [io  size 0x0008]
[   54.662646] pci 0000:06:00.0: reg 0x1c: initial BAR value 0x00008140 invalid
[   54.665553] pci 0000:06:00.0: reg 0x1c: [io  size 0x0004]
[   54.667861] pci 0000:06:00.0: reg 0x20: [io  0x800000-0x80000f]
[   54.670926] pci 0000:06:00.0: reg 0x24: [mem 0x00900000-0x009007ff]
[   54.673999] pci 0000:06:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]
[   54.677231] pci 0000:06:00.0: Max Payload Size set to 256 (was 128, max 512)
[   54.680024] pci 0000:06:00.0: Enabling fixed DMA alias to 00.1
[   54.685613] pci 0000:06:00.0: PME# supported from D3hot
[   54.687586] pci 0000:06:00.0: PME# disabled
[   54.691486] pci 0000:06:00.0: 2.000 Gb/s available PCIe bandwidth,
limited by 2.5 GT/s x1 link at 0000:00:00.0 (capable of 4.000 Gb/s
with 5 GT/s x1 link)
[   54.707650] pci 0000:06:00.1: [1b4b:91a4] type 00 class 0x01018f
[   54.711661] pci 0000:06:00.1: reg 0x10: initial BAR value 0x00008200 invalid
[   54.714870] pci 0000:06:00.1: reg 0x10: [io  size 0x0008]
[   54.717850] pci 0000:06:00.1: reg 0x14: initial BAR value 0x00008240 invalid
[   54.720987] pci 0000:06:00.1: reg 0x14: [io  size 0x0004]
[   54.723317] pci 0000:06:00.1: reg 0x18: initial BAR value 0x00008300 invalid
[   54.726269] pci 0000:06:00.1: reg 0x18: [io  size 0x0008]
[   54.729128] pci 0000:06:00.1: reg 0x1c: initial BAR value 0x00008340 invalid
[   54.731406] pci 0000:06:00.1: reg 0x1c: [io  size 0x0004]
[   54.734321] pci 0000:06:00.1: reg 0x20: [io  0x820000-0x82000f]
[   54.737333] pci 0000:06:00.1: reg 0x24: [mem 0x00920000-0x0092000f]
[   54.739855] pci 0000:06:00.1: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[   54.743153] pci 0000:06:00.1: Max Payload Size set to 256 (was 128, max 512)
[   54.749557] pci 0000:06:00.1: PME# supported from D3hot
[   54.751556] pci 0000:06:00.1: PME# disabled
[   54.764125] do_rockchip_pcie_serror:hey!
[   54.766254] do_rockchip_pcie_serror:hey!
[   54.767753] do_rockchip_pcie_serror:hey!
[   54.769735] do_rockchip_pcie_serror:hey!
[   54.771227] do_rockchip_pcie_serror:hey!
[   54.773130] do_rockchip_pcie_serror:hey!
[   54.774626] do_rockchip_pcie_serror:hey!
[   54.776019] do_rockchip_pcie_serror:hey!
[   54.778028] do_rockchip_pcie_serror:hey!
[   54.779489] do_rockchip_pcie_serror:hey!
[   54.781441] do_rockchip_pcie_serror:hey!
[   54.782900] do_rockchip_pcie_serror:hey!
[   55.024561] pci_bus 0000:06: fixups for bus
[   55.026347] pci_bus 0000:06: bus scan returning with max=06
[   55.028883] pci_bus 0000:06: busn_res: [bus 06-1f] end is updated to 06
[   55.031193] pci_bus 0000:02: bus scan returning with max=06
[   55.033657] pci_bus 0000:02: busn_res: [bus 02-1f] end is updated to 06
[   55.035974] pci_bus 0000:01: bus scan returning with max=06
[   55.038913] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 06
[   55.041730] pci_bus 0000:00: bus scan returning with max=06
[   55.045837] pci 0000:00:00.0: BAR 14: no space for [mem size 0x10000000]
[   55.048083] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x10000000]
[   55.051414] pci 0000:01:00.0: BAR 15: no space for [mem size
0x0c000000 64bit pref]
[   55.054841] pci 0000:01:00.0: BAR 15: failed to assign [mem size
0x0c000000 64bit pref]
[   55.058132] pci 0000:01:00.0: BAR 14: no space for [mem size 0x01c00000]
[   55.061000] pci 0000:01:00.0: BAR 14: failed to assign [mem size 0x01c00000]
[   55.063297] pci 0000:01:00.0: BAR 13: no space for [io  size 0x2000]
[   55.065958] pci 0000:01:00.0: BAR 13: failed to assign [io  size 0x2000]
[   55.069058] pci 0000:02:03.0: BAR 15: no space for [mem size
0x0c000000 64bit pref]
[   55.071603] pci 0000:02:03.0: BAR 15: failed to assign [mem size
0x0c000000 64bit pref]
[   55.074791] pci 0000:02:03.0: BAR 14: no space for [mem size 0x01800000]
[   55.077569] pci 0000:02:03.0: BAR 14: failed to assign [mem size 0x01800000]
[   55.079880] pci 0000:02:07.0: BAR 14: no space for [mem size 0x00100000]
[   55.082650] pci 0000:02:07.0: BAR 14: failed to assign [mem size 0x00100000]
[   55.085505] pci 0000:02:03.0: BAR 13: no space for [io  size 0x1000]
[   55.087606] pci 0000:02:03.0: BAR 13: failed to assign [io  size 0x1000]
[   55.090372] pci 0000:02:07.0: BAR 13: no space for [io  size 0x1000]
[   55.093071] pci 0000:02:07.0: BAR 13: failed to assign [io  size 0x1000]
[   55.095351] pci 0000:02:01.0: PCI bridge to [bus 03]
[   55.098535] pci 0000:04:00.0: BAR 1: no space for [mem size
0x08000000 64bit pref]
[   55.101694] pci 0000:04:00.0: BAR 1: failed to assign [mem size
0x08000000 64bit pref]
[   55.104897] pci 0000:04:00.0: BAR 3: no space for [mem size
0x02000000 64bit pref]
[   55.107397] pci 0000:04:00.0: BAR 3: failed to assign [mem size
0x02000000 64bit pref]
[   55.110532] pci 0000:04:00.0: BAR 0: no space for [mem size 0x01000000]
[   55.113275] pci 0000:04:00.0: BAR 0: failed to assign [mem size 0x01000000]
[   55.115578] pci 0000:04:00.0: BAR 6: no space for [mem size 0x00080000 pref]
[   55.118419] pci 0000:04:00.0: BAR 6: failed to assign [mem size
0x00080000 pref]
[   55.121504] pci 0000:04:00.1: BAR 0: no space for [mem size 0x00004000]
[   55.123684] pci 0000:04:00.1: BAR 0: failed to assign [mem size 0x00004000]
[   55.126517] pci 0000:04:00.0: BAR 5: no space for [io  size 0x0080]
[   55.129224] pci 0000:04:00.0: BAR 5: failed to assign [io  size 0x0080]
[   55.131475] pci 0000:02:03.0: PCI bridge to [bus 04]
[   55.134370] pci 0000:02:05.0: PCI bridge to [bus 05]
[   55.137676] pci 0000:06:00.0: BAR 6: no space for [mem size 0x00010000 pref]
[   55.139982] pci 0000:06:00.0: BAR 6: failed to assign [mem size
0x00010000 pref]
[   55.143057] pci 0000:06:00.1: BAR 6: no space for [mem size 0x00010000 pref]
[   55.145881] pci 0000:06:00.1: BAR 6: failed to assign [mem size
0x00010000 pref]
[   55.148931] pci 0000:06:00.0: BAR 5: no space for [mem size 0x00000800]
[   55.151104] pci 0000:06:00.0: BAR 5: failed to assign [mem size 0x00000800]
[   55.153922] pci 0000:06:00.0: BAR 4: no space for [io  size 0x0010]
[   55.156004] pci 0000:06:00.0: BAR 4: failed to assign [io  size 0x0010]
[   55.158777] pci 0000:06:00.1: BAR 4: no space for [io  size 0x0010]
[   55.161404] pci 0000:06:00.1: BAR 4: failed to assign [io  size 0x0010]
[   55.163607] pci 0000:06:00.1: BAR 5: no space for [mem size 0x00000010]
[   55.166364] pci 0000:06:00.1: BAR 5: failed to assign [mem size 0x00000010]
[   55.169246] pci 0000:06:00.0: BAR 0: no space for [io  size 0x0008]
[   55.171325] pci 0000:06:00.0: BAR 0: failed to assign [io  size 0x0008]
[   55.174077] pci 0000:06:00.0: BAR 2: no space for [io  size 0x0008]
[   55.176759] pci 0000:06:00.0: BAR 2: failed to assign [io  size 0x0008]
[   55.178950] pci 0000:06:00.1: BAR 0: no space for [io  size 0x0008]
[   55.181860] pci 0000:06:00.1: BAR 0: failed to assign [io  size 0x0008]
[   55.184698] pci 0000:06:00.1: BAR 2: no space for [io  size 0x0008]
[   55.186780] pci 0000:06:00.1: BAR 2: failed to assign [io  size 0x0008]
[   55.189510] pci 0000:06:00.0: BAR 1: no space for [io  size 0x0004]
[   55.191587] pci 0000:06:00.0: BAR 1: failed to assign [io  size 0x0004]
[   55.194302] pci 0000:06:00.0: BAR 3: no space for [io  size 0x0004]
[   55.196965] pci 0000:06:00.0: BAR 3: failed to assign [io  size 0x0004]
[   55.199148] pci 0000:06:00.1: BAR 1: no space for [io  size 0x0004]
[   55.201769] pci 0000:06:00.1: BAR 1: failed to assign [io  size 0x0004]
[   55.203952] pci 0000:06:00.1: BAR 3: no space for [io  size 0x0004]
[   55.206664] pci 0000:06:00.1: BAR 3: failed to assign [io  size 0x0004]
[   55.209535] pci 0000:02:07.0: PCI bridge to [bus 06]
[   55.211789] pci 0000:01:00.0: PCI bridge to [bus 02-06]
[   55.214636] pci 0000:00:00.0: PCI bridge to [bus 01-06]
[   55.225253] pcieport 0000:00:00.0: assign IRQ: got 227
[   55.227779] pcieport 0000:00:00.0: enabling bus mastering
[   55.243313] pcieport 0000:00:00.0: PME: Signaling with IRQ 228
[   55.263779] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.263979] pcieport 0000:00:00.0: AER: enabled with IRQ 228
[   55.265375] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.268163] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.268891] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.269629] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.270355] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.271108] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.271846] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.272592] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.273320] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.274031] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.274750] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.275454] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.276187] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.276906] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.277664] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.278393] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.279110] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.279825] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.280551] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.281285] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.282016] pcieport 0000:01:00.0: assign IRQ: got 227
[   55.282597] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.282781] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.285874] rockchip-pcie f8000000.pcie: correctable error interrupt received
[   55.286630] pcieport 0000:01:00.0: enabling bus mastering
[   55.311138] pcieport 0000:02:01.0: assign IRQ: got 230
[   55.314740] pcieport 0000:02:01.0: enabling bus mastering
[   55.344990] pcieport 0000:02:03.0: assign IRQ: got 232
[   55.347735] pcieport 0000:02:03.0: enabling bus mastering
[   55.374090] pcieport 0000:02:05.0: assign IRQ: got 230
[   55.377646] pcieport 0000:02:05.0: enabling bus mastering
[   55.405254] pcieport 0000:02:07.0: assign IRQ: got 232
[   55.407938] pcieport 0000:02:07.0: enabling bus mastering
[   55.434151] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
<snip> when it tries to load nouveau
[   80.221309] nouveau 0000:04:00.0: assign IRQ: got 232
[   80.221367] do_rockchip_pcie_serror:hey!
[   80.221369] do_rockchip_pcie_serror:hey!
[   80.221375] nouveau 0000:04:00.0: unknown chipset (00000000)
[   80.221886] nouveau: probe of 0000:04:00.0 failed with error -12
