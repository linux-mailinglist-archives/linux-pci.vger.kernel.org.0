Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3087211DFAE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 09:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMIsA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 03:48:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:43086 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbfLMIsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Dec 2019 03:48:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id g4so902200pjs.10;
        Fri, 13 Dec 2019 00:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faCBlmgTPQdYlEVpkeE4GNu+nPqEqsfQJpXTYDba5FY=;
        b=razj/7vZ+JbucAknGmxck6+vSzm5wRHRzOWy+lxigo91chdg+RZNqKWqZLz5UnasAa
         nM3svl9rWcegDadG0F32DfWvS3lwWb+b7IiieoollGSgm4Ru1LxV4Sz++ZwCxL199eqY
         5AYzdVnOM8vPrMqe4NtHYIS/2wzqsHoTSMBr8yQJ+Z2kVgsE79bSBkXH5tkLkmSYASb5
         VkSgCiGgWUBq6b73uhCHrvEW+2++cB/P+pC3wleeDo5AYqaLCuOr3eaxYjIa3Yzxwzjz
         lfPNR64+8x3FaUI+krXPecsw7dSiNmwBpJl71Tcu9qxBDLq2WDxU4lqKHyDiDJVhnq8O
         iEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faCBlmgTPQdYlEVpkeE4GNu+nPqEqsfQJpXTYDba5FY=;
        b=SEk6GSLNkvivc4aut0gITiu0YmFl3VVXOwZwwBwox42JAdqL8dctM99e9fTbkasG91
         ur7LF9SMdyvZf5T3UeqI2JxE0eEOkrVVtYqApAHcH6x/2UUK0xfsNrEkjsMZnu1Wrf0u
         KAHG+S9qyHypQjpwcCH+GVMShjmshO+UnhnilVd2OVUk+FQi729eVgbqaoUoivXWclrB
         YQw7t2HS91OzHiDhPPe96Y8MLEdt7etXKlBOU31QP5J4LZAGDAx9aTud++TMa2ZTVJTa
         GJyJPVHjpviyVmpkiiHllAqQ2iaGyBb3bNUrUdbDR4HWBY+kPilEizsMBJjdpJTJCB1i
         rAlQ==
X-Gm-Message-State: APjAAAV2NoxVz3fqDRx0AWi2yYaL9MzJuRmk/yNduPDmgILhApWt+LJK
        7syUXa2xCwtPsZT6A3e7eNg=
X-Google-Smtp-Source: APXvYqxLS8SmpcnrtfIR9E7GHF2j8As78boRZwVuSxFdSNtc8n66W9/XnnKOusFfrKiYhQE90NkjzQ==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr14931561plo.82.1576226879597;
        Fri, 13 Dec 2019 00:47:59 -0800 (PST)
Received: from prasmi.domain.name ([103.219.60.167])
        by smtp.gmail.com with ESMTPSA id 68sm9985632pge.14.2019.12.13.00.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 00:47:58 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Murray <andrew.murray@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v2 0/6] Add support for PCIe controller to work in endpoint mode on R-Car SoCs
Date:   Fri, 13 Dec 2019 08:47:42 +0000
Message-Id: <20191213084748.11210-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch series adds support for PCIe controller on rcar to work in endpoint mode,
this also extends the epf framework to handle features of outbound regions.

Note:
The cadence/rockchip/designware endpoint drivers are build tested only.

Changes for v2:
1] Fixed review comments from Biju for dt-bindings to include an example
   for a tested platform.
2] Fixed review comments from Kishon to extend the features of outbound
   regions in epf framework.
3] Added support to parse outbound-ranges in OF.

lspci output on host:
====================

