Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4D6EED23
	for <lists+linux-pci@lfdr.de>; Wed, 26 Apr 2023 06:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239403AbjDZE4L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Apr 2023 00:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239385AbjDZE4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Apr 2023 00:56:10 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED7F6273E;
        Tue, 25 Apr 2023 21:56:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.99,227,1677510000"; 
   d="scan'208";a="157312767"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Apr 2023 13:56:04 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id CF00E4175EC6;
        Wed, 26 Apr 2023 13:56:04 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org
Cc:     marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v14 00/21] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Wed, 26 Apr 2023 13:55:36 +0900
Message-Id: <20230426045557.3613826-1-yoshihiro.shimoda.uh@renesas.com>
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

Changes from v13:
https://lore.kernel.org/linux-pci/20230418122403.3178462-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on next-20230424.
 - (no change, JFYI) Based on the following cleanups patches:
   [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
   https://lore.kernel.org/linux-pci/20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru/
 - Fix typos in the patch 4/22 and 5/22.
 - Reviewed-by or Acked-by from Manivannan in the patch {4,5,10,16,18,21,22}/22.
 - Acked-by from Jesper in the patch 5/22.
 - Acked-by from Rob in the patch 16/22.
 - Merge the patch 8/22 to the 6/22.
 - Change the subject in the patch 9/22.
 - Fix incorrect implementation in the patch 11/22.
 - Fix issues in the patch 12/22.
 - Revise the descriptions in the patch 1[34569]/22.
 - Update copyright in the patch 1[78]/22.
 - Fix examples in the patch 1[78]/22.
 - Fix some minor issues in the patch 22/22.

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

Yoshihiro Shimoda (21):
  PCI: Add PCI_EXP_LNKCAP_MLW macros
  PCI: Add PCI_HEADER_TYPE_MULTI_FUNC
  PCI: Add INTx Mechanism Messages macros
  PCI: Rename PCI_EPC_IRQ_LEGACY to PCI_EPC_IRQ_INTX
  PCI: dwc: Rename "legacy_irq" to "INTx_irq" in DWC core
  PCI: dwc: Change arguments of dw_pcie_prog_ep_outbound_atu()
  PCI: dwc: Add members into struct dw_pcie_outbound_atu
  PCI: dwc: Add support for triggering INTx IRQs from endpoint drivers
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
 .../pci/controller/dwc/pcie-designware-ep.c   | 104 +++++++--
 .../pci/controller/dwc/pcie-designware-plat.c |   4 +-
 drivers/pci/controller/dwc/pcie-designware.c  | 202 +++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  31 ++-
 drivers/pci/controller/dwc/pcie-keembay.c     |   2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |   4 +-
 .../pci/controller/dwc/pcie-rcar-gen4-ep.c    | 166 ++++++++++++++
 .../pci/controller/dwc/pcie-rcar-gen4-host.c  | 141 ++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 187 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  48 +++++
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
 34 files changed, 1071 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

