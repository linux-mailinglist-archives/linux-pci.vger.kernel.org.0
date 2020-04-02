Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A48DC19CA1A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388696AbgDBTiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 15:38:54 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:40084 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728452AbgDBTix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2020 15:38:53 -0400
X-IronPort-AV: E=Sophos;i="5.72,336,1580742000"; 
   d="scan'208";a="43341491"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Apr 2020 04:38:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6DFF840C4F75;
        Fri,  3 Apr 2020 04:38:44 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 00/11] Add support for PCIe controller to work in endpoint mode on R-Car SoCs
Date:   Thu,  2 Apr 2020 20:38:28 +0100
Message-Id: <1585856319-4380-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series adds support for PCIe controller on rcar to work in
endpoint mode, this also extends the epf framework to handle base region
for mapping PCI address locally.

Note:
The cadence/rockchip/designware endpoint drivers are build tested only.

root@salvator-x:~# ./pcitest.sh 
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
SET IRQ TYPE TO MSI:            OKAY
MSI1:           OKAY
MSI2:           OKAY
MSI3:           OKAY
MSI4:           OKAY
MSI5:           OKAY
MSI6:           OKAY
MSI7:           OKAY
MSI8:           OKAY
MSI9:           OKAY
MSI10:          OKAY
MSI11:          OKAY
MSI12:          OKAY
MSI13:          OKAY
MSI14:          OKAY
MSI15:          OKAY
MSI16:          OKAY
MSI17:          NOT OKAY
MSI18:          NOT OKAY
MSI19:          NOT OKAY
MSI20:          NOT OKAY
MSI21:          NOT OKAY
MSI22:          NOT OKAY
MSI23:          NOT OKAY
MSI24:          NOT OKAY
MSI25:          NOT OKAY
MSI26:          NOT OKAY
MSI27:          NOT OKAY
MSI28:          NOT OKAY
MSI29:          NOT OKAY
MSI30:          NOT OKAY
MSI31:          NOT OKAY
MSI32:          NOT OKAY


Read Tests

SET IRQ TYPE TO MSI:            OKAY
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


Changes for v6:
1] Rebased patches on endpoint branch of https://git.kernel.org/pub/
   scm/linux/kernel/git/lpieralisi/pci.git/
2] Fixed review comments from Shimoda-san
   a] Made sure defconfig changes were in seprate patch
   b] Created rcar_pcie_host/rcar_pcie_ep structures
   c] Added pci-id for R8A774C0
   d] Added entry in MAINTAINERS for dt-binding
   e] Dropped unnecessary braces
3] Added support for msi.

Changes for v5:
1] Rebased patches on next branch of https://git.kernel.org/pub/scm/
   linux/kernel/git/helgaas/pci.git
2] Fixed review comments reported by Kishon while fetching the matching
   window in function pci_epc_get_matching_window()
3] Fixed review comments reported by Bjorn
   a] Split patch up first patch so that its easier to review and incremental
   b] Fixed typos
4] Included Reviewed tag from Rob for the dt-binding patch
5] Fixed issue reported by Nathan for assigning variable to itself

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

Lad Prabhakar (11):
  PCI: rcar: Rename pcie-rcar.c to pcie-rcar-host.c
  arm64: defconfig: enable CONFIG_PCIE_RCAR_HOST
  PCI: drop PCIE_RCAR config option
  PCI: rcar: Move shareable code to a common file
  PCI: rcar: Fix calculating mask for PCIEPAMR register
  PCI: endpoint: Add support to handle multiple base for mapping
    outbound memory
  dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint
    controller
  PCI: rcar: Add support for rcar PCIe controller in endpoint mode
  PCI: Add Renesas R8A774C0 device ID
  misc: pci_endpoint_test: Add Device ID for RZ/G2E PCIe controller
  MAINTAINERS: Add file patterns for rcar PCI device tree bindings

 .../devicetree/bindings/pci/rcar-pci-ep.yaml  |   76 ++
 MAINTAINERS                                   |    1 +
 arch/arm64/configs/defconfig                  |    2 +-
 drivers/misc/pci_endpoint_test.c              |    2 +
 drivers/pci/controller/Kconfig                |   15 +-
 drivers/pci/controller/Makefile               |    3 +-
 .../pci/controller/cadence/pcie-cadence-ep.c  |    3 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |   16 +-
 drivers/pci/controller/pcie-rcar-ep.c         |  556 ++++++++
 drivers/pci/controller/pcie-rcar-host.c       | 1065 +++++++++++++++
 drivers/pci/controller/pcie-rcar.c            | 1206 +----------------
 drivers/pci/controller/pcie-rcar.h            |  140 ++
 drivers/pci/controller/pcie-rockchip-ep.c     |    2 +-
 drivers/pci/endpoint/pci-epc-mem.c            |  195 ++-
 include/linux/pci-epc.h                       |   39 +-
 include/linux/pci_ids.h                       |    1 +
 16 files changed, 2068 insertions(+), 1254 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
 create mode 100644 drivers/pci/controller/pcie-rcar-ep.c
 create mode 100644 drivers/pci/controller/pcie-rcar-host.c
 create mode 100644 drivers/pci/controller/pcie-rcar.h

-- 
2.20.1

