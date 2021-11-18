Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA22456200
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 19:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhKRSNZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 18 Nov 2021 13:13:25 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56346
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230446AbhKRSNZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Nov 2021 13:13:25 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1CE8B40079
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 18:10:21 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id c32so30335683lfv.4
        for <linux-pci@vger.kernel.org>; Thu, 18 Nov 2021 10:10:21 -0800 (PST)
X-Gm-Message-State: AOAM533lLAbJRrYu1gh+y132tD7smBJnx/Pgx3yUKhcEPOT8csHEMAav
        czIJznWWUN3PpK0GpPL/NFZ3X0odsqVkKajcoXYDQA==
X-Google-Smtp-Source: ABdhPJyRa0+Ruz/zoSnnP25qrWyLcXw4hj3A868SlMtwkmUohbHf4cczNzMMbS1KBFmMYFNxPEGGhZw77H31S5Gfqss=
X-Received: by 2002:ac2:4d19:: with SMTP id r25mr25178520lfi.82.1637259019913;
 Thu, 18 Nov 2021 10:10:19 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>
Date:   Thu, 18 Nov 2021 13:10:09 -0500
X-Gmail-Original-Message-ID: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
Message-ID: <CA+enf=v9rY_xnZML01oEgKLmvY1NGBUUhnSJaETmXtDtXfaczA@mail.gmail.com>
Subject: PCIe regression on APM Merlin (aarch64 dev platform) preventing NVME initialization
To:     linux-pci@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

I've recently been given access to a set of 4 APM X-Gene2 Merlin
boards (old-ish development platform).
Running them on Ubuntu 20.04's stock 5.4 kernel worked fine but trying
to run anything else would fail to boot due to a NVME initialization
timeout preventing the main drive from showing up at all.

Tracking this issue, I first moved to clean mainline kernels and then
isolated the issue to be somewhere between 5.4.0 and 5.5.0-rc1, which
sadly meant the merge window (so much for a quick bisect...). I've
then bisected between those two points and came up with:

  6dce5aa59e0bf2430733d7a8b11c205ec10f408e (refs/bisect/bad) PCI:
xgene: Use inbound resources for setup

I finally switched to the latest 5.15.2 tree, reverted that one
commit, built a new kernel and confirmed that those boards now work
flawlessly.

Unfortunately that's about the extent of my abilities with kernel
debugging and I won't pretend to understand what that commit does or
how it may be breaking PCIe initialization on those systems.

I'm not technically blocked on this, I can manually build my own
kernels by reverting that one commit every time, but that's obviously
not ideal and I'd much rather have this fixed upstream :)

== Good boot on 5.15.2 (commit reverted) ==
Full log at: https://gist.github.com/stgraber/e489b7e55dd7ffaac9f77dd8634ca2ff

