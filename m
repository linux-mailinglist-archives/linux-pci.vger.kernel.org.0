Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D798E77BB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 18:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfJ1Rhf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 13:37:35 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33943 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732380AbfJ1Rhf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 13:37:35 -0400
Received: by mail-yb1-f194.google.com with SMTP id m1so4350356ybm.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2019 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oliql5evYaCz9xp87AnEMTYaApv9swR9CcY9H5MhwCM=;
        b=uTkBvRcVtKZXkSt8CR4BJqyN3Byo5SHR3Orsj9QmZfDC220xY+PjfKsZyfyQDi5W12
         lr9zEMox2ABdg3z6+Zc+TkraSewl+/un7/cUOwf0N4+6//no2X8+Zjgj/GJxQY70izLd
         5QxOzCBycKktVyce07eqAeFEYBpJxrPMrulU2uBLTSPyNwi0nd0+0J1Zbobicak4gFTp
         MYK6H9BF4vKqH1M69XW+MfLNuUyX8z3Ifu6WdNaiPih0//hkBQgRt7Ueao94rT0mPuvU
         CYHZOqiTNtaiStX469MZajKphZSGODJ0JVowFewHxFI1V8LPg/SqwJ4EcFXkD3/hzla7
         +NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oliql5evYaCz9xp87AnEMTYaApv9swR9CcY9H5MhwCM=;
        b=RQ/0BFxedRIrkkV1iHqRJBbTV/fwvOM+LbZYgk2RehlWjh/kToy99zZf3nVgapCMKe
         2Ajh4nZ+Ypw+D5zW4wJJUibPUSNPR79PE+UiAF1ygUrAnRApdNA1JEOmDG7E7Ikj6Mt/
         rAHabA42MBHktsMEytgkx5ENvOtqFHBgnJNIxuaD82k/xQnK5Yx4A3jcphXovZ34e3lc
         ofEuq7UCQe2fyXailepKK4MlHvPSYHz4VIVXqo9O3jonBc2MzQwbAu2XnoCCNcdpb5zh
         tYHdnW5GLgUrWVHXx4BVjl0IeyVe2COTXRNI17fEB2A6eA5t9Yux+4J5zu95FSgpvAut
         eWBQ==
X-Gm-Message-State: APjAAAUVIueo1Dh7+Ak/wXMcjKBqp2zE4IHD8zQBa8d3tSw/A4R5lA6X
        TCSRygZ1lSLd4N2RVMDuoaOu4K39jw/8DoYKgP4=
X-Google-Smtp-Source: APXvYqzxO6d/G/TVdjH9jUZR+S12+MvGlHhlWzKXZL0HllK59MNOMGyAC8g++C6T8oTsMDqEEUB4bl1doO9i2N3SbmM=
X-Received: by 2002:a25:cdca:: with SMTP id d193mr15650117ybf.60.1572284253589;
 Mon, 28 Oct 2019 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <CA+QBN9C_o8HanAzXpDUN410g2o5+xfx64pbX3_VHVDKcj5N3kA@mail.gmail.com>
 <20191028171329.GA104845@google.com>
In-Reply-To: <20191028171329.GA104845@google.com>
From:   Carlo Pisani <carlojpisani@gmail.com>
Date:   Mon, 28 Oct 2019 17:37:14 +0100
Message-ID: <CA+QBN9DZyFynoUt+7sS_AcC-Wio-McJKCz8-RYfDWV0jv8iCzw@mail.gmail.com>
Subject: Re: Oxford Semiconductor Ltd OX16PCI954 - weird dmesg
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > These resources are supplied to the PCI core, probably from DT.  A
> > > complete dmesg log would show more.

The rb532 does not have device tree support, so the answer is no.
I am using a common vanilla kernel without any extra patch.


