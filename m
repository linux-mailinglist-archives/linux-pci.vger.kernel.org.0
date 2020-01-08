Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1681347A5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 17:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgAHQWQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 11:22:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40782 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgAHQWQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jan 2020 11:22:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so4020884wrn.7;
        Wed, 08 Jan 2020 08:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUbkapGV6usokmQ+FjkB5jOvk1qHqcO9wl6AKNn00Nk=;
        b=h8knQN1o2rUkXrs6cmqV6R0pZjpNIqTB7V3oR6JagTvF2BpOTk33TgZQ2VL93ruQ7P
         NNtDsRaibXPh7F02dYHtJ23M3Y3TC1viY/GMDwFXVwsH7Drp2dVaq+ui+IOEhKqEWxww
         RkI1XxZjkJLPRpBc3L41n30oe3o1GEAs4M3Vf0C9LFw4uYItxRTiYzLwTXE8YL6e6lF7
         ejW2UtnyvBVNEuAw3RGFEgpsA20udS2bYVFlzlOWNZ6OhFIWCLIfEayHqXthpZXu3lfl
         ruevaOxPDyQiiiDNRjoGGGj4DGK0ynXBLEITcvzszreVeWlDIGmLWGx9Dl8JZK2FYWcR
         rrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUbkapGV6usokmQ+FjkB5jOvk1qHqcO9wl6AKNn00Nk=;
        b=nkDqtskOAfVkvyShgRwxCXv+owi2GHE//gTa7CCDDPLnruO8InaXQZ4rE1ejbyhclv
         +oV1DM5gjRhppxMKCknUjq/VkoIudrTTrDk+2q42Ef8g4+iqisxt+lZ1twqRgPA7bzzd
         +A5LmZ6LYtK0NYTy6o+gKOq9uMljaOhVWNlnViMiwQPVQJU3nJw5c684ZC5Q2QpHUP19
         hvEt9lkRNVeCvy3UKpWEUQ9ejFs6Y1fsiqsZ3zfbrvDdFJwcXskcEDeHPwOmWOG21Pb1
         A0Wn77qixXvKEwVoFUDTnWp7Pnjdso3pv5FI4l5JZXOpNi3kEIMadWm3/UR85ERDe6uq
         zHHA==
X-Gm-Message-State: APjAAAWYIKLIiegsRceJUZwGVTQfDPc5ru9Tdib8JE/kZvfr+0QBwWC/
        b6hyDtttjtftfwb8MIHT0E0=
X-Google-Smtp-Source: APXvYqwhZnXB7Q+A6al2Q81sPowDetau5NML4GV6kVoXXoSM8NYtMGUCa8Dyubp6uMZAvSBs3Fp6EA==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr5761235wrx.304.1578500533082;
        Wed, 08 Jan 2020 08:22:13 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:2811:8b65:294e:fa09])
        by smtp.gmail.com with ESMTPSA id q3sm5112180wrn.33.2020.01.08.08.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:22:12 -0800 (PST)
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
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [v3 0/6] Add support for PCIe controller to work in endpoint mode on R-Car SoCs
Date:   Wed,  8 Jan 2020 16:22:05 +0000
Message-Id: <20200108162211.22358-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |   76 +
 arch/arm64/configs/defconfig                  |    2 +-
 drivers/misc/pci_endpoint_test.c              |    3 +
 drivers/pci/controller/Kconfig                |   11 +-
 drivers/pci/controller/Makefile               |    3 +-
 .../pci/controller/cadence/pcie-cadence-ep.c  |   12 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   31 +-
 drivers/pci/controller/pcie-rcar-ep.c         |  497 +++++++
 drivers/pci/controller/pcie-rcar-host.c       | 1044 ++++++++++++++
 drivers/pci/controller/pcie-rcar.c            | 1232 +----------------
 drivers/pci/controller/pcie-rcar.h            |  132 ++
 drivers/pci/controller/pcie-rockchip-ep.c     |   14 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   29 +-
 drivers/pci/endpoint/pci-epc-core.c           |    7 +-
 drivers/pci/endpoint/pci-epc-mem.c            |  199 ++-
 include/linux/pci-epc.h                       |   46 +-
 16 files changed, 2064 insertions(+), 1274 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.20.1

