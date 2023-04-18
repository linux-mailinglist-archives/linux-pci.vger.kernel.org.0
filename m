Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED116E6139
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjDRMYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDRMYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 08:24:36 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7539A9023;
        Tue, 18 Apr 2023 05:24:13 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,207,1677510000"; 
   d="scan'208";a="156404592"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Apr 2023 21:24:12 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C0871423C459;
        Tue, 18 Apr 2023 21:24:12 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v13 00/22] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Tue, 18 Apr 2023 21:23:41 +0900
Message-Id: <20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.

Changes from v12:
https://lore.kernel.org/linux-pci/20230414061622.2930995-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230414
 - (no change, JFYI) Based on the following cleanups patches:
   [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
   https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
 - Use PCI_HEADER_TYPE_MULTI_FUNC on probe.c and quirks.c.
 - Rename "Legacy IRQ" with "INTx".
 - Change order of patches. (INTx related patches at first.)
 - Change maxItems of reg and reg-names on the dt-bindings doc.
 - Fix minor typos.
 - Change waiting period in the INTx function and add comment.

Changes from v11:
https://lore.kernel.org/linux-pci/20230310123510.675685-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230413
 - Based on the following cleanups patches:
   [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
   https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
 - Drop a fixed patch of pci-epf-test because I have submitted it independently.
 - Split patches about adding dw_pcie_link_set_max_* functions.
 - Split patches about modify __dw_pcie_prog_outbound_atu().
 - Add description about num lanes into the commit log.
 - Add some macros into pci_regs.h and pci.h.
 - Add comment about disabling bars in pcie-rcar-gen4-host.c.
 - Set MAX_MSI_IRQS to num_vectors for handling 32 MSIs.
 - Add .ep_deinit().
 - Add retrain link handling of PCIe Host mode for detecting PCIe Gen4.
 - Modify some minor things.

Changes from v10:
https://lore.kernel.org/linux-pci/20230308082352.491561-1-yoshihiro.shimoda.uh@renesas.com/
 - Fix dt-bindings doc for endpoint (reported by Rob's bot).
 - Add reg and reg-names to the dt-bindings doc of host.
 - Fix examples in the dt-bindings docs of both host and endpoint.
 - Add R-Car S4-8 device ID into the pci_test_endpoint driver.

Yoshihiro Shimoda (22):
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
  PCI: Add INTx Mechanism Messages macros
  PCI: Rename PCI_EPC_IRQ_LEGACY with PCI_EPC_IRQ_INTX
  PCI: dwc: Rename with dw_pcie_ep_raise_intx_irq()
  PCI: dwc: Introduce struct dw_pcie_outbound_atu
  PCI: dwc: Add members into struct dw_pcie_outbound_atu
  PCI: dwc: Change arguments of dw_pcie_prog_ep_outbound_atu()
  PCI: dwc: Add support for triggering INTx IRQs
  PCI: dwc: Add dw_pcie_link_set_max_link_width()
  PCI: dwc: Add dw_pcie_link_set_max_width()
  PCI: dwc: Add dw_pcie_link_set_max_cap_width()
  PCI: dwc: Add EDMA_UNROLL capability flag
  PCI: dwc: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Introduce .ep_pre_init() and .ep_deinit()
  dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
  PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
  misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

 .../bindings/pci/rcar-gen4-pci-ep.yaml        |  98 +++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 109 ++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |   4 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 MAINTAINERS                                   |   1 +
 drivers/misc/pci_endpoint_test.c              |   4 +
 .../pci/controller/cadence/pcie-cadence-ep.c  |   2 +-
 drivers/pci/controller/dwc/Kconfig            |  18 ++
 drivers/pci/controller/dwc/Makefile           |   4 +
 drivers/pci/controller/dwc/pci-dra7xx.c       |   2 +-
 drivers/pci/controller/dwc/pci-imx6.c         |   4 +-
 drivers/pci/controller/dwc/pci-keystone.c     |   2 +-
 .../pci/controller/dwc/pci-layerscape-ep.c    |   4 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |   2 +-
 .../pci/controller/dwc/pcie-designware-ep.c   | 103 +++++++--
 .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 201 +++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  31 ++-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +-
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 166 +++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 134 ++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  49 +++++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +-
 drivers/pci/controller/pcie-rcar-ep.c         |   2 +-
 drivers/pci/controller/pcie-rockchip-ep.c     |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  12 +-
 drivers/pci/pci.h                             |  19 ++
 drivers/pci/probe.c                           |   2 +-
 drivers/pci/quirks.c                          |   4 +-
 include/linux/pci-epc.h                       |   4 +-
 include/uapi/linux/pci_regs.h                 |   7 +
 34 files changed, 1063 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

