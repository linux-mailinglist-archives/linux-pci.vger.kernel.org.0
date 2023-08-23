Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B779378541C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 11:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjHWJbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 05:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235580AbjHWJYC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 05:24:02 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A0775B9F;
        Wed, 23 Aug 2023 02:12:02 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,195,1684767600"; 
   d="scan'208";a="173694712"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Aug 2023 18:12:01 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id CC25D4002942;
        Wed, 23 Aug 2023 18:12:01 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, bhelgaas@google.com,
        kishon@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     marek.vasut+renesas@gmail.com, fancer.lancer@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v19 00/19] PCI: rcar-gen4: Add R-Car Gen4 PCIe support
Date:   Wed, 23 Aug 2023 18:11:34 +0900
Message-Id: <20230823091153.2578417-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add R-Car S4-8 (R-Car Gen4) PCIe Host and Endpoint support.
To support them, modify PCIe DesignWare common codes.

Changes from v18:
https://lore.kernel.org/linux-pci/20230721074452.65545-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch and the following patches:
   [PATCH v3 0/2] Cleanup IRQ type definitions
   https://lore.kernel.org/linux-pci/20230802094036.1052472-1-dlemoal@kernel.org/
 - Drop some patches about converting "legacy" to "INTx".
 - Add detailed description in the patch 0[26]/19.
 - Add a new patch "Expose dw_pcie_write_dbi2" in the patch 11/19.
 - Revise typo in the patch 12/19.
 - Fix calling order of deinit in the patch 12/19.
 - Revise Kconfig about kernel module names in the patch 1[67]/19.
 - Rename drivers' file names in the patch 1[67]/19.
 - Some other minor change/fix in the patch 1[67]/19.

Changes from v17:m
https://lore.kernel.org/linux-pci/20230705114206.3585188-1-yoshihiro.shimoda.uh@renesas.com/
 - Based on the latest pci.git / next branch.
 - Add comments ine the commit log in the patch 01/20.
 - Drop "Implicit" from "Message Routing" in the patch 01/20.
 - Add Reviewed-by tag in the patch 0[14569]/20.
 - Fix typo in the patch 07/20.
 - Drop unnecessary description from the commit log in the patch 09/20.
 - Add clk_bulk_disable_unprepare() calling in the patch 1[78]/20.
 - Use .remove_new() in the patch 1[78]/20.
 - Add rcar_gen4_pcie_basic_deinit() and .deinit() in the patch 17/20.
 - Call rcar_gen4_pcie_basic_deinit() in .ep_deinit() in the patch 18/20.
 - Minor updates for improved code readability in the patch 1[78]/20.

Yoshihiro Shimoda (19):
  PCI: Add INTx Mechanism Messages macros
  PCI: dwc: Change arguments of dw_pcie_prog_outbound_atu()
  PCI: dwc: Add outbound MSG TLPs support
  PCI: designware-ep: Add INTx IRQs support
  PCI: dwc: endpoint: Add multiple PFs support for dbi2
  PCI: dwc: Add dw_pcie_link_set_max_link_width()
  PCI: dwc: Add missing PCI_EXP_LNKCAP_MLW handling
  PCI: tegra194: Drop PCI_EXP_LNKSTA_NLW setting
  PCI: dwc: Add EDMA_UNROLL capability flag
  PCI: dwc: Expose dw_pcie_ep_exit() to module
  PCI: dwc: Expose dw_pcie_write_dbi2() to module
  PCI: dwc: endpoint: Introduce .pre_init() and .deinit()
  dt-bindings: PCI: dwc: Update maxItems of reg and reg-names
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Host
  dt-bindings: PCI: renesas: Add R-Car Gen4 PCIe Endpoint
  PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
  PCI: rcar-gen4-ep: Add R-Car Gen4 PCIe Endpoint support
  MAINTAINERS: Update PCI DRIVER FOR RENESAS R-CAR for R-Car Gen4
  misc: pci_endpoint_test: Add Device ID for R-Car S4-8 PCIe controller

 .../bindings/pci/rcar-gen4-pci-ep.yaml        | 106 +++++++++
 .../bindings/pci/rcar-gen4-pci-host.yaml      | 123 +++++++++++
 .../bindings/pci/snps,dw-pcie-ep.yaml         |   4 +-
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 MAINTAINERS                                   |   1 +
 drivers/misc/pci_endpoint_test.c              |   4 +
 drivers/pci/controller/dwc/Kconfig            |  20 ++
 drivers/pci/controller/dwc/Makefile           |   4 +
 .../pci/controller/dwc/pcie-designware-ep.c   | 136 ++++++++++--
 .../pci/controller/dwc/pcie-designware-host.c |  52 +++--
 drivers/pci/controller/dwc/pcie-designware.c  | 156 ++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  29 ++-
 .../controller/dwc/pcie-rcar-gen4-ep-drv.c    | 178 +++++++++++++++
 .../controller/dwc/pcie-rcar-gen4-host-drv.c  | 145 ++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 208 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-rcar-gen4.h   |  44 ++++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   6 -
 drivers/pci/pci.h                             |  18 ++
 18 files changed, 1107 insertions(+), 131 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rcar-gen4-pci-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-ep-drv.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4-host-drv.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.c
 create mode 100644 drivers/pci/controller/dwc/pcie-rcar-gen4.h

-- 
2.25.1