> It's hard to tell what this 00:00.0 device is.  The Vendor ID 0x111d
> is "Microsemi / PMC / IDT" (now owned by Microchip Technology, per
> https://pci-ids.ucw.cz/read/PC/111d).
>
> The Device ID of 0x0000 looks invalid (though that's defined by the
> vendor, and I think the PCIe spec would allow 0).
>
> The class code is invalid.  Likely the device has configuration
> registers for the PCI host bridge.

> > pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
> > pci_bus 0000:00: root bus resource [io  0x18800000-0x188fffff]
> > pci_bus 0000:00: root bus resource [??? 0x00000000 flags 0x0]
> > pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
> > pci 0000:00:00.0: [111d:0000] type 00 class 0x000000
> > pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x07ffffff pref]
> > pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
> > pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>
> It's hard to tell what this 00:00.0 device is.  The Vendor ID 0x111d
> is "Microsemi / PMC / IDT" (now owned by Microchip Technology, per
> https://pci-ids.ucw.cz/read/PC/111d).

> Can you collect the output of "lspci -vvxxx" as root?

uc-rb532 ~ # lspci -vvxxx
00:00.0 Non-VGA unclassified device: Integrated Device Technology,
Inc. Device 0000
        Subsystem: Device 0214:011d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B- DisINTx-
        Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort+ >SERR- <PERR- INTx-
        Latency: 60 (2000ns min, 14000ns max), Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 140
        Region 0: Memory at <unassigned> (32-bit, prefetchable)
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
00: 1d 11 00 00 57 01 a0 22 00 00 00 00 04 3c 00 00
10: 08 00 00 00 01 00 80 18 01 00 00 18 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 02 1d 01
30: 00 00 00 00 00 00 00 00 00 00 00 00 8c 01 08 38
40: 80 80 00 00 6e 0d 00 00 00 00 00 00 51 00 00 00
50: 00 00 00 00 55 00 00 00 00 00 00 18 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:02.0 Ethernet controller: VIA Technologies, Inc. VT6105/VT6106S
[Rhine-III] (rev 86)
        Subsystem: AST Research Inc Device 086c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 142
        Region 0: I/O ports at 18800000 [size=256]
        Region 1: Memory at 50014000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: via-rhine
00: 06 11 06 31 87 00 10 02 86 00 00 02 00 40 00 00
10: 01 00 80 18 00 40 01 50 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 0d 10 6c 08
30: 00 00 00 00 40 00 00 00 00 00 00 00 8e 01 00 00
40: 01 00 82 f6 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:03.0 Ethernet controller: VIA Technologies, Inc. VT6105/VT6106S
[Rhine-III] (rev 86)
        Subsystem: AST Research Inc Device 086c
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64
        Interrupt: pin A routed to IRQ 143
        Region 0: I/O ports at 18800400 [size=256]
        Region 1: Memory at 50014100 (32-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: via-rhine
00: 06 11 06 31 87 00 10 02 86 00 00 02 00 40 00 00
10: 01 04 80 18 00 41 01 50 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 0d 10 6c 08
30: 00 00 00 00 40 00 00 00 00 00 00 00 8f 01 00 00
40: 01 00 82 f6 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 Network controller: Atheros Communications Inc. Device 0029 (rev 01)
        Subsystem: Atheros Communications Inc. Device 2091
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 168, Cache Line Size: 16 bytes
        Interrupt: pin A routed to IRQ 142
        Region 0: Memory at 50000000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=100mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: ath9k
00: 8c 16 29 00 06 00 b0 02 01 00 80 02 04 a8 00 00
10: 00 00 00 50 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 8c 16 91 20
30: 00 00 00 00 44 00 00 00 00 00 00 00 8e 01 00 00
40: 80 00 00 00 01 00 82 48 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad
16950 UART) function 0 (Uart) (rev 01) (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 143
        Region 0: I/O ports at 18800800 [size=32]
        Region 1: Memory at 50010000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 18800820 [size=32]
        Region 3: Memory at 50011000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: serial
00: 15 14 01 95 03 00 90 02 01 06 00 07 00 00 80 00
10: 01 08 80 18 00 00 01 50 21 08 80 18 00 10 01 50
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 8f 01 00 00
40: 01 00 02 6c 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:05.1 Non-VGA unclassified device: Oxford Semiconductor Ltd
OX16PCI954 (Quad 16950 UART) function 0 (Disabled) (rev 01)
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 143
        Region 0: I/O ports at <unassigned> [disabled]
        Region 1: I/O ports at <unassigned> [disabled]
        Region 2: I/O ports at <unassigned> [disabled]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 15 14 00 95 00 00 90 02 01 00 00 00 00 00 80 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 8f 01 00 00
40: 01 00 02 6c 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.0 Serial controller: Oxford Semiconductor Ltd OX16PCI954 (Quad
16950 UART) function 0 (Uart) (rev 01) (prog-if 06 [16950])
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 140
        Region 0: I/O ports at 18800840 [size=32]
        Region 1: Memory at 50012000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports at 18800860 [size=32]
        Region 3: Memory at 50013000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Kernel driver in use: serial
00: 15 14 01 95 03 00 90 02 01 06 00 07 00 00 80 00
10: 41 08 80 18 00 20 01 50 61 08 80 18 00 30 01 50
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 8c 01 00 00
40: 01 00 02 6c 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:0a.1 Non-VGA unclassified device: Oxford Semiconductor Ltd
OX16PCI954 (Quad 16950 UART) function 0 (Disabled) (rev 01)
        Subsystem: Oxford Semiconductor Ltd Device 0000
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 140
        Region 0: I/O ports at <unassigned> [disabled]
        Region 1: I/O ports at <unassigned> [disabled]
        Region 2: I/O ports at <unassigned> [disabled]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 15 14 00 95 00 00 90 02 01 00 00 00 00 00 80 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 15 14 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 8c 01 00 00
40: 01 00 02 6c 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


> If those UARTs are capable of DMA, it's conceivable they could corrupt
something.

yes, it looks like something corrupts the memory.