01:00.0 Unassigned class [ff00]: Renesas Technology Corp. Device 002d
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 152
        Region 0: Memory at fe200200 (64-bit, non-prefetchable) [size=128]
        Region 2: Memory at fe200000 (64-bit, non-prefetchable) [size=256]
        Region 4: Memory at fe200100 (64-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
                Address: 00000004fa36f000  Data: 0001
                Masking: fffffffe  Pending: 00000000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s unlimited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                        RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s, Exit Latency L0s unlimited
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1, TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
        Capabilities: [100 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Kernel driver in use: pci-endpoint-test
00: 12 19 2d 00 06 00 10 00 00 00 00 ff 00 00 00 00
10: 04 02 20 fe 00 00 00 00 04 00 20 fe 00 00 00 00
20: 04 01 20 fe 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 40 00 00 00 00 00 00 00 98 01 00 00

BAR Test
========
root@g2e:~# pcitest -b 0
BAR0:           OKAY
root@g2e:~# pcitest -b 1
BAR1:           NOT OKAY
root@g2e:~# pcitest -b 2
BAR2:           OKAY
root@g2e:~# pcitest -b 3
BAR3:           NOT OKAY
root@g2e:~# pcitest -b 4
BAR4:           OKAY
root@g2e:~# pcitest -b 5
BAR5:           NOT OKAY

Note: BAR test for 1/3/5 fail because they are configured to be 64bits

Interrupt Test
==============
root@g2e:~# pcitest -i 0
SET IRQ TYPE TO LEGACY:         OKAY
root@g2e:~# pcitest -l
LEGACY IRQ:     OKAY

Read Test
=========
root@g2e:~# pcitest -r -s 1
READ (      1 bytes):           OKAY
root@g2e:~# pcitest -r -s 1024
READ (   1024 bytes):           OKAY
root@g2e:~# pcitest -r -s 1025
READ (   1025 bytes):           OKAY
root@g2e:~# pcitest -r -s 1024000
READ (1024000 bytes):           OKAY
root@g2e:~# pcitest -r -s 1024001
READ (1024001 bytes):           OKAY

Write Test
==========
root@g2e:~# pcitest -w -s 1
WRITE (      1 bytes):          OKAY
root@g2e:~# pcitest -w -s 1024
WRITE (   1024 bytes):          OKAY
root@g2e:~# pcitest -w -s 1025
WRITE (   1025 bytes):          OKAY
root@g2e:~# pcitest -w -s 1024000
WRITE (1024000 bytes):          OKAY
root@g2e:~# pcitest -w -s 1024001
WRITE (1024001 bytes):          OKAY

Copy Test
=========
root@g2e:~# pcitest -c -s 1
COPY (      1 bytes):           OKAY
root@g2e:~# pcitest -c -s 1024
COPY (   1024 bytes):           OKAY
root@g2e:~# pcitest -c -s 1025
COPY (   1025 bytes):           OKAY
root@g2e:~# pcitest -c -s 1024000
COPY (1024000 bytes):           OKAY
root@g2e:~# pcitest -c -s 1024001
COPY (1024001 bytes):           OKAY

Lad, Prabhakar (6):
  pci: pcie-rcar: preparation for adding endpoint support
  pci: endpoint: add support to handle features of outbound memory
  of: address: add support to parse PCI outbound-ranges
  dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
    controller
  pci: rcar: add support for rcar pcie controller in endpoint mode
  misc: pci_endpoint_test: add device-id for RZ/G2E pcie controller

 .../devicetree/bindings/pci/rcar-pci-ep.txt        |   37 +
 arch/arm64/configs/defconfig                       |    2 +-
 drivers/misc/pci_endpoint_test.c                   |    3 +
 drivers/of/address.c                               |   44 +-
 drivers/pci/controller/Kconfig                     |   11 +-
 drivers/pci/controller/Makefile                    |    3 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   30 +-
 drivers/pci/controller/pcie-cadence-ep.c           |   11 +-
 drivers/pci/controller/pcie-rcar-ep.c              |  494 ++++++++
 drivers/pci/controller/pcie-rcar-host.c            | 1056 +++++++++++++++++
 drivers/pci/controller/pcie-rcar.c                 | 1229 +-------------------
 drivers/pci/controller/pcie-rcar.h                 |  129 ++
 drivers/pci/controller/pcie-rockchip-ep.c          |   13 +-
 drivers/pci/endpoint/functions/pci-epf-test.c      |   47 +-
 drivers/pci/endpoint/pci-epc-core.c                |    7 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |  216 +++-
 include/linux/of_address.h                         |   21 +
 include/linux/pci-epc.h                            |   72 +-
 18 files changed, 2152 insertions(+), 1273 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.7.4

