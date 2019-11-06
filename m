Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDCF1EEA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 20:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKFTga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 14:36:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfKFTga (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 14:36:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so694429wrx.3;
        Wed, 06 Nov 2019 11:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZ6A0u9VmEvIT2gJ+ANYj5GDOWs+Sp/CGhdOzWgLIBw=;
        b=VQOR9XFkF8hzle1zZL3VAmZJDpl3K8c+jey857IVovrFUFF1ZhuV9CjTF2nBrIInwk
         3bVlfw+gMxMQZKPLDq+BDw/OrnpkKBmIG+KSYsb3K72SApeUA/QBwWU9kd9RsivWGXKE
         EpxQQjDrrsXXfqPT+BmeSCale7/ciRoWA4XnzLdz6ypBJQwhv9nNDMKedlU62lTLGae+
         ISK864iEH/Dq413wdgMMChtxCja6Stncx990/jFAag/E8wggtonMTKZLdB0QSPUiuyJp
         kOjwuVnHoziVTs/JT/6hiAf3stbEy02IKu3PgWysPzXGZ2qtvJhLxmrYx8Sr0sjtuPD6
         vthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZ6A0u9VmEvIT2gJ+ANYj5GDOWs+Sp/CGhdOzWgLIBw=;
        b=sMeF8dWrXTozPaZ4ihmNLmkngaNxMYdpci9Q3IVSQbNpZ4P96JtyU4268aJQyU+zG4
         LA78jKuLUgBEifEI8StSehgu03n2nxvv2UudmfqiqKHSnrKUUjCI7e1z5tZ8qdZgpDxj
         FYwZKIaJ677Rp64iJ09YA5JecNOeX2rpABhhJ8CYoaWkEXH0Kc8vZA7u22i9gpsBVLU5
         ktM55qjsvt8nSf/Nq57uVY3/Y9RjM81O9eeKRWE9YiLVi9PuUjto2aKZaO+mlooJjRHM
         6AcoaOwFnjGBh0VtDpWVDHxWkaYsalpc85I3wAOcR/xIHVZKEgoUP1cX4pVAYBLEHRRN
         xPgQ==
X-Gm-Message-State: APjAAAVvT26B5GSbEAFRfSsS3o78ZJw0aaMusB/yZVZd4NmkdNqkiIWe
        VOljOno0Te55Hd4JtM5ehJg=
X-Google-Smtp-Source: APXvYqzsMldJhDxY7pKpPo6NdU98nrC0Z1fU5JfjHX9/FiEN5oWT/O5fr3eymXG+3RoUf4S68C1ACA==
X-Received: by 2002:a5d:4885:: with SMTP id g5mr4588945wrq.287.1573068987422;
        Wed, 06 Nov 2019 11:36:27 -0800 (PST)
Received: from prasmi.home ([2a00:23c6:d18:6d00:1d3d:daa8:4e74:8240])
        by smtp.gmail.com with ESMTPSA id 76sm4311737wma.0.2019.11.06.11.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:36:26 -0800 (PST)
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
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/5] Add support for PCIe controller to work in endpoint mode on R-Car SoCs.
Date:   Wed,  6 Nov 2019 19:36:04 +0000
Message-Id: <20191106193609.19645-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>

This patch series adds support for PCIe controller on rcar to work in endpoint mode,
this also extends the epf framework to handle multiple outbound regions.

Note: 
The cadence/rockchip/designware endpoint drivers are build tested only.

Endpoint configuration:
$ cd /sys/kernel/config/pci_ep
$ mkdir functions/pci_epf_test/func1
$ echo 0x1912 > functions/pci_epf_test/func1/vendorid
$ echo 0x002d > functions/pci_epf_test/func1/deviceid
$ echo 32 > functions/pci_epf_test/func1/msi_interrupts
$ ln -s functions/pci_epf_test/func1/ controllers/fe000000.pcie_ep/
$ echo 1 > controllers/fe000000.pcie_ep/start

Host side results:
lspci output:
01:00.0 Unassigned class [ff00]: Renesas Technology Corp. Device 002d
        Flags: bus master, fast devsel, latency 0, IRQ 103
        Memory at fe200200 (64-bit, non-prefetchable) [size=128]
        Memory at fe200000 (64-bit, non-prefetchable) [size=256]
        Memory at fe200100 (64-bit, non-prefetchable) [size=256]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Virtual Channel
        Kernel driver in use: pci-endpoint-test

pcitest results:

BAR tests

BAR0:           OKAY
BAR1:           NOT OKAY
BAR2:           OKAY
BAR3:           NOT OKAY
BAR4:           OKAY
BAR5:           NOT OKAY

Interrupt tests

SET IRQ TYPE TO LEGACY:         OKAY
LEGACY IRQ:     OKAY
Read Tests

SET IRQ TYPE TO LEGACY:         OKAY
READ (      1 bytes):           OKAY
READ (   1024 bytes):           OKAY
READ (   1025 bytes):           OKAY
READ (1024000 bytes):           OKAY
READ (1024001 bytes):           OKAY

Write Tests

WRITE (      1 bytes):          OKAY
WRITE (   1024 bytes):          OKAY
WRITE (   1025 bytes):          OKAY
WRITE (1024000 bytes):          OKAY
WRITE (1024001 bytes):          OKAY

Copy Tests

COPY (      1 bytes):           OKAY
COPY (   1024 bytes):           OKAY
COPY (   1025 bytes):           OKAY
COPY (1024000 bytes):           OKAY
COPY (1024001 bytes):           OKAY

BAR tests for 1/3/5 fail because its configured to use 64bit bars

Lad, Prabhakar (5):
  pci: pcie-rcar: preparation for adding endpoint support
  pci: endpoint: add support to handle multiple base for mapping
    outbound memory
  PCI: rcar: Add R-Car PCIe endpoint device tree bindings
  pci: rcar: add support for rcar pcie controller in endpoint mode
  misc: pci_endpoint_test: add device-id for RZ/G2 pcie controller

 .../devicetree/bindings/pci/rcar-pci-ep.txt   |   43 +
 arch/arm64/configs/defconfig                  |    2 +-
 arch/arm64/configs/renesas_defconfig          |    2 +-
 drivers/misc/pci_endpoint_test.c              |    3 +
 drivers/pci/controller/Kconfig                |   11 +-
 drivers/pci/controller/Makefile               |    3 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   30 +-
 drivers/pci/controller/pcie-cadence-ep.c      |   11 +-
 drivers/pci/controller/pcie-rcar-ep.c         |  483 +++++++
 drivers/pci/controller/pcie-rcar-host.c       | 1058 ++++++++++++++
 drivers/pci/controller/pcie-rcar.c            | 1231 +----------------
 drivers/pci/controller/pcie-rcar.h            |  129 ++
 drivers/pci/controller/pcie-rockchip-ep.c     |   13 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   29 +-
 drivers/pci/endpoint/pci-epc-core.c           |    7 +-
 drivers/pci/endpoint/pci-epc-mem.c            |  189 ++-
 include/linux/pci-epc.h                       |   43 +-
 17 files changed, 2016 insertions(+), 1271 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.txt
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.20.1

