Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFC551566C1
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 19:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBHSgv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Feb 2020 13:36:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34140 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgBHSgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Feb 2020 13:36:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so5398303wme.1;
        Sat, 08 Feb 2020 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeKsOFV6oCWMp1G6zbkmxmW95xEaWFUUaBROFZ39rKw=;
        b=nJQzGevq167s/0vY+EdXZ9/SSkS8gcRMyKvXG3w6SuN8E60vurwBhj8T+F6vdM9mbu
         TH9m5dXVD6MK8e1QEpWl9JAhyNnX22Y55A+Shn3g89lXiWqGha16WjedNlsbjljbktc/
         An0NBmhLABkt5ncKHoJ6ZR8fWnCM8oN3eFP+wl0CKodGC5Uv3oa4mAUhHljDmtCp0bIy
         TaDh3GkGiqMaUFNFuA6IBe20fFOlAD4A0LrvfkzqdrXziPUuZUAjF+d3lscPmLrx0MX7
         DDun/v0zgErN5pTib1/xWLZxAH1mD/bFs6jbLQWH4w7JeAyUXmbsn/aeyJQmXAxDro4x
         taRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YeKsOFV6oCWMp1G6zbkmxmW95xEaWFUUaBROFZ39rKw=;
        b=ru7bSM/cTYmQr+jwM/lC/kD/gwOxPAu2qOFsdiMEoOii5HDEiXhUxksV1yfEKcixOX
         vBCjCNnWfm24y8jak6CdFDKrObWhfCdFnCT0idLgK42wyodKfkiYSL8m/l8r0yE4jO5W
         DJq9IXH4WplhNZm38U9wpEL0/LTK1ZDk0JLuLYIrW3GlwIdxqJiKNU1aZKYfg7zVYFIS
         GC19YWhYzuk8ExALRsrRNDixeAcmbCxLwkRYrnTDikd5N4Rrt1DQs0b7jtS3ANn5ySJC
         k6By2TBPsZiwxF2DFTkkHdhjlE1b4hmXmVNF47pzqWTPS5+fnG61BwYRXekFeWwhM4Uo
         nD0g==
X-Gm-Message-State: APjAAAWwSpk3ClsNzSvZSWXPS0sNoxwcGtmOcbPJiSE66gF7uV02OXC6
        g5WWL1pLyCNpYSiEkpx8tnM=
X-Google-Smtp-Source: APXvYqx+EDqd8IWWdWrwvtGi1TTNxyCXcePbuTT3glwCJUSORKLO9Fmn6P/nD85FemfTWKXehaD28g==
X-Received: by 2002:a7b:c19a:: with SMTP id y26mr5644407wmi.152.1581187005690;
        Sat, 08 Feb 2020 10:36:45 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:a553:90a1:93f5:e306])
        by smtp.gmail.com with ESMTPSA id b67sm8404385wmc.38.2020.02.08.10.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2020 10:36:44 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Andrew Murray <andrew.murray@arm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 0/6] Add support for PCIe controller to work in endpoint mode on R-Car SoCs
Date:   Sat,  8 Feb 2020 18:36:35 +0000
Message-Id: <20200208183641.6674-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds support for PCIe controller on rcar to work in
endpoint mode, this also extends the epf framework to handle base region
for mapping PCI address locally..

Note:
The cadence/rockchip/designware endpoint drivers are build tested only.

Changes for v4:
1] Fixed dtb_check error reported by Rob
2] Fixed review comments reported by Kishon
   a] Dropped pci_epc_find_best_fit_window()
   b] Fixed initializing mem ptr in __pci_epc_mem_init()
   c] Dropped map_size from pci_epc_mem_window structure

Changes for v3:
1] Fixed review comments from Bjorn and Kishon.
3] Converted to DT schema

Changes for v2:
1] Fixed review comments from Biju for dt-bindings to include an example
   for a tested platform.
2] Fixed review comments from Kishon to extend the features of outbound
   regions in epf framework.
3] Added support to parse outbound-ranges in OF.

lspci output on host:
=====================

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
                Address: 00000004fa36d000  Data: 0001
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

Lad Prabhakar (6):
  PCI: rcar: Preparation for adding endpoint support
  PCI: rcar: Fix calculating mask for PCIEPAMR register
  PCI: endpoint: Add support to handle multiple base for mapping
    outbound memory
  dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
    controller
  PCI: rcar: Add support for rcar PCIe controller in endpoint mode
  misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller

 .../devicetree/bindings/pci/rcar-pci-ep.yaml       |   76 ++
 arch/arm64/configs/defconfig                       |    2 +-
 drivers/misc/pci_endpoint_test.c                   |    3 +
 drivers/pci/controller/Kconfig                     |   11 +-
 drivers/pci/controller/Makefile                    |    3 +-
 drivers/pci/controller/cadence/pcie-cadence-ep.c   |    7 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   29 +-
 drivers/pci/controller/pcie-rcar-ep.c              |  492 ++++++++
 drivers/pci/controller/pcie-rcar-host.c            | 1044 +++++++++++++++++
 drivers/pci/controller/pcie-rcar.c                 | 1232 +-------------------
 drivers/pci/controller/pcie-rcar.h                 |  132 +++
 drivers/pci/controller/pcie-rockchip-ep.c          |    7 +-
 drivers/pci/endpoint/pci-epc-mem.c                 |  166 ++-
 include/linux/pci-epc.h                            |   39 +-
 14 files changed, 1982 insertions(+), 1261 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.7.4