root@entak:~# dmesg | grep -Ei "nvme|pci"
[    0.094146] PCI: CLS 0 bytes, default 64
[    0.130573] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.131324] xgene-pcie 1f2b0000.pcie: host bridge /soc/pcie@1f2b0000 ranges:
[    0.131344] xgene-pcie 1f2b0000.pcie:   No bus range found for
/soc/pcie@1f2b0000, using [bus 00-ff]
[    0.131365] xgene-pcie 1f2b0000.pcie:       IO
0xc010000000..0xc01000ffff -> 0x0000000000
[    0.131388] xgene-pcie 1f2b0000.pcie:      MEM
0xc120000000..0xc13fffffff -> 0x0020000000
[    0.131401] xgene-pcie 1f2b0000.pcie:      MEM
0xe000000000..0xffffffffff -> 0xe000000000
[    0.131416] xgene-pcie 1f2b0000.pcie:   IB MEM
0x8000000000..0x807fffffff -> 0x8000000000
[    0.131427] xgene-pcie 1f2b0000.pcie:   IB MEM
0x0000000000..0x7fffffffff -> 0x0000000000
[    0.131510] xgene-pcie 1f2b0000.pcie: (rc) x4 gen-3 link up
[    0.131600] xgene-pcie 1f2b0000.pcie: PCI host bridge to bus 0000:00
[    0.131612] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.131619] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.131629] pci_bus 0000:00: root bus resource [mem
0xc120000000-0xc13fffffff] (bus address [0x20000000-0x3fffffff])
[    0.131637] pci_bus 0000:00: root bus resource [mem
0xe000000000-0xffffffffff pref]
[    0.131671] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    0.131682] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131693] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131705] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131715] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131725] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131733] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131742] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131753] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131781] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits
[    0.131832] pci 0000:00:00.0: supports D1 D2
[    0.132373] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits
[    0.132482] pci 0000:01:00.0: [144d:a80a] type 00 class 0x010802
[    0.132518] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x40003fff 64bit]
[    0.132778] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x4 link at 0000:00:00.0 (capable of 63.012
Gb/s with 16.0 GT/s PCIe x4 link)
[    0.143064] pci 0000:00:00.0: BAR 14: assigned [mem
0xc120000000-0xc1200fffff]
[    0.143086] pci 0000:01:00.0: BAR 0: assigned [mem
0xc120000000-0xc120003fff 64bit]
[    0.143105] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.143114] pci 0000:00:00.0:   bridge window [mem 0xc120000000-0xc1200fffff]
[    0.143315] pcieport 0000:00:00.0: PME: Signaling with IRQ 59
[    0.143518] pcieport 0000:00:00.0: AER: enabled with IRQ 59
[    1.596986] ehci-pci: EHCI PCI platform driver
[    1.611674] ohci-pci: OHCI PCI platform driver
[    3.347499] nvme nvme0: pci function 0000:01:00.0
[    3.347531] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[    3.350353] nvme nvme0: Shutdown timeout set to 10 seconds
[    3.535444] nvme nvme0: 8/0/0 default/read/poll queues
[    3.551454]  nvme0n1: p1 p2 p3 p4
[    6.963428] EXT4-fs (nvme0n1p2): mounted filesystem with ordered
data mode. Opts: (null). Quota mode: none.
[    8.415778] EXT4-fs (nvme0n1p2): re-mounted. Opts: (null). Quota mode: none.

== Bad boot on 5.15.2 (clean build, nothing reverted) ==
Full log at: https://gist.github.com/stgraber/605e8e852d8de35c6bbe64fab0f83815

