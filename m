Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903076B00F6
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCHIZG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 03:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCHIYr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 03:24:47 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1BC8B1A7C;
        Wed,  8 Mar 2023 00:24:25 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,243,1673881200"; 
   d="scan'208";a="155237822"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Mar 2023 17:24:24 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id A53B84011401;
        Wed,  8 Mar 2023 17:24:24 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com
Cc:     Sergey.Semin@baikalelectronics.ru, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v10 00/12] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Wed,  8 Mar 2023 17:23:40 +0900
Message-Id: <20230308082352.491561-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.

Patch [1/12] and [2/12] are bug fix patches.

Changes from v9:
https://lore.kernel.org/linux-pci/20230210134917.2909314-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230306
 - Add bug fix patches into this patch series.
   https://lore.kernel.org/linux-pci/20230216092012.3256440-1-yoshihiro.shimoda.uh@renesas.com/
   https://lore.kernel.org/linux-pci/20230222015327.3585691-1-yoshihiro.shimoda.uh@renesas.com/
 - Add maximum for max-link-speed and num-lanes to dt-bindings of both host and endpoint.
 - Add max-functions to dt-bindings of endpoint.
 - Use reg-names "app" on endpoint.
 - Remove unnecessary linkup and wait process in rcar_gen4_pcie_host_init().
 - Remove unnecessary macros in pcie-rcar-gen4.h.
 - Use dbi2 to write BAR mask registers.
 - Remove no_msix and intx_by_atu flags.
 - Reduce __dw_pcie_prog_outbound_atu() arguments.
 - Add dw_pcie_num_lanes_setup() to setup num_lanes.
 - Refactor dw_pcie_setup() to avoid PCIE_PORT_LINK_CONTROL writing twice.

Changes from v8:
https://lore.kernel.org/all/20230131095543.1831875-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230210.
 - Missing dt-bindings patches accidentally.

Yoshihiro Shimoda (12):
  PCI: dwc: Fix writing wrong value if snps,enable-cdm-check
  PCI: endpoint: functions/pci-epf-test: Fix dma_chan direction
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: dwc: Refactor PCIE_PORT_LINK_CONTROL handling
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: designware-ep: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Add dw_pcie_num_lanes_setup()
  PCI: dwc: Add support for triggering legacy IRQs
  PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
  PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |  95 ++++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      |  96 ++++++++++
 MAINTAINERS                                   |   1 +
 drivers/pci/controller/dwc/Kconfig            |  18 ++
 drivers/pci/controller/dwc/Makefile           |   4 +
 .../pci/controller/dwc/pcie-designware-ep.c   |  70 +++++++-
 drivers/pci/controller/dwc/pcie-designware.c  | 130 +++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  18 +-
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 170 ++++++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 ++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 156 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  56 ++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   5 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |   2 +-
 include/uapi/linux/pci_regs.h                 |   6 +
 15 files changed, 901 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