root@entak:~# cat /boot/efi/dmesg | grep -Ei "nvme|pci"
[    0.094130] PCI: CLS 0 bytes, default 64
[    0.130822] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.131556] xgene-pcie 1f2b0000.pcie: host bridge /soc/pcie@1f2b0000 ranges:
[    0.131576] xgene-pcie 1f2b0000.pcie:   No bus range found for
/soc/pcie@1f2b0000, using [bus 00-ff]
[    0.131596] xgene-pcie 1f2b0000.pcie:       IO
0xc010000000..0xc01000ffff -> 0x0000000000
[    0.131618] xgene-pcie 1f2b0000.pcie:      MEM
0xc120000000..0xc13fffffff -> 0x0020000000
[    0.131630] xgene-pcie 1f2b0000.pcie:      MEM
0xe000000000..0xffffffffff -> 0xe000000000
[    0.131646] xgene-pcie 1f2b0000.pcie:   IB MEM
0x8000000000..0x807fffffff -> 0x8000000000
[    0.131659] xgene-pcie 1f2b0000.pcie:   IB MEM
0x0000000000..0x7fffffffff -> 0x0000000000
[    0.131729] xgene-pcie 1f2b0000.pcie: (rc) x4 gen-3 link up
[    0.131816] xgene-pcie 1f2b0000.pcie: PCI host bridge to bus 0000:00
[    0.131827] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.131834] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.131844] pci_bus 0000:00: root bus resource [mem
0xc120000000-0xc13fffffff] (bus address [0x20000000-0x3fffffff])
[    0.131852] pci_bus 0000:00: root bus resource [mem
0xe000000000-0xffffffffff pref]
[    0.131886] pci 0000:00:00.0: [10e8:e004] type 01 class 0x060400
[    0.131897] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131908] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131919] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131929] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131938] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131946] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131955] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131966] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x4 may corrupt adjacent RW1C bits
[    0.131994] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits
[    0.132044] pci 0000:00:00.0: supports D1 D2
[    0.132590] pci_bus 0000:00: 2-byte config write to 0000:00:00.0
offset 0x3e may corrupt adjacent RW1C bits
[    0.132700] pci 0000:01:00.0: [144d:a80a] type 00 class 0x010802
[    0.132735] pci 0000:01:00.0: reg 0x10: [mem 0x40000000-0x40003fff 64bit]
[    0.132996] pci 0000:01:00.0: 31.504 Gb/s available PCIe bandwidth,
limited by 8.0 GT/s PCIe x4 link at 0000:00:00.0 (capable of 63.012
Gb/s with 16.0 GT/s PCIe x4 link)
[    0.143038] pci 0000:00:00.0: BAR 14: assigned [mem
0xc120000000-0xc1200fffff]
[    0.143059] pci 0000:01:00.0: BAR 0: assigned [mem
0xc120000000-0xc120003fff 64bit]
[    0.143079] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.143087] pci 0000:00:00.0:   bridge window [mem 0xc120000000-0xc1200fffff]
[    0.143286] pcieport 0000:00:00.0: PME: Signaling with IRQ 59
[    0.143474] pcieport 0000:00:00.0: AER: enabled with IRQ 59
[    1.598863] ehci-pci: EHCI PCI platform driver
[    1.613544] ohci-pci: OHCI PCI platform driver
[    3.280872] nvme nvme0: pci function 0000:01:00.0
[    3.280929] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[    7.393328] pcieport 0000:00:00.0: AER: Corrected error received:
0000:01:00.0
[    7.400550] nvme 0000:01:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[    7.409733] nvme 0000:01:00.0:   device [144d:a80a] error
status/mask=00000001/0000e000
[    7.417703] nvme 0000:01:00.0:    [ 0] RxErr
[    7.423434] pci_generic_config_write32: 28 callbacks suppressed
[    7.423439] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0x7a may corrupt adjacent RW1C bits
[   11.524622] pcieport 0000:00:00.0: AER: Corrected error received:
0000:01:00.0
[   11.531828] nvme 0000:01:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[   11.541008] nvme 0000:01:00.0:   device [144d:a80a] error
status/mask=00000001/0000e000
[   11.548978] nvme 0000:01:00.0:    [ 0] RxErr
[   11.554707] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0x7a may corrupt adjacent RW1C bits
[   64.046090] pcieport 0000:00:00.0: AER: Corrected error received:
0000:01:00.0
[   64.053295] nvme 0000:01:00.0: PCIe Bus Error: severity=Corrected,
type=Physical Layer, (Receiver ID)
[   64.062475] nvme 0000:01:00.0:   device [144d:a80a] error
status/mask=00000001/0000e000
[   64.070446] nvme 0000:01:00.0:    [ 0] RxErr
[   64.076175] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0x7a may corrupt adjacent RW1C bits
[   64.478625] nvme nvme0: I/O 16 QID 0 timeout, disable controller
[   64.590606] nvme nvme0: Device shutdown incomplete; abort shutdown
[   64.610619] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0xb2 may corrupt adjacent RW1C bits
[   64.620324] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0x4 may corrupt adjacent RW1C bits
[   64.629984] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0x78 may corrupt adjacent RW1C bits
[   64.639694] pci_bus 0000:01: 2-byte config write to 0000:01:00.0
offset 0x4 may corrupt adjacent RW1C bits
[   64.649330] nvme nvme0: Identify Controller failed (-4)
[   64.654541] nvme nvme0: Removing after probe failure status: -5

Thanks!

Stéphane
